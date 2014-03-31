# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

load 'repo/boxes.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # vagrant-berkshelf hijacks cookbooks_path
  #config.berkshelf.enabled = false

  # Installs chef-client/chef-solo
  config.omnibus.chef_version = :latest

  # vagrant multi-vm configuration
  boxes.each do |opts|
    # per node configuration
    config.vm.define opts[:name] do |node|

        node.vm.hostname = "%s.vagrant" % opts[:name]

        # vagrant base boxes
        images.each do |img|
            if (img[:name] == opts[:os])
                node.vm.box = img[:name]
                node.vm.box_url = img[:url]
            end
        end

        # port forwarding
        opts[:ports].each do |port|
            node.vm.network "forwarded_port", guest: port[0], host: port[1]
        end

        # chef-solo configuration
        node.vm.provision :chef_solo do |chef|

            # custom chef-solo paths
            chef.cookbooks_path = ["repo/cookbooks", "repo/site-cookbooks"]
            chef.roles_path = "repo/roles"
            chef.data_bags_path = "repo/data_bags"

            opts[:roles].each do |role|
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
  end
end
