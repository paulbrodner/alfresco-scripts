module Win
  include DevOn

  Config.on "win" do
    os OS_WIN

    settings do
      hostname "127.0.0.1"
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end
  end
end
