{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Card (..)
    , LegalityElement (..)
    , Ruling (..)
    , ColorIdentity (..)
    , Watermark (..)
    , Layout (..)
    , LegalityEnum (..)
    , Rarity (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { boosterQuickType :: [Text]
    , borderQuickType :: Text
    , cardsQuickType :: [Card]
    , codeQuickType :: Text
    , gathererCodeQuickType :: Text
    , magicCardsInfoCodeQuickType :: Text
    , mkmIDQuickType :: Int
    , mkmNameQuickType :: Text
    , nameQuickType :: Text
    , quickTypeTypeQuickType :: Text
    , releaseDateQuickType :: Text
    } deriving (Show)

data Card = Card
    { artistCard :: Text
    , cardIDCard :: Text
    , cardTextCard :: Maybe Text
    , cardTypeCard :: Text
    , cmcCard :: Int
    , colorIdentityCard :: Maybe ([ColorIdentity])
    , colorsCard :: Maybe ([Watermark])
    , flavorCard :: Maybe Text
    , imageNameCard :: Text
    , layoutCard :: Layout
    , legalitiesCard :: [LegalityElement]
    , manaCostCard :: Maybe Text
    , mciNumberCard :: Maybe Text
    , multiverseidCard :: Int
    , nameCard :: Text
    , originalTextCard :: Text
    , originalTypeCard :: Text
    , powerCard :: Maybe Text
    , printingsCard :: [Text]
    , rarityCard :: Rarity
    , reservedCard :: Maybe Bool
    , rulingsCard :: Maybe ([Ruling])
    , subtypesCard :: Maybe ([Text])
    , supertypesCard :: Maybe ([Text])
    , toughnessCard :: Maybe Text
    , typesCard :: [Type]
    , variationsCard :: Maybe ([Int])
    , watermarkCard :: Maybe Watermark
    } deriving (Show)

data ColorIdentity
    = WColorIdentity
    | RColorIdentity
    | BColorIdentity
    | GColorIdentity
    | UColorIdentity
    deriving (Show)

data Watermark
    = WhiteWatermark
    | RedWatermark
    | BlackWatermark
    | GreenWatermark
    | BlueWatermark
    deriving (Show)

data Layout
    = NormalLayout
    deriving (Show)

data LegalityElement = LegalityElement
    { formatLegalityElement :: Text
    , legalityLegalityElement :: LegalityEnum
    } deriving (Show)

data LegalityEnum
    = LegalLegalityEnum
    | BannedLegalityEnum
    | RestrictedLegalityEnum
    deriving (Show)

data Rarity
    = UncommonRarity
    | RareRarity
    | CommonRarity
    | BasicLandRarity
    deriving (Show)

data Ruling = Ruling
    { dateRuling :: Text
    , rulingTextRuling :: Text
    } deriving (Show)

data Type
    = CreatureType
    | ArtifactType
    | InstantType
    | LandType
    | EnchantmentType
    | SorceryType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType boosterQuickType borderQuickType cardsQuickType codeQuickType gathererCodeQuickType magicCardsInfoCodeQuickType mkmIDQuickType mkmNameQuickType nameQuickType quickTypeTypeQuickType releaseDateQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "booster" .= boosterQuickType
        , Just $ "border" .= borderQuickType
        , Just $ "cards" .= cardsQuickType
        , Just $ "code" .= codeQuickType
        , Just $ "gathererCode" .= gathererCodeQuickType
        , Just $ "magicCardsInfoCode" .= magicCardsInfoCodeQuickType
        , Just $ "mkm_id" .= mkmIDQuickType
        , Just $ "mkm_name" .= mkmNameQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        , Just $ "releaseDate" .= releaseDateQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "booster"
        <*> v .: "border"
        <*> v .: "cards"
        <*> v .: "code"
        <*> v .: "gathererCode"
        <*> v .: "magicCardsInfoCode"
        <*> v .: "mkm_id"
        <*> v .: "mkm_name"
        <*> v .: "name"
        <*> v .: "type"
        <*> v .: "releaseDate"

instance ToJSON Card where
    toJSON (Card artistCard cardIDCard cardTextCard cardTypeCard cmcCard colorIdentityCard colorsCard flavorCard imageNameCard layoutCard legalitiesCard manaCostCard mciNumberCard multiverseidCard nameCard originalTextCard originalTypeCard powerCard printingsCard rarityCard reservedCard rulingsCard subtypesCard supertypesCard toughnessCard typesCard variationsCard watermarkCard) =
        object $ foldMap (maybe [] pure)
        [ Just $ "artist" .= artistCard
        , Just $ "id" .= cardIDCard
        , ("text" .=) <$> cardTextCard
        , Just $ "type" .= cardTypeCard
        , Just $ "cmc" .= cmcCard
        , ("colorIdentity" .=) <$> colorIdentityCard
        , ("colors" .=) <$> colorsCard
        , ("flavor" .=) <$> flavorCard
        , Just $ "imageName" .= imageNameCard
        , Just $ "layout" .= layoutCard
        , Just $ "legalities" .= legalitiesCard
        , ("manaCost" .=) <$> manaCostCard
        , ("mciNumber" .=) <$> mciNumberCard
        , Just $ "multiverseid" .= multiverseidCard
        , Just $ "name" .= nameCard
        , Just $ "originalText" .= originalTextCard
        , Just $ "originalType" .= originalTypeCard
        , ("power" .=) <$> powerCard
        , Just $ "printings" .= printingsCard
        , Just $ "rarity" .= rarityCard
        , ("reserved" .=) <$> reservedCard
        , ("rulings" .=) <$> rulingsCard
        , ("subtypes" .=) <$> subtypesCard
        , ("supertypes" .=) <$> supertypesCard
        , ("toughness" .=) <$> toughnessCard
        , Just $ "types" .= typesCard
        , ("variations" .=) <$> variationsCard
        , ("watermark" .=) <$> watermarkCard
        ]

instance FromJSON Card where
    parseJSON (Object v) = Card
        <$> v .: "artist"
        <*> v .: "id"
        <*> v .:! "text"
        <*> v .: "type"
        <*> v .: "cmc"
        <*> v .:! "colorIdentity"
        <*> v .:! "colors"
        <*> v .:! "flavor"
        <*> v .: "imageName"
        <*> v .: "layout"
        <*> v .: "legalities"
        <*> v .:! "manaCost"
        <*> v .:! "mciNumber"
        <*> v .: "multiverseid"
        <*> v .: "name"
        <*> v .: "originalText"
        <*> v .: "originalType"
        <*> v .:! "power"
        <*> v .: "printings"
        <*> v .: "rarity"
        <*> v .:! "reserved"
        <*> v .:! "rulings"
        <*> v .:! "subtypes"
        <*> v .:! "supertypes"
        <*> v .:! "toughness"
        <*> v .: "types"
        <*> v .:! "variations"
        <*> v .:! "watermark"

instance ToJSON ColorIdentity where
    toJSON WColorIdentity = "W"
    toJSON RColorIdentity = "R"
    toJSON BColorIdentity = "B"
    toJSON GColorIdentity = "G"
    toJSON UColorIdentity = "U"

instance FromJSON ColorIdentity where
    parseJSON = withText "ColorIdentity" parseText
        where
            parseText "W" = return WColorIdentity
            parseText "R" = return RColorIdentity
            parseText "B" = return BColorIdentity
            parseText "G" = return GColorIdentity
            parseText "U" = return UColorIdentity

instance ToJSON Watermark where
    toJSON WhiteWatermark = "White"
    toJSON RedWatermark = "Red"
    toJSON BlackWatermark = "Black"
    toJSON GreenWatermark = "Green"
    toJSON BlueWatermark = "Blue"

instance FromJSON Watermark where
    parseJSON = withText "Watermark" parseText
        where
            parseText "White" = return WhiteWatermark
            parseText "Red" = return RedWatermark
            parseText "Black" = return BlackWatermark
            parseText "Green" = return GreenWatermark
            parseText "Blue" = return BlueWatermark

instance ToJSON Layout where
    toJSON NormalLayout = "normal"

instance FromJSON Layout where
    parseJSON = withText "Layout" parseText
        where
            parseText "normal" = return NormalLayout

instance ToJSON LegalityElement where
    toJSON (LegalityElement formatLegalityElement legalityLegalityElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "format" .= formatLegalityElement
        , Just $ "legality" .= legalityLegalityElement
        ]

instance FromJSON LegalityElement where
    parseJSON (Object v) = LegalityElement
        <$> v .: "format"
        <*> v .: "legality"

instance ToJSON LegalityEnum where
    toJSON LegalLegalityEnum = "Legal"
    toJSON BannedLegalityEnum = "Banned"
    toJSON RestrictedLegalityEnum = "Restricted"

instance FromJSON LegalityEnum where
    parseJSON = withText "LegalityEnum" parseText
        where
            parseText "Legal" = return LegalLegalityEnum
            parseText "Banned" = return BannedLegalityEnum
            parseText "Restricted" = return RestrictedLegalityEnum

instance ToJSON Rarity where
    toJSON UncommonRarity = "Uncommon"
    toJSON RareRarity = "Rare"
    toJSON CommonRarity = "Common"
    toJSON BasicLandRarity = "Basic Land"

instance FromJSON Rarity where
    parseJSON = withText "Rarity" parseText
        where
            parseText "Uncommon" = return UncommonRarity
            parseText "Rare" = return RareRarity
            parseText "Common" = return CommonRarity
            parseText "Basic Land" = return BasicLandRarity

instance ToJSON Ruling where
    toJSON (Ruling dateRuling rulingTextRuling) =
        object $ foldMap (maybe [] pure)
        [ Just $ "date" .= dateRuling
        , Just $ "text" .= rulingTextRuling
        ]

instance FromJSON Ruling where
    parseJSON (Object v) = Ruling
        <$> v .: "date"
        <*> v .: "text"

instance ToJSON Type where
    toJSON CreatureType = "Creature"
    toJSON ArtifactType = "Artifact"
    toJSON InstantType = "Instant"
    toJSON LandType = "Land"
    toJSON EnchantmentType = "Enchantment"
    toJSON SorceryType = "Sorcery"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "Creature" = return CreatureType
            parseText "Artifact" = return ArtifactType
            parseText "Instant" = return InstantType
            parseText "Land" = return LandType
            parseText "Enchantment" = return EnchantmentType
            parseText "Sorcery" = return SorceryType
