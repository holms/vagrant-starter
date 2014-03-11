def boxes
    [
        { :name => 'web',
          :ports => [
              [80, 8080]
          ],
          :os => 'centos65',
          :roles => ['base', 'web']
        },
    ]
end

def images
    [
        { :name => 'centos65',
          :url => 'https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box'
        },
        { :name => 'debian70',
          :url => 'https://dl.dropboxusercontent.com/s/xymcvez85i29lym/vagrant-debian-wheezy64.box'
        },
        { :name => 'ubuntu1304',
          :url => 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box'
        }
    ]
end
