#Define GitHub organization mandatory parameter

param
(
  [Parameter(Mandatory)]
  [string]
  ${Gitea-URL}

)

$uri = ${Gitea-URL}.TrimEnd('/') + "/api/v1/orgs/sockshop/repos"

#Check if Git is installed
if(Get-Command git -errorAction SilentlyContinue){}
else{
    Write-Host "Please install the 'git' command: https://git-scm.com/" -ForegroundColor Red
    exit 1
}


#set up to ingnore self-signed certificates

#[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
$certCallback = @"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback += 
                    delegate
                    (
                        Object obj, 
                        X509Certificate certificate, 
                        X509Chain chain, 
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@
    Add-Type $certCallback
 }
[ServerCertificateValidationCallback]::Ignore()


#Get repos in Organization:
try{
$repositories = Invoke-RestMethod -Uri $uri -ContentType 'application/json'
}
catch{
     Write-Host "No repositories found in sockshop"
     exit 1
}

$current_dir = [string](Get-Location)
$new_dir = "${current_dir}\sockshop"
Write-Host "Repositories will be cloned to: ${new_dir}\" -ForegroundColor Yellow
Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
New-Item -Path . -Name "sockshop" -ItemType "directory" | Out-Null
Set-Location sockshop

foreach ($repo in $repositories) {
   Write-Host "Cloning" $repo.clone_url -ForegroundColor White
   git clone -q $repo.clone_url
   Write-Host "Done cloning" $repo.name -ForegroundColor Green
}

Write-Host ""
Write-Host "The repositories have been cloned to: ${new_dir}\" -ForegroundColor Blue -BackgroundColor White
Set-Location ..
exit 0