# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

boxes = [
{ :name => :web, :ports => [ [80, 8080] ],  :roles => ['base', 'web'] },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Configure base box
  config.vm.box = "centos65"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  # vagrant-berkshelf hijacks cookbooks_path
  #config.berkshelf.enabled = false

  # Installs chef-client/chef-solo
  config.omnibus.chef_version = :latest

  # vagrant multi-vm configuration
  boxes.each do |opts|
    # per node configuration
    config.vm.define opts[:name] do |node|

        node.vm.hostname = "%s.vagrant" % opts[:name].to_s

        # port forwarding
        opts[:ports].each do |port|
            node.vm.network "forwarded_port", guest: port[0], host: port[1]
        end

        # chef-solo configuration
        node.vm.provision :chef_solo do |chef|

            # custom chef-solo paths
            chef.cookbooks_path = ["chef-starter/cookbooks", "chef-starter/site-cookbooks"]
            chef.roles_path = "chef-starter/roles"
            chef.data_bags_path = "chef-starter/data_bags"

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
