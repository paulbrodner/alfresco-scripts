
module AlfrescoTAS
  include DevOn

  Config.on "alfresco_5_2" do
   	nightlybuild "https://nightlybuilds.alfresco.com/Enterprise-5.2/5.2/build-00027/ALL/alfresco-content-services-installer-5.2.0-SNAPSHOT-linux-x64.bin"	  
   	
   	installer_name File.basename(Config.alfresco_5_2.nightlybuild)
   	download_location "/root/#{Config.alfresco_5_2.installer_name}"      

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
  Config.alfresco_5_2.add_compatibility!("configure_tas_node")
end
  