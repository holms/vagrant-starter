Chef-Starter
============

This is PRE-ALPHA! For testing only!
Please fork and help a project, if you can do better makefile scripting, or found something to fix.

Use-case
--------

Primary use-case I had, is to deploy chef-server from my own workstation with minimal fuss.
Also this prolly would be good for initialising new chef repo and setuping workstation too.

Requirements
------------

* This setup requires a proper FQDN. If you're in intranet, set one in /etc/hosts
* You required to have public key in your ~/.ssh/ directory. It will be copied to a chef-server node.
* SUDO enabled linux. Notice: For cloud users: Don't forget to comment ```#Default requiretty``` or else Makefile will fail
* Your sudo user must be the same on all the nodes as server machine (propose for better practise in issue)

OSX support:
------------
    * Install macports
    * Install bash via macports

Configure
---------

Create .makerc
```
cp .makerc.sample .makerc
```
Set your chef-server hostname and username, repo path, and you ready to go.


This will setup chef-server and workstation
```
make install
```

This will only install chef-solo
```
make install_solo
```

Usage
-----


Run updates: get cookbooks, upload all cookbooks, update envs/roles/nodes
```
make # or make update
```

Create and bootstrap a node
```
make node
```



Rebootstrap node
```
make rebootstrap
```

Cook specified node, you will be asked to enter node name, and node list will be shown
```
make cook
```


Destroy everything that's been generated
```
make destroy
```

Remove chef installation on server (BUG: doesn't work with RHEL)
```
make server_destroy
```

Check other available commands inside Makefile or just ```make help```

BUG: Knife-configure problems
-----------------------------

Update: not sure about this method anymore. When I set all the paths, using ```knife bootstrap```, it stops seeing
        his keys, and chef-client crashses. So don't perform this step if you want to have working knife after server 
        installation

If you want to use knife-solo together with knife, you need to append knife-solo generated config to knife.rb
There's a problem with .chef/knife.rb after knife configure -i. Knife by default thinks that everything in */var/chef*
So if you'll decided to use knife-solo after ```make install``` will finish, it will crash, saying there's no roles in */var/chef/role*s.

Add this stuff to .chef/knife.rb manually

```
cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"

```
TODO: Find how to force knife configure append configuration, instead of overwriting it.



