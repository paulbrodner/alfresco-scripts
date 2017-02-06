
module Docker_add_amps
  include DevOn
  
  def self.append_command(command)
    code_for_container = "'#{command}'"
    # append to file commands
    Command.run_shell("echo docker exec -it $output /bin/sh -c \"#{code_for_container}\" >> #{@file}")
  end
  amps = ["https://nexus.alfresco.com/nexus/service/local/repositories/internal-releases/content/org/alfresco/tas/alfresco-log-extension/1.0.0/alfresco-log-extension-1.0.0.amp"]

  @file = "add_amps.sh"
  Command.run_shell "rm -f #{@file}"

  # here we get the ID of container and use this ID (stored in $output of devOn) to next shell script)  
  Command.run_shell "docker ps | grep tas-alfresco | awk '{print $1}' | head -1"

  append_command "supervisorctl stop tomcat-alfresco"
  amps.each do |amp|
    append_command "wget --user=#{$connection.settings.ldap_username} --password=#{$connection.settings.ldap_password} #{amp} -P ../amps"
  end

  append_command "supervisorctl start tomcat-alfresco"
  append_command "ls -la ../amps"
  # make it executable
  Command.run_shell("chmod +x #{@file}")

   # and provision the machine with:
  provision_on $config


  cmd  = "ssh #{$connection.settings['username']}@#{$connection.settings['hostname']}      Use: #{$connection.settings['password']}\n Run manually #{@file} script"
  puts cmd
  puts "Press ENTER to continue and cleanup the #{@file} script in Container..."

  STDIN.gets.chomp
  Command.run_shell("rm -f #{@file}")
end
  