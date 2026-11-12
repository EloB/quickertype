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
    , ColorIdentity(..)
    , Watermark(..)
    , Layout(..)
    , LegalityEnum(..)
    , Rarity(..)
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { booster : List String
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

type alias Card =
    { artist : String
    , cardType : String
    , cmc : Int
    , colorIdentity : Maybe (List ColorIdentity)
    , colors : Maybe (List Watermark)
    , flavor : Maybe String
    , id : String
    , imageName : String
    , layout : Layout
    , legalities : List LegalityElement
    , manaCost : Maybe String
    , mciNumber : Maybe String
    , multiverseid : Int
    , name : String
    , originalText : String
    , originalType : String
    , power : Maybe String
    , printings : List String
    , rarity : Rarity
    , reserved : Maybe Bool
    , rulings : Maybe (List Ruling)
    , subtypes : Maybe (List String)
    , supertypes : Maybe (List String)
    , text : Maybe String
    , toughness : Maybe String
    , types : List Type
    , variations : Maybe (List Int)
    , watermark : Maybe Watermark
    }

type ColorIdentity
    = W
    | R
    | B
    | G
    | U

type Watermark
    = White
    | Red
    | Black
    | Green
    | Blue

type Layout
    = Normal

type alias LegalityElement =
    { format : String
    , legality : LegalityEnum
    }

type LegalityEnum
    = Legal
    | Banned
    | Restricted

type Rarity
    = Uncommon
    | Rare
    | Common
    | BasicLand

type alias Ruling =
    { date : String
    , text : String
    }

type Type
    = Creature
    | Artifact
    | Instant
    | Land
    | Enchantment
    | Sorcery

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
        |> Jpipe.required "booster" (Jdec.list Jdec.string )
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
        [ ("booster", Jenc.list Jenc.string x.booster)
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

card : Jdec.Decoder Card
card =
    Jdec.succeed Card
        |> Jpipe.required "artist" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "cmc" Jdec.int
        |> Jpipe.custom (optionalField "colorIdentity" (Jdec.map Just (Jdec.list colorIdentity )) Nothing)
        |> Jpipe.custom (optionalField "colors" (Jdec.map Just (Jdec.list watermark )) Nothing)
        |> Jpipe.custom (optionalField "flavor" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "imageName" Jdec.string
        |> Jpipe.required "layout" layout
        |> Jpipe.required "legalities" (Jdec.list legalityElement )
        |> Jpipe.custom (optionalField "manaCost" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "mciNumber" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "multiverseid" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "originalText" Jdec.string
        |> Jpipe.required "originalType" Jdec.string
        |> Jpipe.custom (optionalField "power" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "printings" (Jdec.list Jdec.string )
        |> Jpipe.required "rarity" rarity
        |> Jpipe.custom (optionalField "reserved" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "rulings" (Jdec.map Just (Jdec.list ruling )) Nothing)
        |> Jpipe.custom (optionalField "subtypes" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "supertypes" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "text" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "toughness" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "types" (Jdec.list purpleType )
        |> Jpipe.custom (optionalField "variations" (Jdec.map Just (Jdec.list Jdec.int )) Nothing)
        |> Jpipe.custom (optionalField "watermark" (Jdec.map Just watermark) Nothing)

encodeCard : Card -> Jenc.Value
encodeCard x =
    Jenc.object
        [ ("artist", Jenc.string x.artist)
        , ("type", Jenc.string x.cardType)
        , ("cmc", Jenc.int x.cmc)
        , ("colorIdentity", makeNullableEncoder (Jenc.list encodeColorIdentity) x.colorIdentity)
        , ("colors", makeNullableEncoder (Jenc.list encodeWatermark) x.colors)
        , ("flavor", makeNullableEncoder Jenc.string x.flavor)
        , ("id", Jenc.string x.id)
        , ("imageName", Jenc.string x.imageName)
        , ("layout", encodeLayout x.layout)
        , ("legalities", Jenc.list encodeLegalityElement x.legalities)
        , ("manaCost", makeNullableEncoder Jenc.string x.manaCost)
        , ("mciNumber", makeNullableEncoder Jenc.string x.mciNumber)
        , ("multiverseid", Jenc.int x.multiverseid)
        , ("name", Jenc.string x.name)
        , ("originalText", Jenc.string x.originalText)
        , ("originalType", Jenc.string x.originalType)
        , ("power", makeNullableEncoder Jenc.string x.power)
        , ("printings", Jenc.list Jenc.string x.printings)
        , ("rarity", encodeRarity x.rarity)
        , ("reserved", makeNullableEncoder Jenc.bool x.reserved)
        , ("rulings", makeNullableEncoder (Jenc.list encodeRuling) x.rulings)
        , ("subtypes", makeNullableEncoder (Jenc.list Jenc.string) x.subtypes)
        , ("supertypes", makeNullableEncoder (Jenc.list Jenc.string) x.supertypes)
        , ("text", makeNullableEncoder Jenc.string x.text)
        , ("toughness", makeNullableEncoder Jenc.string x.toughness)
        , ("types", Jenc.list encodeType x.types)
        , ("variations", makeNullableEncoder (Jenc.list Jenc.int) x.variations)
        , ("watermark", makeNullableEncoder encodeWatermark x.watermark)
        ]

colorIdentity : Jdec.Decoder ColorIdentity
colorIdentity =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "W" -> Jdec.succeed W
                "R" -> Jdec.succeed R
                "B" -> Jdec.succeed B
                "G" -> Jdec.succeed G
                "U" -> Jdec.succeed U
                somethingElse -> Jdec.fail <| "Invalid ColorIdentity: " ++ somethingElse
        )

encodeColorIdentity : ColorIdentity -> Jenc.Value
encodeColorIdentity x = case x of
    W -> Jenc.string "W"
    R -> Jenc.string "R"
    B -> Jenc.string "B"
    G -> Jenc.string "G"
    U -> Jenc.string "U"

watermark : Jdec.Decoder Watermark
watermark =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "White" -> Jdec.succeed White
                "Red" -> Jdec.succeed Red
                "Black" -> Jdec.succeed Black
                "Green" -> Jdec.succeed Green
                "Blue" -> Jdec.succeed Blue
                somethingElse -> Jdec.fail <| "Invalid Watermark: " ++ somethingElse
        )

encodeWatermark : Watermark -> Jenc.Value
encodeWatermark x = case x of
    White -> Jenc.string "White"
    Red -> Jenc.string "Red"
    Black -> Jenc.string "Black"
    Green -> Jenc.string "Green"
    Blue -> Jenc.string "Blue"

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
        |> Jpipe.required "format" Jdec.string
        |> Jpipe.required "legality" legalityEnum

encodeLegalityElement : LegalityElement -> Jenc.Value
encodeLegalityElement x =
    Jenc.object
        [ ("format", Jenc.string x.format)
        , ("legality", encodeLegalityEnum x.legality)
        ]

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
                "Uncommon" -> Jdec.succeed Uncommon
                "Rare" -> Jdec.succeed Rare
                "Common" -> Jdec.succeed Common
                "Basic Land" -> Jdec.succeed BasicLand
                somethingElse -> Jdec.fail <| "Invalid Rarity: " ++ somethingElse
        )

encodeRarity : Rarity -> Jenc.Value
encodeRarity x = case x of
    Uncommon -> Jenc.string "Uncommon"
    Rare -> Jenc.string "Rare"
    Common -> Jenc.string "Common"
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

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Creature" -> Jdec.succeed Creature
                "Artifact" -> Jdec.succeed Artifact
                "Instant" -> Jdec.succeed Instant
                "Land" -> Jdec.succeed Land
                "Enchantment" -> Jdec.succeed Enchantment
                "Sorcery" -> Jdec.succeed Sorcery
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Creature -> Jenc.string "Creature"
    Artifact -> Jenc.string "Artifact"
    Instant -> Jenc.string "Instant"
    Land -> Jenc.string "Land"
    Enchantment -> Jenc.string "Enchantment"
    Sorcery -> Jenc.string "Sorcery"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
