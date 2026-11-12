-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , Card
    , LegalityElement
    , Ruling
    , Booster(..)
    , ColorIdentity(..)
    , Color(..)
    , Layout(..)
    , Format(..)
    , LegalityEnum(..)
    , Rarity(..)
    , Supertype(..)
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { booster : List Booster
    , border : String
    , cards : List Card
    , code : String
    , gathererCode : String
    , magicCardsInfoCode : String
    , mkmID : Int
    , mkmName : String
    , name : String
    , quickTypeType : String
    , releaseDate : String
    }

type Booster
    = Rare
    | Uncommon
    | Common

type alias Card =
    { artist : String
    , cardType : String
    , cmc : Int
    , colorIdentity : Maybe (List ColorIdentity)
    , colors : Maybe (List Color)
    , flavor : Maybe String
    , id : String
    , imageName : String
    , layout : Layout
    , legalities : List LegalityElement
    , manaCost : Maybe String
    , mciNumber : Maybe String
    , multiverseid : Int
    , name : String
    , originalText : Maybe String
    , originalType : String
    , power : Maybe String
    , printings : List String
    , rarity : Rarity
    , reserved : Maybe Bool
    , rulings : Maybe (List Ruling)
    , subtypes : Maybe (List String)
    , supertypes : Maybe (List Supertype)
    , text : Maybe String
    , toughness : Maybe String
    , types : List Type
    , variations : Maybe (List Int)
    }

type ColorIdentity
    = U
    | B
    | W
    | G
    | R

type Color
    = Blue
    | Black
    | White
    | Green
    | Red

type Layout
    = Normal

type alias LegalityElement =
    { format : Format
    , legality : LegalityEnum
    }

type Format
    = Commander
    | Legacy
    | Modern
    | Vintage
    | TimeSpiralBlock
    | RavnicaBlock
    | IceAgeBlock
    | TempestBlock
    | OnslaughtBlock
    | MasquesBlock
    | MirageBlock
    | UrzaBlock
    | ScarsOfMirrodinBlock
    | MirrodinBlock
    | AmonkhetBlock
    | BattleForZendikarBlock
    | InnistradBlock
    | InvasionBlock
    | KaladeshBlock
    | KamigawaBlock
    | KhansOfTarkirBlock
    | LorwynShadowmoorBlock
    | OdysseyBlock
    | ReturnToRavnicaBlock
    | ShadowsOverInnistradBlock
    | ShardsOfAlaraBlock
    | Standard
    | TherosBlock
    | UnSets
    | ZendikarBlock

type LegalityEnum
    = Legal
    | Banned
    | Restricted

type Rarity
    = RarityUncommon
    | RarityRare
    | RarityCommon
    | BasicLand

type alias Ruling =
    { date : String
    , text : String
    }

type Supertype
    = Basic

type Type
    = Creature
    | Instant
    | Enchantment
    | Artifact
    | Sorcery
    | Land

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "booster" (Jdec.list booster )
        |> Jpipe.required "border" Jdec.string
        |> Jpipe.required "cards" (Jdec.list card )
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "gathererCode" Jdec.string
        |> Jpipe.required "magicCardsInfoCode" Jdec.string
        |> Jpipe.required "mkm_id" Jdec.int
        |> Jpipe.required "mkm_name" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "releaseDate" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("booster", Jenc.list encodeBooster x.booster)
        , ("border", Jenc.string x.border)
        , ("cards", Jenc.list encodeCard x.cards)
        , ("code", Jenc.string x.code)
        , ("gathererCode", Jenc.string x.gathererCode)
        , ("magicCardsInfoCode", Jenc.string x.magicCardsInfoCode)
        , ("mkm_id", Jenc.int x.mkmID)
        , ("mkm_name", Jenc.string x.mkmName)
        , ("name", Jenc.string x.name)
        , ("type", Jenc.string x.quickTypeType)
        , ("releaseDate", Jenc.string x.releaseDate)
        ]

booster : Jdec.Decoder Booster
booster =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "rare" -> Jdec.succeed Rare
                "uncommon" -> Jdec.succeed Uncommon
                "common" -> Jdec.succeed Common
                somethingElse -> Jdec.fail <| "Invalid Booster: " ++ somethingElse
        )

encodeBooster : Booster -> Jenc.Value
encodeBooster x = case x of
    Rare -> Jenc.string "rare"
    Uncommon -> Jenc.string "uncommon"
    Common -> Jenc.string "common"

card : Jdec.Decoder Card
card =
    Jdec.succeed Card
        |> Jpipe.required "artist" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "cmc" Jdec.int
        |> Jpipe.custom (optionalField "colorIdentity" (Jdec.map Just (Jdec.list colorIdentity )) Nothing)
        |> Jpipe.custom (optionalField "colors" (Jdec.map Just (Jdec.list color )) Nothing)
        |> Jpipe.custom (optionalField "flavor" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "imageName" Jdec.string
        |> Jpipe.required "layout" layout
        |> Jpipe.required "legalities" (Jdec.list legalityElement )
        |> Jpipe.custom (optionalField "manaCost" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "mciNumber" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "multiverseid" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.custom (optionalField "originalText" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "originalType" Jdec.string
        |> Jpipe.custom (optionalField "power" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "printings" (Jdec.list Jdec.string )
        |> Jpipe.required "rarity" rarity
        |> Jpipe.custom (optionalField "reserved" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "rulings" (Jdec.map Just (Jdec.list ruling )) Nothing)
        |> Jpipe.custom (optionalField "subtypes" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "supertypes" (Jdec.map Just (Jdec.list supertype )) Nothing)
        |> Jpipe.custom (optionalField "text" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "toughness" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "types" (Jdec.list purpleType )
        |> Jpipe.custom (optionalField "variations" (Jdec.map Just (Jdec.list Jdec.int )) Nothing)

encodeCard : Card -> Jenc.Value
encodeCard x =
    Jenc.object
        [ ("artist", Jenc.string x.artist)
        , ("type", Jenc.string x.cardType)
        , ("cmc", Jenc.int x.cmc)
        , ("colorIdentity", makeNullableEncoder (Jenc.list encodeColorIdentity) x.colorIdentity)
        , ("colors", makeNullableEncoder (Jenc.list encodeColor) x.colors)
        , ("flavor", makeNullableEncoder Jenc.string x.flavor)
        , ("id", Jenc.string x.id)
        , ("imageName", Jenc.string x.imageName)
        , ("layout", encodeLayout x.layout)
        , ("legalities", Jenc.list encodeLegalityElement x.legalities)
        , ("manaCost", makeNullableEncoder Jenc.string x.manaCost)
        , ("mciNumber", makeNullableEncoder Jenc.string x.mciNumber)
        , ("multiverseid", Jenc.int x.multiverseid)
        , ("name", Jenc.string x.name)
        , ("originalText", makeNullableEncoder Jenc.string x.originalText)
        , ("originalType", Jenc.string x.originalType)
        , ("power", makeNullableEncoder Jenc.string x.power)
        , ("printings", Jenc.list Jenc.string x.printings)
        , ("rarity", encodeRarity x.rarity)
        , ("reserved", makeNullableEncoder Jenc.bool x.reserved)
        , ("rulings", makeNullableEncoder (Jenc.list encodeRuling) x.rulings)
        , ("subtypes", makeNullableEncoder (Jenc.list Jenc.string) x.subtypes)
        , ("supertypes", makeNullableEncoder (Jenc.list encodeSupertype) x.supertypes)
        , ("text", makeNullableEncoder Jenc.string x.text)
        , ("toughness", makeNullableEncoder Jenc.string x.toughness)
        , ("types", Jenc.list encodeType x.types)
        , ("variations", makeNullableEncoder (Jenc.list Jenc.int) x.variations)
        ]

colorIdentity : Jdec.Decoder ColorIdentity
colorIdentity =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "U" -> Jdec.succeed U
                "B" -> Jdec.succeed B
                "W" -> Jdec.succeed W
                "G" -> Jdec.succeed G
                "R" -> Jdec.succeed R
                somethingElse -> Jdec.fail <| "Invalid ColorIdentity: " ++ somethingElse
        )

encodeColorIdentity : ColorIdentity -> Jenc.Value
encodeColorIdentity x = case x of
    U -> Jenc.string "U"
    B -> Jenc.string "B"
    W -> Jenc.string "W"
    G -> Jenc.string "G"
    R -> Jenc.string "R"

color : Jdec.Decoder Color
color =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Blue" -> Jdec.succeed Blue
                "Black" -> Jdec.succeed Black
                "White" -> Jdec.succeed White
                "Green" -> Jdec.succeed Green
                "Red" -> Jdec.succeed Red
                somethingElse -> Jdec.fail <| "Invalid Color: " ++ somethingElse
        )

encodeColor : Color -> Jenc.Value
encodeColor x = case x of
    Blue -> Jenc.string "Blue"
    Black -> Jenc.string "Black"
    White -> Jenc.string "White"
    Green -> Jenc.string "Green"
    Red -> Jenc.string "Red"

layout : Jdec.Decoder Layout
layout =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "normal" -> Jdec.succeed Normal
                somethingElse -> Jdec.fail <| "Invalid Layout: " ++ somethingElse
        )

encodeLayout : Layout -> Jenc.Value
encodeLayout x = case x of
    Normal -> Jenc.string "normal"

legalityElement : Jdec.Decoder LegalityElement
legalityElement =
    Jdec.succeed LegalityElement
        |> Jpipe.required "format" format
        |> Jpipe.required "legality" legalityEnum

encodeLegalityElement : LegalityElement -> Jenc.Value
encodeLegalityElement x =
    Jenc.object
        [ ("format", encodeFormat x.format)
        , ("legality", encodeLegalityEnum x.legality)
        ]

format : Jdec.Decoder Format
format =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Commander" -> Jdec.succeed Commander
                "Legacy" -> Jdec.succeed Legacy
                "Modern" -> Jdec.succeed Modern
                "Vintage" -> Jdec.succeed Vintage
                "Time Spiral Block" -> Jdec.succeed TimeSpiralBlock
                "Ravnica Block" -> Jdec.succeed RavnicaBlock
                "Ice Age Block" -> Jdec.succeed IceAgeBlock
                "Tempest Block" -> Jdec.succeed TempestBlock
                "Onslaught Block" -> Jdec.succeed OnslaughtBlock
                "Masques Block" -> Jdec.succeed MasquesBlock
                "Mirage Block" -> Jdec.succeed MirageBlock
                "Urza Block" -> Jdec.succeed UrzaBlock
                "Scars of Mirrodin Block" -> Jdec.succeed ScarsOfMirrodinBlock
                "Mirrodin Block" -> Jdec.succeed MirrodinBlock
                "Amonkhet Block" -> Jdec.succeed AmonkhetBlock
                "Battle for Zendikar Block" -> Jdec.succeed BattleForZendikarBlock
                "Innistrad Block" -> Jdec.succeed InnistradBlock
                "Invasion Block" -> Jdec.succeed InvasionBlock
                "Kaladesh Block" -> Jdec.succeed KaladeshBlock
                "Kamigawa Block" -> Jdec.succeed KamigawaBlock
                "Khans of Tarkir Block" -> Jdec.succeed KhansOfTarkirBlock
                "Lorwyn-Shadowmoor Block" -> Jdec.succeed LorwynShadowmoorBlock
                "Odyssey Block" -> Jdec.succeed OdysseyBlock
                "Return to Ravnica Block" -> Jdec.succeed ReturnToRavnicaBlock
                "Shadows over Innistrad Block" -> Jdec.succeed ShadowsOverInnistradBlock
                "Shards of Alara Block" -> Jdec.succeed ShardsOfAlaraBlock
                "Standard" -> Jdec.succeed Standard
                "Theros Block" -> Jdec.succeed TherosBlock
                "Un-Sets" -> Jdec.succeed UnSets
                "Zendikar Block" -> Jdec.succeed ZendikarBlock
                somethingElse -> Jdec.fail <| "Invalid Format: " ++ somethingElse
        )

encodeFormat : Format -> Jenc.Value
encodeFormat x = case x of
    Commander -> Jenc.string "Commander"
    Legacy -> Jenc.string "Legacy"
    Modern -> Jenc.string "Modern"
    Vintage -> Jenc.string "Vintage"
    TimeSpiralBlock -> Jenc.string "Time Spiral Block"
    RavnicaBlock -> Jenc.string "Ravnica Block"
    IceAgeBlock -> Jenc.string "Ice Age Block"
    TempestBlock -> Jenc.string "Tempest Block"
    OnslaughtBlock -> Jenc.string "Onslaught Block"
    MasquesBlock -> Jenc.string "Masques Block"
    MirageBlock -> Jenc.string "Mirage Block"
    UrzaBlock -> Jenc.string "Urza Block"
    ScarsOfMirrodinBlock -> Jenc.string "Scars of Mirrodin Block"
    MirrodinBlock -> Jenc.string "Mirrodin Block"
    AmonkhetBlock -> Jenc.string "Amonkhet Block"
    BattleForZendikarBlock -> Jenc.string "Battle for Zendikar Block"
    InnistradBlock -> Jenc.string "Innistrad Block"
    InvasionBlock -> Jenc.string "Invasion Block"
    KaladeshBlock -> Jenc.string "Kaladesh Block"
    KamigawaBlock -> Jenc.string "Kamigawa Block"
    KhansOfTarkirBlock -> Jenc.string "Khans of Tarkir Block"
    LorwynShadowmoorBlock -> Jenc.string "Lorwyn-Shadowmoor Block"
    OdysseyBlock -> Jenc.string "Odyssey Block"
    ReturnToRavnicaBlock -> Jenc.string "Return to Ravnica Block"
    ShadowsOverInnistradBlock -> Jenc.string "Shadows over Innistrad Block"
    ShardsOfAlaraBlock -> Jenc.string "Shards of Alara Block"
    Standard -> Jenc.string "Standard"
    TherosBlock -> Jenc.string "Theros Block"
    UnSets -> Jenc.string "Un-Sets"
    ZendikarBlock -> Jenc.string "Zendikar Block"

legalityEnum : Jdec.Decoder LegalityEnum
legalityEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Legal" -> Jdec.succeed Legal
                "Banned" -> Jdec.succeed Banned
                "Restricted" -> Jdec.succeed Restricted
                somethingElse -> Jdec.fail <| "Invalid LegalityEnum: " ++ somethingElse
        )

encodeLegalityEnum : LegalityEnum -> Jenc.Value
encodeLegalityEnum x = case x of
    Legal -> Jenc.string "Legal"
    Banned -> Jenc.string "Banned"
    Restricted -> Jenc.string "Restricted"

rarity : Jdec.Decoder Rarity
rarity =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Uncommon" -> Jdec.succeed RarityUncommon
                "Rare" -> Jdec.succeed RarityRare
                "Common" -> Jdec.succeed RarityCommon
                "Basic Land" -> Jdec.succeed BasicLand
                somethingElse -> Jdec.fail <| "Invalid Rarity: " ++ somethingElse
        )

encodeRarity : Rarity -> Jenc.Value
encodeRarity x = case x of
    RarityUncommon -> Jenc.string "Uncommon"
    RarityRare -> Jenc.string "Rare"
    RarityCommon -> Jenc.string "Common"
    BasicLand -> Jenc.string "Basic Land"

ruling : Jdec.Decoder Ruling
ruling =
    Jdec.succeed Ruling
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "text" Jdec.string

encodeRuling : Ruling -> Jenc.Value
encodeRuling x =
    Jenc.object
        [ ("date", Jenc.string x.date)
        , ("text", Jenc.string x.text)
        ]

supertype : Jdec.Decoder Supertype
supertype =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Basic" -> Jdec.succeed Basic
                somethingElse -> Jdec.fail <| "Invalid Supertype: " ++ somethingElse
        )

encodeSupertype : Supertype -> Jenc.Value
encodeSupertype x = case x of
    Basic -> Jenc.string "Basic"

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Creature" -> Jdec.succeed Creature
                "Instant" -> Jdec.succeed Instant
                "Enchantment" -> Jdec.succeed Enchantment
                "Artifact" -> Jdec.succeed Artifact
                "Sorcery" -> Jdec.succeed Sorcery
                "Land" -> Jdec.succeed Land
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Creature -> Jenc.string "Creature"
    Instant -> Jenc.string "Instant"
    Enchantment -> Jenc.string "Enchantment"
    Artifact -> Jenc.string "Artifact"
    Sorcery -> Jenc.string "Sorcery"
    Land -> Jenc.string "Land"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
