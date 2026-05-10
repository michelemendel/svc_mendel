# Homework: Ansible

[Python flask playbook](https://github.com/dinghy-group/svc/tree/main/ansible/homework)

From the link:

- Execute and Test playbook-flask.yml based on the app.py
  - Create an app.py
  - Create an ansible playbook
  - Run the flask playbook
  - Test via browser

## Steps to solve the exercise

Note: Dockerfile.master and Dockerfile.slave already exist

```bash
# Create ansible_key pair
ssh-keygen -t rsa -f ./ansible_key
chmod 600 ansible_key

# Create a network to use DNS and not IP
d network create ansible-net

# Build slave and master images
d build --no-cache -t ansible-slave -f Dockerfile.slave .
d build --no-cache -t ansible-master -f Dockerfile.master .

# Run the slave
d run -d --rm --name slave-node -p 5015:5015 --network ansible-net ansible-slave

# Run the master container (from this folder)
d run -d --rm --name master-node --network ansible-net \
-v "$(pwd)/ansible_key":/root/.ssh/id_rsa:ro \
-v "$(pwd)":/app:ro \
ansible-master

# Enter master node
# Note that we will be in the /app folder
d exec -it master-node bash

# ------------------------------
# We are now in the master node
# ------------------------------

# Since we use ansible.cfg we don't need to run this line
# export ANSIBLE_HOST_KEY_CHECKING=False

# quick sanity check
ansible -i inventory.yml -m ping all

# Run playbook
ansible-playbook -i inventory.yml playbook.yml

# Check that the server runs on slave

## Option 1: from inside master, hit the slave by DNS name
curl http://slave-node:5015/

## Option 2: from your host browser
# http://localhost:5015/

```
