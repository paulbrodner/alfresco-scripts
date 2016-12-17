
module AlfrescoTAS
  include DevOn

  Config.on "alfresco_5_1" do
   	nightlybuild "https://nightlybuilds.alfresco.com/Enterprise-5.2/5.2/build-00027/ALL/alfresco-content-services-installer-5.2.0-SNAPSHOT-linux-x64.bin"	  
   	
   	installer_name File.basename(Config.alfresco_5_1.nightlybuild)
   	download_location "/root/#{Config.alfresco_5_1.installer_name}"      

   	setup do 
	  driver "org.postgresql.Driver"
	  jdbc_url "jdbc:postgresql://localhost:5432/alfresco?useUnicode=yes&characterEncoding=UTF-8"
   	end
  end

  #add compatible with this script
  Config.alfresco_5_1.add_compatibility!("configure_tas_node")
end
  