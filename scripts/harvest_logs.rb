#
# Collect alfresco.log and catalina.out logs from on node
#
module HarvestLogs
  include DevOn

  def self.structure(name)
    folder = File.basename($config.alfresco.home)
    File.join("LOGS/"+$connection.name, folder + "/" +name)
  end

  Command.download_file($config.alfresco.log, structure("alfresco.log"))
  Command.download_file($config.alfresco.share.log, structure("share.log"))
  Command.download_file($config.tomcat.catalina_out, structure("tomcat/catalina.out"))

  provision_on $config
end
