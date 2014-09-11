def boxes
    [
        { :name => 'web',
          :provider => 'virtualbox',
          :memory => 2048,
          :cpus => 2,
          :ports => [
              [80, 8080],
          ],
          :os => 'ubuntu1404',
          #:chef => ['base-deb', 'base', 'web']
          #:ansible => ['playbook/dev.yml']
          #:salt => 1
        },
        #{ :name => 'web-do',
        #  :provider => 'digital_ocean',
        #  :os => 'digital_ocean',
        #  :size => '2GB',
        #  :image => 'Ubuntu 14.04 x64',
        #  :region => 'ams2',
        #  :token => '',
        #  :ansible => ['shrinktheapp-api/dev.yml']
        #}
    ]
end


def images
    [
        { :name => 'digital_ocean',
          :url => 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
        },
        { :name => 'centos65',
          :url => 'https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box'
        },
        { :name => 'debian72',
          :url => 'https://www.dropbox.com/s/23gupgb0xompvkm/Wheezy64.box?dl=1'
        },
        { :name => 'debian80',
          :url => 'https://downloads.sourceforge.net/project/vagrantboxjessie/debian80.box'
        },
        { :name => 'ubuntu1304',
          :url => 'http://dl.dropbox.com/u/1537815/precise64.box'
        },
        { :name => 'ubuntu1404',
          :url => 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box'
        }
    ]
end
