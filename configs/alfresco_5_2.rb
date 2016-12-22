
module AlfrescoTAS
  include DevOn

  Config.on "alfresco_5_2" do
   	nightlybuild "https://nightlybuilds.alfresco.com/Enterprise-5.2/5.2.N/LATEST/ALL/alfresco-content-services-installer-5.2.1-SNAPSHOT-linux-x64.bin"	  
   	
   	installer_name File.basename(Config.alfresco_5_2.nightlybuild)
   	download_location "/root/#{Config.alfresco_5_2.installer_name}"      

    jolokia do
      download_url "https://repo1.maven.org/maven2/org/jolokia/jolokia-war/1.3.5/jolokia-war-1.3.5.war"
      name File.basename(Config.alfresco_5_2.jolokia.download_url)
    end

   	setup do 
	    driver "org.postgresql.Driver"
	    jdbc_url "jdbc:postgresql://localhost:5432/${db.name}"
      install_location "/opt/alfresco-one"
   	end

    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-log-extension/1.0.0/alfresco-log-extension-1.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-contentmodel-extension/1.0.0/alfresco-contentmodel-extension-1.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-workflow-extension/1.0.0/alfresco-workflow-extension-1.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-action-extension/1.0.0/alfresco-action-extension-1.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-authentication-extension/1.0.0/alfresco-authentication-extension-1.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-behaviours-extension/2.0.0/alfresco-behaviours-extension-2.0.0.amp
    # https://$LDAP_USER:$LDAP_PASS@nexus.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/tas/alfresco-subsystems-extension/1.0.0/alfresco-subsystems-extension-1.0.0.amp
    amps do 
      root "https://nexus.alfresco.com/nexus/service/local/repositories/internal-releases/content/org/alfresco/tas/"
      # all array of amps here 
      alfresco_war ['alfresco-log-extension/1.0.0/alfresco-log-extension-1.0.0.amp', 
                    'alfresco-workflow-extension/1.0.0/alfresco-workflow-extension-1.0.0.amp',
                    'alfresco-authentication-extension/1.0.0/alfresco-authentication-extension-1.0.0.amp',
                    'alfresco-contentmodel-extension/1.0.0/alfresco-contentmodel-extension-1.0.0.amp',
                    'alfresco-action-extension/1.0.0/alfresco-action-extension-1.0.0.amp',
                    'alfresco-scheduledJobs-extension/1.0.0/alfresco-scheduledJobs-extension-1.0.0.amp',
                    'alfresco-behaviours-extension/2.0.0/alfresco-behaviours-extension-2.0.0.amp',
                    'alfresco-subsystems-extension/1.0.0/alfresco-subsystems-extension-1.0.0.amp'
                  ]
    end  	
  end

  #add compatible with this script
  Config.alfresco_5_2.add_compatibility!("configure_tas_server")
  Config.alfresco_5_2.add_compatibility!("cleanup_tas_server")
end
  