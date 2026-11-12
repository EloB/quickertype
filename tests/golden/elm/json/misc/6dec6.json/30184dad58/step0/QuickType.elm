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
    , Query
    , Results
    , Channel
    , Astronomy
    , Atmosphere
    , Image
    , Item
    , Condition
    , Forecast
    , GUID
    , Location
    , Units
    , Wind
    , Text(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { query : Query
    }

type alias Query =
    { count : Int
    , created : String
    , lang : String
    , results : Results
    }

type alias Results =
    { channel : Channel
    }

type alias Channel =
    { astronomy : Astronomy
    , atmosphere : Atmosphere
    , description : String
    , image : Image
    , item : Item
    , language : String
    , lastBuildDate : String
    , link : String
    , location : Location
    , title : String
    , ttl : String
    , units : Units
    , wind : Wind
    }

type alias Astronomy =
    { sunrise : String
    , sunset : String
    }

type alias Atmosphere =
    { humidity : String
    , pressure : String
    , rising : String
    , visibility : String
    }

type alias Image =
    { height : String
    , link : String
    , title : String
    , url : String
    , width : String
    }

type alias Item =
    { condition : Condition
    , description : String
    , forecast : List Forecast
    , guid : GUID
    , lat : String
    , link : String
    , long : String
    , pubDate : String
    , title : String
    }

type alias Condition =
    { code : String
    , date : String
    , temp : String
    , text : String
    }

type alias Forecast =
    { code : String
    , date : String
    , day : String
    , high : String
    , low : String
    , text : Text
    }

type Text
    = Showers
    | MostlySunny
    | PartlyCloudy

type alias GUID =
    { isPermaLink : String
    }

type alias Location =
    { city : String
    , country : String
    , region : String
    }

type alias Units =
    { distance : String
    , pressure : String
    , speed : String
    , temperature : String
    }

type alias Wind =
    { chill : String
    , direction : String
    , speed : String
    }

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
        |> Jpipe.required "query" query

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("query", encodeQuery x.query)
        ]

query : Jdec.Decoder Query
query =
    Jdec.succeed Query
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "created" Jdec.string
        |> Jpipe.required "lang" Jdec.string
        |> Jpipe.required "results" results

encodeQuery : Query -> Jenc.Value
encodeQuery x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("created", Jenc.string x.created)
        , ("lang", Jenc.string x.lang)
        , ("results", encodeResults x.results)
        ]

results : Jdec.Decoder Results
results =
    Jdec.succeed Results
        |> Jpipe.required "channel" channel

encodeResults : Results -> Jenc.Value
encodeResults x =
    Jenc.object
        [ ("channel", encodeChannel x.channel)
        ]

channel : Jdec.Decoder Channel
channel =
    Jdec.succeed Channel
        |> Jpipe.required "astronomy" astronomy
        |> Jpipe.required "atmosphere" atmosphere
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "image" image
        |> Jpipe.required "item" item
        |> Jpipe.required "language" Jdec.string
        |> Jpipe.required "lastBuildDate" Jdec.string
        |> Jpipe.required "link" Jdec.string
        |> Jpipe.required "location" location
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "ttl" Jdec.string
        |> Jpipe.required "units" units
        |> Jpipe.required "wind" wind

encodeChannel : Channel -> Jenc.Value
encodeChannel x =
    Jenc.object
        [ ("astronomy", encodeAstronomy x.astronomy)
        , ("atmosphere", encodeAtmosphere x.atmosphere)
        , ("description", Jenc.string x.description)
        , ("image", encodeImage x.image)
        , ("item", encodeItem x.item)
        , ("language", Jenc.string x.language)
        , ("lastBuildDate", Jenc.string x.lastBuildDate)
        , ("link", Jenc.string x.link)
        , ("location", encodeLocation x.location)
        , ("title", Jenc.string x.title)
        , ("ttl", Jenc.string x.ttl)
        , ("units", encodeUnits x.units)
        , ("wind", encodeWind x.wind)
        ]

astronomy : Jdec.Decoder Astronomy
astronomy =
    Jdec.succeed Astronomy
        |> Jpipe.required "sunrise" Jdec.string
        |> Jpipe.required "sunset" Jdec.string

encodeAstronomy : Astronomy -> Jenc.Value
encodeAstronomy x =
    Jenc.object
        [ ("sunrise", Jenc.string x.sunrise)
        , ("sunset", Jenc.string x.sunset)
        ]

atmosphere : Jdec.Decoder Atmosphere
atmosphere =
    Jdec.succeed Atmosphere
        |> Jpipe.required "humidity" Jdec.string
        |> Jpipe.required "pressure" Jdec.string
        |> Jpipe.required "rising" Jdec.string
        |> Jpipe.required "visibility" Jdec.string

encodeAtmosphere : Atmosphere -> Jenc.Value
encodeAtmosphere x =
    Jenc.object
        [ ("humidity", Jenc.string x.humidity)
        , ("pressure", Jenc.string x.pressure)
        , ("rising", Jenc.string x.rising)
        , ("visibility", Jenc.string x.visibility)
        ]

image : Jdec.Decoder Image
image =
    Jdec.succeed Image
        |> Jpipe.required "height" Jdec.string
        |> Jpipe.required "link" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "width" Jdec.string

encodeImage : Image -> Jenc.Value
encodeImage x =
    Jenc.object
        [ ("height", Jenc.string x.height)
        , ("link", Jenc.string x.link)
        , ("title", Jenc.string x.title)
        , ("url", Jenc.string x.url)
        , ("width", Jenc.string x.width)
        ]

item : Jdec.Decoder Item
item =
    Jdec.succeed Item
        |> Jpipe.required "condition" condition
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "forecast" (Jdec.list forecast )
        |> Jpipe.required "guid" guid
        |> Jpipe.required "lat" Jdec.string
        |> Jpipe.required "link" Jdec.string
        |> Jpipe.required "long" Jdec.string
        |> Jpipe.required "pubDate" Jdec.string
        |> Jpipe.required "title" Jdec.string

encodeItem : Item -> Jenc.Value
encodeItem x =
    Jenc.object
        [ ("condition", encodeCondition x.condition)
        , ("description", Jenc.string x.description)
        , ("forecast", Jenc.list encodeForecast x.forecast)
        , ("guid", encodeGUID x.guid)
        , ("lat", Jenc.string x.lat)
        , ("link", Jenc.string x.link)
        , ("long", Jenc.string x.long)
        , ("pubDate", Jenc.string x.pubDate)
        , ("title", Jenc.string x.title)
        ]

condition : Jdec.Decoder Condition
condition =
    Jdec.succeed Condition
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "temp" Jdec.string
        |> Jpipe.required "text" Jdec.string

encodeCondition : Condition -> Jenc.Value
encodeCondition x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("date", Jenc.string x.date)
        , ("temp", Jenc.string x.temp)
        , ("text", Jenc.string x.text)
        ]

forecast : Jdec.Decoder Forecast
forecast =
    Jdec.succeed Forecast
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "day" Jdec.string
        |> Jpipe.required "high" Jdec.string
        |> Jpipe.required "low" Jdec.string
        |> Jpipe.required "text" text

encodeForecast : Forecast -> Jenc.Value
encodeForecast x =
    Jenc.object
        [ ("code", Jenc.string x.code)
        , ("date", Jenc.string x.date)
        , ("day", Jenc.string x.day)
        , ("high", Jenc.string x.high)
        , ("low", Jenc.string x.low)
        , ("text", encodeText x.text)
        ]

text : Jdec.Decoder Text
text =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Showers" -> Jdec.succeed Showers
                "Mostly Sunny" -> Jdec.succeed MostlySunny
                "Partly Cloudy" -> Jdec.succeed PartlyCloudy
                somethingElse -> Jdec.fail <| "Invalid Text: " ++ somethingElse
        )

encodeText : Text -> Jenc.Value
encodeText x = case x of
    Showers -> Jenc.string "Showers"
    MostlySunny -> Jenc.string "Mostly Sunny"
    PartlyCloudy -> Jenc.string "Partly Cloudy"

guid : Jdec.Decoder GUID
guid =
    Jdec.succeed GUID
        |> Jpipe.required "isPermaLink" Jdec.string

encodeGUID : GUID -> Jenc.Value
encodeGUID x =
    Jenc.object
        [ ("isPermaLink", Jenc.string x.isPermaLink)
        ]

location : Jdec.Decoder Location
location =
    Jdec.succeed Location
        |> Jpipe.required "city" Jdec.string
        |> Jpipe.required "country" Jdec.string
        |> Jpipe.required "region" Jdec.string

encodeLocation : Location -> Jenc.Value
encodeLocation x =
    Jenc.object
        [ ("city", Jenc.string x.city)
        , ("country", Jenc.string x.country)
        , ("region", Jenc.string x.region)
        ]

units : Jdec.Decoder Units
units =
    Jdec.succeed Units
        |> Jpipe.required "distance" Jdec.string
        |> Jpipe.required "pressure" Jdec.string
        |> Jpipe.required "speed" Jdec.string
        |> Jpipe.required "temperature" Jdec.string

encodeUnits : Units -> Jenc.Value
encodeUnits x =
    Jenc.object
        [ ("distance", Jenc.string x.distance)
        , ("pressure", Jenc.string x.pressure)
        , ("speed", Jenc.string x.speed)
        , ("temperature", Jenc.string x.temperature)
        ]

wind : Jdec.Decoder Wind
wind =
    Jdec.succeed Wind
        |> Jpipe.required "chill" Jdec.string
        |> Jpipe.required "direction" Jdec.string
        |> Jpipe.required "speed" Jdec.string

encodeWind : Wind -> Jenc.Value
encodeWind x =
    Jenc.object
        [ ("chill", Jenc.string x.chill)
        , ("direction", Jenc.string x.direction)
        , ("speed", Jenc.string x.speed)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
