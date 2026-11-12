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
    , Fruit
    , Berry
    , Color
    , Shape
    , Geometry
    , CircularShape
    , RectShape
    , Part
    , History
    , Vehicle
    , Speed
    , Limit
    , VehicleType
    , Axis(..)
    , Name(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { version : Maybe String
    , fruits : Maybe (List Fruit)
    , vehicles : Maybe (List Vehicle)
    }

type alias Fruit =
    { apple : Maybe Bool
    , berries : Maybe (List Berry)
    , orange : Maybe Bool
    }

type alias Berry =
    { color : Maybe Color
    , name : Maybe String
    , shapes : Maybe (List Shape)
    }

type alias Color =
    { rgb : Maybe Float
    }

type alias Shape =
    { geometry : Maybe Geometry
    , history : Maybe History
    }

type alias Geometry =
    { rectShape : Maybe RectShape
    , circularShape : Maybe (List CircularShape)
    }

type alias CircularShape =
    { shapeName : Maybe String
    }

type alias RectShape =
    { parts : Maybe (List Part)
    }

type alias Part =
    { depth : Maybe String
    , length : Maybe String
    , width : Maybe String
    }

type alias History =
    { class : Maybe String
    }

type alias Vehicle =
    { brand : Maybe String
    , id : Maybe String
    , speed : Maybe Speed
    , subModule : Maybe Bool
    , vehicleType : Maybe VehicleType
    , year : Maybe String
    }

type alias Speed =
    { velocity : Maybe Limit
    }

type alias Limit =
    { maximum : Maybe Float
    , minimum : Maybe Float
    }

type alias VehicleType =
    { name : Maybe Name
    , width : Maybe Axis
    , length : Maybe Axis
    }

type Axis
    = X
    | Y
    | Z
    | Xy
    | Yz
    | Zx

type Name
    = Truck
    | Bus
    | Car
    | Van
    | Train
    | Bike
    | Aeroplane
    | Jeep
    | Trolley

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
        |> Jpipe.custom (optionalField "version" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "fruits" (Jdec.map Just (Jdec.list fruit )) Nothing)
        |> Jpipe.custom (optionalField "vehicles" (Jdec.map Just (Jdec.list vehicle )) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("version", makeNullableEncoder Jenc.string x.version)
        , ("fruits", makeNullableEncoder (Jenc.list encodeFruit) x.fruits)
        , ("vehicles", makeNullableEncoder (Jenc.list encodeVehicle) x.vehicles)
        ]

fruit : Jdec.Decoder Fruit
fruit =
    Jdec.succeed Fruit
        |> Jpipe.custom (optionalField "apple" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "berries" (Jdec.map Just (Jdec.list berry )) Nothing)
        |> Jpipe.custom (optionalField "orange" (Jdec.map Just Jdec.bool) Nothing)

encodeFruit : Fruit -> Jenc.Value
encodeFruit x =
    Jenc.object
        [ ("apple", makeNullableEncoder Jenc.bool x.apple)
        , ("berries", makeNullableEncoder (Jenc.list encodeBerry) x.berries)
        , ("orange", makeNullableEncoder Jenc.bool x.orange)
        ]

berry : Jdec.Decoder Berry
berry =
    Jdec.succeed Berry
        |> Jpipe.custom (optionalField "color" (Jdec.map Just color) Nothing)
        |> Jpipe.custom (optionalField "name" (Jdec.map Just (Jdec.andThen (\x -> if List.length (String.toList x) >= 1 && True then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)) Nothing)
        |> Jpipe.custom (optionalField "shapes" (Jdec.map Just (Jdec.list shape )) Nothing)

encodeBerry : Berry -> Jenc.Value
encodeBerry x =
    Jenc.object
        [ ("color", makeNullableEncoder encodeColor x.color)
        , ("name", makeNullableEncoder Jenc.string x.name)
        , ("shapes", makeNullableEncoder (Jenc.list encodeShape) x.shapes)
        ]

color : Jdec.Decoder Color
color =
    Jdec.succeed Color
        |> Jpipe.custom (optionalField "rgb" (Jdec.map Just Jdec.float) Nothing)

encodeColor : Color -> Jenc.Value
encodeColor x =
    Jenc.object
        [ ("rgb", makeNullableEncoder Jenc.float x.rgb)
        ]

shape : Jdec.Decoder Shape
shape =
    Jdec.succeed Shape
        |> Jpipe.custom (optionalField "geometry" (Jdec.map Just geometry) Nothing)
        |> Jpipe.custom (optionalField "history" (Jdec.map Just history) Nothing)

encodeShape : Shape -> Jenc.Value
encodeShape x =
    Jenc.object
        [ ("geometry", makeNullableEncoder encodeGeometry x.geometry)
        , ("history", makeNullableEncoder encodeHistory x.history)
        ]

geometry : Jdec.Decoder Geometry
geometry =
    Jdec.succeed Geometry
        |> Jpipe.custom (optionalField "rectShape" (Jdec.map Just rectShape) Nothing)
        |> Jpipe.custom (optionalField "circularShape" (Jdec.map Just (Jdec.list circularShape )) Nothing)

encodeGeometry : Geometry -> Jenc.Value
encodeGeometry x =
    Jenc.object
        [ ("rectShape", makeNullableEncoder encodeRectShape x.rectShape)
        , ("circularShape", makeNullableEncoder (Jenc.list encodeCircularShape) x.circularShape)
        ]

circularShape : Jdec.Decoder CircularShape
circularShape =
    Jdec.succeed CircularShape
        |> Jpipe.custom (optionalField "shapeName" (Jdec.map Just Jdec.string) Nothing)

encodeCircularShape : CircularShape -> Jenc.Value
encodeCircularShape x =
    Jenc.object
        [ ("shapeName", makeNullableEncoder Jenc.string x.shapeName)
        ]

rectShape : Jdec.Decoder RectShape
rectShape =
    Jdec.succeed RectShape
        |> Jpipe.custom (optionalField "parts" (Jdec.map Just (Jdec.list part )) Nothing)

encodeRectShape : RectShape -> Jenc.Value
encodeRectShape x =
    Jenc.object
        [ ("parts", makeNullableEncoder (Jenc.list encodePart) x.parts)
        ]

part : Jdec.Decoder Part
part =
    Jdec.succeed Part
        |> Jpipe.custom (optionalField "depth" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "length" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "width" (Jdec.map Just Jdec.string) Nothing)

encodePart : Part -> Jenc.Value
encodePart x =
    Jenc.object
        [ ("depth", makeNullableEncoder Jenc.string x.depth)
        , ("length", makeNullableEncoder Jenc.string x.length)
        , ("width", makeNullableEncoder Jenc.string x.width)
        ]

history : Jdec.Decoder History
history =
    Jdec.succeed History
        |> Jpipe.custom (optionalField "class" (Jdec.map Just Jdec.string) Nothing)

encodeHistory : History -> Jenc.Value
encodeHistory x =
    Jenc.object
        [ ("class", makeNullableEncoder Jenc.string x.class)
        ]

vehicle : Jdec.Decoder Vehicle
vehicle =
    Jdec.succeed Vehicle
        |> Jpipe.custom (optionalField "brand" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "id" (Jdec.map Just (Jdec.andThen (\x -> if List.length (String.toList x) >= 1 && True then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)) Nothing)
        |> Jpipe.custom (optionalField "speed" (Jdec.map Just speed) Nothing)
        |> Jpipe.custom (optionalField "subModule" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "type" (Jdec.map Just vehicleType) Nothing)
        |> Jpipe.custom (optionalField "year" (Jdec.map Just Jdec.string) Nothing)

encodeVehicle : Vehicle -> Jenc.Value
encodeVehicle x =
    Jenc.object
        [ ("brand", makeNullableEncoder Jenc.string x.brand)
        , ("id", makeNullableEncoder Jenc.string x.id)
        , ("speed", makeNullableEncoder encodeSpeed x.speed)
        , ("subModule", makeNullableEncoder Jenc.bool x.subModule)
        , ("type", makeNullableEncoder encodeVehicleType x.vehicleType)
        , ("year", makeNullableEncoder Jenc.string x.year)
        ]

speed : Jdec.Decoder Speed
speed =
    Jdec.succeed Speed
        |> Jpipe.custom (optionalField "velocity" (Jdec.map Just limit) Nothing)

encodeSpeed : Speed -> Jenc.Value
encodeSpeed x =
    Jenc.object
        [ ("velocity", makeNullableEncoder encodeLimit x.velocity)
        ]

limit : Jdec.Decoder Limit
limit =
    Jdec.succeed Limit
        |> Jpipe.custom (optionalField "maximum" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "minimum" (Jdec.map Just Jdec.float) Nothing)

encodeLimit : Limit -> Jenc.Value
encodeLimit x =
    Jenc.object
        [ ("maximum", makeNullableEncoder Jenc.float x.maximum)
        , ("minimum", makeNullableEncoder Jenc.float x.minimum)
        ]

vehicleType : Jdec.Decoder VehicleType
vehicleType =
    Jdec.succeed VehicleType
        |> Jpipe.custom (optionalField "name" (Jdec.map Just name) Nothing)
        |> Jpipe.custom (optionalField "width" (Jdec.map Just axis) Nothing)
        |> Jpipe.custom (optionalField "length" (Jdec.map Just axis) Nothing)

encodeVehicleType : VehicleType -> Jenc.Value
encodeVehicleType x =
    Jenc.object
        [ ("name", makeNullableEncoder encodeName x.name)
        , ("width", makeNullableEncoder encodeAxis x.width)
        , ("length", makeNullableEncoder encodeAxis x.length)
        ]

axis : Jdec.Decoder Axis
axis =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "X" -> Jdec.succeed X
                "Y" -> Jdec.succeed Y
                "Z" -> Jdec.succeed Z
                "XY" -> Jdec.succeed Xy
                "YZ" -> Jdec.succeed Yz
                "ZX" -> Jdec.succeed Zx
                somethingElse -> Jdec.fail <| "Invalid Axis: " ++ somethingElse
        )

encodeAxis : Axis -> Jenc.Value
encodeAxis x = case x of
    X -> Jenc.string "X"
    Y -> Jenc.string "Y"
    Z -> Jenc.string "Z"
    Xy -> Jenc.string "XY"
    Yz -> Jenc.string "YZ"
    Zx -> Jenc.string "ZX"

name : Jdec.Decoder Name
name =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "truck" -> Jdec.succeed Truck
                "bus" -> Jdec.succeed Bus
                "car" -> Jdec.succeed Car
                "van" -> Jdec.succeed Van
                "train" -> Jdec.succeed Train
                "Bike" -> Jdec.succeed Bike
                "Aeroplane" -> Jdec.succeed Aeroplane
                "Jeep" -> Jdec.succeed Jeep
                "Trolley" -> Jdec.succeed Trolley
                somethingElse -> Jdec.fail <| "Invalid Name: " ++ somethingElse
        )

encodeName : Name -> Jenc.Value
encodeName x = case x of
    Truck -> Jenc.string "truck"
    Bus -> Jenc.string "bus"
    Car -> Jenc.string "car"
    Van -> Jenc.string "van"
    Train -> Jenc.string "train"
    Bike -> Jenc.string "Bike"
    Aeroplane -> Jenc.string "Aeroplane"
    Jeep -> Jenc.string "Jeep"
    Trolley -> Jenc.string "Trolley"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
