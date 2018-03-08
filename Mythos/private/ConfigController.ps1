function ConfigController {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory)]
        [string]
        $Mode

    )

    switch ($Mode) {

        # loads configuration from file
        Import {

            New-Variable -Name OMTConfiguration -Scope Script -Value $Null -Force

            try {

                $configFilePath = (Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -ChildPath 'Mythos.config')
                [XML] $Script:M_MythosConfig = Get-Content -ErrorAction Stop -Path $configFilePath

            }

            catch {

                Write-Error -Message "Unable to locate configuration file at $($configFilePath.FullName). Please follow the instructions in example config file contained in this module's root directory."
                Write-Error -ErrorAction Stop -Message $_.Exception.Message
            }

        }

        Default {}
    }
}