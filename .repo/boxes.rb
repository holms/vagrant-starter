def boxes
    [
        { :name => 'web',
          :ram => 1024,
          :cpus => 2,
          :ports => [
              [80, 8080]
          ],
          :os => 'centos65',
          :roles => ['base-rhel', 'base', 'web']
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
        { :name => 'ubuntu1304',
          :url => 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box'
        }
    ]
end
