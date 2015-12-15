
module Installing_alfresco
  include DevOn

  ALFRESCO_HOME = "alfresco-one-b577"
  INSTALLER_PATH = "/data/nfs/software/alfresco/alfresco-5.1/build-577/alfresco-one-installer-20151210-SNAPSHOT-577-linux-x64.bin"

  unattended = %Q{cd #{File.dirname(INSTALLER_PATH)} && ./#{File.basename(INSTALLER_PATH)}
 --unattendedmodeui none --mode unattended
 --alfresco_admin_password admin
 --disable-components postgres
 --prefix ~/#{ALFRESCO_HOME}
 --jdbc_username admin
 --jdbc_password admin
 --baseunixservice_install_as_service 0}.gsub("\n", "")
  Command.run_shell(unattended)

  provision_on $config
end
