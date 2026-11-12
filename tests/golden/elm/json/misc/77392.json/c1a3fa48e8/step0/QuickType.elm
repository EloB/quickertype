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
    , QuickTypeElement
    , OrbitClass(..)
    , Pha(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { designation : String
    , discoveryDate : String
    , hMag : Maybe String
    , iDeg : String
    , moidAu : String
    , orbitClass : OrbitClass
    , periodYr : Maybe String
    , pha : Pha
    , qAu1 : String
    , qAu2 : Maybe String
    }

type OrbitClass
    = Apollo
    | Amor
    | Aten
    | Comet
    | JupiterFamilyComet
    | HalleyTypeComet
    | ParabolicComet
    | OrbitClassJupiterFamilyComet
    | EnckeTypeComet

type Pha
    = Y
    | N
    | NA

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeElement r)

quickTypeElement : Jdec.Decoder QuickTypeElement
quickTypeElement =
    Jdec.succeed QuickTypeElement
        |> Jpipe.required "designation" Jdec.string
        |> Jpipe.required "discovery_date" Jdec.string
        |> Jpipe.custom (optionalField "h_mag" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "i_deg" Jdec.string
        |> Jpipe.required "moid_au" Jdec.string
        |> Jpipe.required "orbit_class" orbitClass
        |> Jpipe.custom (optionalField "period_yr" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "pha" pha
        |> Jpipe.required "q_au_1" Jdec.string
        |> Jpipe.custom (optionalField "q_au_2" (Jdec.map Just Jdec.string) Nothing)

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("designation", Jenc.string x.designation)
        , ("discovery_date", Jenc.string x.discoveryDate)
        , ("h_mag", makeNullableEncoder Jenc.string x.hMag)
        , ("i_deg", Jenc.string x.iDeg)
        , ("moid_au", Jenc.string x.moidAu)
        , ("orbit_class", encodeOrbitClass x.orbitClass)
        , ("period_yr", makeNullableEncoder Jenc.string x.periodYr)
        , ("pha", encodePha x.pha)
        , ("q_au_1", Jenc.string x.qAu1)
        , ("q_au_2", makeNullableEncoder Jenc.string x.qAu2)
        ]

orbitClass : Jdec.Decoder OrbitClass
orbitClass =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Apollo" -> Jdec.succeed Apollo
                "Amor" -> Jdec.succeed Amor
                "Aten" -> Jdec.succeed Aten
                "Comet" -> Jdec.succeed Comet
                "Jupiter-family Comet" -> Jdec.succeed JupiterFamilyComet
                "Halley-type Comet*" -> Jdec.succeed HalleyTypeComet
                "Parabolic Comet" -> Jdec.succeed ParabolicComet
                "Jupiter-family Comet*" -> Jdec.succeed OrbitClassJupiterFamilyComet
                "Encke-type Comet" -> Jdec.succeed EnckeTypeComet
                somethingElse -> Jdec.fail <| "Invalid OrbitClass: " ++ somethingElse
        )

encodeOrbitClass : OrbitClass -> Jenc.Value
encodeOrbitClass x = case x of
    Apollo -> Jenc.string "Apollo"
    Amor -> Jenc.string "Amor"
    Aten -> Jenc.string "Aten"
    Comet -> Jenc.string "Comet"
    JupiterFamilyComet -> Jenc.string "Jupiter-family Comet"
    HalleyTypeComet -> Jenc.string "Halley-type Comet*"
    ParabolicComet -> Jenc.string "Parabolic Comet"
    OrbitClassJupiterFamilyComet -> Jenc.string "Jupiter-family Comet*"
    EnckeTypeComet -> Jenc.string "Encke-type Comet"

pha : Jdec.Decoder Pha
pha =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Y" -> Jdec.succeed Y
                "N" -> Jdec.succeed N
                "n/a" -> Jdec.succeed NA
                somethingElse -> Jdec.fail <| "Invalid Pha: " ++ somethingElse
        )

encodePha : Pha -> Jenc.Value
encodePha x = case x of
    Y -> Jenc.string "Y"
    N -> Jenc.string "N"
    NA -> Jenc.string "n/a"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
