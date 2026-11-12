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
    , DifferentThingClass
    , PersonElement
    , PurplePerson
    , DifferentThingElement(..)
    , IntOrString(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { booleanValue : Bool
    , dateValue : String
    , differentThings : List DifferentThingElement
    , doubleValue : Float
    , intValue : Int
    , mapValue : Dict String (Maybe Int)
    , nameWithSpaces : ()
    , nullValue : ()
    , nullableMapValue : Dict String (Maybe Int)
    , people : List PersonElement
    , person : PurplePerson
    , stringValue : String
    , tuples : List (List IntOrString)
    , uuidValue : String
    }

type DifferentThingElement
    = DifferentThingClassInDifferentThingElement DifferentThingClass
    | IntegerInDifferentThingElement Int
    | StringInDifferentThingElement String

type alias DifferentThingClass =
    { name : String
    }

type alias PersonElement =
    { intOrString : IntOrString
    , name : String
    , optionalValue : Maybe Bool
    }

type IntOrString
    = IntegerInIntOrString Int
    | StringInIntOrString String

type alias PurplePerson =
    { intOrString : Int
    , name : String
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
        |> Jpipe.required "booleanValue" Jdec.bool
        |> Jpipe.required "dateValue" Jdec.string
        |> Jpipe.required "differentThings" (Jdec.list differentThingElement )
        |> Jpipe.required "doubleValue" Jdec.float
        |> Jpipe.required "intValue" Jdec.int
        |> Jpipe.required "mapValue" (Jdec.dict (Jdec.nullable Jdec.int))
        |> Jpipe.required "name with spaces" (Jdec.null ())
        |> Jpipe.required "nullValue" (Jdec.null ())
        |> Jpipe.required "nullableMapValue" (Jdec.dict (Jdec.nullable Jdec.int))
        |> Jpipe.required "people" (Jdec.list personElement )
        |> Jpipe.required "person" purplePerson
        |> Jpipe.required "stringValue" Jdec.string
        |> Jpipe.required "tuples" (Jdec.list (Jdec.list intOrString ) )
        |> Jpipe.required "uuidValue" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("booleanValue", Jenc.bool x.booleanValue)
        , ("dateValue", Jenc.string x.dateValue)
        , ("differentThings", Jenc.list encodeDifferentThingElement x.differentThings)
        , ("doubleValue", Jenc.float x.doubleValue)
        , ("intValue", Jenc.int x.intValue)
        , ("mapValue", Jenc.dict identity (makeNullableEncoder Jenc.int) x.mapValue)
        , ("name with spaces", always Jenc.null x.nameWithSpaces)
        , ("nullValue", always Jenc.null x.nullValue)
        , ("nullableMapValue", Jenc.dict identity (makeNullableEncoder Jenc.int) x.nullableMapValue)
        , ("people", Jenc.list encodePersonElement x.people)
        , ("person", encodePurplePerson x.person)
        , ("stringValue", Jenc.string x.stringValue)
        , ("tuples", Jenc.list (Jenc.list encodeIntOrString) x.tuples)
        , ("uuidValue", Jenc.string x.uuidValue)
        ]

differentThingElement : Jdec.Decoder DifferentThingElement
differentThingElement =
    Jdec.oneOf
        [ Jdec.map IntegerInDifferentThingElement Jdec.int
        , Jdec.map StringInDifferentThingElement Jdec.string
        , Jdec.map DifferentThingClassInDifferentThingElement differentThingClass
        ]

encodeDifferentThingElement : DifferentThingElement -> Jenc.Value
encodeDifferentThingElement x = case x of
    IntegerInDifferentThingElement y -> Jenc.int y
    StringInDifferentThingElement y -> Jenc.string y
    DifferentThingClassInDifferentThingElement y -> encodeDifferentThingClass y

differentThingClass : Jdec.Decoder DifferentThingClass
differentThingClass =
    Jdec.succeed DifferentThingClass
        |> Jpipe.required "name" Jdec.string

encodeDifferentThingClass : DifferentThingClass -> Jenc.Value
encodeDifferentThingClass x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        ]

personElement : Jdec.Decoder PersonElement
personElement =
    Jdec.succeed PersonElement
        |> Jpipe.required "intOrString" intOrString
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.custom (optionalField "optionalValue" (Jdec.map Just Jdec.bool) Nothing)

encodePersonElement : PersonElement -> Jenc.Value
encodePersonElement x =
    Jenc.object
        [ ("intOrString", encodeIntOrString x.intOrString)
        , ("name", Jenc.string x.name)
        , ("optionalValue", makeNullableEncoder Jenc.bool x.optionalValue)
        ]

intOrString : Jdec.Decoder IntOrString
intOrString =
    Jdec.oneOf
        [ Jdec.map IntegerInIntOrString Jdec.int
        , Jdec.map StringInIntOrString Jdec.string
        ]

encodeIntOrString : IntOrString -> Jenc.Value
encodeIntOrString x = case x of
    IntegerInIntOrString y -> Jenc.int y
    StringInIntOrString y -> Jenc.string y

purplePerson : Jdec.Decoder PurplePerson
purplePerson =
    Jdec.succeed PurplePerson
        |> Jpipe.required "intOrString" Jdec.int
        |> Jpipe.required "name" Jdec.string

encodePurplePerson : PurplePerson -> Jenc.Value
encodePurplePerson x =
    Jenc.object
        [ ("intOrString", Jenc.int x.intOrString)
        , ("name", Jenc.string x.name)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
