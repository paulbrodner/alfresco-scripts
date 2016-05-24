@echo off
set alfresco_local_path=%userprofile%\Downloads
set tmp_logs=C:\desktop-sync
set sync_user_data=%USERPROFILE%\AppData\Local\Alfresco

echo The following setups are available:
DIR %alfresco_local_path%\Alfresco*.exe
echo What do you want to do ?
echo 1-Install
echo 2-Uninstall
set /p INPUT=Choose option:%=%
set /p sync_buil_number=Choose sync build number:%=%
set sync_setup="%alfresco_local_path%\Alfresco Desktop Sync Setup v1.0_64-%sync_buil_number%.exe"
If Not Exist %sync_setup% goto nosetup
If /I "%INPUT%"=="1" goto install 
If /I "%INPUT%"=="2" goto uninstall 
:install
echo Installing %sync_setup%
 %sync_setup% /s /v"/qn /l %tmp_logs%\x64_log_silent_install-%sync_buil_number%.log" 
 start notepad++ %sync_user_data%\AlfrescoSync.conf
goto end

:uninstall
echo Uninstalling %sync_setup%
%sync_setup% /x /s /v"/qn"
goto end

:nosetup
echo %sync_setup% does not exist!
goto end
:end
echo "Done!"
pause