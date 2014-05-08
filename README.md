Vagrant-starter
==================

Automatization of Vagrant and Chef-solo environment.

Description
-----------

This small kit gives you a nice ability to setup vagrant and chef-solo within one command!
All you need to edit is located at `./repo` directory.

Currently only OSX supported on host, and only centos65 guest in Vagrant. Will fix soon

Requirements
------------

* Install Virtualbox
* Install Vagrant

For Ubuntu
----------

Don't install vagrant from apt-get, download deb package from here https://www.vagrantup.com/downloads.html <br />
We need Vagrant 1.4.x, in ubuntu and even rubygems only 1.0 available

```
deb -i vagrant_1.4.3_x86_64.deb
```

For OSX:
--------

* Install Vagrant with osx installer from https://www.vagrantup.com/downloads.html
* Install Virtualbox with osx installer (macports build out of date, doesn't work in maverics)
* Install bash from Macports/Homebrew


Preparation steps
-----------------

Just launch make-install, it will do everything for you
```
make install
```

When adding new cookbooks to Berksfile, you need to to run make-update
```
make update
```

How to deploy
--------------

`./repo` folder is designed to be your repository.

Just do `git init .` and add git origin with your github/bitbucket repo url

* Edit your repo/boxes.rb, currently only "web" vm added.
* Edit your repo/Berksfile to add cookbooks you'll use
* Edit your repo/roles/ and add those roles to boxes.rb to your vm config.

And finally launch Vagrant:
```
vagrant up web
```

Reload VM

```
vagrant reload web
```

Shutdown VM

```
vagrant halt web
```


Chef management
---------------

Provisioning:

```
vagrant provision web
```

Creating new cookbook

```
make cookbook
```

Berkshelf cookbook update

```
make update
```


Destroy
-------

This will destroy all your `./repo` also as everything that's been generated with `vagrant-starter` repo
```
make destroy
```

