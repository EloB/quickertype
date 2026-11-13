-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (generated)
--
-- and you're off to the races with
--
--     decodeString generated myJsonString

module QuickType exposing
    ( Generated
    , generatedToString
    , generated
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias Generated =
    { greeting : String
    , instructions : List String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

generatedToString : Generated -> String
generatedToString r = Jenc.encode 0 (encodeGenerated r)

generated : Jdec.Decoder Generated
generated =
    Jdec.succeed Generated
        |> Jpipe.required "greeting" Jdec.string
        |> Jpipe.required "instructions" (Jdec.list Jdec.string )

encodeGenerated : Generated -> Jenc.Value
encodeGenerated x =
    Jenc.object
        [ ("greeting", Jenc.string x.greeting)
        , ("instructions", Jenc.list Jenc.string x.instructions)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
