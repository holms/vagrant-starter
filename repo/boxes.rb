def boxes
    [
        { :name => :web,
          :ports => [
              [80, 8080]
          ],
          :roles => ['base', 'web']
        },
    ]
end
