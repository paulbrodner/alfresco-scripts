
module Installing_alfresco
  include DevOn

  ALFRESCO_HOME = "alfresco-51-b372"
  INSTALLER_PATH = "/data/nfs/software/alfresco/alfresco-5.1/build-373/alfresco-enterprise-installer-20151006-SNAPSHOT-372-linux-x64.bin"  
  
  @enable_components  = "'javaalfresco libreofficecomponent alfrescosolr alfrescosolr4 alfrescowcmqs alfrescogoogledocs'"
  @disable_components = "'postgres'"
  @db_name="alfresco"
  @jdbc_username="alfresco"
  @jdbc_password="admin"
  @jdbc_url=$config.installer.jdbc_url
  @driver="org.postgresql.Driver"
  @install_as_a_service="0"

  unattended = %Q{
cd #{File.dirname(INSTALLER_PATH)} && #{INSTALLER_PATH} --mode unattended
--alfresco_admin_password admin --disable-components postgres --prefix /home/#{ENV['username']/alfresco-51-b372
 #{ALFRESCO_HOME}}.gsub!("\n", " ")

  #Command.run_shell("chmod +x #{INSTALLER_PATH}")
  Command.run_shell(unattended)

  provision_on $config
end
  