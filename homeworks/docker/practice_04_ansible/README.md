# Ansible

- [Ansible community documentation](https://docs.ansible.com/)
- [docs index](https://docs.ansible.com/projects/ansible/latest/index.html)

## What exactly is Ansible?

Ansible is an automation engine used for configuration management, application deployment, and task automation.

Think of it as a "remote control" for servers. Instead of logging into 50 different computers to install a piece of software one by one, you write a script (called a Playbook) on your "Master" machine, and Ansible pushes those changes to all the "Slave" machines simultaneously.

Key characteristic: It is agentless. You don't need to install special Ansible software on the servers you want to manage; it usually just needs an SSH connection and Python.

## Practice

```bash
# Create a network
d network create ansible-net

# Create dockerfiles for slave and master

# Build slave and master images
d build -t ansible-slave -f Dockerfile.slave .
d build -t ansible-master -f Dockerfile.master .

# Run the slave and master containers
d run -d --name slave-node --network ansible-net ansible-slave
d run -d --name master-node --network ansible-net ansible-master

# Get slave IP
d network inspect ansible-net
# Containers.Name..Name=slave-node.IPv4Address = 192.168.117.2/24

# Go inside the Master container and create the Inventory file that your instructor mentioned.
# The inventory file is like a phone book for Ansible. It tells it which slaves exist and how to talk to them.
d exec -it master-node bash

# We are now in master container

# Create inventory configuration file
cat <<EOF > hosts
[all_slaves]
192.168.117.2 ansible_user=root ansible_password=password
EOF

# Test via ansible ping
export ANSIBLE_HOST_KEY_CHECKING=False # accept all connections
ansible -i hosts -m ping all
# 192.168.117.2 | SUCCESS => {
#     "ansible_facts": {
#         "discovered_interpreter_python": "/usr/bin/python3"
#     },
#     "changed": false,
#     "ping": "pong"
# }

# Other commands from master to slave
ansible -i hosts -a "df -h" all

# Create a Playbook file
cat <<EOF > welcome_pb.yml
- name: My Playbook
  hosts: all_slaves
  tasks:
    - name: Create a text file on the slave
      copy:
        content: "This file was created by Ansible\n"
        dest: /root/hello.txt
EOF
#Run playbook
ansible-playbook -i hosts welcome_pb.yml
# Verify on the Slave
ansible -i hosts -a "cat /root/hello.txt" all

# ssh to slave (pw=password)
ssh root@192.168.117.2

# Exit master

# Inspect master to get IP: 192.168.117.3
# Note: this doesn't work since Dockerfile.master doesn't install and start ssh
ssh root@192.168.117.3
```
