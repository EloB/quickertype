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
    , PulpitismClass
    , PyodermiaClass
    , QuebrachineClass
    , Reimagine
    , Ressaut
    , RewriteClass
    , SantirClass
    , SaxtenClass
    , Scatty
    , SisteringClass
    , Staghunting
    , StrenuosityClass
    , TruantcyClass
    , UnimpeachablyClass
    , UnstressedClass
    , WrothyClass
    , Protrusive(..)
    , PulpitismElement(..)
    , PyodermiaElement(..)
    , QuebrachineElement(..)
    , Querier(..)
    , Rebarbative(..)
    , Retrocervical(..)
    , Revert(..)
    , RewriteElement(..)
    , Saccoderm(..)
    , SantirElement(..)
    , Saprophilous(..)
    , SaxtenElement(..)
    , Scoffer(..)
    , Scrampum(..)
    , Serpentinic(..)
    , Shadowable(..)
    , SisteringElement(..)
    , Stagmometer(..)
    , Stimulability(..)
    , Strangleable(..)
    , StrenuosityElement(..)
    , Tabaxir(..)
    , Talpiform(..)
    , Thwack(..)
    , Tortricine(..)
    , TruantcyElement(..)
    , Unbeginning(..)
    , Undesirability(..)
    , Unerasing(..)
    , Unguentarium(..)
    , UnimpeachablyElement(..)
    , Unmortgaged(..)
    , Unobstructed(..)
    , Unreceptivity(..)
    , Unsatisfactoriness(..)
    , UnstressedElement(..)
    , Untasked(..)
    , Unvarying(..)
    , Vehemently(..)
    , Whitepot(..)
    , WrothyElement(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)
import Array exposing (Array)

type alias QuickType =
    { protrusive : Array Protrusive
    , pulpitism : Array PulpitismElement
    , pyodermia : Array PyodermiaElement
    , quebrachine : Array QuebrachineElement
    , querier : Array Querier
    , rebarbative : Array Rebarbative
    , reimagine : Array Reimagine
    , ressaut : Ressaut
    , retrocervical : Array Retrocervical
    , revert : Array Revert
    , rewrite : Array RewriteElement
    , saccoderm : Array Saccoderm
    , santir : Array SantirElement
    , saprophilous : Array Saprophilous
    , saxten : Array SaxtenElement
    , scatty : Array (Maybe Scatty)
    , scoffer : Array Scoffer
    , scrampum : Array Scrampum
    , semantic : Float
    , serpentinic : Array Serpentinic
    , shadowable : Array Shadowable
    , sistering : Array SisteringElement
    , staghunting : Array Staghunting
    , stagmometer : Array Stagmometer
    , stimulability : Array Stimulability
    , strangleable : Array Strangleable
    , strenuosity : Array StrenuosityElement
    , tabaxir : Array Tabaxir
    , talpiform : Array Talpiform
    , thwack : Array Thwack
    , to : Array (Maybe Float)
    , tortricine : Array Tortricine
    , truantcy : Array TruantcyElement
    , turgesce : Array String
    , unbeginning : Array Unbeginning
    , underdunged : Array Float
    , undesirability : Array Undesirability
    , unerasing : Array Unerasing
    , unguentarium : Array Unguentarium
    , unimpeachably : Array UnimpeachablyElement
    , unmortgaged : Array Unmortgaged
    , unobstructed : Array Unobstructed
    , unreceptivity : Array Unreceptivity
    , unsatisfactoriness : Array Unsatisfactoriness
    , unsecurity : Array Int
    , unstressed : Array UnstressedElement
    , untasked : Array Untasked
    , unvarying : Array Unvarying
    , vehemently : Array Vehemently
    , warriorship : Dict String Bool
    , whitepot : Array Whitepot
    , wrothy : Array WrothyElement
    }

type Protrusive
    = DoubleInProtrusive Float
    | UnionArrayInProtrusive (Array (Maybe Int))

type PulpitismElement
    = DoubleInPulpitismElement Float
    | IntegerArrayInPulpitismElement (Array Int)
    | PulpitismClassInPulpitismElement PulpitismClass

type alias PulpitismClass =
    { abnet : ()
    , buckhorn : ()
    , calciform : ()
    , chelophore : ()
    , cogitation : ()
    , decreeable : ()
    , despicable : ()
    , isodiazo : ()
    , jadedly : ()
    , leptochlorite : ()
    , nursling : ()
    , palamedean : ()
    , photoheliograph : ()
    , pipewood : ()
    , roberd : ()
    , statable : ()
    , superassume : ()
    , syllabe : ()
    , toughhead : ()
    , underburn : ()
    }

type PyodermiaElement
    = IntegerInPyodermiaElement Int
    | PyodermiaClassInPyodermiaElement PyodermiaClass

type alias PyodermiaClass =
    { aphoristically : ()
    , apophyllous : ()
    , cognize : ()
    , dermonosology : ()
    , gyppo : ()
    , ither : ()
    , juglandaceous : ()
    , litho : ()
    , macropterous : ()
    , photographer : ()
    , romancing : ()
    , rumness : ()
    , somniloquist : ()
    , stressfully : ()
    , tactically : ()
    , tracheophony : ()
    , unappositely : ()
    , unclothedly : ()
    , unimplied : ()
    , unsyncopated : ()
    }

type QuebrachineElement
    = BoolInQuebrachineElement Bool
    | NullInQuebrachineElement
    | QuebrachineClassInQuebrachineElement QuebrachineClass

type alias QuebrachineClass =
    { catharticalness : Float
    , chirotherium : Int
    , disdiapason : String
    , homocerc : Bool
    , nonbookish : ()
    }

type Querier
    = BoolInQuerier Bool
    | IntegerMapInQuerier (Dict String Int)

type Rebarbative
    = BoolInRebarbative Bool
    | DoubleInRebarbative Float
    | IntegerArrayInRebarbative (Array Int)

type alias Reimagine =
    { adducible : Maybe ()
    , anabolin : Maybe ()
    , brainy : Maybe ()
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , chrysamine : Maybe ()
    , disdiapason : Maybe String
    , fluxweed : Maybe ()
    , glaucine : Maybe ()
    , grobianism : Maybe ()
    , hermo : Maybe ()
    , hieroglyphist : Maybe ()
    , homocerc : Maybe Bool
    , icteroid : Maybe ()
    , immortal : Maybe ()
    , impetulant : Maybe ()
    , irrigate : Maybe ()
    , myxedema : Maybe ()
    , nonbookish : Maybe ()
    , onyx : Maybe ()
    , repasser : Maybe ()
    , septomarginal : Maybe ()
    , subdie : Maybe ()
    , tibiometatarsal : Maybe ()
    , waltzlike : Maybe ()
    }

type alias Ressaut =
    { apperceptive : String
    , cuttoo : String
    , douser : String
    , drinkproof : String
    , forementioned : String
    , freesia : String
    , genevieve : String
    , hyperdiabolical : String
    , hypocone : String
    , irreverentially : String
    , jumart : String
    , mimosaceae : String
    , mollicrush : String
    , nedder : String
    , retinasphalt : String
    , sough : String
    , steading : String
    , theopaschitism : String
    , undurableness : String
    , unmingleable : String
    }

type Retrocervical
    = IntegerInRetrocervical Int
    | UnionArrayInRetrocervical (Array (Maybe Int))

type Revert
    = BoolInRevert Bool
    | StringInRevert String

type RewriteElement
    = DoubleInRewriteElement Float
    | NullArrayInRewriteElement (Array ())
    | RewriteClassInRewriteElement RewriteClass

type alias RewriteClass =
    { accountancy : ()
    , cacotrophic : ()
    , contest : ()
    , couthily : ()
    , falculate : ()
    , foreseize : ()
    , hyades : ()
    , lemnad : ()
    , monotheistically : ()
    , nonflying : ()
    , ptenoglossa : ()
    , repatch : ()
    , rodman : ()
    , strung : ()
    , titmal : ()
    , twalpennyworth : ()
    , unblamable : ()
    , vertical : ()
    , whiggification : ()
    , yardman : ()
    }

type Saccoderm
    = IntegerArrayInSaccoderm (Array Int)
    | NullInSaccoderm
    | StringInSaccoderm String

type SantirElement
    = DoubleInSantirElement Float
    | SantirClassInSantirElement SantirClass

type alias SantirClass =
    { admiredly : ()
    , demicaponier : ()
    , epitympanic : ()
    , investitor : ()
    , lupiform : ()
    , monoflagellate : ()
    , paleoethnic : ()
    , prediscountable : ()
    , rhetoricals : ()
    , roomth : ()
    , saccharose : ()
    , septonasal : ()
    , serpenticide : ()
    , setarious : ()
    , spaework : ()
    , stylite : ()
    , suessiones : ()
    , timelily : ()
    , unprofaned : ()
    , vorticular : ()
    }

type Saprophilous
    = IntegerMapInSaprophilous (Dict String Int)
    | NullInSaprophilous
    | StringInSaprophilous String

type SaxtenElement
    = SaxtenClassInSaxtenElement SaxtenClass
    | StringInSaxtenElement String

type alias SaxtenClass =
    { algarrobilla : Maybe ()
    , bowgrace : Maybe ()
    , catharticalness : Maybe Float
    , centaurid : Maybe ()
    , chirotherium : Maybe Int
    , disdiapason : Maybe String
    , flix : Maybe ()
    , germanely : Maybe ()
    , homocerc : Maybe Bool
    , inhume : Maybe ()
    , lepidote : Maybe ()
    , megalochirous : Maybe ()
    , ninepenny : Maybe ()
    , nonbookish : Maybe ()
    , nondeist : Maybe ()
    , nymphaeaceous : Maybe ()
    , parietofrontal : Maybe ()
    , sancyite : Maybe ()
    , subjectivist : Maybe ()
    , tibiad : Maybe ()
    , transonic : Maybe ()
    , tripetalous : Maybe ()
    , trunchman : Maybe ()
    , urger : Maybe ()
    , withdrawnness : Maybe ()
    }

type alias Scatty =
    { aeriferous : ()
    , antical : ()
    , antighostism : ()
    , arcanum : ()
    , autotrophy : ()
    , baronial : ()
    , caffeine : ()
    , gorgoniacean : ()
    , heroical : ()
    , hydropical : ()
    , mechanology : ()
    , musicopoetic : ()
    , officiality : ()
    , oftentimes : ()
    , ophthalmotonometer : ()
    , reflectively : ()
    , springer : ()
    , tabasco : ()
    , teleianthous : ()
    , uncombated : ()
    }

type Scoffer
    = IntegerMapInScoffer (Dict String Int)
    | NullArrayInScoffer (Array ())
    | NullInScoffer

type Scrampum
    = BoolInScrampum Bool
    | IntegerArrayInScrampum (Array Int)
    | NullInScrampum

type Serpentinic
    = DoubleInSerpentinic Float
    | IntegerArrayInSerpentinic (Array Int)

type Shadowable
    = BoolInShadowable Bool
    | UnionArrayInShadowable (Array (Maybe Int))

type SisteringElement
    = IntegerInSisteringElement Int
    | NullArrayInSisteringElement (Array ())
    | SisteringClassInSisteringElement SisteringClass

type alias SisteringClass =
    { amphicarpic : ()
    , chianti : ()
    , frigorific : ()
    , haplomi : ()
    , hyperkinesis : ()
    , laudable : ()
    , madwoman : ()
    , maimedly : ()
    , micropterygidae : ()
    , microrhabdus : ()
    , nondense : ()
    , phlebemphraxis : ()
    , redsear : ()
    , schismatical : ()
    , tartryl : ()
    , unabhorred : ()
    , undeliberateness : ()
    , unmixable : ()
    , untruckling : ()
    , vineal : ()
    }

type alias Staghunting =
    { calorimetric : Maybe Int
    , canid : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , disdiapason : Maybe String
    , ditriglyphic : Maybe Int
    , floriferousness : Maybe Int
    , gamelike : Maybe Int
    , grig : Maybe Int
    , homocerc : Maybe Bool
    , interloan : Maybe Int
    , lithotomy : Maybe Int
    , loric : Maybe Int
    , membranocoriaceous : Maybe Int
    , membranogenic : Maybe Int
    , nonbookish : Maybe ()
    , overtrump : Maybe Int
    , scotino : Maybe Int
    , seasonable : Maybe Int
    , sephen : Maybe Int
    , stigmarioid : Maybe Int
    , tired : Maybe Int
    , trifid : Maybe Int
    , undefeatedly : Maybe Int
    , ungirlish : Maybe Int
    }

type Stagmometer
    = StringInStagmometer String
    | UnionArrayInStagmometer (Array (Maybe Int))

type Stimulability
    = BoolInStimulability Bool
    | IntegerInStimulability Int
    | IntegerMapInStimulability (Dict String Int)

type Strangleable
    = DoubleInStrangleable Float
    | NullArrayInStrangleable (Array ())

type StrenuosityElement
    = NullArrayInStrenuosityElement (Array ())
    | StrenuosityClassInStrenuosityElement StrenuosityClass

type alias StrenuosityClass =
    { bliss : Maybe Int
    , buccate : Maybe Int
    , bulletproof : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , crumblingness : Maybe Int
    , disdiapason : Maybe String
    , engagedly : Maybe Int
    , fightable : Maybe Int
    , hoariness : Maybe Int
    , homocerc : Maybe Bool
    , hypopodium : Maybe Int
    , luxurist : Maybe Int
    , mechanician : Maybe Int
    , nonbookish : Maybe ()
    , onopordon : Maybe Int
    , podgily : Maybe Int
    , reformableness : Maybe Int
    , scatterbrains : Maybe Int
    , seminuria : Maybe Int
    , sodomite : Maybe Int
    , tramp : Maybe Int
    , undueness : Maybe Int
    , worthily : Maybe Int
    , yankeeist : Maybe Int
    }

type Tabaxir
    = BoolInTabaxir Bool
    | DoubleInTabaxir Float

type Talpiform
    = DoubleInTalpiform Float
    | NullInTalpiform
    | QuebrachineClassInTalpiform QuebrachineClass

type Thwack
    = BoolInThwack Bool
    | DoubleInThwack Float
    | QuebrachineClassInThwack QuebrachineClass

type Tortricine
    = QuebrachineClassInTortricine QuebrachineClass
    | UnionArrayInTortricine (Array (Maybe Int))

type TruantcyElement
    = BoolInTruantcyElement Bool
    | TruantcyClassInTruantcyElement TruantcyClass

type alias TruantcyClass =
    { alfiona : Maybe ()
    , ascaridiasis : Maybe ()
    , bungey : Maybe ()
    , catharticalness : Maybe Float
    , ceroxyle : Maybe ()
    , chirotherium : Maybe Int
    , chorology : Maybe ()
    , disdiapason : Maybe String
    , enmarble : Maybe ()
    , epeira : Maybe ()
    , eurylaimi : Maybe ()
    , germination : Maybe ()
    , hallelujah : Maybe ()
    , homocerc : Maybe Bool
    , lev : Maybe ()
    , mouthing : Maybe ()
    , nonbookish : Maybe ()
    , philliloo : Maybe ()
    , planetal : Maybe ()
    , poney : Maybe ()
    , punctualist : Maybe ()
    , returnlessly : Maybe ()
    , skelder : Maybe ()
    , windwaywardly : Maybe ()
    , yuman : Maybe ()
    }

type Unbeginning
    = IntegerMapInUnbeginning (Dict String Int)
    | NullArrayInUnbeginning (Array ())
    | StringInUnbeginning String

type Undesirability
    = IntegerArrayInUndesirability (Array Int)
    | IntegerMapInUndesirability (Dict String Int)
    | StringInUndesirability String

type Unerasing
    = IntegerInUnerasing Int
    | IntegerMapInUnerasing (Dict String Int)
    | NullArrayInUnerasing (Array ())

type Unguentarium
    = IntegerInUnguentarium Int
    | NullArrayInUnguentarium (Array ())
    | NullInUnguentarium

type UnimpeachablyElement
    = BoolInUnimpeachablyElement Bool
    | UnimpeachablyClassInUnimpeachablyElement UnimpeachablyClass

type alias UnimpeachablyClass =
    { acerin : Maybe Int
    , bobadil : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , chlorophylligenous : Maybe Int
    , conversational : Maybe Int
    , demiowl : Maybe Int
    , disdiapason : Maybe String
    , ectorhinal : Maybe Int
    , gamblesomeness : Maybe Int
    , homocerc : Maybe Bool
    , irrorate : Maybe Int
    , kindergartening : Maybe Int
    , lateritic : Maybe Int
    , mespil : Maybe Int
    , misconfiguration : Maybe Int
    , nonbookish : Maybe ()
    , planometry : Maybe Int
    , quiina : Maybe Int
    , robert : Maybe Int
    , rot : Maybe Int
    , subcinctorium : Maybe Int
    , tussocker : Maybe Int
    , ultraproud : Maybe Int
    , unsuggestedness : Maybe Int
    }

type Unmortgaged
    = DoubleInUnmortgaged Float
    | IntegerMapInUnmortgaged (Dict String Int)
    | NullInUnmortgaged

type Unobstructed
    = IntegerInUnobstructed Int
    | NullInUnobstructed
    | QuebrachineClassInUnobstructed QuebrachineClass

type Unreceptivity
    = IntegerInUnreceptivity Int
    | NullArrayInUnreceptivity (Array ())
    | StringInUnreceptivity String

type Unsatisfactoriness
    = BoolInUnsatisfactoriness Bool
    | IntegerArrayInUnsatisfactoriness (Array Int)
    | IntegerInUnsatisfactoriness Int

type UnstressedElement
    = BoolInUnstressedElement Bool
    | StringInUnstressedElement String
    | UnstressedClassInUnstressedElement UnstressedClass

type alias UnstressedClass =
    { alain : ()
    , amphirhina : ()
    , antimachinery : ()
    , coldish : ()
    , crantara : ()
    , distinguishing : ()
    , elytroposis : ()
    , gentianwort : ()
    , heliosis : ()
    , instrumental : ()
    , introinflection : ()
    , kala : ()
    , lincolnian : ()
    , metad : ()
    , sarcophilus : ()
    , swingingly : ()
    , unconformity : ()
    , undecreed : ()
    , venerable : ()
    , vowellessness : ()
    }

type Untasked
    = DoubleInUntasked Float
    | IntegerMapInUntasked (Dict String Int)
    | NullArrayInUntasked (Array ())

type Unvarying
    = BoolInUnvarying Bool
    | DoubleInUnvarying Float
    | IntegerMapInUnvarying (Dict String Int)

type Vehemently
    = BoolInVehemently Bool
    | NullArrayInVehemently (Array ())
    | NullInVehemently

type Whitepot
    = DoubleInWhitepot Float
    | QuebrachineClassInWhitepot QuebrachineClass

type WrothyElement
    = NullArrayInWrothyElement (Array ())
    | WrothyClassInWrothyElement WrothyClass

type alias WrothyClass =
    { aeschynanthus : ()
    , aquiferous : ()
    , cheapener : ()
    , enumeration : ()
    , ephesine : ()
    , escadrille : ()
    , estrous : ()
    , interestedly : ()
    , katakinetomer : ()
    , mortification : ()
    , morula : ()
    , orthosymmetrical : ()
    , overbark : ()
    , politist : ()
    , qualified : ()
    , sphenomalar : ()
    , throatful : ()
    , transhumance : ()
    , triandrian : ()
    , unbooked : ()
    }

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
        |> Jpipe.required "protrusive" (Jdec.array protrusive )
        |> Jpipe.required "pulpitism" (Jdec.array pulpitismElement )
        |> Jpipe.required "pyodermia" (Jdec.array pyodermiaElement )
        |> Jpipe.required "quebrachine" (Jdec.array quebrachineElement )
        |> Jpipe.required "querier" (Jdec.array querier )
        |> Jpipe.required "rebarbative" (Jdec.array rebarbative )
        |> Jpipe.required "reimagine" (Jdec.array reimagine )
        |> Jpipe.required "ressaut" ressaut
        |> Jpipe.required "retrocervical" (Jdec.array retrocervical )
        |> Jpipe.required "revert" (Jdec.array revert )
        |> Jpipe.required "rewrite" (Jdec.array rewriteElement )
        |> Jpipe.required "saccoderm" (Jdec.array saccoderm )
        |> Jpipe.required "santir" (Jdec.array santirElement )
        |> Jpipe.required "saprophilous" (Jdec.array saprophilous )
        |> Jpipe.required "saxten" (Jdec.array saxtenElement )
        |> Jpipe.required "scatty" (Jdec.array (Jdec.nullable scatty) )
        |> Jpipe.required "scoffer" (Jdec.array scoffer )
        |> Jpipe.required "scrampum" (Jdec.array scrampum )
        |> Jpipe.required "semantic" Jdec.float
        |> Jpipe.required "serpentinic" (Jdec.array serpentinic )
        |> Jpipe.required "shadowable" (Jdec.array shadowable )
        |> Jpipe.required "sistering" (Jdec.array sisteringElement )
        |> Jpipe.required "staghunting" (Jdec.array staghunting )
        |> Jpipe.required "stagmometer" (Jdec.array stagmometer )
        |> Jpipe.required "stimulability" (Jdec.array stimulability )
        |> Jpipe.required "strangleable" (Jdec.array strangleable )
        |> Jpipe.required "strenuosity" (Jdec.array strenuosityElement )
        |> Jpipe.required "tabaxir" (Jdec.array tabaxir )
        |> Jpipe.required "talpiform" (Jdec.array talpiform )
        |> Jpipe.required "thwack" (Jdec.array thwack )
        |> Jpipe.required "to" (Jdec.array (Jdec.nullable Jdec.float) )
        |> Jpipe.required "tortricine" (Jdec.array tortricine )
        |> Jpipe.required "truantcy" (Jdec.array truantcyElement )
        |> Jpipe.required "turgesce" (Jdec.array Jdec.string )
        |> Jpipe.required "unbeginning" (Jdec.array unbeginning )
        |> Jpipe.required "underdunged" (Jdec.array Jdec.float )
        |> Jpipe.required "undesirability" (Jdec.array undesirability )
        |> Jpipe.required "unerasing" (Jdec.array unerasing )
        |> Jpipe.required "unguentarium" (Jdec.array unguentarium )
        |> Jpipe.required "unimpeachably" (Jdec.array unimpeachablyElement )
        |> Jpipe.required "unmortgaged" (Jdec.array unmortgaged )
        |> Jpipe.required "unobstructed" (Jdec.array unobstructed )
        |> Jpipe.required "unreceptivity" (Jdec.array unreceptivity )
        |> Jpipe.required "unsatisfactoriness" (Jdec.array unsatisfactoriness )
        |> Jpipe.required "unsecurity" (Jdec.array Jdec.int )
        |> Jpipe.required "unstressed" (Jdec.array unstressedElement )
        |> Jpipe.required "untasked" (Jdec.array untasked )
        |> Jpipe.required "unvarying" (Jdec.array unvarying )
        |> Jpipe.required "vehemently" (Jdec.array vehemently )
        |> Jpipe.required "warriorship" (Jdec.dict Jdec.bool)
        |> Jpipe.required "whitepot" (Jdec.array whitepot )
        |> Jpipe.required "wrothy" (Jdec.array wrothyElement )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("protrusive", Jenc.array encodeProtrusive x.protrusive)
        , ("pulpitism", Jenc.array encodePulpitismElement x.pulpitism)
        , ("pyodermia", Jenc.array encodePyodermiaElement x.pyodermia)
        , ("quebrachine", Jenc.array encodeQuebrachineElement x.quebrachine)
        , ("querier", Jenc.array encodeQuerier x.querier)
        , ("rebarbative", Jenc.array encodeRebarbative x.rebarbative)
        , ("reimagine", Jenc.array encodeReimagine x.reimagine)
        , ("ressaut", encodeRessaut x.ressaut)
        , ("retrocervical", Jenc.array encodeRetrocervical x.retrocervical)
        , ("revert", Jenc.array encodeRevert x.revert)
        , ("rewrite", Jenc.array encodeRewriteElement x.rewrite)
        , ("saccoderm", Jenc.array encodeSaccoderm x.saccoderm)
        , ("santir", Jenc.array encodeSantirElement x.santir)
        , ("saprophilous", Jenc.array encodeSaprophilous x.saprophilous)
        , ("saxten", Jenc.array encodeSaxtenElement x.saxten)
        , ("scatty", Jenc.array (makeNullableEncoder encodeScatty) x.scatty)
        , ("scoffer", Jenc.array encodeScoffer x.scoffer)
        , ("scrampum", Jenc.array encodeScrampum x.scrampum)
        , ("semantic", Jenc.float x.semantic)
        , ("serpentinic", Jenc.array encodeSerpentinic x.serpentinic)
        , ("shadowable", Jenc.array encodeShadowable x.shadowable)
        , ("sistering", Jenc.array encodeSisteringElement x.sistering)
        , ("staghunting", Jenc.array encodeStaghunting x.staghunting)
        , ("stagmometer", Jenc.array encodeStagmometer x.stagmometer)
        , ("stimulability", Jenc.array encodeStimulability x.stimulability)
        , ("strangleable", Jenc.array encodeStrangleable x.strangleable)
        , ("strenuosity", Jenc.array encodeStrenuosityElement x.strenuosity)
        , ("tabaxir", Jenc.array encodeTabaxir x.tabaxir)
        , ("talpiform", Jenc.array encodeTalpiform x.talpiform)
        , ("thwack", Jenc.array encodeThwack x.thwack)
        , ("to", Jenc.array (makeNullableEncoder Jenc.float) x.to)
        , ("tortricine", Jenc.array encodeTortricine x.tortricine)
        , ("truantcy", Jenc.array encodeTruantcyElement x.truantcy)
        , ("turgesce", Jenc.array Jenc.string x.turgesce)
        , ("unbeginning", Jenc.array encodeUnbeginning x.unbeginning)
        , ("underdunged", Jenc.array Jenc.float x.underdunged)
        , ("undesirability", Jenc.array encodeUndesirability x.undesirability)
        , ("unerasing", Jenc.array encodeUnerasing x.unerasing)
        , ("unguentarium", Jenc.array encodeUnguentarium x.unguentarium)
        , ("unimpeachably", Jenc.array encodeUnimpeachablyElement x.unimpeachably)
        , ("unmortgaged", Jenc.array encodeUnmortgaged x.unmortgaged)
        , ("unobstructed", Jenc.array encodeUnobstructed x.unobstructed)
        , ("unreceptivity", Jenc.array encodeUnreceptivity x.unreceptivity)
        , ("unsatisfactoriness", Jenc.array encodeUnsatisfactoriness x.unsatisfactoriness)
        , ("unsecurity", Jenc.array Jenc.int x.unsecurity)
        , ("unstressed", Jenc.array encodeUnstressedElement x.unstressed)
        , ("untasked", Jenc.array encodeUntasked x.untasked)
        , ("unvarying", Jenc.array encodeUnvarying x.unvarying)
        , ("vehemently", Jenc.array encodeVehemently x.vehemently)
        , ("warriorship", Jenc.dict identity Jenc.bool x.warriorship)
        , ("whitepot", Jenc.array encodeWhitepot x.whitepot)
        , ("wrothy", Jenc.array encodeWrothyElement x.wrothy)
        ]

protrusive : Jdec.Decoder Protrusive
protrusive =
    Jdec.oneOf
        [ Jdec.map UnionArrayInProtrusive (Jdec.array (Jdec.nullable Jdec.int) )
        , Jdec.map DoubleInProtrusive Jdec.float
        ]

encodeProtrusive : Protrusive -> Jenc.Value
encodeProtrusive x = case x of
    UnionArrayInProtrusive y -> Jenc.array (makeNullableEncoder Jenc.int) y
    DoubleInProtrusive y -> Jenc.float y

pulpitismElement : Jdec.Decoder PulpitismElement
pulpitismElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInPulpitismElement (Jdec.array Jdec.int )
        , Jdec.map DoubleInPulpitismElement Jdec.float
        , Jdec.map PulpitismClassInPulpitismElement pulpitismClass
        ]

encodePulpitismElement : PulpitismElement -> Jenc.Value
encodePulpitismElement x = case x of
    IntegerArrayInPulpitismElement y -> Jenc.array Jenc.int y
    DoubleInPulpitismElement y -> Jenc.float y
    PulpitismClassInPulpitismElement y -> encodePulpitismClass y

pulpitismClass : Jdec.Decoder PulpitismClass
pulpitismClass =
    Jdec.succeed PulpitismClass
        |> Jpipe.required "abnet" (Jdec.null ())
        |> Jpipe.required "buckhorn" (Jdec.null ())
        |> Jpipe.required "calciform" (Jdec.null ())
        |> Jpipe.required "chelophore" (Jdec.null ())
        |> Jpipe.required "cogitation" (Jdec.null ())
        |> Jpipe.required "decreeable" (Jdec.null ())
        |> Jpipe.required "despicable" (Jdec.null ())
        |> Jpipe.required "isodiazo" (Jdec.null ())
        |> Jpipe.required "jadedly" (Jdec.null ())
        |> Jpipe.required "leptochlorite" (Jdec.null ())
        |> Jpipe.required "nursling" (Jdec.null ())
        |> Jpipe.required "palamedean" (Jdec.null ())
        |> Jpipe.required "photoheliograph" (Jdec.null ())
        |> Jpipe.required "pipewood" (Jdec.null ())
        |> Jpipe.required "roberd" (Jdec.null ())
        |> Jpipe.required "statable" (Jdec.null ())
        |> Jpipe.required "superassume" (Jdec.null ())
        |> Jpipe.required "syllabe" (Jdec.null ())
        |> Jpipe.required "toughhead" (Jdec.null ())
        |> Jpipe.required "underburn" (Jdec.null ())

encodePulpitismClass : PulpitismClass -> Jenc.Value
encodePulpitismClass x =
    Jenc.object
        [ ("abnet", always Jenc.null x.abnet)
        , ("buckhorn", always Jenc.null x.buckhorn)
        , ("calciform", always Jenc.null x.calciform)
        , ("chelophore", always Jenc.null x.chelophore)
        , ("cogitation", always Jenc.null x.cogitation)
        , ("decreeable", always Jenc.null x.decreeable)
        , ("despicable", always Jenc.null x.despicable)
        , ("isodiazo", always Jenc.null x.isodiazo)
        , ("jadedly", always Jenc.null x.jadedly)
        , ("leptochlorite", always Jenc.null x.leptochlorite)
        , ("nursling", always Jenc.null x.nursling)
        , ("palamedean", always Jenc.null x.palamedean)
        , ("photoheliograph", always Jenc.null x.photoheliograph)
        , ("pipewood", always Jenc.null x.pipewood)
        , ("roberd", always Jenc.null x.roberd)
        , ("statable", always Jenc.null x.statable)
        , ("superassume", always Jenc.null x.superassume)
        , ("syllabe", always Jenc.null x.syllabe)
        , ("toughhead", always Jenc.null x.toughhead)
        , ("underburn", always Jenc.null x.underburn)
        ]

pyodermiaElement : Jdec.Decoder PyodermiaElement
pyodermiaElement =
    Jdec.oneOf
        [ Jdec.map IntegerInPyodermiaElement Jdec.int
        , Jdec.map PyodermiaClassInPyodermiaElement pyodermiaClass
        ]

encodePyodermiaElement : PyodermiaElement -> Jenc.Value
encodePyodermiaElement x = case x of
    IntegerInPyodermiaElement y -> Jenc.int y
    PyodermiaClassInPyodermiaElement y -> encodePyodermiaClass y

pyodermiaClass : Jdec.Decoder PyodermiaClass
pyodermiaClass =
    Jdec.succeed PyodermiaClass
        |> Jpipe.required "aphoristically" (Jdec.null ())
        |> Jpipe.required "apophyllous" (Jdec.null ())
        |> Jpipe.required "cognize" (Jdec.null ())
        |> Jpipe.required "dermonosology" (Jdec.null ())
        |> Jpipe.required "Gyppo" (Jdec.null ())
        |> Jpipe.required "ither" (Jdec.null ())
        |> Jpipe.required "juglandaceous" (Jdec.null ())
        |> Jpipe.required "litho" (Jdec.null ())
        |> Jpipe.required "macropterous" (Jdec.null ())
        |> Jpipe.required "photographer" (Jdec.null ())
        |> Jpipe.required "romancing" (Jdec.null ())
        |> Jpipe.required "rumness" (Jdec.null ())
        |> Jpipe.required "somniloquist" (Jdec.null ())
        |> Jpipe.required "stressfully" (Jdec.null ())
        |> Jpipe.required "tactically" (Jdec.null ())
        |> Jpipe.required "tracheophony" (Jdec.null ())
        |> Jpipe.required "unappositely" (Jdec.null ())
        |> Jpipe.required "unclothedly" (Jdec.null ())
        |> Jpipe.required "unimplied" (Jdec.null ())
        |> Jpipe.required "unsyncopated" (Jdec.null ())

encodePyodermiaClass : PyodermiaClass -> Jenc.Value
encodePyodermiaClass x =
    Jenc.object
        [ ("aphoristically", always Jenc.null x.aphoristically)
        , ("apophyllous", always Jenc.null x.apophyllous)
        , ("cognize", always Jenc.null x.cognize)
        , ("dermonosology", always Jenc.null x.dermonosology)
        , ("Gyppo", always Jenc.null x.gyppo)
        , ("ither", always Jenc.null x.ither)
        , ("juglandaceous", always Jenc.null x.juglandaceous)
        , ("litho", always Jenc.null x.litho)
        , ("macropterous", always Jenc.null x.macropterous)
        , ("photographer", always Jenc.null x.photographer)
        , ("romancing", always Jenc.null x.romancing)
        , ("rumness", always Jenc.null x.rumness)
        , ("somniloquist", always Jenc.null x.somniloquist)
        , ("stressfully", always Jenc.null x.stressfully)
        , ("tactically", always Jenc.null x.tactically)
        , ("tracheophony", always Jenc.null x.tracheophony)
        , ("unappositely", always Jenc.null x.unappositely)
        , ("unclothedly", always Jenc.null x.unclothedly)
        , ("unimplied", always Jenc.null x.unimplied)
        , ("unsyncopated", always Jenc.null x.unsyncopated)
        ]

quebrachineElement : Jdec.Decoder QuebrachineElement
quebrachineElement =
    Jdec.oneOf
        [ Jdec.map BoolInQuebrachineElement Jdec.bool
        , Jdec.null NullInQuebrachineElement
        , Jdec.map QuebrachineClassInQuebrachineElement quebrachineClass
        ]

encodeQuebrachineElement : QuebrachineElement -> Jenc.Value
encodeQuebrachineElement x = case x of
    BoolInQuebrachineElement y -> Jenc.bool y
    NullInQuebrachineElement -> Jenc.null
    QuebrachineClassInQuebrachineElement y -> encodeQuebrachineClass y

quebrachineClass : Jdec.Decoder QuebrachineClass
quebrachineClass =
    Jdec.succeed QuebrachineClass
        |> Jpipe.required "catharticalness" Jdec.float
        |> Jpipe.required "Chirotherium" Jdec.int
        |> Jpipe.required "disdiapason" Jdec.string
        |> Jpipe.required "homocerc" Jdec.bool
        |> Jpipe.required "nonbookish" (Jdec.null ())

encodeQuebrachineClass : QuebrachineClass -> Jenc.Value
encodeQuebrachineClass x =
    Jenc.object
        [ ("catharticalness", Jenc.float x.catharticalness)
        , ("Chirotherium", Jenc.int x.chirotherium)
        , ("disdiapason", Jenc.string x.disdiapason)
        , ("homocerc", Jenc.bool x.homocerc)
        , ("nonbookish", always Jenc.null x.nonbookish)
        ]

querier : Jdec.Decoder Querier
querier =
    Jdec.oneOf
        [ Jdec.map BoolInQuerier Jdec.bool
        , Jdec.map IntegerMapInQuerier (Jdec.dict Jdec.int)
        ]

encodeQuerier : Querier -> Jenc.Value
encodeQuerier x = case x of
    BoolInQuerier y -> Jenc.bool y
    IntegerMapInQuerier y -> Jenc.dict identity Jenc.int y

rebarbative : Jdec.Decoder Rebarbative
rebarbative =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInRebarbative (Jdec.array Jdec.int )
        , Jdec.map BoolInRebarbative Jdec.bool
        , Jdec.map DoubleInRebarbative Jdec.float
        ]

encodeRebarbative : Rebarbative -> Jenc.Value
encodeRebarbative x = case x of
    IntegerArrayInRebarbative y -> Jenc.array Jenc.int y
    BoolInRebarbative y -> Jenc.bool y
    DoubleInRebarbative y -> Jenc.float y

reimagine : Jdec.Decoder Reimagine
reimagine =
    Jdec.succeed Reimagine
        |> Jpipe.custom (optionalField "adducible" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "anabolin" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "brainy" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "chrysamine" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "fluxweed" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "glaucine" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "grobianism" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Hermo" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "hieroglyphist" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "icteroid" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "immortal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "impetulant" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "irrigate" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "myxedema" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "onyx" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "repasser" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "septomarginal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "subdie" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tibiometatarsal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "waltzlike" (Jdec.nullable (Jdec.null ())) Nothing)

encodeReimagine : Reimagine -> Jenc.Value
encodeReimagine x =
    Jenc.object
        [ ("adducible", makeNullableEncoder (always Jenc.null) x.adducible)
        , ("anabolin", makeNullableEncoder (always Jenc.null) x.anabolin)
        , ("brainy", makeNullableEncoder (always Jenc.null) x.brainy)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("chrysamine", makeNullableEncoder (always Jenc.null) x.chrysamine)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("fluxweed", makeNullableEncoder (always Jenc.null) x.fluxweed)
        , ("glaucine", makeNullableEncoder (always Jenc.null) x.glaucine)
        , ("grobianism", makeNullableEncoder (always Jenc.null) x.grobianism)
        , ("Hermo", makeNullableEncoder (always Jenc.null) x.hermo)
        , ("hieroglyphist", makeNullableEncoder (always Jenc.null) x.hieroglyphist)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("icteroid", makeNullableEncoder (always Jenc.null) x.icteroid)
        , ("immortal", makeNullableEncoder (always Jenc.null) x.immortal)
        , ("impetulant", makeNullableEncoder (always Jenc.null) x.impetulant)
        , ("irrigate", makeNullableEncoder (always Jenc.null) x.irrigate)
        , ("myxedema", makeNullableEncoder (always Jenc.null) x.myxedema)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("onyx", makeNullableEncoder (always Jenc.null) x.onyx)
        , ("repasser", makeNullableEncoder (always Jenc.null) x.repasser)
        , ("septomarginal", makeNullableEncoder (always Jenc.null) x.septomarginal)
        , ("subdie", makeNullableEncoder (always Jenc.null) x.subdie)
        , ("tibiometatarsal", makeNullableEncoder (always Jenc.null) x.tibiometatarsal)
        , ("waltzlike", makeNullableEncoder (always Jenc.null) x.waltzlike)
        ]

ressaut : Jdec.Decoder Ressaut
ressaut =
    Jdec.succeed Ressaut
        |> Jpipe.required "apperceptive" Jdec.string
        |> Jpipe.required "cuttoo" Jdec.string
        |> Jpipe.required "douser" Jdec.string
        |> Jpipe.required "drinkproof" Jdec.string
        |> Jpipe.required "forementioned" Jdec.string
        |> Jpipe.required "Freesia" Jdec.string
        |> Jpipe.required "Genevieve" Jdec.string
        |> Jpipe.required "hyperdiabolical" Jdec.string
        |> Jpipe.required "hypocone" Jdec.string
        |> Jpipe.required "irreverentially" Jdec.string
        |> Jpipe.required "jumart" Jdec.string
        |> Jpipe.required "Mimosaceae" Jdec.string
        |> Jpipe.required "mollicrush" Jdec.string
        |> Jpipe.required "nedder" Jdec.string
        |> Jpipe.required "retinasphalt" Jdec.string
        |> Jpipe.required "sough" Jdec.string
        |> Jpipe.required "steading" Jdec.string
        |> Jpipe.required "Theopaschitism" Jdec.string
        |> Jpipe.required "undurableness" Jdec.string
        |> Jpipe.required "unmingleable" Jdec.string

encodeRessaut : Ressaut -> Jenc.Value
encodeRessaut x =
    Jenc.object
        [ ("apperceptive", Jenc.string x.apperceptive)
        , ("cuttoo", Jenc.string x.cuttoo)
        , ("douser", Jenc.string x.douser)
        , ("drinkproof", Jenc.string x.drinkproof)
        , ("forementioned", Jenc.string x.forementioned)
        , ("Freesia", Jenc.string x.freesia)
        , ("Genevieve", Jenc.string x.genevieve)
        , ("hyperdiabolical", Jenc.string x.hyperdiabolical)
        , ("hypocone", Jenc.string x.hypocone)
        , ("irreverentially", Jenc.string x.irreverentially)
        , ("jumart", Jenc.string x.jumart)
        , ("Mimosaceae", Jenc.string x.mimosaceae)
        , ("mollicrush", Jenc.string x.mollicrush)
        , ("nedder", Jenc.string x.nedder)
        , ("retinasphalt", Jenc.string x.retinasphalt)
        , ("sough", Jenc.string x.sough)
        , ("steading", Jenc.string x.steading)
        , ("Theopaschitism", Jenc.string x.theopaschitism)
        , ("undurableness", Jenc.string x.undurableness)
        , ("unmingleable", Jenc.string x.unmingleable)
        ]

retrocervical : Jdec.Decoder Retrocervical
retrocervical =
    Jdec.oneOf
        [ Jdec.map UnionArrayInRetrocervical (Jdec.array (Jdec.nullable Jdec.int) )
        , Jdec.map IntegerInRetrocervical Jdec.int
        ]

encodeRetrocervical : Retrocervical -> Jenc.Value
encodeRetrocervical x = case x of
    UnionArrayInRetrocervical y -> Jenc.array (makeNullableEncoder Jenc.int) y
    IntegerInRetrocervical y -> Jenc.int y

revert : Jdec.Decoder Revert
revert =
    Jdec.oneOf
        [ Jdec.map BoolInRevert Jdec.bool
        , Jdec.map StringInRevert Jdec.string
        ]

encodeRevert : Revert -> Jenc.Value
encodeRevert x = case x of
    BoolInRevert y -> Jenc.bool y
    StringInRevert y -> Jenc.string y

rewriteElement : Jdec.Decoder RewriteElement
rewriteElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInRewriteElement (Jdec.array (Jdec.null ()) )
        , Jdec.map DoubleInRewriteElement Jdec.float
        , Jdec.map RewriteClassInRewriteElement rewriteClass
        ]

encodeRewriteElement : RewriteElement -> Jenc.Value
encodeRewriteElement x = case x of
    NullArrayInRewriteElement y -> Jenc.array (always Jenc.null) y
    DoubleInRewriteElement y -> Jenc.float y
    RewriteClassInRewriteElement y -> encodeRewriteClass y

rewriteClass : Jdec.Decoder RewriteClass
rewriteClass =
    Jdec.succeed RewriteClass
        |> Jpipe.required "accountancy" (Jdec.null ())
        |> Jpipe.required "cacotrophic" (Jdec.null ())
        |> Jpipe.required "contest" (Jdec.null ())
        |> Jpipe.required "couthily" (Jdec.null ())
        |> Jpipe.required "falculate" (Jdec.null ())
        |> Jpipe.required "foreseize" (Jdec.null ())
        |> Jpipe.required "Hyades" (Jdec.null ())
        |> Jpipe.required "lemnad" (Jdec.null ())
        |> Jpipe.required "monotheistically" (Jdec.null ())
        |> Jpipe.required "nonflying" (Jdec.null ())
        |> Jpipe.required "Ptenoglossa" (Jdec.null ())
        |> Jpipe.required "repatch" (Jdec.null ())
        |> Jpipe.required "rodman" (Jdec.null ())
        |> Jpipe.required "strung" (Jdec.null ())
        |> Jpipe.required "titmal" (Jdec.null ())
        |> Jpipe.required "twalpennyworth" (Jdec.null ())
        |> Jpipe.required "unblamable" (Jdec.null ())
        |> Jpipe.required "vertical" (Jdec.null ())
        |> Jpipe.required "Whiggification" (Jdec.null ())
        |> Jpipe.required "yardman" (Jdec.null ())

encodeRewriteClass : RewriteClass -> Jenc.Value
encodeRewriteClass x =
    Jenc.object
        [ ("accountancy", always Jenc.null x.accountancy)
        , ("cacotrophic", always Jenc.null x.cacotrophic)
        , ("contest", always Jenc.null x.contest)
        , ("couthily", always Jenc.null x.couthily)
        , ("falculate", always Jenc.null x.falculate)
        , ("foreseize", always Jenc.null x.foreseize)
        , ("Hyades", always Jenc.null x.hyades)
        , ("lemnad", always Jenc.null x.lemnad)
        , ("monotheistically", always Jenc.null x.monotheistically)
        , ("nonflying", always Jenc.null x.nonflying)
        , ("Ptenoglossa", always Jenc.null x.ptenoglossa)
        , ("repatch", always Jenc.null x.repatch)
        , ("rodman", always Jenc.null x.rodman)
        , ("strung", always Jenc.null x.strung)
        , ("titmal", always Jenc.null x.titmal)
        , ("twalpennyworth", always Jenc.null x.twalpennyworth)
        , ("unblamable", always Jenc.null x.unblamable)
        , ("vertical", always Jenc.null x.vertical)
        , ("Whiggification", always Jenc.null x.whiggification)
        , ("yardman", always Jenc.null x.yardman)
        ]

saccoderm : Jdec.Decoder Saccoderm
saccoderm =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInSaccoderm (Jdec.array Jdec.int )
        , Jdec.null NullInSaccoderm
        , Jdec.map StringInSaccoderm Jdec.string
        ]

encodeSaccoderm : Saccoderm -> Jenc.Value
encodeSaccoderm x = case x of
    IntegerArrayInSaccoderm y -> Jenc.array Jenc.int y
    NullInSaccoderm -> Jenc.null
    StringInSaccoderm y -> Jenc.string y

santirElement : Jdec.Decoder SantirElement
santirElement =
    Jdec.oneOf
        [ Jdec.map DoubleInSantirElement Jdec.float
        , Jdec.map SantirClassInSantirElement santirClass
        ]

encodeSantirElement : SantirElement -> Jenc.Value
encodeSantirElement x = case x of
    DoubleInSantirElement y -> Jenc.float y
    SantirClassInSantirElement y -> encodeSantirClass y

santirClass : Jdec.Decoder SantirClass
santirClass =
    Jdec.succeed SantirClass
        |> Jpipe.required "admiredly" (Jdec.null ())
        |> Jpipe.required "demicaponier" (Jdec.null ())
        |> Jpipe.required "epitympanic" (Jdec.null ())
        |> Jpipe.required "investitor" (Jdec.null ())
        |> Jpipe.required "lupiform" (Jdec.null ())
        |> Jpipe.required "monoflagellate" (Jdec.null ())
        |> Jpipe.required "paleoethnic" (Jdec.null ())
        |> Jpipe.required "prediscountable" (Jdec.null ())
        |> Jpipe.required "rhetoricals" (Jdec.null ())
        |> Jpipe.required "roomth" (Jdec.null ())
        |> Jpipe.required "saccharose" (Jdec.null ())
        |> Jpipe.required "septonasal" (Jdec.null ())
        |> Jpipe.required "serpenticide" (Jdec.null ())
        |> Jpipe.required "setarious" (Jdec.null ())
        |> Jpipe.required "spaework" (Jdec.null ())
        |> Jpipe.required "stylite" (Jdec.null ())
        |> Jpipe.required "Suessiones" (Jdec.null ())
        |> Jpipe.required "timelily" (Jdec.null ())
        |> Jpipe.required "unprofaned" (Jdec.null ())
        |> Jpipe.required "vorticular" (Jdec.null ())

encodeSantirClass : SantirClass -> Jenc.Value
encodeSantirClass x =
    Jenc.object
        [ ("admiredly", always Jenc.null x.admiredly)
        , ("demicaponier", always Jenc.null x.demicaponier)
        , ("epitympanic", always Jenc.null x.epitympanic)
        , ("investitor", always Jenc.null x.investitor)
        , ("lupiform", always Jenc.null x.lupiform)
        , ("monoflagellate", always Jenc.null x.monoflagellate)
        , ("paleoethnic", always Jenc.null x.paleoethnic)
        , ("prediscountable", always Jenc.null x.prediscountable)
        , ("rhetoricals", always Jenc.null x.rhetoricals)
        , ("roomth", always Jenc.null x.roomth)
        , ("saccharose", always Jenc.null x.saccharose)
        , ("septonasal", always Jenc.null x.septonasal)
        , ("serpenticide", always Jenc.null x.serpenticide)
        , ("setarious", always Jenc.null x.setarious)
        , ("spaework", always Jenc.null x.spaework)
        , ("stylite", always Jenc.null x.stylite)
        , ("Suessiones", always Jenc.null x.suessiones)
        , ("timelily", always Jenc.null x.timelily)
        , ("unprofaned", always Jenc.null x.unprofaned)
        , ("vorticular", always Jenc.null x.vorticular)
        ]

saprophilous : Jdec.Decoder Saprophilous
saprophilous =
    Jdec.oneOf
        [ Jdec.null NullInSaprophilous
        , Jdec.map StringInSaprophilous Jdec.string
        , Jdec.map IntegerMapInSaprophilous (Jdec.dict Jdec.int)
        ]

encodeSaprophilous : Saprophilous -> Jenc.Value
encodeSaprophilous x = case x of
    NullInSaprophilous -> Jenc.null
    StringInSaprophilous y -> Jenc.string y
    IntegerMapInSaprophilous y -> Jenc.dict identity Jenc.int y

saxtenElement : Jdec.Decoder SaxtenElement
saxtenElement =
    Jdec.oneOf
        [ Jdec.map StringInSaxtenElement Jdec.string
        , Jdec.map SaxtenClassInSaxtenElement saxtenClass
        ]

encodeSaxtenElement : SaxtenElement -> Jenc.Value
encodeSaxtenElement x = case x of
    StringInSaxtenElement y -> Jenc.string y
    SaxtenClassInSaxtenElement y -> encodeSaxtenClass y

saxtenClass : Jdec.Decoder SaxtenClass
saxtenClass =
    Jdec.succeed SaxtenClass
        |> Jpipe.custom (optionalField "algarrobilla" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "bowgrace" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Centaurid" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "flix" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "germanely" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "inhume" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "lepidote" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "megalochirous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ninepenny" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nondeist" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nymphaeaceous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "parietofrontal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "sancyite" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "subjectivist" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tibiad" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "transonic" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "tripetalous" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "trunchman" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "urger" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "withdrawnness" (Jdec.nullable (Jdec.null ())) Nothing)

encodeSaxtenClass : SaxtenClass -> Jenc.Value
encodeSaxtenClass x =
    Jenc.object
        [ ("algarrobilla", makeNullableEncoder (always Jenc.null) x.algarrobilla)
        , ("bowgrace", makeNullableEncoder (always Jenc.null) x.bowgrace)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Centaurid", makeNullableEncoder (always Jenc.null) x.centaurid)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("flix", makeNullableEncoder (always Jenc.null) x.flix)
        , ("germanely", makeNullableEncoder (always Jenc.null) x.germanely)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("inhume", makeNullableEncoder (always Jenc.null) x.inhume)
        , ("lepidote", makeNullableEncoder (always Jenc.null) x.lepidote)
        , ("megalochirous", makeNullableEncoder (always Jenc.null) x.megalochirous)
        , ("ninepenny", makeNullableEncoder (always Jenc.null) x.ninepenny)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("nondeist", makeNullableEncoder (always Jenc.null) x.nondeist)
        , ("nymphaeaceous", makeNullableEncoder (always Jenc.null) x.nymphaeaceous)
        , ("parietofrontal", makeNullableEncoder (always Jenc.null) x.parietofrontal)
        , ("sancyite", makeNullableEncoder (always Jenc.null) x.sancyite)
        , ("subjectivist", makeNullableEncoder (always Jenc.null) x.subjectivist)
        , ("tibiad", makeNullableEncoder (always Jenc.null) x.tibiad)
        , ("transonic", makeNullableEncoder (always Jenc.null) x.transonic)
        , ("tripetalous", makeNullableEncoder (always Jenc.null) x.tripetalous)
        , ("trunchman", makeNullableEncoder (always Jenc.null) x.trunchman)
        , ("urger", makeNullableEncoder (always Jenc.null) x.urger)
        , ("withdrawnness", makeNullableEncoder (always Jenc.null) x.withdrawnness)
        ]

scatty : Jdec.Decoder Scatty
scatty =
    Jdec.succeed Scatty
        |> Jpipe.required "aeriferous" (Jdec.null ())
        |> Jpipe.required "antical" (Jdec.null ())
        |> Jpipe.required "antighostism" (Jdec.null ())
        |> Jpipe.required "arcanum" (Jdec.null ())
        |> Jpipe.required "autotrophy" (Jdec.null ())
        |> Jpipe.required "baronial" (Jdec.null ())
        |> Jpipe.required "caffeine" (Jdec.null ())
        |> Jpipe.required "gorgoniacean" (Jdec.null ())
        |> Jpipe.required "heroical" (Jdec.null ())
        |> Jpipe.required "hydropical" (Jdec.null ())
        |> Jpipe.required "mechanology" (Jdec.null ())
        |> Jpipe.required "musicopoetic" (Jdec.null ())
        |> Jpipe.required "officiality" (Jdec.null ())
        |> Jpipe.required "oftentimes" (Jdec.null ())
        |> Jpipe.required "ophthalmotonometer" (Jdec.null ())
        |> Jpipe.required "reflectively" (Jdec.null ())
        |> Jpipe.required "springer" (Jdec.null ())
        |> Jpipe.required "Tabasco" (Jdec.null ())
        |> Jpipe.required "teleianthous" (Jdec.null ())
        |> Jpipe.required "uncombated" (Jdec.null ())

encodeScatty : Scatty -> Jenc.Value
encodeScatty x =
    Jenc.object
        [ ("aeriferous", always Jenc.null x.aeriferous)
        , ("antical", always Jenc.null x.antical)
        , ("antighostism", always Jenc.null x.antighostism)
        , ("arcanum", always Jenc.null x.arcanum)
        , ("autotrophy", always Jenc.null x.autotrophy)
        , ("baronial", always Jenc.null x.baronial)
        , ("caffeine", always Jenc.null x.caffeine)
        , ("gorgoniacean", always Jenc.null x.gorgoniacean)
        , ("heroical", always Jenc.null x.heroical)
        , ("hydropical", always Jenc.null x.hydropical)
        , ("mechanology", always Jenc.null x.mechanology)
        , ("musicopoetic", always Jenc.null x.musicopoetic)
        , ("officiality", always Jenc.null x.officiality)
        , ("oftentimes", always Jenc.null x.oftentimes)
        , ("ophthalmotonometer", always Jenc.null x.ophthalmotonometer)
        , ("reflectively", always Jenc.null x.reflectively)
        , ("springer", always Jenc.null x.springer)
        , ("Tabasco", always Jenc.null x.tabasco)
        , ("teleianthous", always Jenc.null x.teleianthous)
        , ("uncombated", always Jenc.null x.uncombated)
        ]

scoffer : Jdec.Decoder Scoffer
scoffer =
    Jdec.oneOf
        [ Jdec.map NullArrayInScoffer (Jdec.array (Jdec.null ()) )
        , Jdec.null NullInScoffer
        , Jdec.map IntegerMapInScoffer (Jdec.dict Jdec.int)
        ]

encodeScoffer : Scoffer -> Jenc.Value
encodeScoffer x = case x of
    NullArrayInScoffer y -> Jenc.array (always Jenc.null) y
    NullInScoffer -> Jenc.null
    IntegerMapInScoffer y -> Jenc.dict identity Jenc.int y

scrampum : Jdec.Decoder Scrampum
scrampum =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInScrampum (Jdec.array Jdec.int )
        , Jdec.map BoolInScrampum Jdec.bool
        , Jdec.null NullInScrampum
        ]

encodeScrampum : Scrampum -> Jenc.Value
encodeScrampum x = case x of
    IntegerArrayInScrampum y -> Jenc.array Jenc.int y
    BoolInScrampum y -> Jenc.bool y
    NullInScrampum -> Jenc.null

serpentinic : Jdec.Decoder Serpentinic
serpentinic =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInSerpentinic (Jdec.array Jdec.int )
        , Jdec.map DoubleInSerpentinic Jdec.float
        ]

encodeSerpentinic : Serpentinic -> Jenc.Value
encodeSerpentinic x = case x of
    IntegerArrayInSerpentinic y -> Jenc.array Jenc.int y
    DoubleInSerpentinic y -> Jenc.float y

shadowable : Jdec.Decoder Shadowable
shadowable =
    Jdec.oneOf
        [ Jdec.map UnionArrayInShadowable (Jdec.array (Jdec.nullable Jdec.int) )
        , Jdec.map BoolInShadowable Jdec.bool
        ]

encodeShadowable : Shadowable -> Jenc.Value
encodeShadowable x = case x of
    UnionArrayInShadowable y -> Jenc.array (makeNullableEncoder Jenc.int) y
    BoolInShadowable y -> Jenc.bool y

sisteringElement : Jdec.Decoder SisteringElement
sisteringElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInSisteringElement (Jdec.array (Jdec.null ()) )
        , Jdec.map IntegerInSisteringElement Jdec.int
        , Jdec.map SisteringClassInSisteringElement sisteringClass
        ]

encodeSisteringElement : SisteringElement -> Jenc.Value
encodeSisteringElement x = case x of
    NullArrayInSisteringElement y -> Jenc.array (always Jenc.null) y
    IntegerInSisteringElement y -> Jenc.int y
    SisteringClassInSisteringElement y -> encodeSisteringClass y

sisteringClass : Jdec.Decoder SisteringClass
sisteringClass =
    Jdec.succeed SisteringClass
        |> Jpipe.required "amphicarpic" (Jdec.null ())
        |> Jpipe.required "Chianti" (Jdec.null ())
        |> Jpipe.required "frigorific" (Jdec.null ())
        |> Jpipe.required "Haplomi" (Jdec.null ())
        |> Jpipe.required "hyperkinesis" (Jdec.null ())
        |> Jpipe.required "laudable" (Jdec.null ())
        |> Jpipe.required "madwoman" (Jdec.null ())
        |> Jpipe.required "maimedly" (Jdec.null ())
        |> Jpipe.required "Micropterygidae" (Jdec.null ())
        |> Jpipe.required "microrhabdus" (Jdec.null ())
        |> Jpipe.required "nondense" (Jdec.null ())
        |> Jpipe.required "phlebemphraxis" (Jdec.null ())
        |> Jpipe.required "redsear" (Jdec.null ())
        |> Jpipe.required "schismatical" (Jdec.null ())
        |> Jpipe.required "tartryl" (Jdec.null ())
        |> Jpipe.required "unabhorred" (Jdec.null ())
        |> Jpipe.required "undeliberateness" (Jdec.null ())
        |> Jpipe.required "unmixable" (Jdec.null ())
        |> Jpipe.required "untruckling" (Jdec.null ())
        |> Jpipe.required "vineal" (Jdec.null ())

encodeSisteringClass : SisteringClass -> Jenc.Value
encodeSisteringClass x =
    Jenc.object
        [ ("amphicarpic", always Jenc.null x.amphicarpic)
        , ("Chianti", always Jenc.null x.chianti)
        , ("frigorific", always Jenc.null x.frigorific)
        , ("Haplomi", always Jenc.null x.haplomi)
        , ("hyperkinesis", always Jenc.null x.hyperkinesis)
        , ("laudable", always Jenc.null x.laudable)
        , ("madwoman", always Jenc.null x.madwoman)
        , ("maimedly", always Jenc.null x.maimedly)
        , ("Micropterygidae", always Jenc.null x.micropterygidae)
        , ("microrhabdus", always Jenc.null x.microrhabdus)
        , ("nondense", always Jenc.null x.nondense)
        , ("phlebemphraxis", always Jenc.null x.phlebemphraxis)
        , ("redsear", always Jenc.null x.redsear)
        , ("schismatical", always Jenc.null x.schismatical)
        , ("tartryl", always Jenc.null x.tartryl)
        , ("unabhorred", always Jenc.null x.unabhorred)
        , ("undeliberateness", always Jenc.null x.undeliberateness)
        , ("unmixable", always Jenc.null x.unmixable)
        , ("untruckling", always Jenc.null x.untruckling)
        , ("vineal", always Jenc.null x.vineal)
        ]

staghunting : Jdec.Decoder Staghunting
staghunting =
    Jdec.succeed Staghunting
        |> Jpipe.custom (optionalField "calorimetric" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "canid" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ditriglyphic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "floriferousness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "gamelike" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "grig" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "interloan" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "lithotomy" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "loric" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "membranocoriaceous" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "membranogenic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "overtrump" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "scotino" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "seasonable" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "sephen" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "stigmarioid" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "tired" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "trifid" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "undefeatedly" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "ungirlish" (Jdec.map Just Jdec.int) Nothing)

encodeStaghunting : Staghunting -> Jenc.Value
encodeStaghunting x =
    Jenc.object
        [ ("calorimetric", makeNullableEncoder Jenc.int x.calorimetric)
        , ("canid", makeNullableEncoder Jenc.int x.canid)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("ditriglyphic", makeNullableEncoder Jenc.int x.ditriglyphic)
        , ("floriferousness", makeNullableEncoder Jenc.int x.floriferousness)
        , ("gamelike", makeNullableEncoder Jenc.int x.gamelike)
        , ("grig", makeNullableEncoder Jenc.int x.grig)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("interloan", makeNullableEncoder Jenc.int x.interloan)
        , ("lithotomy", makeNullableEncoder Jenc.int x.lithotomy)
        , ("loric", makeNullableEncoder Jenc.int x.loric)
        , ("membranocoriaceous", makeNullableEncoder Jenc.int x.membranocoriaceous)
        , ("membranogenic", makeNullableEncoder Jenc.int x.membranogenic)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("overtrump", makeNullableEncoder Jenc.int x.overtrump)
        , ("scotino", makeNullableEncoder Jenc.int x.scotino)
        , ("seasonable", makeNullableEncoder Jenc.int x.seasonable)
        , ("sephen", makeNullableEncoder Jenc.int x.sephen)
        , ("stigmarioid", makeNullableEncoder Jenc.int x.stigmarioid)
        , ("tired", makeNullableEncoder Jenc.int x.tired)
        , ("trifid", makeNullableEncoder Jenc.int x.trifid)
        , ("undefeatedly", makeNullableEncoder Jenc.int x.undefeatedly)
        , ("ungirlish", makeNullableEncoder Jenc.int x.ungirlish)
        ]

stagmometer : Jdec.Decoder Stagmometer
stagmometer =
    Jdec.oneOf
        [ Jdec.map UnionArrayInStagmometer (Jdec.array (Jdec.nullable Jdec.int) )
        , Jdec.map StringInStagmometer Jdec.string
        ]

encodeStagmometer : Stagmometer -> Jenc.Value
encodeStagmometer x = case x of
    UnionArrayInStagmometer y -> Jenc.array (makeNullableEncoder Jenc.int) y
    StringInStagmometer y -> Jenc.string y

stimulability : Jdec.Decoder Stimulability
stimulability =
    Jdec.oneOf
        [ Jdec.map BoolInStimulability Jdec.bool
        , Jdec.map IntegerInStimulability Jdec.int
        , Jdec.map IntegerMapInStimulability (Jdec.dict Jdec.int)
        ]

encodeStimulability : Stimulability -> Jenc.Value
encodeStimulability x = case x of
    BoolInStimulability y -> Jenc.bool y
    IntegerInStimulability y -> Jenc.int y
    IntegerMapInStimulability y -> Jenc.dict identity Jenc.int y

strangleable : Jdec.Decoder Strangleable
strangleable =
    Jdec.oneOf
        [ Jdec.map NullArrayInStrangleable (Jdec.array (Jdec.null ()) )
        , Jdec.map DoubleInStrangleable Jdec.float
        ]

encodeStrangleable : Strangleable -> Jenc.Value
encodeStrangleable x = case x of
    NullArrayInStrangleable y -> Jenc.array (always Jenc.null) y
    DoubleInStrangleable y -> Jenc.float y

strenuosityElement : Jdec.Decoder StrenuosityElement
strenuosityElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInStrenuosityElement (Jdec.array (Jdec.null ()) )
        , Jdec.map StrenuosityClassInStrenuosityElement strenuosityClass
        ]

encodeStrenuosityElement : StrenuosityElement -> Jenc.Value
encodeStrenuosityElement x = case x of
    NullArrayInStrenuosityElement y -> Jenc.array (always Jenc.null) y
    StrenuosityClassInStrenuosityElement y -> encodeStrenuosityClass y

strenuosityClass : Jdec.Decoder StrenuosityClass
strenuosityClass =
    Jdec.succeed StrenuosityClass
        |> Jpipe.custom (optionalField "bliss" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "buccate" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "bulletproof" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "crumblingness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "engagedly" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "fightable" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "hoariness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "hypopodium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "luxurist" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "mechanician" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Onopordon" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "podgily" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "reformableness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "scatterbrains" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "seminuria" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Sodomite" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "tramp" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "undueness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "worthily" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Yankeeist" (Jdec.map Just Jdec.int) Nothing)

encodeStrenuosityClass : StrenuosityClass -> Jenc.Value
encodeStrenuosityClass x =
    Jenc.object
        [ ("bliss", makeNullableEncoder Jenc.int x.bliss)
        , ("buccate", makeNullableEncoder Jenc.int x.buccate)
        , ("bulletproof", makeNullableEncoder Jenc.int x.bulletproof)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("crumblingness", makeNullableEncoder Jenc.int x.crumblingness)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("engagedly", makeNullableEncoder Jenc.int x.engagedly)
        , ("fightable", makeNullableEncoder Jenc.int x.fightable)
        , ("hoariness", makeNullableEncoder Jenc.int x.hoariness)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("hypopodium", makeNullableEncoder Jenc.int x.hypopodium)
        , ("luxurist", makeNullableEncoder Jenc.int x.luxurist)
        , ("mechanician", makeNullableEncoder Jenc.int x.mechanician)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("Onopordon", makeNullableEncoder Jenc.int x.onopordon)
        , ("podgily", makeNullableEncoder Jenc.int x.podgily)
        , ("reformableness", makeNullableEncoder Jenc.int x.reformableness)
        , ("scatterbrains", makeNullableEncoder Jenc.int x.scatterbrains)
        , ("seminuria", makeNullableEncoder Jenc.int x.seminuria)
        , ("Sodomite", makeNullableEncoder Jenc.int x.sodomite)
        , ("tramp", makeNullableEncoder Jenc.int x.tramp)
        , ("undueness", makeNullableEncoder Jenc.int x.undueness)
        , ("worthily", makeNullableEncoder Jenc.int x.worthily)
        , ("Yankeeist", makeNullableEncoder Jenc.int x.yankeeist)
        ]

tabaxir : Jdec.Decoder Tabaxir
tabaxir =
    Jdec.oneOf
        [ Jdec.map BoolInTabaxir Jdec.bool
        , Jdec.map DoubleInTabaxir Jdec.float
        ]

encodeTabaxir : Tabaxir -> Jenc.Value
encodeTabaxir x = case x of
    BoolInTabaxir y -> Jenc.bool y
    DoubleInTabaxir y -> Jenc.float y

talpiform : Jdec.Decoder Talpiform
talpiform =
    Jdec.oneOf
        [ Jdec.null NullInTalpiform
        , Jdec.map DoubleInTalpiform Jdec.float
        , Jdec.map QuebrachineClassInTalpiform quebrachineClass
        ]

encodeTalpiform : Talpiform -> Jenc.Value
encodeTalpiform x = case x of
    NullInTalpiform -> Jenc.null
    DoubleInTalpiform y -> Jenc.float y
    QuebrachineClassInTalpiform y -> encodeQuebrachineClass y

thwack : Jdec.Decoder Thwack
thwack =
    Jdec.oneOf
        [ Jdec.map BoolInThwack Jdec.bool
        , Jdec.map DoubleInThwack Jdec.float
        , Jdec.map QuebrachineClassInThwack quebrachineClass
        ]

encodeThwack : Thwack -> Jenc.Value
encodeThwack x = case x of
    BoolInThwack y -> Jenc.bool y
    DoubleInThwack y -> Jenc.float y
    QuebrachineClassInThwack y -> encodeQuebrachineClass y

tortricine : Jdec.Decoder Tortricine
tortricine =
    Jdec.oneOf
        [ Jdec.map UnionArrayInTortricine (Jdec.array (Jdec.nullable Jdec.int) )
        , Jdec.map QuebrachineClassInTortricine quebrachineClass
        ]

encodeTortricine : Tortricine -> Jenc.Value
encodeTortricine x = case x of
    UnionArrayInTortricine y -> Jenc.array (makeNullableEncoder Jenc.int) y
    QuebrachineClassInTortricine y -> encodeQuebrachineClass y

truantcyElement : Jdec.Decoder TruantcyElement
truantcyElement =
    Jdec.oneOf
        [ Jdec.map BoolInTruantcyElement Jdec.bool
        , Jdec.map TruantcyClassInTruantcyElement truantcyClass
        ]

encodeTruantcyElement : TruantcyElement -> Jenc.Value
encodeTruantcyElement x = case x of
    BoolInTruantcyElement y -> Jenc.bool y
    TruantcyClassInTruantcyElement y -> encodeTruantcyClass y

truantcyClass : Jdec.Decoder TruantcyClass
truantcyClass =
    Jdec.succeed TruantcyClass
        |> Jpipe.custom (optionalField "alfiona" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "ascaridiasis" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "bungey" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "ceroxyle" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "chorology" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "enmarble" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Epeira" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Eurylaimi" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "germination" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "hallelujah" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "lev" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "mouthing" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "philliloo" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "planetal" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "poney" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "punctualist" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "returnlessly" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "skelder" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "windwaywardly" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Yuman" (Jdec.nullable (Jdec.null ())) Nothing)

encodeTruantcyClass : TruantcyClass -> Jenc.Value
encodeTruantcyClass x =
    Jenc.object
        [ ("alfiona", makeNullableEncoder (always Jenc.null) x.alfiona)
        , ("ascaridiasis", makeNullableEncoder (always Jenc.null) x.ascaridiasis)
        , ("bungey", makeNullableEncoder (always Jenc.null) x.bungey)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("ceroxyle", makeNullableEncoder (always Jenc.null) x.ceroxyle)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("chorology", makeNullableEncoder (always Jenc.null) x.chorology)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("enmarble", makeNullableEncoder (always Jenc.null) x.enmarble)
        , ("Epeira", makeNullableEncoder (always Jenc.null) x.epeira)
        , ("Eurylaimi", makeNullableEncoder (always Jenc.null) x.eurylaimi)
        , ("germination", makeNullableEncoder (always Jenc.null) x.germination)
        , ("hallelujah", makeNullableEncoder (always Jenc.null) x.hallelujah)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("lev", makeNullableEncoder (always Jenc.null) x.lev)
        , ("mouthing", makeNullableEncoder (always Jenc.null) x.mouthing)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("philliloo", makeNullableEncoder (always Jenc.null) x.philliloo)
        , ("planetal", makeNullableEncoder (always Jenc.null) x.planetal)
        , ("poney", makeNullableEncoder (always Jenc.null) x.poney)
        , ("punctualist", makeNullableEncoder (always Jenc.null) x.punctualist)
        , ("returnlessly", makeNullableEncoder (always Jenc.null) x.returnlessly)
        , ("skelder", makeNullableEncoder (always Jenc.null) x.skelder)
        , ("windwaywardly", makeNullableEncoder (always Jenc.null) x.windwaywardly)
        , ("Yuman", makeNullableEncoder (always Jenc.null) x.yuman)
        ]

unbeginning : Jdec.Decoder Unbeginning
unbeginning =
    Jdec.oneOf
        [ Jdec.map NullArrayInUnbeginning (Jdec.array (Jdec.null ()) )
        , Jdec.map StringInUnbeginning Jdec.string
        , Jdec.map IntegerMapInUnbeginning (Jdec.dict Jdec.int)
        ]

encodeUnbeginning : Unbeginning -> Jenc.Value
encodeUnbeginning x = case x of
    NullArrayInUnbeginning y -> Jenc.array (always Jenc.null) y
    StringInUnbeginning y -> Jenc.string y
    IntegerMapInUnbeginning y -> Jenc.dict identity Jenc.int y

undesirability : Jdec.Decoder Undesirability
undesirability =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInUndesirability (Jdec.array Jdec.int )
        , Jdec.map StringInUndesirability Jdec.string
        , Jdec.map IntegerMapInUndesirability (Jdec.dict Jdec.int)
        ]

encodeUndesirability : Undesirability -> Jenc.Value
encodeUndesirability x = case x of
    IntegerArrayInUndesirability y -> Jenc.array Jenc.int y
    StringInUndesirability y -> Jenc.string y
    IntegerMapInUndesirability y -> Jenc.dict identity Jenc.int y

unerasing : Jdec.Decoder Unerasing
unerasing =
    Jdec.oneOf
        [ Jdec.map NullArrayInUnerasing (Jdec.array (Jdec.null ()) )
        , Jdec.map IntegerInUnerasing Jdec.int
        , Jdec.map IntegerMapInUnerasing (Jdec.dict Jdec.int)
        ]

encodeUnerasing : Unerasing -> Jenc.Value
encodeUnerasing x = case x of
    NullArrayInUnerasing y -> Jenc.array (always Jenc.null) y
    IntegerInUnerasing y -> Jenc.int y
    IntegerMapInUnerasing y -> Jenc.dict identity Jenc.int y

unguentarium : Jdec.Decoder Unguentarium
unguentarium =
    Jdec.oneOf
        [ Jdec.map NullArrayInUnguentarium (Jdec.array (Jdec.null ()) )
        , Jdec.map IntegerInUnguentarium Jdec.int
        , Jdec.null NullInUnguentarium
        ]

encodeUnguentarium : Unguentarium -> Jenc.Value
encodeUnguentarium x = case x of
    NullArrayInUnguentarium y -> Jenc.array (always Jenc.null) y
    IntegerInUnguentarium y -> Jenc.int y
    NullInUnguentarium -> Jenc.null

unimpeachablyElement : Jdec.Decoder UnimpeachablyElement
unimpeachablyElement =
    Jdec.oneOf
        [ Jdec.map BoolInUnimpeachablyElement Jdec.bool
        , Jdec.map UnimpeachablyClassInUnimpeachablyElement unimpeachablyClass
        ]

encodeUnimpeachablyElement : UnimpeachablyElement -> Jenc.Value
encodeUnimpeachablyElement x = case x of
    BoolInUnimpeachablyElement y -> Jenc.bool y
    UnimpeachablyClassInUnimpeachablyElement y -> encodeUnimpeachablyClass y

unimpeachablyClass : Jdec.Decoder UnimpeachablyClass
unimpeachablyClass =
    Jdec.succeed UnimpeachablyClass
        |> Jpipe.custom (optionalField "acerin" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Bobadil" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "chlorophylligenous" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "conversational" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "demiowl" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ectorhinal" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "gamblesomeness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "irrorate" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "kindergartening" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "lateritic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "mespil" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "misconfiguration" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "planometry" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Quiina" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Robert" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "rot" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "subcinctorium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "tussocker" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "ultraproud" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "unsuggestedness" (Jdec.map Just Jdec.int) Nothing)

encodeUnimpeachablyClass : UnimpeachablyClass -> Jenc.Value
encodeUnimpeachablyClass x =
    Jenc.object
        [ ("acerin", makeNullableEncoder Jenc.int x.acerin)
        , ("Bobadil", makeNullableEncoder Jenc.int x.bobadil)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("chlorophylligenous", makeNullableEncoder Jenc.int x.chlorophylligenous)
        , ("conversational", makeNullableEncoder Jenc.int x.conversational)
        , ("demiowl", makeNullableEncoder Jenc.int x.demiowl)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("ectorhinal", makeNullableEncoder Jenc.int x.ectorhinal)
        , ("gamblesomeness", makeNullableEncoder Jenc.int x.gamblesomeness)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("irrorate", makeNullableEncoder Jenc.int x.irrorate)
        , ("kindergartening", makeNullableEncoder Jenc.int x.kindergartening)
        , ("lateritic", makeNullableEncoder Jenc.int x.lateritic)
        , ("mespil", makeNullableEncoder Jenc.int x.mespil)
        , ("misconfiguration", makeNullableEncoder Jenc.int x.misconfiguration)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("planometry", makeNullableEncoder Jenc.int x.planometry)
        , ("Quiina", makeNullableEncoder Jenc.int x.quiina)
        , ("Robert", makeNullableEncoder Jenc.int x.robert)
        , ("rot", makeNullableEncoder Jenc.int x.rot)
        , ("subcinctorium", makeNullableEncoder Jenc.int x.subcinctorium)
        , ("tussocker", makeNullableEncoder Jenc.int x.tussocker)
        , ("ultraproud", makeNullableEncoder Jenc.int x.ultraproud)
        , ("unsuggestedness", makeNullableEncoder Jenc.int x.unsuggestedness)
        ]

unmortgaged : Jdec.Decoder Unmortgaged
unmortgaged =
    Jdec.oneOf
        [ Jdec.null NullInUnmortgaged
        , Jdec.map DoubleInUnmortgaged Jdec.float
        , Jdec.map IntegerMapInUnmortgaged (Jdec.dict Jdec.int)
        ]

encodeUnmortgaged : Unmortgaged -> Jenc.Value
encodeUnmortgaged x = case x of
    NullInUnmortgaged -> Jenc.null
    DoubleInUnmortgaged y -> Jenc.float y
    IntegerMapInUnmortgaged y -> Jenc.dict identity Jenc.int y

unobstructed : Jdec.Decoder Unobstructed
unobstructed =
    Jdec.oneOf
        [ Jdec.map IntegerInUnobstructed Jdec.int
        , Jdec.null NullInUnobstructed
        , Jdec.map QuebrachineClassInUnobstructed quebrachineClass
        ]

encodeUnobstructed : Unobstructed -> Jenc.Value
encodeUnobstructed x = case x of
    IntegerInUnobstructed y -> Jenc.int y
    NullInUnobstructed -> Jenc.null
    QuebrachineClassInUnobstructed y -> encodeQuebrachineClass y

unreceptivity : Jdec.Decoder Unreceptivity
unreceptivity =
    Jdec.oneOf
        [ Jdec.map NullArrayInUnreceptivity (Jdec.array (Jdec.null ()) )
        , Jdec.map IntegerInUnreceptivity Jdec.int
        , Jdec.map StringInUnreceptivity Jdec.string
        ]

encodeUnreceptivity : Unreceptivity -> Jenc.Value
encodeUnreceptivity x = case x of
    NullArrayInUnreceptivity y -> Jenc.array (always Jenc.null) y
    IntegerInUnreceptivity y -> Jenc.int y
    StringInUnreceptivity y -> Jenc.string y

unsatisfactoriness : Jdec.Decoder Unsatisfactoriness
unsatisfactoriness =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInUnsatisfactoriness (Jdec.array Jdec.int )
        , Jdec.map BoolInUnsatisfactoriness Jdec.bool
        , Jdec.map IntegerInUnsatisfactoriness Jdec.int
        ]

encodeUnsatisfactoriness : Unsatisfactoriness -> Jenc.Value
encodeUnsatisfactoriness x = case x of
    IntegerArrayInUnsatisfactoriness y -> Jenc.array Jenc.int y
    BoolInUnsatisfactoriness y -> Jenc.bool y
    IntegerInUnsatisfactoriness y -> Jenc.int y

unstressedElement : Jdec.Decoder UnstressedElement
unstressedElement =
    Jdec.oneOf
        [ Jdec.map BoolInUnstressedElement Jdec.bool
        , Jdec.map StringInUnstressedElement Jdec.string
        , Jdec.map UnstressedClassInUnstressedElement unstressedClass
        ]

encodeUnstressedElement : UnstressedElement -> Jenc.Value
encodeUnstressedElement x = case x of
    BoolInUnstressedElement y -> Jenc.bool y
    StringInUnstressedElement y -> Jenc.string y
    UnstressedClassInUnstressedElement y -> encodeUnstressedClass y

unstressedClass : Jdec.Decoder UnstressedClass
unstressedClass =
    Jdec.succeed UnstressedClass
        |> Jpipe.required "Alain" (Jdec.null ())
        |> Jpipe.required "Amphirhina" (Jdec.null ())
        |> Jpipe.required "antimachinery" (Jdec.null ())
        |> Jpipe.required "coldish" (Jdec.null ())
        |> Jpipe.required "crantara" (Jdec.null ())
        |> Jpipe.required "distinguishing" (Jdec.null ())
        |> Jpipe.required "elytroposis" (Jdec.null ())
        |> Jpipe.required "gentianwort" (Jdec.null ())
        |> Jpipe.required "heliosis" (Jdec.null ())
        |> Jpipe.required "instrumental" (Jdec.null ())
        |> Jpipe.required "introinflection" (Jdec.null ())
        |> Jpipe.required "kala" (Jdec.null ())
        |> Jpipe.required "Lincolnian" (Jdec.null ())
        |> Jpipe.required "metad" (Jdec.null ())
        |> Jpipe.required "Sarcophilus" (Jdec.null ())
        |> Jpipe.required "swingingly" (Jdec.null ())
        |> Jpipe.required "unconformity" (Jdec.null ())
        |> Jpipe.required "undecreed" (Jdec.null ())
        |> Jpipe.required "venerable" (Jdec.null ())
        |> Jpipe.required "vowellessness" (Jdec.null ())

encodeUnstressedClass : UnstressedClass -> Jenc.Value
encodeUnstressedClass x =
    Jenc.object
        [ ("Alain", always Jenc.null x.alain)
        , ("Amphirhina", always Jenc.null x.amphirhina)
        , ("antimachinery", always Jenc.null x.antimachinery)
        , ("coldish", always Jenc.null x.coldish)
        , ("crantara", always Jenc.null x.crantara)
        , ("distinguishing", always Jenc.null x.distinguishing)
        , ("elytroposis", always Jenc.null x.elytroposis)
        , ("gentianwort", always Jenc.null x.gentianwort)
        , ("heliosis", always Jenc.null x.heliosis)
        , ("instrumental", always Jenc.null x.instrumental)
        , ("introinflection", always Jenc.null x.introinflection)
        , ("kala", always Jenc.null x.kala)
        , ("Lincolnian", always Jenc.null x.lincolnian)
        , ("metad", always Jenc.null x.metad)
        , ("Sarcophilus", always Jenc.null x.sarcophilus)
        , ("swingingly", always Jenc.null x.swingingly)
        , ("unconformity", always Jenc.null x.unconformity)
        , ("undecreed", always Jenc.null x.undecreed)
        , ("venerable", always Jenc.null x.venerable)
        , ("vowellessness", always Jenc.null x.vowellessness)
        ]

untasked : Jdec.Decoder Untasked
untasked =
    Jdec.oneOf
        [ Jdec.map NullArrayInUntasked (Jdec.array (Jdec.null ()) )
        , Jdec.map DoubleInUntasked Jdec.float
        , Jdec.map IntegerMapInUntasked (Jdec.dict Jdec.int)
        ]

encodeUntasked : Untasked -> Jenc.Value
encodeUntasked x = case x of
    NullArrayInUntasked y -> Jenc.array (always Jenc.null) y
    DoubleInUntasked y -> Jenc.float y
    IntegerMapInUntasked y -> Jenc.dict identity Jenc.int y

unvarying : Jdec.Decoder Unvarying
unvarying =
    Jdec.oneOf
        [ Jdec.map BoolInUnvarying Jdec.bool
        , Jdec.map DoubleInUnvarying Jdec.float
        , Jdec.map IntegerMapInUnvarying (Jdec.dict Jdec.int)
        ]

encodeUnvarying : Unvarying -> Jenc.Value
encodeUnvarying x = case x of
    BoolInUnvarying y -> Jenc.bool y
    DoubleInUnvarying y -> Jenc.float y
    IntegerMapInUnvarying y -> Jenc.dict identity Jenc.int y

vehemently : Jdec.Decoder Vehemently
vehemently =
    Jdec.oneOf
        [ Jdec.map NullArrayInVehemently (Jdec.array (Jdec.null ()) )
        , Jdec.map BoolInVehemently Jdec.bool
        , Jdec.null NullInVehemently
        ]

encodeVehemently : Vehemently -> Jenc.Value
encodeVehemently x = case x of
    NullArrayInVehemently y -> Jenc.array (always Jenc.null) y
    BoolInVehemently y -> Jenc.bool y
    NullInVehemently -> Jenc.null

whitepot : Jdec.Decoder Whitepot
whitepot =
    Jdec.oneOf
        [ Jdec.map DoubleInWhitepot Jdec.float
        , Jdec.map QuebrachineClassInWhitepot quebrachineClass
        ]

encodeWhitepot : Whitepot -> Jenc.Value
encodeWhitepot x = case x of
    DoubleInWhitepot y -> Jenc.float y
    QuebrachineClassInWhitepot y -> encodeQuebrachineClass y

wrothyElement : Jdec.Decoder WrothyElement
wrothyElement =
    Jdec.oneOf
        [ Jdec.map NullArrayInWrothyElement (Jdec.array (Jdec.null ()) )
        , Jdec.map WrothyClassInWrothyElement wrothyClass
        ]

encodeWrothyElement : WrothyElement -> Jenc.Value
encodeWrothyElement x = case x of
    NullArrayInWrothyElement y -> Jenc.array (always Jenc.null) y
    WrothyClassInWrothyElement y -> encodeWrothyClass y

wrothyClass : Jdec.Decoder WrothyClass
wrothyClass =
    Jdec.succeed WrothyClass
        |> Jpipe.required "Aeschynanthus" (Jdec.null ())
        |> Jpipe.required "aquiferous" (Jdec.null ())
        |> Jpipe.required "cheapener" (Jdec.null ())
        |> Jpipe.required "enumeration" (Jdec.null ())
        |> Jpipe.required "Ephesine" (Jdec.null ())
        |> Jpipe.required "escadrille" (Jdec.null ())
        |> Jpipe.required "estrous" (Jdec.null ())
        |> Jpipe.required "interestedly" (Jdec.null ())
        |> Jpipe.required "katakinetomer" (Jdec.null ())
        |> Jpipe.required "mortification" (Jdec.null ())
        |> Jpipe.required "morula" (Jdec.null ())
        |> Jpipe.required "orthosymmetrical" (Jdec.null ())
        |> Jpipe.required "overbark" (Jdec.null ())
        |> Jpipe.required "politist" (Jdec.null ())
        |> Jpipe.required "qualified" (Jdec.null ())
        |> Jpipe.required "sphenomalar" (Jdec.null ())
        |> Jpipe.required "throatful" (Jdec.null ())
        |> Jpipe.required "transhumance" (Jdec.null ())
        |> Jpipe.required "triandrian" (Jdec.null ())
        |> Jpipe.required "unbooked" (Jdec.null ())

encodeWrothyClass : WrothyClass -> Jenc.Value
encodeWrothyClass x =
    Jenc.object
        [ ("Aeschynanthus", always Jenc.null x.aeschynanthus)
        , ("aquiferous", always Jenc.null x.aquiferous)
        , ("cheapener", always Jenc.null x.cheapener)
        , ("enumeration", always Jenc.null x.enumeration)
        , ("Ephesine", always Jenc.null x.ephesine)
        , ("escadrille", always Jenc.null x.escadrille)
        , ("estrous", always Jenc.null x.estrous)
        , ("interestedly", always Jenc.null x.interestedly)
        , ("katakinetomer", always Jenc.null x.katakinetomer)
        , ("mortification", always Jenc.null x.mortification)
        , ("morula", always Jenc.null x.morula)
        , ("orthosymmetrical", always Jenc.null x.orthosymmetrical)
        , ("overbark", always Jenc.null x.overbark)
        , ("politist", always Jenc.null x.politist)
        , ("qualified", always Jenc.null x.qualified)
        , ("sphenomalar", always Jenc.null x.sphenomalar)
        , ("throatful", always Jenc.null x.throatful)
        , ("transhumance", always Jenc.null x.transhumance)
        , ("triandrian", always Jenc.null x.triandrian)
        , ("unbooked", always Jenc.null x.unbooked)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
