# Use the official ASP.NET 6 base image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# Copy the main source code
COPY . .
# Copy csproj and restore as distinct layers
RUN dotnet restore "WorkoutBuddy.Service/Backend.WebApp/Backend.WebApp.csproj"

# Build the application
WORKDIR "/src"
RUN dotnet build "WorkoutBuddy.Service/Backend.WebApp/Backend.WebApp.csproj" -c Release -o /app/build

# Publish Stage
FROM build AS publish
RUN dotnet publish "WorkoutBuddy.Service/Backend.WebApp/Backend.WebApp.csproj" -c Release -o /app/publish

# Final Stage
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "Backend.WebApp.dll", "--server.urls", "http://+:80;https://+:443"]
