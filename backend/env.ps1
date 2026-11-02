$jdkHome = $env:FITGRESS_JDK_HOME
if (-not $jdkHome) {
    $envFile = Join-Path $PSScriptRoot '..\.env'
    if (Test-Path $envFile) {
        foreach ($line in Get-Content $envFile) {
            if ($line -match '^\s*FITGRESS_JDK_HOME\s*=\s*(.*?)\s*$') {
                $jdkHome = $Matches[1]
                if ($jdkHome.Length -ge 2 -and
                    (($jdkHome.StartsWith('"') -and $jdkHome.EndsWith('"')) -or
                     ($jdkHome.StartsWith("'") -and $jdkHome.EndsWith("'")))) {
                    $jdkHome = $jdkHome.Substring(1, $jdkHome.Length - 2)
                }
                break
            }
        }
    }
}

if (-not $jdkHome) {
    Write-Error 'FITGRESS_JDK_HOME is not set. Add your JDK 25 path to FITGRESS_JDK_HOME in the repository .env file, or set it in this terminal.'
    return
}
if (-not (Test-Path (Join-Path $jdkHome 'bin\java.exe'))) {
    Write-Error "No JDK found at FITGRESS_JDK_HOME ($jdkHome)."
    return
}

$env:JAVA_HOME = $jdkHome
$env:Path = "$(Join-Path $jdkHome 'bin');$env:Path"
Write-Host "Using JDK at $jdkHome"
