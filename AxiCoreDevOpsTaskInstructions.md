# DevOps Interview Task

Thank you for taking the time to do our technical test. We need to deploy a new .NET Core Web API application using a docker container.

Write code to do the following:

1. Run the automated tests
2. Package the application as a docker image
3. Deploy and run the image

Improvements can also be made. For example:

- Make any changes to the application you think are useful for a deploy process
- Host the application in a secure fashion

The application is included under [`.\super-service`](`.\super-service`).

Your solution should be triggered by a powershell script called `Deploy.ps1`.

## Submitting

Please send back a zip file with your solution and state the time taken.


# Worklog
## Setup

- install  docker Desktop(hyper-v on  windows)
- switch to  windows containers
- login to dockerhub
- Add to  Dockerfile 
    >```FROM mcr.microsoft.com/dotnet/core/aspnet:3.1```
    
    >```FROM mcr.microsoft.com/dotnet/core/sdk:3.1```
- Preload image 
    >```docker build -t counter-image -f Dockerfile .```
- check  git keys and git setup  and clone from  [https://github.com/alekspv/axi1](https://github.com/alekspv/axi1)  
## Build

> **Note 1:** *covers most tasks: [Tutorial: Containerize a .NET Core app](https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows)*

### Files describtion
From  ```AxiCoreDevOpsTask\Super-service``` as root
| File  |Describtion|
| --- | --- |
| `Dockerfile` | Example of simple build |
| `Dockerfile_with_build` | Multistage build in container for CI with  container support|
| `Deploy.ps1` |build Script|
| `rundeploy.cmd`|Entry point powershell script runner to  overcome scriot run policy|
| `rundeployCi.cmd`| Entry point Powershell runner for Ci to  overcome scriot run policy|

Tested with  Docker Desktop