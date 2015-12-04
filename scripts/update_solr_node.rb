#
# Solr node installed on apache tomcat server

# connected to Alfresco or LB instance
# no SSL connection, just 8080 port used
#
# START tomcat first to create the SOLR webapps
#
module Install_solr
  include DevOn

  # for 5.0.N unzip alfresco-enterprise.5.0.n.zip and copy to ~/
  # copy solr4.zip from alfresco out of the box installation

  Command.kill_program "tomcat"

  #clean solr.log from tomcat
  Command.run_shell "cd #{$config.tomcat.home} && cat /dev/null > solr.log"

  # http://docs.alfresco.com/5.1/tasks/solr4-install-config.html
  Command.upload_file(use_file($config, "solr.xml.erb"), "#{$config.tomcat.catalina.localhost}/solr4.xml")

  Command.upload_file(use_file($config, "a-solrcore.properties.erb"), $config.solr.core_properties.archiveSpaceStore)
  Command.upload_file(use_file($config, "w-solrcore.properties.erb"), $config.solr.core_properties.workspaceSpaceStore)

  Command.upload_file(use_file($config, "server.xml"), File.join($config.tomcat.conf, "server.xml"))
  Command.upload_file(use_file($config, "tomcat-users.xml"), File.join($config.tomcat.conf, "tomcat-users.xml"))

  #Command.run_shell "mkdir -p #{$config.tomcat.webapps.solr.web_inf}"
  #Command.upload_file(use_file($config, "web.xml"), File.join($config.tomcat.webapps.solr.web_inf, "web.xml"))

  #copy solr4 to tomcat webapps
  Command.run_shell("cp #{$config.solr.home}/solr4.war #{$config.tomcat.webapps.home}")

  provision_on $config
end
