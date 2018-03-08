
function Search-MTGCard {

    [CmdletBinding()]

    [OutputType("MTGCard")]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Creature', 'Land', 'Artifact', 'Enchantment', 'Planeswalker')]
        [string[]]
        $Type,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [Alias('CMC')]
        [decimal]
        $ConvertedManaCost

    )

    begin {
        
    } # end block 'begin'

    process {
        
        # this function is responsible for 

        try {

            # build search query

            [string] $str_SearchQuery = "search?q="

            if ($PSBoundParameters.ContainsKey("Name")) {

                $str_URLEncodedCardName = NewUrlEncodedString -String $Name

                $str_SearchQuery = $str_SearchQuery + "name=$str_URLEncodedCardName"

            }

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Name): Getting card from API."
            
            try {

                $obj_JsonResult = SubmitApiRequest -ErrorAction Stop -Method Get -Resource cards -Request $str_SearchQuery
                
            }

            catch {

                Write-Error -Message $_ -ErrorAction Continue

                return
                
            }

            foreach ($mtgCard in $obj_JsonResult.data) {

                $mtgCard | NewCardObject

            } # end foreach mtgCard

        } # end outer try

        catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        } # end outer catch

    } # end block 'process'

    end {

        

    } # end block 'end'

} # end function 'Search-MTGCard'