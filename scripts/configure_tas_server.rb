
module ConfigureTASNode
  include DevOn
  
  ## # prepare environment 
  ## library for mounting drives AOS
  Command.run_shell "apt-get install davfs2 -y"

  ## 0)
  ## check smb server is running - nothing should be returned except of command process id
  Command.run_shell "ps -ef | grep smbd"
  Command.run_shell "ps -ef | grep nmbd"
  ## stopping the smbd server
  Command.run_shell("sudo service smbd stop")
  Command.run_shell("sudo service nmbd stop")

  ## 1)
  ## Kill programs if opened
  Command.kill_program "tomcat"
  Command.kill_program "postgres"
  
  ## 2)
  ## if installer is not on disk download it from nightlybuilds  
  ##
  Command.run_shell("if [ ! -f \"$config.installer_name}\" ]; then wget #{$config.nightlybuild}; fi")
  
  ## 3)
  ## Make binary executable
  Command.run_shell("chmod +x #{$config.installer_name}")

  ## 4)
  ## Delete alfresco if installed
  Command.run_shell("rm -rf #{$config.setup.install_location}")

  ## 5)
  ## install it unattended
  unattended = "./#{$config.installer_name} --mode unattended --alfresco_admin_password admin --jdbc_username alfresco --jdbc_password admin --jdbc_driver '#{$config.setup.driver}' --jdbc_url '#{$config.setup.jdbc_url}' --baseunixservice_install_as_service 0 --prefix #{$config.setup.install_location}"
  Command.run_shell(unattended)

  # ## 6)
  # ## upload custom global properties based on version
  Command.upload_file(use_file($config, "alfresco-global.properties.erb"), "#{$config.setup.install_location}/tomcat/shared/classes/alfresco-global.properties")
  
  ## 7)
  ## Install AMPS
  ##
  $config.amps.alfresco_war.each do |amp_name|
    amp_location = "#{$config.setup.install_location}/amps/#{amp_name}"
    Command.run_shell "rm #{amp_location}"    
    Command.run_shell "wget --user=#{$connection.settings.ldap_username} --password=#{$connection.settings.ldap_password} #{$config.amps.root}#{amp_name} -P #{$config.setup.install_location}/amps"

    Command.run_shell "cd #{$config.setup.install_location}/bin && java -jar alfresco-mmt.jar install ../amps/#{File.basename(amp_name)} ../tomcat/webapps/alfresco.war"
  end

  Command.run_shell "cd #{$config.setup.install_location}/bin && java -jar alfresco-mmt.jar list ../tomcat/webapps/alfresco.war > #{$config.setup.install_location}/installed_amps"
  Command.run_shell "cat #{$config.setup.install_location}/installed_amps"  

  ## 8)
  ## download jolokia  
  Command.run_shell "wget #{$config.jolokia.download_url} -P #{$config.setup.install_location}/tomcat/webapps"
  Command.run_shell "cd #{$config.setup.install_location}/tomcat/webapps && mv #{$config.jolokia.name} jolokia.war"

  ## 9) Start server
  Command.run_shell("cd #{$config.setup.install_location} && ./alfresco.sh start")

  # and provision the machine with:
  provision_on $config
end
  