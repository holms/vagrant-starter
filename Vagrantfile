# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

load 'repo/boxes.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # vagrant-berkshelf hijacks cookbooks_path
  #config.berkshelf.enabled = false

  # vagrant multi-vm configuration
  boxes.each do |opts|
    # per node configuration
    config.vm.define opts[:name] do |node|
        node.ssh.forward_agent = true
        node.ssh.insert_key = false
        #node.ssh.private_key_path = '~/.ssh/id_rsa'

        # vagrant base boxes
        images.each do |img|
            if (img[:name] == opts[:os])
               node.vm.box = img[:name]
               node.vm.box_url = img[:url]
            end
        end

        # VirtualBox provider
        node.vm.provider "virtualbox" do |v|
            if opts[:provider] == 'virtualbox'
                v.memory = opts[:memory]
                v.cpus = opts[:cpus]

                # Ansible requires few additional parameters in order to work with virtualbox
                node.vm.provision "ansible" do |ansible|
                    opts[:ansible].each do |playbook|
                        ansible.playbook = "repo/#{playbook}"
                    end
                    ansible.sudo = true
                    ansible.host_key_checking = false
                    ansible.verbose =  'vvvv'
                    ansible.raw_ssh_args = ['-o UserKnownHostsFile=/dev/null']
                    ansible.extra_vars = {
                       ansible_ssh_user: 'vagrant',
                       ansible_connection: 'ssh',
                       ansible_ssh_args: '-o ForwardAgent=yes -A'
                     }
                end

                # port forwarding
                opts[:ports].each do |port|
                    node.vm.network "forwarded_port", guest: port[0], host: port[1]
                end
            end
        end

        # DigitalOcean provider
        node.vm.provider "digital_ocean" do |v|
            if opts[:provider] == 'digital_ocean'
                node.vm.box = 'digital_ocean'
                node.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
                v.hostname = opts[:name]
                v.token = opts[:token]
                v.image = opts[:image]
                v.region = opts[:region]
                v.size = opts[:size]
            end
        end


        # check if chef being used
        unless opts[:chef].nil?

            # Installs chef-client/chef-solo
            config.omnibus.chef_version = :latest

            # chef-solo configuration
            node.vm.provision :chef_solo do |chef|

                # custom chef-solo paths
                chef.cookbooks_path = ["repo/cookbooks", "repo/site-cookbooks"]
                chef.roles_path = "repo/roles"
                chef.data_bags_path = "repo/data_bags"

                opts[:chef].each do |role|
                    chef.add_role("#{role}")
                end

                # stop chef-solo from breaking the box
                chef.json = {
                    "authorization" => {
                        "sudo" => {
                            "users" => [ "vagrant" ],
                            "passwordless" => true,
                            "sudoers_defaults" => ['!requiretty'],
                        }
                    }
                }

            end
        end

        # check if ansible being used
        unless opts[:ansible].nil?
            node.vm.provision "ansible" do |ansible|
                opts[:ansible].each do |playbook|
                    ansible.playbook = "repo/#{playbook}"
                end
            end
        end

        # check if saltstack being used
        unless opts[:salt].nil?

            config.vm.synced_folder "repo/salt/", "/srv/salt/"

            node.vm.provision "salt" do |salt|
                salt.minion_config = "repo/minion"
                salt.run_highstate = true
                salt.colorize = true
                salt.log_level = 'info'
                salt.verbose = true
                #opts[:salt].each do |minion|
                #end
            end
        end
    end
  end
end
