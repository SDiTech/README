# dotnet-cli

The dotnet-cli is essential for launching starter templates, scaffolding applications, and managing project packages/references.

### Essential Tools
- dotnet-ef
- dotnet-aspnet-codegenerator

```bash
# install with specific versions
dotnet tool install -g dotnet-ef --version 6.0.11
dotnet tool install -g dotnet-aspnet-codegenerator --version 6.0.12
```

__warning__: version mismatches of either of these global tools with their corresponding project library will cause build failures when attempting to generate code.

### Libraries

#### Entities and Code Generation
- Microsoft.EntityFrameworkCore
- Microsoft.EntityFrameworkCore.Design
- Microsoft.VisualStudio.Web.CodeGeneration.Design
- Microsoft.EntityFrameworkCore.SqlServer
- Microsoft.EntityFrameworkCore.Tools
- Pomelo.EntityFrameworkCore.MySql
- Npgsql.EntityFrameworkCore.PostgreSQL

#### Configuration
- Microsoft.Extensions.Configuration
- Microsoft.Extensions.Configuration.FileExtensions
- Microsoft.Extensions.Configuration.Json