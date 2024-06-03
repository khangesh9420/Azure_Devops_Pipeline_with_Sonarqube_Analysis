# Base_Image for dotnet 8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

# Build Image using 8.0 SDK 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["weatherapi/weatherapi.csproj", "weatherapi/"]
# Restore any dependecy if present or found
RUN dotnet restore "weatherapi/weatherapi.csproj"
# copy from local to docker
COPY . .
# This is the application which I want to rundo
WORKDIR "/src/weatherapi/"
# build the application with the release tag and keep in output folder /app/build
RUN dotnet build "weatherapi.csproj" -c Release -o /app/build

# publish Image
FROM build AS publish
RUN dotnet publish "weatherapi.csproj" -c Release -o /app/publish

# final Image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "weatherapi.dll"]
