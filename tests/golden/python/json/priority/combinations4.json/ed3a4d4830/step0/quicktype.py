from dataclasses import dataclass
from typing import Any, Optional, Union, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class PulpitismClass:
    abnet: None
    buckhorn: None
    calciform: None
    chelophore: None
    cogitation: None
    decreeable: None
    despicable: None
    isodiazo: None
    jadedly: None
    leptochlorite: None
    nursling: None
    palamedean: None
    photoheliograph: None
    pipewood: None
    roberd: None
    statable: None
    superassume: None
    syllabe: None
    toughhead: None
    underburn: None

    @staticmethod
    def from_dict(obj: Any) -> 'PulpitismClass':
        assert isinstance(obj, dict)
        abnet = from_none(obj["abnet"])
        buckhorn = from_none(obj["buckhorn"])
        calciform = from_none(obj["calciform"])
        chelophore = from_none(obj["chelophore"])
        cogitation = from_none(obj["cogitation"])
        decreeable = from_none(obj["decreeable"])
        despicable = from_none(obj["despicable"])
        isodiazo = from_none(obj["isodiazo"])
        jadedly = from_none(obj["jadedly"])
        leptochlorite = from_none(obj["leptochlorite"])
        nursling = from_none(obj["nursling"])
        palamedean = from_none(obj["palamedean"])
        photoheliograph = from_none(obj["photoheliograph"])
        pipewood = from_none(obj["pipewood"])
        roberd = from_none(obj["roberd"])
        statable = from_none(obj["statable"])
        superassume = from_none(obj["superassume"])
        syllabe = from_none(obj["syllabe"])
        toughhead = from_none(obj["toughhead"])
        underburn = from_none(obj["underburn"])
        return PulpitismClass(abnet, buckhorn, calciform, chelophore, cogitation, decreeable, despicable, isodiazo, jadedly, leptochlorite, nursling, palamedean, photoheliograph, pipewood, roberd, statable, superassume, syllabe, toughhead, underburn)

    def to_dict(self) -> dict:
        result: dict = {}
        result["abnet"] = from_none(self.abnet)
        result["buckhorn"] = from_none(self.buckhorn)
        result["calciform"] = from_none(self.calciform)
        result["chelophore"] = from_none(self.chelophore)
        result["cogitation"] = from_none(self.cogitation)
        result["decreeable"] = from_none(self.decreeable)
        result["despicable"] = from_none(self.despicable)
        result["isodiazo"] = from_none(self.isodiazo)
        result["jadedly"] = from_none(self.jadedly)
        result["leptochlorite"] = from_none(self.leptochlorite)
        result["nursling"] = from_none(self.nursling)
        result["palamedean"] = from_none(self.palamedean)
        result["photoheliograph"] = from_none(self.photoheliograph)
        result["pipewood"] = from_none(self.pipewood)
        result["roberd"] = from_none(self.roberd)
        result["statable"] = from_none(self.statable)
        result["superassume"] = from_none(self.superassume)
        result["syllabe"] = from_none(self.syllabe)
        result["toughhead"] = from_none(self.toughhead)
        result["underburn"] = from_none(self.underburn)
        return result


@dataclass
class PyodermiaClass:
    gyppo: None
    aphoristically: None
    apophyllous: None
    cognize: None
    dermonosology: None
    ither: None
    juglandaceous: None
    litho: None
    macropterous: None
    photographer: None
    romancing: None
    rumness: None
    somniloquist: None
    stressfully: None
    tactically: None
    tracheophony: None
    unappositely: None
    unclothedly: None
    unimplied: None
    unsyncopated: None

    @staticmethod
    def from_dict(obj: Any) -> 'PyodermiaClass':
        assert isinstance(obj, dict)
        gyppo = from_none(obj["Gyppo"])
        aphoristically = from_none(obj["aphoristically"])
        apophyllous = from_none(obj["apophyllous"])
        cognize = from_none(obj["cognize"])
        dermonosology = from_none(obj["dermonosology"])
        ither = from_none(obj["ither"])
        juglandaceous = from_none(obj["juglandaceous"])
        litho = from_none(obj["litho"])
        macropterous = from_none(obj["macropterous"])
        photographer = from_none(obj["photographer"])
        romancing = from_none(obj["romancing"])
        rumness = from_none(obj["rumness"])
        somniloquist = from_none(obj["somniloquist"])
        stressfully = from_none(obj["stressfully"])
        tactically = from_none(obj["tactically"])
        tracheophony = from_none(obj["tracheophony"])
        unappositely = from_none(obj["unappositely"])
        unclothedly = from_none(obj["unclothedly"])
        unimplied = from_none(obj["unimplied"])
        unsyncopated = from_none(obj["unsyncopated"])
        return PyodermiaClass(gyppo, aphoristically, apophyllous, cognize, dermonosology, ither, juglandaceous, litho, macropterous, photographer, romancing, rumness, somniloquist, stressfully, tactically, tracheophony, unappositely, unclothedly, unimplied, unsyncopated)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Gyppo"] = from_none(self.gyppo)
        result["aphoristically"] = from_none(self.aphoristically)
        result["apophyllous"] = from_none(self.apophyllous)
        result["cognize"] = from_none(self.cognize)
        result["dermonosology"] = from_none(self.dermonosology)
        result["ither"] = from_none(self.ither)
        result["juglandaceous"] = from_none(self.juglandaceous)
        result["litho"] = from_none(self.litho)
        result["macropterous"] = from_none(self.macropterous)
        result["photographer"] = from_none(self.photographer)
        result["romancing"] = from_none(self.romancing)
        result["rumness"] = from_none(self.rumness)
        result["somniloquist"] = from_none(self.somniloquist)
        result["stressfully"] = from_none(self.stressfully)
        result["tactically"] = from_none(self.tactically)
        result["tracheophony"] = from_none(self.tracheophony)
        result["unappositely"] = from_none(self.unappositely)
        result["unclothedly"] = from_none(self.unclothedly)
        result["unimplied"] = from_none(self.unimplied)
        result["unsyncopated"] = from_none(self.unsyncopated)
        return result


@dataclass
class QuebrachineClass:
    chirotherium: int
    catharticalness: float
    disdiapason: str
    homocerc: bool
    nonbookish: None

    @staticmethod
    def from_dict(obj: Any) -> 'QuebrachineClass':
        assert isinstance(obj, dict)
        chirotherium = from_int(obj["Chirotherium"])
        catharticalness = from_float(obj["catharticalness"])
        disdiapason = from_str(obj["disdiapason"])
        homocerc = from_bool(obj["homocerc"])
        nonbookish = from_none(obj["nonbookish"])
        return QuebrachineClass(chirotherium, catharticalness, disdiapason, homocerc, nonbookish)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Chirotherium"] = from_int(self.chirotherium)
        result["catharticalness"] = to_float(self.catharticalness)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


@dataclass
class Reimagine:
    chirotherium: Optional[int]
    hermo: None
    adducible: None
    anabolin: None
    brainy: None
    catharticalness: Optional[float]
    chrysamine: None
    disdiapason: Optional[str]
    fluxweed: None
    glaucine: None
    grobianism: None
    hieroglyphist: None
    homocerc: Optional[bool]
    icteroid: None
    immortal: None
    impetulant: None
    irrigate: None
    myxedema: None
    nonbookish: None
    onyx: None
    repasser: None
    septomarginal: None
    subdie: None
    tibiometatarsal: None
    waltzlike: None

    @staticmethod
    def from_dict(obj: Any) -> 'Reimagine':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        hermo = from_none(obj.get("Hermo"))
        adducible = from_none(obj.get("adducible"))
        anabolin = from_none(obj.get("anabolin"))
        brainy = from_none(obj.get("brainy"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chrysamine = from_none(obj.get("chrysamine"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        fluxweed = from_none(obj.get("fluxweed"))
        glaucine = from_none(obj.get("glaucine"))
        grobianism = from_none(obj.get("grobianism"))
        hieroglyphist = from_none(obj.get("hieroglyphist"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        icteroid = from_none(obj.get("icteroid"))
        immortal = from_none(obj.get("immortal"))
        impetulant = from_none(obj.get("impetulant"))
        irrigate = from_none(obj.get("irrigate"))
        myxedema = from_none(obj.get("myxedema"))
        nonbookish = from_none(obj.get("nonbookish"))
        onyx = from_none(obj.get("onyx"))
        repasser = from_none(obj.get("repasser"))
        septomarginal = from_none(obj.get("septomarginal"))
        subdie = from_none(obj.get("subdie"))
        tibiometatarsal = from_none(obj.get("tibiometatarsal"))
        waltzlike = from_none(obj.get("waltzlike"))
        return Reimagine(chirotherium, hermo, adducible, anabolin, brainy, catharticalness, chrysamine, disdiapason, fluxweed, glaucine, grobianism, hieroglyphist, homocerc, icteroid, immortal, impetulant, irrigate, myxedema, nonbookish, onyx, repasser, septomarginal, subdie, tibiometatarsal, waltzlike)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.hermo is not None:
            result["Hermo"] = from_none(self.hermo)
        if self.adducible is not None:
            result["adducible"] = from_none(self.adducible)
        if self.anabolin is not None:
            result["anabolin"] = from_none(self.anabolin)
        if self.brainy is not None:
            result["brainy"] = from_none(self.brainy)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chrysamine is not None:
            result["chrysamine"] = from_none(self.chrysamine)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.fluxweed is not None:
            result["fluxweed"] = from_none(self.fluxweed)
        if self.glaucine is not None:
            result["glaucine"] = from_none(self.glaucine)
        if self.grobianism is not None:
            result["grobianism"] = from_none(self.grobianism)
        if self.hieroglyphist is not None:
            result["hieroglyphist"] = from_none(self.hieroglyphist)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.icteroid is not None:
            result["icteroid"] = from_none(self.icteroid)
        if self.immortal is not None:
            result["immortal"] = from_none(self.immortal)
        if self.impetulant is not None:
            result["impetulant"] = from_none(self.impetulant)
        if self.irrigate is not None:
            result["irrigate"] = from_none(self.irrigate)
        if self.myxedema is not None:
            result["myxedema"] = from_none(self.myxedema)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.onyx is not None:
            result["onyx"] = from_none(self.onyx)
        if self.repasser is not None:
            result["repasser"] = from_none(self.repasser)
        if self.septomarginal is not None:
            result["septomarginal"] = from_none(self.septomarginal)
        if self.subdie is not None:
            result["subdie"] = from_none(self.subdie)
        if self.tibiometatarsal is not None:
            result["tibiometatarsal"] = from_none(self.tibiometatarsal)
        if self.waltzlike is not None:
            result["waltzlike"] = from_none(self.waltzlike)
        return result


@dataclass
class Ressaut:
    freesia: str
    genevieve: str
    mimosaceae: str
    theopaschitism: str
    apperceptive: str
    cuttoo: str
    douser: str
    drinkproof: str
    forementioned: str
    hyperdiabolical: str
    hypocone: str
    irreverentially: str
    jumart: str
    mollicrush: str
    nedder: str
    retinasphalt: str
    sough: str
    steading: str
    undurableness: str
    unmingleable: str

    @staticmethod
    def from_dict(obj: Any) -> 'Ressaut':
        assert isinstance(obj, dict)
        freesia = from_str(obj["Freesia"])
        genevieve = from_str(obj["Genevieve"])
        mimosaceae = from_str(obj["Mimosaceae"])
        theopaschitism = from_str(obj["Theopaschitism"])
        apperceptive = from_str(obj["apperceptive"])
        cuttoo = from_str(obj["cuttoo"])
        douser = from_str(obj["douser"])
        drinkproof = from_str(obj["drinkproof"])
        forementioned = from_str(obj["forementioned"])
        hyperdiabolical = from_str(obj["hyperdiabolical"])
        hypocone = from_str(obj["hypocone"])
        irreverentially = from_str(obj["irreverentially"])
        jumart = from_str(obj["jumart"])
        mollicrush = from_str(obj["mollicrush"])
        nedder = from_str(obj["nedder"])
        retinasphalt = from_str(obj["retinasphalt"])
        sough = from_str(obj["sough"])
        steading = from_str(obj["steading"])
        undurableness = from_str(obj["undurableness"])
        unmingleable = from_str(obj["unmingleable"])
        return Ressaut(freesia, genevieve, mimosaceae, theopaschitism, apperceptive, cuttoo, douser, drinkproof, forementioned, hyperdiabolical, hypocone, irreverentially, jumart, mollicrush, nedder, retinasphalt, sough, steading, undurableness, unmingleable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Freesia"] = from_str(self.freesia)
        result["Genevieve"] = from_str(self.genevieve)
        result["Mimosaceae"] = from_str(self.mimosaceae)
        result["Theopaschitism"] = from_str(self.theopaschitism)
        result["apperceptive"] = from_str(self.apperceptive)
        result["cuttoo"] = from_str(self.cuttoo)
        result["douser"] = from_str(self.douser)
        result["drinkproof"] = from_str(self.drinkproof)
        result["forementioned"] = from_str(self.forementioned)
        result["hyperdiabolical"] = from_str(self.hyperdiabolical)
        result["hypocone"] = from_str(self.hypocone)
        result["irreverentially"] = from_str(self.irreverentially)
        result["jumart"] = from_str(self.jumart)
        result["mollicrush"] = from_str(self.mollicrush)
        result["nedder"] = from_str(self.nedder)
        result["retinasphalt"] = from_str(self.retinasphalt)
        result["sough"] = from_str(self.sough)
        result["steading"] = from_str(self.steading)
        result["undurableness"] = from_str(self.undurableness)
        result["unmingleable"] = from_str(self.unmingleable)
        return result


@dataclass
class RewriteClass:
    hyades: None
    ptenoglossa: None
    whiggification: None
    accountancy: None
    cacotrophic: None
    contest: None
    couthily: None
    falculate: None
    foreseize: None
    lemnad: None
    monotheistically: None
    nonflying: None
    repatch: None
    rodman: None
    strung: None
    titmal: None
    twalpennyworth: None
    unblamable: None
    vertical: None
    yardman: None

    @staticmethod
    def from_dict(obj: Any) -> 'RewriteClass':
        assert isinstance(obj, dict)
        hyades = from_none(obj["Hyades"])
        ptenoglossa = from_none(obj["Ptenoglossa"])
        whiggification = from_none(obj["Whiggification"])
        accountancy = from_none(obj["accountancy"])
        cacotrophic = from_none(obj["cacotrophic"])
        contest = from_none(obj["contest"])
        couthily = from_none(obj["couthily"])
        falculate = from_none(obj["falculate"])
        foreseize = from_none(obj["foreseize"])
        lemnad = from_none(obj["lemnad"])
        monotheistically = from_none(obj["monotheistically"])
        nonflying = from_none(obj["nonflying"])
        repatch = from_none(obj["repatch"])
        rodman = from_none(obj["rodman"])
        strung = from_none(obj["strung"])
        titmal = from_none(obj["titmal"])
        twalpennyworth = from_none(obj["twalpennyworth"])
        unblamable = from_none(obj["unblamable"])
        vertical = from_none(obj["vertical"])
        yardman = from_none(obj["yardman"])
        return RewriteClass(hyades, ptenoglossa, whiggification, accountancy, cacotrophic, contest, couthily, falculate, foreseize, lemnad, monotheistically, nonflying, repatch, rodman, strung, titmal, twalpennyworth, unblamable, vertical, yardman)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hyades"] = from_none(self.hyades)
        result["Ptenoglossa"] = from_none(self.ptenoglossa)
        result["Whiggification"] = from_none(self.whiggification)
        result["accountancy"] = from_none(self.accountancy)
        result["cacotrophic"] = from_none(self.cacotrophic)
        result["contest"] = from_none(self.contest)
        result["couthily"] = from_none(self.couthily)
        result["falculate"] = from_none(self.falculate)
        result["foreseize"] = from_none(self.foreseize)
        result["lemnad"] = from_none(self.lemnad)
        result["monotheistically"] = from_none(self.monotheistically)
        result["nonflying"] = from_none(self.nonflying)
        result["repatch"] = from_none(self.repatch)
        result["rodman"] = from_none(self.rodman)
        result["strung"] = from_none(self.strung)
        result["titmal"] = from_none(self.titmal)
        result["twalpennyworth"] = from_none(self.twalpennyworth)
        result["unblamable"] = from_none(self.unblamable)
        result["vertical"] = from_none(self.vertical)
        result["yardman"] = from_none(self.yardman)
        return result


@dataclass
class SantirClass:
    suessiones: None
    admiredly: None
    demicaponier: None
    epitympanic: None
    investitor: None
    lupiform: None
    monoflagellate: None
    paleoethnic: None
    prediscountable: None
    rhetoricals: None
    roomth: None
    saccharose: None
    septonasal: None
    serpenticide: None
    setarious: None
    spaework: None
    stylite: None
    timelily: None
    unprofaned: None
    vorticular: None

    @staticmethod
    def from_dict(obj: Any) -> 'SantirClass':
        assert isinstance(obj, dict)
        suessiones = from_none(obj["Suessiones"])
        admiredly = from_none(obj["admiredly"])
        demicaponier = from_none(obj["demicaponier"])
        epitympanic = from_none(obj["epitympanic"])
        investitor = from_none(obj["investitor"])
        lupiform = from_none(obj["lupiform"])
        monoflagellate = from_none(obj["monoflagellate"])
        paleoethnic = from_none(obj["paleoethnic"])
        prediscountable = from_none(obj["prediscountable"])
        rhetoricals = from_none(obj["rhetoricals"])
        roomth = from_none(obj["roomth"])
        saccharose = from_none(obj["saccharose"])
        septonasal = from_none(obj["septonasal"])
        serpenticide = from_none(obj["serpenticide"])
        setarious = from_none(obj["setarious"])
        spaework = from_none(obj["spaework"])
        stylite = from_none(obj["stylite"])
        timelily = from_none(obj["timelily"])
        unprofaned = from_none(obj["unprofaned"])
        vorticular = from_none(obj["vorticular"])
        return SantirClass(suessiones, admiredly, demicaponier, epitympanic, investitor, lupiform, monoflagellate, paleoethnic, prediscountable, rhetoricals, roomth, saccharose, septonasal, serpenticide, setarious, spaework, stylite, timelily, unprofaned, vorticular)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Suessiones"] = from_none(self.suessiones)
        result["admiredly"] = from_none(self.admiredly)
        result["demicaponier"] = from_none(self.demicaponier)
        result["epitympanic"] = from_none(self.epitympanic)
        result["investitor"] = from_none(self.investitor)
        result["lupiform"] = from_none(self.lupiform)
        result["monoflagellate"] = from_none(self.monoflagellate)
        result["paleoethnic"] = from_none(self.paleoethnic)
        result["prediscountable"] = from_none(self.prediscountable)
        result["rhetoricals"] = from_none(self.rhetoricals)
        result["roomth"] = from_none(self.roomth)
        result["saccharose"] = from_none(self.saccharose)
        result["septonasal"] = from_none(self.septonasal)
        result["serpenticide"] = from_none(self.serpenticide)
        result["setarious"] = from_none(self.setarious)
        result["spaework"] = from_none(self.spaework)
        result["stylite"] = from_none(self.stylite)
        result["timelily"] = from_none(self.timelily)
        result["unprofaned"] = from_none(self.unprofaned)
        result["vorticular"] = from_none(self.vorticular)
        return result


@dataclass
class SaxtenClass:
    centaurid: None
    chirotherium: Optional[int]
    algarrobilla: None
    bowgrace: None
    catharticalness: Optional[float]
    disdiapason: Optional[str]
    flix: None
    germanely: None
    homocerc: Optional[bool]
    inhume: None
    lepidote: None
    megalochirous: None
    ninepenny: None
    nonbookish: None
    nondeist: None
    nymphaeaceous: None
    parietofrontal: None
    sancyite: None
    subjectivist: None
    tibiad: None
    transonic: None
    tripetalous: None
    trunchman: None
    urger: None
    withdrawnness: None

    @staticmethod
    def from_dict(obj: Any) -> 'SaxtenClass':
        assert isinstance(obj, dict)
        centaurid = from_none(obj.get("Centaurid"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        algarrobilla = from_none(obj.get("algarrobilla"))
        bowgrace = from_none(obj.get("bowgrace"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        flix = from_none(obj.get("flix"))
        germanely = from_none(obj.get("germanely"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        inhume = from_none(obj.get("inhume"))
        lepidote = from_none(obj.get("lepidote"))
        megalochirous = from_none(obj.get("megalochirous"))
        ninepenny = from_none(obj.get("ninepenny"))
        nonbookish = from_none(obj.get("nonbookish"))
        nondeist = from_none(obj.get("nondeist"))
        nymphaeaceous = from_none(obj.get("nymphaeaceous"))
        parietofrontal = from_none(obj.get("parietofrontal"))
        sancyite = from_none(obj.get("sancyite"))
        subjectivist = from_none(obj.get("subjectivist"))
        tibiad = from_none(obj.get("tibiad"))
        transonic = from_none(obj.get("transonic"))
        tripetalous = from_none(obj.get("tripetalous"))
        trunchman = from_none(obj.get("trunchman"))
        urger = from_none(obj.get("urger"))
        withdrawnness = from_none(obj.get("withdrawnness"))
        return SaxtenClass(centaurid, chirotherium, algarrobilla, bowgrace, catharticalness, disdiapason, flix, germanely, homocerc, inhume, lepidote, megalochirous, ninepenny, nonbookish, nondeist, nymphaeaceous, parietofrontal, sancyite, subjectivist, tibiad, transonic, tripetalous, trunchman, urger, withdrawnness)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.centaurid is not None:
            result["Centaurid"] = from_none(self.centaurid)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.algarrobilla is not None:
            result["algarrobilla"] = from_none(self.algarrobilla)
        if self.bowgrace is not None:
            result["bowgrace"] = from_none(self.bowgrace)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.flix is not None:
            result["flix"] = from_none(self.flix)
        if self.germanely is not None:
            result["germanely"] = from_none(self.germanely)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.inhume is not None:
            result["inhume"] = from_none(self.inhume)
        if self.lepidote is not None:
            result["lepidote"] = from_none(self.lepidote)
        if self.megalochirous is not None:
            result["megalochirous"] = from_none(self.megalochirous)
        if self.ninepenny is not None:
            result["ninepenny"] = from_none(self.ninepenny)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.nondeist is not None:
            result["nondeist"] = from_none(self.nondeist)
        if self.nymphaeaceous is not None:
            result["nymphaeaceous"] = from_none(self.nymphaeaceous)
        if self.parietofrontal is not None:
            result["parietofrontal"] = from_none(self.parietofrontal)
        if self.sancyite is not None:
            result["sancyite"] = from_none(self.sancyite)
        if self.subjectivist is not None:
            result["subjectivist"] = from_none(self.subjectivist)
        if self.tibiad is not None:
            result["tibiad"] = from_none(self.tibiad)
        if self.transonic is not None:
            result["transonic"] = from_none(self.transonic)
        if self.tripetalous is not None:
            result["tripetalous"] = from_none(self.tripetalous)
        if self.trunchman is not None:
            result["trunchman"] = from_none(self.trunchman)
        if self.urger is not None:
            result["urger"] = from_none(self.urger)
        if self.withdrawnness is not None:
            result["withdrawnness"] = from_none(self.withdrawnness)
        return result


@dataclass
class Scatty:
    tabasco: None
    aeriferous: None
    antical: None
    antighostism: None
    arcanum: None
    autotrophy: None
    baronial: None
    caffeine: None
    gorgoniacean: None
    heroical: None
    hydropical: None
    mechanology: None
    musicopoetic: None
    officiality: None
    oftentimes: None
    ophthalmotonometer: None
    reflectively: None
    springer: None
    teleianthous: None
    uncombated: None

    @staticmethod
    def from_dict(obj: Any) -> 'Scatty':
        assert isinstance(obj, dict)
        tabasco = from_none(obj["Tabasco"])
        aeriferous = from_none(obj["aeriferous"])
        antical = from_none(obj["antical"])
        antighostism = from_none(obj["antighostism"])
        arcanum = from_none(obj["arcanum"])
        autotrophy = from_none(obj["autotrophy"])
        baronial = from_none(obj["baronial"])
        caffeine = from_none(obj["caffeine"])
        gorgoniacean = from_none(obj["gorgoniacean"])
        heroical = from_none(obj["heroical"])
        hydropical = from_none(obj["hydropical"])
        mechanology = from_none(obj["mechanology"])
        musicopoetic = from_none(obj["musicopoetic"])
        officiality = from_none(obj["officiality"])
        oftentimes = from_none(obj["oftentimes"])
        ophthalmotonometer = from_none(obj["ophthalmotonometer"])
        reflectively = from_none(obj["reflectively"])
        springer = from_none(obj["springer"])
        teleianthous = from_none(obj["teleianthous"])
        uncombated = from_none(obj["uncombated"])
        return Scatty(tabasco, aeriferous, antical, antighostism, arcanum, autotrophy, baronial, caffeine, gorgoniacean, heroical, hydropical, mechanology, musicopoetic, officiality, oftentimes, ophthalmotonometer, reflectively, springer, teleianthous, uncombated)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Tabasco"] = from_none(self.tabasco)
        result["aeriferous"] = from_none(self.aeriferous)
        result["antical"] = from_none(self.antical)
        result["antighostism"] = from_none(self.antighostism)
        result["arcanum"] = from_none(self.arcanum)
        result["autotrophy"] = from_none(self.autotrophy)
        result["baronial"] = from_none(self.baronial)
        result["caffeine"] = from_none(self.caffeine)
        result["gorgoniacean"] = from_none(self.gorgoniacean)
        result["heroical"] = from_none(self.heroical)
        result["hydropical"] = from_none(self.hydropical)
        result["mechanology"] = from_none(self.mechanology)
        result["musicopoetic"] = from_none(self.musicopoetic)
        result["officiality"] = from_none(self.officiality)
        result["oftentimes"] = from_none(self.oftentimes)
        result["ophthalmotonometer"] = from_none(self.ophthalmotonometer)
        result["reflectively"] = from_none(self.reflectively)
        result["springer"] = from_none(self.springer)
        result["teleianthous"] = from_none(self.teleianthous)
        result["uncombated"] = from_none(self.uncombated)
        return result


@dataclass
class SisteringClass:
    chianti: None
    haplomi: None
    micropterygidae: None
    amphicarpic: None
    frigorific: None
    hyperkinesis: None
    laudable: None
    madwoman: None
    maimedly: None
    microrhabdus: None
    nondense: None
    phlebemphraxis: None
    redsear: None
    schismatical: None
    tartryl: None
    unabhorred: None
    undeliberateness: None
    unmixable: None
    untruckling: None
    vineal: None

    @staticmethod
    def from_dict(obj: Any) -> 'SisteringClass':
        assert isinstance(obj, dict)
        chianti = from_none(obj["Chianti"])
        haplomi = from_none(obj["Haplomi"])
        micropterygidae = from_none(obj["Micropterygidae"])
        amphicarpic = from_none(obj["amphicarpic"])
        frigorific = from_none(obj["frigorific"])
        hyperkinesis = from_none(obj["hyperkinesis"])
        laudable = from_none(obj["laudable"])
        madwoman = from_none(obj["madwoman"])
        maimedly = from_none(obj["maimedly"])
        microrhabdus = from_none(obj["microrhabdus"])
        nondense = from_none(obj["nondense"])
        phlebemphraxis = from_none(obj["phlebemphraxis"])
        redsear = from_none(obj["redsear"])
        schismatical = from_none(obj["schismatical"])
        tartryl = from_none(obj["tartryl"])
        unabhorred = from_none(obj["unabhorred"])
        undeliberateness = from_none(obj["undeliberateness"])
        unmixable = from_none(obj["unmixable"])
        untruckling = from_none(obj["untruckling"])
        vineal = from_none(obj["vineal"])
        return SisteringClass(chianti, haplomi, micropterygidae, amphicarpic, frigorific, hyperkinesis, laudable, madwoman, maimedly, microrhabdus, nondense, phlebemphraxis, redsear, schismatical, tartryl, unabhorred, undeliberateness, unmixable, untruckling, vineal)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Chianti"] = from_none(self.chianti)
        result["Haplomi"] = from_none(self.haplomi)
        result["Micropterygidae"] = from_none(self.micropterygidae)
        result["amphicarpic"] = from_none(self.amphicarpic)
        result["frigorific"] = from_none(self.frigorific)
        result["hyperkinesis"] = from_none(self.hyperkinesis)
        result["laudable"] = from_none(self.laudable)
        result["madwoman"] = from_none(self.madwoman)
        result["maimedly"] = from_none(self.maimedly)
        result["microrhabdus"] = from_none(self.microrhabdus)
        result["nondense"] = from_none(self.nondense)
        result["phlebemphraxis"] = from_none(self.phlebemphraxis)
        result["redsear"] = from_none(self.redsear)
        result["schismatical"] = from_none(self.schismatical)
        result["tartryl"] = from_none(self.tartryl)
        result["unabhorred"] = from_none(self.unabhorred)
        result["undeliberateness"] = from_none(self.undeliberateness)
        result["unmixable"] = from_none(self.unmixable)
        result["untruckling"] = from_none(self.untruckling)
        result["vineal"] = from_none(self.vineal)
        return result


@dataclass
class Staghunting:
    chirotherium: Optional[int]
    calorimetric: Optional[int]
    canid: Optional[int]
    catharticalness: Optional[float]
    disdiapason: Optional[str]
    ditriglyphic: Optional[int]
    floriferousness: Optional[int]
    gamelike: Optional[int]
    grig: Optional[int]
    homocerc: Optional[bool]
    interloan: Optional[int]
    lithotomy: Optional[int]
    loric: Optional[int]
    membranocoriaceous: Optional[int]
    membranogenic: Optional[int]
    nonbookish: None
    overtrump: Optional[int]
    scotino: Optional[int]
    seasonable: Optional[int]
    sephen: Optional[int]
    stigmarioid: Optional[int]
    tired: Optional[int]
    trifid: Optional[int]
    undefeatedly: Optional[int]
    ungirlish: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'Staghunting':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        calorimetric = from_union([from_int, from_none], obj.get("calorimetric"))
        canid = from_union([from_int, from_none], obj.get("canid"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ditriglyphic = from_union([from_int, from_none], obj.get("ditriglyphic"))
        floriferousness = from_union([from_int, from_none], obj.get("floriferousness"))
        gamelike = from_union([from_int, from_none], obj.get("gamelike"))
        grig = from_union([from_int, from_none], obj.get("grig"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        interloan = from_union([from_int, from_none], obj.get("interloan"))
        lithotomy = from_union([from_int, from_none], obj.get("lithotomy"))
        loric = from_union([from_int, from_none], obj.get("loric"))
        membranocoriaceous = from_union([from_int, from_none], obj.get("membranocoriaceous"))
        membranogenic = from_union([from_int, from_none], obj.get("membranogenic"))
        nonbookish = from_none(obj.get("nonbookish"))
        overtrump = from_union([from_int, from_none], obj.get("overtrump"))
        scotino = from_union([from_int, from_none], obj.get("scotino"))
        seasonable = from_union([from_int, from_none], obj.get("seasonable"))
        sephen = from_union([from_int, from_none], obj.get("sephen"))
        stigmarioid = from_union([from_int, from_none], obj.get("stigmarioid"))
        tired = from_union([from_int, from_none], obj.get("tired"))
        trifid = from_union([from_int, from_none], obj.get("trifid"))
        undefeatedly = from_union([from_int, from_none], obj.get("undefeatedly"))
        ungirlish = from_union([from_int, from_none], obj.get("ungirlish"))
        return Staghunting(chirotherium, calorimetric, canid, catharticalness, disdiapason, ditriglyphic, floriferousness, gamelike, grig, homocerc, interloan, lithotomy, loric, membranocoriaceous, membranogenic, nonbookish, overtrump, scotino, seasonable, sephen, stigmarioid, tired, trifid, undefeatedly, ungirlish)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.calorimetric is not None:
            result["calorimetric"] = from_union([from_int, from_none], self.calorimetric)
        if self.canid is not None:
            result["canid"] = from_union([from_int, from_none], self.canid)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.ditriglyphic is not None:
            result["ditriglyphic"] = from_union([from_int, from_none], self.ditriglyphic)
        if self.floriferousness is not None:
            result["floriferousness"] = from_union([from_int, from_none], self.floriferousness)
        if self.gamelike is not None:
            result["gamelike"] = from_union([from_int, from_none], self.gamelike)
        if self.grig is not None:
            result["grig"] = from_union([from_int, from_none], self.grig)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.interloan is not None:
            result["interloan"] = from_union([from_int, from_none], self.interloan)
        if self.lithotomy is not None:
            result["lithotomy"] = from_union([from_int, from_none], self.lithotomy)
        if self.loric is not None:
            result["loric"] = from_union([from_int, from_none], self.loric)
        if self.membranocoriaceous is not None:
            result["membranocoriaceous"] = from_union([from_int, from_none], self.membranocoriaceous)
        if self.membranogenic is not None:
            result["membranogenic"] = from_union([from_int, from_none], self.membranogenic)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.overtrump is not None:
            result["overtrump"] = from_union([from_int, from_none], self.overtrump)
        if self.scotino is not None:
            result["scotino"] = from_union([from_int, from_none], self.scotino)
        if self.seasonable is not None:
            result["seasonable"] = from_union([from_int, from_none], self.seasonable)
        if self.sephen is not None:
            result["sephen"] = from_union([from_int, from_none], self.sephen)
        if self.stigmarioid is not None:
            result["stigmarioid"] = from_union([from_int, from_none], self.stigmarioid)
        if self.tired is not None:
            result["tired"] = from_union([from_int, from_none], self.tired)
        if self.trifid is not None:
            result["trifid"] = from_union([from_int, from_none], self.trifid)
        if self.undefeatedly is not None:
            result["undefeatedly"] = from_union([from_int, from_none], self.undefeatedly)
        if self.ungirlish is not None:
            result["ungirlish"] = from_union([from_int, from_none], self.ungirlish)
        return result


@dataclass
class StrenuosityClass:
    chirotherium: Optional[int]
    onopordon: Optional[int]
    sodomite: Optional[int]
    yankeeist: Optional[int]
    bliss: Optional[int]
    buccate: Optional[int]
    bulletproof: Optional[int]
    catharticalness: Optional[float]
    crumblingness: Optional[int]
    disdiapason: Optional[str]
    engagedly: Optional[int]
    fightable: Optional[int]
    hoariness: Optional[int]
    homocerc: Optional[bool]
    hypopodium: Optional[int]
    luxurist: Optional[int]
    mechanician: Optional[int]
    nonbookish: None
    podgily: Optional[int]
    reformableness: Optional[int]
    scatterbrains: Optional[int]
    seminuria: Optional[int]
    tramp: Optional[int]
    undueness: Optional[int]
    worthily: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'StrenuosityClass':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        onopordon = from_union([from_int, from_none], obj.get("Onopordon"))
        sodomite = from_union([from_int, from_none], obj.get("Sodomite"))
        yankeeist = from_union([from_int, from_none], obj.get("Yankeeist"))
        bliss = from_union([from_int, from_none], obj.get("bliss"))
        buccate = from_union([from_int, from_none], obj.get("buccate"))
        bulletproof = from_union([from_int, from_none], obj.get("bulletproof"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        crumblingness = from_union([from_int, from_none], obj.get("crumblingness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        engagedly = from_union([from_int, from_none], obj.get("engagedly"))
        fightable = from_union([from_int, from_none], obj.get("fightable"))
        hoariness = from_union([from_int, from_none], obj.get("hoariness"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        hypopodium = from_union([from_int, from_none], obj.get("hypopodium"))
        luxurist = from_union([from_int, from_none], obj.get("luxurist"))
        mechanician = from_union([from_int, from_none], obj.get("mechanician"))
        nonbookish = from_none(obj.get("nonbookish"))
        podgily = from_union([from_int, from_none], obj.get("podgily"))
        reformableness = from_union([from_int, from_none], obj.get("reformableness"))
        scatterbrains = from_union([from_int, from_none], obj.get("scatterbrains"))
        seminuria = from_union([from_int, from_none], obj.get("seminuria"))
        tramp = from_union([from_int, from_none], obj.get("tramp"))
        undueness = from_union([from_int, from_none], obj.get("undueness"))
        worthily = from_union([from_int, from_none], obj.get("worthily"))
        return StrenuosityClass(chirotherium, onopordon, sodomite, yankeeist, bliss, buccate, bulletproof, catharticalness, crumblingness, disdiapason, engagedly, fightable, hoariness, homocerc, hypopodium, luxurist, mechanician, nonbookish, podgily, reformableness, scatterbrains, seminuria, tramp, undueness, worthily)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.onopordon is not None:
            result["Onopordon"] = from_union([from_int, from_none], self.onopordon)
        if self.sodomite is not None:
            result["Sodomite"] = from_union([from_int, from_none], self.sodomite)
        if self.yankeeist is not None:
            result["Yankeeist"] = from_union([from_int, from_none], self.yankeeist)
        if self.bliss is not None:
            result["bliss"] = from_union([from_int, from_none], self.bliss)
        if self.buccate is not None:
            result["buccate"] = from_union([from_int, from_none], self.buccate)
        if self.bulletproof is not None:
            result["bulletproof"] = from_union([from_int, from_none], self.bulletproof)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.crumblingness is not None:
            result["crumblingness"] = from_union([from_int, from_none], self.crumblingness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.engagedly is not None:
            result["engagedly"] = from_union([from_int, from_none], self.engagedly)
        if self.fightable is not None:
            result["fightable"] = from_union([from_int, from_none], self.fightable)
        if self.hoariness is not None:
            result["hoariness"] = from_union([from_int, from_none], self.hoariness)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.hypopodium is not None:
            result["hypopodium"] = from_union([from_int, from_none], self.hypopodium)
        if self.luxurist is not None:
            result["luxurist"] = from_union([from_int, from_none], self.luxurist)
        if self.mechanician is not None:
            result["mechanician"] = from_union([from_int, from_none], self.mechanician)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.podgily is not None:
            result["podgily"] = from_union([from_int, from_none], self.podgily)
        if self.reformableness is not None:
            result["reformableness"] = from_union([from_int, from_none], self.reformableness)
        if self.scatterbrains is not None:
            result["scatterbrains"] = from_union([from_int, from_none], self.scatterbrains)
        if self.seminuria is not None:
            result["seminuria"] = from_union([from_int, from_none], self.seminuria)
        if self.tramp is not None:
            result["tramp"] = from_union([from_int, from_none], self.tramp)
        if self.undueness is not None:
            result["undueness"] = from_union([from_int, from_none], self.undueness)
        if self.worthily is not None:
            result["worthily"] = from_union([from_int, from_none], self.worthily)
        return result


@dataclass
class TruantcyClass:
    chirotherium: Optional[int]
    epeira: None
    eurylaimi: None
    yuman: None
    alfiona: None
    ascaridiasis: None
    bungey: None
    catharticalness: Optional[float]
    ceroxyle: None
    chorology: None
    disdiapason: Optional[str]
    enmarble: None
    germination: None
    hallelujah: None
    homocerc: Optional[bool]
    lev: None
    mouthing: None
    nonbookish: None
    philliloo: None
    planetal: None
    poney: None
    punctualist: None
    returnlessly: None
    skelder: None
    windwaywardly: None

    @staticmethod
    def from_dict(obj: Any) -> 'TruantcyClass':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        epeira = from_none(obj.get("Epeira"))
        eurylaimi = from_none(obj.get("Eurylaimi"))
        yuman = from_none(obj.get("Yuman"))
        alfiona = from_none(obj.get("alfiona"))
        ascaridiasis = from_none(obj.get("ascaridiasis"))
        bungey = from_none(obj.get("bungey"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        ceroxyle = from_none(obj.get("ceroxyle"))
        chorology = from_none(obj.get("chorology"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        enmarble = from_none(obj.get("enmarble"))
        germination = from_none(obj.get("germination"))
        hallelujah = from_none(obj.get("hallelujah"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        lev = from_none(obj.get("lev"))
        mouthing = from_none(obj.get("mouthing"))
        nonbookish = from_none(obj.get("nonbookish"))
        philliloo = from_none(obj.get("philliloo"))
        planetal = from_none(obj.get("planetal"))
        poney = from_none(obj.get("poney"))
        punctualist = from_none(obj.get("punctualist"))
        returnlessly = from_none(obj.get("returnlessly"))
        skelder = from_none(obj.get("skelder"))
        windwaywardly = from_none(obj.get("windwaywardly"))
        return TruantcyClass(chirotherium, epeira, eurylaimi, yuman, alfiona, ascaridiasis, bungey, catharticalness, ceroxyle, chorology, disdiapason, enmarble, germination, hallelujah, homocerc, lev, mouthing, nonbookish, philliloo, planetal, poney, punctualist, returnlessly, skelder, windwaywardly)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.epeira is not None:
            result["Epeira"] = from_none(self.epeira)
        if self.eurylaimi is not None:
            result["Eurylaimi"] = from_none(self.eurylaimi)
        if self.yuman is not None:
            result["Yuman"] = from_none(self.yuman)
        if self.alfiona is not None:
            result["alfiona"] = from_none(self.alfiona)
        if self.ascaridiasis is not None:
            result["ascaridiasis"] = from_none(self.ascaridiasis)
        if self.bungey is not None:
            result["bungey"] = from_none(self.bungey)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.ceroxyle is not None:
            result["ceroxyle"] = from_none(self.ceroxyle)
        if self.chorology is not None:
            result["chorology"] = from_none(self.chorology)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.enmarble is not None:
            result["enmarble"] = from_none(self.enmarble)
        if self.germination is not None:
            result["germination"] = from_none(self.germination)
        if self.hallelujah is not None:
            result["hallelujah"] = from_none(self.hallelujah)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.lev is not None:
            result["lev"] = from_none(self.lev)
        if self.mouthing is not None:
            result["mouthing"] = from_none(self.mouthing)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.philliloo is not None:
            result["philliloo"] = from_none(self.philliloo)
        if self.planetal is not None:
            result["planetal"] = from_none(self.planetal)
        if self.poney is not None:
            result["poney"] = from_none(self.poney)
        if self.punctualist is not None:
            result["punctualist"] = from_none(self.punctualist)
        if self.returnlessly is not None:
            result["returnlessly"] = from_none(self.returnlessly)
        if self.skelder is not None:
            result["skelder"] = from_none(self.skelder)
        if self.windwaywardly is not None:
            result["windwaywardly"] = from_none(self.windwaywardly)
        return result


@dataclass
class UnimpeachablyClass:
    bobadil: Optional[int]
    chirotherium: Optional[int]
    quiina: Optional[int]
    robert: Optional[int]
    acerin: Optional[int]
    catharticalness: Optional[float]
    chlorophylligenous: Optional[int]
    conversational: Optional[int]
    demiowl: Optional[int]
    disdiapason: Optional[str]
    ectorhinal: Optional[int]
    gamblesomeness: Optional[int]
    homocerc: Optional[bool]
    irrorate: Optional[int]
    kindergartening: Optional[int]
    lateritic: Optional[int]
    mespil: Optional[int]
    misconfiguration: Optional[int]
    nonbookish: None
    planometry: Optional[int]
    rot: Optional[int]
    subcinctorium: Optional[int]
    tussocker: Optional[int]
    ultraproud: Optional[int]
    unsuggestedness: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'UnimpeachablyClass':
        assert isinstance(obj, dict)
        bobadil = from_union([from_int, from_none], obj.get("Bobadil"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        quiina = from_union([from_int, from_none], obj.get("Quiina"))
        robert = from_union([from_int, from_none], obj.get("Robert"))
        acerin = from_union([from_int, from_none], obj.get("acerin"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chlorophylligenous = from_union([from_int, from_none], obj.get("chlorophylligenous"))
        conversational = from_union([from_int, from_none], obj.get("conversational"))
        demiowl = from_union([from_int, from_none], obj.get("demiowl"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ectorhinal = from_union([from_int, from_none], obj.get("ectorhinal"))
        gamblesomeness = from_union([from_int, from_none], obj.get("gamblesomeness"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        irrorate = from_union([from_int, from_none], obj.get("irrorate"))
        kindergartening = from_union([from_int, from_none], obj.get("kindergartening"))
        lateritic = from_union([from_int, from_none], obj.get("lateritic"))
        mespil = from_union([from_int, from_none], obj.get("mespil"))
        misconfiguration = from_union([from_int, from_none], obj.get("misconfiguration"))
        nonbookish = from_none(obj.get("nonbookish"))
        planometry = from_union([from_int, from_none], obj.get("planometry"))
        rot = from_union([from_int, from_none], obj.get("rot"))
        subcinctorium = from_union([from_int, from_none], obj.get("subcinctorium"))
        tussocker = from_union([from_int, from_none], obj.get("tussocker"))
        ultraproud = from_union([from_int, from_none], obj.get("ultraproud"))
        unsuggestedness = from_union([from_int, from_none], obj.get("unsuggestedness"))
        return UnimpeachablyClass(bobadil, chirotherium, quiina, robert, acerin, catharticalness, chlorophylligenous, conversational, demiowl, disdiapason, ectorhinal, gamblesomeness, homocerc, irrorate, kindergartening, lateritic, mespil, misconfiguration, nonbookish, planometry, rot, subcinctorium, tussocker, ultraproud, unsuggestedness)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bobadil is not None:
            result["Bobadil"] = from_union([from_int, from_none], self.bobadil)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.quiina is not None:
            result["Quiina"] = from_union([from_int, from_none], self.quiina)
        if self.robert is not None:
            result["Robert"] = from_union([from_int, from_none], self.robert)
        if self.acerin is not None:
            result["acerin"] = from_union([from_int, from_none], self.acerin)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chlorophylligenous is not None:
            result["chlorophylligenous"] = from_union([from_int, from_none], self.chlorophylligenous)
        if self.conversational is not None:
            result["conversational"] = from_union([from_int, from_none], self.conversational)
        if self.demiowl is not None:
            result["demiowl"] = from_union([from_int, from_none], self.demiowl)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.ectorhinal is not None:
            result["ectorhinal"] = from_union([from_int, from_none], self.ectorhinal)
        if self.gamblesomeness is not None:
            result["gamblesomeness"] = from_union([from_int, from_none], self.gamblesomeness)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.irrorate is not None:
            result["irrorate"] = from_union([from_int, from_none], self.irrorate)
        if self.kindergartening is not None:
            result["kindergartening"] = from_union([from_int, from_none], self.kindergartening)
        if self.lateritic is not None:
            result["lateritic"] = from_union([from_int, from_none], self.lateritic)
        if self.mespil is not None:
            result["mespil"] = from_union([from_int, from_none], self.mespil)
        if self.misconfiguration is not None:
            result["misconfiguration"] = from_union([from_int, from_none], self.misconfiguration)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.planometry is not None:
            result["planometry"] = from_union([from_int, from_none], self.planometry)
        if self.rot is not None:
            result["rot"] = from_union([from_int, from_none], self.rot)
        if self.subcinctorium is not None:
            result["subcinctorium"] = from_union([from_int, from_none], self.subcinctorium)
        if self.tussocker is not None:
            result["tussocker"] = from_union([from_int, from_none], self.tussocker)
        if self.ultraproud is not None:
            result["ultraproud"] = from_union([from_int, from_none], self.ultraproud)
        if self.unsuggestedness is not None:
            result["unsuggestedness"] = from_union([from_int, from_none], self.unsuggestedness)
        return result


@dataclass
class UnstressedClass:
    alain: None
    amphirhina: None
    lincolnian: None
    sarcophilus: None
    antimachinery: None
    coldish: None
    crantara: None
    distinguishing: None
    elytroposis: None
    gentianwort: None
    heliosis: None
    instrumental: None
    introinflection: None
    kala: None
    metad: None
    swingingly: None
    unconformity: None
    undecreed: None
    venerable: None
    vowellessness: None

    @staticmethod
    def from_dict(obj: Any) -> 'UnstressedClass':
        assert isinstance(obj, dict)
        alain = from_none(obj["Alain"])
        amphirhina = from_none(obj["Amphirhina"])
        lincolnian = from_none(obj["Lincolnian"])
        sarcophilus = from_none(obj["Sarcophilus"])
        antimachinery = from_none(obj["antimachinery"])
        coldish = from_none(obj["coldish"])
        crantara = from_none(obj["crantara"])
        distinguishing = from_none(obj["distinguishing"])
        elytroposis = from_none(obj["elytroposis"])
        gentianwort = from_none(obj["gentianwort"])
        heliosis = from_none(obj["heliosis"])
        instrumental = from_none(obj["instrumental"])
        introinflection = from_none(obj["introinflection"])
        kala = from_none(obj["kala"])
        metad = from_none(obj["metad"])
        swingingly = from_none(obj["swingingly"])
        unconformity = from_none(obj["unconformity"])
        undecreed = from_none(obj["undecreed"])
        venerable = from_none(obj["venerable"])
        vowellessness = from_none(obj["vowellessness"])
        return UnstressedClass(alain, amphirhina, lincolnian, sarcophilus, antimachinery, coldish, crantara, distinguishing, elytroposis, gentianwort, heliosis, instrumental, introinflection, kala, metad, swingingly, unconformity, undecreed, venerable, vowellessness)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Alain"] = from_none(self.alain)
        result["Amphirhina"] = from_none(self.amphirhina)
        result["Lincolnian"] = from_none(self.lincolnian)
        result["Sarcophilus"] = from_none(self.sarcophilus)
        result["antimachinery"] = from_none(self.antimachinery)
        result["coldish"] = from_none(self.coldish)
        result["crantara"] = from_none(self.crantara)
        result["distinguishing"] = from_none(self.distinguishing)
        result["elytroposis"] = from_none(self.elytroposis)
        result["gentianwort"] = from_none(self.gentianwort)
        result["heliosis"] = from_none(self.heliosis)
        result["instrumental"] = from_none(self.instrumental)
        result["introinflection"] = from_none(self.introinflection)
        result["kala"] = from_none(self.kala)
        result["metad"] = from_none(self.metad)
        result["swingingly"] = from_none(self.swingingly)
        result["unconformity"] = from_none(self.unconformity)
        result["undecreed"] = from_none(self.undecreed)
        result["venerable"] = from_none(self.venerable)
        result["vowellessness"] = from_none(self.vowellessness)
        return result


@dataclass
class WrothyClass:
    aeschynanthus: None
    ephesine: None
    aquiferous: None
    cheapener: None
    enumeration: None
    escadrille: None
    estrous: None
    interestedly: None
    katakinetomer: None
    mortification: None
    morula: None
    orthosymmetrical: None
    overbark: None
    politist: None
    qualified: None
    sphenomalar: None
    throatful: None
    transhumance: None
    triandrian: None
    unbooked: None

    @staticmethod
    def from_dict(obj: Any) -> 'WrothyClass':
        assert isinstance(obj, dict)
        aeschynanthus = from_none(obj["Aeschynanthus"])
        ephesine = from_none(obj["Ephesine"])
        aquiferous = from_none(obj["aquiferous"])
        cheapener = from_none(obj["cheapener"])
        enumeration = from_none(obj["enumeration"])
        escadrille = from_none(obj["escadrille"])
        estrous = from_none(obj["estrous"])
        interestedly = from_none(obj["interestedly"])
        katakinetomer = from_none(obj["katakinetomer"])
        mortification = from_none(obj["mortification"])
        morula = from_none(obj["morula"])
        orthosymmetrical = from_none(obj["orthosymmetrical"])
        overbark = from_none(obj["overbark"])
        politist = from_none(obj["politist"])
        qualified = from_none(obj["qualified"])
        sphenomalar = from_none(obj["sphenomalar"])
        throatful = from_none(obj["throatful"])
        transhumance = from_none(obj["transhumance"])
        triandrian = from_none(obj["triandrian"])
        unbooked = from_none(obj["unbooked"])
        return WrothyClass(aeschynanthus, ephesine, aquiferous, cheapener, enumeration, escadrille, estrous, interestedly, katakinetomer, mortification, morula, orthosymmetrical, overbark, politist, qualified, sphenomalar, throatful, transhumance, triandrian, unbooked)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Aeschynanthus"] = from_none(self.aeschynanthus)
        result["Ephesine"] = from_none(self.ephesine)
        result["aquiferous"] = from_none(self.aquiferous)
        result["cheapener"] = from_none(self.cheapener)
        result["enumeration"] = from_none(self.enumeration)
        result["escadrille"] = from_none(self.escadrille)
        result["estrous"] = from_none(self.estrous)
        result["interestedly"] = from_none(self.interestedly)
        result["katakinetomer"] = from_none(self.katakinetomer)
        result["mortification"] = from_none(self.mortification)
        result["morula"] = from_none(self.morula)
        result["orthosymmetrical"] = from_none(self.orthosymmetrical)
        result["overbark"] = from_none(self.overbark)
        result["politist"] = from_none(self.politist)
        result["qualified"] = from_none(self.qualified)
        result["sphenomalar"] = from_none(self.sphenomalar)
        result["throatful"] = from_none(self.throatful)
        result["transhumance"] = from_none(self.transhumance)
        result["triandrian"] = from_none(self.triandrian)
        result["unbooked"] = from_none(self.unbooked)
        return result


@dataclass
class TopLevel:
    protrusive: list[Union[list[Optional[int]], float]]
    pulpitism: list[Union[list[int], PulpitismClass, float]]
    pyodermia: list[Union[PyodermiaClass, int]]
    quebrachine: list[Optional[Union[bool, QuebrachineClass]]]
    querier: list[Union[bool, dict[str, int]]]
    rebarbative: list[Union[list[int], bool, float]]
    reimagine: list[Reimagine]
    ressaut: Ressaut
    retrocervical: list[Union[list[Optional[int]], int]]
    revert: list[Union[bool, str]]
    rewrite: list[Union[list[None], RewriteClass, float]]
    saccoderm: list[Optional[Union[list[int], str]]]
    santir: list[Union[SantirClass, float]]
    saprophilous: list[Optional[Union[dict[str, int], str]]]
    saxten: list[Union[SaxtenClass, str]]
    scatty: list[Optional[Scatty]]
    scoffer: list[Optional[Union[list[None], dict[str, int]]]]
    scrampum: list[Optional[Union[list[int], bool]]]
    semantic: float
    serpentinic: list[Union[list[int], float]]
    shadowable: list[Union[list[Optional[int]], bool]]
    sistering: list[Union[list[None], SisteringClass, int]]
    staghunting: list[Staghunting]
    stagmometer: list[Union[list[Optional[int]], str]]
    stimulability: list[Union[bool, int, dict[str, int]]]
    strangleable: list[Union[list[None], float]]
    strenuosity: list[Union[list[None], StrenuosityClass]]
    tabaxir: list[Union[bool, float]]
    talpiform: list[Optional[Union[QuebrachineClass, float]]]
    thwack: list[Union[bool, QuebrachineClass, float]]
    to: list[Optional[float]]
    tortricine: list[Union[list[Optional[int]], QuebrachineClass]]
    truantcy: list[Union[bool, TruantcyClass]]
    turgesce: list[str]
    unbeginning: list[Union[list[None], dict[str, int], str]]
    underdunged: list[float]
    undesirability: list[Union[list[int], dict[str, int], str]]
    unerasing: list[Union[list[None], int, dict[str, int]]]
    unguentarium: list[Optional[Union[list[None], int]]]
    unimpeachably: list[Union[bool, UnimpeachablyClass]]
    unmortgaged: list[Optional[Union[float, dict[str, int]]]]
    unobstructed: list[Optional[Union[QuebrachineClass, int]]]
    unreceptivity: list[Union[list[None], int, str]]
    unsatisfactoriness: list[Union[list[int], bool, int]]
    unsecurity: list[int]
    unstressed: list[Union[bool, UnstressedClass, str]]
    untasked: list[Union[list[None], float, dict[str, int]]]
    unvarying: list[Union[bool, float, dict[str, int]]]
    vehemently: list[Optional[Union[list[None], bool]]]
    warriorship: dict[str, bool]
    whitepot: list[Union[QuebrachineClass, float]]
    wrothy: list[Union[list[None], WrothyClass]]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        protrusive = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_float], x), obj["protrusive"])
        pulpitism = from_list(lambda x: from_union([lambda x: from_list(from_int, x), PulpitismClass.from_dict, from_float], x), obj["pulpitism"])
        pyodermia = from_list(lambda x: from_union([PyodermiaClass.from_dict, from_int], x), obj["pyodermia"])
        quebrachine = from_list(lambda x: from_union([from_bool, QuebrachineClass.from_dict, from_none], x), obj["quebrachine"])
        querier = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x)], x), obj["querier"])
        rebarbative = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_float], x), obj["rebarbative"])
        reimagine = from_list(Reimagine.from_dict, obj["reimagine"])
        ressaut = Ressaut.from_dict(obj["ressaut"])
        retrocervical = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_int], x), obj["retrocervical"])
        revert = from_list(lambda x: from_union([from_bool, from_str], x), obj["revert"])
        rewrite = from_list(lambda x: from_union([lambda x: from_list(from_none, x), RewriteClass.from_dict, from_float], x), obj["rewrite"])
        saccoderm = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_none, from_str], x), obj["saccoderm"])
        santir = from_list(lambda x: from_union([SantirClass.from_dict, from_float], x), obj["santir"])
        saprophilous = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_none, from_str], x), obj["saprophilous"])
        saxten = from_list(lambda x: from_union([SaxtenClass.from_dict, from_str], x), obj["saxten"])
        scatty = from_list(lambda x: from_union([Scatty.from_dict, from_none], x), obj["scatty"])
        scoffer = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x), from_none], x), obj["scoffer"])
        scrampum = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_none], x), obj["scrampum"])
        semantic = from_float(obj["semantic"])
        serpentinic = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_float], x), obj["serpentinic"])
        shadowable = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_bool], x), obj["shadowable"])
        sistering = from_list(lambda x: from_union([lambda x: from_list(from_none, x), SisteringClass.from_dict, from_int], x), obj["sistering"])
        staghunting = from_list(Staghunting.from_dict, obj["staghunting"])
        stagmometer = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_str], x), obj["stagmometer"])
        stimulability = from_list(lambda x: from_union([from_bool, from_int, lambda x: from_dict(from_int, x)], x), obj["stimulability"])
        strangleable = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_float], x), obj["strangleable"])
        strenuosity = from_list(lambda x: from_union([lambda x: from_list(from_none, x), StrenuosityClass.from_dict], x), obj["strenuosity"])
        tabaxir = from_list(lambda x: from_union([from_bool, from_float], x), obj["tabaxir"])
        talpiform = from_list(lambda x: from_union([QuebrachineClass.from_dict, from_float, from_none], x), obj["talpiform"])
        thwack = from_list(lambda x: from_union([from_bool, QuebrachineClass.from_dict, from_float], x), obj["thwack"])
        to = from_list(lambda x: from_union([from_float, from_none], x), obj["to"])
        tortricine = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), QuebrachineClass.from_dict], x), obj["tortricine"])
        truantcy = from_list(lambda x: from_union([from_bool, TruantcyClass.from_dict], x), obj["truantcy"])
        turgesce = from_list(from_str, obj["turgesce"])
        unbeginning = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x), from_str], x), obj["unbeginning"])
        underdunged = from_list(from_float, obj["underdunged"])
        undesirability = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x), from_str], x), obj["undesirability"])
        unerasing = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, lambda x: from_dict(from_int, x)], x), obj["unerasing"])
        unguentarium = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, from_none], x), obj["unguentarium"])
        unimpeachably = from_list(lambda x: from_union([from_bool, UnimpeachablyClass.from_dict], x), obj["unimpeachably"])
        unmortgaged = from_list(lambda x: from_union([from_float, lambda x: from_dict(from_int, x), from_none], x), obj["unmortgaged"])
        unobstructed = from_list(lambda x: from_union([QuebrachineClass.from_dict, from_int, from_none], x), obj["unobstructed"])
        unreceptivity = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, from_str], x), obj["unreceptivity"])
        unsatisfactoriness = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_int], x), obj["unsatisfactoriness"])
        unsecurity = from_list(from_int, obj["unsecurity"])
        unstressed = from_list(lambda x: from_union([from_bool, UnstressedClass.from_dict, from_str], x), obj["unstressed"])
        untasked = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_float, lambda x: from_dict(from_int, x)], x), obj["untasked"])
        unvarying = from_list(lambda x: from_union([from_bool, from_float, lambda x: from_dict(from_int, x)], x), obj["unvarying"])
        vehemently = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_none], x), obj["vehemently"])
        warriorship = from_dict(from_bool, obj["warriorship"])
        whitepot = from_list(lambda x: from_union([QuebrachineClass.from_dict, from_float], x), obj["whitepot"])
        wrothy = from_list(lambda x: from_union([lambda x: from_list(from_none, x), WrothyClass.from_dict], x), obj["wrothy"])
        return TopLevel(protrusive, pulpitism, pyodermia, quebrachine, querier, rebarbative, reimagine, ressaut, retrocervical, revert, rewrite, saccoderm, santir, saprophilous, saxten, scatty, scoffer, scrampum, semantic, serpentinic, shadowable, sistering, staghunting, stagmometer, stimulability, strangleable, strenuosity, tabaxir, talpiform, thwack, to, tortricine, truantcy, turgesce, unbeginning, underdunged, undesirability, unerasing, unguentarium, unimpeachably, unmortgaged, unobstructed, unreceptivity, unsatisfactoriness, unsecurity, unstressed, untasked, unvarying, vehemently, warriorship, whitepot, wrothy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["protrusive"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), to_float], x), self.protrusive)
        result["pulpitism"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(PulpitismClass, x), to_float], x), self.pulpitism)
        result["pyodermia"] = from_list(lambda x: from_union([lambda x: to_class(PyodermiaClass, x), from_int], x), self.pyodermia)
        result["quebrachine"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(QuebrachineClass, x), from_none], x), self.quebrachine)
        result["querier"] = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x)], x), self.querier)
        result["rebarbative"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, to_float], x), self.rebarbative)
        result["reimagine"] = from_list(lambda x: to_class(Reimagine, x), self.reimagine)
        result["ressaut"] = to_class(Ressaut, self.ressaut)
        result["retrocervical"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_int], x), self.retrocervical)
        result["revert"] = from_list(lambda x: from_union([from_bool, from_str], x), self.revert)
        result["rewrite"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(RewriteClass, x), to_float], x), self.rewrite)
        result["saccoderm"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_none, from_str], x), self.saccoderm)
        result["santir"] = from_list(lambda x: from_union([lambda x: to_class(SantirClass, x), to_float], x), self.santir)
        result["saprophilous"] = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_none, from_str], x), self.saprophilous)
        result["saxten"] = from_list(lambda x: from_union([lambda x: to_class(SaxtenClass, x), from_str], x), self.saxten)
        result["scatty"] = from_list(lambda x: from_union([lambda x: to_class(Scatty, x), from_none], x), self.scatty)
        result["scoffer"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x), from_none], x), self.scoffer)
        result["scrampum"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_none], x), self.scrampum)
        result["semantic"] = to_float(self.semantic)
        result["serpentinic"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), to_float], x), self.serpentinic)
        result["shadowable"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_bool], x), self.shadowable)
        result["sistering"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(SisteringClass, x), from_int], x), self.sistering)
        result["staghunting"] = from_list(lambda x: to_class(Staghunting, x), self.staghunting)
        result["stagmometer"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_str], x), self.stagmometer)
        result["stimulability"] = from_list(lambda x: from_union([from_bool, from_int, lambda x: from_dict(from_int, x)], x), self.stimulability)
        result["strangleable"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), to_float], x), self.strangleable)
        result["strenuosity"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(StrenuosityClass, x)], x), self.strenuosity)
        result["tabaxir"] = from_list(lambda x: from_union([from_bool, to_float], x), self.tabaxir)
        result["talpiform"] = from_list(lambda x: from_union([lambda x: to_class(QuebrachineClass, x), to_float, from_none], x), self.talpiform)
        result["thwack"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(QuebrachineClass, x), to_float], x), self.thwack)
        result["to"] = from_list(lambda x: from_union([to_float, from_none], x), self.to)
        result["tortricine"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: to_class(QuebrachineClass, x)], x), self.tortricine)
        result["truantcy"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(TruantcyClass, x)], x), self.truantcy)
        result["turgesce"] = from_list(from_str, self.turgesce)
        result["unbeginning"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x), from_str], x), self.unbeginning)
        result["underdunged"] = from_list(to_float, self.underdunged)
        result["undesirability"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x), from_str], x), self.undesirability)
        result["unerasing"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, lambda x: from_dict(from_int, x)], x), self.unerasing)
        result["unguentarium"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, from_none], x), self.unguentarium)
        result["unimpeachably"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(UnimpeachablyClass, x)], x), self.unimpeachably)
        result["unmortgaged"] = from_list(lambda x: from_union([to_float, lambda x: from_dict(from_int, x), from_none], x), self.unmortgaged)
        result["unobstructed"] = from_list(lambda x: from_union([lambda x: to_class(QuebrachineClass, x), from_int, from_none], x), self.unobstructed)
        result["unreceptivity"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int, from_str], x), self.unreceptivity)
        result["unsatisfactoriness"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_int], x), self.unsatisfactoriness)
        result["unsecurity"] = from_list(from_int, self.unsecurity)
        result["unstressed"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(UnstressedClass, x), from_str], x), self.unstressed)
        result["untasked"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), to_float, lambda x: from_dict(from_int, x)], x), self.untasked)
        result["unvarying"] = from_list(lambda x: from_union([from_bool, to_float, lambda x: from_dict(from_int, x)], x), self.unvarying)
        result["vehemently"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_none], x), self.vehemently)
        result["warriorship"] = from_dict(from_bool, self.warriorship)
        result["whitepot"] = from_list(lambda x: from_union([lambda x: to_class(QuebrachineClass, x), to_float], x), self.whitepot)
        result["wrothy"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(WrothyClass, x)], x), self.wrothy)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
