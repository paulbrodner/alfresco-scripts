
module ConfigureTASNode
  include DevOn
 
  ## 1)
  ## Kill programs if opened
  Command.kill_program "tomcat"
  Command.kill_program "postgres"
  
  # ## 2)
  # ## if installer is not on disk download it from nightlybuilds  
  # ##
  # Command.run_shell("if [ ! -f \"$config.installer_name}\" ]; then wget #{$config.nightlybuild}; fi")
  
  # ## 3)
  # ## Make binary executable
  # Command.run_shell("chmod +x #{$config.installer_name}")

  # ## 4)
  # ## Delete alfresco if installed
  # Command.run_shell("rm -rf /opt/alfresco-one")

  # ## 5)
  # ## install it unattended
  # unattended = "./#{$config.installer_name} --mode unattended --alfresco_admin_password admin --jdbc_username alfresco --jdbc_password admin --jdbc_driver '#{$config.setup.driver}' --jdbc_url '#{$config.setup.jdbc_url}' --baseunixservice_install_as_service 0 --prefix /opt/alfresco-one"
  # Command.run_shell(unattended)

  # ## 6)
  # ## upload custom global properties based on version
  Command.upload_file(use_file($config, "alfresco-global.properties.erb"), "/opt/alfresco-one/tomcat/shared/classes/alfresco-global.properties")
  
  # ## 7)
  # ## Install AMPS
  # ##
  # $config.amps.alfresco_war.each do |amp_name|
  #   amp_location = "/opt/alfresco-one/amps/#{amp_name}"
  #   Command.run_shell "rm #{amp_location}"    
  #   Command.run_shell "wget --user=#{$connection.settings.ldap_username} --password=#{$connection.settings.ldap_password} #{$config.amps.root}#{amp_name} -P /opt/alfresco-one/amps"

  #   Command.run_shell "cd /opt/alfresco-one/bin && java -jar alfresco-mmt.jar install ../amps/#{File.basename(amp_name)} ../tomcat/webapps/alfresco.war"
  # end

  # Command.run_shell "cd /opt/alfresco-one/bin && java -jar alfresco-mmt.jar list ../tomcat/webapps/alfresco.war > /opt/alfresco-one/installed_amps"
  # Command.run_shell "cat /opt/alfresco-one/installed_amps"  

  # ## 8)
  # ## download jolokia  
  # Command.run_shell "wget #{$config.jolokia.download_url} -P /opt/alfresco-one/tomcat/webapps"
  # Command.run_shell "cd /opt/alfresco-one/tomcat/webapps && mv #{$config.jolokia.name} jolokia.war"

  # ## 9) Start server
  # Command.run_shell("cd /opt/alfresco-one && ./alfresco.sh start")

  # and provision the machine with:
  provision_on $config
end
  