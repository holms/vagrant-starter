def boxes
    [
        { :name => 'web',
          :memory => 1024,
          :cpus => 2,
          :ports => [
              [80, 8080]
          ],
          :os => 'ubuntu1404',
          #:chef => ['base-deb', 'base', 'web']
          #:ansible => ['']
        },
    ]
end

def images
    [
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
