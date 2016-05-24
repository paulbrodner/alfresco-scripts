curl  \-u username:password \--cookie-jar cookies.txt https://bamboo.alfresco.com/bamboo/userlogin!default.action?os_destination=%2Fstart.action 
curl -O --cookie cookies.txt https://bamboo.alfresco.com/bamboo/browse/SRVC-SYNCWINDOWS-486/artifact/shared/Installers/Alfresco%20Desktop%20Sync%20Setup%20v1.0_64.exe
