UNAME := $(shell uname)

ifeq ($(UNAME),Darwin)
	    SHELL := /opt/local/bin/bash
else
	    SHELL := /bin/bash
endif

vagrant := $(shell { type vagrant; } 2>/dev/null)
virtualbox := $(shell { type virtualbox; } 2>/dev/null)

.PHONY: check install destroy update
check: check_virtualbox check_vagrant
install: check destroy install_chefstarter install_repo setup_chefstarter link_repo install_omnibus update finish

check_virtualbox:
	@-echo -e "\n\e[31m\e5 Checking if Virtualbox installed... \c"
ifdef virtualbox
	@-echo -e "YES\e[39m"
else
	@-echo -e "NO!\n\n\e[5m Please install Virtualbox \e[25m\e[39m\n\n"
	@-echo -e " For ubuntu use this: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_i686.deb \n\n"
	@exit 1
endif

check_vagrant:
	@-echo -e "\e[31m\e5 Checking if Vagrant installed... \c"
ifdef vagrant
	@-echo -e "YES\e[39m"
else
	@-echo -e "NO!\n\n\e[5m Please install Vagrant \e[25m\e[39m\n\n"
	@exit 1
endif

install_chefstarter:
	@-echo -e "\n\e[31m\e5 Clone chef-starter subtree... \n\e[39m"
	git clone https://github.com/holms/chef-starter

setup_chefstarter:
	@-echo -e "\n\e[31m\e5 Launching chef-solo installer... \n\e[39m"
	cd chef-starter && make install_solo

install_omnibus:
	@-echo -e "\n\e[31m\e5 Installing vagrant omnibus plugin... \n\e[39m"
	vagrant plugin install vagrant-omnibus

install_repo:
	@-echo -e "\n\e[31m\e5 Installing your repo env... \n\e[39m"
	-mkdir -p repo/roles repo/site-cookbooks repo/data_bags
	-cp chef-starter/.roles/my.cool.role.json.sample repo/roles/
	-cp .repo/Berksfile .repo/.makerc .repo/boxes.rb repo/
	-cp .repo/roles/* repo/roles/
	-rm -rf chef-starter/Berksfile
	-rm -rf chef-starter/.makerc
	-ln -s `pwd`/repo/Berksfile `pwd`/chef-starter/Berksfile
	-ln -s `pwd`/repo/.makerc 	`pwd`/chef-starter/.makerc

link_repo:
	-rm -rf chef-starter/roles
	-rm -rf chef-starter/site-cookbooks
	-rm -rf chef-starter/data_bags
	-ln -s `pwd`/repo/data_bags `pwd`/chef-starter/data_bags
	-ln -s `pwd`/repo/roles     `pwd`/chef-starter/roles
	-ln -s `pwd`/repo/site-cookbooks `pwd`/chef-starter/site-cookbooks

update:
	cd chef-starter; make update ; cd ../

destroy:
	@-echo -e "\n\e[31m\e[5m WARNING! \e[25m\e[31m THIS WILL DESTROY ALL CONFIGURATION, DO YOU REALLY WANT TO PROCESEED???!!111 IF NO - PRESS CTRL+C \e[39m\n"
	@-echo -e "Press enter to confirm: "; read confirm
	-rm -rf .vagrant
	-rm -rf chef-starter
	-rm -rf repo

finish:
	@-echo -e "\n\e[31m\e5 We done! \n\e[39m"
