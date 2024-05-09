FROM mcr.microsoft.com/dotnet/aspnet:8.0
ARG configuration=Release

WORKDIR /app
COPY bin/${configuration}/net8.0/linux-x64/publish /app
ENTRYPOINT ["/app/webapi"]
