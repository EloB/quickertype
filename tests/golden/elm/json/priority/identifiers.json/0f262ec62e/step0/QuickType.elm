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
    , QuickTypeBla
    , Empty
    , Foo
    , FooBla
    , EmptyClass
    , ThisIsAToughOne
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { bla : QuickTypeBla
    , empty : Empty
    , foo : Foo
    , quickType : Int
    , quickTypeEmpty : EmptyClass
    , thisIsAToughOne : ThisIsAToughOne
    }

type alias QuickTypeBla =
    { bar : Int
    }

type alias Empty =
    { purpleX : Int
    }

type alias Foo =
    { bla : FooBla
    , empty : Int
    , foo : Int
    }

type alias FooBla =
    {
    }

type alias EmptyClass =
    { emptyY : Int
    }

type alias ThisIsAToughOne =
    { empty : Int
    , thisIsAToughOne : Int
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
        |> Jpipe.required "bla" quickTypeBla
        |> Jpipe.required "" empty
        |> Jpipe.required "foo" foo
        |> Jpipe.required "!" Jdec.int
        |> Jpipe.required "Empty" emptyClass
        |> Jpipe.required "ThisIsA\u{1F61C}Tough\"\n\nOne" thisIsAToughOne

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("bla", encodeQuickTypeBla x.bla)
        , ("", encodeEmpty x.empty)
        , ("foo", encodeFoo x.foo)
        , ("!", Jenc.int x.quickType)
        , ("Empty", encodeEmptyClass x.quickTypeEmpty)
        , ("ThisIsA\u{1F61C}Tough\"\n\nOne", encodeThisIsAToughOne x.thisIsAToughOne)
        ]

quickTypeBla : Jdec.Decoder QuickTypeBla
quickTypeBla =
    Jdec.succeed QuickTypeBla
        |> Jpipe.required "bar" Jdec.int

encodeQuickTypeBla : QuickTypeBla -> Jenc.Value
encodeQuickTypeBla x =
    Jenc.object
        [ ("bar", Jenc.int x.bar)
        ]

empty : Jdec.Decoder Empty
empty =
    Jdec.succeed Empty
        |> Jpipe.required "x" Jdec.int

encodeEmpty : Empty -> Jenc.Value
encodeEmpty x =
    Jenc.object
        [ ("x", Jenc.int x.purpleX)
        ]

foo : Jdec.Decoder Foo
foo =
    Jdec.succeed Foo
        |> Jpipe.required "bla" fooBla
        |> Jpipe.required "_" Jdec.int
        |> Jpipe.required "__" Jdec.int

encodeFoo : Foo -> Jenc.Value
encodeFoo x =
    Jenc.object
        [ ("bla", encodeFooBla x.bla)
        , ("_", Jenc.int x.empty)
        , ("__", Jenc.int x.foo)
        ]

fooBla : Jdec.Decoder FooBla
fooBla =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> FooBla)

encodeFooBla : FooBla -> Jenc.Value
encodeFooBla x =
    Jenc.object
        [
        ]

emptyClass : Jdec.Decoder EmptyClass
emptyClass =
    Jdec.succeed EmptyClass
        |> Jpipe.required "y" Jdec.int

encodeEmptyClass : EmptyClass -> Jenc.Value
encodeEmptyClass x =
    Jenc.object
        [ ("y", Jenc.int x.emptyY)
        ]

thisIsAToughOne : Jdec.Decoder ThisIsAToughOne
thisIsAToughOne =
    Jdec.succeed ThisIsAToughOne
        |> Jpipe.required "\n\n\n" Jdec.int
        |> Jpipe.required "\"" Jdec.int

encodeThisIsAToughOne : ThisIsAToughOne -> Jenc.Value
encodeThisIsAToughOne x =
    Jenc.object
        [ ("\n\n\n", Jenc.int x.empty)
        , ("\"", Jenc.int x.thisIsAToughOne)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
