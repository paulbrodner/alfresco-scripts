#
# Collect alfresco.log and catalina.out logs from on node + solr logs
#
module HarvestLogs
  include DevOn

  def self.structure(name)
    folder = File.basename($config.alfresco.home)
    File.join("LOGS/"+$connection.name, folder + "/" +name)
  end

  Command.download_file($config.alfresco.log, structure("alfresco.log"))
  Command.download_file($config.tomcat.catalina_out, structure("tomcat/catalina.out"))
  Command.run_shell("ls #{$config.alfresco.home}/solr.log*")

  # run the provisioning and extract the log files
  files = provision_on($config)
  files.each do |file|
    Command.download_file(file, structure(File.basename(file)))
  end

  # run again the provisioning in order to download the extracted logs
  provision_on($config)
end
