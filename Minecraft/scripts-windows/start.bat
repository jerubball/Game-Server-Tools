cd C:\Users\hasol\AppData\Roaming\.minecraft\server\
powershell -Command ..\announce.ps1 '"Minecraft vanilla server started on port 25566."'
start "MinecraftServer" /AFFINITY 0xf /HIGH /WAIT /B java -Xmx10000M -Xms10000M -XX:+UseG1GC -XX:MaxGCPauseMillis=250 -jar server.jar
powershell -Command ..\announce.ps1 '"Minecraft vanilla server stopped."'
pause