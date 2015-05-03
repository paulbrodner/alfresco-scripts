module Deploy_selenium_rc
  include DevOn

  # Unix Deploy
  Command.kill_program "selenium-node"
  Command.kill_program "selenium-hub"
  Command.kill_program "selenium-server"

  Command.run_shell("sudo mkdir #{$config.location.unix}")
  Command.run_shell("sudo chmod -R 777 #{$config.location.unix}")
  Command.run_shell("chown nobody:nogroup -R  #{$config.location.unix}")

  # download selenium
  Command.run_shell("cd #{$config.location.unix} && wget #{$config.url.selenium_jar}")

  file = File.join($config.location.unix, "selenium-hub.sh")
  Command.upload_file(use_file($config, "selenium-hub.sh.erb"), file)
  Command.run_shell("chmod +x #{file}")

  file = File.join($config.location.unix, "selenium-node.sh")
  Command.upload_file(use_file($config, "selenium-node.sh.erb"), file)
  Command.run_shell("chmod +x #{file}")

  ##start the hub
  #Command.run_shell("cd  #{$config.location.unix} && ./#{File.basename(file)} &")
  ##start the node
  #Command.run_shell("cd  #{$config.location.unix} && ./#{File.basename(file)} &")

  provision_on $config
end
  