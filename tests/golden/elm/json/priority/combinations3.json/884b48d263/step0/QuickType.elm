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
    , JurorClass
    , LadronismClass
    , LandlubberlyClass
    , LupusClass
    , Maslin
    , MonaziteClass
    , MonotheisticallyClass
    , Noncontributing
    , OccupationalistClass
    , OutrivalClass
    , PiaculumClass
    , Pneumocele
    , PotwhiskyClass
    , PrefreshmanClass
    , JurorElement(..)
    , Kongoni(..)
    , LadronismElement(..)
    , LandlubberlyElement(..)
    , Listener(..)
    , LupusElement(..)
    , MonaziteElement(..)
    , Monoliteral(..)
    , MonotheisticallyElement(..)
    , Montage(..)
    , Moralness(..)
    , Mulishly(..)
    , Myoscope(..)
    , Neuromastic(..)
    , Nonnervous(..)
    , Nonvaluation(..)
    , OccupationalistElement(..)
    , OutrivalElement(..)
    , Paleographically(..)
    , Pamphletwise(..)
    , Pediatric(..)
    , PiaculumElement(..)
    , Piccadilly(..)
    , Piffler(..)
    , Pithful(..)
    , Placuntiti(..)
    , Plectopterous(..)
    , Poliorcetic(..)
    , Poormaster(..)
    , PotwhiskyElement(..)
    , Practicalizer(..)
    , PrefreshmanElement(..)
    , Prehensility(..)
    , Prevoidance(..)
    , Protext(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { juror : List JurorElement
    , kongoni : List Kongoni
    , ladronism : List LadronismElement
    , landlubberly : List LandlubberlyElement
    , listener : List Listener
    , lupus : List LupusElement
    , maslin : List Maslin
    , monazite : List MonaziteElement
    , monoliteral : List Monoliteral
    , monotheistically : List MonotheisticallyElement
    , montage : List Montage
    , moralness : List Moralness
    , mowra : List (Maybe MonaziteClass)
    , mulishly : List Mulishly
    , myoscope : List Myoscope
    , nach : List (Maybe (List (Maybe Int)))
    , neuromastic : List Neuromastic
    , noncontributing : List Noncontributing
    , nonnervous : List Nonnervous
    , nonvaluation : List Nonvaluation
    , occupationalist : List OccupationalistElement
    , outrival : List OutrivalElement
    , paleographically : List Paleographically
    , pamphletwise : List Pamphletwise
    , pediatrics : List Pediatric
    , perceptive : List Bool
    , piaculum : List PiaculumElement
    , piccadilly : List Piccadilly
    , piffler : List Piffler
    , pithful : List Pithful
    , placuntitis : List Placuntiti
    , plectopterous : List Plectopterous
    , pneumocele : List (Maybe Pneumocele)
    , poliorcetic : List Poliorcetic
    , poormaster : List Poormaster
    , potwhisky : List PotwhiskyElement
    , practicalizer : List Practicalizer
    , prefreshman : List PrefreshmanElement
    , prehensility : List Prehensility
    , prevoidance : List Prevoidance
    , probant : List (Dict String (Maybe Int))
    , protext : List Protext
    }

type JurorElement
    = BoolInJurorElement Bool
    | JurorClassInJurorElement JurorClass

type alias JurorClass =
    { adipsy : ()
    , auxiliator : ()
    , benda : ()
    , benjamin : ()
    , brandling : ()
    , epicurishly : ()
    , eremochaetous : ()
    , marten : ()
    , monocline : ()
    , olea : ()
    , palgat : ()
    , pennyworth : ()
    , pioury : ()
    , pragmatistic : ()
    , stylelessness : ()
    , systematical : ()
    , thready : ()
    , uncontemporary : ()
    , uncouched : ()
    , uninhabitedness : ()
    }

type Kongoni
    = IntegerArrayInKongoni (List Int)
    | IntegerMapInKongoni (Dict String Int)

type LadronismElement
    = DoubleInLadronismElement Float
    | LadronismClassInLadronismElement LadronismClass
    | StringInLadronismElement String

type alias LadronismClass =
    { acclaimer : ()
    , achree : ()
    , base : ()
    , conundrumize : ()
    , degerminator : ()
    , describable : ()
    , exasperatedly : ()
    , heroine : ()
    , indazin : ()
    , luteous : ()
    , papular : ()
    , pritch : ()
    , prodenia : ()
    , seege : ()
    , shopgirl : ()
    , tragedietta : ()
    , unsparse : ()
    , uplook : ()
    , vermiformis : ()
    , whafabout : ()
    }

type LandlubberlyElement
    = BoolInLandlubberlyElement Bool
    | IntegerInLandlubberlyElement Int
    | LandlubberlyClassInLandlubberlyElement LandlubberlyClass

type alias LandlubberlyClass =
    { acropoleis : ()
    , aminate : ()
    , amyraldism : ()
    , bipenniform : ()
    , bugre : ()
    , calycule : ()
    , caoutchouc : ()
    , disprover : ()
    , fitroot : ()
    , fulgently : ()
    , kickup : ()
    , laevoversion : ()
    , moter : ()
    , objectivity : ()
    , posterity : ()
    , postnuptial : ()
    , precedentary : ()
    , saddling : ()
    , subcurrent : ()
    , unrecriminative : ()
    }

type Listener
    = IntegerInListener Int
    | NullArrayInListener (List ())

type LupusElement
    = IntegerInLupusElement Int
    | LupusClassInLupusElement LupusClass

type alias LupusClass =
    { catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , chlorioninae : Maybe Int
    , corvinae : Maybe Int
    , crassina : Maybe Int
    , disdiapason : Maybe String
    , exiguity : Maybe Int
    , farcist : Maybe Int
    , holographical : Maybe Int
    , homocerc : Maybe Bool
    , ichthyophagan : Maybe Int
    , implacable : Maybe Int
    , nonbookish : Maybe ()
    , outshiner : Maybe Int
    , overweather : Maybe Int
    , protonegroid : Maybe Int
    , shallowish : Maybe Int
    , snoke : Maybe Int
    , snout : Maybe Int
    , surveillance : Maybe Int
    , threshingtime : Maybe Int
    , thysanocarpus : Maybe Int
    , unsignificantly : Maybe Int
    , unsnap : Maybe Int
    , vendible : Maybe Int
    }

type alias Maslin =
    { alicant : Maybe Int
    , antiatonement : Maybe ()
    , anticorrosive : Maybe Int
    , aphidozer : Maybe ()
    , bakuninist : Maybe ()
    , be : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , chub : Maybe Int
    , cuprosilicon : Maybe Int
    , curtailedly : Maybe Int
    , dellenite : Maybe Int
    , dimitry : Maybe Int
    , disdiapason : Maybe String
    , edifying : Maybe ()
    , ethmoiditis : Maybe Int
    , gastralgy : Maybe ()
    , goatherd : Maybe Int
    , hammerdress : Maybe Int
    , hangfire : Maybe ()
    , homocerc : Maybe Bool
    , lacunosity : Maybe Int
    , longiloquence : Maybe ()
    , mameliere : Maybe Int
    , motherless : Maybe ()
    , nonbookish : Maybe ()
    , noncorrodible : Maybe ()
    , nonsensicality : Maybe ()
    , oafishly : Maybe Int
    , pfund : Maybe ()
    , preadvisory : Maybe ()
    , retroflexed : Maybe ()
    , saccharulmic : Maybe Int
    , scowlful : Maybe Int
    , secluded : Maybe ()
    , slackage : Maybe ()
    , sphaeridial : Maybe Int
    , spondulics : Maybe ()
    , subsecive : Maybe Int
    , swellmobsman : Maybe ()
    , trachyglossate : Maybe Int
    , trialogue : Maybe ()
    , unassuaged : Maybe Int
    , ungross : Maybe ()
    , unjudiciously : Maybe ()
    }

type MonaziteElement
    = DoubleInMonaziteElement Float
    | MonaziteClassInMonaziteElement MonaziteClass

type alias MonaziteClass =
    { catharticalness : Float
    , chirotherium : Int
    , disdiapason : String
    , homocerc : Bool
    , nonbookish : ()
    }

type Monoliteral
    = BoolInMonoliteral Bool
    | NullArrayInMonoliteral (List ())

type MonotheisticallyElement
    = MonotheisticallyClassInMonotheisticallyElement MonotheisticallyClass
    | NullArrayInMonotheisticallyElement (List ())

type alias MonotheisticallyClass =
    { blaspheme : Maybe ()
    , catharticalness : Maybe Float
    , celiosalpingectomy : Maybe ()
    , chirotherium : Maybe Int
    , consummativeness : Maybe ()
    , disdiapason : Maybe String
    , egestive : Maybe ()
    , enchylema : Maybe ()
    , gasconade : Maybe ()
    , holidayer : Maybe ()
    , homocerc : Maybe Bool
    , intuitionalism : Maybe ()
    , lophiostomate : Maybe ()
    , nonbookish : Maybe ()
    , nonvolition : Maybe ()
    , palatableness : Maybe ()
    , pimpery : Maybe ()
    , previolation : Maybe ()
    , reconveyance : Maybe ()
    , registership : Maybe ()
    , rhyacolite : Maybe ()
    , smithereens : Maybe ()
    , superedification : Maybe ()
    , trust : Maybe ()
    , whitestone : Maybe ()
    }

type Montage
    = DoubleInMontage Float
    | NullArrayInMontage (List ())
    | StringInMontage String

type Moralness
    = DoubleInMoralness Float
    | NullArrayInMoralness (List ())
    | NullInMoralness

type Mulishly
    = DoubleInMulishly Float
    | IntegerArrayInMulishly (List Int)
    | NullInMulishly

type Myoscope
    = BoolInMyoscope Bool
    | IntegerInMyoscope Int
    | NullArrayInMyoscope (List ())

type Neuromastic
    = DoubleInNeuromastic Float
    | NullArrayInNeuromastic (List ())

type alias Noncontributing =
    { estevin : String
    , jolterhead : Float
    , sauternes : Int
    , sparsely : Bool
    , unrequested : ()
    }

type Nonnervous
    = BoolInNonnervous Bool
    | IntegerInNonnervous Int

type Nonvaluation
    = BoolInNonvaluation Bool
    | DoubleInNonvaluation Float
    | NullArrayInNonvaluation (List ())

type OccupationalistElement
    = NullArrayInOccupationalistElement (List ())
    | NullInOccupationalistElement
    | OccupationalistClassInOccupationalistElement OccupationalistClass

type alias OccupationalistClass =
    { beholdable : ()
    , brotuliform : ()
    , chimakum : ()
    , doodler : ()
    , emulsin : ()
    , fin : ()
    , flourishing : ()
    , flueless : ()
    , furtively : ()
    , gritter : ()
    , interwish : ()
    , monoxylic : ()
    , myristic : ()
    , nightwear : ()
    , peruser : ()
    , theoastrological : ()
    , thumby : ()
    , tingitid : ()
    , trailless : ()
    , unpocketed : ()
    }

type OutrivalElement
    = DoubleInOutrivalElement Float
    | NullInOutrivalElement
    | OutrivalClassInOutrivalElement OutrivalClass

type alias OutrivalClass =
    { adroitly : ()
    , bridehood : ()
    , castoroides : ()
    , czechoslovak : ()
    , diagenesis : ()
    , dihexahedron : ()
    , dopester : ()
    , eumerism : ()
    , flyness : ()
    , fouler : ()
    , laudanosine : ()
    , lingulidae : ()
    , minutary : ()
    , mitra : ()
    , opisthorchiasis : ()
    , pensively : ()
    , pubigerous : ()
    , rebellious : ()
    , recodify : ()
    , unpaced : ()
    }

type Paleographically
    = DoubleInPaleographically Float
    | UnionMapInPaleographically (Dict String (Maybe Int))

type Pamphletwise
    = IntegerInPamphletwise Int
    | IntegerMapInPamphletwise (Dict String Int)
    | StringInPamphletwise String

type Pediatric
    = BoolInPediatric Bool
    | DoubleInPediatric Float
    | NullInPediatric

type PiaculumElement
    = DoubleInPiaculumElement Float
    | PiaculumClassInPiaculumElement PiaculumClass

type alias PiaculumClass =
    { alada : Maybe Int
    , amphistomous : Maybe Int
    , boysenberry : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , decardinalize : Maybe Int
    , discouragement : Maybe Int
    , disdiapason : Maybe String
    , doitrified : Maybe Int
    , hexaspermous : Maybe Int
    , homocerc : Maybe Bool
    , insinking : Maybe Int
    , loathfulness : Maybe Int
    , miasmatical : Maybe Int
    , neurofibril : Maybe Int
    , nonbookish : Maybe ()
    , phonendoscope : Maybe Int
    , pilferment : Maybe Int
    , predismissory : Maybe Int
    , preinscription : Maybe Int
    , quotative : Maybe Int
    , sienna : Maybe Int
    , thorax : Maybe Int
    , yachting : Maybe Int
    , zipper : Maybe Int
    }

type Piccadilly
    = DoubleInPiccadilly Float
    | NullInPiccadilly
    | StringInPiccadilly String

type Piffler
    = MonaziteClassInPiffler MonaziteClass
    | NullArrayInPiffler (List ())

type Pithful
    = BoolInPithful Bool
    | IntegerInPithful Int
    | NullInPithful

type Placuntiti
    = IntegerInPlacuntiti Int
    | IntegerMapInPlacuntiti (Dict String Int)

type Plectopterous
    = DoubleInPlectopterous Float
    | IntegerMapInPlectopterous (Dict String Int)

type alias Pneumocele =
    { carbonarism : Maybe ()
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , cineolic : Maybe ()
    , cobbly : Maybe ()
    , conchyliferous : Maybe ()
    , congregation : Maybe ()
    , disdiapason : Maybe String
    , enterotomy : Maybe ()
    , entophytal : Maybe ()
    , fewtrils : Maybe ()
    , herem : Maybe ()
    , homocerc : Maybe Bool
    , koniga : Maybe ()
    , meticulosity : Maybe ()
    , micky : Maybe ()
    , mismarriage : Maybe ()
    , neurotrophic : Maybe ()
    , nonbookish : Maybe ()
    , persuasively : Maybe ()
    , replaceable : Maybe ()
    , silex : Maybe ()
    , taillight : Maybe ()
    , unjealous : Maybe ()
    , visitorial : Maybe ()
    }

type Poliorcetic
    = BoolInPoliorcetic Bool
    | MonaziteClassInPoliorcetic MonaziteClass

type Poormaster
    = IntegerArrayInPoormaster (List Int)
    | IntegerMapInPoormaster (Dict String Int)
    | NullInPoormaster

type PotwhiskyElement
    = IntegerInPotwhiskyElement Int
    | NullInPotwhiskyElement
    | PotwhiskyClassInPotwhiskyElement PotwhiskyClass

type alias PotwhiskyClass =
    { arciform : ()
    , cresolin : ()
    , disheartener : ()
    , disproportionable : ()
    , euchorda : ()
    , ferryway : ()
    , filamentiferous : ()
    , flemish : ()
    , forgainst : ()
    , grainering : ()
    , irrevoluble : ()
    , kindredship : ()
    , pinguitudinous : ()
    , simpletonic : ()
    , singsong : ()
    , submergement : ()
    , supraoesophagal : ()
    , thrashel : ()
    , tyremesis : ()
    , yoruba : ()
    }

type Practicalizer
    = MonaziteClassInPracticalizer MonaziteClass
    | NullArrayInPracticalizer (List ())
    | StringInPracticalizer String

type PrefreshmanElement
    = NullArrayInPrefreshmanElement (List ())
    | PrefreshmanClassInPrefreshmanElement PrefreshmanClass
    | StringInPrefreshmanElement String

type alias PrefreshmanClass =
    { azorubine : ()
    , choroiditis : ()
    , coagulatory : ()
    , cyclorama : ()
    , dolphus : ()
    , duckhearted : ()
    , ficus : ()
    , gemaric : ()
    , jugation : ()
    , myoliposis : ()
    , nonnomination : ()
    , palay : ()
    , pentactinal : ()
    , phaet : ()
    , piquant : ()
    , registration : ()
    , remancipation : ()
    , scutatiform : ()
    , theodolite : ()
    , underward : ()
    }

type Prehensility
    = BoolInPrehensility Bool
    | MonaziteClassInPrehensility MonaziteClass
    | NullArrayInPrehensility (List ())

type Prevoidance
    = IntegerArrayInPrevoidance (List Int)
    | IntegerInPrevoidance Int
    | MonaziteClassInPrevoidance MonaziteClass

type Protext
    = BoolInProtext Bool
    | IntegerArrayInProtext (List Int)
    | MonaziteClassInProtext MonaziteClass

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
        |> Jpipe.required "juror" (Jdec.list jurorElement )
        |> Jpipe.required "kongoni" (Jdec.list kongoni )
        |> Jpipe.required "ladronism" (Jdec.list ladronismElement )
        |> Jpipe.required "landlubberly" (Jdec.list landlubberlyElement )
        |> Jpipe.required "listener" (Jdec.list listener )
        |> Jpipe.required "lupus" (Jdec.list lupusElement )
        |> Jpipe.required "maslin" (Jdec.list maslin )
        |> Jpipe.required "monazite" (Jdec.list monaziteElement )
        |> Jpipe.required "monoliteral" (Jdec.list monoliteral )
        |> Jpipe.required "monotheistically" (Jdec.list monotheisticallyElement )
        |> Jpipe.required "montage" (Jdec.list montage )
        |> Jpipe.required "moralness" (Jdec.list moralness )
        |> Jpipe.required "mowra" (Jdec.list (Jdec.nullable monaziteClass) )
        |> Jpipe.required "mulishly" (Jdec.list mulishly )
        |> Jpipe.required "myoscope" (Jdec.list myoscope )
        |> Jpipe.required "nach" (Jdec.list (Jdec.nullable (Jdec.list (Jdec.nullable Jdec.int) )) )
        |> Jpipe.required "neuromastic" (Jdec.list neuromastic )
        |> Jpipe.required "noncontributing" (Jdec.list noncontributing )
        |> Jpipe.required "nonnervous" (Jdec.list nonnervous )
        |> Jpipe.required "nonvaluation" (Jdec.list nonvaluation )
        |> Jpipe.required "occupationalist" (Jdec.list occupationalistElement )
        |> Jpipe.required "outrival" (Jdec.list outrivalElement )
        |> Jpipe.required "paleographically" (Jdec.list paleographically )
        |> Jpipe.required "pamphletwise" (Jdec.list pamphletwise )
        |> Jpipe.required "pediatrics" (Jdec.list pediatric )
        |> Jpipe.required "perceptive" (Jdec.list Jdec.bool )
        |> Jpipe.required "piaculum" (Jdec.list piaculumElement )
        |> Jpipe.required "piccadilly" (Jdec.list piccadilly )
        |> Jpipe.required "piffler" (Jdec.list piffler )
        |> Jpipe.required "pithful" (Jdec.list pithful )
        |> Jpipe.required "placuntitis" (Jdec.list placuntiti )
        |> Jpipe.required "plectopterous" (Jdec.list plectopterous )
        |> Jpipe.required "pneumocele" (Jdec.list (Jdec.nullable pneumocele) )
        |> Jpipe.required "poliorcetic" (Jdec.list poliorcetic )
        |> Jpipe.required "poormaster" (Jdec.list poormaster )
        |> Jpipe.required "potwhisky" (Jdec.list potwhiskyElement )
        |> Jpipe.required "practicalizer" (Jdec.list practicalizer )
        |> Jpipe.required "prefreshman" (Jdec.list prefreshmanElement )
        |> Jpipe.required "prehensility" (Jdec.list prehensility )
        |> Jpipe.required "prevoidance" (Jdec.list prevoidance )
        |> Jpipe.required "probant" (Jdec.list (Jdec.dict (Jdec.nullable Jdec.int)) )
        |> Jpipe.required "protext" (Jdec.list protext )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("juror", Jenc.list encodeJurorElement x.juror)
        , ("kongoni", Jenc.list encodeKongoni x.kongoni)
        , ("ladronism", Jenc.list encodeLadronismElement x.ladronism)
        , ("landlubberly", Jenc.list encodeLandlubberlyElement x.landlubberly)
        , ("listener", Jenc.list encodeListener x.listener)
        , ("lupus", Jenc.list encodeLupusElement x.lupus)
        , ("maslin", Jenc.list encodeMaslin x.maslin)
        , ("monazite", Jenc.list encodeMonaziteElement x.monazite)
        , ("monoliteral", Jenc.list encodeMonoliteral x.monoliteral)
        , ("monotheistically", Jenc.list encodeMonotheisticallyElement x.monotheistically)
        , ("montage", Jenc.list encodeMontage x.montage)
        , ("moralness", Jenc.list encodeMoralness x.moralness)
        , ("mowra", Jenc.list (makeNullableEncoder encodeMonaziteClass) x.mowra)
        , ("mulishly", Jenc.list encodeMulishly x.mulishly)
        , ("myoscope", Jenc.list encodeMyoscope x.myoscope)
        , ("nach", Jenc.list (makeNullableEncoder (Jenc.list (makeNullableEncoder Jenc.int))) x.nach)
        , ("neuromastic", Jenc.list encodeNeuromastic x.neuromastic)
        , ("noncontributing", Jenc.list encodeNoncontributing x.noncontributing)
        , ("nonnervous", Jenc.list encodeNonnervous x.nonnervous)
        , ("nonvaluation", Jenc.list encodeNonvaluation x.nonvaluation)
        , ("occupationalist", Jenc.list encodeOccupationalistElement x.occupationalist)
        , ("outrival", Jenc.list encodeOutrivalElement x.outrival)
        , ("paleographically", Jenc.list encodePaleographically x.paleographically)
        , ("pamphletwise", Jenc.list encodePamphletwise x.pamphletwise)
        , ("pediatrics", Jenc.list encodePediatric x.pediatrics)
        , ("perceptive", Jenc.list Jenc.bool x.perceptive)
        , ("piaculum", Jenc.list encodePiaculumElement x.piaculum)
        , ("piccadilly", Jenc.list encodePiccadilly x.piccadilly)
        , ("piffler", Jenc.list encodePiffler x.piffler)
        , ("pithful", Jenc.list encodePithful x.pithful)
        , ("placuntitis", Jenc.list encodePlacuntiti x.placuntitis)
        , ("plectopterous", Jenc.list encodePlectopterous x.plectopterous)
        , ("pneumocele", Jenc.list (makeNullableEncoder encodePneumocele) x.pneumocele)
        , ("poliorcetic", Jenc.list encodePoliorcetic x.poliorcetic)
        , ("poormaster", Jenc.list encodePoormaster x.poormaster)
        , ("potwhisky", Jenc.list encodePotwhiskyElement x.potwhisky)
        , ("practicalizer", Jenc.list encodePracticalizer x.practicalizer)
        , ("prefreshman", Jenc.list encodePrefreshmanElement x.prefreshman)
        , ("prehensility", Jenc.list encodePrehensility x.prehensility)
        , ("prevoidance", Jenc.list encodePrevoidance x.prevoidance)
        , ("probant", Jenc.list (Jenc.dict identity (makeNullableEncoder Jenc.int)) x.probant)
        , ("protext", Jenc.list encodeProtext x.protext)
        ]

jurorElement : Jdec.Decoder JurorElement
jurorElement =
    Jdec.oneOf
        [ Jdec.map BoolInJurorElement Jdec.bool
        , Jdec.map JurorClassInJurorElement jurorClass
        ]

encodeJurorElement : JurorElement -> Jenc.Value
encodeJurorElement x = case x of
    BoolInJurorElement y -> Jenc.bool y
    JurorClassInJurorElement y -> encodeJurorClass y

jurorClass : Jdec.Decoder JurorClass
jurorClass =
    Jdec.succeed JurorClass
        |> Jpipe.required "adipsy" (Jdec.null ())
        |> Jpipe.required "auxiliator" (Jdec.null ())
        |> Jpipe.required "benda" (Jdec.null ())
        |> Jpipe.required "benjamin" (Jdec.null ())
        |> Jpipe.required "brandling" (Jdec.null ())
        |> Jpipe.required "epicurishly" (Jdec.null ())
        |> Jpipe.required "eremochaetous" (Jdec.null ())
        |> Jpipe.required "marten" (Jdec.null ())
        |> Jpipe.required "monocline" (Jdec.null ())
        |> Jpipe.required "Olea" (Jdec.null ())
        |> Jpipe.required "palgat" (Jdec.null ())
        |> Jpipe.required "pennyworth" (Jdec.null ())
        |> Jpipe.required "pioury" (Jdec.null ())
        |> Jpipe.required "pragmatistic" (Jdec.null ())
        |> Jpipe.required "stylelessness" (Jdec.null ())
        |> Jpipe.required "systematical" (Jdec.null ())
        |> Jpipe.required "thready" (Jdec.null ())
        |> Jpipe.required "uncontemporary" (Jdec.null ())
        |> Jpipe.required "uncouched" (Jdec.null ())
        |> Jpipe.required "uninhabitedness" (Jdec.null ())

encodeJurorClass : JurorClass -> Jenc.Value
encodeJurorClass x =
    Jenc.object
        [ ("adipsy", always Jenc.null x.adipsy)
        , ("auxiliator", always Jenc.null x.auxiliator)
        , ("benda", always Jenc.null x.benda)
        , ("benjamin", always Jenc.null x.benjamin)
        , ("brandling", always Jenc.null x.brandling)
        , ("epicurishly", always Jenc.null x.epicurishly)
        , ("eremochaetous", always Jenc.null x.eremochaetous)
        , ("marten", always Jenc.null x.marten)
        , ("monocline", always Jenc.null x.monocline)
        , ("Olea", always Jenc.null x.olea)
        , ("palgat", always Jenc.null x.palgat)
        , ("pennyworth", always Jenc.null x.pennyworth)
        , ("pioury", always Jenc.null x.pioury)
        , ("pragmatistic", always Jenc.null x.pragmatistic)
        , ("stylelessness", always Jenc.null x.stylelessness)
        , ("systematical", always Jenc.null x.systematical)
        , ("thready", always Jenc.null x.thready)
        , ("uncontemporary", always Jenc.null x.uncontemporary)
        , ("uncouched", always Jenc.null x.uncouched)
        , ("uninhabitedness", always Jenc.null x.uninhabitedness)
        ]

kongoni : Jdec.Decoder Kongoni
kongoni =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInKongoni (Jdec.list Jdec.int )
        , Jdec.map IntegerMapInKongoni (Jdec.dict Jdec.int)
        ]

encodeKongoni : Kongoni -> Jenc.Value
encodeKongoni x = case x of
    IntegerArrayInKongoni y -> Jenc.list Jenc.int y
    IntegerMapInKongoni y -> Jenc.dict identity Jenc.int y

ladronismElement : Jdec.Decoder LadronismElement
ladronismElement =
    Jdec.oneOf
        [ Jdec.map StringInLadronismElement Jdec.string
        , Jdec.map DoubleInLadronismElement Jdec.float
        , Jdec.map LadronismClassInLadronismElement ladronismClass
        ]

encodeLadronismElement : LadronismElement -> Jenc.Value
encodeLadronismElement x = case x of
    StringInLadronismElement y -> Jenc.string y
    DoubleInLadronismElement y -> Jenc.float y
    LadronismClassInLadronismElement y -> encodeLadronismClass y

ladronismClass : Jdec.Decoder LadronismClass
ladronismClass =
    Jdec.succeed LadronismClass
        |> Jpipe.required "acclaimer" (Jdec.null ())
        |> Jpipe.required "achree" (Jdec.null ())
        |> Jpipe.required "base" (Jdec.null ())
        |> Jpipe.required "conundrumize" (Jdec.null ())
        |> Jpipe.required "degerminator" (Jdec.null ())
        |> Jpipe.required "describable" (Jdec.null ())
        |> Jpipe.required "exasperatedly" (Jdec.null ())
        |> Jpipe.required "heroine" (Jdec.null ())
        |> Jpipe.required "indazin" (Jdec.null ())
        |> Jpipe.required "luteous" (Jdec.null ())
        |> Jpipe.required "papular" (Jdec.null ())
        |> Jpipe.required "pritch" (Jdec.null ())
        |> Jpipe.required "Prodenia" (Jdec.null ())
        |> Jpipe.required "seege" (Jdec.null ())
        |> Jpipe.required "shopgirl" (Jdec.null ())
        |> Jpipe.required "tragedietta" (Jdec.null ())
        |> Jpipe.required "unsparse" (Jdec.null ())
        |> Jpipe.required "uplook" (Jdec.null ())
        |> Jpipe.required "vermiformis" (Jdec.null ())
        |> Jpipe.required "whafabout" (Jdec.null ())

encodeLadronismClass : LadronismClass -> Jenc.Value
encodeLadronismClass x =
    Jenc.object
        [ ("acclaimer", always Jenc.null x.acclaimer)
        , ("achree", always Jenc.null x.achree)
        , ("base", always Jenc.null x.base)
        , ("conundrumize", always Jenc.null x.conundrumize)
        , ("degerminator", always Jenc.null x.degerminator)
        , ("describable", always Jenc.null x.describable)
        , ("exasperatedly", always Jenc.null x.exasperatedly)
        , ("heroine", always Jenc.null x.heroine)
        , ("indazin", always Jenc.null x.indazin)
        , ("luteous", always Jenc.null x.luteous)
        , ("papular", always Jenc.null x.papular)
        , ("pritch", always Jenc.null x.pritch)
        , ("Prodenia", always Jenc.null x.prodenia)
        , ("seege", always Jenc.null x.seege)
        , ("shopgirl", always Jenc.null x.shopgirl)
        , ("tragedietta", always Jenc.null x.tragedietta)
        , ("unsparse", always Jenc.null x.unsparse)
        , ("uplook", always Jenc.null x.uplook)
        , ("vermiformis", always Jenc.null x.vermiformis)
        , ("whafabout", always Jenc.null x.whafabout)
        ]

landlubberlyElement : Jdec.Decoder LandlubberlyElement
landlubberlyElement =
    Jdec.oneOf
        [ Jdec.map BoolInLandlubberlyElement Jdec.bool
        , Jdec.map IntegerInLandlubberlyElement Jdec.int
        , Jdec.map LandlubberlyClassInLandlubberlyElement landlubberlyClass
        ]

encodeLandlubberlyElement : LandlubberlyElement -> Jenc.Value
encodeLandlubberlyElement x = case x of
    BoolInLandlubberlyElement y -> Jenc.bool y
    IntegerInLandlubberlyElement y -> Jenc.int y
    LandlubberlyClassInLandlubberlyElement y -> encodeLandlubberlyClass y

landlubberlyClass : Jdec.Decoder LandlubberlyClass
landlubberlyClass =
    Jdec.succeed LandlubberlyClass
        |> Jpipe.required "acropoleis" (Jdec.null ())
        |> Jpipe.required "aminate" (Jdec.null ())
        |> Jpipe.required "Amyraldism" (Jdec.null ())
        |> Jpipe.required "bipenniform" (Jdec.null ())
        |> Jpipe.required "bugre" (Jdec.null ())
        |> Jpipe.required "calycule" (Jdec.null ())
        |> Jpipe.required "caoutchouc" (Jdec.null ())
        |> Jpipe.required "disprover" (Jdec.null ())
        |> Jpipe.required "fitroot" (Jdec.null ())
        |> Jpipe.required "fulgently" (Jdec.null ())
        |> Jpipe.required "kickup" (Jdec.null ())
        |> Jpipe.required "laevoversion" (Jdec.null ())
        |> Jpipe.required "moter" (Jdec.null ())
        |> Jpipe.required "objectivity" (Jdec.null ())
        |> Jpipe.required "posterity" (Jdec.null ())
        |> Jpipe.required "postnuptial" (Jdec.null ())
        |> Jpipe.required "precedentary" (Jdec.null ())
        |> Jpipe.required "saddling" (Jdec.null ())
        |> Jpipe.required "subcurrent" (Jdec.null ())
        |> Jpipe.required "unrecriminative" (Jdec.null ())

encodeLandlubberlyClass : LandlubberlyClass -> Jenc.Value
encodeLandlubberlyClass x =
    Jenc.object
        [ ("acropoleis", always Jenc.null x.acropoleis)
        , ("aminate", always Jenc.null x.aminate)
        , ("Amyraldism", always Jenc.null x.amyraldism)
        , ("bipenniform", always Jenc.null x.bipenniform)
        , ("bugre", always Jenc.null x.bugre)
        , ("calycule", always Jenc.null x.calycule)
        , ("caoutchouc", always Jenc.null x.caoutchouc)
        , ("disprover", always Jenc.null x.disprover)
        , ("fitroot", always Jenc.null x.fitroot)
        , ("fulgently", always Jenc.null x.fulgently)
        , ("kickup", always Jenc.null x.kickup)
        , ("laevoversion", always Jenc.null x.laevoversion)
        , ("moter", always Jenc.null x.moter)
        , ("objectivity", always Jenc.null x.objectivity)
        , ("posterity", always Jenc.null x.posterity)
        , ("postnuptial", always Jenc.null x.postnuptial)
        , ("precedentary", always Jenc.null x.precedentary)
        , ("saddling", always Jenc.null x.saddling)
        , ("subcurrent", always Jenc.null x.subcurrent)
        , ("unrecriminative", always Jenc.null x.unrecriminative)
        ]

listener : Jdec.Decoder Listener
listener =
    Jdec.oneOf
        [ Jdec.map NullArrayInListener (Jdec.list (Jdec.null ()) )
        , Jdec.map IntegerInListener Jdec.int
        ]

encodeListener : Listener -> Jenc.Value
encodeListener x = case x of
    NullArrayInListener y -> Jenc.list (always Jenc.null) y
    IntegerInListener y -> Jenc.int y

lupusElement : Jdec.Decoder LupusElement
lupusElement =
    Jdec.oneOf
        [ Jdec.map IntegerInLupusElement Jdec.int
        , Jdec.map LupusClassInLupusElement lupusClass
        ]

encodeLupusElement : LupusElement -> Jenc.Value
encodeLupusElement x = case x of
    IntegerInLupusElement y -> Jenc.int y
    LupusClassInLupusElement y -> encodeLupusClass y

lupusClass : Jdec.Decoder LupusClass
lupusClass =
    Jdec.succeed LupusClass
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Chlorioninae" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Corvinae" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Crassina" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "exiguity" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "farcist" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "holographical" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "ichthyophagan" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "implacable" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "outshiner" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "overweather" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "protonegroid" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "shallowish" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "snoke" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "snout" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "surveillance" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "threshingtime" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Thysanocarpus" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "unsignificantly" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "unsnap" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "vendible" (Jdec.map Just Jdec.int) Nothing)

encodeLupusClass : LupusClass -> Jenc.Value
encodeLupusClass x =
    Jenc.object
        [ ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("Chlorioninae", makeNullableEncoder Jenc.int x.chlorioninae)
        , ("Corvinae", makeNullableEncoder Jenc.int x.corvinae)
        , ("Crassina", makeNullableEncoder Jenc.int x.crassina)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("exiguity", makeNullableEncoder Jenc.int x.exiguity)
        , ("farcist", makeNullableEncoder Jenc.int x.farcist)
        , ("holographical", makeNullableEncoder Jenc.int x.holographical)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("ichthyophagan", makeNullableEncoder Jenc.int x.ichthyophagan)
        , ("implacable", makeNullableEncoder Jenc.int x.implacable)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("outshiner", makeNullableEncoder Jenc.int x.outshiner)
        , ("overweather", makeNullableEncoder Jenc.int x.overweather)
        , ("protonegroid", makeNullableEncoder Jenc.int x.protonegroid)
        , ("shallowish", makeNullableEncoder Jenc.int x.shallowish)
        , ("snoke", makeNullableEncoder Jenc.int x.snoke)
        , ("snout", makeNullableEncoder Jenc.int x.snout)
        , ("surveillance", makeNullableEncoder Jenc.int x.surveillance)
        , ("threshingtime", makeNullableEncoder Jenc.int x.threshingtime)
        , ("Thysanocarpus", makeNullableEncoder Jenc.int x.thysanocarpus)
        , ("unsignificantly", makeNullableEncoder Jenc.int x.unsignificantly)
        , ("unsnap", makeNullableEncoder Jenc.int x.unsnap)
        , ("vendible", makeNullableEncoder Jenc.int x.vendible)
        ]

maslin : Jdec.Decoder Maslin
maslin =
    Jdec.succeed Maslin
        |> Jpipe.custom (optionalField "Alicant" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "antiatonement" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "anticorrosive" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "aphidozer" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Bakuninist" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "be" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "chub" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "cuprosilicon" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "curtailedly" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "dellenite" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Dimitry" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "edifying" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ethmoiditis" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "gastralgy" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "goatherd" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "hammerdress" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "hangfire" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "lacunosity" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "longiloquence" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "mameliere" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "motherless" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "noncorrodible" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonsensicality" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "oafishly" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "pfund" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "preadvisory" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "retroflexed" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "saccharulmic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "scowlful" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "secluded" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "slackage" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "sphaeridial" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "spondulics" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "subsecive" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "swellmobsman" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "trachyglossate" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "trialogue" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unassuaged" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "ungross" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unjudiciously" (Jdec.nullable (Jdec.null ())) Nothing)

encodeMaslin : Maslin -> Jenc.Value
encodeMaslin x =
    Jenc.object
        [ ("Alicant", makeNullableEncoder Jenc.int x.alicant)
        , ("antiatonement", makeNullableEncoder (always Jenc.null) x.antiatonement)
        , ("anticorrosive", makeNullableEncoder Jenc.int x.anticorrosive)
        , ("aphidozer", makeNullableEncoder (always Jenc.null) x.aphidozer)
        , ("Bakuninist", makeNullableEncoder (always Jenc.null) x.bakuninist)
        , ("be", makeNullableEncoder Jenc.int x.be)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("chub", makeNullableEncoder Jenc.int x.chub)
        , ("cuprosilicon", makeNullableEncoder Jenc.int x.cuprosilicon)
        , ("curtailedly", makeNullableEncoder Jenc.int x.curtailedly)
        , ("dellenite", makeNullableEncoder Jenc.int x.dellenite)
        , ("Dimitry", makeNullableEncoder Jenc.int x.dimitry)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("edifying", makeNullableEncoder (always Jenc.null) x.edifying)
        , ("ethmoiditis", makeNullableEncoder Jenc.int x.ethmoiditis)
        , ("gastralgy", makeNullableEncoder (always Jenc.null) x.gastralgy)
        , ("goatherd", makeNullableEncoder Jenc.int x.goatherd)
        , ("hammerdress", makeNullableEncoder Jenc.int x.hammerdress)
        , ("hangfire", makeNullableEncoder (always Jenc.null) x.hangfire)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("lacunosity", makeNullableEncoder Jenc.int x.lacunosity)
        , ("longiloquence", makeNullableEncoder (always Jenc.null) x.longiloquence)
        , ("mameliere", makeNullableEncoder Jenc.int x.mameliere)
        , ("motherless", makeNullableEncoder (always Jenc.null) x.motherless)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("noncorrodible", makeNullableEncoder (always Jenc.null) x.noncorrodible)
        , ("nonsensicality", makeNullableEncoder (always Jenc.null) x.nonsensicality)
        , ("oafishly", makeNullableEncoder Jenc.int x.oafishly)
        , ("pfund", makeNullableEncoder (always Jenc.null) x.pfund)
        , ("preadvisory", makeNullableEncoder (always Jenc.null) x.preadvisory)
        , ("retroflexed", makeNullableEncoder (always Jenc.null) x.retroflexed)
        , ("saccharulmic", makeNullableEncoder Jenc.int x.saccharulmic)
        , ("scowlful", makeNullableEncoder Jenc.int x.scowlful)
        , ("secluded", makeNullableEncoder (always Jenc.null) x.secluded)
        , ("slackage", makeNullableEncoder (always Jenc.null) x.slackage)
        , ("sphaeridial", makeNullableEncoder Jenc.int x.sphaeridial)
        , ("spondulics", makeNullableEncoder (always Jenc.null) x.spondulics)
        , ("subsecive", makeNullableEncoder Jenc.int x.subsecive)
        , ("swellmobsman", makeNullableEncoder (always Jenc.null) x.swellmobsman)
        , ("trachyglossate", makeNullableEncoder Jenc.int x.trachyglossate)
        , ("trialogue", makeNullableEncoder (always Jenc.null) x.trialogue)
        , ("unassuaged", makeNullableEncoder Jenc.int x.unassuaged)
        , ("ungross", makeNullableEncoder (always Jenc.null) x.ungross)
        , ("unjudiciously", makeNullableEncoder (always Jenc.null) x.unjudiciously)
        ]

monaziteElement : Jdec.Decoder MonaziteElement
monaziteElement =
    Jdec.oneOf
        [ Jdec.map DoubleInMonaziteElement Jdec.float
        , Jdec.map MonaziteClassInMonaziteElement monaziteClass
        ]

encodeMonaziteElement : MonaziteElement -> Jenc.Value
encodeMonaziteElement x = case x of
    DoubleInMonaziteElement y -> Jenc.float y
    MonaziteClassInMonaziteElement y -> encodeMonaziteClass y

monaziteClass : Jdec.Decoder MonaziteClass
monaziteClass =
    Jdec.succeed MonaziteClass
        |> Jpipe.required "catharticalness" Jdec.float
        |> Jpipe.required "Chirotherium" Jdec.int
        |> Jpipe.required "disdiapason" Jdec.string
        |> Jpipe.required "homocerc" Jdec.bool
        |> Jpipe.required "nonbookish" (Jdec.null ())

encodeMonaziteClass : MonaziteClass -> Jenc.Value
encodeMonaziteClass x =
    Jenc.object
        [ ("catharticalness", Jenc.float x.catharticalness)
        , ("Chirotherium", Jenc.int x.chirotherium)
        , ("disdiapason", Jenc.string x.disdiapason)
        , ("homocerc", Jenc.bool x.homocerc)
        , ("nonbookish", always Jenc.null x.nonbookish)
        ]

monoliteral : Jdec.Decoder Monoliteral
monoliteral =
    Jdec.oneOf
        [ Jdec.map NullArrayInMonoliteral (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInMonoliteral Jdec.bool
        ]

encodeMonoliteral : Monoliteral -> Jenc.Value
encodeMonoliteral x = case x of
    NullArrayInMonoliteral y -> Jenc.list (always Jenc.null) y
    BoolInMonoliteral y -> Jenc.bool y

monotheisticallyElement : Jdec.Decoder MonotheisticallyElement
monotheisticallyElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInMonotheisticallyElement (Jdec.list (Jdec.null ()) )
        , Jdec.map MonotheisticallyClassInMonotheisticallyElement monotheisticallyClass
        ]

encodeMonotheisticallyElement : MonotheisticallyElement -> Jenc.Value
encodeMonotheisticallyElement x = case x of
    NullArrayInMonotheisticallyElement y -> Jenc.list (always Jenc.null) y
    MonotheisticallyClassInMonotheisticallyElement y -> encodeMonotheisticallyClass y

monotheisticallyClass : Jdec.Decoder MonotheisticallyClass
monotheisticallyClass =
    Jdec.succeed MonotheisticallyClass
        |> Jpipe.custom (optionalField "blaspheme" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "celiosalpingectomy" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "consummativeness" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "egestive" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "enchylema" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "gasconade" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "holidayer" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "intuitionalism" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "lophiostomate" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonvolition" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "palatableness" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "pimpery" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "previolation" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "reconveyance" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "registership" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "rhyacolite" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "smithereens" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "superedification" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "trust" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "whitestone" (Jdec.nullable (Jdec.null ())) Nothing)

encodeMonotheisticallyClass : MonotheisticallyClass -> Jenc.Value
encodeMonotheisticallyClass x =
    Jenc.object
        [ ("blaspheme", makeNullableEncoder (always Jenc.null) x.blaspheme)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("celiosalpingectomy", makeNullableEncoder (always Jenc.null) x.celiosalpingectomy)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("consummativeness", makeNullableEncoder (always Jenc.null) x.consummativeness)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("egestive", makeNullableEncoder (always Jenc.null) x.egestive)
        , ("enchylema", makeNullableEncoder (always Jenc.null) x.enchylema)
        , ("gasconade", makeNullableEncoder (always Jenc.null) x.gasconade)
        , ("holidayer", makeNullableEncoder (always Jenc.null) x.holidayer)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("intuitionalism", makeNullableEncoder (always Jenc.null) x.intuitionalism)
        , ("lophiostomate", makeNullableEncoder (always Jenc.null) x.lophiostomate)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("nonvolition", makeNullableEncoder (always Jenc.null) x.nonvolition)
        , ("palatableness", makeNullableEncoder (always Jenc.null) x.palatableness)
        , ("pimpery", makeNullableEncoder (always Jenc.null) x.pimpery)
        , ("previolation", makeNullableEncoder (always Jenc.null) x.previolation)
        , ("reconveyance", makeNullableEncoder (always Jenc.null) x.reconveyance)
        , ("registership", makeNullableEncoder (always Jenc.null) x.registership)
        , ("rhyacolite", makeNullableEncoder (always Jenc.null) x.rhyacolite)
        , ("smithereens", makeNullableEncoder (always Jenc.null) x.smithereens)
        , ("superedification", makeNullableEncoder (always Jenc.null) x.superedification)
        , ("trust", makeNullableEncoder (always Jenc.null) x.trust)
        , ("whitestone", makeNullableEncoder (always Jenc.null) x.whitestone)
        ]

montage : Jdec.Decoder Montage
montage =
    Jdec.oneOf
        [ Jdec.map NullArrayInMontage (Jdec.list (Jdec.null ()) )
        , Jdec.map StringInMontage Jdec.string
        , Jdec.map DoubleInMontage Jdec.float
        ]

encodeMontage : Montage -> Jenc.Value
encodeMontage x = case x of
    NullArrayInMontage y -> Jenc.list (always Jenc.null) y
    StringInMontage y -> Jenc.string y
    DoubleInMontage y -> Jenc.float y

moralness : Jdec.Decoder Moralness
moralness =
    Jdec.oneOf
        [ Jdec.map NullArrayInMoralness (Jdec.list (Jdec.null ()) )
        , Jdec.null NullInMoralness
        , Jdec.map DoubleInMoralness Jdec.float
        ]

encodeMoralness : Moralness -> Jenc.Value
encodeMoralness x = case x of
    NullArrayInMoralness y -> Jenc.list (always Jenc.null) y
    NullInMoralness -> Jenc.null
    DoubleInMoralness y -> Jenc.float y

mulishly : Jdec.Decoder Mulishly
mulishly =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInMulishly (Jdec.list Jdec.int )
        , Jdec.null NullInMulishly
        , Jdec.map DoubleInMulishly Jdec.float
        ]

encodeMulishly : Mulishly -> Jenc.Value
encodeMulishly x = case x of
    IntegerArrayInMulishly y -> Jenc.list Jenc.int y
    NullInMulishly -> Jenc.null
    DoubleInMulishly y -> Jenc.float y

myoscope : Jdec.Decoder Myoscope
myoscope =
    Jdec.oneOf
        [ Jdec.map NullArrayInMyoscope (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInMyoscope Jdec.bool
        , Jdec.map IntegerInMyoscope Jdec.int
        ]

encodeMyoscope : Myoscope -> Jenc.Value
encodeMyoscope x = case x of
    NullArrayInMyoscope y -> Jenc.list (always Jenc.null) y
    BoolInMyoscope y -> Jenc.bool y
    IntegerInMyoscope y -> Jenc.int y

neuromastic : Jdec.Decoder Neuromastic
neuromastic =
    Jdec.oneOf
        [ Jdec.map NullArrayInNeuromastic (Jdec.list (Jdec.null ()) )
        , Jdec.map DoubleInNeuromastic Jdec.float
        ]

encodeNeuromastic : Neuromastic -> Jenc.Value
encodeNeuromastic x = case x of
    NullArrayInNeuromastic y -> Jenc.list (always Jenc.null) y
    DoubleInNeuromastic y -> Jenc.float y

noncontributing : Jdec.Decoder Noncontributing
noncontributing =
    Jdec.succeed Noncontributing
        |> Jpipe.required "estevin" Jdec.string
        |> Jpipe.required "jolterhead" Jdec.float
        |> Jpipe.required "sauternes" Jdec.int
        |> Jpipe.required "sparsely" Jdec.bool
        |> Jpipe.required "unrequested" (Jdec.null ())

encodeNoncontributing : Noncontributing -> Jenc.Value
encodeNoncontributing x =
    Jenc.object
        [ ("estevin", Jenc.string x.estevin)
        , ("jolterhead", Jenc.float x.jolterhead)
        , ("sauternes", Jenc.int x.sauternes)
        , ("sparsely", Jenc.bool x.sparsely)
        , ("unrequested", always Jenc.null x.unrequested)
        ]

nonnervous : Jdec.Decoder Nonnervous
nonnervous =
    Jdec.oneOf
        [ Jdec.map BoolInNonnervous Jdec.bool
        , Jdec.map IntegerInNonnervous Jdec.int
        ]

encodeNonnervous : Nonnervous -> Jenc.Value
encodeNonnervous x = case x of
    BoolInNonnervous y -> Jenc.bool y
    IntegerInNonnervous y -> Jenc.int y

nonvaluation : Jdec.Decoder Nonvaluation
nonvaluation =
    Jdec.oneOf
        [ Jdec.map NullArrayInNonvaluation (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInNonvaluation Jdec.bool
        , Jdec.map DoubleInNonvaluation Jdec.float
        ]

encodeNonvaluation : Nonvaluation -> Jenc.Value
encodeNonvaluation x = case x of
    NullArrayInNonvaluation y -> Jenc.list (always Jenc.null) y
    BoolInNonvaluation y -> Jenc.bool y
    DoubleInNonvaluation y -> Jenc.float y

occupationalistElement : Jdec.Decoder OccupationalistElement
occupationalistElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInOccupationalistElement (Jdec.list (Jdec.null ()) )
        , Jdec.null NullInOccupationalistElement
        , Jdec.map OccupationalistClassInOccupationalistElement occupationalistClass
        ]

encodeOccupationalistElement : OccupationalistElement -> Jenc.Value
encodeOccupationalistElement x = case x of
    NullArrayInOccupationalistElement y -> Jenc.list (always Jenc.null) y
    NullInOccupationalistElement -> Jenc.null
    OccupationalistClassInOccupationalistElement y -> encodeOccupationalistClass y

occupationalistClass : Jdec.Decoder OccupationalistClass
occupationalistClass =
    Jdec.succeed OccupationalistClass
        |> Jpipe.required "beholdable" (Jdec.null ())
        |> Jpipe.required "brotuliform" (Jdec.null ())
        |> Jpipe.required "Chimakum" (Jdec.null ())
        |> Jpipe.required "doodler" (Jdec.null ())
        |> Jpipe.required "emulsin" (Jdec.null ())
        |> Jpipe.required "Fin" (Jdec.null ())
        |> Jpipe.required "flourishing" (Jdec.null ())
        |> Jpipe.required "flueless" (Jdec.null ())
        |> Jpipe.required "furtively" (Jdec.null ())
        |> Jpipe.required "gritter" (Jdec.null ())
        |> Jpipe.required "interwish" (Jdec.null ())
        |> Jpipe.required "monoxylic" (Jdec.null ())
        |> Jpipe.required "myristic" (Jdec.null ())
        |> Jpipe.required "nightwear" (Jdec.null ())
        |> Jpipe.required "peruser" (Jdec.null ())
        |> Jpipe.required "theoastrological" (Jdec.null ())
        |> Jpipe.required "thumby" (Jdec.null ())
        |> Jpipe.required "tingitid" (Jdec.null ())
        |> Jpipe.required "trailless" (Jdec.null ())
        |> Jpipe.required "unpocketed" (Jdec.null ())

encodeOccupationalistClass : OccupationalistClass -> Jenc.Value
encodeOccupationalistClass x =
    Jenc.object
        [ ("beholdable", always Jenc.null x.beholdable)
        , ("brotuliform", always Jenc.null x.brotuliform)
        , ("Chimakum", always Jenc.null x.chimakum)
        , ("doodler", always Jenc.null x.doodler)
        , ("emulsin", always Jenc.null x.emulsin)
        , ("Fin", always Jenc.null x.fin)
        , ("flourishing", always Jenc.null x.flourishing)
        , ("flueless", always Jenc.null x.flueless)
        , ("furtively", always Jenc.null x.furtively)
        , ("gritter", always Jenc.null x.gritter)
        , ("interwish", always Jenc.null x.interwish)
        , ("monoxylic", always Jenc.null x.monoxylic)
        , ("myristic", always Jenc.null x.myristic)
        , ("nightwear", always Jenc.null x.nightwear)
        , ("peruser", always Jenc.null x.peruser)
        , ("theoastrological", always Jenc.null x.theoastrological)
        , ("thumby", always Jenc.null x.thumby)
        , ("tingitid", always Jenc.null x.tingitid)
        , ("trailless", always Jenc.null x.trailless)
        , ("unpocketed", always Jenc.null x.unpocketed)
        ]

outrivalElement : Jdec.Decoder OutrivalElement
outrivalElement =
    Jdec.oneOf
        [ Jdec.null NullInOutrivalElement
        , Jdec.map DoubleInOutrivalElement Jdec.float
        , Jdec.map OutrivalClassInOutrivalElement outrivalClass
        ]

encodeOutrivalElement : OutrivalElement -> Jenc.Value
encodeOutrivalElement x = case x of
    NullInOutrivalElement -> Jenc.null
    DoubleInOutrivalElement y -> Jenc.float y
    OutrivalClassInOutrivalElement y -> encodeOutrivalClass y

outrivalClass : Jdec.Decoder OutrivalClass
outrivalClass =
    Jdec.succeed OutrivalClass
        |> Jpipe.required "adroitly" (Jdec.null ())
        |> Jpipe.required "bridehood" (Jdec.null ())
        |> Jpipe.required "Castoroides" (Jdec.null ())
        |> Jpipe.required "Czechoslovak" (Jdec.null ())
        |> Jpipe.required "diagenesis" (Jdec.null ())
        |> Jpipe.required "dihexahedron" (Jdec.null ())
        |> Jpipe.required "dopester" (Jdec.null ())
        |> Jpipe.required "eumerism" (Jdec.null ())
        |> Jpipe.required "flyness" (Jdec.null ())
        |> Jpipe.required "fouler" (Jdec.null ())
        |> Jpipe.required "laudanosine" (Jdec.null ())
        |> Jpipe.required "Lingulidae" (Jdec.null ())
        |> Jpipe.required "minutary" (Jdec.null ())
        |> Jpipe.required "mitra" (Jdec.null ())
        |> Jpipe.required "opisthorchiasis" (Jdec.null ())
        |> Jpipe.required "pensively" (Jdec.null ())
        |> Jpipe.required "pubigerous" (Jdec.null ())
        |> Jpipe.required "rebellious" (Jdec.null ())
        |> Jpipe.required "recodify" (Jdec.null ())
        |> Jpipe.required "unpaced" (Jdec.null ())

encodeOutrivalClass : OutrivalClass -> Jenc.Value
encodeOutrivalClass x =
    Jenc.object
        [ ("adroitly", always Jenc.null x.adroitly)
        , ("bridehood", always Jenc.null x.bridehood)
        , ("Castoroides", always Jenc.null x.castoroides)
        , ("Czechoslovak", always Jenc.null x.czechoslovak)
        , ("diagenesis", always Jenc.null x.diagenesis)
        , ("dihexahedron", always Jenc.null x.dihexahedron)
        , ("dopester", always Jenc.null x.dopester)
        , ("eumerism", always Jenc.null x.eumerism)
        , ("flyness", always Jenc.null x.flyness)
        , ("fouler", always Jenc.null x.fouler)
        , ("laudanosine", always Jenc.null x.laudanosine)
        , ("Lingulidae", always Jenc.null x.lingulidae)
        , ("minutary", always Jenc.null x.minutary)
        , ("mitra", always Jenc.null x.mitra)
        , ("opisthorchiasis", always Jenc.null x.opisthorchiasis)
        , ("pensively", always Jenc.null x.pensively)
        , ("pubigerous", always Jenc.null x.pubigerous)
        , ("rebellious", always Jenc.null x.rebellious)
        , ("recodify", always Jenc.null x.recodify)
        , ("unpaced", always Jenc.null x.unpaced)
        ]

paleographically : Jdec.Decoder Paleographically
paleographically =
    Jdec.oneOf
        [ Jdec.map DoubleInPaleographically Jdec.float
        , Jdec.map UnionMapInPaleographically (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodePaleographically : Paleographically -> Jenc.Value
encodePaleographically x = case x of
    DoubleInPaleographically y -> Jenc.float y
    UnionMapInPaleographically y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

pamphletwise : Jdec.Decoder Pamphletwise
pamphletwise =
    Jdec.oneOf
        [ Jdec.map IntegerInPamphletwise Jdec.int
        , Jdec.map StringInPamphletwise Jdec.string
        , Jdec.map IntegerMapInPamphletwise (Jdec.dict Jdec.int)
        ]

encodePamphletwise : Pamphletwise -> Jenc.Value
encodePamphletwise x = case x of
    IntegerInPamphletwise y -> Jenc.int y
    StringInPamphletwise y -> Jenc.string y
    IntegerMapInPamphletwise y -> Jenc.dict identity Jenc.int y

pediatric : Jdec.Decoder Pediatric
pediatric =
    Jdec.oneOf
        [ Jdec.map BoolInPediatric Jdec.bool
        , Jdec.null NullInPediatric
        , Jdec.map DoubleInPediatric Jdec.float
        ]

encodePediatric : Pediatric -> Jenc.Value
encodePediatric x = case x of
    BoolInPediatric y -> Jenc.bool y
    NullInPediatric -> Jenc.null
    DoubleInPediatric y -> Jenc.float y

piaculumElement : Jdec.Decoder PiaculumElement
piaculumElement =
    Jdec.oneOf
        [ Jdec.map DoubleInPiaculumElement Jdec.float
        , Jdec.map PiaculumClassInPiaculumElement piaculumClass
        ]

encodePiaculumElement : PiaculumElement -> Jenc.Value
encodePiaculumElement x = case x of
    DoubleInPiaculumElement y -> Jenc.float y
    PiaculumClassInPiaculumElement y -> encodePiaculumClass y

piaculumClass : Jdec.Decoder PiaculumClass
piaculumClass =
    Jdec.succeed PiaculumClass
        |> Jpipe.custom (optionalField "alada" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "amphistomous" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "boysenberry" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "decardinalize" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "discouragement" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "doitrified" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "hexaspermous" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "insinking" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "loathfulness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "miasmatical" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "neurofibril" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "phonendoscope" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "pilferment" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "predismissory" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "preinscription" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "quotative" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "sienna" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "thorax" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "yachting" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Zipper" (Jdec.map Just Jdec.int) Nothing)

encodePiaculumClass : PiaculumClass -> Jenc.Value
encodePiaculumClass x =
    Jenc.object
        [ ("alada", makeNullableEncoder Jenc.int x.alada)
        , ("amphistomous", makeNullableEncoder Jenc.int x.amphistomous)
        , ("boysenberry", makeNullableEncoder Jenc.int x.boysenberry)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("decardinalize", makeNullableEncoder Jenc.int x.decardinalize)
        , ("discouragement", makeNullableEncoder Jenc.int x.discouragement)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("doitrified", makeNullableEncoder Jenc.int x.doitrified)
        , ("hexaspermous", makeNullableEncoder Jenc.int x.hexaspermous)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("insinking", makeNullableEncoder Jenc.int x.insinking)
        , ("loathfulness", makeNullableEncoder Jenc.int x.loathfulness)
        , ("miasmatical", makeNullableEncoder Jenc.int x.miasmatical)
        , ("neurofibril", makeNullableEncoder Jenc.int x.neurofibril)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("phonendoscope", makeNullableEncoder Jenc.int x.phonendoscope)
        , ("pilferment", makeNullableEncoder Jenc.int x.pilferment)
        , ("predismissory", makeNullableEncoder Jenc.int x.predismissory)
        , ("preinscription", makeNullableEncoder Jenc.int x.preinscription)
        , ("quotative", makeNullableEncoder Jenc.int x.quotative)
        , ("sienna", makeNullableEncoder Jenc.int x.sienna)
        , ("thorax", makeNullableEncoder Jenc.int x.thorax)
        , ("yachting", makeNullableEncoder Jenc.int x.yachting)
        , ("Zipper", makeNullableEncoder Jenc.int x.zipper)
        ]

piccadilly : Jdec.Decoder Piccadilly
piccadilly =
    Jdec.oneOf
        [ Jdec.null NullInPiccadilly
        , Jdec.map StringInPiccadilly Jdec.string
        , Jdec.map DoubleInPiccadilly Jdec.float
        ]

encodePiccadilly : Piccadilly -> Jenc.Value
encodePiccadilly x = case x of
    NullInPiccadilly -> Jenc.null
    StringInPiccadilly y -> Jenc.string y
    DoubleInPiccadilly y -> Jenc.float y

piffler : Jdec.Decoder Piffler
piffler =
    Jdec.oneOf
        [ Jdec.map NullArrayInPiffler (Jdec.list (Jdec.null ()) )
        , Jdec.map MonaziteClassInPiffler monaziteClass
        ]

encodePiffler : Piffler -> Jenc.Value
encodePiffler x = case x of
    NullArrayInPiffler y -> Jenc.list (always Jenc.null) y
    MonaziteClassInPiffler y -> encodeMonaziteClass y

pithful : Jdec.Decoder Pithful
pithful =
    Jdec.oneOf
        [ Jdec.map BoolInPithful Jdec.bool
        , Jdec.map IntegerInPithful Jdec.int
        , Jdec.null NullInPithful
        ]

encodePithful : Pithful -> Jenc.Value
encodePithful x = case x of
    BoolInPithful y -> Jenc.bool y
    IntegerInPithful y -> Jenc.int y
    NullInPithful -> Jenc.null

placuntiti : Jdec.Decoder Placuntiti
placuntiti =
    Jdec.oneOf
        [ Jdec.map IntegerInPlacuntiti Jdec.int
        , Jdec.map IntegerMapInPlacuntiti (Jdec.dict Jdec.int)
        ]

encodePlacuntiti : Placuntiti -> Jenc.Value
encodePlacuntiti x = case x of
    IntegerInPlacuntiti y -> Jenc.int y
    IntegerMapInPlacuntiti y -> Jenc.dict identity Jenc.int y

plectopterous : Jdec.Decoder Plectopterous
plectopterous =
    Jdec.oneOf
        [ Jdec.map DoubleInPlectopterous Jdec.float
        , Jdec.map IntegerMapInPlectopterous (Jdec.dict Jdec.int)
        ]

encodePlectopterous : Plectopterous -> Jenc.Value
encodePlectopterous x = case x of
    DoubleInPlectopterous y -> Jenc.float y
    IntegerMapInPlectopterous y -> Jenc.dict identity Jenc.int y

pneumocele : Jdec.Decoder Pneumocele
pneumocele =
    Jdec.succeed Pneumocele
        |> Jpipe.custom (optionalField "Carbonarism" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "cineolic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "cobbly" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "conchyliferous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "congregation" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "enterotomy" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "entophytal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "fewtrils" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "herem" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "Koniga" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "meticulosity" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Micky" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "mismarriage" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "neurotrophic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "persuasively" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "replaceable" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "silex" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "taillight" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "unjealous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "visitorial" (Jdec.nullable (Jdec.null ())) Nothing)

encodePneumocele : Pneumocele -> Jenc.Value
encodePneumocele x =
    Jenc.object
        [ ("Carbonarism", makeNullableEncoder (always Jenc.null) x.carbonarism)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("cineolic", makeNullableEncoder (always Jenc.null) x.cineolic)
        , ("cobbly", makeNullableEncoder (always Jenc.null) x.cobbly)
        , ("conchyliferous", makeNullableEncoder (always Jenc.null) x.conchyliferous)
        , ("congregation", makeNullableEncoder (always Jenc.null) x.congregation)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("enterotomy", makeNullableEncoder (always Jenc.null) x.enterotomy)
        , ("entophytal", makeNullableEncoder (always Jenc.null) x.entophytal)
        , ("fewtrils", makeNullableEncoder (always Jenc.null) x.fewtrils)
        , ("herem", makeNullableEncoder (always Jenc.null) x.herem)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("Koniga", makeNullableEncoder (always Jenc.null) x.koniga)
        , ("meticulosity", makeNullableEncoder (always Jenc.null) x.meticulosity)
        , ("Micky", makeNullableEncoder (always Jenc.null) x.micky)
        , ("mismarriage", makeNullableEncoder (always Jenc.null) x.mismarriage)
        , ("neurotrophic", makeNullableEncoder (always Jenc.null) x.neurotrophic)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("persuasively", makeNullableEncoder (always Jenc.null) x.persuasively)
        , ("replaceable", makeNullableEncoder (always Jenc.null) x.replaceable)
        , ("silex", makeNullableEncoder (always Jenc.null) x.silex)
        , ("taillight", makeNullableEncoder (always Jenc.null) x.taillight)
        , ("unjealous", makeNullableEncoder (always Jenc.null) x.unjealous)
        , ("visitorial", makeNullableEncoder (always Jenc.null) x.visitorial)
        ]

poliorcetic : Jdec.Decoder Poliorcetic
poliorcetic =
    Jdec.oneOf
        [ Jdec.map BoolInPoliorcetic Jdec.bool
        , Jdec.map MonaziteClassInPoliorcetic monaziteClass
        ]

encodePoliorcetic : Poliorcetic -> Jenc.Value
encodePoliorcetic x = case x of
    BoolInPoliorcetic y -> Jenc.bool y
    MonaziteClassInPoliorcetic y -> encodeMonaziteClass y

poormaster : Jdec.Decoder Poormaster
poormaster =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInPoormaster (Jdec.list Jdec.int )
        , Jdec.null NullInPoormaster
        , Jdec.map IntegerMapInPoormaster (Jdec.dict Jdec.int)
        ]

encodePoormaster : Poormaster -> Jenc.Value
encodePoormaster x = case x of
    IntegerArrayInPoormaster y -> Jenc.list Jenc.int y
    NullInPoormaster -> Jenc.null
    IntegerMapInPoormaster y -> Jenc.dict identity Jenc.int y

potwhiskyElement : Jdec.Decoder PotwhiskyElement
potwhiskyElement =
    Jdec.oneOf
        [ Jdec.map IntegerInPotwhiskyElement Jdec.int
        , Jdec.null NullInPotwhiskyElement
        , Jdec.map PotwhiskyClassInPotwhiskyElement potwhiskyClass
        ]

encodePotwhiskyElement : PotwhiskyElement -> Jenc.Value
encodePotwhiskyElement x = case x of
    IntegerInPotwhiskyElement y -> Jenc.int y
    NullInPotwhiskyElement -> Jenc.null
    PotwhiskyClassInPotwhiskyElement y -> encodePotwhiskyClass y

potwhiskyClass : Jdec.Decoder PotwhiskyClass
potwhiskyClass =
    Jdec.succeed PotwhiskyClass
        |> Jpipe.required "arciform" (Jdec.null ())
        |> Jpipe.required "cresolin" (Jdec.null ())
        |> Jpipe.required "disheartener" (Jdec.null ())
        |> Jpipe.required "disproportionable" (Jdec.null ())
        |> Jpipe.required "Euchorda" (Jdec.null ())
        |> Jpipe.required "ferryway" (Jdec.null ())
        |> Jpipe.required "filamentiferous" (Jdec.null ())
        |> Jpipe.required "flemish" (Jdec.null ())
        |> Jpipe.required "forgainst" (Jdec.null ())
        |> Jpipe.required "grainering" (Jdec.null ())
        |> Jpipe.required "irrevoluble" (Jdec.null ())
        |> Jpipe.required "kindredship" (Jdec.null ())
        |> Jpipe.required "pinguitudinous" (Jdec.null ())
        |> Jpipe.required "simpletonic" (Jdec.null ())
        |> Jpipe.required "singsong" (Jdec.null ())
        |> Jpipe.required "submergement" (Jdec.null ())
        |> Jpipe.required "supraoesophagal" (Jdec.null ())
        |> Jpipe.required "thrashel" (Jdec.null ())
        |> Jpipe.required "tyremesis" (Jdec.null ())
        |> Jpipe.required "Yoruba" (Jdec.null ())

encodePotwhiskyClass : PotwhiskyClass -> Jenc.Value
encodePotwhiskyClass x =
    Jenc.object
        [ ("arciform", always Jenc.null x.arciform)
        , ("cresolin", always Jenc.null x.cresolin)
        , ("disheartener", always Jenc.null x.disheartener)
        , ("disproportionable", always Jenc.null x.disproportionable)
        , ("Euchorda", always Jenc.null x.euchorda)
        , ("ferryway", always Jenc.null x.ferryway)
        , ("filamentiferous", always Jenc.null x.filamentiferous)
        , ("flemish", always Jenc.null x.flemish)
        , ("forgainst", always Jenc.null x.forgainst)
        , ("grainering", always Jenc.null x.grainering)
        , ("irrevoluble", always Jenc.null x.irrevoluble)
        , ("kindredship", always Jenc.null x.kindredship)
        , ("pinguitudinous", always Jenc.null x.pinguitudinous)
        , ("simpletonic", always Jenc.null x.simpletonic)
        , ("singsong", always Jenc.null x.singsong)
        , ("submergement", always Jenc.null x.submergement)
        , ("supraoesophagal", always Jenc.null x.supraoesophagal)
        , ("thrashel", always Jenc.null x.thrashel)
        , ("tyremesis", always Jenc.null x.tyremesis)
        , ("Yoruba", always Jenc.null x.yoruba)
        ]

practicalizer : Jdec.Decoder Practicalizer
practicalizer =
    Jdec.oneOf
        [ Jdec.map NullArrayInPracticalizer (Jdec.list (Jdec.null ()) )
        , Jdec.map StringInPracticalizer Jdec.string
        , Jdec.map MonaziteClassInPracticalizer monaziteClass
        ]

encodePracticalizer : Practicalizer -> Jenc.Value
encodePracticalizer x = case x of
    NullArrayInPracticalizer y -> Jenc.list (always Jenc.null) y
    StringInPracticalizer y -> Jenc.string y
    MonaziteClassInPracticalizer y -> encodeMonaziteClass y

prefreshmanElement : Jdec.Decoder PrefreshmanElement
prefreshmanElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInPrefreshmanElement (Jdec.list (Jdec.null ()) )
        , Jdec.map StringInPrefreshmanElement Jdec.string
        , Jdec.map PrefreshmanClassInPrefreshmanElement prefreshmanClass
        ]

encodePrefreshmanElement : PrefreshmanElement -> Jenc.Value
encodePrefreshmanElement x = case x of
    NullArrayInPrefreshmanElement y -> Jenc.list (always Jenc.null) y
    StringInPrefreshmanElement y -> Jenc.string y
    PrefreshmanClassInPrefreshmanElement y -> encodePrefreshmanClass y

prefreshmanClass : Jdec.Decoder PrefreshmanClass
prefreshmanClass =
    Jdec.succeed PrefreshmanClass
        |> Jpipe.required "azorubine" (Jdec.null ())
        |> Jpipe.required "choroiditis" (Jdec.null ())
        |> Jpipe.required "coagulatory" (Jdec.null ())
        |> Jpipe.required "cyclorama" (Jdec.null ())
        |> Jpipe.required "Dolphus" (Jdec.null ())
        |> Jpipe.required "duckhearted" (Jdec.null ())
        |> Jpipe.required "Ficus" (Jdec.null ())
        |> Jpipe.required "Gemaric" (Jdec.null ())
        |> Jpipe.required "jugation" (Jdec.null ())
        |> Jpipe.required "myoliposis" (Jdec.null ())
        |> Jpipe.required "nonnomination" (Jdec.null ())
        |> Jpipe.required "palay" (Jdec.null ())
        |> Jpipe.required "pentactinal" (Jdec.null ())
        |> Jpipe.required "Phaet" (Jdec.null ())
        |> Jpipe.required "piquant" (Jdec.null ())
        |> Jpipe.required "registration" (Jdec.null ())
        |> Jpipe.required "remancipation" (Jdec.null ())
        |> Jpipe.required "scutatiform" (Jdec.null ())
        |> Jpipe.required "theodolite" (Jdec.null ())
        |> Jpipe.required "underward" (Jdec.null ())

encodePrefreshmanClass : PrefreshmanClass -> Jenc.Value
encodePrefreshmanClass x =
    Jenc.object
        [ ("azorubine", always Jenc.null x.azorubine)
        , ("choroiditis", always Jenc.null x.choroiditis)
        , ("coagulatory", always Jenc.null x.coagulatory)
        , ("cyclorama", always Jenc.null x.cyclorama)
        , ("Dolphus", always Jenc.null x.dolphus)
        , ("duckhearted", always Jenc.null x.duckhearted)
        , ("Ficus", always Jenc.null x.ficus)
        , ("Gemaric", always Jenc.null x.gemaric)
        , ("jugation", always Jenc.null x.jugation)
        , ("myoliposis", always Jenc.null x.myoliposis)
        , ("nonnomination", always Jenc.null x.nonnomination)
        , ("palay", always Jenc.null x.palay)
        , ("pentactinal", always Jenc.null x.pentactinal)
        , ("Phaet", always Jenc.null x.phaet)
        , ("piquant", always Jenc.null x.piquant)
        , ("registration", always Jenc.null x.registration)
        , ("remancipation", always Jenc.null x.remancipation)
        , ("scutatiform", always Jenc.null x.scutatiform)
        , ("theodolite", always Jenc.null x.theodolite)
        , ("underward", always Jenc.null x.underward)
        ]

prehensility : Jdec.Decoder Prehensility
prehensility =
    Jdec.oneOf
        [ Jdec.map NullArrayInPrehensility (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInPrehensility Jdec.bool
        , Jdec.map MonaziteClassInPrehensility monaziteClass
        ]

encodePrehensility : Prehensility -> Jenc.Value
encodePrehensility x = case x of
    NullArrayInPrehensility y -> Jenc.list (always Jenc.null) y
    BoolInPrehensility y -> Jenc.bool y
    MonaziteClassInPrehensility y -> encodeMonaziteClass y

prevoidance : Jdec.Decoder Prevoidance
prevoidance =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInPrevoidance (Jdec.list Jdec.int )
        , Jdec.map IntegerInPrevoidance Jdec.int
        , Jdec.map MonaziteClassInPrevoidance monaziteClass
        ]

encodePrevoidance : Prevoidance -> Jenc.Value
encodePrevoidance x = case x of
    IntegerArrayInPrevoidance y -> Jenc.list Jenc.int y
    IntegerInPrevoidance y -> Jenc.int y
    MonaziteClassInPrevoidance y -> encodeMonaziteClass y

protext : Jdec.Decoder Protext
protext =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInProtext (Jdec.list Jdec.int )
        , Jdec.map BoolInProtext Jdec.bool
        , Jdec.map MonaziteClassInProtext monaziteClass
        ]

encodeProtext : Protext -> Jenc.Value
encodeProtext x = case x of
    IntegerArrayInProtext y -> Jenc.list Jenc.int y
    BoolInProtext y -> Jenc.bool y
    MonaziteClassInProtext y -> encodeMonaziteClass y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
