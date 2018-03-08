function JoinUri {

    [CmdletBinding()]

    [OutputType("Uri")]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Uri,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [uri]
        $ChildUri

    )

    begin {

        

    } # end block 'begin'

    process {

        try {

            Write-Output ([uri] ($Uri.OriginalString + "/" + $ChildUri.OriginalString))

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'JoinUri'

function NewUrlEncodedString {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ValueFromRemainingArguments)]
        [ValidateNotNullOrEmpty()]
        [string]
        $String

    )

    begin {

        

    } # end block 'begin'

    process {

        try {

            Write-Output ([System.Web.HttpUtility]::UrlEncode($String))

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'NewUrlEncodedString'

function GetHttpErrorStatusCode {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ValueFromRemainingArguments)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.ErrorRecord]
        $HttpError

    )

    begin {

        

    } # end block 'begin'

    process {

        try {

            Write-Output ([int] $HttpError.Exception.Response.StatusCode)

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'GetHttpErrorStatusCode'