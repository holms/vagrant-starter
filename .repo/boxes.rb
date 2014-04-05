def boxes
    [
        { :name => 'web',
          :memory => 1024,
          :cpus => 2,
          :ports => [
              [80, 8080]
          ],
          :os => 'debian80',
          :roles => ['base-deb', 'base', 'web']
        },
    ]
end

def images
    [
        { :name => 'vagrant-jessie',
          :url => 'file:///Users/Holms/jessie.box'
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
          :url => 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box'
        }
    ]
end
