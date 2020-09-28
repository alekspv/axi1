[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({test-path $_ })]
    [string]
    $Dockerfile,
    [Switch]$Localbuild
)
## Build and test

"We are in  "+$PWD

if ($Localbuild) {
    dotnet build .\src\SuperService.csproj
    dotnet test .\test\SuperService.UnitTests.csproj   
    dotnet publish .\src\SuperService.csproj -c Release  
}

#Deleting old 
docker stop core-counter
docker rm  core-counter
docker rmi counter-image
##Docker Build 
docker build  -t counter-image -f $Dockerfile .
#docker build  -t counter-image -f .\src\Dockerfile_with_build  .\src\

docker images

docker run -d -P --name core-counter counter-image 

### SSL
# dotnet dev-certs https -ep $env:USERPROFILE\.aspnet\https\aspnetapp.pfx -p "password"
# dotnet dev-certs https --trust
# docker run --rm -it -p 8000:80 -p 8001:443 -e ASPNETCORE_URLS="https://+;http://+" -e ASPNETCORE_HTTPS_PORT=8001 -e ASPNETCORE_Kestrel__Certificates__Default__Password="password" -e ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx -v $env:USERPROFILE\.aspnet\https:/https/  --name core-counter counter-image 
# docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" counter-image
## Deploy and run Locally

## Upload Image

## Deploy cloud