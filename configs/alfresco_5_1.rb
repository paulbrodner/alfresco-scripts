
module AlfrescoTAS
  include DevOn

  Config.on "alfresco_5_1" do
   	nightlybuild "https://nightlybuilds.alfresco.com/Enterprise-5.1/5.1.2/build-00012/ALL/alfresco-one-installer-5.1.2-linux-x64.bin"	  
   	
   	installer_name File.basename(Config.alfresco_5_1.nightlybuild)
   	download_location "/root/#{Config.alfresco_5_1.installer_name}"      

    jolokia do
      download_url "https://repo1.maven.org/maven2/org/jolokia/jolokia-war/1.3.5/jolokia-war-1.3.5.war"
      name File.basename(Config.alfresco_5_1.jolokia.download_url)
    end

   	setup do 
	    driver "org.postgresql.Driver"
	    jdbc_url "jdbc:postgresql://localhost:5432/${db.name}"
   	end

   	amps do 
   	  root "https://nexus.alfresco.com/nexus/service/local/repositories/internal-releases/content/org/alfresco/tas/"
   	  # all array of amps here 
   	  alfresco_war ['alfresco-log-extension/1.0.0/alfresco-log-extension-1.0.0.amp']
   	end   	
  end

  #add compatible with this script
  Config.alfresco_5_1.add_compatibility!("configure_tas_server")
end
  