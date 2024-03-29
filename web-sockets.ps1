$path = Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Path)
Import-Module "$($path)/src/Pode.psm1" -Force -ErrorAction Stop

# create a server, and start listening
Start-PodeServer -Type Pode -Threads 5 {

    # listen on HTTPS and HTTP
    #Add-PodeEndpoint -Address * -Port 8080 -Protocol Http
    if ([string]::IsNullOrEmpty($env:port))
    {$portNo = 9001}
    else {$portNo = $env:port}
    Add-PodeEndpoint -Address * -Port $portNo -CertificateFile './certs/docker.pfx' -CertificatePassword 'podeRocksSocks' -Protocol Https

    # log requests to the terminal
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    # GET request for web page 
    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
        Write-PodeJsonResponse -Value @{
            Kenobi = 'Hello, there!!'
        }
    }
}