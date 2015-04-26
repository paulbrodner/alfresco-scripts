module BmSl01
  include DevOn

  Config.on "bm_sl01" do
    os OS_UNIX

    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end

    tmp "/tmp"
  end
end

