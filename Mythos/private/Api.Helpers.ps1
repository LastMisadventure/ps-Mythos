# instantiates a new card object
function NewCardObject {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ValueFromRemainingArguments)]
        [ValidateNotNullOrEmpty()]
        [object]
        $CardInput

    )

    begin {

        Set-StrictMode -Off

    } # end block 'begin'

    process {

        try {

            $currentCard = New-Object -ErrorAction Stop -TypeName MTGCard

            $currentCard.Name = $CardInput.Name
            $currentCard.Type = $CardInput.type_line
            $currentCard.ManaCost = $CardInput.mana_cost
            $currentCard.ConvertedManaCost = $CardInput.cmc
            $currentCard.Color = $CardInput.colors
            $currentCard.ColorIdentity = $CardInput.color_identity
            $currentCard.Power = $CardInput.power
            $currentCard.Toughness = $CardInput.Toughness
            $currentCard.OracleText = $CardInput.oracle_text
            $currentCard.ScryfallId = $CardInput.id
            $currentCard.OracleId = $CardInput.oracle_id
            $currentCard.MultiverseIds = $CardInput.multiverse_ids
            $currentCard.MTGOId = $CardInput.mtgo_id
            $currentCard.ScryfallUri = $CardInput.uri 
            $currentCard.ScryfallPermapageUri = $CardInput.scryfall_uri
            $currentCard.PrintsSearchUri = $currentCard.prints_search_uri
            $currentCard.RulingsUri = $currentCard.rulings_uri

            Write-Output $currentCard

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        Set-StrictMode -Version Latest

    } # end block 'end'

    # instantiates a new card object
} # end function 'NewCardObject'

# knows how to 
function SubmitApiRequest {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('cards', 'named')]
        [string]
        $Resource,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Request,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Method

    )

    begin {

        

    } # end block 'begin'

    process {

        try {

            [uri] $uri_PlatformUri = $M_MythosConfig.Data.Api.PlatformUri

            [uri] $uri_RequestUri = JoinUri -Uri $uri_PlatformUri -ChildUri ($Resource + "/" + $Request)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Assembled API request: Perform a '$($Method)' on Uri '$($uri_RequestUri)'."

            Write-Output (Invoke-RestMethod -Method $Method -Uri $uri_RequestUri -ErrorAction Stop)

        } # end outer try

        catch {

            if (404 -eq ([int] $_.Exception.Response.StatusCode)) {

                Write-Error -ErrorAction Stop -Message "[$($MyInvocation.MyCommand.Name)]: API returned '404, not found'. If this was a request for a card, it probably means no such card exists. Sorry."
            }

            else {

                $_

            }

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'SubmitApiRequest'