module Vagrant
  include DevOn

  Config.on "vagrant" do
    settings do
      hostname "127.0.0.1"
      username Env.user
      port Env.port
      # run vagrant ssh-config to find the path of key_data
      key_data "connections/vagrant/.vagrant/machines/default/virtualbox/private_key"
    end
    
    tomcat do
      jvmRoute "at4"
    end

    tcp do
      host Config.vagrant.settings.hostname
    end
    tmp "/tmp"
  end
end
