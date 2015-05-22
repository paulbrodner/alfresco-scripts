module Test
  include DevOn

  Config.on "test" do
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

