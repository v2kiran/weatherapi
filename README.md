# weatherapi
publish api to azure using terraform and azure devops


```powershell
# setup a new blazor app
dotnet new blazorserver -o BlazorApp --no-https
cd BlazorApp

# make sure port is not in the range shown in the list below:
# mine is set to 5302
# ..\BlazorApp\Properties\launchSettings.json : set "applicationUrl": "http://localhost:5302"
netsh interface ipv4 show excludedportrange protocol=tcp

#The dotnet watch command will build and start the app, and then update the app whenever you make code changes. You can stop the app at any time by selecting Ctrl+C.
dotnet watch
```

the blazorapp website should auto open in your default browser

open `..BlazorApp\Pages\index.razor` inside pages folder and change
```
hello world
to
Terraform Azure Devops
```
the dotnet watch command should reload the changes automatically

## build docker image
```
docker build -t v2kiran/blazorapp
```

## test the image by running it locally
```
docker run --name myblazorapp -d -p 9001:80 v2kiran/blazorapp
```

we should be able to browse to http://localhost:9001

## Push image to docker hub
```
docker stop myblazorapp

# remove the container that we ran locally. we will run this container in the cloud
docker rm myblazorapp

# assumes that you have logged into docker hub
# if not use docker login -u user -p pass
docker push v2kiran/blazorapp
```