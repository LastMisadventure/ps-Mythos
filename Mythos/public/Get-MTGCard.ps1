<#
.SYNOPSIS
Gets card data from the Scryfall API by name. This command will only return 1 card. Ambigious matches are treated as errors.

For searching cards with specific data, use the cmdlet 'Search-MTGCard' instead. Typically, you'll want to use 'Search-MTGCard' unless you enjoy pain.

.DESCRIPTION
Gets card data from the Scryfall API by name.

.PARAMETER Name
A complete or partial name of the card.

.PARAMETER FuzzyMode
Used when you want to submit a non-exact card name. Case, punctuation, and card name completeness are not required.

.PARAMETER ExactMode
Used when you want to submit an exact card name. Case and punctuation is still ignored for this mode.

.EXAMPLE
Get-MTGCard -Name Forest -ExactMode

Exact Searching. Returns the basic land 'Forest'.

.EXAMPLE

Get-MTGCard -Name "aust com" -FuzzyMode

Fuzzy Searching. Returns the card "Austere Command".

.NOTES
General notes
#>
function Get-MTGCard {

    [CmdletBinding(DefaultParameterSetName = "PSParamSet_SearchModeFuzzy")]

    [OutputType("MTGCard")]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = "PSParamSet_SearchModeFuzzy")]
        [ValidateNotNullOrEmpty()]
        [switch]
        $FuzzyMode,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = "PSParamSet_SearchModeExact")]
        [ValidateNotNullOrEmpty()]
        [switch]
        $ExactMode

    )

    begin {
        
    } # end block 'begin'

    process {
        
        # this function is responsible for 

        try {

            # build out query string

            [string] $str_SearchQuery = "named?"
            
            switch ($PSCmdlet.ParameterSetName) {

                "PSParamSet_SearchModeFuzzy" { 
                    
                    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Search operating in '$($PSCmdlet.ParameterSetName)'."
                    
                    $str_SearchQuery = $str_SearchQuery + "fuzzy=" 
                }

                "PSParamSet_SearchModeExact" { 
                    
                    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Search operating in '$($PSCmdlet.ParameterSetName)'."
                    
                    $str_SearchQuery = $str_SearchQuery + "exact=" 
                }

            }

            if ($PSBoundParameters.ContainsKey("Name")) {

                $str_URLEncodedCardName = NewUrlEncodedString -String $Name

                $str_SearchQuery = $str_SearchQuery + "$str_URLEncodedCardName"

            }

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Assembled search query string '$($str_SearchQuery)'."

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Name): Getting card from API."
            
            try {

                $obj_JsonResult = SubmitApiRequest -ErrorAction Stop -Method Get -Resource cards -Request $str_SearchQuery
                
            }

            catch {

                Write-Error -Message $_ -ErrorAction Continue

                return
                
            }

            foreach ($mtgCard in $obj_JsonResult) {

                $mtgCard | NewCardObject

            } # end foreach mtgCard

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'Get-OMTMTGCard'