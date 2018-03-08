Set-StrictMode -Version Latest

$class = @(Get-ChildItem -File -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'class') -ErrorAction SilentlyContinue)
$Public = @(Get-ChildItem -File -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public') -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -File -Filter *.ps1 -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private') -Recurse -ErrorAction SilentlyContinue)

foreach ($function in @($Class + $Public + $Private)) {

    try {

        . $function.Fullname

    }

    catch {

        Write-Error -ErrorAction Stop -Message "Failed to import function '$($function.fullname)': $_"
    }
}

try {
    
    Add-Type -AssemblyName System.Web -ErrorAction Stop

    # load config
    ConfigController -Mode Import -ErrorAction Stop

}

catch {

    Write-Error -Exception $_.Exception
    
}