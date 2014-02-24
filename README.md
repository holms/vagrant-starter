Vagrant-starter
==================

Automatization of Vagrant and Chef-solo environment.

Description
-----------

This small kit gives you a nice ability to setup vagrant and chef-solo within one command!
All chef `roles` and `Berksfile` located in `./chef-repo` directory.

Requirements
------------

* Install Virtualbox
* Install Vagrant

On Osx

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
