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
    , Tx
    , Input
    , Out
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { txs : List Tx
    }

type alias Tx =
    { doubleSpend : Bool
    , hash : String
    , inputs : List Input
    , lockTime : Int
    , out : List Out
    , relayedBy : String
    , size : Int
    , time : Int
    , txIndex : Int
    , ver : Int
    , vinSz : Int
    , voutSz : Int
    }

type alias Input =
    { prevOut : Out
    , script : String
    , sequence : Int
    }

type alias Out =
    { addr : String
    , n : Int
    , outType : Int
    , script : String
    , spent : Bool
    , txIndex : Int
    , value : Int
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
        |> Jpipe.required "txs" (Jdec.list tx )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("txs", Jenc.list encodeTx x.txs)
        ]

tx : Jdec.Decoder Tx
tx =
    Jdec.succeed Tx
        |> Jpipe.required "double_spend" Jdec.bool
        |> Jpipe.required "hash" Jdec.string
        |> Jpipe.required "inputs" (Jdec.list input )
        |> Jpipe.required "lock_time" Jdec.int
        |> Jpipe.required "out" (Jdec.list out )
        |> Jpipe.required "relayed_by" Jdec.string
        |> Jpipe.required "size" Jdec.int
        |> Jpipe.required "time" Jdec.int
        |> Jpipe.required "tx_index" Jdec.int
        |> Jpipe.required "ver" Jdec.int
        |> Jpipe.required "vin_sz" Jdec.int
        |> Jpipe.required "vout_sz" Jdec.int

encodeTx : Tx -> Jenc.Value
encodeTx x =
    Jenc.object
        [ ("double_spend", Jenc.bool x.doubleSpend)
        , ("hash", Jenc.string x.hash)
        , ("inputs", Jenc.list encodeInput x.inputs)
        , ("lock_time", Jenc.int x.lockTime)
        , ("out", Jenc.list encodeOut x.out)
        , ("relayed_by", Jenc.string x.relayedBy)
        , ("size", Jenc.int x.size)
        , ("time", Jenc.int x.time)
        , ("tx_index", Jenc.int x.txIndex)
        , ("ver", Jenc.int x.ver)
        , ("vin_sz", Jenc.int x.vinSz)
        , ("vout_sz", Jenc.int x.voutSz)
        ]

input : Jdec.Decoder Input
input =
    Jdec.succeed Input
        |> Jpipe.required "prev_out" out
        |> Jpipe.required "script" Jdec.string
        |> Jpipe.required "sequence" Jdec.int

encodeInput : Input -> Jenc.Value
encodeInput x =
    Jenc.object
        [ ("prev_out", encodeOut x.prevOut)
        , ("script", Jenc.string x.script)
        , ("sequence", Jenc.int x.sequence)
        ]

out : Jdec.Decoder Out
out =
    Jdec.succeed Out
        |> Jpipe.required "addr" Jdec.string
        |> Jpipe.required "n" Jdec.int
        |> Jpipe.required "type" Jdec.int
        |> Jpipe.required "script" Jdec.string
        |> Jpipe.required "spent" Jdec.bool
        |> Jpipe.required "tx_index" Jdec.int
        |> Jpipe.required "value" Jdec.int

encodeOut : Out -> Jenc.Value
encodeOut x =
    Jenc.object
        [ ("addr", Jenc.string x.addr)
        , ("n", Jenc.int x.n)
        , ("type", Jenc.int x.outType)
        , ("script", Jenc.string x.script)
        , ("spent", Jenc.bool x.spent)
        , ("tx_index", Jenc.int x.txIndex)
        , ("value", Jenc.int x.value)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
