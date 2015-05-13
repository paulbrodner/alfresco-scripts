#
# Connection example script
#
module Install
  include DevOn

  #from alf01
  Command.run_shell("tar -xzf #{$config.backup.b402.contentstore.source} -C #{$config.backup.b402.contentstore.destination}/data")
  Command.run_shell("tar -xzf #{$config.backup.b402.mysql.source} -C #{$config.backup.b402.mysql.destination}")

  provision_on $config
end

