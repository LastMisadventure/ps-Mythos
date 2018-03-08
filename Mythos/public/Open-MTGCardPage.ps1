function Open-MTGCardPage {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ValueFromRemainingArguments)]
        [ValidateNotNullOrEmpty()]
        [MTGCard]
        $CardObject

    )

    begin {

        

    } # end block 'begin'

    process {

        try {

            $CardObject.OpenScryfallPage()

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'Open-MTGCardPage'