{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , MissionSpec (..)
    , Objective (..)
    , Reward (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { missionSpecsQuickType :: HashMap Text MissionSpec
    } deriving (Show)

data MissionSpec = MissionSpec
    { objectivesMissionSpec :: HashMap Text Objective
    } deriving (Show)

data Objective = Objective
    { rewardsObjective :: HashMap Text Reward
    } deriving (Show)

data Reward = Reward
    {
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType missionSpecsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "mission_specs" .= missionSpecsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "mission_specs"

instance ToJSON MissionSpec where
    toJSON (MissionSpec objectivesMissionSpec) =
        object $ foldMap (maybe [] pure)
        [ Just $ "objectives" .= objectivesMissionSpec
        ]

instance FromJSON MissionSpec where
    parseJSON (Object v) = MissionSpec
        <$> v .: "objectives"

instance ToJSON Objective where
    toJSON (Objective rewardsObjective) =
        object $ foldMap (maybe [] pure)
        [ Just $ "rewards" .= rewardsObjective
        ]

instance FromJSON Objective where
    parseJSON (Object v) = Objective
        <$> v .: "rewards"

instance ToJSON Reward where
    toJSON = \_ -> emptyObject

instance FromJSON Reward where
    parseJSON (Object _) = return Reward
