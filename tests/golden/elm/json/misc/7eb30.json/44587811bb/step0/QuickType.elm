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
    , Result
    , Group
    , Code(..)
    , English(..)
    , Thai(..)
    , LocationEnum(..)
    , TelEnum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { count : Int
    , next : String
    , previous : ()
    , results : List Result
    }

type alias Result =
    { code : String
    , english : String
    , fav : Bool
    , group : Group
    , location : LocationEnum
    , minScreens : Int
    , numViews : Int
    , showtimes : String
    , stars : Int
    , tel : TelEnum
    , thai : String
    , todayScreens : Int
    , url : String
    , website : String
    }

type alias Group =
    { code : Code
    , english : English
    , thai : Thai
    , website : String
    }

type Code
    = Sf

type English
    = EnglishSF

type Thai
    = Empty

type LocationEnum
    = Location
    | The5ThFLEmporium

type TelEnum
    = Tel
    | The022688899

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
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "next" Jdec.string
        |> Jpipe.required "previous" (Jdec.null ())
        |> Jpipe.required "results" (Jdec.list result )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("next", Jenc.string x.next)
        , ("previous", always Jenc.null x.previous)
        , ("results", Jenc.list encodeResult x.results)
        ]

result : Jdec.Decoder Result
result =
    Jdec.succeed Result
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "english" Jdec.string
        |> Jpipe.required "fav" Jdec.bool
        |> Jpipe.required "group" group
        |> Jpipe.required "location" locationEnum
        |> Jpipe.required "min_screens" Jdec.int
        |> Jpipe.required "num_views" Jdec.int
        |> Jpipe.required "showtimes" Jdec.string
        |> Jpipe.required "stars" Jdec.int
        |> Jpipe.required "tel" telEnum
        |> Jpipe.required "thai" Jdec.string
        |> Jpipe.required "today_screens" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "website" Jdec.string

encodeResult : Result -> Jenc.Value
encodeResult x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("english", Jenc.string x.english)
        , ("fav", Jenc.bool x.fav)
        , ("group", encodeGroup x.group)
        , ("location", encodeLocationEnum x.location)
        , ("min_screens", Jenc.int x.minScreens)
        , ("num_views", Jenc.int x.numViews)
        , ("showtimes", Jenc.string x.showtimes)
        , ("stars", Jenc.int x.stars)
        , ("tel", encodeTelEnum x.tel)
        , ("thai", Jenc.string x.thai)
        , ("today_screens", Jenc.int x.todayScreens)
        , ("url", Jenc.string x.url)
        , ("website", Jenc.string x.website)
        ]

group : Jdec.Decoder Group
group =
    Jdec.succeed Group
        |> Jpipe.required "code" code
        |> Jpipe.required "english" english
        |> Jpipe.required "thai" thai
        |> Jpipe.required "website" Jdec.string

encodeGroup : Group -> Jenc.Value
encodeGroup x =
    Jenc.object
        [ ("code", encodeCode x.code)
        , ("english", encodeEnglish x.english)
        , ("thai", encodeThai x.thai)
        , ("website", Jenc.string x.website)
        ]

code : Jdec.Decoder Code
code =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "sf" -> Jdec.succeed Sf
                somethingElse -> Jdec.fail <| "Invalid Code: " ++ somethingElse
        )

encodeCode : Code -> Jenc.Value
encodeCode x = case x of
    Sf -> Jenc.string "sf"

english : Jdec.Decoder English
english =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "SF" -> Jdec.succeed EnglishSF
                somethingElse -> Jdec.fail <| "Invalid English: " ++ somethingElse
        )

encodeEnglish : English -> Jenc.Value
encodeEnglish x = case x of
    EnglishSF -> Jenc.string "SF"

thai : Jdec.Decoder Thai
thai =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "เอสเอฟ" -> Jdec.succeed Empty
                somethingElse -> Jdec.fail <| "Invalid Thai: " ++ somethingElse
        )

encodeThai : Thai -> Jenc.Value
encodeThai x = case x of
    Empty -> Jenc.string "เอสเอฟ"

locationEnum : Jdec.Decoder LocationEnum
locationEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Location
                "5th Fl. Emporium" -> Jdec.succeed The5ThFLEmporium
                somethingElse -> Jdec.fail <| "Invalid LocationEnum: " ++ somethingElse
        )

encodeLocationEnum : LocationEnum -> Jenc.Value
encodeLocationEnum x = case x of
    Location -> Jenc.string ""
    The5ThFLEmporium -> Jenc.string "5th Fl. Emporium"

telEnum : Jdec.Decoder TelEnum
telEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "" -> Jdec.succeed Tel
                "02-268-8899" -> Jdec.succeed The022688899
                somethingElse -> Jdec.fail <| "Invalid TelEnum: " ++ somethingElse
        )

encodeTelEnum : TelEnum -> Jenc.Value
encodeTelEnum x = case x of
    Tel -> Jenc.string ""
    The022688899 -> Jenc.string "02-268-8899"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
