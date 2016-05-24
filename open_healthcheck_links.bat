@echo off
echo Open healthcheck links..

start cmd /C start "" https://localhost:9090/alfresco/healthcheck
echo Opening ActiveMQ link...
start cmd /C start "" http://localhost:8161/admin/topics.jsp