module Install
  include DevOn
  require File.expand_path("configs/#{ENV['config']}")
  config = DevOn::Config.send(ENV['config'])
     
  Command.run_shell(config, "cd /vagrant/ && chmod +x alfresco-community-5.0.d-installer-linux-x64.bin")

  provision_on config
end
