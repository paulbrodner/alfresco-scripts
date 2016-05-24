@echo off
echo Install Alfresco unattended...

set setups_location=%userprofile%\Downloads
set alfresco_kit_folder=%setups_location%\alfresco-one
set alfresco_setup=%alfresco_kit_folder%\alfresco-one-installer-20160415-SNAPSHOT-399-win-x64.exe
set alfresco_destination=C:\Alfresco-One

%alfresco_setup% --mode unattended --enable-components javaalfresco,postgres,alfrescosolr4,alfrescogoogledocs,libreofficecomponent --prefix %alfresco_destination% --jdbc_username alfresco --jdbc_password alfresco --alfresco_admin_password admin --alfrescocustomstack_services_startup auto --unattendedmodeui minimal