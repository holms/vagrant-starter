def boxes
    [
        { :name => 'web',
          :provider => 'virtualbox',
          :memory => 2048,
          :cpus => 2,
          #:private_ip => '192.168.1.100',
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
        #  :image => 'ubuntu-14-04-x64',
        #  :region => 'ams2',
        #  :token => '',
        #  :ansible => ['playbook/dev.yml']
        #}
    ]
end


def images
    [
        { :name => 'digital_ocean',
          :url => 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
        },
        { :name => 'centos7',
          :url => 'https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box'
        },
        { :name => 'ubuntu1404',
          :url => 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
        },
        { :name => 'debian8',
          :url => 'https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box'
        },
        { :name => 'debian72',
          :url => 'https://www.dropbox.com/s/23gupgb0xompvkm/Wheezy64.box?dl=1'
        },
        { :name => 'ubuntu1404-nochef',
          :url => 'https://github.com/holms/vagrant-starter/releases/download/0.1/Ubuntu-14.04-server-amd64.box'
        }
    ]
end
