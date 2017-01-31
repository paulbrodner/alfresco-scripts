
module DockerUpdate
  include DevOn
  
  def self.append_command(command)
    code_for_container = "'#{command}'"

    # append to file commands
    Command.run_shell("echo docker exec -it $output /bin/sh -c \"#{code_for_container}\" >> #{@file}")
  end

  #
  # use gloabl variable of the current connection selected
  # $connection.settings
  # or of the current configuration
  # $config.name
  #
  # Command.run_shell_file("install/test.sh")
  @file = "start.sh"
  Command.run_shell "rm -f #{@file}"

  # here we get the ID of container and use this ID (stored in $output of devOn) to next shell script)  
  Command.run_shell "docker ps | grep tas-alfresco | awk '{print $1}' | head -1"

  append_command "supervisorctl stop tomcat-alfresco"
  append_command "wget https://releases.alfresco.com/AOS-Module/1.1.5/alfresco-aos-module-1.1.5.zip; unzip alfresco-aos-module-1.1.5.zip"
  append_command "cp _vti_bin.war ../alfresco/webapps/"
  append_command "cp alfresco-aos-module-1.1.5.amp ../amps"
  append_command "java -jar alfresco-mmt.jar install alfresco-aos-module-1.1.5.amp ../alfresco/webapps/alfresco.war"
  append_command "supervisorctl start tomcat-alfresco"
  append_command "ls -la"
  
  # run the file
  Command.run_shell("chmod +x #{@file}")
  Command.run_shell("./#{@file}")

  #and provision the machine with:
  provision_on $config  
  
  cmd  = "ssh #{$connection.settings['username']}@#{$connection.settings['hostname']}      Use: #{$connection.settings['password']}"
  puts cmd
  
end


  