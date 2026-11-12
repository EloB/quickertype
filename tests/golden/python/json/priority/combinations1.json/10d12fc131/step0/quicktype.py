def from_none(x):
    assert x is None
    return x


def from_float(x):
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_int(x):
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x):
    assert isinstance(x, str)
    return x


def from_bool(x):
    assert isinstance(x, bool)
    return x


def to_float(x):
    assert isinstance(x, (int, float))
    return x


def from_list(f, x):
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_dict(f, x):
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c, x):
    assert isinstance(x, c)
    return x.to_dict()


class CerographClass:
    def __init__(self, apotropaion, casuary, creaker, disqualification, imperatorious, impermeabilize, metastoma, noctidiurnal, nonreserve, ophthalmotonometry, pailful, pigfish, pongee, prosodical, scrofuloderm, storekeeping, therologist, tolowa, tradeful, unriveting):
        self.apotropaion = apotropaion
        self.casuary = casuary
        self.creaker = creaker
        self.disqualification = disqualification
        self.imperatorious = imperatorious
        self.impermeabilize = impermeabilize
        self.metastoma = metastoma
        self.noctidiurnal = noctidiurnal
        self.nonreserve = nonreserve
        self.ophthalmotonometry = ophthalmotonometry
        self.pailful = pailful
        self.pigfish = pigfish
        self.pongee = pongee
        self.prosodical = prosodical
        self.scrofuloderm = scrofuloderm
        self.storekeeping = storekeeping
        self.therologist = therologist
        self.tolowa = tolowa
        self.tradeful = tradeful
        self.unriveting = unriveting

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
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
        tolowa = from_none(obj["Tolowa"])
        tradeful = from_none(obj["tradeful"])
        unriveting = from_none(obj["unriveting"])
        return CerographClass(apotropaion, casuary, creaker, disqualification, imperatorious, impermeabilize, metastoma, noctidiurnal, nonreserve, ophthalmotonometry, pailful, pigfish, pongee, prosodical, scrofuloderm, storekeeping, therologist, tolowa, tradeful, unriveting)

    def to_dict(self):
        result = {}
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
        result["Tolowa"] = from_none(self.tolowa)
        result["tradeful"] = from_none(self.tradeful)
        result["unriveting"] = from_none(self.unriveting)
        return result


class ChemotherapeuticClass:
    def __init__(self, angioneurotic, availment, bladelet, catharticalness, caulis, chalcus, chirotherium, disdiapason, enteradenological, homocerc, imporosity, insistently, intraparietal, ivied, maureen, nonbookish, nostochine, nutcracker, ofttimes, phenocryst, precoincident, ramiferous, stagmometer, tetherball, unshy):
        self.angioneurotic = angioneurotic
        self.availment = availment
        self.bladelet = bladelet
        self.catharticalness = catharticalness
        self.caulis = caulis
        self.chalcus = chalcus
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.enteradenological = enteradenological
        self.homocerc = homocerc
        self.imporosity = imporosity
        self.insistently = insistently
        self.intraparietal = intraparietal
        self.ivied = ivied
        self.maureen = maureen
        self.nonbookish = nonbookish
        self.nostochine = nostochine
        self.nutcracker = nutcracker
        self.ofttimes = ofttimes
        self.phenocryst = phenocryst
        self.precoincident = precoincident
        self.ramiferous = ramiferous
        self.stagmometer = stagmometer
        self.tetherball = tetherball
        self.unshy = unshy

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        angioneurotic = from_none(obj.get("angioneurotic"))
        availment = from_none(obj.get("availment"))
        bladelet = from_none(obj.get("bladelet"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        caulis = from_none(obj.get("caulis"))
        chalcus = from_none(obj.get("chalcus"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        enteradenological = from_none(obj.get("enteradenological"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        imporosity = from_none(obj.get("imporosity"))
        insistently = from_none(obj.get("insistently"))
        intraparietal = from_none(obj.get("intraparietal"))
        ivied = from_none(obj.get("ivied"))
        maureen = from_none(obj.get("Maureen"))
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
        return ChemotherapeuticClass(angioneurotic, availment, bladelet, catharticalness, caulis, chalcus, chirotherium, disdiapason, enteradenological, homocerc, imporosity, insistently, intraparietal, ivied, maureen, nonbookish, nostochine, nutcracker, ofttimes, phenocryst, precoincident, ramiferous, stagmometer, tetherball, unshy)

    def to_dict(self):
        result = {}
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
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.maureen is not None:
            result["Maureen"] = from_none(self.maureen)
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


class CimeliaClass:
    def __init__(self, catharticalness, chirotherium, disdiapason, homocerc, nonbookish):
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.homocerc = homocerc
        self.nonbookish = nonbookish

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        catharticalness = from_float(obj["catharticalness"])
        chirotherium = from_int(obj["Chirotherium"])
        disdiapason = from_str(obj["disdiapason"])
        homocerc = from_bool(obj["homocerc"])
        nonbookish = from_none(obj["nonbookish"])
        return CimeliaClass(catharticalness, chirotherium, disdiapason, homocerc, nonbookish)

    def to_dict(self):
        result = {}
        result["catharticalness"] = to_float(self.catharticalness)
        result["Chirotherium"] = from_int(self.chirotherium)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


class CoadjustClass:
    def __init__(self, amidosulphonal, benny, catharticalness, chirotherium, disdiapason, ensnare, homocerc, hybridizer, leastwise, lof, monkhood, netherlandish, nonbookish, peonism, phonelescope, porphyrogeniture, preindemnify, rosal, scalenous, scopine, sedaceae, suberinize, symbiot, tablefellow, unchargeable):
        self.amidosulphonal = amidosulphonal
        self.benny = benny
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.ensnare = ensnare
        self.homocerc = homocerc
        self.hybridizer = hybridizer
        self.leastwise = leastwise
        self.lof = lof
        self.monkhood = monkhood
        self.netherlandish = netherlandish
        self.nonbookish = nonbookish
        self.peonism = peonism
        self.phonelescope = phonelescope
        self.porphyrogeniture = porphyrogeniture
        self.preindemnify = preindemnify
        self.rosal = rosal
        self.scalenous = scalenous
        self.scopine = scopine
        self.sedaceae = sedaceae
        self.suberinize = suberinize
        self.symbiot = symbiot
        self.tablefellow = tablefellow
        self.unchargeable = unchargeable

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        amidosulphonal = from_none(obj.get("amidosulphonal"))
        benny = from_none(obj.get("Benny"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ensnare = from_none(obj.get("ensnare"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        hybridizer = from_none(obj.get("hybridizer"))
        leastwise = from_none(obj.get("leastwise"))
        lof = from_none(obj.get("lof"))
        monkhood = from_none(obj.get("monkhood"))
        netherlandish = from_none(obj.get("Netherlandish"))
        nonbookish = from_none(obj.get("nonbookish"))
        peonism = from_none(obj.get("peonism"))
        phonelescope = from_none(obj.get("Phonelescope"))
        porphyrogeniture = from_none(obj.get("porphyrogeniture"))
        preindemnify = from_none(obj.get("preindemnify"))
        rosal = from_none(obj.get("rosal"))
        scalenous = from_none(obj.get("scalenous"))
        scopine = from_none(obj.get("scopine"))
        sedaceae = from_none(obj.get("Sedaceae"))
        suberinize = from_none(obj.get("suberinize"))
        symbiot = from_none(obj.get("symbiot"))
        tablefellow = from_none(obj.get("tablefellow"))
        unchargeable = from_none(obj.get("unchargeable"))
        return CoadjustClass(amidosulphonal, benny, catharticalness, chirotherium, disdiapason, ensnare, homocerc, hybridizer, leastwise, lof, monkhood, netherlandish, nonbookish, peonism, phonelescope, porphyrogeniture, preindemnify, rosal, scalenous, scopine, sedaceae, suberinize, symbiot, tablefellow, unchargeable)

    def to_dict(self):
        result = {}
        if self.amidosulphonal is not None:
            result["amidosulphonal"] = from_none(self.amidosulphonal)
        if self.benny is not None:
            result["Benny"] = from_none(self.benny)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.netherlandish is not None:
            result["Netherlandish"] = from_none(self.netherlandish)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.peonism is not None:
            result["peonism"] = from_none(self.peonism)
        if self.phonelescope is not None:
            result["Phonelescope"] = from_none(self.phonelescope)
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
        if self.sedaceae is not None:
            result["Sedaceae"] = from_none(self.sedaceae)
        if self.suberinize is not None:
            result["suberinize"] = from_none(self.suberinize)
        if self.symbiot is not None:
            result["symbiot"] = from_none(self.symbiot)
        if self.tablefellow is not None:
            result["tablefellow"] = from_none(self.tablefellow)
        if self.unchargeable is not None:
            result["unchargeable"] = from_none(self.unchargeable)
        return result


class CredulityClass:
    def __init__(self, ammonolytic, bushmaster, considering, consuetudinary, embarras, fineness, flaithship, flavia, gruffly, hedychium, leadwort, overseriously, parabola, pectinatodenticulate, popean, pornocrat, quadrisect, seriality, vamphorn, wharp):
        self.ammonolytic = ammonolytic
        self.bushmaster = bushmaster
        self.considering = considering
        self.consuetudinary = consuetudinary
        self.embarras = embarras
        self.fineness = fineness
        self.flaithship = flaithship
        self.flavia = flavia
        self.gruffly = gruffly
        self.hedychium = hedychium
        self.leadwort = leadwort
        self.overseriously = overseriously
        self.parabola = parabola
        self.pectinatodenticulate = pectinatodenticulate
        self.popean = popean
        self.pornocrat = pornocrat
        self.quadrisect = quadrisect
        self.seriality = seriality
        self.vamphorn = vamphorn
        self.wharp = wharp

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        ammonolytic = from_none(obj["ammonolytic"])
        bushmaster = from_none(obj["bushmaster"])
        considering = from_none(obj["considering"])
        consuetudinary = from_none(obj["consuetudinary"])
        embarras = from_none(obj["embarras"])
        fineness = from_none(obj["fineness"])
        flaithship = from_none(obj["flaithship"])
        flavia = from_none(obj["Flavia"])
        gruffly = from_none(obj["gruffly"])
        hedychium = from_none(obj["Hedychium"])
        leadwort = from_none(obj["leadwort"])
        overseriously = from_none(obj["overseriously"])
        parabola = from_none(obj["parabola"])
        pectinatodenticulate = from_none(obj["pectinatodenticulate"])
        popean = from_none(obj["Popean"])
        pornocrat = from_none(obj["pornocrat"])
        quadrisect = from_none(obj["quadrisect"])
        seriality = from_none(obj["seriality"])
        vamphorn = from_none(obj["vamphorn"])
        wharp = from_none(obj["wharp"])
        return CredulityClass(ammonolytic, bushmaster, considering, consuetudinary, embarras, fineness, flaithship, flavia, gruffly, hedychium, leadwort, overseriously, parabola, pectinatodenticulate, popean, pornocrat, quadrisect, seriality, vamphorn, wharp)

    def to_dict(self):
        result = {}
        result["ammonolytic"] = from_none(self.ammonolytic)
        result["bushmaster"] = from_none(self.bushmaster)
        result["considering"] = from_none(self.considering)
        result["consuetudinary"] = from_none(self.consuetudinary)
        result["embarras"] = from_none(self.embarras)
        result["fineness"] = from_none(self.fineness)
        result["flaithship"] = from_none(self.flaithship)
        result["Flavia"] = from_none(self.flavia)
        result["gruffly"] = from_none(self.gruffly)
        result["Hedychium"] = from_none(self.hedychium)
        result["leadwort"] = from_none(self.leadwort)
        result["overseriously"] = from_none(self.overseriously)
        result["parabola"] = from_none(self.parabola)
        result["pectinatodenticulate"] = from_none(self.pectinatodenticulate)
        result["Popean"] = from_none(self.popean)
        result["pornocrat"] = from_none(self.pornocrat)
        result["quadrisect"] = from_none(self.quadrisect)
        result["seriality"] = from_none(self.seriality)
        result["vamphorn"] = from_none(self.vamphorn)
        result["wharp"] = from_none(self.wharp)
        return result


class DeruralizeClass:
    def __init__(self, bockerel, boulder, churrus, counterdigged, dialogite, digenic, dunbird, ergatogyne, fiendful, jackrod, jehovistic, paninean, panther, placentigerous, romney, sparm, tocsin, unnicked, unstavable, windfirm):
        self.bockerel = bockerel
        self.boulder = boulder
        self.churrus = churrus
        self.counterdigged = counterdigged
        self.dialogite = dialogite
        self.digenic = digenic
        self.dunbird = dunbird
        self.ergatogyne = ergatogyne
        self.fiendful = fiendful
        self.jackrod = jackrod
        self.jehovistic = jehovistic
        self.paninean = paninean
        self.panther = panther
        self.placentigerous = placentigerous
        self.romney = romney
        self.sparm = sparm
        self.tocsin = tocsin
        self.unnicked = unnicked
        self.unstavable = unstavable
        self.windfirm = windfirm

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
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
        jehovistic = from_none(obj["Jehovistic"])
        paninean = from_none(obj["Paninean"])
        panther = from_none(obj["panther"])
        placentigerous = from_none(obj["placentigerous"])
        romney = from_none(obj["Romney"])
        sparm = from_none(obj["sparm"])
        tocsin = from_none(obj["tocsin"])
        unnicked = from_none(obj["unnicked"])
        unstavable = from_none(obj["unstavable"])
        windfirm = from_none(obj["windfirm"])
        return DeruralizeClass(bockerel, boulder, churrus, counterdigged, dialogite, digenic, dunbird, ergatogyne, fiendful, jackrod, jehovistic, paninean, panther, placentigerous, romney, sparm, tocsin, unnicked, unstavable, windfirm)

    def to_dict(self):
        result = {}
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
        result["Jehovistic"] = from_none(self.jehovistic)
        result["Paninean"] = from_none(self.paninean)
        result["panther"] = from_none(self.panther)
        result["placentigerous"] = from_none(self.placentigerous)
        result["Romney"] = from_none(self.romney)
        result["sparm"] = from_none(self.sparm)
        result["tocsin"] = from_none(self.tocsin)
        result["unnicked"] = from_none(self.unnicked)
        result["unstavable"] = from_none(self.unstavable)
        result["windfirm"] = from_none(self.windfirm)
        return result


class DiaereseClass:
    def __init__(self, amoreuxia, ani, bernicle, blackwasher, blowhard, broma, closecross, congregationalism, grayly, historically, hoast, irretentive, parcener, pedder, pseudoanatomic, rhizocarpian, samel, silker, subdentated, subobscure):
        self.amoreuxia = amoreuxia
        self.ani = ani
        self.bernicle = bernicle
        self.blackwasher = blackwasher
        self.blowhard = blowhard
        self.broma = broma
        self.closecross = closecross
        self.congregationalism = congregationalism
        self.grayly = grayly
        self.historically = historically
        self.hoast = hoast
        self.irretentive = irretentive
        self.parcener = parcener
        self.pedder = pedder
        self.pseudoanatomic = pseudoanatomic
        self.rhizocarpian = rhizocarpian
        self.samel = samel
        self.silker = silker
        self.subdentated = subdentated
        self.subobscure = subobscure

    @staticmethod
    def from_dict(obj):
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

    def to_dict(self):
        result = {}
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


class Encrust:
    def __init__(self, comradely, diacanthous, feminineness, gossamered, hibernia, hibiscus, lepidosauria, lollingly, manager, mechanic, overminuteness, papelonne, plebification, pugmiller, recoveror, spermatoblastic, syllidae, ungyved, whirlabout, woodenware):
        self.comradely = comradely
        self.diacanthous = diacanthous
        self.feminineness = feminineness
        self.gossamered = gossamered
        self.hibernia = hibernia
        self.hibiscus = hibiscus
        self.lepidosauria = lepidosauria
        self.lollingly = lollingly
        self.manager = manager
        self.mechanic = mechanic
        self.overminuteness = overminuteness
        self.papelonne = papelonne
        self.plebification = plebification
        self.pugmiller = pugmiller
        self.recoveror = recoveror
        self.spermatoblastic = spermatoblastic
        self.syllidae = syllidae
        self.ungyved = ungyved
        self.whirlabout = whirlabout
        self.woodenware = woodenware

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        comradely = from_none(obj["comradely"])
        diacanthous = from_none(obj["diacanthous"])
        feminineness = from_none(obj["feminineness"])
        gossamered = from_none(obj["gossamered"])
        hibernia = from_none(obj["Hibernia"])
        hibiscus = from_none(obj["Hibiscus"])
        lepidosauria = from_none(obj["Lepidosauria"])
        lollingly = from_none(obj["lollingly"])
        manager = from_none(obj["manager"])
        mechanic = from_none(obj["mechanic"])
        overminuteness = from_none(obj["overminuteness"])
        papelonne = from_none(obj["papelonne"])
        plebification = from_none(obj["plebification"])
        pugmiller = from_none(obj["pugmiller"])
        recoveror = from_none(obj["recoveror"])
        spermatoblastic = from_none(obj["spermatoblastic"])
        syllidae = from_none(obj["Syllidae"])
        ungyved = from_none(obj["ungyved"])
        whirlabout = from_none(obj["whirlabout"])
        woodenware = from_none(obj["woodenware"])
        return Encrust(comradely, diacanthous, feminineness, gossamered, hibernia, hibiscus, lepidosauria, lollingly, manager, mechanic, overminuteness, papelonne, plebification, pugmiller, recoveror, spermatoblastic, syllidae, ungyved, whirlabout, woodenware)

    def to_dict(self):
        result = {}
        result["comradely"] = from_none(self.comradely)
        result["diacanthous"] = from_none(self.diacanthous)
        result["feminineness"] = from_none(self.feminineness)
        result["gossamered"] = from_none(self.gossamered)
        result["Hibernia"] = from_none(self.hibernia)
        result["Hibiscus"] = from_none(self.hibiscus)
        result["Lepidosauria"] = from_none(self.lepidosauria)
        result["lollingly"] = from_none(self.lollingly)
        result["manager"] = from_none(self.manager)
        result["mechanic"] = from_none(self.mechanic)
        result["overminuteness"] = from_none(self.overminuteness)
        result["papelonne"] = from_none(self.papelonne)
        result["plebification"] = from_none(self.plebification)
        result["pugmiller"] = from_none(self.pugmiller)
        result["recoveror"] = from_none(self.recoveror)
        result["spermatoblastic"] = from_none(self.spermatoblastic)
        result["Syllidae"] = from_none(self.syllidae)
        result["ungyved"] = from_none(self.ungyved)
        result["whirlabout"] = from_none(self.whirlabout)
        result["woodenware"] = from_none(self.woodenware)
        return result


class FagginglyClass:
    def __init__(self, abranchian, aculeiform, adiaphoristic, adoptionism, anglic, antrotomy, coerciveness, decorist, duckhood, heteromeri, hypochnose, lochage, melee, nonconformitant, poinsettia, putatively, semivolatile, soleas, unfastenable, unmillinered):
        self.abranchian = abranchian
        self.aculeiform = aculeiform
        self.adiaphoristic = adiaphoristic
        self.adoptionism = adoptionism
        self.anglic = anglic
        self.antrotomy = antrotomy
        self.coerciveness = coerciveness
        self.decorist = decorist
        self.duckhood = duckhood
        self.heteromeri = heteromeri
        self.hypochnose = hypochnose
        self.lochage = lochage
        self.melee = melee
        self.nonconformitant = nonconformitant
        self.poinsettia = poinsettia
        self.putatively = putatively
        self.semivolatile = semivolatile
        self.soleas = soleas
        self.unfastenable = unfastenable
        self.unmillinered = unmillinered

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        abranchian = from_none(obj["abranchian"])
        aculeiform = from_none(obj["aculeiform"])
        adiaphoristic = from_none(obj["adiaphoristic"])
        adoptionism = from_none(obj["adoptionism"])
        anglic = from_none(obj["Anglic"])
        antrotomy = from_none(obj["antrotomy"])
        coerciveness = from_none(obj["coerciveness"])
        decorist = from_none(obj["decorist"])
        duckhood = from_none(obj["duckhood"])
        heteromeri = from_none(obj["Heteromeri"])
        hypochnose = from_none(obj["hypochnose"])
        lochage = from_none(obj["lochage"])
        melee = from_none(obj["melee"])
        nonconformitant = from_none(obj["nonconformitant"])
        poinsettia = from_none(obj["Poinsettia"])
        putatively = from_none(obj["putatively"])
        semivolatile = from_none(obj["semivolatile"])
        soleas = from_none(obj["soleas"])
        unfastenable = from_none(obj["unfastenable"])
        unmillinered = from_none(obj["unmillinered"])
        return FagginglyClass(abranchian, aculeiform, adiaphoristic, adoptionism, anglic, antrotomy, coerciveness, decorist, duckhood, heteromeri, hypochnose, lochage, melee, nonconformitant, poinsettia, putatively, semivolatile, soleas, unfastenable, unmillinered)

    def to_dict(self):
        result = {}
        result["abranchian"] = from_none(self.abranchian)
        result["aculeiform"] = from_none(self.aculeiform)
        result["adiaphoristic"] = from_none(self.adiaphoristic)
        result["adoptionism"] = from_none(self.adoptionism)
        result["Anglic"] = from_none(self.anglic)
        result["antrotomy"] = from_none(self.antrotomy)
        result["coerciveness"] = from_none(self.coerciveness)
        result["decorist"] = from_none(self.decorist)
        result["duckhood"] = from_none(self.duckhood)
        result["Heteromeri"] = from_none(self.heteromeri)
        result["hypochnose"] = from_none(self.hypochnose)
        result["lochage"] = from_none(self.lochage)
        result["melee"] = from_none(self.melee)
        result["nonconformitant"] = from_none(self.nonconformitant)
        result["Poinsettia"] = from_none(self.poinsettia)
        result["putatively"] = from_none(self.putatively)
        result["semivolatile"] = from_none(self.semivolatile)
        result["soleas"] = from_none(self.soleas)
        result["unfastenable"] = from_none(self.unfastenable)
        result["unmillinered"] = from_none(self.unmillinered)
        return result


class FenkClass:
    def __init__(self, apoise, astronomize, cockhorse, copular, dagomba, draffy, foreigner, guyandot, neurogliosis, osmious, palpitate, rebukeable, reinwardtia, reservatory, scalt, scripturalize, tintometer, tritoness, undergrade, undermountain):
        self.apoise = apoise
        self.astronomize = astronomize
        self.cockhorse = cockhorse
        self.copular = copular
        self.dagomba = dagomba
        self.draffy = draffy
        self.foreigner = foreigner
        self.guyandot = guyandot
        self.neurogliosis = neurogliosis
        self.osmious = osmious
        self.palpitate = palpitate
        self.rebukeable = rebukeable
        self.reinwardtia = reinwardtia
        self.reservatory = reservatory
        self.scalt = scalt
        self.scripturalize = scripturalize
        self.tintometer = tintometer
        self.tritoness = tritoness
        self.undergrade = undergrade
        self.undermountain = undermountain

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        apoise = from_none(obj["apoise"])
        astronomize = from_none(obj["astronomize"])
        cockhorse = from_none(obj["cockhorse"])
        copular = from_none(obj["copular"])
        dagomba = from_none(obj["Dagomba"])
        draffy = from_none(obj["draffy"])
        foreigner = from_none(obj["foreigner"])
        guyandot = from_none(obj["Guyandot"])
        neurogliosis = from_none(obj["neurogliosis"])
        osmious = from_none(obj["osmious"])
        palpitate = from_none(obj["palpitate"])
        rebukeable = from_none(obj["rebukeable"])
        reinwardtia = from_none(obj["Reinwardtia"])
        reservatory = from_none(obj["reservatory"])
        scalt = from_none(obj["scalt"])
        scripturalize = from_none(obj["scripturalize"])
        tintometer = from_none(obj["tintometer"])
        tritoness = from_none(obj["Tritoness"])
        undergrade = from_none(obj["undergrade"])
        undermountain = from_none(obj["undermountain"])
        return FenkClass(apoise, astronomize, cockhorse, copular, dagomba, draffy, foreigner, guyandot, neurogliosis, osmious, palpitate, rebukeable, reinwardtia, reservatory, scalt, scripturalize, tintometer, tritoness, undergrade, undermountain)

    def to_dict(self):
        result = {}
        result["apoise"] = from_none(self.apoise)
        result["astronomize"] = from_none(self.astronomize)
        result["cockhorse"] = from_none(self.cockhorse)
        result["copular"] = from_none(self.copular)
        result["Dagomba"] = from_none(self.dagomba)
        result["draffy"] = from_none(self.draffy)
        result["foreigner"] = from_none(self.foreigner)
        result["Guyandot"] = from_none(self.guyandot)
        result["neurogliosis"] = from_none(self.neurogliosis)
        result["osmious"] = from_none(self.osmious)
        result["palpitate"] = from_none(self.palpitate)
        result["rebukeable"] = from_none(self.rebukeable)
        result["Reinwardtia"] = from_none(self.reinwardtia)
        result["reservatory"] = from_none(self.reservatory)
        result["scalt"] = from_none(self.scalt)
        result["scripturalize"] = from_none(self.scripturalize)
        result["tintometer"] = from_none(self.tintometer)
        result["Tritoness"] = from_none(self.tritoness)
        result["undergrade"] = from_none(self.undergrade)
        result["undermountain"] = from_none(self.undermountain)
        return result


class FlagmakingClass:
    def __init__(self, albarco, bunodonta, hornify, hydrocorisae, hypoglossus, inexpiably, ingratitude, ladyfly, medicament, monogrammatic, nobbut, notacanthidae, polyplacophore, proexercise, protoplast, puzzling, splanchnoskeleton, unloveliness, unquarantined, unrenounceable):
        self.albarco = albarco
        self.bunodonta = bunodonta
        self.hornify = hornify
        self.hydrocorisae = hydrocorisae
        self.hypoglossus = hypoglossus
        self.inexpiably = inexpiably
        self.ingratitude = ingratitude
        self.ladyfly = ladyfly
        self.medicament = medicament
        self.monogrammatic = monogrammatic
        self.nobbut = nobbut
        self.notacanthidae = notacanthidae
        self.polyplacophore = polyplacophore
        self.proexercise = proexercise
        self.protoplast = protoplast
        self.puzzling = puzzling
        self.splanchnoskeleton = splanchnoskeleton
        self.unloveliness = unloveliness
        self.unquarantined = unquarantined
        self.unrenounceable = unrenounceable

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        albarco = from_none(obj["albarco"])
        bunodonta = from_none(obj["Bunodonta"])
        hornify = from_none(obj["hornify"])
        hydrocorisae = from_none(obj["Hydrocorisae"])
        hypoglossus = from_none(obj["hypoglossus"])
        inexpiably = from_none(obj["inexpiably"])
        ingratitude = from_none(obj["ingratitude"])
        ladyfly = from_none(obj["ladyfly"])
        medicament = from_none(obj["medicament"])
        monogrammatic = from_none(obj["monogrammatic"])
        nobbut = from_none(obj["nobbut"])
        notacanthidae = from_none(obj["Notacanthidae"])
        polyplacophore = from_none(obj["polyplacophore"])
        proexercise = from_none(obj["proexercise"])
        protoplast = from_none(obj["protoplast"])
        puzzling = from_none(obj["puzzling"])
        splanchnoskeleton = from_none(obj["splanchnoskeleton"])
        unloveliness = from_none(obj["unloveliness"])
        unquarantined = from_none(obj["unquarantined"])
        unrenounceable = from_none(obj["unrenounceable"])
        return FlagmakingClass(albarco, bunodonta, hornify, hydrocorisae, hypoglossus, inexpiably, ingratitude, ladyfly, medicament, monogrammatic, nobbut, notacanthidae, polyplacophore, proexercise, protoplast, puzzling, splanchnoskeleton, unloveliness, unquarantined, unrenounceable)

    def to_dict(self):
        result = {}
        result["albarco"] = from_none(self.albarco)
        result["Bunodonta"] = from_none(self.bunodonta)
        result["hornify"] = from_none(self.hornify)
        result["Hydrocorisae"] = from_none(self.hydrocorisae)
        result["hypoglossus"] = from_none(self.hypoglossus)
        result["inexpiably"] = from_none(self.inexpiably)
        result["ingratitude"] = from_none(self.ingratitude)
        result["ladyfly"] = from_none(self.ladyfly)
        result["medicament"] = from_none(self.medicament)
        result["monogrammatic"] = from_none(self.monogrammatic)
        result["nobbut"] = from_none(self.nobbut)
        result["Notacanthidae"] = from_none(self.notacanthidae)
        result["polyplacophore"] = from_none(self.polyplacophore)
        result["proexercise"] = from_none(self.proexercise)
        result["protoplast"] = from_none(self.protoplast)
        result["puzzling"] = from_none(self.puzzling)
        result["splanchnoskeleton"] = from_none(self.splanchnoskeleton)
        result["unloveliness"] = from_none(self.unloveliness)
        result["unquarantined"] = from_none(self.unquarantined)
        result["unrenounceable"] = from_none(self.unrenounceable)
        return result


class HemocoeleClass:
    def __init__(self, acrogamy, amelification, autobiographic, berat, catharticalness, chirotherium, disdiapason, disproportionably, erythrite, graphic, hepatological, homocerc, incommensurably, misaffirm, nonbookish, pocketbook, sclerometric, stambouline, stickpin, tubulure, undelated, unsalt, untutelar, vagrant, walt):
        self.acrogamy = acrogamy
        self.amelification = amelification
        self.autobiographic = autobiographic
        self.berat = berat
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disdiapason = disdiapason
        self.disproportionably = disproportionably
        self.erythrite = erythrite
        self.graphic = graphic
        self.hepatological = hepatological
        self.homocerc = homocerc
        self.incommensurably = incommensurably
        self.misaffirm = misaffirm
        self.nonbookish = nonbookish
        self.pocketbook = pocketbook
        self.sclerometric = sclerometric
        self.stambouline = stambouline
        self.stickpin = stickpin
        self.tubulure = tubulure
        self.undelated = undelated
        self.unsalt = unsalt
        self.untutelar = untutelar
        self.vagrant = vagrant
        self.walt = walt

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        acrogamy = from_none(obj.get("acrogamy"))
        amelification = from_none(obj.get("amelification"))
        autobiographic = from_none(obj.get("autobiographic"))
        berat = from_none(obj.get("berat"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
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
        walt = from_none(obj.get("Walt"))
        return HemocoeleClass(acrogamy, amelification, autobiographic, berat, catharticalness, chirotherium, disdiapason, disproportionably, erythrite, graphic, hepatological, homocerc, incommensurably, misaffirm, nonbookish, pocketbook, sclerometric, stambouline, stickpin, tubulure, undelated, unsalt, untutelar, vagrant, walt)

    def to_dict(self):
        result = {}
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
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.walt is not None:
            result["Walt"] = from_none(self.walt)
        return result


class Interacinar:
    def __init__(self, assapan, benefactorship, triseriatim, tubbing, untrimmed):
        self.assapan = assapan
        self.benefactorship = benefactorship
        self.triseriatim = triseriatim
        self.tubbing = tubbing
        self.untrimmed = untrimmed

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        assapan = from_float(obj["assapan"])
        benefactorship = from_bool(obj["benefactorship"])
        triseriatim = from_str(obj["triseriatim"])
        tubbing = from_int(obj["tubbing"])
        untrimmed = from_none(obj["untrimmed"])
        return Interacinar(assapan, benefactorship, triseriatim, tubbing, untrimmed)

    def to_dict(self):
        result = {}
        result["assapan"] = to_float(self.assapan)
        result["benefactorship"] = from_bool(self.benefactorship)
        result["triseriatim"] = from_str(self.triseriatim)
        result["tubbing"] = from_int(self.tubbing)
        result["untrimmed"] = from_none(self.untrimmed)
        return result


class TopLevel:
    def __init__(self, centrodesmose, cerograph, chemotherapeutics, cimelia, citrated, clinodome, coadjust, consilience, constructor, continuative, credulity, creviced, cubiculum, deruralize, diaereses, dissolution, downstroke, electrotautomerism, eleutheromania, encrust, entomoid, epipaleolithic, expropriable, faggingly, fenks, flagmaking, fluorometer, fulsome, fuzzy, gardenwards, generalissimo, habeas, hemicrystalline, hemocoele, hoister, hyperpiesis, hyppish, idealizer, incrustator, intentiveness, interacinar, intercorrelation, jacutinga):
        self.centrodesmose = centrodesmose
        self.cerograph = cerograph
        self.chemotherapeutics = chemotherapeutics
        self.cimelia = cimelia
        self.citrated = citrated
        self.clinodome = clinodome
        self.coadjust = coadjust
        self.consilience = consilience
        self.constructor = constructor
        self.continuative = continuative
        self.credulity = credulity
        self.creviced = creviced
        self.cubiculum = cubiculum
        self.deruralize = deruralize
        self.diaereses = diaereses
        self.dissolution = dissolution
        self.downstroke = downstroke
        self.electrotautomerism = electrotautomerism
        self.eleutheromania = eleutheromania
        self.encrust = encrust
        self.entomoid = entomoid
        self.epipaleolithic = epipaleolithic
        self.expropriable = expropriable
        self.faggingly = faggingly
        self.fenks = fenks
        self.flagmaking = flagmaking
        self.fluorometer = fluorometer
        self.fulsome = fulsome
        self.fuzzy = fuzzy
        self.gardenwards = gardenwards
        self.generalissimo = generalissimo
        self.habeas = habeas
        self.hemicrystalline = hemicrystalline
        self.hemocoele = hemocoele
        self.hoister = hoister
        self.hyperpiesis = hyperpiesis
        self.hyppish = hyppish
        self.idealizer = idealizer
        self.incrustator = incrustator
        self.intentiveness = intentiveness
        self.interacinar = interacinar
        self.intercorrelation = intercorrelation
        self.jacutinga = jacutinga

    @staticmethod
    def from_dict(obj):
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

    def to_dict(self):
        result = {}
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


def top_level_from_dict(s):
    return TopLevel.from_dict(s)


def top_level_to_dict(x):
    return to_class(TopLevel, x)
