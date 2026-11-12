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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

{-| Comment delimiters:
*/
/*
{ -
- }
"""
</summary> & <br>
}
}
}
}
}

trailingBackslash:
Ends with a backslash \

trailingQuote:
Ends with a quote "

trailingTripleQuote:
Ends with a triple quote """

value:
Property delimiters:
*/
/*
{ -
- }
"""
</summary> & <br>
}
}
}
}
}
-}
type alias QuickType =
    { trailingBackslash : Maybe String
    , trailingQuote : Maybe String
    , trailingTripleQuote : Maybe String
    , value : String
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
        |> Jpipe.custom (optionalField "trailingBackslash" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "trailingQuote" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "trailingTripleQuote" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "value" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("trailingBackslash", makeNullableEncoder Jenc.string x.trailingBackslash)
        , ("trailingQuote", makeNullableEncoder Jenc.string x.trailingQuote)
        , ("trailingTripleQuote", makeNullableEncoder Jenc.string x.trailingTripleQuote)
        , ("value", Jenc.string x.value)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
