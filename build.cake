#tool "nuget:?package=GitVersion.CommandLine"

//////////////////////////////////////////////////////////////////////
// ARGUMENTS
//////////////////////////////////////////////////////////////////////

var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");
var distDir = Argument("distDir", "./dist/")

Information($"Running target {target} in configuration {configuration}");

//////////////////////////////////////////////////////////////////////
// TASKS
//////////////////////////////////////////////////////////////////////

Task("Clean")
    .Does(() =>
{
    CleanDirectories("./**/bin");
    CleanDirectories("./**/obj");
});

Task("Restore")
    .Does(() =>
{
    DotNetCoreRestore("./src/");
});

Task("UpdateAssemblyInfo")
    .Does(() =>
{
    GitVersion(new GitVersionSettings {
        UpdateAssemblyInfo = true
    });
});

Task("Build")
  .Does(() =>
  {
     var versionInfo = GitVersion(new GitVersionSettings()
    {
        UpdateAssemblyInfo = false
    });

    DotNetCoreBuild("./src/", new DotNetCoreBuildSettings{
        Configuration = configuration,
        ArgumentCustomization = args => args.Append($"--no-restore /p:Version={versionInfo.InformationalVersion}"),
    });
  });

Task("Publish")
    .Does(() =>
    {
        var versionInfo = GitVersion(new GitVersionSettings()
        {
            UpdateAssemblyInfo = true
        });

        Information($"Setting version to {versionInfo.InformationalVersion}");

        DotNetCorePublish("./Hackathon/Hackathon.csproj", new DotNetCorePublishSettings{
            Configuration = configuration,
            OutputDirectory = "./dist/",
            Runtime = "linux-x64",
            SelfContained = true,
            WorkingDirectory = "./src",
            VersionSuffix = versionInfo.Sha,
            ArgumentCustomization = args => args.Append($"/p:Version={versionInfo.InformationalVersion}"),
        });
    });

Task("Test")
    .Does(() =>
    {
        var projects = GetFiles("./src/**/*Test.csproj");
        foreach(var project in projects)
        {
            Information("Testing project " + project);
            DotNetCoreTest(
                project.ToString(),
                new DotNetCoreTestSettings()
                {
                    Configuration = configuration,
                    NoBuild = true,
                    ArgumentCustomization = args => args.Append("--no-restore"),
                });
        }
    });

Task("Default")
    .IsDependentOn("Clean")
    .IsDependentOn("Restore")
    .IsDependentOn("Build")
    .IsDependentOn("Test");

RunTarget(target);