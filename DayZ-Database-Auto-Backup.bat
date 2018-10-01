@ECHO OFF

SET Dt=%DATE:~4,2%.%DATE:~7,2%.%DATE:~-4% %TIME:~0,2%.%TIME:~3,2%
SET SrcFolder=C:\steamcmd\dayz_server\mpmissions\dayzOffline.chernarusplus\storage_1
SET DestPath=C:\steamcmd\backups
SET TempFolder=C:\steamcmd\backups\storage1

xcopy /O /X /E /H /K /Y "%SrcFolder%" "%TempFolder%"

"C:\Program Files\7-Zip\7z" a "%DestPath%\DayZ_Database.%Dt%.7z" "%TempFolder%"
