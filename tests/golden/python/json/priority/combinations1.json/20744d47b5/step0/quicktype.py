from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


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
class CerographClass:
    tolowa: None
    apotropaion: None
    casuary: None
    creaker: None
    disqualification: None
    imperatorious: None
    impermeabilize: None
    metastoma: None
    noctidiurnal: None
    nonreserve: None
    ophthalmotonometry: None
    pailful: None
    pigfish: None
    pongee: None
    prosodical: None
    scrofuloderm: None
    storekeeping: None
    therologist: None
    tradeful: None
    unriveting: None

    @staticmethod
    def from_dict(obj: Any) -> 'CerographClass':
        assert isinstance(obj, dict)
        tolowa = from_none(obj["Tolowa"])
        apotropaion = from_none(obj["apotropaion"])
        casuary = from_none(obj["casuary"])
        creaker = from_none(obj["creaker"])
        disqualification = from_none(obj["disqualification"])
        imperatorious = from_none(obj["imperatorious"])
        impermeabilize = from_none(obj["impermeabilize"])
        metastoma = from_none(obj["metastoma"])
        noctidiurnal = from_none(obj["noctidiurnal"])
        nonreserve = from_none(obj["nonreserve"])
        ophthalmotonometry = from_none(obj["ophthalmotonometry"])
        pailful = from_none(obj["pailful"])
        pigfish = from_none(obj["pigfish"])
        pongee = from_none(obj["pongee"])
        prosodical = from_none(obj["prosodical"])
        scrofuloderm = from_none(obj["scrofuloderm"])
        storekeeping = from_none(obj["storekeeping"])
        therologist = from_none(obj["therologist"])
        tradeful = from_none(obj["tradeful"])
        unriveting = from_none(obj["unriveting"])
        return CerographClass(tolowa, apotropaion, casuary, creaker, disqualification, imperatorious, impermeabilize, metastoma, noctidiurnal, nonreserve, ophthalmotonometry, pailful, pigfish, pongee, prosodical, scrofuloderm, storekeeping, therologist, tradeful, unriveting)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Tolowa"] = from_none(self.tolowa)
        result["apotropaion"] = from_none(self.apotropaion)
        result["casuary"] = from_none(self.casuary)
        result["creaker"] = from_none(self.creaker)
        result["disqualification"] = from_none(self.disqualification)
        result["imperatorious"] = from_none(self.imperatorious)
        result["impermeabilize"] = from_none(self.impermeabilize)
        result["metastoma"] = from_none(self.metastoma)
        result["noctidiurnal"] = from_none(self.noctidiurnal)
        result["nonreserve"] = from_none(self.nonreserve)
        result["ophthalmotonometry"] = from_none(self.ophthalmotonometry)
        result["pailful"] = from_none(self.pailful)
        result["pigfish"] = from_none(self.pigfish)
        result["pongee"] = from_none(self.pongee)
        result["prosodical"] = from_none(self.prosodical)
        result["scrofuloderm"] = from_none(self.scrofuloderm)
        result["storekeeping"] = from_none(self.storekeeping)
        result["therologist"] = from_none(self.therologist)
        result["tradeful"] = from_none(self.tradeful)
        result["unriveting"] = from_none(self.unriveting)
        return result


@dataclass
class ChemotherapeuticClass:
    chirotherium: int | None
    maureen: None
    angioneurotic: None
    availment: None
    bladelet: None
    catharticalness: float | None
    caulis: None
    chalcus: None
    disdiapason: str | None
    enteradenological: None
    homocerc: bool | None
    imporosity: None
    insistently: None
    intraparietal: None
    ivied: None
    nonbookish: None
    nostochine: None
    nutcracker: None
    ofttimes: None
    phenocryst: None
    precoincident: None
    ramiferous: None
    stagmometer: None
    tetherball: None
    unshy: None

    @staticmethod
    def from_dict(obj: Any) -> 'ChemotherapeuticClass':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        maureen = from_none(obj.get("Maureen"))
        angioneurotic = from_none(obj.get("angioneurotic"))
        availment = from_none(obj.get("availment"))
        bladelet = from_none(obj.get("bladelet"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        caulis = from_none(obj.get("caulis"))
        chalcus = from_none(obj.get("chalcus"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        enteradenological = from_none(obj.get("enteradenological"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        imporosity = from_none(obj.get("imporosity"))
        insistently = from_none(obj.get("insistently"))
        intraparietal = from_none(obj.get("intraparietal"))
        ivied = from_none(obj.get("ivied"))
        nonbookish = from_none(obj.get("nonbookish"))
        nostochine = from_none(obj.get("nostochine"))
        nutcracker = from_none(obj.get("nutcracker"))
        ofttimes = from_none(obj.get("ofttimes"))
        phenocryst = from_none(obj.get("phenocryst"))
        precoincident = from_none(obj.get("precoincident"))
        ramiferous = from_none(obj.get("ramiferous"))
        stagmometer = from_none(obj.get("stagmometer"))
        tetherball = from_none(obj.get("tetherball"))
        unshy = from_none(obj.get("unshy"))
        return ChemotherapeuticClass(chirotherium, maureen, angioneurotic, availment, bladelet, catharticalness, caulis, chalcus, disdiapason, enteradenological, homocerc, imporosity, insistently, intraparietal, ivied, nonbookish, nostochine, nutcracker, ofttimes, phenocryst, precoincident, ramiferous, stagmometer, tetherball, unshy)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.maureen is not None:
            result["Maureen"] = from_none(self.maureen)
        if self.angioneurotic is not None:
            result["angioneurotic"] = from_none(self.angioneurotic)
        if self.availment is not None:
            result["availment"] = from_none(self.availment)
        if self.bladelet is not None:
            result["bladelet"] = from_none(self.bladelet)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.caulis is not None:
            result["caulis"] = from_none(self.caulis)
        if self.chalcus is not None:
            result["chalcus"] = from_none(self.chalcus)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.enteradenological is not None:
            result["enteradenological"] = from_none(self.enteradenological)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.imporosity is not None:
            result["imporosity"] = from_none(self.imporosity)
        if self.insistently is not None:
            result["insistently"] = from_none(self.insistently)
        if self.intraparietal is not None:
            result["intraparietal"] = from_none(self.intraparietal)
        if self.ivied is not None:
            result["ivied"] = from_none(self.ivied)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.nostochine is not None:
            result["nostochine"] = from_none(self.nostochine)
        if self.nutcracker is not None:
            result["nutcracker"] = from_none(self.nutcracker)
        if self.ofttimes is not None:
            result["ofttimes"] = from_none(self.ofttimes)
        if self.phenocryst is not None:
            result["phenocryst"] = from_none(self.phenocryst)
        if self.precoincident is not None:
            result["precoincident"] = from_none(self.precoincident)
        if self.ramiferous is not None:
            result["ramiferous"] = from_none(self.ramiferous)
        if self.stagmometer is not None:
            result["stagmometer"] = from_none(self.stagmometer)
        if self.tetherball is not None:
            result["tetherball"] = from_none(self.tetherball)
        if self.unshy is not None:
            result["unshy"] = from_none(self.unshy)
        return result


@dataclass
class CimeliaClass:
    chirotherium: int
    catharticalness: float
    disdiapason: str
    homocerc: bool
    nonbookish: None

    @staticmethod
    def from_dict(obj: Any) -> 'CimeliaClass':
        assert isinstance(obj, dict)
        chirotherium = from_int(obj["Chirotherium"])
        catharticalness = from_float(obj["catharticalness"])
        disdiapason = from_str(obj["disdiapason"])
        homocerc = from_bool(obj["homocerc"])
        nonbookish = from_none(obj["nonbookish"])
        return CimeliaClass(chirotherium, catharticalness, disdiapason, homocerc, nonbookish)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Chirotherium"] = from_int(self.chirotherium)
        result["catharticalness"] = to_float(self.catharticalness)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


@dataclass
class CoadjustClass:
    benny: None
    chirotherium: int | None
    netherlandish: None
    phonelescope: None
    sedaceae: None
    amidosulphonal: None
    catharticalness: float | None
    disdiapason: str | None
    ensnare: None
    homocerc: bool | None
    hybridizer: None
    leastwise: None
    lof: None
    monkhood: None
    nonbookish: None
    peonism: None
    porphyrogeniture: None
    preindemnify: None
    rosal: None
    scalenous: None
    scopine: None
    suberinize: None
    symbiot: None
    tablefellow: None
    unchargeable: None

    @staticmethod
    def from_dict(obj: Any) -> 'CoadjustClass':
        assert isinstance(obj, dict)
        benny = from_none(obj.get("Benny"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        netherlandish = from_none(obj.get("Netherlandish"))
        phonelescope = from_none(obj.get("Phonelescope"))
        sedaceae = from_none(obj.get("Sedaceae"))
        amidosulphonal = from_none(obj.get("amidosulphonal"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ensnare = from_none(obj.get("ensnare"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        hybridizer = from_none(obj.get("hybridizer"))
        leastwise = from_none(obj.get("leastwise"))
        lof = from_none(obj.get("lof"))
        monkhood = from_none(obj.get("monkhood"))
        nonbookish = from_none(obj.get("nonbookish"))
        peonism = from_none(obj.get("peonism"))
        porphyrogeniture = from_none(obj.get("porphyrogeniture"))
        preindemnify = from_none(obj.get("preindemnify"))
        rosal = from_none(obj.get("rosal"))
        scalenous = from_none(obj.get("scalenous"))
        scopine = from_none(obj.get("scopine"))
        suberinize = from_none(obj.get("suberinize"))
        symbiot = from_none(obj.get("symbiot"))
        tablefellow = from_none(obj.get("tablefellow"))
        unchargeable = from_none(obj.get("unchargeable"))
        return CoadjustClass(benny, chirotherium, netherlandish, phonelescope, sedaceae, amidosulphonal, catharticalness, disdiapason, ensnare, homocerc, hybridizer, leastwise, lof, monkhood, nonbookish, peonism, porphyrogeniture, preindemnify, rosal, scalenous, scopine, suberinize, symbiot, tablefellow, unchargeable)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.benny is not None:
            result["Benny"] = from_none(self.benny)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.netherlandish is not None:
            result["Netherlandish"] = from_none(self.netherlandish)
        if self.phonelescope is not None:
            result["Phonelescope"] = from_none(self.phonelescope)
        if self.sedaceae is not None:
            result["Sedaceae"] = from_none(self.sedaceae)
        if self.amidosulphonal is not None:
            result["amidosulphonal"] = from_none(self.amidosulphonal)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.ensnare is not None:
            result["ensnare"] = from_none(self.ensnare)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.hybridizer is not None:
            result["hybridizer"] = from_none(self.hybridizer)
        if self.leastwise is not None:
            result["leastwise"] = from_none(self.leastwise)
        if self.lof is not None:
            result["lof"] = from_none(self.lof)
        if self.monkhood is not None:
            result["monkhood"] = from_none(self.monkhood)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.peonism is not None:
            result["peonism"] = from_none(self.peonism)
        if self.porphyrogeniture is not None:
            result["porphyrogeniture"] = from_none(self.porphyrogeniture)
        if self.preindemnify is not None:
            result["preindemnify"] = from_none(self.preindemnify)
        if self.rosal is not None:
            result["rosal"] = from_none(self.rosal)
        if self.scalenous is not None:
            result["scalenous"] = from_none(self.scalenous)
        if self.scopine is not None:
            result["scopine"] = from_none(self.scopine)
        if self.suberinize is not None:
            result["suberinize"] = from_none(self.suberinize)
        if self.symbiot is not None:
            result["symbiot"] = from_none(self.symbiot)
        if self.tablefellow is not None:
            result["tablefellow"] = from_none(self.tablefellow)
        if self.unchargeable is not None:
            result["unchargeable"] = from_none(self.unchargeable)
        return result


@dataclass
class CredulityClass:
    flavia: None
    hedychium: None
    popean: None
    ammonolytic: None
    bushmaster: None
    considering: None
    consuetudinary: None
    embarras: None
    fineness: None
    flaithship: None
    gruffly: None
    leadwort: None
    overseriously: None
    parabola: None
    pectinatodenticulate: None
    pornocrat: None
    quadrisect: None
    seriality: None
    vamphorn: None
    wharp: None

    @staticmethod
    def from_dict(obj: Any) -> 'CredulityClass':
        assert isinstance(obj, dict)
        flavia = from_none(obj["Flavia"])
        hedychium = from_none(obj["Hedychium"])
        popean = from_none(obj["Popean"])
        ammonolytic = from_none(obj["ammonolytic"])
        bushmaster = from_none(obj["bushmaster"])
        considering = from_none(obj["considering"])
        consuetudinary = from_none(obj["consuetudinary"])
        embarras = from_none(obj["embarras"])
        fineness = from_none(obj["fineness"])
        flaithship = from_none(obj["flaithship"])
        gruffly = from_none(obj["gruffly"])
        leadwort = from_none(obj["leadwort"])
        overseriously = from_none(obj["overseriously"])
        parabola = from_none(obj["parabola"])
        pectinatodenticulate = from_none(obj["pectinatodenticulate"])
        pornocrat = from_none(obj["pornocrat"])
        quadrisect = from_none(obj["quadrisect"])
        seriality = from_none(obj["seriality"])
        vamphorn = from_none(obj["vamphorn"])
        wharp = from_none(obj["wharp"])
        return CredulityClass(flavia, hedychium, popean, ammonolytic, bushmaster, considering, consuetudinary, embarras, fineness, flaithship, gruffly, leadwort, overseriously, parabola, pectinatodenticulate, pornocrat, quadrisect, seriality, vamphorn, wharp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Flavia"] = from_none(self.flavia)
        result["Hedychium"] = from_none(self.hedychium)
        result["Popean"] = from_none(self.popean)
        result["ammonolytic"] = from_none(self.ammonolytic)
        result["bushmaster"] = from_none(self.bushmaster)
        result["considering"] = from_none(self.considering)
        result["consuetudinary"] = from_none(self.consuetudinary)
        result["embarras"] = from_none(self.embarras)
        result["fineness"] = from_none(self.fineness)
        result["flaithship"] = from_none(self.flaithship)
        result["gruffly"] = from_none(self.gruffly)
        result["leadwort"] = from_none(self.leadwort)
        result["overseriously"] = from_none(self.overseriously)
        result["parabola"] = from_none(self.parabola)
        result["pectinatodenticulate"] = from_none(self.pectinatodenticulate)
        result["pornocrat"] = from_none(self.pornocrat)
        result["quadrisect"] = from_none(self.quadrisect)
        result["seriality"] = from_none(self.seriality)
        result["vamphorn"] = from_none(self.vamphorn)
        result["wharp"] = from_none(self.wharp)
        return result


@dataclass
class DeruralizeClass:
    jehovistic: None
    paninean: None
    romney: None
    bockerel: None
    boulder: None
    churrus: None
    counterdigged: None
    dialogite: None
    digenic: None
    dunbird: None
    ergatogyne: None
    fiendful: None
    jackrod: None
    panther: None
    placentigerous: None
    sparm: None
    tocsin: None
    unnicked: None
    unstavable: None
    windfirm: None

    @staticmethod
    def from_dict(obj: Any) -> 'DeruralizeClass':
        assert isinstance(obj, dict)
        jehovistic = from_none(obj["Jehovistic"])
        paninean = from_none(obj["Paninean"])
        romney = from_none(obj["Romney"])
        bockerel = from_none(obj["bockerel"])
        boulder = from_none(obj["boulder"])
        churrus = from_none(obj["churrus"])
        counterdigged = from_none(obj["counterdigged"])
        dialogite = from_none(obj["dialogite"])
        digenic = from_none(obj["digenic"])
        dunbird = from_none(obj["dunbird"])
        ergatogyne = from_none(obj["ergatogyne"])
        fiendful = from_none(obj["fiendful"])
        jackrod = from_none(obj["jackrod"])
        panther = from_none(obj["panther"])
        placentigerous = from_none(obj["placentigerous"])
        sparm = from_none(obj["sparm"])
        tocsin = from_none(obj["tocsin"])
        unnicked = from_none(obj["unnicked"])
        unstavable = from_none(obj["unstavable"])
        windfirm = from_none(obj["windfirm"])
        return DeruralizeClass(jehovistic, paninean, romney, bockerel, boulder, churrus, counterdigged, dialogite, digenic, dunbird, ergatogyne, fiendful, jackrod, panther, placentigerous, sparm, tocsin, unnicked, unstavable, windfirm)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Jehovistic"] = from_none(self.jehovistic)
        result["Paninean"] = from_none(self.paninean)
        result["Romney"] = from_none(self.romney)
        result["bockerel"] = from_none(self.bockerel)
        result["boulder"] = from_none(self.boulder)
        result["churrus"] = from_none(self.churrus)
        result["counterdigged"] = from_none(self.counterdigged)
        result["dialogite"] = from_none(self.dialogite)
        result["digenic"] = from_none(self.digenic)
        result["dunbird"] = from_none(self.dunbird)
        result["ergatogyne"] = from_none(self.ergatogyne)
        result["fiendful"] = from_none(self.fiendful)
        result["jackrod"] = from_none(self.jackrod)
        result["panther"] = from_none(self.panther)
        result["placentigerous"] = from_none(self.placentigerous)
        result["sparm"] = from_none(self.sparm)
        result["tocsin"] = from_none(self.tocsin)
        result["unnicked"] = from_none(self.unnicked)
        result["unstavable"] = from_none(self.unstavable)
        result["windfirm"] = from_none(self.windfirm)
        return result


@dataclass
class DiaereseClass:
    amoreuxia: None
    ani: None
    bernicle: None
    blackwasher: None
    blowhard: None
    broma: None
    closecross: None
    congregationalism: None
    grayly: None
    historically: None
    hoast: None
    irretentive: None
    parcener: None
    pedder: None
    pseudoanatomic: None
    rhizocarpian: None
    samel: None
    silker: None
    subdentated: None
    subobscure: None

    @staticmethod
    def from_dict(obj: Any) -> 'DiaereseClass':
        assert isinstance(obj, dict)
        amoreuxia = from_none(obj["Amoreuxia"])
        ani = from_none(obj["ani"])
        bernicle = from_none(obj["bernicle"])
        blackwasher = from_none(obj["blackwasher"])
        blowhard = from_none(obj["blowhard"])
        broma = from_none(obj["broma"])
        closecross = from_none(obj["closecross"])
        congregationalism = from_none(obj["congregationalism"])
        grayly = from_none(obj["grayly"])
        historically = from_none(obj["historically"])
        hoast = from_none(obj["hoast"])
        irretentive = from_none(obj["irretentive"])
        parcener = from_none(obj["parcener"])
        pedder = from_none(obj["pedder"])
        pseudoanatomic = from_none(obj["pseudoanatomic"])
        rhizocarpian = from_none(obj["rhizocarpian"])
        samel = from_none(obj["samel"])
        silker = from_none(obj["silker"])
        subdentated = from_none(obj["subdentated"])
        subobscure = from_none(obj["subobscure"])
        return DiaereseClass(amoreuxia, ani, bernicle, blackwasher, blowhard, broma, closecross, congregationalism, grayly, historically, hoast, irretentive, parcener, pedder, pseudoanatomic, rhizocarpian, samel, silker, subdentated, subobscure)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Amoreuxia"] = from_none(self.amoreuxia)
        result["ani"] = from_none(self.ani)
        result["bernicle"] = from_none(self.bernicle)
        result["blackwasher"] = from_none(self.blackwasher)
        result["blowhard"] = from_none(self.blowhard)
        result["broma"] = from_none(self.broma)
        result["closecross"] = from_none(self.closecross)
        result["congregationalism"] = from_none(self.congregationalism)
        result["grayly"] = from_none(self.grayly)
        result["historically"] = from_none(self.historically)
        result["hoast"] = from_none(self.hoast)
        result["irretentive"] = from_none(self.irretentive)
        result["parcener"] = from_none(self.parcener)
        result["pedder"] = from_none(self.pedder)
        result["pseudoanatomic"] = from_none(self.pseudoanatomic)
        result["rhizocarpian"] = from_none(self.rhizocarpian)
        result["samel"] = from_none(self.samel)
        result["silker"] = from_none(self.silker)
        result["subdentated"] = from_none(self.subdentated)
        result["subobscure"] = from_none(self.subobscure)
        return result


@dataclass
class Encrust:
    hibernia: None
    hibiscus: None
    lepidosauria: None
    syllidae: None
    comradely: None
    diacanthous: None
    feminineness: None
    gossamered: None
    lollingly: None
    manager: None
    mechanic: None
    overminuteness: None
    papelonne: None
    plebification: None
    pugmiller: None
    recoveror: None
    spermatoblastic: None
    ungyved: None
    whirlabout: None
    woodenware: None

    @staticmethod
    def from_dict(obj: Any) -> 'Encrust':
        assert isinstance(obj, dict)
        hibernia = from_none(obj["Hibernia"])
        hibiscus = from_none(obj["Hibiscus"])
        lepidosauria = from_none(obj["Lepidosauria"])
        syllidae = from_none(obj["Syllidae"])
        comradely = from_none(obj["comradely"])
        diacanthous = from_none(obj["diacanthous"])
        feminineness = from_none(obj["feminineness"])
        gossamered = from_none(obj["gossamered"])
        lollingly = from_none(obj["lollingly"])
        manager = from_none(obj["manager"])
        mechanic = from_none(obj["mechanic"])
        overminuteness = from_none(obj["overminuteness"])
        papelonne = from_none(obj["papelonne"])
        plebification = from_none(obj["plebification"])
        pugmiller = from_none(obj["pugmiller"])
        recoveror = from_none(obj["recoveror"])
        spermatoblastic = from_none(obj["spermatoblastic"])
        ungyved = from_none(obj["ungyved"])
        whirlabout = from_none(obj["whirlabout"])
        woodenware = from_none(obj["woodenware"])
        return Encrust(hibernia, hibiscus, lepidosauria, syllidae, comradely, diacanthous, feminineness, gossamered, lollingly, manager, mechanic, overminuteness, papelonne, plebification, pugmiller, recoveror, spermatoblastic, ungyved, whirlabout, woodenware)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hibernia"] = from_none(self.hibernia)
        result["Hibiscus"] = from_none(self.hibiscus)
        result["Lepidosauria"] = from_none(self.lepidosauria)
        result["Syllidae"] = from_none(self.syllidae)
        result["comradely"] = from_none(self.comradely)
        result["diacanthous"] = from_none(self.diacanthous)
        result["feminineness"] = from_none(self.feminineness)
        result["gossamered"] = from_none(self.gossamered)
        result["lollingly"] = from_none(self.lollingly)
        result["manager"] = from_none(self.manager)
        result["mechanic"] = from_none(self.mechanic)
        result["overminuteness"] = from_none(self.overminuteness)
        result["papelonne"] = from_none(self.papelonne)
        result["plebification"] = from_none(self.plebification)
        result["pugmiller"] = from_none(self.pugmiller)
        result["recoveror"] = from_none(self.recoveror)
        result["spermatoblastic"] = from_none(self.spermatoblastic)
        result["ungyved"] = from_none(self.ungyved)
        result["whirlabout"] = from_none(self.whirlabout)
        result["woodenware"] = from_none(self.woodenware)
        return result


@dataclass
class FagginglyClass:
    anglic: None
    heteromeri: None
    poinsettia: None
    abranchian: None
    aculeiform: None
    adiaphoristic: None
    adoptionism: None
    antrotomy: None
    coerciveness: None
    decorist: None
    duckhood: None
    hypochnose: None
    lochage: None
    melee: None
    nonconformitant: None
    putatively: None
    semivolatile: None
    soleas: None
    unfastenable: None
    unmillinered: None

    @staticmethod
    def from_dict(obj: Any) -> 'FagginglyClass':
        assert isinstance(obj, dict)
        anglic = from_none(obj["Anglic"])
        heteromeri = from_none(obj["Heteromeri"])
        poinsettia = from_none(obj["Poinsettia"])
        abranchian = from_none(obj["abranchian"])
        aculeiform = from_none(obj["aculeiform"])
        adiaphoristic = from_none(obj["adiaphoristic"])
        adoptionism = from_none(obj["adoptionism"])
        antrotomy = from_none(obj["antrotomy"])
        coerciveness = from_none(obj["coerciveness"])
        decorist = from_none(obj["decorist"])
        duckhood = from_none(obj["duckhood"])
        hypochnose = from_none(obj["hypochnose"])
        lochage = from_none(obj["lochage"])
        melee = from_none(obj["melee"])
        nonconformitant = from_none(obj["nonconformitant"])
        putatively = from_none(obj["putatively"])
        semivolatile = from_none(obj["semivolatile"])
        soleas = from_none(obj["soleas"])
        unfastenable = from_none(obj["unfastenable"])
        unmillinered = from_none(obj["unmillinered"])
        return FagginglyClass(anglic, heteromeri, poinsettia, abranchian, aculeiform, adiaphoristic, adoptionism, antrotomy, coerciveness, decorist, duckhood, hypochnose, lochage, melee, nonconformitant, putatively, semivolatile, soleas, unfastenable, unmillinered)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Anglic"] = from_none(self.anglic)
        result["Heteromeri"] = from_none(self.heteromeri)
        result["Poinsettia"] = from_none(self.poinsettia)
        result["abranchian"] = from_none(self.abranchian)
        result["aculeiform"] = from_none(self.aculeiform)
        result["adiaphoristic"] = from_none(self.adiaphoristic)
        result["adoptionism"] = from_none(self.adoptionism)
        result["antrotomy"] = from_none(self.antrotomy)
        result["coerciveness"] = from_none(self.coerciveness)
        result["decorist"] = from_none(self.decorist)
        result["duckhood"] = from_none(self.duckhood)
        result["hypochnose"] = from_none(self.hypochnose)
        result["lochage"] = from_none(self.lochage)
        result["melee"] = from_none(self.melee)
        result["nonconformitant"] = from_none(self.nonconformitant)
        result["putatively"] = from_none(self.putatively)
        result["semivolatile"] = from_none(self.semivolatile)
        result["soleas"] = from_none(self.soleas)
        result["unfastenable"] = from_none(self.unfastenable)
        result["unmillinered"] = from_none(self.unmillinered)
        return result


@dataclass
class FenkClass:
    dagomba: None
    guyandot: None
    reinwardtia: None
    tritoness: None
    apoise: None
    astronomize: None
    cockhorse: None
    copular: None
    draffy: None
    foreigner: None
    neurogliosis: None
    osmious: None
    palpitate: None
    rebukeable: None
    reservatory: None
    scalt: None
    scripturalize: None
    tintometer: None
    undergrade: None
    undermountain: None

    @staticmethod
    def from_dict(obj: Any) -> 'FenkClass':
        assert isinstance(obj, dict)
        dagomba = from_none(obj["Dagomba"])
        guyandot = from_none(obj["Guyandot"])
        reinwardtia = from_none(obj["Reinwardtia"])
        tritoness = from_none(obj["Tritoness"])
        apoise = from_none(obj["apoise"])
        astronomize = from_none(obj["astronomize"])
        cockhorse = from_none(obj["cockhorse"])
        copular = from_none(obj["copular"])
        draffy = from_none(obj["draffy"])
        foreigner = from_none(obj["foreigner"])
        neurogliosis = from_none(obj["neurogliosis"])
        osmious = from_none(obj["osmious"])
        palpitate = from_none(obj["palpitate"])
        rebukeable = from_none(obj["rebukeable"])
        reservatory = from_none(obj["reservatory"])
        scalt = from_none(obj["scalt"])
        scripturalize = from_none(obj["scripturalize"])
        tintometer = from_none(obj["tintometer"])
        undergrade = from_none(obj["undergrade"])
        undermountain = from_none(obj["undermountain"])
        return FenkClass(dagomba, guyandot, reinwardtia, tritoness, apoise, astronomize, cockhorse, copular, draffy, foreigner, neurogliosis, osmious, palpitate, rebukeable, reservatory, scalt, scripturalize, tintometer, undergrade, undermountain)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Dagomba"] = from_none(self.dagomba)
        result["Guyandot"] = from_none(self.guyandot)
        result["Reinwardtia"] = from_none(self.reinwardtia)
        result["Tritoness"] = from_none(self.tritoness)
        result["apoise"] = from_none(self.apoise)
        result["astronomize"] = from_none(self.astronomize)
        result["cockhorse"] = from_none(self.cockhorse)
        result["copular"] = from_none(self.copular)
        result["draffy"] = from_none(self.draffy)
        result["foreigner"] = from_none(self.foreigner)
        result["neurogliosis"] = from_none(self.neurogliosis)
        result["osmious"] = from_none(self.osmious)
        result["palpitate"] = from_none(self.palpitate)
        result["rebukeable"] = from_none(self.rebukeable)
        result["reservatory"] = from_none(self.reservatory)
        result["scalt"] = from_none(self.scalt)
        result["scripturalize"] = from_none(self.scripturalize)
        result["tintometer"] = from_none(self.tintometer)
        result["undergrade"] = from_none(self.undergrade)
        result["undermountain"] = from_none(self.undermountain)
        return result


@dataclass
class FlagmakingClass:
    bunodonta: None
    hydrocorisae: None
    notacanthidae: None
    albarco: None
    hornify: None
    hypoglossus: None
    inexpiably: None
    ingratitude: None
    ladyfly: None
    medicament: None
    monogrammatic: None
    nobbut: None
    polyplacophore: None
    proexercise: None
    protoplast: None
    puzzling: None
    splanchnoskeleton: None
    unloveliness: None
    unquarantined: None
    unrenounceable: None

    @staticmethod
    def from_dict(obj: Any) -> 'FlagmakingClass':
        assert isinstance(obj, dict)
        bunodonta = from_none(obj["Bunodonta"])
        hydrocorisae = from_none(obj["Hydrocorisae"])
        notacanthidae = from_none(obj["Notacanthidae"])
        albarco = from_none(obj["albarco"])
        hornify = from_none(obj["hornify"])
        hypoglossus = from_none(obj["hypoglossus"])
        inexpiably = from_none(obj["inexpiably"])
        ingratitude = from_none(obj["ingratitude"])
        ladyfly = from_none(obj["ladyfly"])
        medicament = from_none(obj["medicament"])
        monogrammatic = from_none(obj["monogrammatic"])
        nobbut = from_none(obj["nobbut"])
        polyplacophore = from_none(obj["polyplacophore"])
        proexercise = from_none(obj["proexercise"])
        protoplast = from_none(obj["protoplast"])
        puzzling = from_none(obj["puzzling"])
        splanchnoskeleton = from_none(obj["splanchnoskeleton"])
        unloveliness = from_none(obj["unloveliness"])
        unquarantined = from_none(obj["unquarantined"])
        unrenounceable = from_none(obj["unrenounceable"])
        return FlagmakingClass(bunodonta, hydrocorisae, notacanthidae, albarco, hornify, hypoglossus, inexpiably, ingratitude, ladyfly, medicament, monogrammatic, nobbut, polyplacophore, proexercise, protoplast, puzzling, splanchnoskeleton, unloveliness, unquarantined, unrenounceable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Bunodonta"] = from_none(self.bunodonta)
        result["Hydrocorisae"] = from_none(self.hydrocorisae)
        result["Notacanthidae"] = from_none(self.notacanthidae)
        result["albarco"] = from_none(self.albarco)
        result["hornify"] = from_none(self.hornify)
        result["hypoglossus"] = from_none(self.hypoglossus)
        result["inexpiably"] = from_none(self.inexpiably)
        result["ingratitude"] = from_none(self.ingratitude)
        result["ladyfly"] = from_none(self.ladyfly)
        result["medicament"] = from_none(self.medicament)
        result["monogrammatic"] = from_none(self.monogrammatic)
        result["nobbut"] = from_none(self.nobbut)
        result["polyplacophore"] = from_none(self.polyplacophore)
        result["proexercise"] = from_none(self.proexercise)
        result["protoplast"] = from_none(self.protoplast)
        result["puzzling"] = from_none(self.puzzling)
        result["splanchnoskeleton"] = from_none(self.splanchnoskeleton)
        result["unloveliness"] = from_none(self.unloveliness)
        result["unquarantined"] = from_none(self.unquarantined)
        result["unrenounceable"] = from_none(self.unrenounceable)
        return result


@dataclass
class HemocoeleClass:
    chirotherium: int | None
    walt: None
    acrogamy: None
    amelification: None
    autobiographic: None
    berat: None
    catharticalness: float | None
    disdiapason: str | None
    disproportionably: None
    erythrite: None
    graphic: None
    hepatological: None
    homocerc: bool | None
    incommensurably: None
    misaffirm: None
    nonbookish: None
    pocketbook: None
    sclerometric: None
    stambouline: None
    stickpin: None
    tubulure: None
    undelated: None
    unsalt: None
    untutelar: None
    vagrant: None

    @staticmethod
    def from_dict(obj: Any) -> 'HemocoeleClass':
        assert isinstance(obj, dict)
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        walt = from_none(obj.get("Walt"))
        acrogamy = from_none(obj.get("acrogamy"))
        amelification = from_none(obj.get("amelification"))
        autobiographic = from_none(obj.get("autobiographic"))
        berat = from_none(obj.get("berat"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        disproportionably = from_none(obj.get("disproportionably"))
        erythrite = from_none(obj.get("erythrite"))
        graphic = from_none(obj.get("graphic"))
        hepatological = from_none(obj.get("hepatological"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        incommensurably = from_none(obj.get("incommensurably"))
        misaffirm = from_none(obj.get("misaffirm"))
        nonbookish = from_none(obj.get("nonbookish"))
        pocketbook = from_none(obj.get("pocketbook"))
        sclerometric = from_none(obj.get("sclerometric"))
        stambouline = from_none(obj.get("stambouline"))
        stickpin = from_none(obj.get("stickpin"))
        tubulure = from_none(obj.get("tubulure"))
        undelated = from_none(obj.get("undelated"))
        unsalt = from_none(obj.get("unsalt"))
        untutelar = from_none(obj.get("untutelar"))
        vagrant = from_none(obj.get("vagrant"))
        return HemocoeleClass(chirotherium, walt, acrogamy, amelification, autobiographic, berat, catharticalness, disdiapason, disproportionably, erythrite, graphic, hepatological, homocerc, incommensurably, misaffirm, nonbookish, pocketbook, sclerometric, stambouline, stickpin, tubulure, undelated, unsalt, untutelar, vagrant)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.walt is not None:
            result["Walt"] = from_none(self.walt)
        if self.acrogamy is not None:
            result["acrogamy"] = from_none(self.acrogamy)
        if self.amelification is not None:
            result["amelification"] = from_none(self.amelification)
        if self.autobiographic is not None:
            result["autobiographic"] = from_none(self.autobiographic)
        if self.berat is not None:
            result["berat"] = from_none(self.berat)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.disproportionably is not None:
            result["disproportionably"] = from_none(self.disproportionably)
        if self.erythrite is not None:
            result["erythrite"] = from_none(self.erythrite)
        if self.graphic is not None:
            result["graphic"] = from_none(self.graphic)
        if self.hepatological is not None:
            result["hepatological"] = from_none(self.hepatological)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.incommensurably is not None:
            result["incommensurably"] = from_none(self.incommensurably)
        if self.misaffirm is not None:
            result["misaffirm"] = from_none(self.misaffirm)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.pocketbook is not None:
            result["pocketbook"] = from_none(self.pocketbook)
        if self.sclerometric is not None:
            result["sclerometric"] = from_none(self.sclerometric)
        if self.stambouline is not None:
            result["stambouline"] = from_none(self.stambouline)
        if self.stickpin is not None:
            result["stickpin"] = from_none(self.stickpin)
        if self.tubulure is not None:
            result["tubulure"] = from_none(self.tubulure)
        if self.undelated is not None:
            result["undelated"] = from_none(self.undelated)
        if self.unsalt is not None:
            result["unsalt"] = from_none(self.unsalt)
        if self.untutelar is not None:
            result["untutelar"] = from_none(self.untutelar)
        if self.vagrant is not None:
            result["vagrant"] = from_none(self.vagrant)
        return result


@dataclass
class Interacinar:
    assapan: float
    benefactorship: bool
    triseriatim: str
    tubbing: int
    untrimmed: None

    @staticmethod
    def from_dict(obj: Any) -> 'Interacinar':
        assert isinstance(obj, dict)
        assapan = from_float(obj["assapan"])
        benefactorship = from_bool(obj["benefactorship"])
        triseriatim = from_str(obj["triseriatim"])
        tubbing = from_int(obj["tubbing"])
        untrimmed = from_none(obj["untrimmed"])
        return Interacinar(assapan, benefactorship, triseriatim, tubbing, untrimmed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["assapan"] = to_float(self.assapan)
        result["benefactorship"] = from_bool(self.benefactorship)
        result["triseriatim"] = from_str(self.triseriatim)
        result["tubbing"] = from_int(self.tubbing)
        result["untrimmed"] = from_none(self.untrimmed)
        return result


@dataclass
class TopLevel:
    centrodesmose: str
    cerograph: list[CerographClass | str | None]
    chemotherapeutics: list[ChemotherapeuticClass | int]
    cimelia: list[list[int] | CimeliaClass | None]
    citrated: int
    clinodome: list[float | str]
    coadjust: list[CoadjustClass | float]
    consilience: list[float | dict[str, int]]
    constructor: list[bool | dict[str, int | None]]
    continuative: list[dict[str, int] | str]
    credulity: list[CredulityClass | int | str]
    creviced: list[bool | dict[str, int] | str]
    cubiculum: list[list[int | None]]
    deruralize: list[list[None] | bool | DeruralizeClass]
    diaereses: list[list[int] | bool | DiaereseClass]
    dissolution: list[list[None] | None]
    downstroke: list[list[None] | bool | str]
    electrotautomerism: list[float | None]
    eleutheromania: list[float | dict[str, int] | str]
    encrust: Encrust
    entomoid: list[CimeliaClass | int]
    epipaleolithic: list[list[int] | float]
    expropriable: list[list[None] | CimeliaClass | float]
    faggingly: list[FagginglyClass | float]
    fenks: list[FenkClass | str]
    flagmaking: list[bool | FlagmakingClass | float]
    fluorometer: list[int | str | None]
    fulsome: list[int | None]
    fuzzy: list[int | dict[str, int | None]]
    gardenwards: list[list[int] | bool | str]
    generalissimo: list[bool | dict[str, int] | None]
    habeas: list[dict[str, int] | None]
    hemicrystalline: list[CimeliaClass | str]
    hemocoele: list[list[int] | HemocoeleClass]
    hoister: list[CimeliaClass | str | None]
    hyperpiesis: list[list[None] | CimeliaClass | None]
    hyppish: list[bool | str | None]
    idealizer: list[list[None] | CimeliaClass | int]
    incrustator: list[list[int] | int | str]
    intentiveness: list[CimeliaClass | float | str]
    interacinar: Interacinar
    intercorrelation: list[list[int] | None]
    jacutinga: list[list[int] | dict[str, int | None]]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        centrodesmose = from_str(obj["centrodesmose"])
        cerograph = from_list(lambda x: from_union([CerographClass.from_dict, from_none, from_str], x), obj["cerograph"])
        chemotherapeutics = from_list(lambda x: from_union([ChemotherapeuticClass.from_dict, from_int], x), obj["chemotherapeutics"])
        cimelia = from_list(lambda x: from_union([lambda x: from_list(from_int, x), CimeliaClass.from_dict, from_none], x), obj["cimelia"])
        citrated = from_int(obj["citrated"])
        clinodome = from_list(lambda x: from_union([from_float, from_str], x), obj["clinodome"])
        coadjust = from_list(lambda x: from_union([CoadjustClass.from_dict, from_float], x), obj["coadjust"])
        consilience = from_list(lambda x: from_union([from_float, lambda x: from_dict(from_int, x)], x), obj["consilience"])
        constructor = from_list(lambda x: from_union([from_bool, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), obj["constructor"])
        continuative = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_str], x), obj["continuative"])
        credulity = from_list(lambda x: from_union([CredulityClass.from_dict, from_int, from_str], x), obj["credulity"])
        creviced = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x), from_str], x), obj["creviced"])
        cubiculum = from_list(lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), obj["cubiculum"])
        deruralize = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, DeruralizeClass.from_dict], x), obj["deruralize"])
        diaereses = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, DiaereseClass.from_dict], x), obj["diaereses"])
        dissolution = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_none], x), obj["dissolution"])
        downstroke = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_str], x), obj["downstroke"])
        electrotautomerism = from_list(lambda x: from_union([from_float, from_none], x), obj["electrotautomerism"])
        eleutheromania = from_list(lambda x: from_union([from_float, lambda x: from_dict(from_int, x), from_str], x), obj["eleutheromania"])
        encrust = Encrust.from_dict(obj["encrust"])
        entomoid = from_list(lambda x: from_union([CimeliaClass.from_dict, from_int], x), obj["entomoid"])
        epipaleolithic = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_float], x), obj["epipaleolithic"])
        expropriable = from_list(lambda x: from_union([lambda x: from_list(from_none, x), CimeliaClass.from_dict, from_float], x), obj["expropriable"])
        faggingly = from_list(lambda x: from_union([FagginglyClass.from_dict, from_float], x), obj["faggingly"])
        fenks = from_list(lambda x: from_union([FenkClass.from_dict, from_str], x), obj["fenks"])
        flagmaking = from_list(lambda x: from_union([from_bool, FlagmakingClass.from_dict, from_float], x), obj["flagmaking"])
        fluorometer = from_list(lambda x: from_union([from_int, from_none, from_str], x), obj["fluorometer"])
        fulsome = from_list(lambda x: from_union([from_int, from_none], x), obj["fulsome"])
        fuzzy = from_list(lambda x: from_union([from_int, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), obj["fuzzy"])
        gardenwards = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_str], x), obj["gardenwards"])
        generalissimo = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x), from_none], x), obj["generalissimo"])
        habeas = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_none], x), obj["habeas"])
        hemicrystalline = from_list(lambda x: from_union([CimeliaClass.from_dict, from_str], x), obj["hemicrystalline"])
        hemocoele = from_list(lambda x: from_union([lambda x: from_list(from_int, x), HemocoeleClass.from_dict], x), obj["hemocoele"])
        hoister = from_list(lambda x: from_union([CimeliaClass.from_dict, from_none, from_str], x), obj["hoister"])
        hyperpiesis = from_list(lambda x: from_union([lambda x: from_list(from_none, x), CimeliaClass.from_dict, from_none], x), obj["hyperpiesis"])
        hyppish = from_list(lambda x: from_union([from_bool, from_none, from_str], x), obj["hyppish"])
        idealizer = from_list(lambda x: from_union([lambda x: from_list(from_none, x), CimeliaClass.from_dict, from_int], x), obj["idealizer"])
        incrustator = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_str], x), obj["incrustator"])
        intentiveness = from_list(lambda x: from_union([CimeliaClass.from_dict, from_float, from_str], x), obj["intentiveness"])
        interacinar = Interacinar.from_dict(obj["interacinar"])
        intercorrelation = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_none], x), obj["intercorrelation"])
        jacutinga = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), obj["jacutinga"])
        return TopLevel(centrodesmose, cerograph, chemotherapeutics, cimelia, citrated, clinodome, coadjust, consilience, constructor, continuative, credulity, creviced, cubiculum, deruralize, diaereses, dissolution, downstroke, electrotautomerism, eleutheromania, encrust, entomoid, epipaleolithic, expropriable, faggingly, fenks, flagmaking, fluorometer, fulsome, fuzzy, gardenwards, generalissimo, habeas, hemicrystalline, hemocoele, hoister, hyperpiesis, hyppish, idealizer, incrustator, intentiveness, interacinar, intercorrelation, jacutinga)

    def to_dict(self) -> dict:
        result: dict = {}
        result["centrodesmose"] = from_str(self.centrodesmose)
        result["cerograph"] = from_list(lambda x: from_union([lambda x: to_class(CerographClass, x), from_none, from_str], x), self.cerograph)
        result["chemotherapeutics"] = from_list(lambda x: from_union([lambda x: to_class(ChemotherapeuticClass, x), from_int], x), self.chemotherapeutics)
        result["cimelia"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(CimeliaClass, x), from_none], x), self.cimelia)
        result["citrated"] = from_int(self.citrated)
        result["clinodome"] = from_list(lambda x: from_union([to_float, from_str], x), self.clinodome)
        result["coadjust"] = from_list(lambda x: from_union([lambda x: to_class(CoadjustClass, x), to_float], x), self.coadjust)
        result["consilience"] = from_list(lambda x: from_union([to_float, lambda x: from_dict(from_int, x)], x), self.consilience)
        result["constructor"] = from_list(lambda x: from_union([from_bool, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), self.constructor)
        result["continuative"] = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_str], x), self.continuative)
        result["credulity"] = from_list(lambda x: from_union([lambda x: to_class(CredulityClass, x), from_int, from_str], x), self.credulity)
        result["creviced"] = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x), from_str], x), self.creviced)
        result["cubiculum"] = from_list(lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), self.cubiculum)
        result["deruralize"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, lambda x: to_class(DeruralizeClass, x)], x), self.deruralize)
        result["diaereses"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, lambda x: to_class(DiaereseClass, x)], x), self.diaereses)
        result["dissolution"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_none], x), self.dissolution)
        result["downstroke"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_str], x), self.downstroke)
        result["electrotautomerism"] = from_list(lambda x: from_union([to_float, from_none], x), self.electrotautomerism)
        result["eleutheromania"] = from_list(lambda x: from_union([to_float, lambda x: from_dict(from_int, x), from_str], x), self.eleutheromania)
        result["encrust"] = to_class(Encrust, self.encrust)
        result["entomoid"] = from_list(lambda x: from_union([lambda x: to_class(CimeliaClass, x), from_int], x), self.entomoid)
        result["epipaleolithic"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), to_float], x), self.epipaleolithic)
        result["expropriable"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(CimeliaClass, x), to_float], x), self.expropriable)
        result["faggingly"] = from_list(lambda x: from_union([lambda x: to_class(FagginglyClass, x), to_float], x), self.faggingly)
        result["fenks"] = from_list(lambda x: from_union([lambda x: to_class(FenkClass, x), from_str], x), self.fenks)
        result["flagmaking"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(FlagmakingClass, x), to_float], x), self.flagmaking)
        result["fluorometer"] = from_list(lambda x: from_union([from_int, from_none, from_str], x), self.fluorometer)
        result["fulsome"] = from_list(lambda x: from_union([from_int, from_none], x), self.fulsome)
        result["fuzzy"] = from_list(lambda x: from_union([from_int, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), self.fuzzy)
        result["gardenwards"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, from_str], x), self.gardenwards)
        result["generalissimo"] = from_list(lambda x: from_union([from_bool, lambda x: from_dict(from_int, x), from_none], x), self.generalissimo)
        result["habeas"] = from_list(lambda x: from_union([lambda x: from_dict(from_int, x), from_none], x), self.habeas)
        result["hemicrystalline"] = from_list(lambda x: from_union([lambda x: to_class(CimeliaClass, x), from_str], x), self.hemicrystalline)
        result["hemocoele"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(HemocoeleClass, x)], x), self.hemocoele)
        result["hoister"] = from_list(lambda x: from_union([lambda x: to_class(CimeliaClass, x), from_none, from_str], x), self.hoister)
        result["hyperpiesis"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(CimeliaClass, x), from_none], x), self.hyperpiesis)
        result["hyppish"] = from_list(lambda x: from_union([from_bool, from_none, from_str], x), self.hyppish)
        result["idealizer"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(CimeliaClass, x), from_int], x), self.idealizer)
        result["incrustator"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_str], x), self.incrustator)
        result["intentiveness"] = from_list(lambda x: from_union([lambda x: to_class(CimeliaClass, x), to_float, from_str], x), self.intentiveness)
        result["interacinar"] = to_class(Interacinar, self.interacinar)
        result["intercorrelation"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_none], x), self.intercorrelation)
        result["jacutinga"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), self.jacutinga)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
