# Serverside - ATS

The solution will be divided in different sides, the backend providing REST API and the front Due the VanHack's partnership with Microsoft and because their systems are made in .NET, the backend part will be developed .NET Core MVC.

## Framework Version and installation

Framework used is the .NET Core V 2.1.X.
For intall information, please, follow the [link](https://www.microsoft.com/net/download/thank-you/dotnet-sdk-2.1.403-macos-x64-installer)
For more information about the Framework, see [.NET application architecture guides](https://www.microsoft.com/net/learn/dotnet/architecture-guides).
For first steps on .NET Core, click [here](https://docs.microsoft.com/en-us/aspnet/core/tutorials/razor-pages-vsc/razor-pages-start?view=aspnetcore-2.1)

## To run

Assuming the dotnet core is properly up and running, To execute de dotnet server, just stay on server directory and type on terminal ```dotnet run``` , or play on MS Visual Studio.

Assuming the service is running on `http://localhost:5000`, open this address on Browser and a Swagger UI will provide a minimum documentation and become able to perform HTTP Requests with UI's help.

### Tests

The tests are missing, the same way the business/service classes are also not implemented. 
A smoke test was developed just to validate if the REST API is up and running in bash script. Simply, just need to execute the (smoketest-basic.sh)[./bash-scripts/smoketest-basic.sh] script.

## TODOs notes:
- Create the business/services classes and connect the Controllers on these classes. The controllers are just connecting with in memory DB to support the frontend and simplify the discussion about the needs on API interfaces.