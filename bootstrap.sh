#!/usr/bin/env bash

# install ansible
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# copy files into /home/vagrant
cp -a /vagrant/examples/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# deploy environment
#cd /home/vagrant; /usr/bin/ansible all -m ping; /usr/bin/ansible-playbook env-role.yml
