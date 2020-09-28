FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
COPY out/ App/
#COPY https/ https/
WORKDIR /App

ENTRYPOINT ["dotnet", "SuperService.dll"]