-include .makerc
UNAME := $(shell uname)

ifeq ($(UNAME),Darwin)
	    SHELL := /opt/local/bin/bash
else
	    SHELL := /bin/bash
endif

vagrant := $(shell { type vagrant; } 2>/dev/null)
virtualbox := $(shell { type virtualbox; } 2>/dev/null)

.PHONY: check install destroy
check: check_virtualbox check_vagrant
install: destroy install_chefstarter install_omnibus install_chefrepo finish

check_virtualbox:
	@-echo -e "\n\e[31m\e5 Checking if Virtualbox installed... \c"
ifdef virtualbox
	@-echo -e "YES\e[39m"
else
	@-echo -e "NO!\n\n\e[5m Please install Virtualbox \e[25m\e[39m\n"
endif

check_vagrant:
	@-echo -e "\e[31m\e5 Checking if Vagrant installed... \c"
ifdef vagrant
	@-echo -e "YES\e[39m"
else
	@-echo -e "NO!\n\n\e[5m Please install Vagrant \e[25m\e[39m\n"
endif

install_chefstarter:
	@-echo -e "\n\e[31m\e5 Clone chef-starter submodule... \n\e[39m"
	git submodule update --init
	@-echo -e "\n\e[31m\e5 Launching chef-solor installer... \n\e[39m"
	cd chef-starter; make install_solo
	cd ../

install_omnibus:
	@-echo -e "\n\e[31m\e5 Installing vagrant omnibus plugin... \n\e[39m"
	vagrant plugin install vagrant-omnibus

install_chefrepo:
	@-echo -e "\n\e[31m\e5 Installing chef-repo env... \n\e[39m"
	-mv chef-starter/roles/my.cool.role.json.sample chef-repo/roles/
	-rm -rf chef-starter/roles
	-ln -s chef-repo/roles chef-starter/roles
	-rm -rf chef-starter/Berksfile
	-ln -s chef-repo/Berksfile chef-starter/Berksfile
	-ln -s chef-repo/.makerc chef-starter/.makerc

destroy:
	@-echo -e "\n\e[31m\e[5m WARNING! \e[25m\e[31m THIS WILL DESTROY ALL CONFIGURATION, DO YOU REALLY WANT TO PROCESEED???!!111 IF NO - PRESS CTRL+C \e[39m\n"
	@-echo -e "Press enter to confirm: "; read confirm
	-rm -rf .vagrant
	-rm -rf chef-starter
	-rm -rf chef-repo/roles/my.cool.role.json.sample

finish:
	@-echo -e "\n\e[31m\e5 We done! \n\e[39m"
