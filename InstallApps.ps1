$chocolateyAppList = "googlechrome,7zip,dotnetcore-sdk"
$dismAppList = ""

Invoke-Expression "RunChoco.ps1 ""$chocolateyAppList"" ""$dismAppList"""