#
# Install Alfresco
# just define in your configuration file the attributes listed in configs/install_alfresco.rb
#
#
module InstallAlfresco
  include DevOn

  unattended = %Q{
cd #{File.dirname($config.installer.binary)} && #{$config.installer.binary} --mode unattended
--alfresco_admin_password admin
--enable-components #{$config.installer.enable_components}
  #{$config.installer.disable_components.empty? ? "" : "--disable-components #{$config.installer.disable_components}" }
--jdbc_username #{$config.installer.jdbc_username}
--jdbc_password #{$config.installer.jdbc_password}
--jdbc_driver '#{$config.installer.driver}'
--jdbc_url '#{$config.installer.jdbc_url}'
--baseunixservice_install_as_service #{$config.installer.install_as_a_service}
--prefix #{$config.alfresco.home}}.gsub!("\n", " ")


  Command.run_shell("chmod +x #{$config.installer.binary}")
  Command.run_shell(unattended)

  provision_on $config
end
  