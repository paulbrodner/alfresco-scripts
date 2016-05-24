@echo off
echo Start activeMQ
set setups_location=C:\active-mq\apache-activemq-5.13.1\bin\win64\activemq.bat

start /MIN cmd /C %setups_location% start

echo Opening ActiveMQ link...
start cmd /C start "" http://localhost:8161/admin/topics.jsp