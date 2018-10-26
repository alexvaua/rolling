## Zero downtime deployment (rolling) in test environment by Ansible.

On the hosts node we need to install Vagrant and VirtualBox as a HV.

We are going to provision instances according the list:

1. Loand Ballanser based on Haproxy (lb)
1. Webservers based on nginx (web1-3)
1. Ansible Management node (man)

*System requirements:*
Linux "Ubuntu 16.04", 1CPU, 1.5GB RAM, 8-9GB free space in /home

How to install on Ubuntu 16.04:
### Instalation and deploy env on host machine
```
sudo apt install vagrant virtualbox git -y;
git clone https://github.com/alexvaua/rolling.git ~/;
cd ~/rolling
```
### Optionally
Here do we have main configs:
- `examples/inventory.ini` - The inventory file where we describe hosts that are need to manage by Ansible.
- `examples/rolling.yml` - The playbook that we use for configuring and perform the deploy(rolling) without downtime.

### Commands for env preparation
```
# deploying the env according by Vagrant 
sudo vagrant up
# connect to `man` for management
vagrant ssh man
ansible-playbook env-role.yml
# exit from `man`
exit
```

### Testing
After successful installation and provisioning we can be able to see test page by this address:
(http://localhost:8080)
The statistic(Haproxy) of routing and balancing we should see by this address:
(http://localhost:8080/haproxy?stats)

### Repositories
- https://github.com/alexvaua/rolling - Main repository that contains of dployment files.
- https://github.com/alexvaua/site - Repository that contains site that we used as example.

### Deployment
Deployment based on "release" or any branch, that should be prepared in the site repo.
After that we be able to run command below(that step can be automated):

### Commands for rolling deployment from `man` server
```
# connect to `man` for management
vagrant ssh man
# run playbook rolling for deploing
ansible-playbook rolling.yml
# exit from `man`
exit
```

### Finish
*Files* 
- `bootstrap.sh` - Install/Config Ansible and Deploy env
- `examples` - Ansible configs and roles
- `README` - The file that you read
- `Vagrantfile` - Defines environment by Vagrant

```
# Cleaning
vagrant halt -f;
cd ..;
rm -rf rolling;
sudo apt purge vagrant virtualbox git -y
```

