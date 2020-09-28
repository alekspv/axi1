[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({test-path $_ })]
    [string]
    $Dockerfile,
    [Switch]$Localbuild
)
# #For ssl
# if (-not (Test-Path .\https)) {
#     mkdir https   
# }
# copy $env:USERPROFILE\.aspnet\https\* .\https


if ($Localbuild) {
    dotnet build .\src\SuperService.csproj
    dotnet test .\test\SuperService.UnitTests.csproj   
    dotnet publish .\src\SuperService.csproj -c Release   -o out
}

#Deleting old 
docker stop core-counter
docker rm  core-counter
docker rmi counter-image

##Docker Build 
docker build  -t counter-image -f $Dockerfile .

#Simple run
 docker run -d -P --name core-counter counter-image 
#get url  for windows Docker Desktop
 $containerip  = $(docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" core-counter)
 "http://"+$containerip+"/time"
 
### Generate SSL dev cert
# dotnet dev-certs https -ep $env:USERPROFILE\.aspnet\https\aspnetapp.pfx -p "password"
# dotnet dev-certs https --trust

#For SSL
# docker run --rm -it -p 8000:80 -p 8001:443 -e ASPNETCORE_URLS="https://+;http://+" -e ASPNETCORE_HTTPS_PORT=8001 -e ASPNETCORE_Kestrel__Certificates__Default__Password="password" -e ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx  --name core-counter counter-image 
# docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" core-counter