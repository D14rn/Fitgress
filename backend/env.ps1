$jdkHome = $env:FITGRESS_JDK_HOME
if (-not $jdkHome) {
    Write-Error 'FITGRESS_JDK_HOME is not set. Run: setx FITGRESS_JDK_HOME "C:\path\to\jdk-25" then open a new terminal.'
    return
}
if (-not (Test-Path (Join-Path $jdkHome 'bin\java.exe'))) {
    Write-Error "No JDK found at FITGRESS_JDK_HOME ($jdkHome)."
    return
}

$env:JAVA_HOME = $jdkHome
$env:Path = "$(Join-Path $jdkHome 'bin');$env:Path"
Write-Host "Using JDK at $jdkHome"
