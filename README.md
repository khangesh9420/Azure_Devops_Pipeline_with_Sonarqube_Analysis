# WeatherAPI

WeatherAPI is a .NET ASP Core application that displays a static web page with weather information. This project uses .NET SDK 8.0, Docker, Docker Compose, and is integrated with an Azure DevOps pipeline for CI/CD.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Clone and build the project locally](#clone-and-build-the-project-locally)
  - [Cloning the Repository](#cloning-the-repository)
  - [Building the Project locally](#building-the-project-locally)
- [Running the Application](#running-the-application)
  - [Using Docker](#using-docker)
  - [Using Docker Compose](#using-docker-compose)
- [Pipeline Configuration](#pipeline-configuration)
  - [Overview of the Azure DevOps Pipeline](#overview-of-the-azure-devops-pipeline)
  - [Pipeline defined in several stages](#pipeline-defined-in-several-stages)
  - [Triggers](#triggers)
- [Infrastructure Overview](#infrastructure-overview)
  - [Build Stage](#build-stage)
  - [Build and Push Docker Image Stage](#build-and-push-docker-image-stage)
  - [Test Stage](#test-stage)
  - [Staging Deployment Stage](#staging-deployment-stage)
  - [Deployment Stage](#deployment-stage)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- Install [.NET SDK 8.0](https://dotnet.microsoft.com/download/dotnet/8.0)
- Install [GIT](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop)
- Install [Docker](https://www.docker.com/get-started)
- You have an [Azure DevOps](https://dev.azure.com/) account and the necessary permissions to create and run CI/CD pipelines.

## Clone and build the project locally

### Cloning the Repository

1. Clone the repository to your local machine using the following command:

    ```bash
    git clone https://github.com/khangesh9420/azure_devops_dotnet_asp_pipeline.git
    ```

### Building the Project locally 

2. Navigate to the project directory and build the project:

    ```bash
    cd azure_devops_dotnet_asp_pipeline/weatherapi
    dotnet clean
    dotnet build
    [command below is a normal mode run] 
    dotnet run 
    [command below is a detached mode run]
    dotnet run -d 
    ```

3.  Navigate to the project directory and test the project:

     ```bash
    cd azure_devops_dotnet_asp_pipeline/weatherapi:Tests
    dotnet clean
    [Run Unit test using below command]
    dotnet test
    
    ```

## Running the Application

### Using Docker

1. Build the Docker image:

    ```bash
    docker build -t khangeshmatte123/dotnet:latest .
  
    ```

2. Run the Docker container:

    ```bash
    docker run -d -p 8082:8080 khangeshmatte123/dotnet:latest
    ```

3. Open your browser and navigate to `http://localhost:8082` to see the application.

### Using Docker Compose

1. Run the following command to start the application using Docker Compose:

    ```bash
    docker-compose up
    ```

2. Open your browser and navigate to `http://localhost:8081` to see the application.

## Pipeline Configuration

### Overview of the Azure DevOps Pipeline

The Azure DevOps pipeline for WeatherAPI includes multiple stages for building, docker buildpush, testing, and deploying the application. The stages are defined in the `azure-pipelines.yml` file located in the root of the repository.

### Pipeline defined in a sevral stages

1. **Build**: Compiles the .NET project and generates artifacts.
2. **Docker Image Build**: Builds and push Docker images for the .NET project.
3. **Test**: Runs tests to ensure code quality.
4. **Staging**: Deploys the application to a staging environment.
5. **Deploy**: Deploys the application to production after successful testing.

### Triggers

The pipeline is triggered on changes to the `main` branch or when new releases are created.

## Infrastructure Overview

The flowchart diagram of Pipeline is look like this
<img width="215" alt="image" src="https://github.com/khangesh9420/azure_devops_dotnet_asp_pipeline/assets/72436906/100b848c-4773-4fa2-bca4-045c8c372785">

### Build Stage

The Build stage compiles the project, performs code analysis using SonarCloud, and publishes artifacts for further stages. 

Steps:

1. **Checkout**: Fetches the latest source code.
2. **Use .NET SDK**: Sets up the .NET SDK version.
3. **Restore Packages**: Retrieves necessary NuGet packages.
4. **SonarCloud Preparation**: Configures the project for analysis.
5. **Build the Project**: Compiles the project.
6. **Publish Artifacts**: Stores the compiled code for deployment.
7. **SonarCloud Analysis**: Conducts static code analysis.
8. **SonarCloud Publish**: Shares analysis results.
9. **Publish Build Artifacts**: Makes compiled code available for subsequent stages.

### Build and Push Docker Image Stage

#### Steps:

1. **Build Docker Image**: Builds the Docker image using the specified Dockerfile.
2. **Push Docker Image**: Pushes the built Docker image to the specified container registry.

#### Conditions:

- The Push Docker Image task is executed only if the Build stage succeeded and the source branch is `main`.

### Test Stage

#### Steps:

1. **Unit Testing**: Executes unit tests for the application.
   
   - **DotNetCoreCLI Task**: Runs unit tests using the .NET Core CLI. It specifies the test project to run, configuration, and collects code coverage data.

### Staging Deployment Stage

The Staging Deployment stage creates a staging environment for the application. This stage runs after the Test stage and only if the tests have succeeded.

#### Steps:

1. **Creating Staging Environment**: Prepares the staging environment before deployment.
   
   - **Run Docker Compose**: Utilizes Docker Compose to set up containers defined in the `docker-compose.yml` file.

### Deployment Stage

The Deployment stage initiates the deployment of the application after successful staging. It utilizes Docker Compose for deployment and checks container status, inspects logs, and performs a health check.

#### Steps:

1. **Deploy**: Utilizes Docker Compose to deploy the application.

2. **Check Container Status**: Verifies container status using `docker ps -a`.

3. **Inspect Container Logs**: Reviews container logs using `docker-compose logs`.

4. **Health Check**: Verifies application health with a curl request.

