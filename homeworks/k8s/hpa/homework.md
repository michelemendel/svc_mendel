# Homework - Horizontal Pod Autoscaler (HPA)

From lesson 2026.05.26
The homework text has been heavily modified to be easier to follow and to fit my k8s setup

1. Apply Deployment
2. Apply Autoscaler
3. Stress test
4. Cleanup

Note regarding metrics-server: It's already installed in my cluster, and configured with --kubelet-insecure-tls

## Apply Deployment

```bash
# Create ns hwhpa and set it as default
k create ns hwhpa
k config set-context --current --namespace hwhpa
# Apply
k apply -f autoscale-hpa.yaml
# Verify
k get all
# Check resource utilization
k top pods
# Output:
# NAME                         CPU(cores)   MEMORY(bytes)
# php-apache-7d5c97c57-2flcl   1m           9Mi
```

## Apply Autoscaler

Target around 10% average CPU, and keep php-apache between 1 and 5 pods

```bash
# Create a HorizontalPodAutoscaler and watch it
k autoscale deployment php-apache --cpu-percent=10 --min=1 --max=5
# Verify
k get hpa
# Output:
# NAME         REFERENCE               TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
# php-apache   Deployment/php-apache   cpu: 2%/10%   1         5         1          44s
```

## Stress test

This is the stress test that we'll run twice with maxReplicas 5 and 10

```bash
# Watch the hpa
k get hpa -w
# In another terminal, start a Linux container and enter the shell
k run -it --rm load-generator --image=busybox:1.28 --restart=Never -- sh
# Run this in the shell
while sleep 0.01; do wget -q -O- http://php-apache; done
```

### Part 1: maxReplicas=5

Run the stress test

Output from hpa watch:

```bash
NAME         REFERENCE               TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   cpu: 2%/10%   1         5         1          102s
php-apache   Deployment/php-apache   cpu: 46%/10%   1         5         1          2m45s
php-apache   Deployment/php-apache   cpu: 402%/10%   1         5         4          3m
php-apache   Deployment/php-apache   cpu: 198%/10%   1         5         5          3m15s
php-apache   Deployment/php-apache   cpu: 126%/10%   1         5         5          3m30s
php-apache   Deployment/php-apache   cpu: 96%/10%    1         5         5          3m45s
...
```

- What e.g. `cpu: 96%/10%` means:
  - 96%: Pods are using 96% of their requested CPU (48m of 50m) on average
  - 10%: What the HPA is configured to use
- We also see that replicas scale up from 1 to 4 to 5 as CPU crosses 10%. Running `k get pods` we see 5 pods

### Part 2: maxReplicas=10

```bash
# Check replica count
# Important: Wait few minutes and it will go back to min pods
# Set maxReplicas to 10
k edit hpa php-apache
```

Run the stress test again

Output from hpa watch:

```bash
NAME         REFERENCE               TARGETS        MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   cpu: 78%/10%   1         10        5          18m
php-apache   Deployment/php-apache   cpu: 22%/10%   1         10        5          18m
php-apache   Deployment/php-apache   cpu: 50%/10%   1         10        10         19m
php-apache   Deployment/php-apache   cpu: 59%/10%   1         10        10         19m
php-apache   Deployment/php-apache   cpu: 53%/10%   1         10        10         19m
...
```

- So here see that we are using 10 pods, and that targets has a lower CPU usage.
- Then we stop the stress test

```bash
...
php-apache   Deployment/php-apache   cpu: 2%/10%    1         10        10         27m
php-apache   Deployment/php-apache   cpu: 2%/10%    1         10        2          27m
...
php-apache   Deployment/php-apache   cpu: 2%/10%   1         10        1          32m
...
```

Here we see that HPA has scaled down the number of replicas.

## Cleanup

```bash
# Reset ns to default
k config set-context --current --namespace default
# Delete the hwhpa ns and verify that it's gone
k delete ns hwhpa
k get ns hwhpa
# Output:
# Error from server (NotFound): namespaces "hwhpa" not found
k get hpa -n hwhpa
# Output:
# No resources found in hwhpa namespace.
```
