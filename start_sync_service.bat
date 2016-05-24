@echo off
set sync_version_path=C:\desktop-sync\setup\sync-704
set sync_server_path=%sync_version_path%\service-sync

cd %sync_server_path% && java -jar %sync_server_path%\service-sync-1.1-SNAPSHOT.jar server config.yml