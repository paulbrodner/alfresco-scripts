module Vagrant
  include DevOn

  Config.on "vagrant" do
    connection do
      hostname "127.0.0.1"
      username "vagrant"
      port 2222
      # run vagrant ssh-config to find the path of key_data
      key_data "configs/vagrant/.vagrant/machines/default/virtualbox/private_key"
    end

    tmp "/tmp"
  end
end
