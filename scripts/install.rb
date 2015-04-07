module Install
  include DevOn
  # use gloabl variable of the current connection selected
  # $connection.settings
  # or of the current configuration
  # $config.name
  # require File.expand_path 'configs/simple'
  # Command.run_shell_file("install/test.sh")
  Command.run_shell($config.shell)
  # Command.run_shell("rm -rf /tmp/fromFile")
  # Command.run_shell("ls -la /tmp")
  # Command.upload_file("<source>/example.erb.rb", "/home/vagrant/test.rb")
  #
  # and provision the machine with:
  #puts $connection.settings.inspect
  #puts $config.inspect
  provision_on $config
end
