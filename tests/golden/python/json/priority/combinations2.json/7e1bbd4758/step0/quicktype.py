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
class AlleviateClass:
    hulsean: None
    apriori: None
    beggarer: None
    brokenheartedly: None
    debilitation: None
    frike: None
    gastrolith: None
    orthocentric: None
    petaly: None
    probudgeting: None
    reacquire: None
    scow: None
    shutoff: None
    subcontiguous: None
    suffumigate: None
    transformable: None
    uncoroneted: None
    unparking: None
    unvarnishedness: None
    wherewithal: None

    @staticmethod
    def from_dict(obj: Any) -> 'AlleviateClass':
        assert isinstance(obj, dict)
        hulsean = from_none(obj["Hulsean"])
        apriori = from_none(obj["apriori"])
        beggarer = from_none(obj["beggarer"])
        brokenheartedly = from_none(obj["brokenheartedly"])
        debilitation = from_none(obj["debilitation"])
        frike = from_none(obj["frike"])
        gastrolith = from_none(obj["gastrolith"])
        orthocentric = from_none(obj["orthocentric"])
        petaly = from_none(obj["petaly"])
        probudgeting = from_none(obj["probudgeting"])
        reacquire = from_none(obj["reacquire"])
        scow = from_none(obj["scow"])
        shutoff = from_none(obj["shutoff"])
        subcontiguous = from_none(obj["subcontiguous"])
        suffumigate = from_none(obj["suffumigate"])
        transformable = from_none(obj["transformable"])
        uncoroneted = from_none(obj["uncoroneted"])
        unparking = from_none(obj["unparking"])
        unvarnishedness = from_none(obj["unvarnishedness"])
        wherewithal = from_none(obj["wherewithal"])
        return AlleviateClass(hulsean, apriori, beggarer, brokenheartedly, debilitation, frike, gastrolith, orthocentric, petaly, probudgeting, reacquire, scow, shutoff, subcontiguous, suffumigate, transformable, uncoroneted, unparking, unvarnishedness, wherewithal)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hulsean"] = from_none(self.hulsean)
        result["apriori"] = from_none(self.apriori)
        result["beggarer"] = from_none(self.beggarer)
        result["brokenheartedly"] = from_none(self.brokenheartedly)
        result["debilitation"] = from_none(self.debilitation)
        result["frike"] = from_none(self.frike)
        result["gastrolith"] = from_none(self.gastrolith)
        result["orthocentric"] = from_none(self.orthocentric)
        result["petaly"] = from_none(self.petaly)
        result["probudgeting"] = from_none(self.probudgeting)
        result["reacquire"] = from_none(self.reacquire)
        result["scow"] = from_none(self.scow)
        result["shutoff"] = from_none(self.shutoff)
        result["subcontiguous"] = from_none(self.subcontiguous)
        result["suffumigate"] = from_none(self.suffumigate)
        result["transformable"] = from_none(self.transformable)
        result["uncoroneted"] = from_none(self.uncoroneted)
        result["unparking"] = from_none(self.unparking)
        result["unvarnishedness"] = from_none(self.unvarnishedness)
        result["wherewithal"] = from_none(self.wherewithal)
        return result


@dataclass
class Rebecca:
    chirotherium: int
    catharticalness: float
    disdiapason: str
    homocerc: bool
    nonbookish: None

    @staticmethod
    def from_dict(obj: Any) -> 'Rebecca':
        assert isinstance(obj, dict)
        chirotherium = from_int(obj["Chirotherium"])
        catharticalness = from_float(obj["catharticalness"])
        disdiapason = from_str(obj["disdiapason"])
        homocerc = from_bool(obj["homocerc"])
        nonbookish = from_none(obj["nonbookish"])
        return Rebecca(chirotherium, catharticalness, disdiapason, homocerc, nonbookish)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Chirotherium"] = from_int(self.chirotherium)
        result["catharticalness"] = to_float(self.catharticalness)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


@dataclass
class Amphithyron:
    chirotherium: Optional[int]
    juniperus: Optional[int]
    nazirite: Optional[int]
    those: Optional[int]
    akroasis: Optional[int]
    antiphonical: Optional[int]
    basebred: Optional[int]
    catharticalness: Optional[float]
    conductometric: Optional[int]
    disdiapason: Optional[str]
    ensilation: Optional[int]
    eyebolt: Optional[int]
    fistulated: Optional[int]
    heteropod: Optional[int]
    homocerc: Optional[bool]
    labyrinthically: Optional[int]
    martyrization: Optional[int]
    mispolicy: Optional[int]
    multipara: Optional[int]
    nonbookish: None
    possessorial: Optional[int]
    shamed: Optional[int]
    shelfworn: Optional[int]
    stagnum: Optional[int]
    undecimal: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'Amphithyron':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        juniperus = from_union([from_int, from_none], obj.get("Juniperus"))
        nazirite = from_union([from_int, from_none], obj.get("Nazirite"))
        those = from_union([from_int, from_none], obj.get("Those"))
        akroasis = from_union([from_int, from_none], obj.get("akroasis"))
        antiphonical = from_union([from_int, from_none], obj.get("antiphonical"))
        basebred = from_union([from_int, from_none], obj.get("basebred"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        conductometric = from_union([from_int, from_none], obj.get("conductometric"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ensilation = from_union([from_int, from_none], obj.get("ensilation"))
        eyebolt = from_union([from_int, from_none], obj.get("eyebolt"))
        fistulated = from_union([from_int, from_none], obj.get("fistulated"))
        heteropod = from_union([from_int, from_none], obj.get("heteropod"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        labyrinthically = from_union([from_int, from_none], obj.get("labyrinthically"))
        martyrization = from_union([from_int, from_none], obj.get("martyrization"))
        mispolicy = from_union([from_int, from_none], obj.get("mispolicy"))
        multipara = from_union([from_int, from_none], obj.get("multipara"))
        nonbookish = from_none(obj.get("nonbookish"))
        possessorial = from_union([from_int, from_none], obj.get("possessorial"))
        shamed = from_union([from_int, from_none], obj.get("shamed"))
        shelfworn = from_union([from_int, from_none], obj.get("shelfworn"))
        stagnum = from_union([from_int, from_none], obj.get("stagnum"))
        undecimal = from_union([from_int, from_none], obj.get("undecimal"))
        return Amphithyron(chirotherium, juniperus, nazirite, those, akroasis, antiphonical, basebred, catharticalness, conductometric, disdiapason, ensilation, eyebolt, fistulated, heteropod, homocerc, labyrinthically, martyrization, mispolicy, multipara, nonbookish, possessorial, shamed, shelfworn, stagnum, undecimal)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.juniperus is not None:
            result["Juniperus"] = from_union([from_int, from_none], self.juniperus)
        if self.nazirite is not None:
            result["Nazirite"] = from_union([from_int, from_none], self.nazirite)
        if self.those is not None:
            result["Those"] = from_union([from_int, from_none], self.those)
        if self.akroasis is not None:
            result["akroasis"] = from_union([from_int, from_none], self.akroasis)
        if self.antiphonical is not None:
            result["antiphonical"] = from_union([from_int, from_none], self.antiphonical)
        if self.basebred is not None:
            result["basebred"] = from_union([from_int, from_none], self.basebred)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.conductometric is not None:
            result["conductometric"] = from_union([from_int, from_none], self.conductometric)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.ensilation is not None:
            result["ensilation"] = from_union([from_int, from_none], self.ensilation)
        if self.eyebolt is not None:
            result["eyebolt"] = from_union([from_int, from_none], self.eyebolt)
        if self.fistulated is not None:
            result["fistulated"] = from_union([from_int, from_none], self.fistulated)
        if self.heteropod is not None:
            result["heteropod"] = from_union([from_int, from_none], self.heteropod)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.labyrinthically is not None:
            result["labyrinthically"] = from_union([from_int, from_none], self.labyrinthically)
        if self.martyrization is not None:
            result["martyrization"] = from_union([from_int, from_none], self.martyrization)
        if self.mispolicy is not None:
            result["mispolicy"] = from_union([from_int, from_none], self.mispolicy)
        if self.multipara is not None:
            result["multipara"] = from_union([from_int, from_none], self.multipara)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.possessorial is not None:
            result["possessorial"] = from_union([from_int, from_none], self.possessorial)
        if self.shamed is not None:
            result["shamed"] = from_union([from_int, from_none], self.shamed)
        if self.shelfworn is not None:
            result["shelfworn"] = from_union([from_int, from_none], self.shelfworn)
        if self.stagnum is not None:
            result["stagnum"] = from_union([from_int, from_none], self.stagnum)
        if self.undecimal is not None:
            result["undecimal"] = from_union([from_int, from_none], self.undecimal)
        return result


@dataclass
class AnkeeClass:
    anomoean: None
    naja: None
    barleyhood: None
    befriender: None
    brutishness: None
    cephalalgy: None
    cirurgian: None
    conventionally: None
    jackshay: None
    milammeter: None
    ombrological: None
    phonasthenia: None
    retrievableness: None
    snakily: None
    swot: None
    tartlet: None
    thiofuran: None
    tracheophone: None
    tuglike: None
    unscratchingly: None

    @staticmethod
    def from_dict(obj: Any) -> 'AnkeeClass':
        assert isinstance(obj, dict)
        anomoean = from_none(obj["Anomoean"])
        naja = from_none(obj["Naja"])
        barleyhood = from_none(obj["barleyhood"])
        befriender = from_none(obj["befriender"])
        brutishness = from_none(obj["brutishness"])
        cephalalgy = from_none(obj["cephalalgy"])
        cirurgian = from_none(obj["cirurgian"])
        conventionally = from_none(obj["conventionally"])
        jackshay = from_none(obj["jackshay"])
        milammeter = from_none(obj["milammeter"])
        ombrological = from_none(obj["ombrological"])
        phonasthenia = from_none(obj["phonasthenia"])
        retrievableness = from_none(obj["retrievableness"])
        snakily = from_none(obj["snakily"])
        swot = from_none(obj["swot"])
        tartlet = from_none(obj["tartlet"])
        thiofuran = from_none(obj["thiofuran"])
        tracheophone = from_none(obj["tracheophone"])
        tuglike = from_none(obj["tuglike"])
        unscratchingly = from_none(obj["unscratchingly"])
        return AnkeeClass(anomoean, naja, barleyhood, befriender, brutishness, cephalalgy, cirurgian, conventionally, jackshay, milammeter, ombrological, phonasthenia, retrievableness, snakily, swot, tartlet, thiofuran, tracheophone, tuglike, unscratchingly)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Anomoean"] = from_none(self.anomoean)
        result["Naja"] = from_none(self.naja)
        result["barleyhood"] = from_none(self.barleyhood)
        result["befriender"] = from_none(self.befriender)
        result["brutishness"] = from_none(self.brutishness)
        result["cephalalgy"] = from_none(self.cephalalgy)
        result["cirurgian"] = from_none(self.cirurgian)
        result["conventionally"] = from_none(self.conventionally)
        result["jackshay"] = from_none(self.jackshay)
        result["milammeter"] = from_none(self.milammeter)
        result["ombrological"] = from_none(self.ombrological)
        result["phonasthenia"] = from_none(self.phonasthenia)
        result["retrievableness"] = from_none(self.retrievableness)
        result["snakily"] = from_none(self.snakily)
        result["swot"] = from_none(self.swot)
        result["tartlet"] = from_none(self.tartlet)
        result["thiofuran"] = from_none(self.thiofuran)
        result["tracheophone"] = from_none(self.tracheophone)
        result["tuglike"] = from_none(self.tuglike)
        result["unscratchingly"] = from_none(self.unscratchingly)
        return result


@dataclass
class AnsarieClass:
    alida: None
    ictonyx: None
    ramist: None
    accension: None
    asteria: None
    beriberic: None
    edgebone: None
    gastrodialysis: None
    geographic: None
    metrocele: None
    misgraft: None
    monteith: None
    notcher: None
    prorestriction: None
    throatlet: None
    unfair: None
    unsynonymous: None
    water: None
    zestfully: None
    zincic: None

    @staticmethod
    def from_dict(obj: Any) -> 'AnsarieClass':
        assert isinstance(obj, dict)
        alida = from_none(obj["Alida"])
        ictonyx = from_none(obj["Ictonyx"])
        ramist = from_none(obj["Ramist"])
        accension = from_none(obj["accension"])
        asteria = from_none(obj["asteria"])
        beriberic = from_none(obj["beriberic"])
        edgebone = from_none(obj["edgebone"])
        gastrodialysis = from_none(obj["gastrodialysis"])
        geographic = from_none(obj["geographic"])
        metrocele = from_none(obj["metrocele"])
        misgraft = from_none(obj["misgraft"])
        monteith = from_none(obj["monteith"])
        notcher = from_none(obj["notcher"])
        prorestriction = from_none(obj["prorestriction"])
        throatlet = from_none(obj["throatlet"])
        unfair = from_none(obj["unfair"])
        unsynonymous = from_none(obj["unsynonymous"])
        water = from_none(obj["water"])
        zestfully = from_none(obj["zestfully"])
        zincic = from_none(obj["zincic"])
        return AnsarieClass(alida, ictonyx, ramist, accension, asteria, beriberic, edgebone, gastrodialysis, geographic, metrocele, misgraft, monteith, notcher, prorestriction, throatlet, unfair, unsynonymous, water, zestfully, zincic)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Alida"] = from_none(self.alida)
        result["Ictonyx"] = from_none(self.ictonyx)
        result["Ramist"] = from_none(self.ramist)
        result["accension"] = from_none(self.accension)
        result["asteria"] = from_none(self.asteria)
        result["beriberic"] = from_none(self.beriberic)
        result["edgebone"] = from_none(self.edgebone)
        result["gastrodialysis"] = from_none(self.gastrodialysis)
        result["geographic"] = from_none(self.geographic)
        result["metrocele"] = from_none(self.metrocele)
        result["misgraft"] = from_none(self.misgraft)
        result["monteith"] = from_none(self.monteith)
        result["notcher"] = from_none(self.notcher)
        result["prorestriction"] = from_none(self.prorestriction)
        result["throatlet"] = from_none(self.throatlet)
        result["unfair"] = from_none(self.unfair)
        result["unsynonymous"] = from_none(self.unsynonymous)
        result["water"] = from_none(self.water)
        result["zestfully"] = from_none(self.zestfully)
        result["zincic"] = from_none(self.zincic)
        return result


@dataclass
class ChytridiaceaeClass:
    batidaceae: None
    brechites: None
    emery: None
    narraganset: None
    codespairer: None
    enervative: None
    excriminate: None
    goshenite: None
    grime: None
    gritten: None
    hectorly: None
    intermediation: None
    meeterly: None
    onymatic: None
    paddlecock: None
    thana: None
    thornily: None
    uckia: None
    unmettle: None
    vorticellid: None

    @staticmethod
    def from_dict(obj: Any) -> 'ChytridiaceaeClass':
        assert isinstance(obj, dict)
        batidaceae = from_none(obj["Batidaceae"])
        brechites = from_none(obj["Brechites"])
        emery = from_none(obj["Emery"])
        narraganset = from_none(obj["Narraganset"])
        codespairer = from_none(obj["codespairer"])
        enervative = from_none(obj["enervative"])
        excriminate = from_none(obj["excriminate"])
        goshenite = from_none(obj["goshenite"])
        grime = from_none(obj["grime"])
        gritten = from_none(obj["gritten"])
        hectorly = from_none(obj["hectorly"])
        intermediation = from_none(obj["intermediation"])
        meeterly = from_none(obj["meeterly"])
        onymatic = from_none(obj["onymatic"])
        paddlecock = from_none(obj["paddlecock"])
        thana = from_none(obj["thana"])
        thornily = from_none(obj["thornily"])
        uckia = from_none(obj["uckia"])
        unmettle = from_none(obj["unmettle"])
        vorticellid = from_none(obj["vorticellid"])
        return ChytridiaceaeClass(batidaceae, brechites, emery, narraganset, codespairer, enervative, excriminate, goshenite, grime, gritten, hectorly, intermediation, meeterly, onymatic, paddlecock, thana, thornily, uckia, unmettle, vorticellid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Batidaceae"] = from_none(self.batidaceae)
        result["Brechites"] = from_none(self.brechites)
        result["Emery"] = from_none(self.emery)
        result["Narraganset"] = from_none(self.narraganset)
        result["codespairer"] = from_none(self.codespairer)
        result["enervative"] = from_none(self.enervative)
        result["excriminate"] = from_none(self.excriminate)
        result["goshenite"] = from_none(self.goshenite)
        result["grime"] = from_none(self.grime)
        result["gritten"] = from_none(self.gritten)
        result["hectorly"] = from_none(self.hectorly)
        result["intermediation"] = from_none(self.intermediation)
        result["meeterly"] = from_none(self.meeterly)
        result["onymatic"] = from_none(self.onymatic)
        result["paddlecock"] = from_none(self.paddlecock)
        result["thana"] = from_none(self.thana)
        result["thornily"] = from_none(self.thornily)
        result["uckia"] = from_none(self.uckia)
        result["unmettle"] = from_none(self.unmettle)
        result["vorticellid"] = from_none(self.vorticellid)
        return result


@dataclass
class DiscordiaClass:
    altaic: Optional[int]
    chirotherium: Optional[int]
    patarin: Optional[int]
    amoristic: Optional[int]
    blennophthalmia: Optional[int]
    catharticalness: Optional[float]
    disciplinability: Optional[int]
    disdiapason: Optional[str]
    goofer: Optional[int]
    homocerc: Optional[bool]
    laryngograph: Optional[int]
    leucitis: Optional[int]
    lymphocyst: Optional[int]
    microcosmology: Optional[int]
    nauseation: Optional[int]
    nonbookish: None
    preliberal: Optional[int]
    prettifier: Optional[int]
    rangework: Optional[int]
    redient: Optional[int]
    subfusiform: Optional[int]
    suicidical: Optional[int]
    swow: Optional[int]
    wastrel: Optional[int]
    wingle: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'DiscordiaClass':
        assert isinstance(obj, dict)
        altaic = from_union([from_int, from_none], obj.get("Altaic"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        patarin = from_union([from_int, from_none], obj.get("Patarin"))
        amoristic = from_union([from_int, from_none], obj.get("amoristic"))
        blennophthalmia = from_union([from_int, from_none], obj.get("blennophthalmia"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        disciplinability = from_union([from_int, from_none], obj.get("disciplinability"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        goofer = from_union([from_int, from_none], obj.get("goofer"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        laryngograph = from_union([from_int, from_none], obj.get("laryngograph"))
        leucitis = from_union([from_int, from_none], obj.get("leucitis"))
        lymphocyst = from_union([from_int, from_none], obj.get("lymphocyst"))
        microcosmology = from_union([from_int, from_none], obj.get("microcosmology"))
        nauseation = from_union([from_int, from_none], obj.get("nauseation"))
        nonbookish = from_none(obj.get("nonbookish"))
        preliberal = from_union([from_int, from_none], obj.get("preliberal"))
        prettifier = from_union([from_int, from_none], obj.get("prettifier"))
        rangework = from_union([from_int, from_none], obj.get("rangework"))
        redient = from_union([from_int, from_none], obj.get("redient"))
        subfusiform = from_union([from_int, from_none], obj.get("subfusiform"))
        suicidical = from_union([from_int, from_none], obj.get("suicidical"))
        swow = from_union([from_int, from_none], obj.get("swow"))
        wastrel = from_union([from_int, from_none], obj.get("wastrel"))
        wingle = from_union([from_int, from_none], obj.get("wingle"))
        return DiscordiaClass(altaic, chirotherium, patarin, amoristic, blennophthalmia, catharticalness, disciplinability, disdiapason, goofer, homocerc, laryngograph, leucitis, lymphocyst, microcosmology, nauseation, nonbookish, preliberal, prettifier, rangework, redient, subfusiform, suicidical, swow, wastrel, wingle)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.altaic is not None:
            result["Altaic"] = from_union([from_int, from_none], self.altaic)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.patarin is not None:
            result["Patarin"] = from_union([from_int, from_none], self.patarin)
        if self.amoristic is not None:
            result["amoristic"] = from_union([from_int, from_none], self.amoristic)
        if self.blennophthalmia is not None:
            result["blennophthalmia"] = from_union([from_int, from_none], self.blennophthalmia)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.disciplinability is not None:
            result["disciplinability"] = from_union([from_int, from_none], self.disciplinability)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.goofer is not None:
            result["goofer"] = from_union([from_int, from_none], self.goofer)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.laryngograph is not None:
            result["laryngograph"] = from_union([from_int, from_none], self.laryngograph)
        if self.leucitis is not None:
            result["leucitis"] = from_union([from_int, from_none], self.leucitis)
        if self.lymphocyst is not None:
            result["lymphocyst"] = from_union([from_int, from_none], self.lymphocyst)
        if self.microcosmology is not None:
            result["microcosmology"] = from_union([from_int, from_none], self.microcosmology)
        if self.nauseation is not None:
            result["nauseation"] = from_union([from_int, from_none], self.nauseation)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.preliberal is not None:
            result["preliberal"] = from_union([from_int, from_none], self.preliberal)
        if self.prettifier is not None:
            result["prettifier"] = from_union([from_int, from_none], self.prettifier)
        if self.rangework is not None:
            result["rangework"] = from_union([from_int, from_none], self.rangework)
        if self.redient is not None:
            result["redient"] = from_union([from_int, from_none], self.redient)
        if self.subfusiform is not None:
            result["subfusiform"] = from_union([from_int, from_none], self.subfusiform)
        if self.suicidical is not None:
            result["suicidical"] = from_union([from_int, from_none], self.suicidical)
        if self.swow is not None:
            result["swow"] = from_union([from_int, from_none], self.swow)
        if self.wastrel is not None:
            result["wastrel"] = from_union([from_int, from_none], self.wastrel)
        if self.wingle is not None:
            result["wingle"] = from_union([from_int, from_none], self.wingle)
        return result


@dataclass
class GryphosaurusClass:
    burushaski: None
    tahami: None
    amissibility: None
    citronin: None
    coplaintiff: None
    disquisitionary: None
    enoplan: None
    faintness: None
    hebetomy: None
    islandry: None
    lameduck: None
    overbattle: None
    overinterested: None
    phrenologic: None
    rainband: None
    shiningly: None
    stamineous: None
    subscapularis: None
    undaubed: None
    underntime: None

    @staticmethod
    def from_dict(obj: Any) -> 'GryphosaurusClass':
        assert isinstance(obj, dict)
        burushaski = from_none(obj["Burushaski"])
        tahami = from_none(obj["Tahami"])
        amissibility = from_none(obj["amissibility"])
        citronin = from_none(obj["citronin"])
        coplaintiff = from_none(obj["coplaintiff"])
        disquisitionary = from_none(obj["disquisitionary"])
        enoplan = from_none(obj["enoplan"])
        faintness = from_none(obj["faintness"])
        hebetomy = from_none(obj["hebetomy"])
        islandry = from_none(obj["islandry"])
        lameduck = from_none(obj["lameduck"])
        overbattle = from_none(obj["overbattle"])
        overinterested = from_none(obj["overinterested"])
        phrenologic = from_none(obj["phrenologic"])
        rainband = from_none(obj["rainband"])
        shiningly = from_none(obj["shiningly"])
        stamineous = from_none(obj["stamineous"])
        subscapularis = from_none(obj["subscapularis"])
        undaubed = from_none(obj["undaubed"])
        underntime = from_none(obj["underntime"])
        return GryphosaurusClass(burushaski, tahami, amissibility, citronin, coplaintiff, disquisitionary, enoplan, faintness, hebetomy, islandry, lameduck, overbattle, overinterested, phrenologic, rainband, shiningly, stamineous, subscapularis, undaubed, underntime)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Burushaski"] = from_none(self.burushaski)
        result["Tahami"] = from_none(self.tahami)
        result["amissibility"] = from_none(self.amissibility)
        result["citronin"] = from_none(self.citronin)
        result["coplaintiff"] = from_none(self.coplaintiff)
        result["disquisitionary"] = from_none(self.disquisitionary)
        result["enoplan"] = from_none(self.enoplan)
        result["faintness"] = from_none(self.faintness)
        result["hebetomy"] = from_none(self.hebetomy)
        result["islandry"] = from_none(self.islandry)
        result["lameduck"] = from_none(self.lameduck)
        result["overbattle"] = from_none(self.overbattle)
        result["overinterested"] = from_none(self.overinterested)
        result["phrenologic"] = from_none(self.phrenologic)
        result["rainband"] = from_none(self.rainband)
        result["shiningly"] = from_none(self.shiningly)
        result["stamineous"] = from_none(self.stamineous)
        result["subscapularis"] = from_none(self.subscapularis)
        result["undaubed"] = from_none(self.undaubed)
        result["underntime"] = from_none(self.underntime)
        return result


@dataclass
class LaviniaClass:
    chirotherium: Optional[int]
    tacana: Optional[int]
    agitable: Optional[int]
    asininity: Optional[int]
    benefiter: Optional[int]
    bronzelike: Optional[int]
    catharticalness: Optional[float]
    cholesteatomatous: Optional[int]
    deprivement: Optional[int]
    disdiapason: Optional[str]
    flippantness: Optional[int]
    fogproof: Optional[int]
    homocerc: Optional[bool]
    merrymeeting: Optional[int]
    nonbookish: None
    overcareful: Optional[int]
    panaris: Optional[int]
    preacceptance: Optional[int]
    quinoxaline: Optional[int]
    sig: Optional[int]
    superconfusion: Optional[int]
    tillotter: Optional[int]
    tranquillize: Optional[int]
    unquestionable: Optional[int]
    uproute: Optional[int]

    @staticmethod
    def from_dict(obj: Any) -> 'LaviniaClass':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        tacana = from_union([from_int, from_none], obj.get("Tacana"))
        agitable = from_union([from_int, from_none], obj.get("agitable"))
        asininity = from_union([from_int, from_none], obj.get("asininity"))
        benefiter = from_union([from_int, from_none], obj.get("benefiter"))
        bronzelike = from_union([from_int, from_none], obj.get("bronzelike"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        cholesteatomatous = from_union([from_int, from_none], obj.get("cholesteatomatous"))
        deprivement = from_union([from_int, from_none], obj.get("deprivement"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        flippantness = from_union([from_int, from_none], obj.get("flippantness"))
        fogproof = from_union([from_int, from_none], obj.get("fogproof"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        merrymeeting = from_union([from_int, from_none], obj.get("merrymeeting"))
        nonbookish = from_none(obj.get("nonbookish"))
        overcareful = from_union([from_int, from_none], obj.get("overcareful"))
        panaris = from_union([from_int, from_none], obj.get("panaris"))
        preacceptance = from_union([from_int, from_none], obj.get("preacceptance"))
        quinoxaline = from_union([from_int, from_none], obj.get("quinoxaline"))
        sig = from_union([from_int, from_none], obj.get("sig"))
        superconfusion = from_union([from_int, from_none], obj.get("superconfusion"))
        tillotter = from_union([from_int, from_none], obj.get("tillotter"))
        tranquillize = from_union([from_int, from_none], obj.get("tranquillize"))
        unquestionable = from_union([from_int, from_none], obj.get("unquestionable"))
        uproute = from_union([from_int, from_none], obj.get("uproute"))
        return LaviniaClass(chirotherium, tacana, agitable, asininity, benefiter, bronzelike, catharticalness, cholesteatomatous, deprivement, disdiapason, flippantness, fogproof, homocerc, merrymeeting, nonbookish, overcareful, panaris, preacceptance, quinoxaline, sig, superconfusion, tillotter, tranquillize, unquestionable, uproute)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.tacana is not None:
            result["Tacana"] = from_union([from_int, from_none], self.tacana)
        if self.agitable is not None:
            result["agitable"] = from_union([from_int, from_none], self.agitable)
        if self.asininity is not None:
            result["asininity"] = from_union([from_int, from_none], self.asininity)
        if self.benefiter is not None:
            result["benefiter"] = from_union([from_int, from_none], self.benefiter)
        if self.bronzelike is not None:
            result["bronzelike"] = from_union([from_int, from_none], self.bronzelike)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.cholesteatomatous is not None:
            result["cholesteatomatous"] = from_union([from_int, from_none], self.cholesteatomatous)
        if self.deprivement is not None:
            result["deprivement"] = from_union([from_int, from_none], self.deprivement)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.flippantness is not None:
            result["flippantness"] = from_union([from_int, from_none], self.flippantness)
        if self.fogproof is not None:
            result["fogproof"] = from_union([from_int, from_none], self.fogproof)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.merrymeeting is not None:
            result["merrymeeting"] = from_union([from_int, from_none], self.merrymeeting)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.overcareful is not None:
            result["overcareful"] = from_union([from_int, from_none], self.overcareful)
        if self.panaris is not None:
            result["panaris"] = from_union([from_int, from_none], self.panaris)
        if self.preacceptance is not None:
            result["preacceptance"] = from_union([from_int, from_none], self.preacceptance)
        if self.quinoxaline is not None:
            result["quinoxaline"] = from_union([from_int, from_none], self.quinoxaline)
        if self.sig is not None:
            result["sig"] = from_union([from_int, from_none], self.sig)
        if self.superconfusion is not None:
            result["superconfusion"] = from_union([from_int, from_none], self.superconfusion)
        if self.tillotter is not None:
            result["tillotter"] = from_union([from_int, from_none], self.tillotter)
        if self.tranquillize is not None:
            result["tranquillize"] = from_union([from_int, from_none], self.tranquillize)
        if self.unquestionable is not None:
            result["unquestionable"] = from_union([from_int, from_none], self.unquestionable)
        if self.uproute is not None:
            result["uproute"] = from_union([from_int, from_none], self.uproute)
        return result


@dataclass
class OskarClass:
    acrobates: None
    cayuga: None
    netherlandish: None
    beanshooter: None
    bearhound: None
    guarneri: None
    hypochondriacism: None
    indication: None
    jaculative: None
    nagana: None
    noctivagous: None
    nonphysiological: None
    praxis: None
    provision: None
    subterhuman: None
    sunlit: None
    syncraniate: None
    teachment: None
    unmutinous: None
    unstoppable: None

    @staticmethod
    def from_dict(obj: Any) -> 'OskarClass':
        assert isinstance(obj, dict)
        acrobates = from_none(obj["Acrobates"])
        cayuga = from_none(obj["Cayuga"])
        netherlandish = from_none(obj["Netherlandish"])
        beanshooter = from_none(obj["beanshooter"])
        bearhound = from_none(obj["bearhound"])
        guarneri = from_none(obj["guarneri"])
        hypochondriacism = from_none(obj["hypochondriacism"])
        indication = from_none(obj["indication"])
        jaculative = from_none(obj["jaculative"])
        nagana = from_none(obj["nagana"])
        noctivagous = from_none(obj["noctivagous"])
        nonphysiological = from_none(obj["nonphysiological"])
        praxis = from_none(obj["praxis"])
        provision = from_none(obj["provision"])
        subterhuman = from_none(obj["subterhuman"])
        sunlit = from_none(obj["sunlit"])
        syncraniate = from_none(obj["syncraniate"])
        teachment = from_none(obj["teachment"])
        unmutinous = from_none(obj["unmutinous"])
        unstoppable = from_none(obj["unstoppable"])
        return OskarClass(acrobates, cayuga, netherlandish, beanshooter, bearhound, guarneri, hypochondriacism, indication, jaculative, nagana, noctivagous, nonphysiological, praxis, provision, subterhuman, sunlit, syncraniate, teachment, unmutinous, unstoppable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Acrobates"] = from_none(self.acrobates)
        result["Cayuga"] = from_none(self.cayuga)
        result["Netherlandish"] = from_none(self.netherlandish)
        result["beanshooter"] = from_none(self.beanshooter)
        result["bearhound"] = from_none(self.bearhound)
        result["guarneri"] = from_none(self.guarneri)
        result["hypochondriacism"] = from_none(self.hypochondriacism)
        result["indication"] = from_none(self.indication)
        result["jaculative"] = from_none(self.jaculative)
        result["nagana"] = from_none(self.nagana)
        result["noctivagous"] = from_none(self.noctivagous)
        result["nonphysiological"] = from_none(self.nonphysiological)
        result["praxis"] = from_none(self.praxis)
        result["provision"] = from_none(self.provision)
        result["subterhuman"] = from_none(self.subterhuman)
        result["sunlit"] = from_none(self.sunlit)
        result["syncraniate"] = from_none(self.syncraniate)
        result["teachment"] = from_none(self.teachment)
        result["unmutinous"] = from_none(self.unmutinous)
        result["unstoppable"] = from_none(self.unstoppable)
        return result


@dataclass
class TopLevel:
    abranchiata: list[Optional[Union[list[int], int]]]
    andriana: list[Optional[str]]
    ansarie: list[Optional[Union[list[int], AnsarieClass]]]
    chytridiaceae: list[Optional[Union[bool, ChytridiaceaeClass]]]
    discordia: list[Union[list[int], DiscordiaClass]]
    endomyces: list[Union[int, str]]
    epinephelidae: list[Union[bool, int, str]]
    eupatorium: list[Union[list[None], dict[str, int]]]
    gryphosaurus: list[Union[list[int], GryphosaurusClass, str]]
    koryak: list[Union[dict[str, Optional[int]], str]]
    lavinia: list[Union[LaviniaClass, str]]
    oskar: list[Union[list[int], OskarClass]]
    rebecca: list[Union[Rebecca, int, str]]
    rhomboganoidei: list[Union[list[int], Rebecca, str]]
    rigsmal: bool
    ruellia: list[Union[bool, Rebecca, str]]
    school: list[Optional[Union[int, dict[str, int]]]]
    shakespearolater: list[Union[list[int], float, str]]
    svan: list[float]
    wayao: dict[str, float]
    academe: list[Union[list[int], int, dict[str, int]]]
    acquirable: list[Union[list[Optional[int]], dict[str, int]]]
    aerometry: list[Union[bool, float]]
    alexin: list[Union[list[int], bool]]
    alleviate: list[Union[list[Optional[int]], AlleviateClass]]
    amaas: list[Union[bool, Rebecca, int]]
    ambassage: list[Union[list[None], str]]
    amphithyron: list[Optional[Amphithyron]]
    ankee: list[Union[list[int], AnkeeClass, int]]
    annihilator: list[Optional[dict[str, Optional[int]]]]
    aphasia: list[Union[list[int], int]]
    asprawl: list[Union[float, str]]
    attractive: list[Optional[bool]]
    barksome: dict[str, int]
    bedesman: list[Union[bool, float, str]]
    belard: list[Union[list[int], Rebecca, float]]
    bocking: list[Union[list[int], bool, dict[str, int]]]
    brawlingly: list[Union[list[None], dict[str, Optional[int]]]]
    brookie: list[Union[list[int], Rebecca]]
    bumboatman: list[Optional[Union[list[None], str]]]
    bystreet: list[None]
    calaverite: list[Union[list[int], str]]
    catallactic: list[Union[list[None], bool, dict[str, int]]]
    cemental: list[Union[list[int], float, dict[str, int]]]
    annulose: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        abranchiata = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_none], x), obj["Abranchiata"])
        andriana = from_list(lambda x: from_union([from_none, from_str], x), obj["Andriana"])
        ansarie = from_list(lambda x: from_union([lambda x: from_list(from_int, x), AnsarieClass.from_dict, from_none], x), obj["Ansarie"])
        chytridiaceae = from_list(lambda x: from_union([from_bool, ChytridiaceaeClass.from_dict, from_none], x), obj["Chytridiaceae"])
        discordia = from_list(lambda x: from_union([lambda x: from_list(from_int, x), DiscordiaClass.from_dict], x), obj["Discordia"])
        endomyces = from_list(lambda x: from_union([from_int, from_str], x), obj["Endomyces"])
        epinephelidae = from_list(lambda x: from_union([from_bool, from_int, from_str], x), obj["Epinephelidae"])
        eupatorium = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x)], x), obj["Eupatorium"])
        gryphosaurus = from_list(lambda x: from_union([lambda x: from_list(from_int, x), GryphosaurusClass.from_dict, from_str], x), obj["Gryphosaurus"])
        koryak = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_str], x), obj["Koryak"])
        lavinia = from_list(lambda x: from_union([LaviniaClass.from_dict, from_str], x), obj["Lavinia"])
        oskar = from_list(lambda x: from_union([lambda x: from_list(from_int, x), OskarClass.from_dict], x), obj["Oskar"])
        rebecca = from_list(lambda x: from_union([Rebecca.from_dict, from_int, from_str], x), obj["Rebecca"])
        rhomboganoidei = from_list(lambda x: from_union([lambda x: from_list(from_int, x), Rebecca.from_dict, from_str], x), obj["Rhomboganoidei"])
        rigsmal = from_bool(obj["Rigsmal"])
        ruellia = from_list(lambda x: from_union([from_bool, Rebecca.from_dict, from_str], x), obj["Ruellia"])
        school = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x), from_none], x), obj["School"])
        shakespearolater = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_float, from_str], x), obj["Shakespearolater"])
        svan = from_list(from_float, obj["Svan"])
        wayao = from_dict(from_float, obj["Wayao"])
        academe = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, lambda x: from_dict(from_int, x)], x), obj["academe"])
        acquirable = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: from_dict(from_int, x)], x), obj["acquirable"])
        aerometry = from_list(lambda x: from_union([from_bool, from_float], x), obj["aerometry"])
        alexin = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool], x), obj["alexin"])
        alleviate = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), AlleviateClass.from_dict], x), obj["alleviate"])
        amaas = from_list(lambda x: from_union([from_bool, Rebecca.from_dict, from_int], x), obj["amaas"])
        ambassage = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_str], x), obj["ambassage"])
        amphithyron = from_list(lambda x: from_union([Amphithyron.from_dict, from_none], x), obj["amphithyron"])
        ankee = from_list(lambda x: from_union([lambda x: from_list(from_int, x), AnkeeClass.from_dict, from_int], x), obj["ankee"])
        annihilator = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_none], x), obj["annihilator"])
        aphasia = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int], x), obj["aphasia"])
        asprawl = from_list(lambda x: from_union([from_float, from_str], x), obj["asprawl"])
        attractive = from_list(lambda x: from_union([from_bool, from_none], x), obj["attractive"])
        barksome = from_dict(from_int, obj["barksome"])
        bedesman = from_list(lambda x: from_union([from_bool, from_float, from_str], x), obj["bedesman"])
        belard = from_list(lambda x: from_union([lambda x: from_list(from_int, x), Rebecca.from_dict, from_float], x), obj["belard"])
        bocking = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, lambda x: from_dict(from_int, x)], x), obj["bocking"])
        brawlingly = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), obj["brawlingly"])
        brookie = from_list(lambda x: from_union([lambda x: from_list(from_int, x), Rebecca.from_dict], x), obj["brookie"])
        bumboatman = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_none, from_str], x), obj["bumboatman"])
        bystreet = from_list(from_none, obj["bystreet"])
        calaverite = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_str], x), obj["calaverite"])
        catallactic = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, lambda x: from_dict(from_int, x)], x), obj["catallactic"])
        cemental = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_float, lambda x: from_dict(from_int, x)], x), obj["cemental"])
        annulose = from_none(obj["annulose"])
        return TopLevel(abranchiata, andriana, ansarie, chytridiaceae, discordia, endomyces, epinephelidae, eupatorium, gryphosaurus, koryak, lavinia, oskar, rebecca, rhomboganoidei, rigsmal, ruellia, school, shakespearolater, svan, wayao, academe, acquirable, aerometry, alexin, alleviate, amaas, ambassage, amphithyron, ankee, annihilator, aphasia, asprawl, attractive, barksome, bedesman, belard, bocking, brawlingly, brookie, bumboatman, bystreet, calaverite, catallactic, cemental, annulose)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Abranchiata"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_none], x), self.abranchiata)
        result["Andriana"] = from_list(lambda x: from_union([from_none, from_str], x), self.andriana)
        result["Ansarie"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(AnsarieClass, x), from_none], x), self.ansarie)
        result["Chytridiaceae"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(ChytridiaceaeClass, x), from_none], x), self.chytridiaceae)
        result["Discordia"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(DiscordiaClass, x)], x), self.discordia)
        result["Endomyces"] = from_list(lambda x: from_union([from_int, from_str], x), self.endomyces)
        result["Epinephelidae"] = from_list(lambda x: from_union([from_bool, from_int, from_str], x), self.epinephelidae)
        result["Eupatorium"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(from_int, x)], x), self.eupatorium)
        result["Gryphosaurus"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(GryphosaurusClass, x), from_str], x), self.gryphosaurus)
        result["Koryak"] = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_str], x), self.koryak)
        result["Lavinia"] = from_list(lambda x: from_union([lambda x: to_class(LaviniaClass, x), from_str], x), self.lavinia)
        result["Oskar"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(OskarClass, x)], x), self.oskar)
        result["Rebecca"] = from_list(lambda x: from_union([lambda x: to_class(Rebecca, x), from_int, from_str], x), self.rebecca)
        result["Rhomboganoidei"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(Rebecca, x), from_str], x), self.rhomboganoidei)
        result["Rigsmal"] = from_bool(self.rigsmal)
        result["Ruellia"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(Rebecca, x), from_str], x), self.ruellia)
        result["School"] = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x), from_none], x), self.school)
        result["Shakespearolater"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), to_float, from_str], x), self.shakespearolater)
        result["Svan"] = from_list(to_float, self.svan)
        result["Wayao"] = from_dict(to_float, self.wayao)
        result["academe"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, lambda x: from_dict(from_int, x)], x), self.academe)
        result["acquirable"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: from_dict(from_int, x)], x), self.acquirable)
        result["aerometry"] = from_list(lambda x: from_union([from_bool, to_float], x), self.aerometry)
        result["alexin"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool], x), self.alexin)
        result["alleviate"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: to_class(AlleviateClass, x)], x), self.alleviate)
        result["amaas"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(Rebecca, x), from_int], x), self.amaas)
        result["ambassage"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_str], x), self.ambassage)
        result["amphithyron"] = from_list(lambda x: from_union([lambda x: to_class(Amphithyron, x), from_none], x), self.amphithyron)
        result["ankee"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(AnkeeClass, x), from_int], x), self.ankee)
        result["annihilator"] = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_none], x), self.annihilator)
        result["aphasia"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int], x), self.aphasia)
        result["asprawl"] = from_list(lambda x: from_union([to_float, from_str], x), self.asprawl)
        result["attractive"] = from_list(lambda x: from_union([from_bool, from_none], x), self.attractive)
        result["barksome"] = from_dict(from_int, self.barksome)
        result["bedesman"] = from_list(lambda x: from_union([from_bool, to_float, from_str], x), self.bedesman)
        result["belard"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(Rebecca, x), to_float], x), self.belard)
        result["bocking"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, lambda x: from_dict(from_int, x)], x), self.bocking)
        result["brawlingly"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), self.brawlingly)
        result["brookie"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(Rebecca, x)], x), self.brookie)
        result["bumboatman"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_none, from_str], x), self.bumboatman)
        result["bystreet"] = from_list(from_none, self.bystreet)
        result["calaverite"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_str], x), self.calaverite)
        result["catallactic"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, lambda x: from_dict(from_int, x)], x), self.catallactic)
        result["cemental"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), to_float, lambda x: from_dict(from_int, x)], x), self.cemental)
        result["annulose"] = from_none(self.annulose)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
