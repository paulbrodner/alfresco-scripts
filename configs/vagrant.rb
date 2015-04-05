module Vagrant
  include DevOn

  Config.on "vagrant" do
    connection do
      hostname "127.0.0.1"
      username "vagrant"
      port 2222
      key_data "configs/vagrant/private_key"
    end

    tmp "/tmp"
  end
end
