module MmSolrNode
  include DevOn

  Config.on "install_alfresco" do

    installer do
      binary "/downloads/alfresco-one-installer-5.1.2-linux-x64.bin"
      db_name "alfresco"
      jdbc_username "alfresco"
      jdbc_password "admin"
      jdbc_url  "jdbc:postgresql://localhost:5432/#{Config.install_alfresco.installer.db_name}?useUnicode=yes&characterEncoding=UTF-8"
      enable_components "javaalfresco,postgres,libreofficecomponent,alfrescosolr,alfrescosolr4,aosmodule,alfrescowcmqs,alfrescogoogledocs"
      disable_components ""
      driver "org.postgresql.Driver"
      install_as_a_service "0"
    end

    alfresco do
      home "/#{ENV['username']}/#{File.basename(Config.install_alfresco.installer.binary,".*").split("-installer").first}"
    end

  end

  #add compatible with this script
  Config.install_alfresco.add_compatibility!("install_alfresco")
  Config.install_alfresco.add_compatibility!("restart_alfresco_tomcat")
end
