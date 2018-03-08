class MTGCard {

    # public properties; gameplay properties

    [string] $Name
    [string] $Type
    [string] $ManaCost
    [decimal] $ConvertedManaCost
    [string] $OracleText
    [string] $Power
    [string] $Toughness
    [string] $Loyalty
    [string] $Color
    [string] $ColorIdentity

    # probably not props for default format
    [guid] $ScryfallId
    [guid] $OracleId
    [array] $MultiverseIds
    [int32] $MTGOId
    [uri] $ScryfallUri
    [uri] $ScryfallPermapageUri
    [uri] $PrintsSearchUri
    [uri] $RulingsUri


    # constructor

    MTGCard () {}

    OpenScryfallPage () {

        Start-Process microsoft-edge:$($this.ScryfallPermapageUri.OriginalString)

    }

}