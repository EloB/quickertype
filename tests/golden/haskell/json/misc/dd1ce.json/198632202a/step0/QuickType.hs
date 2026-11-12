{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Card (..)
    , LegalityElement (..)
    , Ruling (..)
    , Booster (..)
    , ColorIdentity (..)
    , Color (..)
    , Layout (..)
    , Format (..)
    , LegalityEnum (..)
    , Rarity (..)
    , Supertype (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { boosterQuickType :: [Booster]
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

data Booster
    = RareBooster
    | UncommonBooster
    | CommonBooster
    deriving (Show)

data Card = Card
    { artistCard :: Text
    , cardIDCard :: Text
    , cardTextCard :: Maybe Text
    , cardTypeCard :: Text
    , cmcCard :: Int
    , colorIdentityCard :: Maybe ([ColorIdentity])
    , colorsCard :: Maybe ([Color])
    , flavorCard :: Maybe Text
    , imageNameCard :: Text
    , layoutCard :: Layout
    , legalitiesCard :: [LegalityElement]
    , manaCostCard :: Maybe Text
    , mciNumberCard :: Maybe Text
    , multiverseidCard :: Int
    , nameCard :: Text
    , originalTextCard :: Maybe Text
    , originalTypeCard :: Text
    , powerCard :: Maybe Text
    , printingsCard :: [Text]
    , rarityCard :: Rarity
    , reservedCard :: Maybe Bool
    , rulingsCard :: Maybe ([Ruling])
    , subtypesCard :: Maybe ([Text])
    , supertypesCard :: Maybe ([Supertype])
    , toughnessCard :: Maybe Text
    , typesCard :: [Type]
    , variationsCard :: Maybe ([Int])
    } deriving (Show)

data ColorIdentity
    = UColorIdentity
    | BColorIdentity
    | WColorIdentity
    | GColorIdentity
    | RColorIdentity
    deriving (Show)

data Color
    = BlueColor
    | BlackColor
    | WhiteColor
    | GreenColor
    | RedColor
    deriving (Show)

data Layout
    = NormalLayout
    deriving (Show)

data LegalityElement = LegalityElement
    { formatLegalityElement :: Format
    , legalityLegalityElement :: LegalityEnum
    } deriving (Show)

data Format
    = CommanderFormat
    | LegacyFormat
    | ModernFormat
    | VintageFormat
    | TimeSpiralBlockFormat
    | RavnicaBlockFormat
    | IceAgeBlockFormat
    | TempestBlockFormat
    | OnslaughtBlockFormat
    | MasquesBlockFormat
    | MirageBlockFormat
    | UrzaBlockFormat
    | ScarsOfMirrodinBlockFormat
    | MirrodinBlockFormat
    | AmonkhetBlockFormat
    | BattleForZendikarBlockFormat
    | InnistradBlockFormat
    | InvasionBlockFormat
    | KaladeshBlockFormat
    | KamigawaBlockFormat
    | KhansOfTarkirBlockFormat
    | LorwynShadowmoorBlockFormat
    | OdysseyBlockFormat
    | ReturnToRavnicaBlockFormat
    | ShadowsOverInnistradBlockFormat
    | ShardsOfAlaraBlockFormat
    | StandardFormat
    | TherosBlockFormat
    | UnSetsFormat
    | ZendikarBlockFormat
    deriving (Show)

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

data Supertype
    = BasicSupertype
    deriving (Show)

data Type
    = CreatureType
    | InstantType
    | EnchantmentType
    | ArtifactType
    | SorceryType
    | LandType
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

instance ToJSON Booster where
    toJSON RareBooster = "rare"
    toJSON UncommonBooster = "uncommon"
    toJSON CommonBooster = "common"

instance FromJSON Booster where
    parseJSON = withText "Booster" parseText
        where
            parseText "rare" = return RareBooster
            parseText "uncommon" = return UncommonBooster
            parseText "common" = return CommonBooster

instance ToJSON Card where
    toJSON (Card artistCard cardIDCard cardTextCard cardTypeCard cmcCard colorIdentityCard colorsCard flavorCard imageNameCard layoutCard legalitiesCard manaCostCard mciNumberCard multiverseidCard nameCard originalTextCard originalTypeCard powerCard printingsCard rarityCard reservedCard rulingsCard subtypesCard supertypesCard toughnessCard typesCard variationsCard) =
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
        , ("originalText" .=) <$> originalTextCard
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
        <*> v .:! "originalText"
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

instance ToJSON ColorIdentity where
    toJSON UColorIdentity = "U"
    toJSON BColorIdentity = "B"
    toJSON WColorIdentity = "W"
    toJSON GColorIdentity = "G"
    toJSON RColorIdentity = "R"

instance FromJSON ColorIdentity where
    parseJSON = withText "ColorIdentity" parseText
        where
            parseText "U" = return UColorIdentity
            parseText "B" = return BColorIdentity
            parseText "W" = return WColorIdentity
            parseText "G" = return GColorIdentity
            parseText "R" = return RColorIdentity

instance ToJSON Color where
    toJSON BlueColor = "Blue"
    toJSON BlackColor = "Black"
    toJSON WhiteColor = "White"
    toJSON GreenColor = "Green"
    toJSON RedColor = "Red"

instance FromJSON Color where
    parseJSON = withText "Color" parseText
        where
            parseText "Blue" = return BlueColor
            parseText "Black" = return BlackColor
            parseText "White" = return WhiteColor
            parseText "Green" = return GreenColor
            parseText "Red" = return RedColor

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

instance ToJSON Format where
    toJSON CommanderFormat = "Commander"
    toJSON LegacyFormat = "Legacy"
    toJSON ModernFormat = "Modern"
    toJSON VintageFormat = "Vintage"
    toJSON TimeSpiralBlockFormat = "Time Spiral Block"
    toJSON RavnicaBlockFormat = "Ravnica Block"
    toJSON IceAgeBlockFormat = "Ice Age Block"
    toJSON TempestBlockFormat = "Tempest Block"
    toJSON OnslaughtBlockFormat = "Onslaught Block"
    toJSON MasquesBlockFormat = "Masques Block"
    toJSON MirageBlockFormat = "Mirage Block"
    toJSON UrzaBlockFormat = "Urza Block"
    toJSON ScarsOfMirrodinBlockFormat = "Scars of Mirrodin Block"
    toJSON MirrodinBlockFormat = "Mirrodin Block"
    toJSON AmonkhetBlockFormat = "Amonkhet Block"
    toJSON BattleForZendikarBlockFormat = "Battle for Zendikar Block"
    toJSON InnistradBlockFormat = "Innistrad Block"
    toJSON InvasionBlockFormat = "Invasion Block"
    toJSON KaladeshBlockFormat = "Kaladesh Block"
    toJSON KamigawaBlockFormat = "Kamigawa Block"
    toJSON KhansOfTarkirBlockFormat = "Khans of Tarkir Block"
    toJSON LorwynShadowmoorBlockFormat = "Lorwyn-Shadowmoor Block"
    toJSON OdysseyBlockFormat = "Odyssey Block"
    toJSON ReturnToRavnicaBlockFormat = "Return to Ravnica Block"
    toJSON ShadowsOverInnistradBlockFormat = "Shadows over Innistrad Block"
    toJSON ShardsOfAlaraBlockFormat = "Shards of Alara Block"
    toJSON StandardFormat = "Standard"
    toJSON TherosBlockFormat = "Theros Block"
    toJSON UnSetsFormat = "Un-Sets"
    toJSON ZendikarBlockFormat = "Zendikar Block"

instance FromJSON Format where
    parseJSON = withText "Format" parseText
        where
            parseText "Commander" = return CommanderFormat
            parseText "Legacy" = return LegacyFormat
            parseText "Modern" = return ModernFormat
            parseText "Vintage" = return VintageFormat
            parseText "Time Spiral Block" = return TimeSpiralBlockFormat
            parseText "Ravnica Block" = return RavnicaBlockFormat
            parseText "Ice Age Block" = return IceAgeBlockFormat
            parseText "Tempest Block" = return TempestBlockFormat
            parseText "Onslaught Block" = return OnslaughtBlockFormat
            parseText "Masques Block" = return MasquesBlockFormat
            parseText "Mirage Block" = return MirageBlockFormat
            parseText "Urza Block" = return UrzaBlockFormat
            parseText "Scars of Mirrodin Block" = return ScarsOfMirrodinBlockFormat
            parseText "Mirrodin Block" = return MirrodinBlockFormat
            parseText "Amonkhet Block" = return AmonkhetBlockFormat
            parseText "Battle for Zendikar Block" = return BattleForZendikarBlockFormat
            parseText "Innistrad Block" = return InnistradBlockFormat
            parseText "Invasion Block" = return InvasionBlockFormat
            parseText "Kaladesh Block" = return KaladeshBlockFormat
            parseText "Kamigawa Block" = return KamigawaBlockFormat
            parseText "Khans of Tarkir Block" = return KhansOfTarkirBlockFormat
            parseText "Lorwyn-Shadowmoor Block" = return LorwynShadowmoorBlockFormat
            parseText "Odyssey Block" = return OdysseyBlockFormat
            parseText "Return to Ravnica Block" = return ReturnToRavnicaBlockFormat
            parseText "Shadows over Innistrad Block" = return ShadowsOverInnistradBlockFormat
            parseText "Shards of Alara Block" = return ShardsOfAlaraBlockFormat
            parseText "Standard" = return StandardFormat
            parseText "Theros Block" = return TherosBlockFormat
            parseText "Un-Sets" = return UnSetsFormat
            parseText "Zendikar Block" = return ZendikarBlockFormat

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

instance ToJSON Supertype where
    toJSON BasicSupertype = "Basic"

instance FromJSON Supertype where
    parseJSON = withText "Supertype" parseText
        where
            parseText "Basic" = return BasicSupertype

instance ToJSON Type where
    toJSON CreatureType = "Creature"
    toJSON InstantType = "Instant"
    toJSON EnchantmentType = "Enchantment"
    toJSON ArtifactType = "Artifact"
    toJSON SorceryType = "Sorcery"
    toJSON LandType = "Land"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "Creature" = return CreatureType
            parseText "Instant" = return InstantType
            parseText "Enchantment" = return EnchantmentType
            parseText "Artifact" = return ArtifactType
            parseText "Sorcery" = return SorceryType
            parseText "Land" = return LandType
