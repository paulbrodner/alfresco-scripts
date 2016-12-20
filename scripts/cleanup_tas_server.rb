
module Cleanup_tas_server
  include DevOn
  
  ## 1)
  ## stop alfresco  
  Command.kill_program "tomcat"  

  ## 2) 
  ## list database
  Command.run_shell("cd #{$config.setup.install_location}/postgresql/bin/ && PGPASSWORD=admin ./psql -Upostgres -h localhost --list")

  ## 3)
  ## recreate database
  Command.run_shell("cd #{$config.setup.install_location}/postgresql/bin/ && PGPASSWORD=admin ./psql -Upostgres -h localhost -c \"drop database alfresco\"")
  Command.run_shell("cd #{$config.setup.install_location}/postgresql/bin/ && PGPASSWORD=admin ./psql -Upostgres -h localhost -c \"create database alfresco\"")
  
  ## 4)
  ## delete content store
  Command.run_shell("rm -rf #{$config.setup.install_location}/alf_data/contentstore && rm -rf #{$config.setup.install_location}/alf_data/contentstore.deleted")
  Command.run_shell("rm -rf #{$config.setup.install_location}/alf_data/solr4/content && rm -rf #{$config.setup.install_location}/alf_data/solr4/index")

  ## 5) restart server
  Command.kill_program "tomcat"
  Command.kill_program "postgres"    
  Command.run_shell "cat /dev/null > #{$config.setup.install_location}/tomcat/logs/catalina.out"
  
  Command.run_shell("cd #{$config.setup.install_location} && ./alfresco.sh start")

  # and provision the machine with:
  provision_on $config
end
  