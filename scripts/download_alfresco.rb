#
# Download Alfresco
#
module DownloadAlfresco
  include DevOn

  Command.run_shell("curl  \-u #{ENV["bamboo_username"]}:#{ENV["bamboo_password"]} \--cookie-jar cookies.txt '#{ENV["bamboo_login"]}' \--head")
  Command.run_shell("curl -O --cookie cookies.txt #{ENV["alfresco_binary_source"]} #{File.basename(ENV["alfresco_binary_source"])}")
  provision_on $config
end
