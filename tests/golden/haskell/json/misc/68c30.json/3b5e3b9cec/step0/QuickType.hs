{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Tx (..)
    , Input (..)
    , Out (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { txsQuickType :: [Tx]
    } deriving (Show)

data Tx = Tx
    { doubleSpendTx :: Bool
    , hashTx :: Text
    , inputsTx :: [Input]
    , lockTimeTx :: Int
    , outTx :: [Out]
    , relayedByTx :: Text
    , sizeTx :: Int
    , timeTx :: Int
    , txIndexTx :: Int
    , verTx :: Int
    , vinSzTx :: Int
    , voutSzTx :: Int
    } deriving (Show)

data Input = Input
    { prevOutInput :: Out
    , scriptInput :: Text
    , sequenceInput :: Int
    } deriving (Show)

data Out = Out
    { addrOut :: Text
    , nOut :: Int
    , outTypeOut :: Int
    , scriptOut :: Text
    , spentOut :: Bool
    , txIndexOut :: Int
    , valueOut :: Int
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType txsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "txs" .= txsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "txs"

instance ToJSON Tx where
    toJSON (Tx doubleSpendTx hashTx inputsTx lockTimeTx outTx relayedByTx sizeTx timeTx txIndexTx verTx vinSzTx voutSzTx) =
        object $ foldMap (maybe [] pure)
        [ Just $ "double_spend" .= doubleSpendTx
        , Just $ "hash" .= hashTx
        , Just $ "inputs" .= inputsTx
        , Just $ "lock_time" .= lockTimeTx
        , Just $ "out" .= outTx
        , Just $ "relayed_by" .= relayedByTx
        , Just $ "size" .= sizeTx
        , Just $ "time" .= timeTx
        , Just $ "tx_index" .= txIndexTx
        , Just $ "ver" .= verTx
        , Just $ "vin_sz" .= vinSzTx
        , Just $ "vout_sz" .= voutSzTx
        ]

instance FromJSON Tx where
    parseJSON (Object v) = Tx
        <$> v .: "double_spend"
        <*> v .: "hash"
        <*> v .: "inputs"
        <*> v .: "lock_time"
        <*> v .: "out"
        <*> v .: "relayed_by"
        <*> v .: "size"
        <*> v .: "time"
        <*> v .: "tx_index"
        <*> v .: "ver"
        <*> v .: "vin_sz"
        <*> v .: "vout_sz"

instance ToJSON Input where
    toJSON (Input prevOutInput scriptInput sequenceInput) =
        object $ foldMap (maybe [] pure)
        [ Just $ "prev_out" .= prevOutInput
        , Just $ "script" .= scriptInput
        , Just $ "sequence" .= sequenceInput
        ]

instance FromJSON Input where
    parseJSON (Object v) = Input
        <$> v .: "prev_out"
        <*> v .: "script"
        <*> v .: "sequence"

instance ToJSON Out where
    toJSON (Out addrOut nOut outTypeOut scriptOut spentOut txIndexOut valueOut) =
        object $ foldMap (maybe [] pure)
        [ Just $ "addr" .= addrOut
        , Just $ "n" .= nOut
        , Just $ "type" .= outTypeOut
        , Just $ "script" .= scriptOut
        , Just $ "spent" .= spentOut
        , Just $ "tx_index" .= txIndexOut
        , Just $ "value" .= valueOut
        ]

instance FromJSON Out where
    parseJSON (Object v) = Out
        <$> v .: "addr"
        <*> v .: "n"
        <*> v .: "type"
        <*> v .: "script"
        <*> v .: "spent"
        <*> v .: "tx_index"
        <*> v .: "value"
