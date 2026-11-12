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
    , CerographClass
    , ChemotherapeuticClass
    , CimeliaClass
    , CoadjustClass
    , CredulityClass
    , DeruralizeClass
    , DiaereseClass
    , Encrust
    , FagginglyClass
    , FenkClass
    , FlagmakingClass
    , HemocoeleClass
    , Interacinar
    , CerographElement(..)
    , ChemotherapeuticElement(..)
    , CimeliaElement(..)
    , Clinodome(..)
    , CoadjustElement(..)
    , Consilience(..)
    , Constructor(..)
    , Continuative(..)
    , CredulityElement(..)
    , Creviced(..)
    , DeruralizeElement(..)
    , DiaereseElement(..)
    , Downstroke(..)
    , Eleutheromania(..)
    , Entomoid(..)
    , Epipaleolithic(..)
    , Expropriable(..)
    , FagginglyElement(..)
    , FenkElement(..)
    , FlagmakingElement(..)
    , Fluorometer(..)
    , Fuzzy(..)
    , Gardenward(..)
    , Generalissimo(..)
    , Hemicrystalline(..)
    , HemocoeleElement(..)
    , Hoister(..)
    , Hyperpiesi(..)
    , Hyppish(..)
    , Idealizer(..)
    , Incrustator(..)
    , Intentiveness(..)
    , Jacutinga(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { centrodesmose : String
    , cerograph : List CerographElement
    , chemotherapeutics : List ChemotherapeuticElement
    , cimelia : List CimeliaElement
    , citrated : Int
    , clinodome : List Clinodome
    , coadjust : List CoadjustElement
    , consilience : List Consilience
    , constructor : List Constructor
    , continuative : List Continuative
    , credulity : List CredulityElement
    , creviced : List Creviced
    , cubiculum : List (List (Maybe Int))
    , deruralize : List DeruralizeElement
    , diaereses : List DiaereseElement
    , dissolution : List (Maybe (List ()))
    , downstroke : List Downstroke
    , electrotautomerism : List (Maybe Float)
    , eleutheromania : List Eleutheromania
    , encrust : Encrust
    , entomoid : List Entomoid
    , epipaleolithic : List Epipaleolithic
    , expropriable : List Expropriable
    , faggingly : List FagginglyElement
    , fenks : List FenkElement
    , flagmaking : List FlagmakingElement
    , fluorometer : List Fluorometer
    , fulsome : List (Maybe Int)
    , fuzzy : List Fuzzy
    , gardenwards : List Gardenward
    , generalissimo : List Generalissimo
    , habeas : List (Maybe (Dict String Int))
    , hemicrystalline : List Hemicrystalline
    , hemocoele : List HemocoeleElement
    , hoister : List Hoister
    , hyperpiesis : List Hyperpiesi
    , hyppish : List Hyppish
    , idealizer : List Idealizer
    , incrustator : List Incrustator
    , intentiveness : List Intentiveness
    , interacinar : Interacinar
    , intercorrelation : List (Maybe (List Int))
    , jacutinga : List Jacutinga
    }

type CerographElement
    = CerographClassInCerographElement CerographClass
    | NullInCerographElement
    | StringInCerographElement String

type alias CerographClass =
    { apotropaion : ()
    , casuary : ()
    , creaker : ()
    , disqualification : ()
    , imperatorious : ()
    , impermeabilize : ()
    , metastoma : ()
    , noctidiurnal : ()
    , nonreserve : ()
    , ophthalmotonometry : ()
    , pailful : ()
    , pigfish : ()
    , pongee : ()
    , prosodical : ()
    , scrofuloderm : ()
    , storekeeping : ()
    , therologist : ()
    , tolowa : ()
    , tradeful : ()
    , unriveting : ()
    }

type ChemotherapeuticElement
    = ChemotherapeuticClassInChemotherapeuticElement ChemotherapeuticClass
    | IntegerInChemotherapeuticElement Int

type alias ChemotherapeuticClass =
    { angioneurotic : Maybe ()
    , availment : Maybe ()
    , bladelet : Maybe ()
    , catharticalness : Maybe Float
    , caulis : Maybe ()
    , chalcus : Maybe ()
    , chirotherium : Maybe Int
    , disdiapason : Maybe String
    , enteradenological : Maybe ()
    , homocerc : Maybe Bool
    , imporosity : Maybe ()
    , insistently : Maybe ()
    , intraparietal : Maybe ()
    , ivied : Maybe ()
    , maureen : Maybe ()
    , nonbookish : Maybe ()
    , nostochine : Maybe ()
    , nutcracker : Maybe ()
    , ofttimes : Maybe ()
    , phenocryst : Maybe ()
    , precoincident : Maybe ()
    , ramiferous : Maybe ()
    , stagmometer : Maybe ()
    , tetherball : Maybe ()
    , unshy : Maybe ()
    }

type CimeliaElement
    = CimeliaClassInCimeliaElement CimeliaClass
    | IntegerArrayInCimeliaElement (List Int)
    | NullInCimeliaElement

type alias CimeliaClass =
    { catharticalness : Float
    , chirotherium : Int
    , disdiapason : String
    , homocerc : Bool
    , nonbookish : ()
    }

type Clinodome
    = DoubleInClinodome Float
    | StringInClinodome String

type CoadjustElement
    = CoadjustClassInCoadjustElement CoadjustClass
    | DoubleInCoadjustElement Float

type alias CoadjustClass =
    { amidosulphonal : Maybe ()
    , benny : Maybe ()
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , disdiapason : Maybe String
    , ensnare : Maybe ()
    , homocerc : Maybe Bool
    , hybridizer : Maybe ()
    , leastwise : Maybe ()
    , lof : Maybe ()
    , monkhood : Maybe ()
    , netherlandish : Maybe ()
    , nonbookish : Maybe ()
    , peonism : Maybe ()
    , phonelescope : Maybe ()
    , porphyrogeniture : Maybe ()
    , preindemnify : Maybe ()
    , rosal : Maybe ()
    , scalenous : Maybe ()
    , scopine : Maybe ()
    , sedaceae : Maybe ()
    , suberinize : Maybe ()
    , symbiot : Maybe ()
    , tablefellow : Maybe ()
    , unchargeable : Maybe ()
    }

type Consilience
    = DoubleInConsilience Float
    | IntegerMapInConsilience (Dict String Int)

type Constructor
    = BoolInConstructor Bool
    | UnionMapInConstructor (Dict String (Maybe Int))

type Continuative
    = IntegerMapInContinuative (Dict String Int)
    | StringInContinuative String

type CredulityElement
    = CredulityClassInCredulityElement CredulityClass
    | IntegerInCredulityElement Int
    | StringInCredulityElement String

type alias CredulityClass =
    { ammonolytic : ()
    , bushmaster : ()
    , considering : ()
    , consuetudinary : ()
    , embarras : ()
    , fineness : ()
    , flaithship : ()
    , flavia : ()
    , gruffly : ()
    , hedychium : ()
    , leadwort : ()
    , overseriously : ()
    , parabola : ()
    , pectinatodenticulate : ()
    , popean : ()
    , pornocrat : ()
    , quadrisect : ()
    , seriality : ()
    , vamphorn : ()
    , wharp : ()
    }

type Creviced
    = BoolInCreviced Bool
    | IntegerMapInCreviced (Dict String Int)
    | StringInCreviced String

type DeruralizeElement
    = BoolInDeruralizeElement Bool
    | DeruralizeClassInDeruralizeElement DeruralizeClass
    | NullArrayInDeruralizeElement (List ())

type alias DeruralizeClass =
    { bockerel : ()
    , boulder : ()
    , churrus : ()
    , counterdigged : ()
    , dialogite : ()
    , digenic : ()
    , dunbird : ()
    , ergatogyne : ()
    , fiendful : ()
    , jackrod : ()
    , jehovistic : ()
    , paninean : ()
    , panther : ()
    , placentigerous : ()
    , romney : ()
    , sparm : ()
    , tocsin : ()
    , unnicked : ()
    , unstavable : ()
    , windfirm : ()
    }

type DiaereseElement
    = BoolInDiaereseElement Bool
    | DiaereseClassInDiaereseElement DiaereseClass
    | IntegerArrayInDiaereseElement (List Int)

type alias DiaereseClass =
    { amoreuxia : ()
    , ani : ()
    , bernicle : ()
    , blackwasher : ()
    , blowhard : ()
    , broma : ()
    , closecross : ()
    , congregationalism : ()
    , grayly : ()
    , historically : ()
    , hoast : ()
    , irretentive : ()
    , parcener : ()
    , pedder : ()
    , pseudoanatomic : ()
    , rhizocarpian : ()
    , samel : ()
    , silker : ()
    , subdentated : ()
    , subobscure : ()
    }

type Downstroke
    = BoolInDownstroke Bool
    | NullArrayInDownstroke (List ())
    | StringInDownstroke String

type Eleutheromania
    = DoubleInEleutheromania Float
    | IntegerMapInEleutheromania (Dict String Int)
    | StringInEleutheromania String

type alias Encrust =
    { comradely : ()
    , diacanthous : ()
    , feminineness : ()
    , gossamered : ()
    , hibernia : ()
    , hibiscus : ()
    , lepidosauria : ()
    , lollingly : ()
    , manager : ()
    , mechanic : ()
    , overminuteness : ()
    , papelonne : ()
    , plebification : ()
    , pugmiller : ()
    , recoveror : ()
    , spermatoblastic : ()
    , syllidae : ()
    , ungyved : ()
    , whirlabout : ()
    , woodenware : ()
    }

type Entomoid
    = CimeliaClassInEntomoid CimeliaClass
    | IntegerInEntomoid Int

type Epipaleolithic
    = DoubleInEpipaleolithic Float
    | IntegerArrayInEpipaleolithic (List Int)

type Expropriable
    = CimeliaClassInExpropriable CimeliaClass
    | DoubleInExpropriable Float
    | NullArrayInExpropriable (List ())

type FagginglyElement
    = DoubleInFagginglyElement Float
    | FagginglyClassInFagginglyElement FagginglyClass

type alias FagginglyClass =
    { abranchian : ()
    , aculeiform : ()
    , adiaphoristic : ()
    , adoptionism : ()
    , anglic : ()
    , antrotomy : ()
    , coerciveness : ()
    , decorist : ()
    , duckhood : ()
    , heteromeri : ()
    , hypochnose : ()
    , lochage : ()
    , melee : ()
    , nonconformitant : ()
    , poinsettia : ()
    , putatively : ()
    , semivolatile : ()
    , soleas : ()
    , unfastenable : ()
    , unmillinered : ()
    }

type FenkElement
    = FenkClassInFenkElement FenkClass
    | StringInFenkElement String

type alias FenkClass =
    { apoise : ()
    , astronomize : ()
    , cockhorse : ()
    , copular : ()
    , dagomba : ()
    , draffy : ()
    , foreigner : ()
    , guyandot : ()
    , neurogliosis : ()
    , osmious : ()
    , palpitate : ()
    , rebukeable : ()
    , reinwardtia : ()
    , reservatory : ()
    , scalt : ()
    , scripturalize : ()
    , tintometer : ()
    , tritoness : ()
    , undergrade : ()
    , undermountain : ()
    }

type FlagmakingElement
    = BoolInFlagmakingElement Bool
    | DoubleInFlagmakingElement Float
    | FlagmakingClassInFlagmakingElement FlagmakingClass

type alias FlagmakingClass =
    { albarco : ()
    , bunodonta : ()
    , hornify : ()
    , hydrocorisae : ()
    , hypoglossus : ()
    , inexpiably : ()
    , ingratitude : ()
    , ladyfly : ()
    , medicament : ()
    , monogrammatic : ()
    , nobbut : ()
    , notacanthidae : ()
    , polyplacophore : ()
    , proexercise : ()
    , protoplast : ()
    , puzzling : ()
    , splanchnoskeleton : ()
    , unloveliness : ()
    , unquarantined : ()
    , unrenounceable : ()
    }

type Fluorometer
    = IntegerInFluorometer Int
    | NullInFluorometer
    | StringInFluorometer String

type Fuzzy
    = IntegerInFuzzy Int
    | UnionMapInFuzzy (Dict String (Maybe Int))

type Gardenward
    = BoolInGardenward Bool
    | IntegerArrayInGardenward (List Int)
    | StringInGardenward String

type Generalissimo
    = BoolInGeneralissimo Bool
    | IntegerMapInGeneralissimo (Dict String Int)
    | NullInGeneralissimo

type Hemicrystalline
    = CimeliaClassInHemicrystalline CimeliaClass
    | StringInHemicrystalline String

type HemocoeleElement
    = HemocoeleClassInHemocoeleElement HemocoeleClass
    | IntegerArrayInHemocoeleElement (List Int)

type alias HemocoeleClass =
    { acrogamy : Maybe ()
    , amelification : Maybe ()
    , autobiographic : Maybe ()
    , berat : Maybe ()
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , disdiapason : Maybe String
    , disproportionably : Maybe ()
    , erythrite : Maybe ()
    , graphic : Maybe ()
    , hepatological : Maybe ()
    , homocerc : Maybe Bool
    , incommensurably : Maybe ()
    , misaffirm : Maybe ()
    , nonbookish : Maybe ()
    , pocketbook : Maybe ()
    , sclerometric : Maybe ()
    , stambouline : Maybe ()
    , stickpin : Maybe ()
    , tubulure : Maybe ()
    , undelated : Maybe ()
    , unsalt : Maybe ()
    , untutelar : Maybe ()
    , vagrant : Maybe ()
    , walt : Maybe ()
    }

type Hoister
    = CimeliaClassInHoister CimeliaClass
    | NullInHoister
    | StringInHoister String

type Hyperpiesi
    = CimeliaClassInHyperpiesi CimeliaClass
    | NullArrayInHyperpiesi (List ())
    | NullInHyperpiesi

type Hyppish
    = BoolInHyppish Bool
    | NullInHyppish
    | StringInHyppish String

type Idealizer
    = CimeliaClassInIdealizer CimeliaClass
    | IntegerInIdealizer Int
    | NullArrayInIdealizer (List ())

type Incrustator
    = IntegerArrayInIncrustator (List Int)
    | IntegerInIncrustator Int
    | StringInIncrustator String

type Intentiveness
    = CimeliaClassInIntentiveness CimeliaClass
    | DoubleInIntentiveness Float
    | StringInIntentiveness String

type alias Interacinar =
    { assapan : Float
    , benefactorship : Bool
    , triseriatim : String
    , tubbing : Int
    , untrimmed : ()
    }

type Jacutinga
    = IntegerArrayInJacutinga (List Int)
    | UnionMapInJacutinga (Dict String (Maybe Int))

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
        |> Jpipe.required "centrodesmose" Jdec.string
        |> Jpipe.required "cerograph" (Jdec.list cerographElement )
        |> Jpipe.required "chemotherapeutics" (Jdec.list chemotherapeuticElement )
        |> Jpipe.required "cimelia" (Jdec.list cimeliaElement )
        |> Jpipe.required "citrated" Jdec.int
        |> Jpipe.required "clinodome" (Jdec.list clinodome )
        |> Jpipe.required "coadjust" (Jdec.list coadjustElement )
        |> Jpipe.required "consilience" (Jdec.list consilience )
        |> Jpipe.required "constructor" (Jdec.list constructor )
        |> Jpipe.required "continuative" (Jdec.list continuative )
        |> Jpipe.required "credulity" (Jdec.list credulityElement )
        |> Jpipe.required "creviced" (Jdec.list creviced )
        |> Jpipe.required "cubiculum" (Jdec.list (Jdec.list (Jdec.nullable Jdec.int) ) )
        |> Jpipe.required "deruralize" (Jdec.list deruralizeElement )
        |> Jpipe.required "diaereses" (Jdec.list diaereseElement )
        |> Jpipe.required "dissolution" (Jdec.list (Jdec.nullable (Jdec.list (Jdec.null ()) )) )
        |> Jpipe.required "downstroke" (Jdec.list downstroke )
        |> Jpipe.required "electrotautomerism" (Jdec.list (Jdec.nullable Jdec.float) )
        |> Jpipe.required "eleutheromania" (Jdec.list eleutheromania )
        |> Jpipe.required "encrust" encrust
        |> Jpipe.required "entomoid" (Jdec.list entomoid )
        |> Jpipe.required "epipaleolithic" (Jdec.list epipaleolithic )
        |> Jpipe.required "expropriable" (Jdec.list expropriable )
        |> Jpipe.required "faggingly" (Jdec.list fagginglyElement )
        |> Jpipe.required "fenks" (Jdec.list fenkElement )
        |> Jpipe.required "flagmaking" (Jdec.list flagmakingElement )
        |> Jpipe.required "fluorometer" (Jdec.list fluorometer )
        |> Jpipe.required "fulsome" (Jdec.list (Jdec.nullable Jdec.int) )
        |> Jpipe.required "fuzzy" (Jdec.list fuzzy )
        |> Jpipe.required "gardenwards" (Jdec.list gardenward )
        |> Jpipe.required "generalissimo" (Jdec.list generalissimo )
        |> Jpipe.required "habeas" (Jdec.list (Jdec.nullable (Jdec.dict Jdec.int)) )
        |> Jpipe.required "hemicrystalline" (Jdec.list hemicrystalline )
        |> Jpipe.required "hemocoele" (Jdec.list hemocoeleElement )
        |> Jpipe.required "hoister" (Jdec.list hoister )
        |> Jpipe.required "hyperpiesis" (Jdec.list hyperpiesi )
        |> Jpipe.required "hyppish" (Jdec.list hyppish )
        |> Jpipe.required "idealizer" (Jdec.list idealizer )
        |> Jpipe.required "incrustator" (Jdec.list incrustator )
        |> Jpipe.required "intentiveness" (Jdec.list intentiveness )
        |> Jpipe.required "interacinar" interacinar
        |> Jpipe.required "intercorrelation" (Jdec.list (Jdec.nullable (Jdec.list Jdec.int )) )
        |> Jpipe.required "jacutinga" (Jdec.list jacutinga )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("centrodesmose", Jenc.string x.centrodesmose)
        , ("cerograph", Jenc.list encodeCerographElement x.cerograph)
        , ("chemotherapeutics", Jenc.list encodeChemotherapeuticElement x.chemotherapeutics)
        , ("cimelia", Jenc.list encodeCimeliaElement x.cimelia)
        , ("citrated", Jenc.int x.citrated)
        , ("clinodome", Jenc.list encodeClinodome x.clinodome)
        , ("coadjust", Jenc.list encodeCoadjustElement x.coadjust)
        , ("consilience", Jenc.list encodeConsilience x.consilience)
        , ("constructor", Jenc.list encodeConstructor x.constructor)
        , ("continuative", Jenc.list encodeContinuative x.continuative)
        , ("credulity", Jenc.list encodeCredulityElement x.credulity)
        , ("creviced", Jenc.list encodeCreviced x.creviced)
        , ("cubiculum", Jenc.list (Jenc.list (makeNullableEncoder Jenc.int)) x.cubiculum)
        , ("deruralize", Jenc.list encodeDeruralizeElement x.deruralize)
        , ("diaereses", Jenc.list encodeDiaereseElement x.diaereses)
        , ("dissolution", Jenc.list (makeNullableEncoder (Jenc.list (always Jenc.null))) x.dissolution)
        , ("downstroke", Jenc.list encodeDownstroke x.downstroke)
        , ("electrotautomerism", Jenc.list (makeNullableEncoder Jenc.float) x.electrotautomerism)
        , ("eleutheromania", Jenc.list encodeEleutheromania x.eleutheromania)
        , ("encrust", encodeEncrust x.encrust)
        , ("entomoid", Jenc.list encodeEntomoid x.entomoid)
        , ("epipaleolithic", Jenc.list encodeEpipaleolithic x.epipaleolithic)
        , ("expropriable", Jenc.list encodeExpropriable x.expropriable)
        , ("faggingly", Jenc.list encodeFagginglyElement x.faggingly)
        , ("fenks", Jenc.list encodeFenkElement x.fenks)
        , ("flagmaking", Jenc.list encodeFlagmakingElement x.flagmaking)
        , ("fluorometer", Jenc.list encodeFluorometer x.fluorometer)
        , ("fulsome", Jenc.list (makeNullableEncoder Jenc.int) x.fulsome)
        , ("fuzzy", Jenc.list encodeFuzzy x.fuzzy)
        , ("gardenwards", Jenc.list encodeGardenward x.gardenwards)
        , ("generalissimo", Jenc.list encodeGeneralissimo x.generalissimo)
        , ("habeas", Jenc.list (makeNullableEncoder (Jenc.dict identity Jenc.int)) x.habeas)
        , ("hemicrystalline", Jenc.list encodeHemicrystalline x.hemicrystalline)
        , ("hemocoele", Jenc.list encodeHemocoeleElement x.hemocoele)
        , ("hoister", Jenc.list encodeHoister x.hoister)
        , ("hyperpiesis", Jenc.list encodeHyperpiesi x.hyperpiesis)
        , ("hyppish", Jenc.list encodeHyppish x.hyppish)
        , ("idealizer", Jenc.list encodeIdealizer x.idealizer)
        , ("incrustator", Jenc.list encodeIncrustator x.incrustator)
        , ("intentiveness", Jenc.list encodeIntentiveness x.intentiveness)
        , ("interacinar", encodeInteracinar x.interacinar)
        , ("intercorrelation", Jenc.list (makeNullableEncoder (Jenc.list Jenc.int)) x.intercorrelation)
        , ("jacutinga", Jenc.list encodeJacutinga x.jacutinga)
        ]

cerographElement : Jdec.Decoder CerographElement
cerographElement =
    Jdec.oneOf
        [ Jdec.null NullInCerographElement
        , Jdec.map StringInCerographElement Jdec.string
        , Jdec.map CerographClassInCerographElement cerographClass
        ]

encodeCerographElement : CerographElement -> Jenc.Value
encodeCerographElement x = case x of
    NullInCerographElement -> Jenc.null
    StringInCerographElement y -> Jenc.string y
    CerographClassInCerographElement y -> encodeCerographClass y

cerographClass : Jdec.Decoder CerographClass
cerographClass =
    Jdec.succeed CerographClass
        |> Jpipe.required "apotropaion" (Jdec.null ())
        |> Jpipe.required "casuary" (Jdec.null ())
        |> Jpipe.required "creaker" (Jdec.null ())
        |> Jpipe.required "disqualification" (Jdec.null ())
        |> Jpipe.required "imperatorious" (Jdec.null ())
        |> Jpipe.required "impermeabilize" (Jdec.null ())
        |> Jpipe.required "metastoma" (Jdec.null ())
        |> Jpipe.required "noctidiurnal" (Jdec.null ())
        |> Jpipe.required "nonreserve" (Jdec.null ())
        |> Jpipe.required "ophthalmotonometry" (Jdec.null ())
        |> Jpipe.required "pailful" (Jdec.null ())
        |> Jpipe.required "pigfish" (Jdec.null ())
        |> Jpipe.required "pongee" (Jdec.null ())
        |> Jpipe.required "prosodical" (Jdec.null ())
        |> Jpipe.required "scrofuloderm" (Jdec.null ())
        |> Jpipe.required "storekeeping" (Jdec.null ())
        |> Jpipe.required "therologist" (Jdec.null ())
        |> Jpipe.required "Tolowa" (Jdec.null ())
        |> Jpipe.required "tradeful" (Jdec.null ())
        |> Jpipe.required "unriveting" (Jdec.null ())

encodeCerographClass : CerographClass -> Jenc.Value
encodeCerographClass x =
    Jenc.object
        [ ("apotropaion", always Jenc.null x.apotropaion)
        , ("casuary", always Jenc.null x.casuary)
        , ("creaker", always Jenc.null x.creaker)
        , ("disqualification", always Jenc.null x.disqualification)
        , ("imperatorious", always Jenc.null x.imperatorious)
        , ("impermeabilize", always Jenc.null x.impermeabilize)
        , ("metastoma", always Jenc.null x.metastoma)
        , ("noctidiurnal", always Jenc.null x.noctidiurnal)
        , ("nonreserve", always Jenc.null x.nonreserve)
        , ("ophthalmotonometry", always Jenc.null x.ophthalmotonometry)
        , ("pailful", always Jenc.null x.pailful)
        , ("pigfish", always Jenc.null x.pigfish)
        , ("pongee", always Jenc.null x.pongee)
        , ("prosodical", always Jenc.null x.prosodical)
        , ("scrofuloderm", always Jenc.null x.scrofuloderm)
        , ("storekeeping", always Jenc.null x.storekeeping)
        , ("therologist", always Jenc.null x.therologist)
        , ("Tolowa", always Jenc.null x.tolowa)
        , ("tradeful", always Jenc.null x.tradeful)
        , ("unriveting", always Jenc.null x.unriveting)
        ]

chemotherapeuticElement : Jdec.Decoder ChemotherapeuticElement
chemotherapeuticElement =
    Jdec.oneOf
        [ Jdec.map IntegerInChemotherapeuticElement Jdec.int
        , Jdec.map ChemotherapeuticClassInChemotherapeuticElement chemotherapeuticClass
        ]

encodeChemotherapeuticElement : ChemotherapeuticElement -> Jenc.Value
encodeChemotherapeuticElement x = case x of
    IntegerInChemotherapeuticElement y -> Jenc.int y
    ChemotherapeuticClassInChemotherapeuticElement y -> encodeChemotherapeuticClass y

chemotherapeuticClass : Jdec.Decoder ChemotherapeuticClass
chemotherapeuticClass =
    Jdec.succeed ChemotherapeuticClass
        |> Jpipe.custom (optionalField "angioneurotic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "availment" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "bladelet" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "caulis" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "chalcus" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "enteradenological" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "imporosity" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "insistently" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "intraparietal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ivied" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Maureen" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nostochine" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nutcracker" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ofttimes" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "phenocryst" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "precoincident" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ramiferous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "stagmometer" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tetherball" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unshy" (Jdec.nullable (Jdec.null ())) Nothing)

encodeChemotherapeuticClass : ChemotherapeuticClass -> Jenc.Value
encodeChemotherapeuticClass x =
    Jenc.object
        [ ("angioneurotic", makeNullableEncoder (always Jenc.null) x.angioneurotic)
        , ("availment", makeNullableEncoder (always Jenc.null) x.availment)
        , ("bladelet", makeNullableEncoder (always Jenc.null) x.bladelet)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("caulis", makeNullableEncoder (always Jenc.null) x.caulis)
        , ("chalcus", makeNullableEncoder (always Jenc.null) x.chalcus)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("enteradenological", makeNullableEncoder (always Jenc.null) x.enteradenological)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("imporosity", makeNullableEncoder (always Jenc.null) x.imporosity)
        , ("insistently", makeNullableEncoder (always Jenc.null) x.insistently)
        , ("intraparietal", makeNullableEncoder (always Jenc.null) x.intraparietal)
        , ("ivied", makeNullableEncoder (always Jenc.null) x.ivied)
        , ("Maureen", makeNullableEncoder (always Jenc.null) x.maureen)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("nostochine", makeNullableEncoder (always Jenc.null) x.nostochine)
        , ("nutcracker", makeNullableEncoder (always Jenc.null) x.nutcracker)
        , ("ofttimes", makeNullableEncoder (always Jenc.null) x.ofttimes)
        , ("phenocryst", makeNullableEncoder (always Jenc.null) x.phenocryst)
        , ("precoincident", makeNullableEncoder (always Jenc.null) x.precoincident)
        , ("ramiferous", makeNullableEncoder (always Jenc.null) x.ramiferous)
        , ("stagmometer", makeNullableEncoder (always Jenc.null) x.stagmometer)
        , ("tetherball", makeNullableEncoder (always Jenc.null) x.tetherball)
        , ("unshy", makeNullableEncoder (always Jenc.null) x.unshy)
        ]

cimeliaElement : Jdec.Decoder CimeliaElement
cimeliaElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInCimeliaElement (Jdec.list Jdec.int )
        , Jdec.null NullInCimeliaElement
        , Jdec.map CimeliaClassInCimeliaElement cimeliaClass
        ]

encodeCimeliaElement : CimeliaElement -> Jenc.Value
encodeCimeliaElement x = case x of
    IntegerArrayInCimeliaElement y -> Jenc.list Jenc.int y
    NullInCimeliaElement -> Jenc.null
    CimeliaClassInCimeliaElement y -> encodeCimeliaClass y

cimeliaClass : Jdec.Decoder CimeliaClass
cimeliaClass =
    Jdec.succeed CimeliaClass
        |> Jpipe.required "catharticalness" Jdec.float
        |> Jpipe.required "Chirotherium" Jdec.int
        |> Jpipe.required "disdiapason" Jdec.string
        |> Jpipe.required "homocerc" Jdec.bool
        |> Jpipe.required "nonbookish" (Jdec.null ())

encodeCimeliaClass : CimeliaClass -> Jenc.Value
encodeCimeliaClass x =
    Jenc.object
        [ ("catharticalness", Jenc.float x.catharticalness)
        , ("Chirotherium", Jenc.int x.chirotherium)
        , ("disdiapason", Jenc.string x.disdiapason)
        , ("homocerc", Jenc.bool x.homocerc)
        , ("nonbookish", always Jenc.null x.nonbookish)
        ]

clinodome : Jdec.Decoder Clinodome
clinodome =
    Jdec.oneOf
        [ Jdec.map StringInClinodome Jdec.string
        , Jdec.map DoubleInClinodome Jdec.float
        ]

encodeClinodome : Clinodome -> Jenc.Value
encodeClinodome x = case x of
    StringInClinodome y -> Jenc.string y
    DoubleInClinodome y -> Jenc.float y

coadjustElement : Jdec.Decoder CoadjustElement
coadjustElement =
    Jdec.oneOf
        [ Jdec.map DoubleInCoadjustElement Jdec.float
        , Jdec.map CoadjustClassInCoadjustElement coadjustClass
        ]

encodeCoadjustElement : CoadjustElement -> Jenc.Value
encodeCoadjustElement x = case x of
    DoubleInCoadjustElement y -> Jenc.float y
    CoadjustClassInCoadjustElement y -> encodeCoadjustClass y

coadjustClass : Jdec.Decoder CoadjustClass
coadjustClass =
    Jdec.succeed CoadjustClass
        |> Jpipe.custom (optionalField "amidosulphonal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Benny" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ensnare" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "hybridizer" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "leastwise" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "lof" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "monkhood" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Netherlandish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "peonism" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Phonelescope" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "porphyrogeniture" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "preindemnify" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "rosal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "scalenous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "scopine" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Sedaceae" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "suberinize" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "symbiot" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tablefellow" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unchargeable" (Jdec.nullable (Jdec.null ())) Nothing)

encodeCoadjustClass : CoadjustClass -> Jenc.Value
encodeCoadjustClass x =
    Jenc.object
        [ ("amidosulphonal", makeNullableEncoder (always Jenc.null) x.amidosulphonal)
        , ("Benny", makeNullableEncoder (always Jenc.null) x.benny)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("ensnare", makeNullableEncoder (always Jenc.null) x.ensnare)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("hybridizer", makeNullableEncoder (always Jenc.null) x.hybridizer)
        , ("leastwise", makeNullableEncoder (always Jenc.null) x.leastwise)
        , ("lof", makeNullableEncoder (always Jenc.null) x.lof)
        , ("monkhood", makeNullableEncoder (always Jenc.null) x.monkhood)
        , ("Netherlandish", makeNullableEncoder (always Jenc.null) x.netherlandish)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("peonism", makeNullableEncoder (always Jenc.null) x.peonism)
        , ("Phonelescope", makeNullableEncoder (always Jenc.null) x.phonelescope)
        , ("porphyrogeniture", makeNullableEncoder (always Jenc.null) x.porphyrogeniture)
        , ("preindemnify", makeNullableEncoder (always Jenc.null) x.preindemnify)
        , ("rosal", makeNullableEncoder (always Jenc.null) x.rosal)
        , ("scalenous", makeNullableEncoder (always Jenc.null) x.scalenous)
        , ("scopine", makeNullableEncoder (always Jenc.null) x.scopine)
        , ("Sedaceae", makeNullableEncoder (always Jenc.null) x.sedaceae)
        , ("suberinize", makeNullableEncoder (always Jenc.null) x.suberinize)
        , ("symbiot", makeNullableEncoder (always Jenc.null) x.symbiot)
        , ("tablefellow", makeNullableEncoder (always Jenc.null) x.tablefellow)
        , ("unchargeable", makeNullableEncoder (always Jenc.null) x.unchargeable)
        ]

consilience : Jdec.Decoder Consilience
consilience =
    Jdec.oneOf
        [ Jdec.map DoubleInConsilience Jdec.float
        , Jdec.map IntegerMapInConsilience (Jdec.dict Jdec.int)
        ]

encodeConsilience : Consilience -> Jenc.Value
encodeConsilience x = case x of
    DoubleInConsilience y -> Jenc.float y
    IntegerMapInConsilience y -> Jenc.dict identity Jenc.int y

constructor : Jdec.Decoder Constructor
constructor =
    Jdec.oneOf
        [ Jdec.map BoolInConstructor Jdec.bool
        , Jdec.map UnionMapInConstructor (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodeConstructor : Constructor -> Jenc.Value
encodeConstructor x = case x of
    BoolInConstructor y -> Jenc.bool y
    UnionMapInConstructor y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

continuative : Jdec.Decoder Continuative
continuative =
    Jdec.oneOf
        [ Jdec.map StringInContinuative Jdec.string
        , Jdec.map IntegerMapInContinuative (Jdec.dict Jdec.int)
        ]

encodeContinuative : Continuative -> Jenc.Value
encodeContinuative x = case x of
    StringInContinuative y -> Jenc.string y
    IntegerMapInContinuative y -> Jenc.dict identity Jenc.int y

credulityElement : Jdec.Decoder CredulityElement
credulityElement =
    Jdec.oneOf
        [ Jdec.map IntegerInCredulityElement Jdec.int
        , Jdec.map StringInCredulityElement Jdec.string
        , Jdec.map CredulityClassInCredulityElement credulityClass
        ]

encodeCredulityElement : CredulityElement -> Jenc.Value
encodeCredulityElement x = case x of
    IntegerInCredulityElement y -> Jenc.int y
    StringInCredulityElement y -> Jenc.string y
    CredulityClassInCredulityElement y -> encodeCredulityClass y

credulityClass : Jdec.Decoder CredulityClass
credulityClass =
    Jdec.succeed CredulityClass
        |> Jpipe.required "ammonolytic" (Jdec.null ())
        |> Jpipe.required "bushmaster" (Jdec.null ())
        |> Jpipe.required "considering" (Jdec.null ())
        |> Jpipe.required "consuetudinary" (Jdec.null ())
        |> Jpipe.required "embarras" (Jdec.null ())
        |> Jpipe.required "fineness" (Jdec.null ())
        |> Jpipe.required "flaithship" (Jdec.null ())
        |> Jpipe.required "Flavia" (Jdec.null ())
        |> Jpipe.required "gruffly" (Jdec.null ())
        |> Jpipe.required "Hedychium" (Jdec.null ())
        |> Jpipe.required "leadwort" (Jdec.null ())
        |> Jpipe.required "overseriously" (Jdec.null ())
        |> Jpipe.required "parabola" (Jdec.null ())
        |> Jpipe.required "pectinatodenticulate" (Jdec.null ())
        |> Jpipe.required "Popean" (Jdec.null ())
        |> Jpipe.required "pornocrat" (Jdec.null ())
        |> Jpipe.required "quadrisect" (Jdec.null ())
        |> Jpipe.required "seriality" (Jdec.null ())
        |> Jpipe.required "vamphorn" (Jdec.null ())
        |> Jpipe.required "wharp" (Jdec.null ())

encodeCredulityClass : CredulityClass -> Jenc.Value
encodeCredulityClass x =
    Jenc.object
        [ ("ammonolytic", always Jenc.null x.ammonolytic)
        , ("bushmaster", always Jenc.null x.bushmaster)
        , ("considering", always Jenc.null x.considering)
        , ("consuetudinary", always Jenc.null x.consuetudinary)
        , ("embarras", always Jenc.null x.embarras)
        , ("fineness", always Jenc.null x.fineness)
        , ("flaithship", always Jenc.null x.flaithship)
        , ("Flavia", always Jenc.null x.flavia)
        , ("gruffly", always Jenc.null x.gruffly)
        , ("Hedychium", always Jenc.null x.hedychium)
        , ("leadwort", always Jenc.null x.leadwort)
        , ("overseriously", always Jenc.null x.overseriously)
        , ("parabola", always Jenc.null x.parabola)
        , ("pectinatodenticulate", always Jenc.null x.pectinatodenticulate)
        , ("Popean", always Jenc.null x.popean)
        , ("pornocrat", always Jenc.null x.pornocrat)
        , ("quadrisect", always Jenc.null x.quadrisect)
        , ("seriality", always Jenc.null x.seriality)
        , ("vamphorn", always Jenc.null x.vamphorn)
        , ("wharp", always Jenc.null x.wharp)
        ]

creviced : Jdec.Decoder Creviced
creviced =
    Jdec.oneOf
        [ Jdec.map BoolInCreviced Jdec.bool
        , Jdec.map StringInCreviced Jdec.string
        , Jdec.map IntegerMapInCreviced (Jdec.dict Jdec.int)
        ]

encodeCreviced : Creviced -> Jenc.Value
encodeCreviced x = case x of
    BoolInCreviced y -> Jenc.bool y
    StringInCreviced y -> Jenc.string y
    IntegerMapInCreviced y -> Jenc.dict identity Jenc.int y

deruralizeElement : Jdec.Decoder DeruralizeElement
deruralizeElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInDeruralizeElement (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInDeruralizeElement Jdec.bool
        , Jdec.map DeruralizeClassInDeruralizeElement deruralizeClass
        ]

encodeDeruralizeElement : DeruralizeElement -> Jenc.Value
encodeDeruralizeElement x = case x of
    NullArrayInDeruralizeElement y -> Jenc.list (always Jenc.null) y
    BoolInDeruralizeElement y -> Jenc.bool y
    DeruralizeClassInDeruralizeElement y -> encodeDeruralizeClass y

deruralizeClass : Jdec.Decoder DeruralizeClass
deruralizeClass =
    Jdec.succeed DeruralizeClass
        |> Jpipe.required "bockerel" (Jdec.null ())
        |> Jpipe.required "boulder" (Jdec.null ())
        |> Jpipe.required "churrus" (Jdec.null ())
        |> Jpipe.required "counterdigged" (Jdec.null ())
        |> Jpipe.required "dialogite" (Jdec.null ())
        |> Jpipe.required "digenic" (Jdec.null ())
        |> Jpipe.required "dunbird" (Jdec.null ())
        |> Jpipe.required "ergatogyne" (Jdec.null ())
        |> Jpipe.required "fiendful" (Jdec.null ())
        |> Jpipe.required "jackrod" (Jdec.null ())
        |> Jpipe.required "Jehovistic" (Jdec.null ())
        |> Jpipe.required "Paninean" (Jdec.null ())
        |> Jpipe.required "panther" (Jdec.null ())
        |> Jpipe.required "placentigerous" (Jdec.null ())
        |> Jpipe.required "Romney" (Jdec.null ())
        |> Jpipe.required "sparm" (Jdec.null ())
        |> Jpipe.required "tocsin" (Jdec.null ())
        |> Jpipe.required "unnicked" (Jdec.null ())
        |> Jpipe.required "unstavable" (Jdec.null ())
        |> Jpipe.required "windfirm" (Jdec.null ())

encodeDeruralizeClass : DeruralizeClass -> Jenc.Value
encodeDeruralizeClass x =
    Jenc.object
        [ ("bockerel", always Jenc.null x.bockerel)
        , ("boulder", always Jenc.null x.boulder)
        , ("churrus", always Jenc.null x.churrus)
        , ("counterdigged", always Jenc.null x.counterdigged)
        , ("dialogite", always Jenc.null x.dialogite)
        , ("digenic", always Jenc.null x.digenic)
        , ("dunbird", always Jenc.null x.dunbird)
        , ("ergatogyne", always Jenc.null x.ergatogyne)
        , ("fiendful", always Jenc.null x.fiendful)
        , ("jackrod", always Jenc.null x.jackrod)
        , ("Jehovistic", always Jenc.null x.jehovistic)
        , ("Paninean", always Jenc.null x.paninean)
        , ("panther", always Jenc.null x.panther)
        , ("placentigerous", always Jenc.null x.placentigerous)
        , ("Romney", always Jenc.null x.romney)
        , ("sparm", always Jenc.null x.sparm)
        , ("tocsin", always Jenc.null x.tocsin)
        , ("unnicked", always Jenc.null x.unnicked)
        , ("unstavable", always Jenc.null x.unstavable)
        , ("windfirm", always Jenc.null x.windfirm)
        ]

diaereseElement : Jdec.Decoder DiaereseElement
diaereseElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInDiaereseElement (Jdec.list Jdec.int )
        , Jdec.map BoolInDiaereseElement Jdec.bool
        , Jdec.map DiaereseClassInDiaereseElement diaereseClass
        ]

encodeDiaereseElement : DiaereseElement -> Jenc.Value
encodeDiaereseElement x = case x of
    IntegerArrayInDiaereseElement y -> Jenc.list Jenc.int y
    BoolInDiaereseElement y -> Jenc.bool y
    DiaereseClassInDiaereseElement y -> encodeDiaereseClass y

diaereseClass : Jdec.Decoder DiaereseClass
diaereseClass =
    Jdec.succeed DiaereseClass
        |> Jpipe.required "Amoreuxia" (Jdec.null ())
        |> Jpipe.required "ani" (Jdec.null ())
        |> Jpipe.required "bernicle" (Jdec.null ())
        |> Jpipe.required "blackwasher" (Jdec.null ())
        |> Jpipe.required "blowhard" (Jdec.null ())
        |> Jpipe.required "broma" (Jdec.null ())
        |> Jpipe.required "closecross" (Jdec.null ())
        |> Jpipe.required "congregationalism" (Jdec.null ())
        |> Jpipe.required "grayly" (Jdec.null ())
        |> Jpipe.required "historically" (Jdec.null ())
        |> Jpipe.required "hoast" (Jdec.null ())
        |> Jpipe.required "irretentive" (Jdec.null ())
        |> Jpipe.required "parcener" (Jdec.null ())
        |> Jpipe.required "pedder" (Jdec.null ())
        |> Jpipe.required "pseudoanatomic" (Jdec.null ())
        |> Jpipe.required "rhizocarpian" (Jdec.null ())
        |> Jpipe.required "samel" (Jdec.null ())
        |> Jpipe.required "silker" (Jdec.null ())
        |> Jpipe.required "subdentated" (Jdec.null ())
        |> Jpipe.required "subobscure" (Jdec.null ())

encodeDiaereseClass : DiaereseClass -> Jenc.Value
encodeDiaereseClass x =
    Jenc.object
        [ ("Amoreuxia", always Jenc.null x.amoreuxia)
        , ("ani", always Jenc.null x.ani)
        , ("bernicle", always Jenc.null x.bernicle)
        , ("blackwasher", always Jenc.null x.blackwasher)
        , ("blowhard", always Jenc.null x.blowhard)
        , ("broma", always Jenc.null x.broma)
        , ("closecross", always Jenc.null x.closecross)
        , ("congregationalism", always Jenc.null x.congregationalism)
        , ("grayly", always Jenc.null x.grayly)
        , ("historically", always Jenc.null x.historically)
        , ("hoast", always Jenc.null x.hoast)
        , ("irretentive", always Jenc.null x.irretentive)
        , ("parcener", always Jenc.null x.parcener)
        , ("pedder", always Jenc.null x.pedder)
        , ("pseudoanatomic", always Jenc.null x.pseudoanatomic)
        , ("rhizocarpian", always Jenc.null x.rhizocarpian)
        , ("samel", always Jenc.null x.samel)
        , ("silker", always Jenc.null x.silker)
        , ("subdentated", always Jenc.null x.subdentated)
        , ("subobscure", always Jenc.null x.subobscure)
        ]

downstroke : Jdec.Decoder Downstroke
downstroke =
    Jdec.oneOf
        [ Jdec.map NullArrayInDownstroke (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInDownstroke Jdec.bool
        , Jdec.map StringInDownstroke Jdec.string
        ]

encodeDownstroke : Downstroke -> Jenc.Value
encodeDownstroke x = case x of
    NullArrayInDownstroke y -> Jenc.list (always Jenc.null) y
    BoolInDownstroke y -> Jenc.bool y
    StringInDownstroke y -> Jenc.string y

eleutheromania : Jdec.Decoder Eleutheromania
eleutheromania =
    Jdec.oneOf
        [ Jdec.map StringInEleutheromania Jdec.string
        , Jdec.map DoubleInEleutheromania Jdec.float
        , Jdec.map IntegerMapInEleutheromania (Jdec.dict Jdec.int)
        ]

encodeEleutheromania : Eleutheromania -> Jenc.Value
encodeEleutheromania x = case x of
    StringInEleutheromania y -> Jenc.string y
    DoubleInEleutheromania y -> Jenc.float y
    IntegerMapInEleutheromania y -> Jenc.dict identity Jenc.int y

encrust : Jdec.Decoder Encrust
encrust =
    Jdec.succeed Encrust
        |> Jpipe.required "comradely" (Jdec.null ())
        |> Jpipe.required "diacanthous" (Jdec.null ())
        |> Jpipe.required "feminineness" (Jdec.null ())
        |> Jpipe.required "gossamered" (Jdec.null ())
        |> Jpipe.required "Hibernia" (Jdec.null ())
        |> Jpipe.required "Hibiscus" (Jdec.null ())
        |> Jpipe.required "Lepidosauria" (Jdec.null ())
        |> Jpipe.required "lollingly" (Jdec.null ())
        |> Jpipe.required "manager" (Jdec.null ())
        |> Jpipe.required "mechanic" (Jdec.null ())
        |> Jpipe.required "overminuteness" (Jdec.null ())
        |> Jpipe.required "papelonne" (Jdec.null ())
        |> Jpipe.required "plebification" (Jdec.null ())
        |> Jpipe.required "pugmiller" (Jdec.null ())
        |> Jpipe.required "recoveror" (Jdec.null ())
        |> Jpipe.required "spermatoblastic" (Jdec.null ())
        |> Jpipe.required "Syllidae" (Jdec.null ())
        |> Jpipe.required "ungyved" (Jdec.null ())
        |> Jpipe.required "whirlabout" (Jdec.null ())
        |> Jpipe.required "woodenware" (Jdec.null ())

encodeEncrust : Encrust -> Jenc.Value
encodeEncrust x =
    Jenc.object
        [ ("comradely", always Jenc.null x.comradely)
        , ("diacanthous", always Jenc.null x.diacanthous)
        , ("feminineness", always Jenc.null x.feminineness)
        , ("gossamered", always Jenc.null x.gossamered)
        , ("Hibernia", always Jenc.null x.hibernia)
        , ("Hibiscus", always Jenc.null x.hibiscus)
        , ("Lepidosauria", always Jenc.null x.lepidosauria)
        , ("lollingly", always Jenc.null x.lollingly)
        , ("manager", always Jenc.null x.manager)
        , ("mechanic", always Jenc.null x.mechanic)
        , ("overminuteness", always Jenc.null x.overminuteness)
        , ("papelonne", always Jenc.null x.papelonne)
        , ("plebification", always Jenc.null x.plebification)
        , ("pugmiller", always Jenc.null x.pugmiller)
        , ("recoveror", always Jenc.null x.recoveror)
        , ("spermatoblastic", always Jenc.null x.spermatoblastic)
        , ("Syllidae", always Jenc.null x.syllidae)
        , ("ungyved", always Jenc.null x.ungyved)
        , ("whirlabout", always Jenc.null x.whirlabout)
        , ("woodenware", always Jenc.null x.woodenware)
        ]

entomoid : Jdec.Decoder Entomoid
entomoid =
    Jdec.oneOf
        [ Jdec.map IntegerInEntomoid Jdec.int
        , Jdec.map CimeliaClassInEntomoid cimeliaClass
        ]

encodeEntomoid : Entomoid -> Jenc.Value
encodeEntomoid x = case x of
    IntegerInEntomoid y -> Jenc.int y
    CimeliaClassInEntomoid y -> encodeCimeliaClass y

epipaleolithic : Jdec.Decoder Epipaleolithic
epipaleolithic =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInEpipaleolithic (Jdec.list Jdec.int )
        , Jdec.map DoubleInEpipaleolithic Jdec.float
        ]

encodeEpipaleolithic : Epipaleolithic -> Jenc.Value
encodeEpipaleolithic x = case x of
    IntegerArrayInEpipaleolithic y -> Jenc.list Jenc.int y
    DoubleInEpipaleolithic y -> Jenc.float y

expropriable : Jdec.Decoder Expropriable
expropriable =
    Jdec.oneOf
        [ Jdec.map NullArrayInExpropriable (Jdec.list (Jdec.null ()) )
        , Jdec.map DoubleInExpropriable Jdec.float
        , Jdec.map CimeliaClassInExpropriable cimeliaClass
        ]

encodeExpropriable : Expropriable -> Jenc.Value
encodeExpropriable x = case x of
    NullArrayInExpropriable y -> Jenc.list (always Jenc.null) y
    DoubleInExpropriable y -> Jenc.float y
    CimeliaClassInExpropriable y -> encodeCimeliaClass y

fagginglyElement : Jdec.Decoder FagginglyElement
fagginglyElement =
    Jdec.oneOf
        [ Jdec.map DoubleInFagginglyElement Jdec.float
        , Jdec.map FagginglyClassInFagginglyElement fagginglyClass
        ]

encodeFagginglyElement : FagginglyElement -> Jenc.Value
encodeFagginglyElement x = case x of
    DoubleInFagginglyElement y -> Jenc.float y
    FagginglyClassInFagginglyElement y -> encodeFagginglyClass y

fagginglyClass : Jdec.Decoder FagginglyClass
fagginglyClass =
    Jdec.succeed FagginglyClass
        |> Jpipe.required "abranchian" (Jdec.null ())
        |> Jpipe.required "aculeiform" (Jdec.null ())
        |> Jpipe.required "adiaphoristic" (Jdec.null ())
        |> Jpipe.required "adoptionism" (Jdec.null ())
        |> Jpipe.required "Anglic" (Jdec.null ())
        |> Jpipe.required "antrotomy" (Jdec.null ())
        |> Jpipe.required "coerciveness" (Jdec.null ())
        |> Jpipe.required "decorist" (Jdec.null ())
        |> Jpipe.required "duckhood" (Jdec.null ())
        |> Jpipe.required "Heteromeri" (Jdec.null ())
        |> Jpipe.required "hypochnose" (Jdec.null ())
        |> Jpipe.required "lochage" (Jdec.null ())
        |> Jpipe.required "melee" (Jdec.null ())
        |> Jpipe.required "nonconformitant" (Jdec.null ())
        |> Jpipe.required "Poinsettia" (Jdec.null ())
        |> Jpipe.required "putatively" (Jdec.null ())
        |> Jpipe.required "semivolatile" (Jdec.null ())
        |> Jpipe.required "soleas" (Jdec.null ())
        |> Jpipe.required "unfastenable" (Jdec.null ())
        |> Jpipe.required "unmillinered" (Jdec.null ())

encodeFagginglyClass : FagginglyClass -> Jenc.Value
encodeFagginglyClass x =
    Jenc.object
        [ ("abranchian", always Jenc.null x.abranchian)
        , ("aculeiform", always Jenc.null x.aculeiform)
        , ("adiaphoristic", always Jenc.null x.adiaphoristic)
        , ("adoptionism", always Jenc.null x.adoptionism)
        , ("Anglic", always Jenc.null x.anglic)
        , ("antrotomy", always Jenc.null x.antrotomy)
        , ("coerciveness", always Jenc.null x.coerciveness)
        , ("decorist", always Jenc.null x.decorist)
        , ("duckhood", always Jenc.null x.duckhood)
        , ("Heteromeri", always Jenc.null x.heteromeri)
        , ("hypochnose", always Jenc.null x.hypochnose)
        , ("lochage", always Jenc.null x.lochage)
        , ("melee", always Jenc.null x.melee)
        , ("nonconformitant", always Jenc.null x.nonconformitant)
        , ("Poinsettia", always Jenc.null x.poinsettia)
        , ("putatively", always Jenc.null x.putatively)
        , ("semivolatile", always Jenc.null x.semivolatile)
        , ("soleas", always Jenc.null x.soleas)
        , ("unfastenable", always Jenc.null x.unfastenable)
        , ("unmillinered", always Jenc.null x.unmillinered)
        ]

fenkElement : Jdec.Decoder FenkElement
fenkElement =
    Jdec.oneOf
        [ Jdec.map StringInFenkElement Jdec.string
        , Jdec.map FenkClassInFenkElement fenkClass
        ]

encodeFenkElement : FenkElement -> Jenc.Value
encodeFenkElement x = case x of
    StringInFenkElement y -> Jenc.string y
    FenkClassInFenkElement y -> encodeFenkClass y

fenkClass : Jdec.Decoder FenkClass
fenkClass =
    Jdec.succeed FenkClass
        |> Jpipe.required "apoise" (Jdec.null ())
        |> Jpipe.required "astronomize" (Jdec.null ())
        |> Jpipe.required "cockhorse" (Jdec.null ())
        |> Jpipe.required "copular" (Jdec.null ())
        |> Jpipe.required "Dagomba" (Jdec.null ())
        |> Jpipe.required "draffy" (Jdec.null ())
        |> Jpipe.required "foreigner" (Jdec.null ())
        |> Jpipe.required "Guyandot" (Jdec.null ())
        |> Jpipe.required "neurogliosis" (Jdec.null ())
        |> Jpipe.required "osmious" (Jdec.null ())
        |> Jpipe.required "palpitate" (Jdec.null ())
        |> Jpipe.required "rebukeable" (Jdec.null ())
        |> Jpipe.required "Reinwardtia" (Jdec.null ())
        |> Jpipe.required "reservatory" (Jdec.null ())
        |> Jpipe.required "scalt" (Jdec.null ())
        |> Jpipe.required "scripturalize" (Jdec.null ())
        |> Jpipe.required "tintometer" (Jdec.null ())
        |> Jpipe.required "Tritoness" (Jdec.null ())
        |> Jpipe.required "undergrade" (Jdec.null ())
        |> Jpipe.required "undermountain" (Jdec.null ())

encodeFenkClass : FenkClass -> Jenc.Value
encodeFenkClass x =
    Jenc.object
        [ ("apoise", always Jenc.null x.apoise)
        , ("astronomize", always Jenc.null x.astronomize)
        , ("cockhorse", always Jenc.null x.cockhorse)
        , ("copular", always Jenc.null x.copular)
        , ("Dagomba", always Jenc.null x.dagomba)
        , ("draffy", always Jenc.null x.draffy)
        , ("foreigner", always Jenc.null x.foreigner)
        , ("Guyandot", always Jenc.null x.guyandot)
        , ("neurogliosis", always Jenc.null x.neurogliosis)
        , ("osmious", always Jenc.null x.osmious)
        , ("palpitate", always Jenc.null x.palpitate)
        , ("rebukeable", always Jenc.null x.rebukeable)
        , ("Reinwardtia", always Jenc.null x.reinwardtia)
        , ("reservatory", always Jenc.null x.reservatory)
        , ("scalt", always Jenc.null x.scalt)
        , ("scripturalize", always Jenc.null x.scripturalize)
        , ("tintometer", always Jenc.null x.tintometer)
        , ("Tritoness", always Jenc.null x.tritoness)
        , ("undergrade", always Jenc.null x.undergrade)
        , ("undermountain", always Jenc.null x.undermountain)
        ]

flagmakingElement : Jdec.Decoder FlagmakingElement
flagmakingElement =
    Jdec.oneOf
        [ Jdec.map BoolInFlagmakingElement Jdec.bool
        , Jdec.map DoubleInFlagmakingElement Jdec.float
        , Jdec.map FlagmakingClassInFlagmakingElement flagmakingClass
        ]

encodeFlagmakingElement : FlagmakingElement -> Jenc.Value
encodeFlagmakingElement x = case x of
    BoolInFlagmakingElement y -> Jenc.bool y
    DoubleInFlagmakingElement y -> Jenc.float y
    FlagmakingClassInFlagmakingElement y -> encodeFlagmakingClass y

flagmakingClass : Jdec.Decoder FlagmakingClass
flagmakingClass =
    Jdec.succeed FlagmakingClass
        |> Jpipe.required "albarco" (Jdec.null ())
        |> Jpipe.required "Bunodonta" (Jdec.null ())
        |> Jpipe.required "hornify" (Jdec.null ())
        |> Jpipe.required "Hydrocorisae" (Jdec.null ())
        |> Jpipe.required "hypoglossus" (Jdec.null ())
        |> Jpipe.required "inexpiably" (Jdec.null ())
        |> Jpipe.required "ingratitude" (Jdec.null ())
        |> Jpipe.required "ladyfly" (Jdec.null ())
        |> Jpipe.required "medicament" (Jdec.null ())
        |> Jpipe.required "monogrammatic" (Jdec.null ())
        |> Jpipe.required "nobbut" (Jdec.null ())
        |> Jpipe.required "Notacanthidae" (Jdec.null ())
        |> Jpipe.required "polyplacophore" (Jdec.null ())
        |> Jpipe.required "proexercise" (Jdec.null ())
        |> Jpipe.required "protoplast" (Jdec.null ())
        |> Jpipe.required "puzzling" (Jdec.null ())
        |> Jpipe.required "splanchnoskeleton" (Jdec.null ())
        |> Jpipe.required "unloveliness" (Jdec.null ())
        |> Jpipe.required "unquarantined" (Jdec.null ())
        |> Jpipe.required "unrenounceable" (Jdec.null ())

encodeFlagmakingClass : FlagmakingClass -> Jenc.Value
encodeFlagmakingClass x =
    Jenc.object
        [ ("albarco", always Jenc.null x.albarco)
        , ("Bunodonta", always Jenc.null x.bunodonta)
        , ("hornify", always Jenc.null x.hornify)
        , ("Hydrocorisae", always Jenc.null x.hydrocorisae)
        , ("hypoglossus", always Jenc.null x.hypoglossus)
        , ("inexpiably", always Jenc.null x.inexpiably)
        , ("ingratitude", always Jenc.null x.ingratitude)
        , ("ladyfly", always Jenc.null x.ladyfly)
        , ("medicament", always Jenc.null x.medicament)
        , ("monogrammatic", always Jenc.null x.monogrammatic)
        , ("nobbut", always Jenc.null x.nobbut)
        , ("Notacanthidae", always Jenc.null x.notacanthidae)
        , ("polyplacophore", always Jenc.null x.polyplacophore)
        , ("proexercise", always Jenc.null x.proexercise)
        , ("protoplast", always Jenc.null x.protoplast)
        , ("puzzling", always Jenc.null x.puzzling)
        , ("splanchnoskeleton", always Jenc.null x.splanchnoskeleton)
        , ("unloveliness", always Jenc.null x.unloveliness)
        , ("unquarantined", always Jenc.null x.unquarantined)
        , ("unrenounceable", always Jenc.null x.unrenounceable)
        ]

fluorometer : Jdec.Decoder Fluorometer
fluorometer =
    Jdec.oneOf
        [ Jdec.map IntegerInFluorometer Jdec.int
        , Jdec.null NullInFluorometer
        , Jdec.map StringInFluorometer Jdec.string
        ]

encodeFluorometer : Fluorometer -> Jenc.Value
encodeFluorometer x = case x of
    IntegerInFluorometer y -> Jenc.int y
    NullInFluorometer -> Jenc.null
    StringInFluorometer y -> Jenc.string y

fuzzy : Jdec.Decoder Fuzzy
fuzzy =
    Jdec.oneOf
        [ Jdec.map IntegerInFuzzy Jdec.int
        , Jdec.map UnionMapInFuzzy (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodeFuzzy : Fuzzy -> Jenc.Value
encodeFuzzy x = case x of
    IntegerInFuzzy y -> Jenc.int y
    UnionMapInFuzzy y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

gardenward : Jdec.Decoder Gardenward
gardenward =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInGardenward (Jdec.list Jdec.int )
        , Jdec.map BoolInGardenward Jdec.bool
        , Jdec.map StringInGardenward Jdec.string
        ]

encodeGardenward : Gardenward -> Jenc.Value
encodeGardenward x = case x of
    IntegerArrayInGardenward y -> Jenc.list Jenc.int y
    BoolInGardenward y -> Jenc.bool y
    StringInGardenward y -> Jenc.string y

generalissimo : Jdec.Decoder Generalissimo
generalissimo =
    Jdec.oneOf
        [ Jdec.map BoolInGeneralissimo Jdec.bool
        , Jdec.null NullInGeneralissimo
        , Jdec.map IntegerMapInGeneralissimo (Jdec.dict Jdec.int)
        ]

encodeGeneralissimo : Generalissimo -> Jenc.Value
encodeGeneralissimo x = case x of
    BoolInGeneralissimo y -> Jenc.bool y
    NullInGeneralissimo -> Jenc.null
    IntegerMapInGeneralissimo y -> Jenc.dict identity Jenc.int y

hemicrystalline : Jdec.Decoder Hemicrystalline
hemicrystalline =
    Jdec.oneOf
        [ Jdec.map StringInHemicrystalline Jdec.string
        , Jdec.map CimeliaClassInHemicrystalline cimeliaClass
        ]

encodeHemicrystalline : Hemicrystalline -> Jenc.Value
encodeHemicrystalline x = case x of
    StringInHemicrystalline y -> Jenc.string y
    CimeliaClassInHemicrystalline y -> encodeCimeliaClass y

hemocoeleElement : Jdec.Decoder HemocoeleElement
hemocoeleElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInHemocoeleElement (Jdec.list Jdec.int )
        , Jdec.map HemocoeleClassInHemocoeleElement hemocoeleClass
        ]

encodeHemocoeleElement : HemocoeleElement -> Jenc.Value
encodeHemocoeleElement x = case x of
    IntegerArrayInHemocoeleElement y -> Jenc.list Jenc.int y
    HemocoeleClassInHemocoeleElement y -> encodeHemocoeleClass y

hemocoeleClass : Jdec.Decoder HemocoeleClass
hemocoeleClass =
    Jdec.succeed HemocoeleClass
        |> Jpipe.custom (optionalField "acrogamy" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "amelification" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "autobiographic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "berat" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "disproportionably" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "erythrite" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "graphic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "hepatological" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "incommensurably" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "misaffirm" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "pocketbook" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "sclerometric" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "stambouline" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "stickpin" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tubulure" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "undelated" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unsalt" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "untutelar" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "vagrant" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Walt" (Jdec.nullable (Jdec.null ())) Nothing)

encodeHemocoeleClass : HemocoeleClass -> Jenc.Value
encodeHemocoeleClass x =
    Jenc.object
        [ ("acrogamy", makeNullableEncoder (always Jenc.null) x.acrogamy)
        , ("amelification", makeNullableEncoder (always Jenc.null) x.amelification)
        , ("autobiographic", makeNullableEncoder (always Jenc.null) x.autobiographic)
        , ("berat", makeNullableEncoder (always Jenc.null) x.berat)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("disproportionably", makeNullableEncoder (always Jenc.null) x.disproportionably)
        , ("erythrite", makeNullableEncoder (always Jenc.null) x.erythrite)
        , ("graphic", makeNullableEncoder (always Jenc.null) x.graphic)
        , ("hepatological", makeNullableEncoder (always Jenc.null) x.hepatological)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("incommensurably", makeNullableEncoder (always Jenc.null) x.incommensurably)
        , ("misaffirm", makeNullableEncoder (always Jenc.null) x.misaffirm)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("pocketbook", makeNullableEncoder (always Jenc.null) x.pocketbook)
        , ("sclerometric", makeNullableEncoder (always Jenc.null) x.sclerometric)
        , ("stambouline", makeNullableEncoder (always Jenc.null) x.stambouline)
        , ("stickpin", makeNullableEncoder (always Jenc.null) x.stickpin)
        , ("tubulure", makeNullableEncoder (always Jenc.null) x.tubulure)
        , ("undelated", makeNullableEncoder (always Jenc.null) x.undelated)
        , ("unsalt", makeNullableEncoder (always Jenc.null) x.unsalt)
        , ("untutelar", makeNullableEncoder (always Jenc.null) x.untutelar)
        , ("vagrant", makeNullableEncoder (always Jenc.null) x.vagrant)
        , ("Walt", makeNullableEncoder (always Jenc.null) x.walt)
        ]

hoister : Jdec.Decoder Hoister
hoister =
    Jdec.oneOf
        [ Jdec.null NullInHoister
        , Jdec.map StringInHoister Jdec.string
        , Jdec.map CimeliaClassInHoister cimeliaClass
        ]

encodeHoister : Hoister -> Jenc.Value
encodeHoister x = case x of
    NullInHoister -> Jenc.null
    StringInHoister y -> Jenc.string y
    CimeliaClassInHoister y -> encodeCimeliaClass y

hyperpiesi : Jdec.Decoder Hyperpiesi
hyperpiesi =
    Jdec.oneOf
        [ Jdec.map NullArrayInHyperpiesi (Jdec.list (Jdec.null ()) )
        , Jdec.null NullInHyperpiesi
        , Jdec.map CimeliaClassInHyperpiesi cimeliaClass
        ]

encodeHyperpiesi : Hyperpiesi -> Jenc.Value
encodeHyperpiesi x = case x of
    NullArrayInHyperpiesi y -> Jenc.list (always Jenc.null) y
    NullInHyperpiesi -> Jenc.null
    CimeliaClassInHyperpiesi y -> encodeCimeliaClass y

hyppish : Jdec.Decoder Hyppish
hyppish =
    Jdec.oneOf
        [ Jdec.map BoolInHyppish Jdec.bool
        , Jdec.null NullInHyppish
        , Jdec.map StringInHyppish Jdec.string
        ]

encodeHyppish : Hyppish -> Jenc.Value
encodeHyppish x = case x of
    BoolInHyppish y -> Jenc.bool y
    NullInHyppish -> Jenc.null
    StringInHyppish y -> Jenc.string y

idealizer : Jdec.Decoder Idealizer
idealizer =
    Jdec.oneOf
        [ Jdec.map NullArrayInIdealizer (Jdec.list (Jdec.null ()) )
        , Jdec.map IntegerInIdealizer Jdec.int
        , Jdec.map CimeliaClassInIdealizer cimeliaClass
        ]

encodeIdealizer : Idealizer -> Jenc.Value
encodeIdealizer x = case x of
    NullArrayInIdealizer y -> Jenc.list (always Jenc.null) y
    IntegerInIdealizer y -> Jenc.int y
    CimeliaClassInIdealizer y -> encodeCimeliaClass y

incrustator : Jdec.Decoder Incrustator
incrustator =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInIncrustator (Jdec.list Jdec.int )
        , Jdec.map IntegerInIncrustator Jdec.int
        , Jdec.map StringInIncrustator Jdec.string
        ]

encodeIncrustator : Incrustator -> Jenc.Value
encodeIncrustator x = case x of
    IntegerArrayInIncrustator y -> Jenc.list Jenc.int y
    IntegerInIncrustator y -> Jenc.int y
    StringInIncrustator y -> Jenc.string y

intentiveness : Jdec.Decoder Intentiveness
intentiveness =
    Jdec.oneOf
        [ Jdec.map StringInIntentiveness Jdec.string
        , Jdec.map DoubleInIntentiveness Jdec.float
        , Jdec.map CimeliaClassInIntentiveness cimeliaClass
        ]

encodeIntentiveness : Intentiveness -> Jenc.Value
encodeIntentiveness x = case x of
    StringInIntentiveness y -> Jenc.string y
    DoubleInIntentiveness y -> Jenc.float y
    CimeliaClassInIntentiveness y -> encodeCimeliaClass y

interacinar : Jdec.Decoder Interacinar
interacinar =
    Jdec.succeed Interacinar
        |> Jpipe.required "assapan" Jdec.float
        |> Jpipe.required "benefactorship" Jdec.bool
        |> Jpipe.required "triseriatim" Jdec.string
        |> Jpipe.required "tubbing" Jdec.int
        |> Jpipe.required "untrimmed" (Jdec.null ())

encodeInteracinar : Interacinar -> Jenc.Value
encodeInteracinar x =
    Jenc.object
        [ ("assapan", Jenc.float x.assapan)
        , ("benefactorship", Jenc.bool x.benefactorship)
        , ("triseriatim", Jenc.string x.triseriatim)
        , ("tubbing", Jenc.int x.tubbing)
        , ("untrimmed", always Jenc.null x.untrimmed)
        ]

jacutinga : Jdec.Decoder Jacutinga
jacutinga =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInJacutinga (Jdec.list Jdec.int )
        , Jdec.map UnionMapInJacutinga (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodeJacutinga : Jacutinga -> Jenc.Value
encodeJacutinga x = case x of
    IntegerArrayInJacutinga y -> Jenc.list Jenc.int y
    UnionMapInJacutinga y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
