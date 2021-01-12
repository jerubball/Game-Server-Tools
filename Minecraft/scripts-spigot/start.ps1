# powershell ise
# Set-ExecutionPolicy RemoteSigned

# 0xF 0x3 0xC

if ($args[0] -eq '1') {
    java -Xmx4300M -Xms4300M -Xmn4300M -jar spigot-1.16.4.jar
    pause
} elseif ($args[0] -eq '2') {
    #$ErrorActionPreference="Continue"
    ForEach ($proc in Get-Process) {
        If ($proc.ProcessName -eq "java") {
            $proc.ProcessorAffinity=0xF
            $proc.PriorityClass="RealTime"
        } Else {
            $proc.ProcessorAffinity=0xC
            If ($proc.ProcessName -eq "explorer") {
                $proc.PriorityClass="BelowNormal"
            }
            #If ($proc.ProcessName -eq "clipdown") {
            #    Stop-Process -id $proc.Id
            #}
        }
    }
} else {
    #$Proc=Start-Process powershell -PassThru -ArgumentList "-File ./start.ps1 1"
    Start-Process ./start.bat
    Start-Sleep -Seconds 20
    Start-Process powershell -Verb RunAs -ArgumentList "-File C:/Users/hasol/AppData/Roaming/.minecraft/server-spigot/start.ps1 2"
    #Start-Process powershell -Verb RunAs -ArgumentList "-File C:/Users/hasol/AppData/Roaming/.minecraft/server-spigot/test.ps1"
}