# Vagrant-starter

Automatization of Vagrant and Chef-solo environment.

## Description

This small kit gives you a nice ability to setup vagrant and chef-solo within one command!
All you need to edit is located at `./repo` directory.

Currently only OSX supported on host, and only centos65 guest in Vagrant. Will fix soon

## Requirements

* Install Virtualbox
* Install Vagrant

## Installation

### For Ubuntu

Don't install vagrant from apt-get, download deb package from here https://www.vagrantup.com/downloads.html <br />
We need Vagrant 1.4.x, in ubuntu and even rubygems only 1.0 available

```
deb -i vagrant_1.4.3_x86_64.deb
```

### For OSX

* Install Vagrant with osx installer from https://www.vagrantup.com/downloads.html
* Install Virtualbox with osx installer (macports build out of date, doesn't work in maverics)
* Install bash from Macports/Homebrew


## Bugs


Currently there's a bug which can be workarounded, although it's a bit annoying.

* To use digital ocean provider, you need to have this line in your Vagrantfile `node.ssh.private_key_path = '~/.ssh/id_rsa'` which is currently commented out. It's commented out because you local vm provisiong will fail. Currently I'm in search how to fix this. You'll have to comment in and out this line when you want to use local vm's instead of digital ocean and vice-versa

## Preparation steps

Just launch make-install, it will do everything for you

```
make install
```


## Local usage

`./repo` folder is designed to be your repository.

Just do `git init .` and add git origin with your github/bitbucket repo url

* Edit your repo/boxes.rb, currently only "web" vm added.
* Edit your repo/Berksfile to add cookbooks you'll use
* Edit your repo/roles/ and add those roles to boxes.rb to your vm config.

### Create VM

```
vagrant up web
```

### Reload VM

```
vagrant reload web
```

### Shutdown VM

```
vagrant halt web
```
### Delete VM

```
vagrant destroy web
```
---------------
## Provisioning

### Ansible management

Edit ```.makerc``` and uncomment ```USE_ANSIBLE=1``` variable. By default it's commented out.

Create a playbook directory in ```repo/myplaybook/main.yml```, add this playbook path to your ```repo/boxes.rb``` vm configuration

#### Provisioning

```
vagrant provision web
```
### Saltstack management

Edit `.makerc` and uncomment `USE_SALT=1` variable.
In `repo/boxes.rb` you need to add `:salt=>1` to enable salt.
Currently only one minion supported.

#### Provisioning

```
vagrant provision web
```


### Chef management

#### Provisioning

```
vagrant provision web
```

#### Creating new cookbook

```
make cookbook
```

#### Berkshelf cookbook update

```
make update
```
## Destroy

This will destroy all your `./repo` also as everything that's been generated with `vagrant-starter` repo
```
make destroy
```

## Provisioning to DigitalOcean

### Pre-configuration

* You need to have private ssh key here: `~/.ssh/id_rsa`
* You need to add api key for each droplet in `repo/boxes.rb`

### Creating new droplet

In `repo/boxes.rb` you'll find commented out configuration template for digital ocean droplet. Here's how to create it

```
vagrant up myserver.mydomain.com --provider=digital_ocean
```

### Acknowledge existing droplet

If you have existing droplet on Digital Ocean, you can tell vagrant to manage it. First of all don't forget to add droplet configuration to `repo/boxes.rb`. Then you need to perform some actions:

```
vagrant up myserver.mydomain.com --provider=digital_ocean
```

### Troubles

* In case you have troubles with ssl, you need curl ssl certificates to be installed.
* If you have troubles with ssh and ansible, check if you don't have user root set in your playbook
