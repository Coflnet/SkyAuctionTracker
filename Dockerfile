FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /build/sky
COPY SkyAuctionTracker.csproj SkyAuctionTracker.csproj
RUN dotnet restore
COPY . .
RUN dotnet publish -c release

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

COPY --from=build /build/sky/bin/release/net6.0/publish/ .
RUN mkdir -p ah/files

ENTRYPOINT ["dotnet", "SkyAuctionTracker.dll"]

VOLUME /data
