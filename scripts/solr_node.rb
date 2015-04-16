#
# Solr node installed on apache tomcat server
# connected to Alfresco or LB instance
# no SSL connection, just 8080 port used
#
# START tomcat first to create the SOLR webapps
#
module Install_solr
  include DevOn

  # http://docs.alfresco.com/4.1/tasks/solr-install-config.html
  Command.upload_file(use_file($config, "solr.xml.erb"), "#{$config.tomcat.catalina.localhost}/solr.xml")

  Command.upload_file(use_file($config, "a-solrcore.properties.erb"), $config.solr.core_properties.archiveSpaceStore)
  Command.upload_file(use_file($config, "w-solrcore.properties.erb"), $config.solr.core_properties.workspaceSpaceStore)

  Command.upload_file(use_file($config, "server.xml"), File.join($config.tomcat.conf, "server.xml"))
  Command.upload_file(use_file($config, "tomcat-users.xml"), File.join($config.tomcat.conf, "tomcat-users.xml"))

  Command.upload_file(use_file($config, "web.xml"), File.join($config.tomcat.webapps.solr.web_inf, "web.xml"))

  provision_on $config
end
