#
# Connection example script
#
module Install
  include DevOn

  #from db01
  Command.run_shell "mysql -u #{$config.db.username} -p#{$config.db.password} #{$config.db.name} < #{$config.backup.b402.mysql.destination}"
  provision_on $config
end

