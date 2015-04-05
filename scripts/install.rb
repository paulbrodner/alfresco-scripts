module Install
  include DevOn
  require File.expand_path("configs/#{ENV['config']}")
  config = DevOn::Config.send(ENV['config'])
  Command.run_shell(config, "ls -la /vagrant")

  provision_on config
end
