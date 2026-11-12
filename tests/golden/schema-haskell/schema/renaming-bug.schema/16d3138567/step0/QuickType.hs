{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Fruit (..)
    , Berry (..)
    , Color (..)
    , Shape (..)
    , Geometry (..)
    , CircularShape (..)
    , RectShape (..)
    , Part (..)
    , History (..)
    , Vehicle (..)
    , Speed (..)
    , Limit (..)
    , VehicleType (..)
    , Axis (..)
    , Name (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { versionQuickType :: Maybe Text
    , fruitsQuickType :: Maybe ([Fruit])
    , vehiclesQuickType :: Maybe ([Vehicle])
    } deriving (Show)

data Fruit = Fruit
    { appleFruit :: Maybe Bool
    , berriesFruit :: Maybe ([Berry])
    , orangeFruit :: Maybe Bool
    } deriving (Show)

data Berry = Berry
    { colorBerry :: Maybe Color
    , nameBerry :: Maybe Text
    , shapesBerry :: Maybe ([Shape])
    } deriving (Show)

data Color = Color
    { rgbColor :: Maybe Double
    } deriving (Show)

data Shape = Shape
    { geometryShape :: Maybe Geometry
    , historyShape :: Maybe History
    } deriving (Show)

data Geometry = Geometry
    { rectShapeGeometry :: Maybe RectShape
    , circularShapeGeometry :: Maybe ([CircularShape])
    } deriving (Show)

data CircularShape = CircularShape
    { shapeNameCircularShape :: Maybe Text
    } deriving (Show)

data RectShape = RectShape
    { partsRectShape :: Maybe ([Part])
    } deriving (Show)

data Part = Part
    { depthPart :: Maybe Text
    , lengthPart :: Maybe Text
    , widthPart :: Maybe Text
    } deriving (Show)

data History = History
    { historyClassHistory :: Maybe Text
    } deriving (Show)

data Vehicle = Vehicle
    { brandVehicle :: Maybe Text
    , vehicleIDVehicle :: Maybe Text
    , speedVehicle :: Maybe Speed
    , subModuleVehicle :: Maybe Bool
    , vehicleTypeVehicle :: Maybe VehicleType
    , yearVehicle :: Maybe Text
    } deriving (Show)

data Speed = Speed
    { velocitySpeed :: Maybe Limit
    } deriving (Show)

data Limit = Limit
    { maximumLimit :: Maybe Double
    , minimumLimit :: Maybe Double
    } deriving (Show)

data VehicleType = VehicleType
    { nameVehicleType :: Maybe Name
    , widthVehicleType :: Maybe Axis
    , lengthVehicleType :: Maybe Axis
    } deriving (Show)

data Axis
    = XAxis
    | YAxis
    | ZAxis
    | XYAxis
    | YZAxis
    | ZXAxis
    deriving (Show)

data Name
    = TruckName
    | BusName
    | CarName
    | VanName
    | TrainName
    | BikeName
    | AeroplaneName
    | JeepName
    | TrolleyName
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType versionQuickType fruitsQuickType vehiclesQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("version" .=) <$> versionQuickType
        , ("fruits" .=) <$> fruitsQuickType
        , ("vehicles" .=) <$> vehiclesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "version"
        <*> v .:! "fruits"
        <*> v .:! "vehicles"

instance ToJSON Fruit where
    toJSON (Fruit appleFruit berriesFruit orangeFruit) =
        object $ foldMap (maybe [] pure)
        [ ("apple" .=) <$> appleFruit
        , ("berries" .=) <$> berriesFruit
        , ("orange" .=) <$> orangeFruit
        ]

instance FromJSON Fruit where
    parseJSON (Object v) = Fruit
        <$> v .:! "apple"
        <*> v .:! "berries"
        <*> v .:! "orange"

instance ToJSON Berry where
    toJSON (Berry colorBerry nameBerry shapesBerry) =
        object $ foldMap (maybe [] pure)
        [ ("color" .=) <$> colorBerry
        , ("name" .=) <$> nameBerry
        , ("shapes" .=) <$> shapesBerry
        ]

instance FromJSON Berry where
    parseJSON (Object v) = Berry
        <$> v .:! "color"
        <*> v .:! "name"
        <*> v .:! "shapes"

instance ToJSON Color where
    toJSON (Color rgbColor) =
        object $ foldMap (maybe [] pure)
        [ ("rgb" .=) <$> rgbColor
        ]

instance FromJSON Color where
    parseJSON (Object v) = Color
        <$> v .:! "rgb"

instance ToJSON Shape where
    toJSON (Shape geometryShape historyShape) =
        object $ foldMap (maybe [] pure)
        [ ("geometry" .=) <$> geometryShape
        , ("history" .=) <$> historyShape
        ]

instance FromJSON Shape where
    parseJSON (Object v) = Shape
        <$> v .:! "geometry"
        <*> v .:! "history"

instance ToJSON Geometry where
    toJSON (Geometry rectShapeGeometry circularShapeGeometry) =
        object $ foldMap (maybe [] pure)
        [ ("rectShape" .=) <$> rectShapeGeometry
        , ("circularShape" .=) <$> circularShapeGeometry
        ]

instance FromJSON Geometry where
    parseJSON (Object v) = Geometry
        <$> v .:! "rectShape"
        <*> v .:! "circularShape"

instance ToJSON CircularShape where
    toJSON (CircularShape shapeNameCircularShape) =
        object $ foldMap (maybe [] pure)
        [ ("shapeName" .=) <$> shapeNameCircularShape
        ]

instance FromJSON CircularShape where
    parseJSON (Object v) = CircularShape
        <$> v .:! "shapeName"

instance ToJSON RectShape where
    toJSON (RectShape partsRectShape) =
        object $ foldMap (maybe [] pure)
        [ ("parts" .=) <$> partsRectShape
        ]

instance FromJSON RectShape where
    parseJSON (Object v) = RectShape
        <$> v .:! "parts"

instance ToJSON Part where
    toJSON (Part depthPart lengthPart widthPart) =
        object $ foldMap (maybe [] pure)
        [ ("depth" .=) <$> depthPart
        , ("length" .=) <$> lengthPart
        , ("width" .=) <$> widthPart
        ]

instance FromJSON Part where
    parseJSON (Object v) = Part
        <$> v .:! "depth"
        <*> v .:! "length"
        <*> v .:! "width"

instance ToJSON History where
    toJSON (History historyClassHistory) =
        object $ foldMap (maybe [] pure)
        [ ("class" .=) <$> historyClassHistory
        ]

instance FromJSON History where
    parseJSON (Object v) = History
        <$> v .:! "class"

instance ToJSON Vehicle where
    toJSON (Vehicle brandVehicle vehicleIDVehicle speedVehicle subModuleVehicle vehicleTypeVehicle yearVehicle) =
        object $ foldMap (maybe [] pure)
        [ ("brand" .=) <$> brandVehicle
        , ("id" .=) <$> vehicleIDVehicle
        , ("speed" .=) <$> speedVehicle
        , ("subModule" .=) <$> subModuleVehicle
        , ("type" .=) <$> vehicleTypeVehicle
        , ("year" .=) <$> yearVehicle
        ]

instance FromJSON Vehicle where
    parseJSON (Object v) = Vehicle
        <$> v .:! "brand"
        <*> v .:! "id"
        <*> v .:! "speed"
        <*> v .:! "subModule"
        <*> v .:! "type"
        <*> v .:! "year"

instance ToJSON Speed where
    toJSON (Speed velocitySpeed) =
        object $ foldMap (maybe [] pure)
        [ ("velocity" .=) <$> velocitySpeed
        ]

instance FromJSON Speed where
    parseJSON (Object v) = Speed
        <$> v .:! "velocity"

instance ToJSON Limit where
    toJSON (Limit maximumLimit minimumLimit) =
        object $ foldMap (maybe [] pure)
        [ ("maximum" .=) <$> maximumLimit
        , ("minimum" .=) <$> minimumLimit
        ]

instance FromJSON Limit where
    parseJSON (Object v) = Limit
        <$> v .:! "maximum"
        <*> v .:! "minimum"

instance ToJSON VehicleType where
    toJSON (VehicleType nameVehicleType widthVehicleType lengthVehicleType) =
        object $ foldMap (maybe [] pure)
        [ ("name" .=) <$> nameVehicleType
        , ("width" .=) <$> widthVehicleType
        , ("length" .=) <$> lengthVehicleType
        ]

instance FromJSON VehicleType where
    parseJSON (Object v) = VehicleType
        <$> v .:! "name"
        <*> v .:! "width"
        <*> v .:! "length"

instance ToJSON Axis where
    toJSON XAxis = "X"
    toJSON YAxis = "Y"
    toJSON ZAxis = "Z"
    toJSON XYAxis = "XY"
    toJSON YZAxis = "YZ"
    toJSON ZXAxis = "ZX"

instance FromJSON Axis where
    parseJSON = withText "Axis" parseText
        where
            parseText "X" = return XAxis
            parseText "Y" = return YAxis
            parseText "Z" = return ZAxis
            parseText "XY" = return XYAxis
            parseText "YZ" = return YZAxis
            parseText "ZX" = return ZXAxis

instance ToJSON Name where
    toJSON TruckName = "truck"
    toJSON BusName = "bus"
    toJSON CarName = "car"
    toJSON VanName = "van"
    toJSON TrainName = "train"
    toJSON BikeName = "Bike"
    toJSON AeroplaneName = "Aeroplane"
    toJSON JeepName = "Jeep"
    toJSON TrolleyName = "Trolley"

instance FromJSON Name where
    parseJSON = withText "Name" parseText
        where
            parseText "truck" = return TruckName
            parseText "bus" = return BusName
            parseText "car" = return CarName
            parseText "van" = return VanName
            parseText "train" = return TrainName
            parseText "Bike" = return BikeName
            parseText "Aeroplane" = return AeroplaneName
            parseText "Jeep" = return JeepName
            parseText "Trolley" = return TrolleyName
