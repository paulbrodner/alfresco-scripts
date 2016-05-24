@echo off
echo Update Alfresco...

set alfresco_installation_path=C:\Alfresco-One
set global_properties_path=%alfresco_installation_path%\tomcat\shared\classes\alfresco-global.properties

REM ACTIVE MQ
set activeMQ_broker_url=(tcp://localhost:61616)?timeout=3000

REM Sync service
set sync_version_path=C:\desktop-sync\setup\sync-704
set dsync_amp_path=%sync_version_path%\amps-repository\alfresco-device-sync-repo-2.0-SNAPSHOT.amp

REM STOP Alfresco
REM net stop "alfrescoTomcat" 

echo Editing the global properties file
echo. >> %global_properties_path%
echo. >> %global_properties_path%
echo ### Remote JMX (Default: disabled) override ### >> %global_properties_path%
echo alfresco.jmx.connector.enabled=true >> %global_properties_path%
echo ###Adding Extra parameters for Desktop Sync### >> %global_properties_path%
echo messaging.broker.url=failover:%activeMQ_broker_url% >> %global_properties_path%
echo messaging.subsystem.autoStart=true >> %global_properties_path%
echo events.subsystem.autoStart=true >> %global_properties_path%
echo sync.service.uris=https://localhost:9090/alfresco >> %global_properties_path%
echo system.usages.enabled=true >> %global_properties_path%

echo Applying AMP...
java -jar %alfresco_installation_path%\bin\alfresco-mmt.jar install %dsync_amp_path% %alfresco_installation_path%\tomcat\webapps\alfresco.war
java -jar %alfresco_installation_path%\bin\alfresco-mmt.jar list %alfresco_installation_path%\tomcat\webapps\alfresco.war

REM net start "alfrescoTomcat" 

pause