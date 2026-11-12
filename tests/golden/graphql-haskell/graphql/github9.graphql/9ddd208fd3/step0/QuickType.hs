{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Data (..)
    , AddReactionPayload (..)
    , Reaction (..)
    , Reactable (..)
    , ErrorElement (..)
    , ReactionContent (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { addReactionDataQuickType :: Maybe Data
    , errorsQuickType :: Maybe ([ErrorElement])
    } deriving (Show)

data Data = Data
    { addReactionData :: Maybe AddReactionPayload
    } deriving (Show)

data AddReactionPayload = AddReactionPayload
    { clientMutationIDAddReactionPayload :: Maybe Text
    , reactionAddReactionPayload :: Reaction
    , subjectAddReactionPayload :: Reactable
    } deriving (Show)

data Reaction = Reaction
    { contentReaction :: ReactionContent
    } deriving (Show)

data ReactionContent
    = THUMBSUPReactionContent
    | THUMBSDOWNReactionContent
    | LAUGHReactionContent
    | HOORAYReactionContent
    | CONFUSEDReactionContent
    | HEARTReactionContent
    deriving (Show)

data Reactable = Reactable
    { viewerCanReactReactable :: Bool
    , reactionGroupsReactable :: Maybe ([Reaction])
    } deriving (Show)

data ErrorElement = ErrorElement
    { messageErrorElement :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType addReactionDataQuickType errorsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= addReactionDataQuickType
        , ("errors" .=) <$> errorsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "data"
        <*> v .:! "errors"

instance ToJSON Data where
    toJSON (Data addReactionData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "addReaction" .= addReactionData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .: "addReaction"

instance ToJSON AddReactionPayload where
    toJSON (AddReactionPayload clientMutationIDAddReactionPayload reactionAddReactionPayload subjectAddReactionPayload) =
        object $ foldMap (maybe [] pure)
        [ Just $ "clientMutationId" .= clientMutationIDAddReactionPayload
        , Just $ "reaction" .= reactionAddReactionPayload
        , Just $ "subject" .= subjectAddReactionPayload
        ]

instance FromJSON AddReactionPayload where
    parseJSON (Object v) = AddReactionPayload
        <$> v .: "clientMutationId"
        <*> v .: "reaction"
        <*> v .: "subject"

instance ToJSON Reaction where
    toJSON (Reaction contentReaction) =
        object $ foldMap (maybe [] pure)
        [ Just $ "content" .= contentReaction
        ]

instance FromJSON Reaction where
    parseJSON (Object v) = Reaction
        <$> v .: "content"

instance ToJSON ReactionContent where
    toJSON THUMBSUPReactionContent = "THUMBS_UP"
    toJSON THUMBSDOWNReactionContent = "THUMBS_DOWN"
    toJSON LAUGHReactionContent = "LAUGH"
    toJSON HOORAYReactionContent = "HOORAY"
    toJSON CONFUSEDReactionContent = "CONFUSED"
    toJSON HEARTReactionContent = "HEART"

instance FromJSON ReactionContent where
    parseJSON = withText "ReactionContent" parseText
        where
            parseText "THUMBS_UP" = return THUMBSUPReactionContent
            parseText "THUMBS_DOWN" = return THUMBSDOWNReactionContent
            parseText "LAUGH" = return LAUGHReactionContent
            parseText "HOORAY" = return HOORAYReactionContent
            parseText "CONFUSED" = return CONFUSEDReactionContent
            parseText "HEART" = return HEARTReactionContent

instance ToJSON Reactable where
    toJSON (Reactable viewerCanReactReactable reactionGroupsReactable) =
        object $ foldMap (maybe [] pure)
        [ Just $ "viewerCanReact" .= viewerCanReactReactable
        , Just $ "reactionGroups" .= reactionGroupsReactable
        ]

instance FromJSON Reactable where
    parseJSON (Object v) = Reactable
        <$> v .: "viewerCanReact"
        <*> v .: "reactionGroups"

instance ToJSON ErrorElement where
    toJSON (ErrorElement messageErrorElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageErrorElement
        ]

instance FromJSON ErrorElement where
    parseJSON (Object v) = ErrorElement
        <$> v .: "message"
