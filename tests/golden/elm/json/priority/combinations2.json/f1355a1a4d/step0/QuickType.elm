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
    , AlleviateClass
    , Rebecca
    , Amphithyron
    , AnkeeClass
    , AnsarieClass
    , ChytridiaceaeClass
    , DiscordiaClass
    , GryphosaurusClass
    , LaviniaClass
    , OskarClass
    , Abranchiata(..)
    , Academe(..)
    , Acquirable(..)
    , Aerometry(..)
    , Alexin(..)
    , AlleviateElement(..)
    , Amaa(..)
    , Ambassage(..)
    , AnkeeElement(..)
    , AnsarieElement(..)
    , Aphasia(..)
    , Asprawl(..)
    , Bedesman(..)
    , Belard(..)
    , Bocking(..)
    , Brawlingly(..)
    , Brookie(..)
    , Bumboatman(..)
    , Calaverite(..)
    , Catallactic(..)
    , Cemental(..)
    , ChytridiaceaeElement(..)
    , DiscordiaElement(..)
    , Endomyce(..)
    , Epinephelidae(..)
    , Eupatorium(..)
    , GryphosaurusElement(..)
    , Koryak(..)
    , LaviniaElement(..)
    , OskarElement(..)
    , RebeccaElement(..)
    , Rhomboganoidei(..)
    , Ruellia(..)
    , School(..)
    , Shakespearolater(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { abranchiata : List Abranchiata
    , academe : List Academe
    , acquirable : List Acquirable
    , aerometry : List Aerometry
    , alexin : List Alexin
    , alleviate : List AlleviateElement
    , amaas : List Amaa
    , ambassage : List Ambassage
    , amphithyron : List (Maybe Amphithyron)
    , andriana : List (Maybe String)
    , ankee : List AnkeeElement
    , annihilator : List (Maybe (Dict String (Maybe Int)))
    , annulose : ()
    , ansarie : List AnsarieElement
    , aphasia : List Aphasia
    , asprawl : List Asprawl
    , attractive : List (Maybe Bool)
    , barksome : Dict String Int
    , bedesman : List Bedesman
    , belard : List Belard
    , bocking : List Bocking
    , brawlingly : List Brawlingly
    , brookie : List Brookie
    , bumboatman : List Bumboatman
    , bystreet : List ()
    , calaverite : List Calaverite
    , catallactic : List Catallactic
    , cemental : List Cemental
    , chytridiaceae : List ChytridiaceaeElement
    , discordia : List DiscordiaElement
    , endomyces : List Endomyce
    , epinephelidae : List Epinephelidae
    , eupatorium : List Eupatorium
    , gryphosaurus : List GryphosaurusElement
    , koryak : List Koryak
    , lavinia : List LaviniaElement
    , oskar : List OskarElement
    , rebecca : List RebeccaElement
    , rhomboganoidei : List Rhomboganoidei
    , rigsmal : Bool
    , ruellia : List Ruellia
    , school : List School
    , shakespearolater : List Shakespearolater
    , svan : List Float
    , wayao : Dict String Float
    }

type Abranchiata
    = IntegerArrayInAbranchiata (List Int)
    | IntegerInAbranchiata Int
    | NullInAbranchiata

type Academe
    = IntegerArrayInAcademe (List Int)
    | IntegerInAcademe Int
    | IntegerMapInAcademe (Dict String Int)

type Acquirable
    = IntegerMapInAcquirable (Dict String Int)
    | UnionArrayInAcquirable (List (Maybe Int))

type Aerometry
    = BoolInAerometry Bool
    | DoubleInAerometry Float

type Alexin
    = BoolInAlexin Bool
    | IntegerArrayInAlexin (List Int)

type AlleviateElement
    = AlleviateClassInAlleviateElement AlleviateClass
    | UnionArrayInAlleviateElement (List (Maybe Int))

type alias AlleviateClass =
    { apriori : ()
    , beggarer : ()
    , brokenheartedly : ()
    , debilitation : ()
    , frike : ()
    , gastrolith : ()
    , hulsean : ()
    , orthocentric : ()
    , petaly : ()
    , probudgeting : ()
    , reacquire : ()
    , scow : ()
    , shutoff : ()
    , subcontiguous : ()
    , suffumigate : ()
    , transformable : ()
    , uncoroneted : ()
    , unparking : ()
    , unvarnishedness : ()
    , wherewithal : ()
    }

type Amaa
    = BoolInAmaa Bool
    | IntegerInAmaa Int
    | RebeccaInAmaa Rebecca

type alias Rebecca =
    { catharticalness : Float
    , chirotherium : Int
    , disdiapason : String
    , homocerc : Bool
    , nonbookish : ()
    }

type Ambassage
    = NullArrayInAmbassage (List ())
    | StringInAmbassage String

type alias Amphithyron =
    { akroasis : Maybe Int
    , antiphonical : Maybe Int
    , basebred : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , conductometric : Maybe Int
    , disdiapason : Maybe String
    , ensilation : Maybe Int
    , eyebolt : Maybe Int
    , fistulated : Maybe Int
    , heteropod : Maybe Int
    , homocerc : Maybe Bool
    , juniperus : Maybe Int
    , labyrinthically : Maybe Int
    , martyrization : Maybe Int
    , mispolicy : Maybe Int
    , multipara : Maybe Int
    , nazirite : Maybe Int
    , nonbookish : Maybe ()
    , possessorial : Maybe Int
    , shamed : Maybe Int
    , shelfworn : Maybe Int
    , stagnum : Maybe Int
    , those : Maybe Int
    , undecimal : Maybe Int
    }

type AnkeeElement
    = AnkeeClassInAnkeeElement AnkeeClass
    | IntegerArrayInAnkeeElement (List Int)
    | IntegerInAnkeeElement Int

type alias AnkeeClass =
    { anomoean : ()
    , barleyhood : ()
    , befriender : ()
    , brutishness : ()
    , cephalalgy : ()
    , cirurgian : ()
    , conventionally : ()
    , jackshay : ()
    , milammeter : ()
    , naja : ()
    , ombrological : ()
    , phonasthenia : ()
    , retrievableness : ()
    , snakily : ()
    , swot : ()
    , tartlet : ()
    , thiofuran : ()
    , tracheophone : ()
    , tuglike : ()
    , unscratchingly : ()
    }

type AnsarieElement
    = AnsarieClassInAnsarieElement AnsarieClass
    | IntegerArrayInAnsarieElement (List Int)
    | NullInAnsarieElement

type alias AnsarieClass =
    { accension : ()
    , alida : ()
    , asteria : ()
    , beriberic : ()
    , edgebone : ()
    , gastrodialysis : ()
    , geographic : ()
    , ictonyx : ()
    , metrocele : ()
    , misgraft : ()
    , monteith : ()
    , notcher : ()
    , prorestriction : ()
    , ramist : ()
    , throatlet : ()
    , unfair : ()
    , unsynonymous : ()
    , water : ()
    , zestfully : ()
    , zincic : ()
    }

type Aphasia
    = IntegerArrayInAphasia (List Int)
    | IntegerInAphasia Int

type Asprawl
    = DoubleInAsprawl Float
    | StringInAsprawl String

type Bedesman
    = BoolInBedesman Bool
    | DoubleInBedesman Float
    | StringInBedesman String

type Belard
    = DoubleInBelard Float
    | IntegerArrayInBelard (List Int)
    | RebeccaInBelard Rebecca

type Bocking
    = BoolInBocking Bool
    | IntegerArrayInBocking (List Int)
    | IntegerMapInBocking (Dict String Int)

type Brawlingly
    = NullArrayInBrawlingly (List ())
    | UnionMapInBrawlingly (Dict String (Maybe Int))

type Brookie
    = IntegerArrayInBrookie (List Int)
    | RebeccaInBrookie Rebecca

type Bumboatman
    = NullArrayInBumboatman (List ())
    | NullInBumboatman
    | StringInBumboatman String

type Calaverite
    = IntegerArrayInCalaverite (List Int)
    | StringInCalaverite String

type Catallactic
    = BoolInCatallactic Bool
    | IntegerMapInCatallactic (Dict String Int)
    | NullArrayInCatallactic (List ())

type Cemental
    = DoubleInCemental Float
    | IntegerArrayInCemental (List Int)
    | IntegerMapInCemental (Dict String Int)

type ChytridiaceaeElement
    = BoolInChytridiaceaeElement Bool
    | ChytridiaceaeClassInChytridiaceaeElement ChytridiaceaeClass
    | NullInChytridiaceaeElement

type alias ChytridiaceaeClass =
    { batidaceae : ()
    , brechites : ()
    , codespairer : ()
    , emery : ()
    , enervative : ()
    , excriminate : ()
    , goshenite : ()
    , grime : ()
    , gritten : ()
    , hectorly : ()
    , intermediation : ()
    , meeterly : ()
    , narraganset : ()
    , onymatic : ()
    , paddlecock : ()
    , thana : ()
    , thornily : ()
    , uckia : ()
    , unmettle : ()
    , vorticellid : ()
    }

type DiscordiaElement
    = DiscordiaClassInDiscordiaElement DiscordiaClass
    | IntegerArrayInDiscordiaElement (List Int)

type alias DiscordiaClass =
    { altaic : Maybe Int
    , amoristic : Maybe Int
    , blennophthalmia : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , disciplinability : Maybe Int
    , disdiapason : Maybe String
    , goofer : Maybe Int
    , homocerc : Maybe Bool
    , laryngograph : Maybe Int
    , leucitis : Maybe Int
    , lymphocyst : Maybe Int
    , microcosmology : Maybe Int
    , nauseation : Maybe Int
    , nonbookish : Maybe ()
    , patarin : Maybe Int
    , preliberal : Maybe Int
    , prettifier : Maybe Int
    , rangework : Maybe Int
    , redient : Maybe Int
    , subfusiform : Maybe Int
    , suicidical : Maybe Int
    , swow : Maybe Int
    , wastrel : Maybe Int
    , wingle : Maybe Int
    }

type Endomyce
    = IntegerInEndomyce Int
    | StringInEndomyce String

type Epinephelidae
    = BoolInEpinephelidae Bool
    | IntegerInEpinephelidae Int
    | StringInEpinephelidae String

type Eupatorium
    = IntegerMapInEupatorium (Dict String Int)
    | NullArrayInEupatorium (List ())

type GryphosaurusElement
    = GryphosaurusClassInGryphosaurusElement GryphosaurusClass
    | IntegerArrayInGryphosaurusElement (List Int)
    | StringInGryphosaurusElement String

type alias GryphosaurusClass =
    { amissibility : ()
    , burushaski : ()
    , citronin : ()
    , coplaintiff : ()
    , disquisitionary : ()
    , enoplan : ()
    , faintness : ()
    , hebetomy : ()
    , islandry : ()
    , lameduck : ()
    , overbattle : ()
    , overinterested : ()
    , phrenologic : ()
    , rainband : ()
    , shiningly : ()
    , stamineous : ()
    , subscapularis : ()
    , tahami : ()
    , undaubed : ()
    , underntime : ()
    }

type Koryak
    = StringInKoryak String
    | UnionMapInKoryak (Dict String (Maybe Int))

type LaviniaElement
    = LaviniaClassInLaviniaElement LaviniaClass
    | StringInLaviniaElement String

type alias LaviniaClass =
    { agitable : Maybe Int
    , asininity : Maybe Int
    , benefiter : Maybe Int
    , bronzelike : Maybe Int
    , catharticalness : Maybe Float
    , chirotherium : Maybe Int
    , cholesteatomatous : Maybe Int
    , deprivement : Maybe Int
    , disdiapason : Maybe String
    , flippantness : Maybe Int
    , fogproof : Maybe Int
    , homocerc : Maybe Bool
    , merrymeeting : Maybe Int
    , nonbookish : Maybe ()
    , overcareful : Maybe Int
    , panaris : Maybe Int
    , preacceptance : Maybe Int
    , quinoxaline : Maybe Int
    , sig : Maybe Int
    , superconfusion : Maybe Int
    , tacana : Maybe Int
    , tillotter : Maybe Int
    , tranquillize : Maybe Int
    , unquestionable : Maybe Int
    , uproute : Maybe Int
    }

type OskarElement
    = IntegerArrayInOskarElement (List Int)
    | OskarClassInOskarElement OskarClass

type alias OskarClass =
    { acrobates : ()
    , beanshooter : ()
    , bearhound : ()
    , cayuga : ()
    , guarneri : ()
    , hypochondriacism : ()
    , indication : ()
    , jaculative : ()
    , nagana : ()
    , netherlandish : ()
    , noctivagous : ()
    , nonphysiological : ()
    , praxis : ()
    , provision : ()
    , subterhuman : ()
    , sunlit : ()
    , syncraniate : ()
    , teachment : ()
    , unmutinous : ()
    , unstoppable : ()
    }

type RebeccaElement
    = IntegerInRebeccaElement Int
    | RebeccaInRebeccaElement Rebecca
    | StringInRebeccaElement String

type Rhomboganoidei
    = IntegerArrayInRhomboganoidei (List Int)
    | RebeccaInRhomboganoidei Rebecca
    | StringInRhomboganoidei String

type Ruellia
    = BoolInRuellia Bool
    | RebeccaInRuellia Rebecca
    | StringInRuellia String

type School
    = IntegerInSchool Int
    | IntegerMapInSchool (Dict String Int)
    | NullInSchool

type Shakespearolater
    = DoubleInShakespearolater Float
    | IntegerArrayInShakespearolater (List Int)
    | StringInShakespearolater String

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
        |> Jpipe.required "Abranchiata" (Jdec.list abranchiata )
        |> Jpipe.required "academe" (Jdec.list academe )
        |> Jpipe.required "acquirable" (Jdec.list acquirable )
        |> Jpipe.required "aerometry" (Jdec.list aerometry )
        |> Jpipe.required "alexin" (Jdec.list alexin )
        |> Jpipe.required "alleviate" (Jdec.list alleviateElement )
        |> Jpipe.required "amaas" (Jdec.list amaa )
        |> Jpipe.required "ambassage" (Jdec.list ambassage )
        |> Jpipe.required "amphithyron" (Jdec.list (Jdec.nullable amphithyron) )
        |> Jpipe.required "Andriana" (Jdec.list (Jdec.nullable Jdec.string) )
        |> Jpipe.required "ankee" (Jdec.list ankeeElement )
        |> Jpipe.required "annihilator" (Jdec.list (Jdec.nullable (Jdec.dict (Jdec.nullable Jdec.int))) )
        |> Jpipe.required "annulose" (Jdec.null ())
        |> Jpipe.required "Ansarie" (Jdec.list ansarieElement )
        |> Jpipe.required "aphasia" (Jdec.list aphasia )
        |> Jpipe.required "asprawl" (Jdec.list asprawl )
        |> Jpipe.required "attractive" (Jdec.list (Jdec.nullable Jdec.bool) )
        |> Jpipe.required "barksome" (Jdec.dict Jdec.int)
        |> Jpipe.required "bedesman" (Jdec.list bedesman )
        |> Jpipe.required "belard" (Jdec.list belard )
        |> Jpipe.required "bocking" (Jdec.list bocking )
        |> Jpipe.required "brawlingly" (Jdec.list brawlingly )
        |> Jpipe.required "brookie" (Jdec.list brookie )
        |> Jpipe.required "bumboatman" (Jdec.list bumboatman )
        |> Jpipe.required "bystreet" (Jdec.list (Jdec.null ()) )
        |> Jpipe.required "calaverite" (Jdec.list calaverite )
        |> Jpipe.required "catallactic" (Jdec.list catallactic )
        |> Jpipe.required "cemental" (Jdec.list cemental )
        |> Jpipe.required "Chytridiaceae" (Jdec.list chytridiaceaeElement )
        |> Jpipe.required "Discordia" (Jdec.list discordiaElement )
        |> Jpipe.required "Endomyces" (Jdec.list endomyce )
        |> Jpipe.required "Epinephelidae" (Jdec.list epinephelidae )
        |> Jpipe.required "Eupatorium" (Jdec.list eupatorium )
        |> Jpipe.required "Gryphosaurus" (Jdec.list gryphosaurusElement )
        |> Jpipe.required "Koryak" (Jdec.list koryak )
        |> Jpipe.required "Lavinia" (Jdec.list laviniaElement )
        |> Jpipe.required "Oskar" (Jdec.list oskarElement )
        |> Jpipe.required "Rebecca" (Jdec.list rebeccaElement )
        |> Jpipe.required "Rhomboganoidei" (Jdec.list rhomboganoidei )
        |> Jpipe.required "Rigsmal" Jdec.bool
        |> Jpipe.required "Ruellia" (Jdec.list ruellia )
        |> Jpipe.required "School" (Jdec.list school )
        |> Jpipe.required "Shakespearolater" (Jdec.list shakespearolater )
        |> Jpipe.required "Svan" (Jdec.list Jdec.float )
        |> Jpipe.required "Wayao" (Jdec.dict Jdec.float)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("Abranchiata", Jenc.list encodeAbranchiata x.abranchiata)
        , ("academe", Jenc.list encodeAcademe x.academe)
        , ("acquirable", Jenc.list encodeAcquirable x.acquirable)
        , ("aerometry", Jenc.list encodeAerometry x.aerometry)
        , ("alexin", Jenc.list encodeAlexin x.alexin)
        , ("alleviate", Jenc.list encodeAlleviateElement x.alleviate)
        , ("amaas", Jenc.list encodeAmaa x.amaas)
        , ("ambassage", Jenc.list encodeAmbassage x.ambassage)
        , ("amphithyron", Jenc.list (makeNullableEncoder encodeAmphithyron) x.amphithyron)
        , ("Andriana", Jenc.list (makeNullableEncoder Jenc.string) x.andriana)
        , ("ankee", Jenc.list encodeAnkeeElement x.ankee)
        , ("annihilator", Jenc.list (makeNullableEncoder (Jenc.dict identity (makeNullableEncoder Jenc.int))) x.annihilator)
        , ("annulose", always Jenc.null x.annulose)
        , ("Ansarie", Jenc.list encodeAnsarieElement x.ansarie)
        , ("aphasia", Jenc.list encodeAphasia x.aphasia)
        , ("asprawl", Jenc.list encodeAsprawl x.asprawl)
        , ("attractive", Jenc.list (makeNullableEncoder Jenc.bool) x.attractive)
        , ("barksome", Jenc.dict identity Jenc.int x.barksome)
        , ("bedesman", Jenc.list encodeBedesman x.bedesman)
        , ("belard", Jenc.list encodeBelard x.belard)
        , ("bocking", Jenc.list encodeBocking x.bocking)
        , ("brawlingly", Jenc.list encodeBrawlingly x.brawlingly)
        , ("brookie", Jenc.list encodeBrookie x.brookie)
        , ("bumboatman", Jenc.list encodeBumboatman x.bumboatman)
        , ("bystreet", Jenc.list (always Jenc.null) x.bystreet)
        , ("calaverite", Jenc.list encodeCalaverite x.calaverite)
        , ("catallactic", Jenc.list encodeCatallactic x.catallactic)
        , ("cemental", Jenc.list encodeCemental x.cemental)
        , ("Chytridiaceae", Jenc.list encodeChytridiaceaeElement x.chytridiaceae)
        , ("Discordia", Jenc.list encodeDiscordiaElement x.discordia)
        , ("Endomyces", Jenc.list encodeEndomyce x.endomyces)
        , ("Epinephelidae", Jenc.list encodeEpinephelidae x.epinephelidae)
        , ("Eupatorium", Jenc.list encodeEupatorium x.eupatorium)
        , ("Gryphosaurus", Jenc.list encodeGryphosaurusElement x.gryphosaurus)
        , ("Koryak", Jenc.list encodeKoryak x.koryak)
        , ("Lavinia", Jenc.list encodeLaviniaElement x.lavinia)
        , ("Oskar", Jenc.list encodeOskarElement x.oskar)
        , ("Rebecca", Jenc.list encodeRebeccaElement x.rebecca)
        , ("Rhomboganoidei", Jenc.list encodeRhomboganoidei x.rhomboganoidei)
        , ("Rigsmal", Jenc.bool x.rigsmal)
        , ("Ruellia", Jenc.list encodeRuellia x.ruellia)
        , ("School", Jenc.list encodeSchool x.school)
        , ("Shakespearolater", Jenc.list encodeShakespearolater x.shakespearolater)
        , ("Svan", Jenc.list Jenc.float x.svan)
        , ("Wayao", Jenc.dict identity Jenc.float x.wayao)
        ]

abranchiata : Jdec.Decoder Abranchiata
abranchiata =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAbranchiata (Jdec.list Jdec.int )
        , Jdec.map IntegerInAbranchiata Jdec.int
        , Jdec.null NullInAbranchiata
        ]

encodeAbranchiata : Abranchiata -> Jenc.Value
encodeAbranchiata x = case x of
    IntegerArrayInAbranchiata y -> Jenc.list Jenc.int y
    IntegerInAbranchiata y -> Jenc.int y
    NullInAbranchiata -> Jenc.null

academe : Jdec.Decoder Academe
academe =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAcademe (Jdec.list Jdec.int )
        , Jdec.map IntegerInAcademe Jdec.int
        , Jdec.map IntegerMapInAcademe (Jdec.dict Jdec.int)
        ]

encodeAcademe : Academe -> Jenc.Value
encodeAcademe x = case x of
    IntegerArrayInAcademe y -> Jenc.list Jenc.int y
    IntegerInAcademe y -> Jenc.int y
    IntegerMapInAcademe y -> Jenc.dict identity Jenc.int y

acquirable : Jdec.Decoder Acquirable
acquirable =
    Jdec.oneOf
        [ Jdec.map UnionArrayInAcquirable (Jdec.list (Jdec.nullable Jdec.int) )
        , Jdec.map IntegerMapInAcquirable (Jdec.dict Jdec.int)
        ]

encodeAcquirable : Acquirable -> Jenc.Value
encodeAcquirable x = case x of
    UnionArrayInAcquirable y -> Jenc.list (makeNullableEncoder Jenc.int) y
    IntegerMapInAcquirable y -> Jenc.dict identity Jenc.int y

aerometry : Jdec.Decoder Aerometry
aerometry =
    Jdec.oneOf
        [ Jdec.map BoolInAerometry Jdec.bool
        , Jdec.map DoubleInAerometry Jdec.float
        ]

encodeAerometry : Aerometry -> Jenc.Value
encodeAerometry x = case x of
    BoolInAerometry y -> Jenc.bool y
    DoubleInAerometry y -> Jenc.float y

alexin : Jdec.Decoder Alexin
alexin =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAlexin (Jdec.list Jdec.int )
        , Jdec.map BoolInAlexin Jdec.bool
        ]

encodeAlexin : Alexin -> Jenc.Value
encodeAlexin x = case x of
    IntegerArrayInAlexin y -> Jenc.list Jenc.int y
    BoolInAlexin y -> Jenc.bool y

alleviateElement : Jdec.Decoder AlleviateElement
alleviateElement =
    Jdec.oneOf
        [ Jdec.map UnionArrayInAlleviateElement (Jdec.list (Jdec.nullable Jdec.int) )
        , Jdec.map AlleviateClassInAlleviateElement alleviateClass
        ]

encodeAlleviateElement : AlleviateElement -> Jenc.Value
encodeAlleviateElement x = case x of
    UnionArrayInAlleviateElement y -> Jenc.list (makeNullableEncoder Jenc.int) y
    AlleviateClassInAlleviateElement y -> encodeAlleviateClass y

alleviateClass : Jdec.Decoder AlleviateClass
alleviateClass =
    Jdec.succeed AlleviateClass
        |> Jpipe.required "apriori" (Jdec.null ())
        |> Jpipe.required "beggarer" (Jdec.null ())
        |> Jpipe.required "brokenheartedly" (Jdec.null ())
        |> Jpipe.required "debilitation" (Jdec.null ())
        |> Jpipe.required "frike" (Jdec.null ())
        |> Jpipe.required "gastrolith" (Jdec.null ())
        |> Jpipe.required "Hulsean" (Jdec.null ())
        |> Jpipe.required "orthocentric" (Jdec.null ())
        |> Jpipe.required "petaly" (Jdec.null ())
        |> Jpipe.required "probudgeting" (Jdec.null ())
        |> Jpipe.required "reacquire" (Jdec.null ())
        |> Jpipe.required "scow" (Jdec.null ())
        |> Jpipe.required "shutoff" (Jdec.null ())
        |> Jpipe.required "subcontiguous" (Jdec.null ())
        |> Jpipe.required "suffumigate" (Jdec.null ())
        |> Jpipe.required "transformable" (Jdec.null ())
        |> Jpipe.required "uncoroneted" (Jdec.null ())
        |> Jpipe.required "unparking" (Jdec.null ())
        |> Jpipe.required "unvarnishedness" (Jdec.null ())
        |> Jpipe.required "wherewithal" (Jdec.null ())

encodeAlleviateClass : AlleviateClass -> Jenc.Value
encodeAlleviateClass x =
    Jenc.object
        [ ("apriori", always Jenc.null x.apriori)
        , ("beggarer", always Jenc.null x.beggarer)
        , ("brokenheartedly", always Jenc.null x.brokenheartedly)
        , ("debilitation", always Jenc.null x.debilitation)
        , ("frike", always Jenc.null x.frike)
        , ("gastrolith", always Jenc.null x.gastrolith)
        , ("Hulsean", always Jenc.null x.hulsean)
        , ("orthocentric", always Jenc.null x.orthocentric)
        , ("petaly", always Jenc.null x.petaly)
        , ("probudgeting", always Jenc.null x.probudgeting)
        , ("reacquire", always Jenc.null x.reacquire)
        , ("scow", always Jenc.null x.scow)
        , ("shutoff", always Jenc.null x.shutoff)
        , ("subcontiguous", always Jenc.null x.subcontiguous)
        , ("suffumigate", always Jenc.null x.suffumigate)
        , ("transformable", always Jenc.null x.transformable)
        , ("uncoroneted", always Jenc.null x.uncoroneted)
        , ("unparking", always Jenc.null x.unparking)
        , ("unvarnishedness", always Jenc.null x.unvarnishedness)
        , ("wherewithal", always Jenc.null x.wherewithal)
        ]

amaa : Jdec.Decoder Amaa
amaa =
    Jdec.oneOf
        [ Jdec.map BoolInAmaa Jdec.bool
        , Jdec.map IntegerInAmaa Jdec.int
        , Jdec.map RebeccaInAmaa rebecca
        ]

encodeAmaa : Amaa -> Jenc.Value
encodeAmaa x = case x of
    BoolInAmaa y -> Jenc.bool y
    IntegerInAmaa y -> Jenc.int y
    RebeccaInAmaa y -> encodeRebecca y

rebecca : Jdec.Decoder Rebecca
rebecca =
    Jdec.succeed Rebecca
        |> Jpipe.required "catharticalness" Jdec.float
        |> Jpipe.required "Chirotherium" Jdec.int
        |> Jpipe.required "disdiapason" Jdec.string
        |> Jpipe.required "homocerc" Jdec.bool
        |> Jpipe.required "nonbookish" (Jdec.null ())

encodeRebecca : Rebecca -> Jenc.Value
encodeRebecca x =
    Jenc.object
        [ ("catharticalness", Jenc.float x.catharticalness)
        , ("Chirotherium", Jenc.int x.chirotherium)
        , ("disdiapason", Jenc.string x.disdiapason)
        , ("homocerc", Jenc.bool x.homocerc)
        , ("nonbookish", always Jenc.null x.nonbookish)
        ]

ambassage : Jdec.Decoder Ambassage
ambassage =
    Jdec.oneOf
        [ Jdec.map NullArrayInAmbassage (Jdec.list (Jdec.null ()) )
        , Jdec.map StringInAmbassage Jdec.string
        ]

encodeAmbassage : Ambassage -> Jenc.Value
encodeAmbassage x = case x of
    NullArrayInAmbassage y -> Jenc.list (always Jenc.null) y
    StringInAmbassage y -> Jenc.string y

amphithyron : Jdec.Decoder Amphithyron
amphithyron =
    Jdec.succeed Amphithyron
        |> Jpipe.custom (optionalField "akroasis" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "antiphonical" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "basebred" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "conductometric" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "ensilation" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "eyebolt" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "fistulated" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "heteropod" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "Juniperus" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "labyrinthically" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "martyrization" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "mispolicy" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "multipara" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Nazirite" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "possessorial" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "shamed" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "shelfworn" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "stagnum" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Those" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "undecimal" (Jdec.map Just Jdec.int) Nothing)

encodeAmphithyron : Amphithyron -> Jenc.Value
encodeAmphithyron x =
    Jenc.object
        [ ("akroasis", makeNullableEncoder Jenc.int x.akroasis)
        , ("antiphonical", makeNullableEncoder Jenc.int x.antiphonical)
        , ("basebred", makeNullableEncoder Jenc.int x.basebred)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("conductometric", makeNullableEncoder Jenc.int x.conductometric)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("ensilation", makeNullableEncoder Jenc.int x.ensilation)
        , ("eyebolt", makeNullableEncoder Jenc.int x.eyebolt)
        , ("fistulated", makeNullableEncoder Jenc.int x.fistulated)
        , ("heteropod", makeNullableEncoder Jenc.int x.heteropod)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("Juniperus", makeNullableEncoder Jenc.int x.juniperus)
        , ("labyrinthically", makeNullableEncoder Jenc.int x.labyrinthically)
        , ("martyrization", makeNullableEncoder Jenc.int x.martyrization)
        , ("mispolicy", makeNullableEncoder Jenc.int x.mispolicy)
        , ("multipara", makeNullableEncoder Jenc.int x.multipara)
        , ("Nazirite", makeNullableEncoder Jenc.int x.nazirite)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("possessorial", makeNullableEncoder Jenc.int x.possessorial)
        , ("shamed", makeNullableEncoder Jenc.int x.shamed)
        , ("shelfworn", makeNullableEncoder Jenc.int x.shelfworn)
        , ("stagnum", makeNullableEncoder Jenc.int x.stagnum)
        , ("Those", makeNullableEncoder Jenc.int x.those)
        , ("undecimal", makeNullableEncoder Jenc.int x.undecimal)
        ]

ankeeElement : Jdec.Decoder AnkeeElement
ankeeElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAnkeeElement (Jdec.list Jdec.int )
        , Jdec.map IntegerInAnkeeElement Jdec.int
        , Jdec.map AnkeeClassInAnkeeElement ankeeClass
        ]

encodeAnkeeElement : AnkeeElement -> Jenc.Value
encodeAnkeeElement x = case x of
    IntegerArrayInAnkeeElement y -> Jenc.list Jenc.int y
    IntegerInAnkeeElement y -> Jenc.int y
    AnkeeClassInAnkeeElement y -> encodeAnkeeClass y

ankeeClass : Jdec.Decoder AnkeeClass
ankeeClass =
    Jdec.succeed AnkeeClass
        |> Jpipe.required "Anomoean" (Jdec.null ())
        |> Jpipe.required "barleyhood" (Jdec.null ())
        |> Jpipe.required "befriender" (Jdec.null ())
        |> Jpipe.required "brutishness" (Jdec.null ())
        |> Jpipe.required "cephalalgy" (Jdec.null ())
        |> Jpipe.required "cirurgian" (Jdec.null ())
        |> Jpipe.required "conventionally" (Jdec.null ())
        |> Jpipe.required "jackshay" (Jdec.null ())
        |> Jpipe.required "milammeter" (Jdec.null ())
        |> Jpipe.required "Naja" (Jdec.null ())
        |> Jpipe.required "ombrological" (Jdec.null ())
        |> Jpipe.required "phonasthenia" (Jdec.null ())
        |> Jpipe.required "retrievableness" (Jdec.null ())
        |> Jpipe.required "snakily" (Jdec.null ())
        |> Jpipe.required "swot" (Jdec.null ())
        |> Jpipe.required "tartlet" (Jdec.null ())
        |> Jpipe.required "thiofuran" (Jdec.null ())
        |> Jpipe.required "tracheophone" (Jdec.null ())
        |> Jpipe.required "tuglike" (Jdec.null ())
        |> Jpipe.required "unscratchingly" (Jdec.null ())

encodeAnkeeClass : AnkeeClass -> Jenc.Value
encodeAnkeeClass x =
    Jenc.object
        [ ("Anomoean", always Jenc.null x.anomoean)
        , ("barleyhood", always Jenc.null x.barleyhood)
        , ("befriender", always Jenc.null x.befriender)
        , ("brutishness", always Jenc.null x.brutishness)
        , ("cephalalgy", always Jenc.null x.cephalalgy)
        , ("cirurgian", always Jenc.null x.cirurgian)
        , ("conventionally", always Jenc.null x.conventionally)
        , ("jackshay", always Jenc.null x.jackshay)
        , ("milammeter", always Jenc.null x.milammeter)
        , ("Naja", always Jenc.null x.naja)
        , ("ombrological", always Jenc.null x.ombrological)
        , ("phonasthenia", always Jenc.null x.phonasthenia)
        , ("retrievableness", always Jenc.null x.retrievableness)
        , ("snakily", always Jenc.null x.snakily)
        , ("swot", always Jenc.null x.swot)
        , ("tartlet", always Jenc.null x.tartlet)
        , ("thiofuran", always Jenc.null x.thiofuran)
        , ("tracheophone", always Jenc.null x.tracheophone)
        , ("tuglike", always Jenc.null x.tuglike)
        , ("unscratchingly", always Jenc.null x.unscratchingly)
        ]

ansarieElement : Jdec.Decoder AnsarieElement
ansarieElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAnsarieElement (Jdec.list Jdec.int )
        , Jdec.null NullInAnsarieElement
        , Jdec.map AnsarieClassInAnsarieElement ansarieClass
        ]

encodeAnsarieElement : AnsarieElement -> Jenc.Value
encodeAnsarieElement x = case x of
    IntegerArrayInAnsarieElement y -> Jenc.list Jenc.int y
    NullInAnsarieElement -> Jenc.null
    AnsarieClassInAnsarieElement y -> encodeAnsarieClass y

ansarieClass : Jdec.Decoder AnsarieClass
ansarieClass =
    Jdec.succeed AnsarieClass
        |> Jpipe.required "accension" (Jdec.null ())
        |> Jpipe.required "Alida" (Jdec.null ())
        |> Jpipe.required "asteria" (Jdec.null ())
        |> Jpipe.required "beriberic" (Jdec.null ())
        |> Jpipe.required "edgebone" (Jdec.null ())
        |> Jpipe.required "gastrodialysis" (Jdec.null ())
        |> Jpipe.required "geographic" (Jdec.null ())
        |> Jpipe.required "Ictonyx" (Jdec.null ())
        |> Jpipe.required "metrocele" (Jdec.null ())
        |> Jpipe.required "misgraft" (Jdec.null ())
        |> Jpipe.required "monteith" (Jdec.null ())
        |> Jpipe.required "notcher" (Jdec.null ())
        |> Jpipe.required "prorestriction" (Jdec.null ())
        |> Jpipe.required "Ramist" (Jdec.null ())
        |> Jpipe.required "throatlet" (Jdec.null ())
        |> Jpipe.required "unfair" (Jdec.null ())
        |> Jpipe.required "unsynonymous" (Jdec.null ())
        |> Jpipe.required "water" (Jdec.null ())
        |> Jpipe.required "zestfully" (Jdec.null ())
        |> Jpipe.required "zincic" (Jdec.null ())

encodeAnsarieClass : AnsarieClass -> Jenc.Value
encodeAnsarieClass x =
    Jenc.object
        [ ("accension", always Jenc.null x.accension)
        , ("Alida", always Jenc.null x.alida)
        , ("asteria", always Jenc.null x.asteria)
        , ("beriberic", always Jenc.null x.beriberic)
        , ("edgebone", always Jenc.null x.edgebone)
        , ("gastrodialysis", always Jenc.null x.gastrodialysis)
        , ("geographic", always Jenc.null x.geographic)
        , ("Ictonyx", always Jenc.null x.ictonyx)
        , ("metrocele", always Jenc.null x.metrocele)
        , ("misgraft", always Jenc.null x.misgraft)
        , ("monteith", always Jenc.null x.monteith)
        , ("notcher", always Jenc.null x.notcher)
        , ("prorestriction", always Jenc.null x.prorestriction)
        , ("Ramist", always Jenc.null x.ramist)
        , ("throatlet", always Jenc.null x.throatlet)
        , ("unfair", always Jenc.null x.unfair)
        , ("unsynonymous", always Jenc.null x.unsynonymous)
        , ("water", always Jenc.null x.water)
        , ("zestfully", always Jenc.null x.zestfully)
        , ("zincic", always Jenc.null x.zincic)
        ]

aphasia : Jdec.Decoder Aphasia
aphasia =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInAphasia (Jdec.list Jdec.int )
        , Jdec.map IntegerInAphasia Jdec.int
        ]

encodeAphasia : Aphasia -> Jenc.Value
encodeAphasia x = case x of
    IntegerArrayInAphasia y -> Jenc.list Jenc.int y
    IntegerInAphasia y -> Jenc.int y

asprawl : Jdec.Decoder Asprawl
asprawl =
    Jdec.oneOf
        [ Jdec.map StringInAsprawl Jdec.string
        , Jdec.map DoubleInAsprawl Jdec.float
        ]

encodeAsprawl : Asprawl -> Jenc.Value
encodeAsprawl x = case x of
    StringInAsprawl y -> Jenc.string y
    DoubleInAsprawl y -> Jenc.float y

bedesman : Jdec.Decoder Bedesman
bedesman =
    Jdec.oneOf
        [ Jdec.map BoolInBedesman Jdec.bool
        , Jdec.map StringInBedesman Jdec.string
        , Jdec.map DoubleInBedesman Jdec.float
        ]

encodeBedesman : Bedesman -> Jenc.Value
encodeBedesman x = case x of
    BoolInBedesman y -> Jenc.bool y
    StringInBedesman y -> Jenc.string y
    DoubleInBedesman y -> Jenc.float y

belard : Jdec.Decoder Belard
belard =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInBelard (Jdec.list Jdec.int )
        , Jdec.map DoubleInBelard Jdec.float
        , Jdec.map RebeccaInBelard rebecca
        ]

encodeBelard : Belard -> Jenc.Value
encodeBelard x = case x of
    IntegerArrayInBelard y -> Jenc.list Jenc.int y
    DoubleInBelard y -> Jenc.float y
    RebeccaInBelard y -> encodeRebecca y

bocking : Jdec.Decoder Bocking
bocking =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInBocking (Jdec.list Jdec.int )
        , Jdec.map BoolInBocking Jdec.bool
        , Jdec.map IntegerMapInBocking (Jdec.dict Jdec.int)
        ]

encodeBocking : Bocking -> Jenc.Value
encodeBocking x = case x of
    IntegerArrayInBocking y -> Jenc.list Jenc.int y
    BoolInBocking y -> Jenc.bool y
    IntegerMapInBocking y -> Jenc.dict identity Jenc.int y

brawlingly : Jdec.Decoder Brawlingly
brawlingly =
    Jdec.oneOf
        [ Jdec.map NullArrayInBrawlingly (Jdec.list (Jdec.null ()) )
        , Jdec.map UnionMapInBrawlingly (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodeBrawlingly : Brawlingly -> Jenc.Value
encodeBrawlingly x = case x of
    NullArrayInBrawlingly y -> Jenc.list (always Jenc.null) y
    UnionMapInBrawlingly y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

brookie : Jdec.Decoder Brookie
brookie =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInBrookie (Jdec.list Jdec.int )
        , Jdec.map RebeccaInBrookie rebecca
        ]

encodeBrookie : Brookie -> Jenc.Value
encodeBrookie x = case x of
    IntegerArrayInBrookie y -> Jenc.list Jenc.int y
    RebeccaInBrookie y -> encodeRebecca y

bumboatman : Jdec.Decoder Bumboatman
bumboatman =
    Jdec.oneOf
        [ Jdec.map NullArrayInBumboatman (Jdec.list (Jdec.null ()) )
        , Jdec.null NullInBumboatman
        , Jdec.map StringInBumboatman Jdec.string
        ]

encodeBumboatman : Bumboatman -> Jenc.Value
encodeBumboatman x = case x of
    NullArrayInBumboatman y -> Jenc.list (always Jenc.null) y
    NullInBumboatman -> Jenc.null
    StringInBumboatman y -> Jenc.string y

calaverite : Jdec.Decoder Calaverite
calaverite =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInCalaverite (Jdec.list Jdec.int )
        , Jdec.map StringInCalaverite Jdec.string
        ]

encodeCalaverite : Calaverite -> Jenc.Value
encodeCalaverite x = case x of
    IntegerArrayInCalaverite y -> Jenc.list Jenc.int y
    StringInCalaverite y -> Jenc.string y

catallactic : Jdec.Decoder Catallactic
catallactic =
    Jdec.oneOf
        [ Jdec.map NullArrayInCatallactic (Jdec.list (Jdec.null ()) )
        , Jdec.map BoolInCatallactic Jdec.bool
        , Jdec.map IntegerMapInCatallactic (Jdec.dict Jdec.int)
        ]

encodeCatallactic : Catallactic -> Jenc.Value
encodeCatallactic x = case x of
    NullArrayInCatallactic y -> Jenc.list (always Jenc.null) y
    BoolInCatallactic y -> Jenc.bool y
    IntegerMapInCatallactic y -> Jenc.dict identity Jenc.int y

cemental : Jdec.Decoder Cemental
cemental =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInCemental (Jdec.list Jdec.int )
        , Jdec.map DoubleInCemental Jdec.float
        , Jdec.map IntegerMapInCemental (Jdec.dict Jdec.int)
        ]

encodeCemental : Cemental -> Jenc.Value
encodeCemental x = case x of
    IntegerArrayInCemental y -> Jenc.list Jenc.int y
    DoubleInCemental y -> Jenc.float y
    IntegerMapInCemental y -> Jenc.dict identity Jenc.int y

chytridiaceaeElement : Jdec.Decoder ChytridiaceaeElement
chytridiaceaeElement =
    Jdec.oneOf
        [ Jdec.map BoolInChytridiaceaeElement Jdec.bool
        , Jdec.null NullInChytridiaceaeElement
        , Jdec.map ChytridiaceaeClassInChytridiaceaeElement chytridiaceaeClass
        ]

encodeChytridiaceaeElement : ChytridiaceaeElement -> Jenc.Value
encodeChytridiaceaeElement x = case x of
    BoolInChytridiaceaeElement y -> Jenc.bool y
    NullInChytridiaceaeElement -> Jenc.null
    ChytridiaceaeClassInChytridiaceaeElement y -> encodeChytridiaceaeClass y

chytridiaceaeClass : Jdec.Decoder ChytridiaceaeClass
chytridiaceaeClass =
    Jdec.succeed ChytridiaceaeClass
        |> Jpipe.required "Batidaceae" (Jdec.null ())
        |> Jpipe.required "Brechites" (Jdec.null ())
        |> Jpipe.required "codespairer" (Jdec.null ())
        |> Jpipe.required "Emery" (Jdec.null ())
        |> Jpipe.required "enervative" (Jdec.null ())
        |> Jpipe.required "excriminate" (Jdec.null ())
        |> Jpipe.required "goshenite" (Jdec.null ())
        |> Jpipe.required "grime" (Jdec.null ())
        |> Jpipe.required "gritten" (Jdec.null ())
        |> Jpipe.required "hectorly" (Jdec.null ())
        |> Jpipe.required "intermediation" (Jdec.null ())
        |> Jpipe.required "meeterly" (Jdec.null ())
        |> Jpipe.required "Narraganset" (Jdec.null ())
        |> Jpipe.required "onymatic" (Jdec.null ())
        |> Jpipe.required "paddlecock" (Jdec.null ())
        |> Jpipe.required "thana" (Jdec.null ())
        |> Jpipe.required "thornily" (Jdec.null ())
        |> Jpipe.required "uckia" (Jdec.null ())
        |> Jpipe.required "unmettle" (Jdec.null ())
        |> Jpipe.required "vorticellid" (Jdec.null ())

encodeChytridiaceaeClass : ChytridiaceaeClass -> Jenc.Value
encodeChytridiaceaeClass x =
    Jenc.object
        [ ("Batidaceae", always Jenc.null x.batidaceae)
        , ("Brechites", always Jenc.null x.brechites)
        , ("codespairer", always Jenc.null x.codespairer)
        , ("Emery", always Jenc.null x.emery)
        , ("enervative", always Jenc.null x.enervative)
        , ("excriminate", always Jenc.null x.excriminate)
        , ("goshenite", always Jenc.null x.goshenite)
        , ("grime", always Jenc.null x.grime)
        , ("gritten", always Jenc.null x.gritten)
        , ("hectorly", always Jenc.null x.hectorly)
        , ("intermediation", always Jenc.null x.intermediation)
        , ("meeterly", always Jenc.null x.meeterly)
        , ("Narraganset", always Jenc.null x.narraganset)
        , ("onymatic", always Jenc.null x.onymatic)
        , ("paddlecock", always Jenc.null x.paddlecock)
        , ("thana", always Jenc.null x.thana)
        , ("thornily", always Jenc.null x.thornily)
        , ("uckia", always Jenc.null x.uckia)
        , ("unmettle", always Jenc.null x.unmettle)
        , ("vorticellid", always Jenc.null x.vorticellid)
        ]

discordiaElement : Jdec.Decoder DiscordiaElement
discordiaElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInDiscordiaElement (Jdec.list Jdec.int )
        , Jdec.map DiscordiaClassInDiscordiaElement discordiaClass
        ]

encodeDiscordiaElement : DiscordiaElement -> Jenc.Value
encodeDiscordiaElement x = case x of
    IntegerArrayInDiscordiaElement y -> Jenc.list Jenc.int y
    DiscordiaClassInDiscordiaElement y -> encodeDiscordiaClass y

discordiaClass : Jdec.Decoder DiscordiaClass
discordiaClass =
    Jdec.succeed DiscordiaClass
        |> Jpipe.custom (optionalField "Altaic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "amoristic" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "blennophthalmia" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disciplinability" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "goofer" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "laryngograph" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "leucitis" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "lymphocyst" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "microcosmology" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nauseation" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "Patarin" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "preliberal" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "prettifier" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "rangework" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "redient" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "subfusiform" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "suicidical" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "swow" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "wastrel" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "wingle" (Jdec.map Just Jdec.int) Nothing)

encodeDiscordiaClass : DiscordiaClass -> Jenc.Value
encodeDiscordiaClass x =
    Jenc.object
        [ ("Altaic", makeNullableEncoder Jenc.int x.altaic)
        , ("amoristic", makeNullableEncoder Jenc.int x.amoristic)
        , ("blennophthalmia", makeNullableEncoder Jenc.int x.blennophthalmia)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("disciplinability", makeNullableEncoder Jenc.int x.disciplinability)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("goofer", makeNullableEncoder Jenc.int x.goofer)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("laryngograph", makeNullableEncoder Jenc.int x.laryngograph)
        , ("leucitis", makeNullableEncoder Jenc.int x.leucitis)
        , ("lymphocyst", makeNullableEncoder Jenc.int x.lymphocyst)
        , ("microcosmology", makeNullableEncoder Jenc.int x.microcosmology)
        , ("nauseation", makeNullableEncoder Jenc.int x.nauseation)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("Patarin", makeNullableEncoder Jenc.int x.patarin)
        , ("preliberal", makeNullableEncoder Jenc.int x.preliberal)
        , ("prettifier", makeNullableEncoder Jenc.int x.prettifier)
        , ("rangework", makeNullableEncoder Jenc.int x.rangework)
        , ("redient", makeNullableEncoder Jenc.int x.redient)
        , ("subfusiform", makeNullableEncoder Jenc.int x.subfusiform)
        , ("suicidical", makeNullableEncoder Jenc.int x.suicidical)
        , ("swow", makeNullableEncoder Jenc.int x.swow)
        , ("wastrel", makeNullableEncoder Jenc.int x.wastrel)
        , ("wingle", makeNullableEncoder Jenc.int x.wingle)
        ]

endomyce : Jdec.Decoder Endomyce
endomyce =
    Jdec.oneOf
        [ Jdec.map IntegerInEndomyce Jdec.int
        , Jdec.map StringInEndomyce Jdec.string
        ]

encodeEndomyce : Endomyce -> Jenc.Value
encodeEndomyce x = case x of
    IntegerInEndomyce y -> Jenc.int y
    StringInEndomyce y -> Jenc.string y

epinephelidae : Jdec.Decoder Epinephelidae
epinephelidae =
    Jdec.oneOf
        [ Jdec.map BoolInEpinephelidae Jdec.bool
        , Jdec.map IntegerInEpinephelidae Jdec.int
        , Jdec.map StringInEpinephelidae Jdec.string
        ]

encodeEpinephelidae : Epinephelidae -> Jenc.Value
encodeEpinephelidae x = case x of
    BoolInEpinephelidae y -> Jenc.bool y
    IntegerInEpinephelidae y -> Jenc.int y
    StringInEpinephelidae y -> Jenc.string y

eupatorium : Jdec.Decoder Eupatorium
eupatorium =
    Jdec.oneOf
        [ Jdec.map NullArrayInEupatorium (Jdec.list (Jdec.null ()) )
        , Jdec.map IntegerMapInEupatorium (Jdec.dict Jdec.int)
        ]

encodeEupatorium : Eupatorium -> Jenc.Value
encodeEupatorium x = case x of
    NullArrayInEupatorium y -> Jenc.list (always Jenc.null) y
    IntegerMapInEupatorium y -> Jenc.dict identity Jenc.int y

gryphosaurusElement : Jdec.Decoder GryphosaurusElement
gryphosaurusElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInGryphosaurusElement (Jdec.list Jdec.int )
        , Jdec.map StringInGryphosaurusElement Jdec.string
        , Jdec.map GryphosaurusClassInGryphosaurusElement gryphosaurusClass
        ]

encodeGryphosaurusElement : GryphosaurusElement -> Jenc.Value
encodeGryphosaurusElement x = case x of
    IntegerArrayInGryphosaurusElement y -> Jenc.list Jenc.int y
    StringInGryphosaurusElement y -> Jenc.string y
    GryphosaurusClassInGryphosaurusElement y -> encodeGryphosaurusClass y

gryphosaurusClass : Jdec.Decoder GryphosaurusClass
gryphosaurusClass =
    Jdec.succeed GryphosaurusClass
        |> Jpipe.required "amissibility" (Jdec.null ())
        |> Jpipe.required "Burushaski" (Jdec.null ())
        |> Jpipe.required "citronin" (Jdec.null ())
        |> Jpipe.required "coplaintiff" (Jdec.null ())
        |> Jpipe.required "disquisitionary" (Jdec.null ())
        |> Jpipe.required "enoplan" (Jdec.null ())
        |> Jpipe.required "faintness" (Jdec.null ())
        |> Jpipe.required "hebetomy" (Jdec.null ())
        |> Jpipe.required "islandry" (Jdec.null ())
        |> Jpipe.required "lameduck" (Jdec.null ())
        |> Jpipe.required "overbattle" (Jdec.null ())
        |> Jpipe.required "overinterested" (Jdec.null ())
        |> Jpipe.required "phrenologic" (Jdec.null ())
        |> Jpipe.required "rainband" (Jdec.null ())
        |> Jpipe.required "shiningly" (Jdec.null ())
        |> Jpipe.required "stamineous" (Jdec.null ())
        |> Jpipe.required "subscapularis" (Jdec.null ())
        |> Jpipe.required "Tahami" (Jdec.null ())
        |> Jpipe.required "undaubed" (Jdec.null ())
        |> Jpipe.required "underntime" (Jdec.null ())

encodeGryphosaurusClass : GryphosaurusClass -> Jenc.Value
encodeGryphosaurusClass x =
    Jenc.object
        [ ("amissibility", always Jenc.null x.amissibility)
        , ("Burushaski", always Jenc.null x.burushaski)
        , ("citronin", always Jenc.null x.citronin)
        , ("coplaintiff", always Jenc.null x.coplaintiff)
        , ("disquisitionary", always Jenc.null x.disquisitionary)
        , ("enoplan", always Jenc.null x.enoplan)
        , ("faintness", always Jenc.null x.faintness)
        , ("hebetomy", always Jenc.null x.hebetomy)
        , ("islandry", always Jenc.null x.islandry)
        , ("lameduck", always Jenc.null x.lameduck)
        , ("overbattle", always Jenc.null x.overbattle)
        , ("overinterested", always Jenc.null x.overinterested)
        , ("phrenologic", always Jenc.null x.phrenologic)
        , ("rainband", always Jenc.null x.rainband)
        , ("shiningly", always Jenc.null x.shiningly)
        , ("stamineous", always Jenc.null x.stamineous)
        , ("subscapularis", always Jenc.null x.subscapularis)
        , ("Tahami", always Jenc.null x.tahami)
        , ("undaubed", always Jenc.null x.undaubed)
        , ("underntime", always Jenc.null x.underntime)
        ]

koryak : Jdec.Decoder Koryak
koryak =
    Jdec.oneOf
        [ Jdec.map StringInKoryak Jdec.string
        , Jdec.map UnionMapInKoryak (Jdec.dict (Jdec.nullable Jdec.int))
        ]

encodeKoryak : Koryak -> Jenc.Value
encodeKoryak x = case x of
    StringInKoryak y -> Jenc.string y
    UnionMapInKoryak y -> Jenc.dict identity (makeNullableEncoder Jenc.int) y

laviniaElement : Jdec.Decoder LaviniaElement
laviniaElement =
    Jdec.oneOf
        [ Jdec.map StringInLaviniaElement Jdec.string
        , Jdec.map LaviniaClassInLaviniaElement laviniaClass
        ]

encodeLaviniaElement : LaviniaElement -> Jenc.Value
encodeLaviniaElement x = case x of
    StringInLaviniaElement y -> Jenc.string y
    LaviniaClassInLaviniaElement y -> encodeLaviniaClass y

laviniaClass : Jdec.Decoder LaviniaClass
laviniaClass =
    Jdec.succeed LaviniaClass
        |> Jpipe.custom (optionalField "agitable" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "asininity" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "benefiter" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "bronzelike" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "catharticalness" (Jdec.map Just Jdec.float) Nothing)
        |> Jpipe.custom (optionalField "Chirotherium" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "cholesteatomatous" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "deprivement" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "disdiapason" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "flippantness" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "fogproof" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "homocerc" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "merrymeeting" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "nonbookish" (Jdec.nullable (Jdec.null ())) Nothing)
        |> Jpipe.custom (optionalField "overcareful" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "panaris" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "preacceptance" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "quinoxaline" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "sig" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "superconfusion" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "Tacana" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "tillotter" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "tranquillize" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "unquestionable" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "uproute" (Jdec.map Just Jdec.int) Nothing)

encodeLaviniaClass : LaviniaClass -> Jenc.Value
encodeLaviniaClass x =
    Jenc.object
        [ ("agitable", makeNullableEncoder Jenc.int x.agitable)
        , ("asininity", makeNullableEncoder Jenc.int x.asininity)
        , ("benefiter", makeNullableEncoder Jenc.int x.benefiter)
        , ("bronzelike", makeNullableEncoder Jenc.int x.bronzelike)
        , ("catharticalness", makeNullableEncoder Jenc.float x.catharticalness)
        , ("Chirotherium", makeNullableEncoder Jenc.int x.chirotherium)
        , ("cholesteatomatous", makeNullableEncoder Jenc.int x.cholesteatomatous)
        , ("deprivement", makeNullableEncoder Jenc.int x.deprivement)
        , ("disdiapason", makeNullableEncoder Jenc.string x.disdiapason)
        , ("flippantness", makeNullableEncoder Jenc.int x.flippantness)
        , ("fogproof", makeNullableEncoder Jenc.int x.fogproof)
        , ("homocerc", makeNullableEncoder Jenc.bool x.homocerc)
        , ("merrymeeting", makeNullableEncoder Jenc.int x.merrymeeting)
        , ("nonbookish", makeNullableEncoder (always Jenc.null) x.nonbookish)
        , ("overcareful", makeNullableEncoder Jenc.int x.overcareful)
        , ("panaris", makeNullableEncoder Jenc.int x.panaris)
        , ("preacceptance", makeNullableEncoder Jenc.int x.preacceptance)
        , ("quinoxaline", makeNullableEncoder Jenc.int x.quinoxaline)
        , ("sig", makeNullableEncoder Jenc.int x.sig)
        , ("superconfusion", makeNullableEncoder Jenc.int x.superconfusion)
        , ("Tacana", makeNullableEncoder Jenc.int x.tacana)
        , ("tillotter", makeNullableEncoder Jenc.int x.tillotter)
        , ("tranquillize", makeNullableEncoder Jenc.int x.tranquillize)
        , ("unquestionable", makeNullableEncoder Jenc.int x.unquestionable)
        , ("uproute", makeNullableEncoder Jenc.int x.uproute)
        ]

oskarElement : Jdec.Decoder OskarElement
oskarElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInOskarElement (Jdec.list Jdec.int )
        , Jdec.map OskarClassInOskarElement oskarClass
        ]

encodeOskarElement : OskarElement -> Jenc.Value
encodeOskarElement x = case x of
    IntegerArrayInOskarElement y -> Jenc.list Jenc.int y
    OskarClassInOskarElement y -> encodeOskarClass y

oskarClass : Jdec.Decoder OskarClass
oskarClass =
    Jdec.succeed OskarClass
        |> Jpipe.required "Acrobates" (Jdec.null ())
        |> Jpipe.required "beanshooter" (Jdec.null ())
        |> Jpipe.required "bearhound" (Jdec.null ())
        |> Jpipe.required "Cayuga" (Jdec.null ())
        |> Jpipe.required "guarneri" (Jdec.null ())
        |> Jpipe.required "hypochondriacism" (Jdec.null ())
        |> Jpipe.required "indication" (Jdec.null ())
        |> Jpipe.required "jaculative" (Jdec.null ())
        |> Jpipe.required "nagana" (Jdec.null ())
        |> Jpipe.required "Netherlandish" (Jdec.null ())
        |> Jpipe.required "noctivagous" (Jdec.null ())
        |> Jpipe.required "nonphysiological" (Jdec.null ())
        |> Jpipe.required "praxis" (Jdec.null ())
        |> Jpipe.required "provision" (Jdec.null ())
        |> Jpipe.required "subterhuman" (Jdec.null ())
        |> Jpipe.required "sunlit" (Jdec.null ())
        |> Jpipe.required "syncraniate" (Jdec.null ())
        |> Jpipe.required "teachment" (Jdec.null ())
        |> Jpipe.required "unmutinous" (Jdec.null ())
        |> Jpipe.required "unstoppable" (Jdec.null ())

encodeOskarClass : OskarClass -> Jenc.Value
encodeOskarClass x =
    Jenc.object
        [ ("Acrobates", always Jenc.null x.acrobates)
        , ("beanshooter", always Jenc.null x.beanshooter)
        , ("bearhound", always Jenc.null x.bearhound)
        , ("Cayuga", always Jenc.null x.cayuga)
        , ("guarneri", always Jenc.null x.guarneri)
        , ("hypochondriacism", always Jenc.null x.hypochondriacism)
        , ("indication", always Jenc.null x.indication)
        , ("jaculative", always Jenc.null x.jaculative)
        , ("nagana", always Jenc.null x.nagana)
        , ("Netherlandish", always Jenc.null x.netherlandish)
        , ("noctivagous", always Jenc.null x.noctivagous)
        , ("nonphysiological", always Jenc.null x.nonphysiological)
        , ("praxis", always Jenc.null x.praxis)
        , ("provision", always Jenc.null x.provision)
        , ("subterhuman", always Jenc.null x.subterhuman)
        , ("sunlit", always Jenc.null x.sunlit)
        , ("syncraniate", always Jenc.null x.syncraniate)
        , ("teachment", always Jenc.null x.teachment)
        , ("unmutinous", always Jenc.null x.unmutinous)
        , ("unstoppable", always Jenc.null x.unstoppable)
        ]

rebeccaElement : Jdec.Decoder RebeccaElement
rebeccaElement =
    Jdec.oneOf
        [ Jdec.map IntegerInRebeccaElement Jdec.int
        , Jdec.map StringInRebeccaElement Jdec.string
        , Jdec.map RebeccaInRebeccaElement rebecca
        ]

encodeRebeccaElement : RebeccaElement -> Jenc.Value
encodeRebeccaElement x = case x of
    IntegerInRebeccaElement y -> Jenc.int y
    StringInRebeccaElement y -> Jenc.string y
    RebeccaInRebeccaElement y -> encodeRebecca y

rhomboganoidei : Jdec.Decoder Rhomboganoidei
rhomboganoidei =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInRhomboganoidei (Jdec.list Jdec.int )
        , Jdec.map StringInRhomboganoidei Jdec.string
        , Jdec.map RebeccaInRhomboganoidei rebecca
        ]

encodeRhomboganoidei : Rhomboganoidei -> Jenc.Value
encodeRhomboganoidei x = case x of
    IntegerArrayInRhomboganoidei y -> Jenc.list Jenc.int y
    StringInRhomboganoidei y -> Jenc.string y
    RebeccaInRhomboganoidei y -> encodeRebecca y

ruellia : Jdec.Decoder Ruellia
ruellia =
    Jdec.oneOf
        [ Jdec.map BoolInRuellia Jdec.bool
        , Jdec.map StringInRuellia Jdec.string
        , Jdec.map RebeccaInRuellia rebecca
        ]

encodeRuellia : Ruellia -> Jenc.Value
encodeRuellia x = case x of
    BoolInRuellia y -> Jenc.bool y
    StringInRuellia y -> Jenc.string y
    RebeccaInRuellia y -> encodeRebecca y

school : Jdec.Decoder School
school =
    Jdec.oneOf
        [ Jdec.map IntegerInSchool Jdec.int
        , Jdec.null NullInSchool
        , Jdec.map IntegerMapInSchool (Jdec.dict Jdec.int)
        ]

encodeSchool : School -> Jenc.Value
encodeSchool x = case x of
    IntegerInSchool y -> Jenc.int y
    NullInSchool -> Jenc.null
    IntegerMapInSchool y -> Jenc.dict identity Jenc.int y

shakespearolater : Jdec.Decoder Shakespearolater
shakespearolater =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInShakespearolater (Jdec.list Jdec.int )
        , Jdec.map StringInShakespearolater Jdec.string
        , Jdec.map DoubleInShakespearolater Jdec.float
        ]

encodeShakespearolater : Shakespearolater -> Jenc.Value
encodeShakespearolater x = case x of
    IntegerArrayInShakespearolater y -> Jenc.list Jenc.int y
    StringInShakespearolater y -> Jenc.string y
    DoubleInShakespearolater y -> Jenc.float y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
