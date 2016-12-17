
module ConfigureTASNode
  include DevOn
  
  #Command.run_shell("wget #{$config.nightlybuild}")
  
  # Command.run_shell("chmod +x #{$config.installer_name}")

  Command.kill_program "tomcat"
  Command.kill_program "postgres"

  alfresco_log = "https://nexus.alfresco.com/nexus/service/local/repositories/internal-releases/content/org/alfresco/tas/alfresco-log-extension/1.0.0/alfresco-log-extension-1.0.0.amp"
  Command.upload_file(use_file($config, "alfresco-global.properties.erb"), "/opt/alfresco-one/tomcat/shared/classes/alfresco-global.properties")

  Command.run_shell("wget --user=#{$connection.settings.ldap_username} --password=#{$connection.settings.ldap_password} #{alfresco_log}")
  
  # Command.run_shell("rm -rf /opt/alfresco-one")


  # unattended = "./#{$config.installer_name} --mode unattended --alfresco_admin_password admin --jdbc_username alfresco --jdbc_password admin --jdbc_driver '#{$config.setup.driver}' --jdbc_url '#{$config.setup.jdbc_url}' --baseunixservice_install_as_service 0 --prefix /opt/alfresco-one"

  # Command.run_shell(unattended)

  # Command.run_shell("cd /opt/alfresco-one && ./alfresco.sh start")

  # and provision the machine with:
  provision_on $config
end
  