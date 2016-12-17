module Jenkins
  include DevOn

  Config.on "tas_server2" do
    os OS_UNIX

    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
      ldap_username ENV['ALFRESCO_USERNAME']  #defined in .bash_profile
      ldap_password ENV['ALFRESCO_PASSWORD']  #defined in .bash_profile
    end

    tmp "/tmp"
  end
end

