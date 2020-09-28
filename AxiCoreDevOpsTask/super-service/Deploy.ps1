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

#Deleting old containers
docker stop core-counter
docker rm  core-counter
##Docker Build 
docker build  -t counter-image -f .\src\Dockerfile  .\src\
#docker build  -t counter-image -f .\src\Dockerfile_with_build  .\src\

docker images

docker run -d -P --name core-counter counter-image 
#docker start  core-counter
### SSL

# docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" counter-image
## Deploy and run Locally

## Upload Image

## Deploy cloud