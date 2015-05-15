module MmSolrNode
  include DevOn

  Config.on "default_alfresco" do

    installer do
      binary "/data/nfs/software/alfresco/alfresco-5.1/alfresco-community-5.1-SNAPSHOT-installer-linux-x64.bin"
      db_name "alfresco"
      jdbc_username "alfresco"
      jdbc_password "admin"
      jdbc_url  "jdbc:postgresql://localhost:5432/#{Config.default_alfresco.installer.db_name}?useUnicode=yes&characterEncoding=UTF-8"
      enable_components "javaalfresco,alfrescosharepoint,alfrescowcmqs,libreofficecomponent"
      disable_components ""
      driver "org.postgresql.Driver"
      install_as_a_service "0"
    end

    alfresco do
      home "/home/#{ENV['username']}/#{File.basename(Config.default_alfresco.installer.binary,".*").split("-installer").first}"
    end

  end

  #add compatible with this script
  Config.default_alfresco.add_compatibility!("install_alfresco")
  Config.default_alfresco.add_compatibility!("restart_alfresco_tomcat")
end
