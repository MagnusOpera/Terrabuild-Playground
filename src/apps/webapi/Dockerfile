ARG dotnet_version
ARG configuration
ARG platform
FROM mcr.microsoft.com/dotnet/aspnet:${dotnet_version}

WORKDIR /app
COPY bin/${configuration}/${dotnet_version}/${platform} .

USER app
ENTRYPOINT [ "./webapi" ]
CMD [ "./webapi" ]
