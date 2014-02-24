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

How to deploy
--------------

`./repo` folder is designed to be your repository.

Just do `git init .` and add git origin with your github/bitbucket repo url

* Edit your repo/boxes.rb, currently only "web" vm added.
* Edit your repo/Berksfile to add cookbooks you'll use
* Edit your repo/roles/ and add those roles to boxes.rb to your vm config.

And finally launch Vagrant:
```
vagrant up
```

Destroy
-------

This will destroy all your `./repo` also as everything that's been generated with `vagrant-starter` repo
```
make destroy
```



