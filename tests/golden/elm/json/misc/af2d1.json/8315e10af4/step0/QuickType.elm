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
    , CRS
    , CRSProperties
    , FeatureElement
    , Geometry
    , FeatureProperties
    , FeatureType(..)
    , GeometryType(..)
    , GeometryName(..)
    , AddImprov(..)
    , FundingBa(..)
    , LevelAccu(..)
    , Material(..)
    , MiSymbolo(..)
    , PropertiesType(..)
    , Status(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { crs : CRS
    , features : List FeatureElement
    , quickTypeType : String
    , totalFeatures : Int
    }

type alias CRS =
    { crsType : String
    , properties : CRSProperties
    }

type alias CRSProperties =
    { name : String
    }

type alias FeatureElement =
    { featureType : FeatureType
    , geometry : Geometry
    , geometryName : GeometryName
    , id : String
    , properties : FeatureProperties
    }

type FeatureType
    = Feature

type alias Geometry =
    { coordinates : List (List (List (List Float)))
    , geometryType : GeometryType
    }

type GeometryType
    = MultiPolygon

type GeometryName
    = Geom

type alias FeatureProperties =
    { addImprov : Maybe AddImprov
    , area : Float
    , assetNumb : String
    , comments : Maybe String
    , condition : Int
    , constructi : Maybe String
    , createdate : ()
    , createuser : ()
    , disposalD : ()
    , documents : String
    , drawingNu : Maybe String
    , fileNumbe : Maybe String
    , folderNum : Maybe String
    , fundingBa : Maybe FundingBa
    , historicC : Int
    , inspection : String
    , inspectors : ()
    , lastUpdat : ()
    , levelAccu : Maybe LevelAccu
    , material : Material
    , miPrinx : Int
    , miSymbolo : MiSymbolo
    , numberLAN : Int
    , owner : Maybe String
    , positional : Maybe LevelAccu
    , projectNu : Maybe String
    , propertiesType : Maybe PropertiesType
    , recID : Int
    , recordCre : Maybe String
    , shapeArea : Float
    , shapeLeng : Float
    , status : Status
    , surveyNum : ()
    , toeRl : Float
    , topRl : Float
    , updateDAT : String
    , updatedate : ()
    , updateuser : ()
    }

type AddImprov
    = F
    | AddImprovF
    | T

type FundingBa
    = NonGCCC
    | Capex
    | Initial
    | Contribute

type LevelAccu
    = GPSCorrected10M
    | Approx
    | GPSCOrrected10M

type Material
    = Gravel
    | Concrete
    | Bitumen
    | InterlockConcBlock
    | Other
    | Earth

type MiSymbolo
    = Pen2265535Brush1016777215

type PropertiesType
    = BoatRamp

type Status
    = Current

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
        |> Jpipe.required "crs" crs
        |> Jpipe.required "features" (Jdec.list featureElement )
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "totalFeatures" Jdec.int

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("crs", encodeCRS x.crs)
        , ("features", Jenc.list encodeFeatureElement x.features)
        , ("type", Jenc.string x.quickTypeType)
        , ("totalFeatures", Jenc.int x.totalFeatures)
        ]

crs : Jdec.Decoder CRS
crs =
    Jdec.succeed CRS
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "properties" crsProperties

encodeCRS : CRS -> Jenc.Value
encodeCRS x =
    Jenc.object
        [ ("type", Jenc.string x.crsType)
        , ("properties", encodeCRSProperties x.properties)
        ]

crsProperties : Jdec.Decoder CRSProperties
crsProperties =
    Jdec.succeed CRSProperties
        |> Jpipe.required "name" Jdec.string

encodeCRSProperties : CRSProperties -> Jenc.Value
encodeCRSProperties x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        ]

featureElement : Jdec.Decoder FeatureElement
featureElement =
    Jdec.succeed FeatureElement
        |> Jpipe.required "type" featureType
        |> Jpipe.required "geometry" geometry
        |> Jpipe.required "geometry_name" geometryName
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "properties" featureProperties

encodeFeatureElement : FeatureElement -> Jenc.Value
encodeFeatureElement x =
    Jenc.object
        [ ("type", encodeFeatureType x.featureType)
        , ("geometry", encodeGeometry x.geometry)
        , ("geometry_name", encodeGeometryName x.geometryName)
        , ("id", Jenc.string x.id)
        , ("properties", encodeFeatureProperties x.properties)
        ]

featureType : Jdec.Decoder FeatureType
featureType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Feature" -> Jdec.succeed Feature
                somethingElse -> Jdec.fail <| "Invalid FeatureType: " ++ somethingElse
        )

encodeFeatureType : FeatureType -> Jenc.Value
encodeFeatureType x = case x of
    Feature -> Jenc.string "Feature"

geometry : Jdec.Decoder Geometry
geometry =
    Jdec.succeed Geometry
        |> Jpipe.required "coordinates" (Jdec.list (Jdec.list (Jdec.list (Jdec.list Jdec.float ) ) ) )
        |> Jpipe.required "type" geometryType

encodeGeometry : Geometry -> Jenc.Value
encodeGeometry x =
    Jenc.object
        [ ("coordinates", Jenc.list (Jenc.list (Jenc.list (Jenc.list Jenc.float))) x.coordinates)
        , ("type", encodeGeometryType x.geometryType)
        ]

geometryType : Jdec.Decoder GeometryType
geometryType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "MultiPolygon" -> Jdec.succeed MultiPolygon
                somethingElse -> Jdec.fail <| "Invalid GeometryType: " ++ somethingElse
        )

encodeGeometryType : GeometryType -> Jenc.Value
encodeGeometryType x = case x of
    MultiPolygon -> Jenc.string "MultiPolygon"

geometryName : Jdec.Decoder GeometryName
geometryName =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "geom" -> Jdec.succeed Geom
                somethingElse -> Jdec.fail <| "Invalid GeometryName: " ++ somethingElse
        )

encodeGeometryName : GeometryName -> Jenc.Value
encodeGeometryName x = case x of
    Geom -> Jenc.string "geom"

featureProperties : Jdec.Decoder FeatureProperties
featureProperties =
    Jdec.succeed FeatureProperties
        |> Jpipe.required "add_improv" (Jdec.nullable addImprov)
        |> Jpipe.required "area_" Jdec.float
        |> Jpipe.required "asset_numb" Jdec.string
        |> Jpipe.required "comments" (Jdec.nullable Jdec.string)
        |> Jpipe.required "condition" Jdec.int
        |> Jpipe.required "constructi" (Jdec.nullable Jdec.string)
        |> Jpipe.required "createdate" (Jdec.null ())
        |> Jpipe.required "createuser" (Jdec.null ())
        |> Jpipe.required "disposal_d" (Jdec.null ())
        |> Jpipe.required "documents" Jdec.string
        |> Jpipe.required "drawing_nu" (Jdec.nullable Jdec.string)
        |> Jpipe.required "file_numbe" (Jdec.nullable Jdec.string)
        |> Jpipe.required "folder_num" (Jdec.nullable Jdec.string)
        |> Jpipe.required "funding_ba" (Jdec.nullable fundingBa)
        |> Jpipe.required "historic_c" Jdec.int
        |> Jpipe.required "inspection" Jdec.string
        |> Jpipe.required "inspectors" (Jdec.null ())
        |> Jpipe.required "last_updat" (Jdec.null ())
        |> Jpipe.required "level_accu" (Jdec.nullable levelAccu)
        |> Jpipe.required "material" material
        |> Jpipe.required "mi_prinx" Jdec.int
        |> Jpipe.required "mi_symbolo" miSymbolo
        |> Jpipe.required "number_lan" Jdec.int
        |> Jpipe.required "owner" (Jdec.nullable Jdec.string)
        |> Jpipe.required "positional" (Jdec.nullable levelAccu)
        |> Jpipe.required "project_nu" (Jdec.nullable Jdec.string)
        |> Jpipe.required "type" (Jdec.nullable propertiesType)
        |> Jpipe.required "rec_id" Jdec.int
        |> Jpipe.required "record_cre" (Jdec.nullable Jdec.string)
        |> Jpipe.required "shape_area" Jdec.float
        |> Jpipe.required "shape_leng" Jdec.float
        |> Jpipe.required "status" status
        |> Jpipe.required "survey_num" (Jdec.null ())
        |> Jpipe.required "toe_rl" Jdec.float
        |> Jpipe.required "top_rl" Jdec.float
        |> Jpipe.required "update_dat" Jdec.string
        |> Jpipe.required "updatedate" (Jdec.null ())
        |> Jpipe.required "updateuser" (Jdec.null ())

encodeFeatureProperties : FeatureProperties -> Jenc.Value
encodeFeatureProperties x =
    Jenc.object
        [ ("add_improv", makeNullableEncoder encodeAddImprov x.addImprov)
        , ("area_", Jenc.float x.area)
        , ("asset_numb", Jenc.string x.assetNumb)
        , ("comments", makeNullableEncoder Jenc.string x.comments)
        , ("condition", Jenc.int x.condition)
        , ("constructi", makeNullableEncoder Jenc.string x.constructi)
        , ("createdate", always Jenc.null x.createdate)
        , ("createuser", always Jenc.null x.createuser)
        , ("disposal_d", always Jenc.null x.disposalD)
        , ("documents", Jenc.string x.documents)
        , ("drawing_nu", makeNullableEncoder Jenc.string x.drawingNu)
        , ("file_numbe", makeNullableEncoder Jenc.string x.fileNumbe)
        , ("folder_num", makeNullableEncoder Jenc.string x.folderNum)
        , ("funding_ba", makeNullableEncoder encodeFundingBa x.fundingBa)
        , ("historic_c", Jenc.int x.historicC)
        , ("inspection", Jenc.string x.inspection)
        , ("inspectors", always Jenc.null x.inspectors)
        , ("last_updat", always Jenc.null x.lastUpdat)
        , ("level_accu", makeNullableEncoder encodeLevelAccu x.levelAccu)
        , ("material", encodeMaterial x.material)
        , ("mi_prinx", Jenc.int x.miPrinx)
        , ("mi_symbolo", encodeMiSymbolo x.miSymbolo)
        , ("number_lan", Jenc.int x.numberLAN)
        , ("owner", makeNullableEncoder Jenc.string x.owner)
        , ("positional", makeNullableEncoder encodeLevelAccu x.positional)
        , ("project_nu", makeNullableEncoder Jenc.string x.projectNu)
        , ("type", makeNullableEncoder encodePropertiesType x.propertiesType)
        , ("rec_id", Jenc.int x.recID)
        , ("record_cre", makeNullableEncoder Jenc.string x.recordCre)
        , ("shape_area", Jenc.float x.shapeArea)
        , ("shape_leng", Jenc.float x.shapeLeng)
        , ("status", encodeStatus x.status)
        , ("survey_num", always Jenc.null x.surveyNum)
        , ("toe_rl", Jenc.float x.toeRl)
        , ("top_rl", Jenc.float x.topRl)
        , ("update_dat", Jenc.string x.updateDAT)
        , ("updatedate", always Jenc.null x.updatedate)
        , ("updateuser", always Jenc.null x.updateuser)
        ]

addImprov : Jdec.Decoder AddImprov
addImprov =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "f" -> Jdec.succeed F
                "F" -> Jdec.succeed AddImprovF
                "t" -> Jdec.succeed T
                somethingElse -> Jdec.fail <| "Invalid AddImprov: " ++ somethingElse
        )

encodeAddImprov : AddImprov -> Jenc.Value
encodeAddImprov x = case x of
    F -> Jenc.string "f"
    AddImprovF -> Jenc.string "F"
    T -> Jenc.string "t"

fundingBa : Jdec.Decoder FundingBa
fundingBa =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Non GCCC" -> Jdec.succeed NonGCCC
                "Capex" -> Jdec.succeed Capex
                "Initial" -> Jdec.succeed Initial
                "Contribute" -> Jdec.succeed Contribute
                somethingElse -> Jdec.fail <| "Invalid FundingBa: " ++ somethingElse
        )

encodeFundingBa : FundingBa -> Jenc.Value
encodeFundingBa x = case x of
    NonGCCC -> Jenc.string "Non GCCC"
    Capex -> Jenc.string "Capex"
    Initial -> Jenc.string "Initial"
    Contribute -> Jenc.string "Contribute"

levelAccu : Jdec.Decoder LevelAccu
levelAccu =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "GPS Corrected 1.0M" -> Jdec.succeed GPSCorrected10M
                "APPROX" -> Jdec.succeed Approx
                "GPS COrrected 1.0M" -> Jdec.succeed GPSCOrrected10M
                somethingElse -> Jdec.fail <| "Invalid LevelAccu: " ++ somethingElse
        )

encodeLevelAccu : LevelAccu -> Jenc.Value
encodeLevelAccu x = case x of
    GPSCorrected10M -> Jenc.string "GPS Corrected 1.0M"
    Approx -> Jenc.string "APPROX"
    GPSCOrrected10M -> Jenc.string "GPS COrrected 1.0M"

material : Jdec.Decoder Material
material =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Gravel" -> Jdec.succeed Gravel
                "Concrete" -> Jdec.succeed Concrete
                "Bitumen" -> Jdec.succeed Bitumen
                "Interlock Conc Block" -> Jdec.succeed InterlockConcBlock
                "Other" -> Jdec.succeed Other
                "Earth" -> Jdec.succeed Earth
                somethingElse -> Jdec.fail <| "Invalid Material: " ++ somethingElse
        )

encodeMaterial : Material -> Jenc.Value
encodeMaterial x = case x of
    Gravel -> Jenc.string "Gravel"
    Concrete -> Jenc.string "Concrete"
    Bitumen -> Jenc.string "Bitumen"
    InterlockConcBlock -> Jenc.string "Interlock Conc Block"
    Other -> Jenc.string "Other"
    Earth -> Jenc.string "Earth"

miSymbolo : Jdec.Decoder MiSymbolo
miSymbolo =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Pen (2, 2, 65535) Brush (1, 0, 16777215)" -> Jdec.succeed Pen2265535Brush1016777215
                somethingElse -> Jdec.fail <| "Invalid MiSymbolo: " ++ somethingElse
        )

encodeMiSymbolo : MiSymbolo -> Jenc.Value
encodeMiSymbolo x = case x of
    Pen2265535Brush1016777215 -> Jenc.string "Pen (2, 2, 65535) Brush (1, 0, 16777215)"

propertiesType : Jdec.Decoder PropertiesType
propertiesType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Boat Ramp" -> Jdec.succeed BoatRamp
                somethingElse -> Jdec.fail <| "Invalid PropertiesType: " ++ somethingElse
        )

encodePropertiesType : PropertiesType -> Jenc.Value
encodePropertiesType x = case x of
    BoatRamp -> Jenc.string "Boat Ramp"

status : Jdec.Decoder Status
status =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "CURRENT" -> Jdec.succeed Current
                somethingElse -> Jdec.fail <| "Invalid Status: " ++ somethingElse
        )

encodeStatus : Status -> Jenc.Value
encodeStatus x = case x of
    Current -> Jenc.string "CURRENT"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
