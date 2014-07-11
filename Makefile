UNAME := $(shell uname)

ifeq ($(UNAME),Darwin)
	    SHELL := /opt/local/bin/bash
		OSX := 1
else
	    SHELL := /bin/bash
endif

-include .makerc

vagrant := $(shell { type vagrant; } 2>/dev/null)
virtualbox := $(shell { type virtualbox; } 2>/dev/null)

.PHONY: check install install_provision destroy update

ifdef USE_ANSIBLE
install_provision: install_ansible install_repo_ansible
endif

ifndef USE_ANSIBLE
install_provision: install_chefstarter setup_chefstarter install_repo_chef link_repo_chef install_omnibus update
endif

check: check_virtualbox check_vagrant
install: check destroy install_provision finish

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

install_ansible:
	@-echo -e "\n\e[31m\e5 Installing ansible... \n\e[39m"
ifdef OSX
	sudo port -v install ansible
endif
ifndef OSX
	sudo apt-get install ansible
endif

install_omnibus:
	@-echo -e "\n\e[31m\e5 Installing vagrant omnibus plugin... \n\e[39m"
	vagrant plugin install vagrant-omnibus

install_repo_chef:
	@-echo -e "\n\e[31m\e5 Installing your chef repo env... \n\e[39m"
	-mv chef-starter/repo ./repo
	-cp .repo-chef/Berksfile .repo-chef/.makerc .repo-chef/boxes.rb repo/
	-cp .repo-chef/roles/* repo/roles/
	-rm -rf chef-starter/.makerc

install_repo_ansible:
	@-echo -e "\n\e[31m\e5 Installing your ansible repo env... \n\e[39m"
	-cp -R .repo-ansible repo
	-cp .repo-chef/boxes.rb repo/boxes.rb

link_repo_chef:
	-rm -rf chef-starter/repo
	ln -s `pwd`/repo/ `pwd`/chef-starter/repo

update:
	cd chef-starter; make update ; cd ../
	rm -rf repo/cookbooks
	cd repo ; berks vendor cookbooks
	@-echo -e "\n\e[31m\e5 Done! \n\e[39m"


destroy:
	@-echo -e "\n\e[31m\e[5m WARNING! \e[25m\e[31m THIS WILL DESTROY ALL CONFIGURATION, DO YOU REALLY WANT TO PROCESEED???!!111 IF NO - PRESS CTRL+C \e[39m\n"
	@-echo -e "Press enter to confirm: "; read confirm
	-rm -rf .vagrant
	-rm -rf chef-starter
	-rm -rf repo

finish:
	@-echo -e "\n\e[31m\e5 We done! \n\e[39m"

cookbook:
	@-echo "New cookbook name: "; read cookbook_name; \
	echo -e "\n\e[31mCreating cookbook $$cookbook_name in repo/site-cookbooks directory ... \e[39m"; \
	cd repo/site-cookbooks; \
	berks cookbook $$cookbook_name
