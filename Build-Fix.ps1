$ErrorActionPreference = "Stop"

$version = "3.1.2-yinspect.3"
$output = Join-Path $PWD "artifacts\nuget"

$projects = @(
    "Source\HelixToolkit\HelixToolkit.csproj",
    "Source\HelixToolkit.Maths\HelixToolkit.Maths.csproj",
    "Source\HelixToolkit.Geometry\HelixToolkit.Geometry.csproj",
    "Source\HelixToolkit.SharpDX\HelixToolkit.SharpDX.csproj",
    "Source\HelixToolkit.Wpf.SharpDX\HelixToolkit.Wpf.SharpDX.csproj"
)

New-Item -ItemType Directory -Force -Path $output | Out-Null

foreach ($project in $projects) {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Packing: $project" -ForegroundColor Cyan
    Write-Host "Version: $version" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan

    dotnet pack $project `
        -c Release `
        -o $output `
        "-p:Version=$version"

    if ($LASTEXITCODE -ne 0) {
        throw "NuGet packaging failed: $project"
    }
}

Write-Host "`nAll packages generated successfully!" -ForegroundColor Green