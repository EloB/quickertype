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


class JurorClass:
    def __init__(self, adipsy, auxiliator, benda, benjamin, brandling, epicurishly, eremochaetous, marten, monocline, olea, palgat, pennyworth, pioury, pragmatistic, stylelessness, systematical, thready, uncontemporary, uncouched, uninhabitedness):
        self.adipsy = adipsy
        self.auxiliator = auxiliator
        self.benda = benda
        self.benjamin = benjamin
        self.brandling = brandling
        self.epicurishly = epicurishly
        self.eremochaetous = eremochaetous
        self.marten = marten
        self.monocline = monocline
        self.olea = olea
        self.palgat = palgat
        self.pennyworth = pennyworth
        self.pioury = pioury
        self.pragmatistic = pragmatistic
        self.stylelessness = stylelessness
        self.systematical = systematical
        self.thready = thready
        self.uncontemporary = uncontemporary
        self.uncouched = uncouched
        self.uninhabitedness = uninhabitedness

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        adipsy = from_none(obj["adipsy"])
        auxiliator = from_none(obj["auxiliator"])
        benda = from_none(obj["benda"])
        benjamin = from_none(obj["benjamin"])
        brandling = from_none(obj["brandling"])
        epicurishly = from_none(obj["epicurishly"])
        eremochaetous = from_none(obj["eremochaetous"])
        marten = from_none(obj["marten"])
        monocline = from_none(obj["monocline"])
        olea = from_none(obj["Olea"])
        palgat = from_none(obj["palgat"])
        pennyworth = from_none(obj["pennyworth"])
        pioury = from_none(obj["pioury"])
        pragmatistic = from_none(obj["pragmatistic"])
        stylelessness = from_none(obj["stylelessness"])
        systematical = from_none(obj["systematical"])
        thready = from_none(obj["thready"])
        uncontemporary = from_none(obj["uncontemporary"])
        uncouched = from_none(obj["uncouched"])
        uninhabitedness = from_none(obj["uninhabitedness"])
        return JurorClass(adipsy, auxiliator, benda, benjamin, brandling, epicurishly, eremochaetous, marten, monocline, olea, palgat, pennyworth, pioury, pragmatistic, stylelessness, systematical, thready, uncontemporary, uncouched, uninhabitedness)

    def to_dict(self):
        result = {}
        result["adipsy"] = from_none(self.adipsy)
        result["auxiliator"] = from_none(self.auxiliator)
        result["benda"] = from_none(self.benda)
        result["benjamin"] = from_none(self.benjamin)
        result["brandling"] = from_none(self.brandling)
        result["epicurishly"] = from_none(self.epicurishly)
        result["eremochaetous"] = from_none(self.eremochaetous)
        result["marten"] = from_none(self.marten)
        result["monocline"] = from_none(self.monocline)
        result["Olea"] = from_none(self.olea)
        result["palgat"] = from_none(self.palgat)
        result["pennyworth"] = from_none(self.pennyworth)
        result["pioury"] = from_none(self.pioury)
        result["pragmatistic"] = from_none(self.pragmatistic)
        result["stylelessness"] = from_none(self.stylelessness)
        result["systematical"] = from_none(self.systematical)
        result["thready"] = from_none(self.thready)
        result["uncontemporary"] = from_none(self.uncontemporary)
        result["uncouched"] = from_none(self.uncouched)
        result["uninhabitedness"] = from_none(self.uninhabitedness)
        return result


class LadronismClass:
    def __init__(self, acclaimer, achree, base, conundrumize, degerminator, describable, exasperatedly, heroine, indazin, luteous, papular, pritch, prodenia, seege, shopgirl, tragedietta, unsparse, uplook, vermiformis, whafabout):
        self.acclaimer = acclaimer
        self.achree = achree
        self.base = base
        self.conundrumize = conundrumize
        self.degerminator = degerminator
        self.describable = describable
        self.exasperatedly = exasperatedly
        self.heroine = heroine
        self.indazin = indazin
        self.luteous = luteous
        self.papular = papular
        self.pritch = pritch
        self.prodenia = prodenia
        self.seege = seege
        self.shopgirl = shopgirl
        self.tragedietta = tragedietta
        self.unsparse = unsparse
        self.uplook = uplook
        self.vermiformis = vermiformis
        self.whafabout = whafabout

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        acclaimer = from_none(obj["acclaimer"])
        achree = from_none(obj["achree"])
        base = from_none(obj["base"])
        conundrumize = from_none(obj["conundrumize"])
        degerminator = from_none(obj["degerminator"])
        describable = from_none(obj["describable"])
        exasperatedly = from_none(obj["exasperatedly"])
        heroine = from_none(obj["heroine"])
        indazin = from_none(obj["indazin"])
        luteous = from_none(obj["luteous"])
        papular = from_none(obj["papular"])
        pritch = from_none(obj["pritch"])
        prodenia = from_none(obj["Prodenia"])
        seege = from_none(obj["seege"])
        shopgirl = from_none(obj["shopgirl"])
        tragedietta = from_none(obj["tragedietta"])
        unsparse = from_none(obj["unsparse"])
        uplook = from_none(obj["uplook"])
        vermiformis = from_none(obj["vermiformis"])
        whafabout = from_none(obj["whafabout"])
        return LadronismClass(acclaimer, achree, base, conundrumize, degerminator, describable, exasperatedly, heroine, indazin, luteous, papular, pritch, prodenia, seege, shopgirl, tragedietta, unsparse, uplook, vermiformis, whafabout)

    def to_dict(self):
        result = {}
        result["acclaimer"] = from_none(self.acclaimer)
        result["achree"] = from_none(self.achree)
        result["base"] = from_none(self.base)
        result["conundrumize"] = from_none(self.conundrumize)
        result["degerminator"] = from_none(self.degerminator)
        result["describable"] = from_none(self.describable)
        result["exasperatedly"] = from_none(self.exasperatedly)
        result["heroine"] = from_none(self.heroine)
        result["indazin"] = from_none(self.indazin)
        result["luteous"] = from_none(self.luteous)
        result["papular"] = from_none(self.papular)
        result["pritch"] = from_none(self.pritch)
        result["Prodenia"] = from_none(self.prodenia)
        result["seege"] = from_none(self.seege)
        result["shopgirl"] = from_none(self.shopgirl)
        result["tragedietta"] = from_none(self.tragedietta)
        result["unsparse"] = from_none(self.unsparse)
        result["uplook"] = from_none(self.uplook)
        result["vermiformis"] = from_none(self.vermiformis)
        result["whafabout"] = from_none(self.whafabout)
        return result


class LandlubberlyClass:
    def __init__(self, acropoleis, aminate, amyraldism, bipenniform, bugre, calycule, caoutchouc, disprover, fitroot, fulgently, kickup, laevoversion, moter, objectivity, posterity, postnuptial, precedentary, saddling, subcurrent, unrecriminative):
        self.acropoleis = acropoleis
        self.aminate = aminate
        self.amyraldism = amyraldism
        self.bipenniform = bipenniform
        self.bugre = bugre
        self.calycule = calycule
        self.caoutchouc = caoutchouc
        self.disprover = disprover
        self.fitroot = fitroot
        self.fulgently = fulgently
        self.kickup = kickup
        self.laevoversion = laevoversion
        self.moter = moter
        self.objectivity = objectivity
        self.posterity = posterity
        self.postnuptial = postnuptial
        self.precedentary = precedentary
        self.saddling = saddling
        self.subcurrent = subcurrent
        self.unrecriminative = unrecriminative

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        acropoleis = from_none(obj["acropoleis"])
        aminate = from_none(obj["aminate"])
        amyraldism = from_none(obj["Amyraldism"])
        bipenniform = from_none(obj["bipenniform"])
        bugre = from_none(obj["bugre"])
        calycule = from_none(obj["calycule"])
        caoutchouc = from_none(obj["caoutchouc"])
        disprover = from_none(obj["disprover"])
        fitroot = from_none(obj["fitroot"])
        fulgently = from_none(obj["fulgently"])
        kickup = from_none(obj["kickup"])
        laevoversion = from_none(obj["laevoversion"])
        moter = from_none(obj["moter"])
        objectivity = from_none(obj["objectivity"])
        posterity = from_none(obj["posterity"])
        postnuptial = from_none(obj["postnuptial"])
        precedentary = from_none(obj["precedentary"])
        saddling = from_none(obj["saddling"])
        subcurrent = from_none(obj["subcurrent"])
        unrecriminative = from_none(obj["unrecriminative"])
        return LandlubberlyClass(acropoleis, aminate, amyraldism, bipenniform, bugre, calycule, caoutchouc, disprover, fitroot, fulgently, kickup, laevoversion, moter, objectivity, posterity, postnuptial, precedentary, saddling, subcurrent, unrecriminative)

    def to_dict(self):
        result = {}
        result["acropoleis"] = from_none(self.acropoleis)
        result["aminate"] = from_none(self.aminate)
        result["Amyraldism"] = from_none(self.amyraldism)
        result["bipenniform"] = from_none(self.bipenniform)
        result["bugre"] = from_none(self.bugre)
        result["calycule"] = from_none(self.calycule)
        result["caoutchouc"] = from_none(self.caoutchouc)
        result["disprover"] = from_none(self.disprover)
        result["fitroot"] = from_none(self.fitroot)
        result["fulgently"] = from_none(self.fulgently)
        result["kickup"] = from_none(self.kickup)
        result["laevoversion"] = from_none(self.laevoversion)
        result["moter"] = from_none(self.moter)
        result["objectivity"] = from_none(self.objectivity)
        result["posterity"] = from_none(self.posterity)
        result["postnuptial"] = from_none(self.postnuptial)
        result["precedentary"] = from_none(self.precedentary)
        result["saddling"] = from_none(self.saddling)
        result["subcurrent"] = from_none(self.subcurrent)
        result["unrecriminative"] = from_none(self.unrecriminative)
        return result


class LupusClass:
    def __init__(self, catharticalness, chirotherium, chlorioninae, corvinae, crassina, disdiapason, exiguity, farcist, holographical, homocerc, ichthyophagan, implacable, nonbookish, outshiner, overweather, protonegroid, shallowish, snoke, snout, surveillance, threshingtime, thysanocarpus, unsignificantly, unsnap, vendible):
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.chlorioninae = chlorioninae
        self.corvinae = corvinae
        self.crassina = crassina
        self.disdiapason = disdiapason
        self.exiguity = exiguity
        self.farcist = farcist
        self.holographical = holographical
        self.homocerc = homocerc
        self.ichthyophagan = ichthyophagan
        self.implacable = implacable
        self.nonbookish = nonbookish
        self.outshiner = outshiner
        self.overweather = overweather
        self.protonegroid = protonegroid
        self.shallowish = shallowish
        self.snoke = snoke
        self.snout = snout
        self.surveillance = surveillance
        self.threshingtime = threshingtime
        self.thysanocarpus = thysanocarpus
        self.unsignificantly = unsignificantly
        self.unsnap = unsnap
        self.vendible = vendible

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        chlorioninae = from_union([from_int, from_none], obj.get("Chlorioninae"))
        corvinae = from_union([from_int, from_none], obj.get("Corvinae"))
        crassina = from_union([from_int, from_none], obj.get("Crassina"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        exiguity = from_union([from_int, from_none], obj.get("exiguity"))
        farcist = from_union([from_int, from_none], obj.get("farcist"))
        holographical = from_union([from_int, from_none], obj.get("holographical"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        ichthyophagan = from_union([from_int, from_none], obj.get("ichthyophagan"))
        implacable = from_union([from_int, from_none], obj.get("implacable"))
        nonbookish = from_none(obj.get("nonbookish"))
        outshiner = from_union([from_int, from_none], obj.get("outshiner"))
        overweather = from_union([from_int, from_none], obj.get("overweather"))
        protonegroid = from_union([from_int, from_none], obj.get("protonegroid"))
        shallowish = from_union([from_int, from_none], obj.get("shallowish"))
        snoke = from_union([from_int, from_none], obj.get("snoke"))
        snout = from_union([from_int, from_none], obj.get("snout"))
        surveillance = from_union([from_int, from_none], obj.get("surveillance"))
        threshingtime = from_union([from_int, from_none], obj.get("threshingtime"))
        thysanocarpus = from_union([from_int, from_none], obj.get("Thysanocarpus"))
        unsignificantly = from_union([from_int, from_none], obj.get("unsignificantly"))
        unsnap = from_union([from_int, from_none], obj.get("unsnap"))
        vendible = from_union([from_int, from_none], obj.get("vendible"))
        return LupusClass(catharticalness, chirotherium, chlorioninae, corvinae, crassina, disdiapason, exiguity, farcist, holographical, homocerc, ichthyophagan, implacable, nonbookish, outshiner, overweather, protonegroid, shallowish, snoke, snout, surveillance, threshingtime, thysanocarpus, unsignificantly, unsnap, vendible)

    def to_dict(self):
        result = {}
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.chlorioninae is not None:
            result["Chlorioninae"] = from_union([from_int, from_none], self.chlorioninae)
        if self.corvinae is not None:
            result["Corvinae"] = from_union([from_int, from_none], self.corvinae)
        if self.crassina is not None:
            result["Crassina"] = from_union([from_int, from_none], self.crassina)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.exiguity is not None:
            result["exiguity"] = from_union([from_int, from_none], self.exiguity)
        if self.farcist is not None:
            result["farcist"] = from_union([from_int, from_none], self.farcist)
        if self.holographical is not None:
            result["holographical"] = from_union([from_int, from_none], self.holographical)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.ichthyophagan is not None:
            result["ichthyophagan"] = from_union([from_int, from_none], self.ichthyophagan)
        if self.implacable is not None:
            result["implacable"] = from_union([from_int, from_none], self.implacable)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.outshiner is not None:
            result["outshiner"] = from_union([from_int, from_none], self.outshiner)
        if self.overweather is not None:
            result["overweather"] = from_union([from_int, from_none], self.overweather)
        if self.protonegroid is not None:
            result["protonegroid"] = from_union([from_int, from_none], self.protonegroid)
        if self.shallowish is not None:
            result["shallowish"] = from_union([from_int, from_none], self.shallowish)
        if self.snoke is not None:
            result["snoke"] = from_union([from_int, from_none], self.snoke)
        if self.snout is not None:
            result["snout"] = from_union([from_int, from_none], self.snout)
        if self.surveillance is not None:
            result["surveillance"] = from_union([from_int, from_none], self.surveillance)
        if self.threshingtime is not None:
            result["threshingtime"] = from_union([from_int, from_none], self.threshingtime)
        if self.thysanocarpus is not None:
            result["Thysanocarpus"] = from_union([from_int, from_none], self.thysanocarpus)
        if self.unsignificantly is not None:
            result["unsignificantly"] = from_union([from_int, from_none], self.unsignificantly)
        if self.unsnap is not None:
            result["unsnap"] = from_union([from_int, from_none], self.unsnap)
        if self.vendible is not None:
            result["vendible"] = from_union([from_int, from_none], self.vendible)
        return result


class Maslin:
    def __init__(self, alicant, antiatonement, anticorrosive, aphidozer, bakuninist, be, catharticalness, chirotherium, chub, cuprosilicon, curtailedly, dellenite, dimitry, disdiapason, edifying, ethmoiditis, gastralgy, goatherd, hammerdress, hangfire, homocerc, lacunosity, longiloquence, mameliere, motherless, nonbookish, noncorrodible, nonsensicality, oafishly, pfund, preadvisory, retroflexed, saccharulmic, scowlful, secluded, slackage, sphaeridial, spondulics, subsecive, swellmobsman, trachyglossate, trialogue, unassuaged, ungross, unjudiciously):
        self.alicant = alicant
        self.antiatonement = antiatonement
        self.anticorrosive = anticorrosive
        self.aphidozer = aphidozer
        self.bakuninist = bakuninist
        self.be = be
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.chub = chub
        self.cuprosilicon = cuprosilicon
        self.curtailedly = curtailedly
        self.dellenite = dellenite
        self.dimitry = dimitry
        self.disdiapason = disdiapason
        self.edifying = edifying
        self.ethmoiditis = ethmoiditis
        self.gastralgy = gastralgy
        self.goatherd = goatherd
        self.hammerdress = hammerdress
        self.hangfire = hangfire
        self.homocerc = homocerc
        self.lacunosity = lacunosity
        self.longiloquence = longiloquence
        self.mameliere = mameliere
        self.motherless = motherless
        self.nonbookish = nonbookish
        self.noncorrodible = noncorrodible
        self.nonsensicality = nonsensicality
        self.oafishly = oafishly
        self.pfund = pfund
        self.preadvisory = preadvisory
        self.retroflexed = retroflexed
        self.saccharulmic = saccharulmic
        self.scowlful = scowlful
        self.secluded = secluded
        self.slackage = slackage
        self.sphaeridial = sphaeridial
        self.spondulics = spondulics
        self.subsecive = subsecive
        self.swellmobsman = swellmobsman
        self.trachyglossate = trachyglossate
        self.trialogue = trialogue
        self.unassuaged = unassuaged
        self.ungross = ungross
        self.unjudiciously = unjudiciously

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        alicant = from_union([from_int, from_none], obj.get("Alicant"))
        antiatonement = from_none(obj.get("antiatonement"))
        anticorrosive = from_union([from_int, from_none], obj.get("anticorrosive"))
        aphidozer = from_none(obj.get("aphidozer"))
        bakuninist = from_none(obj.get("Bakuninist"))
        be = from_union([from_int, from_none], obj.get("be"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        chub = from_union([from_int, from_none], obj.get("chub"))
        cuprosilicon = from_union([from_int, from_none], obj.get("cuprosilicon"))
        curtailedly = from_union([from_int, from_none], obj.get("curtailedly"))
        dellenite = from_union([from_int, from_none], obj.get("dellenite"))
        dimitry = from_union([from_int, from_none], obj.get("Dimitry"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        edifying = from_none(obj.get("edifying"))
        ethmoiditis = from_union([from_int, from_none], obj.get("ethmoiditis"))
        gastralgy = from_none(obj.get("gastralgy"))
        goatherd = from_union([from_int, from_none], obj.get("goatherd"))
        hammerdress = from_union([from_int, from_none], obj.get("hammerdress"))
        hangfire = from_none(obj.get("hangfire"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        lacunosity = from_union([from_int, from_none], obj.get("lacunosity"))
        longiloquence = from_none(obj.get("longiloquence"))
        mameliere = from_union([from_int, from_none], obj.get("mameliere"))
        motherless = from_none(obj.get("motherless"))
        nonbookish = from_none(obj.get("nonbookish"))
        noncorrodible = from_none(obj.get("noncorrodible"))
        nonsensicality = from_none(obj.get("nonsensicality"))
        oafishly = from_union([from_int, from_none], obj.get("oafishly"))
        pfund = from_none(obj.get("pfund"))
        preadvisory = from_none(obj.get("preadvisory"))
        retroflexed = from_none(obj.get("retroflexed"))
        saccharulmic = from_union([from_int, from_none], obj.get("saccharulmic"))
        scowlful = from_union([from_int, from_none], obj.get("scowlful"))
        secluded = from_none(obj.get("secluded"))
        slackage = from_none(obj.get("slackage"))
        sphaeridial = from_union([from_int, from_none], obj.get("sphaeridial"))
        spondulics = from_none(obj.get("spondulics"))
        subsecive = from_union([from_int, from_none], obj.get("subsecive"))
        swellmobsman = from_none(obj.get("swellmobsman"))
        trachyglossate = from_union([from_int, from_none], obj.get("trachyglossate"))
        trialogue = from_none(obj.get("trialogue"))
        unassuaged = from_union([from_int, from_none], obj.get("unassuaged"))
        ungross = from_none(obj.get("ungross"))
        unjudiciously = from_none(obj.get("unjudiciously"))
        return Maslin(alicant, antiatonement, anticorrosive, aphidozer, bakuninist, be, catharticalness, chirotherium, chub, cuprosilicon, curtailedly, dellenite, dimitry, disdiapason, edifying, ethmoiditis, gastralgy, goatherd, hammerdress, hangfire, homocerc, lacunosity, longiloquence, mameliere, motherless, nonbookish, noncorrodible, nonsensicality, oafishly, pfund, preadvisory, retroflexed, saccharulmic, scowlful, secluded, slackage, sphaeridial, spondulics, subsecive, swellmobsman, trachyglossate, trialogue, unassuaged, ungross, unjudiciously)

    def to_dict(self):
        result = {}
        if self.alicant is not None:
            result["Alicant"] = from_union([from_int, from_none], self.alicant)
        if self.antiatonement is not None:
            result["antiatonement"] = from_none(self.antiatonement)
        if self.anticorrosive is not None:
            result["anticorrosive"] = from_union([from_int, from_none], self.anticorrosive)
        if self.aphidozer is not None:
            result["aphidozer"] = from_none(self.aphidozer)
        if self.bakuninist is not None:
            result["Bakuninist"] = from_none(self.bakuninist)
        if self.be is not None:
            result["be"] = from_union([from_int, from_none], self.be)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.chub is not None:
            result["chub"] = from_union([from_int, from_none], self.chub)
        if self.cuprosilicon is not None:
            result["cuprosilicon"] = from_union([from_int, from_none], self.cuprosilicon)
        if self.curtailedly is not None:
            result["curtailedly"] = from_union([from_int, from_none], self.curtailedly)
        if self.dellenite is not None:
            result["dellenite"] = from_union([from_int, from_none], self.dellenite)
        if self.dimitry is not None:
            result["Dimitry"] = from_union([from_int, from_none], self.dimitry)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.edifying is not None:
            result["edifying"] = from_none(self.edifying)
        if self.ethmoiditis is not None:
            result["ethmoiditis"] = from_union([from_int, from_none], self.ethmoiditis)
        if self.gastralgy is not None:
            result["gastralgy"] = from_none(self.gastralgy)
        if self.goatherd is not None:
            result["goatherd"] = from_union([from_int, from_none], self.goatherd)
        if self.hammerdress is not None:
            result["hammerdress"] = from_union([from_int, from_none], self.hammerdress)
        if self.hangfire is not None:
            result["hangfire"] = from_none(self.hangfire)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.lacunosity is not None:
            result["lacunosity"] = from_union([from_int, from_none], self.lacunosity)
        if self.longiloquence is not None:
            result["longiloquence"] = from_none(self.longiloquence)
        if self.mameliere is not None:
            result["mameliere"] = from_union([from_int, from_none], self.mameliere)
        if self.motherless is not None:
            result["motherless"] = from_none(self.motherless)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.noncorrodible is not None:
            result["noncorrodible"] = from_none(self.noncorrodible)
        if self.nonsensicality is not None:
            result["nonsensicality"] = from_none(self.nonsensicality)
        if self.oafishly is not None:
            result["oafishly"] = from_union([from_int, from_none], self.oafishly)
        if self.pfund is not None:
            result["pfund"] = from_none(self.pfund)
        if self.preadvisory is not None:
            result["preadvisory"] = from_none(self.preadvisory)
        if self.retroflexed is not None:
            result["retroflexed"] = from_none(self.retroflexed)
        if self.saccharulmic is not None:
            result["saccharulmic"] = from_union([from_int, from_none], self.saccharulmic)
        if self.scowlful is not None:
            result["scowlful"] = from_union([from_int, from_none], self.scowlful)
        if self.secluded is not None:
            result["secluded"] = from_none(self.secluded)
        if self.slackage is not None:
            result["slackage"] = from_none(self.slackage)
        if self.sphaeridial is not None:
            result["sphaeridial"] = from_union([from_int, from_none], self.sphaeridial)
        if self.spondulics is not None:
            result["spondulics"] = from_none(self.spondulics)
        if self.subsecive is not None:
            result["subsecive"] = from_union([from_int, from_none], self.subsecive)
        if self.swellmobsman is not None:
            result["swellmobsman"] = from_none(self.swellmobsman)
        if self.trachyglossate is not None:
            result["trachyglossate"] = from_union([from_int, from_none], self.trachyglossate)
        if self.trialogue is not None:
            result["trialogue"] = from_none(self.trialogue)
        if self.unassuaged is not None:
            result["unassuaged"] = from_union([from_int, from_none], self.unassuaged)
        if self.ungross is not None:
            result["ungross"] = from_none(self.ungross)
        if self.unjudiciously is not None:
            result["unjudiciously"] = from_none(self.unjudiciously)
        return result


class MonaziteClass:
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
        return MonaziteClass(catharticalness, chirotherium, disdiapason, homocerc, nonbookish)

    def to_dict(self):
        result = {}
        result["catharticalness"] = to_float(self.catharticalness)
        result["Chirotherium"] = from_int(self.chirotherium)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


class MonotheisticallyClass:
    def __init__(self, blaspheme, catharticalness, celiosalpingectomy, chirotherium, consummativeness, disdiapason, egestive, enchylema, gasconade, holidayer, homocerc, intuitionalism, lophiostomate, nonbookish, nonvolition, palatableness, pimpery, previolation, reconveyance, registership, rhyacolite, smithereens, superedification, trust, whitestone):
        self.blaspheme = blaspheme
        self.catharticalness = catharticalness
        self.celiosalpingectomy = celiosalpingectomy
        self.chirotherium = chirotherium
        self.consummativeness = consummativeness
        self.disdiapason = disdiapason
        self.egestive = egestive
        self.enchylema = enchylema
        self.gasconade = gasconade
        self.holidayer = holidayer
        self.homocerc = homocerc
        self.intuitionalism = intuitionalism
        self.lophiostomate = lophiostomate
        self.nonbookish = nonbookish
        self.nonvolition = nonvolition
        self.palatableness = palatableness
        self.pimpery = pimpery
        self.previolation = previolation
        self.reconveyance = reconveyance
        self.registership = registership
        self.rhyacolite = rhyacolite
        self.smithereens = smithereens
        self.superedification = superedification
        self.trust = trust
        self.whitestone = whitestone

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        blaspheme = from_none(obj.get("blaspheme"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        celiosalpingectomy = from_none(obj.get("celiosalpingectomy"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        consummativeness = from_none(obj.get("consummativeness"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        egestive = from_none(obj.get("egestive"))
        enchylema = from_none(obj.get("enchylema"))
        gasconade = from_none(obj.get("gasconade"))
        holidayer = from_none(obj.get("holidayer"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        intuitionalism = from_none(obj.get("intuitionalism"))
        lophiostomate = from_none(obj.get("lophiostomate"))
        nonbookish = from_none(obj.get("nonbookish"))
        nonvolition = from_none(obj.get("nonvolition"))
        palatableness = from_none(obj.get("palatableness"))
        pimpery = from_none(obj.get("pimpery"))
        previolation = from_none(obj.get("previolation"))
        reconveyance = from_none(obj.get("reconveyance"))
        registership = from_none(obj.get("registership"))
        rhyacolite = from_none(obj.get("rhyacolite"))
        smithereens = from_none(obj.get("smithereens"))
        superedification = from_none(obj.get("superedification"))
        trust = from_none(obj.get("trust"))
        whitestone = from_none(obj.get("whitestone"))
        return MonotheisticallyClass(blaspheme, catharticalness, celiosalpingectomy, chirotherium, consummativeness, disdiapason, egestive, enchylema, gasconade, holidayer, homocerc, intuitionalism, lophiostomate, nonbookish, nonvolition, palatableness, pimpery, previolation, reconveyance, registership, rhyacolite, smithereens, superedification, trust, whitestone)

    def to_dict(self):
        result = {}
        if self.blaspheme is not None:
            result["blaspheme"] = from_none(self.blaspheme)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.celiosalpingectomy is not None:
            result["celiosalpingectomy"] = from_none(self.celiosalpingectomy)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.consummativeness is not None:
            result["consummativeness"] = from_none(self.consummativeness)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.egestive is not None:
            result["egestive"] = from_none(self.egestive)
        if self.enchylema is not None:
            result["enchylema"] = from_none(self.enchylema)
        if self.gasconade is not None:
            result["gasconade"] = from_none(self.gasconade)
        if self.holidayer is not None:
            result["holidayer"] = from_none(self.holidayer)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.intuitionalism is not None:
            result["intuitionalism"] = from_none(self.intuitionalism)
        if self.lophiostomate is not None:
            result["lophiostomate"] = from_none(self.lophiostomate)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.nonvolition is not None:
            result["nonvolition"] = from_none(self.nonvolition)
        if self.palatableness is not None:
            result["palatableness"] = from_none(self.palatableness)
        if self.pimpery is not None:
            result["pimpery"] = from_none(self.pimpery)
        if self.previolation is not None:
            result["previolation"] = from_none(self.previolation)
        if self.reconveyance is not None:
            result["reconveyance"] = from_none(self.reconveyance)
        if self.registership is not None:
            result["registership"] = from_none(self.registership)
        if self.rhyacolite is not None:
            result["rhyacolite"] = from_none(self.rhyacolite)
        if self.smithereens is not None:
            result["smithereens"] = from_none(self.smithereens)
        if self.superedification is not None:
            result["superedification"] = from_none(self.superedification)
        if self.trust is not None:
            result["trust"] = from_none(self.trust)
        if self.whitestone is not None:
            result["whitestone"] = from_none(self.whitestone)
        return result


class Noncontributing:
    def __init__(self, estevin, jolterhead, sauternes, sparsely, unrequested):
        self.estevin = estevin
        self.jolterhead = jolterhead
        self.sauternes = sauternes
        self.sparsely = sparsely
        self.unrequested = unrequested

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        estevin = from_str(obj["estevin"])
        jolterhead = from_float(obj["jolterhead"])
        sauternes = from_int(obj["sauternes"])
        sparsely = from_bool(obj["sparsely"])
        unrequested = from_none(obj["unrequested"])
        return Noncontributing(estevin, jolterhead, sauternes, sparsely, unrequested)

    def to_dict(self):
        result = {}
        result["estevin"] = from_str(self.estevin)
        result["jolterhead"] = to_float(self.jolterhead)
        result["sauternes"] = from_int(self.sauternes)
        result["sparsely"] = from_bool(self.sparsely)
        result["unrequested"] = from_none(self.unrequested)
        return result


class OccupationalistClass:
    def __init__(self, beholdable, brotuliform, chimakum, doodler, emulsin, fin, flourishing, flueless, furtively, gritter, interwish, monoxylic, myristic, nightwear, peruser, theoastrological, thumby, tingitid, trailless, unpocketed):
        self.beholdable = beholdable
        self.brotuliform = brotuliform
        self.chimakum = chimakum
        self.doodler = doodler
        self.emulsin = emulsin
        self.fin = fin
        self.flourishing = flourishing
        self.flueless = flueless
        self.furtively = furtively
        self.gritter = gritter
        self.interwish = interwish
        self.monoxylic = monoxylic
        self.myristic = myristic
        self.nightwear = nightwear
        self.peruser = peruser
        self.theoastrological = theoastrological
        self.thumby = thumby
        self.tingitid = tingitid
        self.trailless = trailless
        self.unpocketed = unpocketed

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        beholdable = from_none(obj["beholdable"])
        brotuliform = from_none(obj["brotuliform"])
        chimakum = from_none(obj["Chimakum"])
        doodler = from_none(obj["doodler"])
        emulsin = from_none(obj["emulsin"])
        fin = from_none(obj["Fin"])
        flourishing = from_none(obj["flourishing"])
        flueless = from_none(obj["flueless"])
        furtively = from_none(obj["furtively"])
        gritter = from_none(obj["gritter"])
        interwish = from_none(obj["interwish"])
        monoxylic = from_none(obj["monoxylic"])
        myristic = from_none(obj["myristic"])
        nightwear = from_none(obj["nightwear"])
        peruser = from_none(obj["peruser"])
        theoastrological = from_none(obj["theoastrological"])
        thumby = from_none(obj["thumby"])
        tingitid = from_none(obj["tingitid"])
        trailless = from_none(obj["trailless"])
        unpocketed = from_none(obj["unpocketed"])
        return OccupationalistClass(beholdable, brotuliform, chimakum, doodler, emulsin, fin, flourishing, flueless, furtively, gritter, interwish, monoxylic, myristic, nightwear, peruser, theoastrological, thumby, tingitid, trailless, unpocketed)

    def to_dict(self):
        result = {}
        result["beholdable"] = from_none(self.beholdable)
        result["brotuliform"] = from_none(self.brotuliform)
        result["Chimakum"] = from_none(self.chimakum)
        result["doodler"] = from_none(self.doodler)
        result["emulsin"] = from_none(self.emulsin)
        result["Fin"] = from_none(self.fin)
        result["flourishing"] = from_none(self.flourishing)
        result["flueless"] = from_none(self.flueless)
        result["furtively"] = from_none(self.furtively)
        result["gritter"] = from_none(self.gritter)
        result["interwish"] = from_none(self.interwish)
        result["monoxylic"] = from_none(self.monoxylic)
        result["myristic"] = from_none(self.myristic)
        result["nightwear"] = from_none(self.nightwear)
        result["peruser"] = from_none(self.peruser)
        result["theoastrological"] = from_none(self.theoastrological)
        result["thumby"] = from_none(self.thumby)
        result["tingitid"] = from_none(self.tingitid)
        result["trailless"] = from_none(self.trailless)
        result["unpocketed"] = from_none(self.unpocketed)
        return result


class OutrivalClass:
    def __init__(self, adroitly, bridehood, castoroides, czechoslovak, diagenesis, dihexahedron, dopester, eumerism, flyness, fouler, laudanosine, lingulidae, minutary, mitra, opisthorchiasis, pensively, pubigerous, rebellious, recodify, unpaced):
        self.adroitly = adroitly
        self.bridehood = bridehood
        self.castoroides = castoroides
        self.czechoslovak = czechoslovak
        self.diagenesis = diagenesis
        self.dihexahedron = dihexahedron
        self.dopester = dopester
        self.eumerism = eumerism
        self.flyness = flyness
        self.fouler = fouler
        self.laudanosine = laudanosine
        self.lingulidae = lingulidae
        self.minutary = minutary
        self.mitra = mitra
        self.opisthorchiasis = opisthorchiasis
        self.pensively = pensively
        self.pubigerous = pubigerous
        self.rebellious = rebellious
        self.recodify = recodify
        self.unpaced = unpaced

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        adroitly = from_none(obj["adroitly"])
        bridehood = from_none(obj["bridehood"])
        castoroides = from_none(obj["Castoroides"])
        czechoslovak = from_none(obj["Czechoslovak"])
        diagenesis = from_none(obj["diagenesis"])
        dihexahedron = from_none(obj["dihexahedron"])
        dopester = from_none(obj["dopester"])
        eumerism = from_none(obj["eumerism"])
        flyness = from_none(obj["flyness"])
        fouler = from_none(obj["fouler"])
        laudanosine = from_none(obj["laudanosine"])
        lingulidae = from_none(obj["Lingulidae"])
        minutary = from_none(obj["minutary"])
        mitra = from_none(obj["mitra"])
        opisthorchiasis = from_none(obj["opisthorchiasis"])
        pensively = from_none(obj["pensively"])
        pubigerous = from_none(obj["pubigerous"])
        rebellious = from_none(obj["rebellious"])
        recodify = from_none(obj["recodify"])
        unpaced = from_none(obj["unpaced"])
        return OutrivalClass(adroitly, bridehood, castoroides, czechoslovak, diagenesis, dihexahedron, dopester, eumerism, flyness, fouler, laudanosine, lingulidae, minutary, mitra, opisthorchiasis, pensively, pubigerous, rebellious, recodify, unpaced)

    def to_dict(self):
        result = {}
        result["adroitly"] = from_none(self.adroitly)
        result["bridehood"] = from_none(self.bridehood)
        result["Castoroides"] = from_none(self.castoroides)
        result["Czechoslovak"] = from_none(self.czechoslovak)
        result["diagenesis"] = from_none(self.diagenesis)
        result["dihexahedron"] = from_none(self.dihexahedron)
        result["dopester"] = from_none(self.dopester)
        result["eumerism"] = from_none(self.eumerism)
        result["flyness"] = from_none(self.flyness)
        result["fouler"] = from_none(self.fouler)
        result["laudanosine"] = from_none(self.laudanosine)
        result["Lingulidae"] = from_none(self.lingulidae)
        result["minutary"] = from_none(self.minutary)
        result["mitra"] = from_none(self.mitra)
        result["opisthorchiasis"] = from_none(self.opisthorchiasis)
        result["pensively"] = from_none(self.pensively)
        result["pubigerous"] = from_none(self.pubigerous)
        result["rebellious"] = from_none(self.rebellious)
        result["recodify"] = from_none(self.recodify)
        result["unpaced"] = from_none(self.unpaced)
        return result


class PiaculumClass:
    def __init__(self, alada, amphistomous, boysenberry, catharticalness, chirotherium, decardinalize, discouragement, disdiapason, doitrified, hexaspermous, homocerc, insinking, loathfulness, miasmatical, neurofibril, nonbookish, phonendoscope, pilferment, predismissory, preinscription, quotative, sienna, thorax, yachting, zipper):
        self.alada = alada
        self.amphistomous = amphistomous
        self.boysenberry = boysenberry
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.decardinalize = decardinalize
        self.discouragement = discouragement
        self.disdiapason = disdiapason
        self.doitrified = doitrified
        self.hexaspermous = hexaspermous
        self.homocerc = homocerc
        self.insinking = insinking
        self.loathfulness = loathfulness
        self.miasmatical = miasmatical
        self.neurofibril = neurofibril
        self.nonbookish = nonbookish
        self.phonendoscope = phonendoscope
        self.pilferment = pilferment
        self.predismissory = predismissory
        self.preinscription = preinscription
        self.quotative = quotative
        self.sienna = sienna
        self.thorax = thorax
        self.yachting = yachting
        self.zipper = zipper

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        alada = from_union([from_int, from_none], obj.get("alada"))
        amphistomous = from_union([from_int, from_none], obj.get("amphistomous"))
        boysenberry = from_union([from_int, from_none], obj.get("boysenberry"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        decardinalize = from_union([from_int, from_none], obj.get("decardinalize"))
        discouragement = from_union([from_int, from_none], obj.get("discouragement"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        doitrified = from_union([from_int, from_none], obj.get("doitrified"))
        hexaspermous = from_union([from_int, from_none], obj.get("hexaspermous"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        insinking = from_union([from_int, from_none], obj.get("insinking"))
        loathfulness = from_union([from_int, from_none], obj.get("loathfulness"))
        miasmatical = from_union([from_int, from_none], obj.get("miasmatical"))
        neurofibril = from_union([from_int, from_none], obj.get("neurofibril"))
        nonbookish = from_none(obj.get("nonbookish"))
        phonendoscope = from_union([from_int, from_none], obj.get("phonendoscope"))
        pilferment = from_union([from_int, from_none], obj.get("pilferment"))
        predismissory = from_union([from_int, from_none], obj.get("predismissory"))
        preinscription = from_union([from_int, from_none], obj.get("preinscription"))
        quotative = from_union([from_int, from_none], obj.get("quotative"))
        sienna = from_union([from_int, from_none], obj.get("sienna"))
        thorax = from_union([from_int, from_none], obj.get("thorax"))
        yachting = from_union([from_int, from_none], obj.get("yachting"))
        zipper = from_union([from_int, from_none], obj.get("Zipper"))
        return PiaculumClass(alada, amphistomous, boysenberry, catharticalness, chirotherium, decardinalize, discouragement, disdiapason, doitrified, hexaspermous, homocerc, insinking, loathfulness, miasmatical, neurofibril, nonbookish, phonendoscope, pilferment, predismissory, preinscription, quotative, sienna, thorax, yachting, zipper)

    def to_dict(self):
        result = {}
        if self.alada is not None:
            result["alada"] = from_union([from_int, from_none], self.alada)
        if self.amphistomous is not None:
            result["amphistomous"] = from_union([from_int, from_none], self.amphistomous)
        if self.boysenberry is not None:
            result["boysenberry"] = from_union([from_int, from_none], self.boysenberry)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.decardinalize is not None:
            result["decardinalize"] = from_union([from_int, from_none], self.decardinalize)
        if self.discouragement is not None:
            result["discouragement"] = from_union([from_int, from_none], self.discouragement)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.doitrified is not None:
            result["doitrified"] = from_union([from_int, from_none], self.doitrified)
        if self.hexaspermous is not None:
            result["hexaspermous"] = from_union([from_int, from_none], self.hexaspermous)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.insinking is not None:
            result["insinking"] = from_union([from_int, from_none], self.insinking)
        if self.loathfulness is not None:
            result["loathfulness"] = from_union([from_int, from_none], self.loathfulness)
        if self.miasmatical is not None:
            result["miasmatical"] = from_union([from_int, from_none], self.miasmatical)
        if self.neurofibril is not None:
            result["neurofibril"] = from_union([from_int, from_none], self.neurofibril)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.phonendoscope is not None:
            result["phonendoscope"] = from_union([from_int, from_none], self.phonendoscope)
        if self.pilferment is not None:
            result["pilferment"] = from_union([from_int, from_none], self.pilferment)
        if self.predismissory is not None:
            result["predismissory"] = from_union([from_int, from_none], self.predismissory)
        if self.preinscription is not None:
            result["preinscription"] = from_union([from_int, from_none], self.preinscription)
        if self.quotative is not None:
            result["quotative"] = from_union([from_int, from_none], self.quotative)
        if self.sienna is not None:
            result["sienna"] = from_union([from_int, from_none], self.sienna)
        if self.thorax is not None:
            result["thorax"] = from_union([from_int, from_none], self.thorax)
        if self.yachting is not None:
            result["yachting"] = from_union([from_int, from_none], self.yachting)
        if self.zipper is not None:
            result["Zipper"] = from_union([from_int, from_none], self.zipper)
        return result


class Pneumocele:
    def __init__(self, carbonarism, catharticalness, chirotherium, cineolic, cobbly, conchyliferous, congregation, disdiapason, enterotomy, entophytal, fewtrils, herem, homocerc, koniga, meticulosity, micky, mismarriage, neurotrophic, nonbookish, persuasively, replaceable, silex, taillight, unjealous, visitorial):
        self.carbonarism = carbonarism
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.cineolic = cineolic
        self.cobbly = cobbly
        self.conchyliferous = conchyliferous
        self.congregation = congregation
        self.disdiapason = disdiapason
        self.enterotomy = enterotomy
        self.entophytal = entophytal
        self.fewtrils = fewtrils
        self.herem = herem
        self.homocerc = homocerc
        self.koniga = koniga
        self.meticulosity = meticulosity
        self.micky = micky
        self.mismarriage = mismarriage
        self.neurotrophic = neurotrophic
        self.nonbookish = nonbookish
        self.persuasively = persuasively
        self.replaceable = replaceable
        self.silex = silex
        self.taillight = taillight
        self.unjealous = unjealous
        self.visitorial = visitorial

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        carbonarism = from_none(obj.get("Carbonarism"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        cineolic = from_none(obj.get("cineolic"))
        cobbly = from_none(obj.get("cobbly"))
        conchyliferous = from_none(obj.get("conchyliferous"))
        congregation = from_none(obj.get("congregation"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        enterotomy = from_none(obj.get("enterotomy"))
        entophytal = from_none(obj.get("entophytal"))
        fewtrils = from_none(obj.get("fewtrils"))
        herem = from_none(obj.get("herem"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        koniga = from_none(obj.get("Koniga"))
        meticulosity = from_none(obj.get("meticulosity"))
        micky = from_none(obj.get("Micky"))
        mismarriage = from_none(obj.get("mismarriage"))
        neurotrophic = from_none(obj.get("neurotrophic"))
        nonbookish = from_none(obj.get("nonbookish"))
        persuasively = from_none(obj.get("persuasively"))
        replaceable = from_none(obj.get("replaceable"))
        silex = from_none(obj.get("silex"))
        taillight = from_none(obj.get("taillight"))
        unjealous = from_none(obj.get("unjealous"))
        visitorial = from_none(obj.get("visitorial"))
        return Pneumocele(carbonarism, catharticalness, chirotherium, cineolic, cobbly, conchyliferous, congregation, disdiapason, enterotomy, entophytal, fewtrils, herem, homocerc, koniga, meticulosity, micky, mismarriage, neurotrophic, nonbookish, persuasively, replaceable, silex, taillight, unjealous, visitorial)

    def to_dict(self):
        result = {}
        if self.carbonarism is not None:
            result["Carbonarism"] = from_none(self.carbonarism)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
        if self.cineolic is not None:
            result["cineolic"] = from_none(self.cineolic)
        if self.cobbly is not None:
            result["cobbly"] = from_none(self.cobbly)
        if self.conchyliferous is not None:
            result["conchyliferous"] = from_none(self.conchyliferous)
        if self.congregation is not None:
            result["congregation"] = from_none(self.congregation)
        if self.disdiapason is not None:
            result["disdiapason"] = from_union([from_none, from_str], self.disdiapason)
        if self.enterotomy is not None:
            result["enterotomy"] = from_none(self.enterotomy)
        if self.entophytal is not None:
            result["entophytal"] = from_none(self.entophytal)
        if self.fewtrils is not None:
            result["fewtrils"] = from_none(self.fewtrils)
        if self.herem is not None:
            result["herem"] = from_none(self.herem)
        if self.homocerc is not None:
            result["homocerc"] = from_union([from_bool, from_none], self.homocerc)
        if self.koniga is not None:
            result["Koniga"] = from_none(self.koniga)
        if self.meticulosity is not None:
            result["meticulosity"] = from_none(self.meticulosity)
        if self.micky is not None:
            result["Micky"] = from_none(self.micky)
        if self.mismarriage is not None:
            result["mismarriage"] = from_none(self.mismarriage)
        if self.neurotrophic is not None:
            result["neurotrophic"] = from_none(self.neurotrophic)
        if self.nonbookish is not None:
            result["nonbookish"] = from_none(self.nonbookish)
        if self.persuasively is not None:
            result["persuasively"] = from_none(self.persuasively)
        if self.replaceable is not None:
            result["replaceable"] = from_none(self.replaceable)
        if self.silex is not None:
            result["silex"] = from_none(self.silex)
        if self.taillight is not None:
            result["taillight"] = from_none(self.taillight)
        if self.unjealous is not None:
            result["unjealous"] = from_none(self.unjealous)
        if self.visitorial is not None:
            result["visitorial"] = from_none(self.visitorial)
        return result


class PotwhiskyClass:
    def __init__(self, arciform, cresolin, disheartener, disproportionable, euchorda, ferryway, filamentiferous, flemish, forgainst, grainering, irrevoluble, kindredship, pinguitudinous, simpletonic, singsong, submergement, supraoesophagal, thrashel, tyremesis, yoruba):
        self.arciform = arciform
        self.cresolin = cresolin
        self.disheartener = disheartener
        self.disproportionable = disproportionable
        self.euchorda = euchorda
        self.ferryway = ferryway
        self.filamentiferous = filamentiferous
        self.flemish = flemish
        self.forgainst = forgainst
        self.grainering = grainering
        self.irrevoluble = irrevoluble
        self.kindredship = kindredship
        self.pinguitudinous = pinguitudinous
        self.simpletonic = simpletonic
        self.singsong = singsong
        self.submergement = submergement
        self.supraoesophagal = supraoesophagal
        self.thrashel = thrashel
        self.tyremesis = tyremesis
        self.yoruba = yoruba

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        arciform = from_none(obj["arciform"])
        cresolin = from_none(obj["cresolin"])
        disheartener = from_none(obj["disheartener"])
        disproportionable = from_none(obj["disproportionable"])
        euchorda = from_none(obj["Euchorda"])
        ferryway = from_none(obj["ferryway"])
        filamentiferous = from_none(obj["filamentiferous"])
        flemish = from_none(obj["flemish"])
        forgainst = from_none(obj["forgainst"])
        grainering = from_none(obj["grainering"])
        irrevoluble = from_none(obj["irrevoluble"])
        kindredship = from_none(obj["kindredship"])
        pinguitudinous = from_none(obj["pinguitudinous"])
        simpletonic = from_none(obj["simpletonic"])
        singsong = from_none(obj["singsong"])
        submergement = from_none(obj["submergement"])
        supraoesophagal = from_none(obj["supraoesophagal"])
        thrashel = from_none(obj["thrashel"])
        tyremesis = from_none(obj["tyremesis"])
        yoruba = from_none(obj["Yoruba"])
        return PotwhiskyClass(arciform, cresolin, disheartener, disproportionable, euchorda, ferryway, filamentiferous, flemish, forgainst, grainering, irrevoluble, kindredship, pinguitudinous, simpletonic, singsong, submergement, supraoesophagal, thrashel, tyremesis, yoruba)

    def to_dict(self):
        result = {}
        result["arciform"] = from_none(self.arciform)
        result["cresolin"] = from_none(self.cresolin)
        result["disheartener"] = from_none(self.disheartener)
        result["disproportionable"] = from_none(self.disproportionable)
        result["Euchorda"] = from_none(self.euchorda)
        result["ferryway"] = from_none(self.ferryway)
        result["filamentiferous"] = from_none(self.filamentiferous)
        result["flemish"] = from_none(self.flemish)
        result["forgainst"] = from_none(self.forgainst)
        result["grainering"] = from_none(self.grainering)
        result["irrevoluble"] = from_none(self.irrevoluble)
        result["kindredship"] = from_none(self.kindredship)
        result["pinguitudinous"] = from_none(self.pinguitudinous)
        result["simpletonic"] = from_none(self.simpletonic)
        result["singsong"] = from_none(self.singsong)
        result["submergement"] = from_none(self.submergement)
        result["supraoesophagal"] = from_none(self.supraoesophagal)
        result["thrashel"] = from_none(self.thrashel)
        result["tyremesis"] = from_none(self.tyremesis)
        result["Yoruba"] = from_none(self.yoruba)
        return result


class PrefreshmanClass:
    def __init__(self, azorubine, choroiditis, coagulatory, cyclorama, dolphus, duckhearted, ficus, gemaric, jugation, myoliposis, nonnomination, palay, pentactinal, phaet, piquant, registration, remancipation, scutatiform, theodolite, underward):
        self.azorubine = azorubine
        self.choroiditis = choroiditis
        self.coagulatory = coagulatory
        self.cyclorama = cyclorama
        self.dolphus = dolphus
        self.duckhearted = duckhearted
        self.ficus = ficus
        self.gemaric = gemaric
        self.jugation = jugation
        self.myoliposis = myoliposis
        self.nonnomination = nonnomination
        self.palay = palay
        self.pentactinal = pentactinal
        self.phaet = phaet
        self.piquant = piquant
        self.registration = registration
        self.remancipation = remancipation
        self.scutatiform = scutatiform
        self.theodolite = theodolite
        self.underward = underward

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        azorubine = from_none(obj["azorubine"])
        choroiditis = from_none(obj["choroiditis"])
        coagulatory = from_none(obj["coagulatory"])
        cyclorama = from_none(obj["cyclorama"])
        dolphus = from_none(obj["Dolphus"])
        duckhearted = from_none(obj["duckhearted"])
        ficus = from_none(obj["Ficus"])
        gemaric = from_none(obj["Gemaric"])
        jugation = from_none(obj["jugation"])
        myoliposis = from_none(obj["myoliposis"])
        nonnomination = from_none(obj["nonnomination"])
        palay = from_none(obj["palay"])
        pentactinal = from_none(obj["pentactinal"])
        phaet = from_none(obj["Phaet"])
        piquant = from_none(obj["piquant"])
        registration = from_none(obj["registration"])
        remancipation = from_none(obj["remancipation"])
        scutatiform = from_none(obj["scutatiform"])
        theodolite = from_none(obj["theodolite"])
        underward = from_none(obj["underward"])
        return PrefreshmanClass(azorubine, choroiditis, coagulatory, cyclorama, dolphus, duckhearted, ficus, gemaric, jugation, myoliposis, nonnomination, palay, pentactinal, phaet, piquant, registration, remancipation, scutatiform, theodolite, underward)

    def to_dict(self):
        result = {}
        result["azorubine"] = from_none(self.azorubine)
        result["choroiditis"] = from_none(self.choroiditis)
        result["coagulatory"] = from_none(self.coagulatory)
        result["cyclorama"] = from_none(self.cyclorama)
        result["Dolphus"] = from_none(self.dolphus)
        result["duckhearted"] = from_none(self.duckhearted)
        result["Ficus"] = from_none(self.ficus)
        result["Gemaric"] = from_none(self.gemaric)
        result["jugation"] = from_none(self.jugation)
        result["myoliposis"] = from_none(self.myoliposis)
        result["nonnomination"] = from_none(self.nonnomination)
        result["palay"] = from_none(self.palay)
        result["pentactinal"] = from_none(self.pentactinal)
        result["Phaet"] = from_none(self.phaet)
        result["piquant"] = from_none(self.piquant)
        result["registration"] = from_none(self.registration)
        result["remancipation"] = from_none(self.remancipation)
        result["scutatiform"] = from_none(self.scutatiform)
        result["theodolite"] = from_none(self.theodolite)
        result["underward"] = from_none(self.underward)
        return result


class TopLevel:
    def __init__(self, juror, kongoni, ladronism, landlubberly, listener, lupus, maslin, monazite, monoliteral, monotheistically, montage, moralness, mowra, mulishly, myoscope, nach, neuromastic, noncontributing, nonnervous, nonvaluation, occupationalist, outrival, paleographically, pamphletwise, pediatrics, perceptive, piaculum, piccadilly, piffler, pithful, placuntitis, plectopterous, pneumocele, poliorcetic, poormaster, potwhisky, practicalizer, prefreshman, prehensility, prevoidance, probant, protext):
        self.juror = juror
        self.kongoni = kongoni
        self.ladronism = ladronism
        self.landlubberly = landlubberly
        self.listener = listener
        self.lupus = lupus
        self.maslin = maslin
        self.monazite = monazite
        self.monoliteral = monoliteral
        self.monotheistically = monotheistically
        self.montage = montage
        self.moralness = moralness
        self.mowra = mowra
        self.mulishly = mulishly
        self.myoscope = myoscope
        self.nach = nach
        self.neuromastic = neuromastic
        self.noncontributing = noncontributing
        self.nonnervous = nonnervous
        self.nonvaluation = nonvaluation
        self.occupationalist = occupationalist
        self.outrival = outrival
        self.paleographically = paleographically
        self.pamphletwise = pamphletwise
        self.pediatrics = pediatrics
        self.perceptive = perceptive
        self.piaculum = piaculum
        self.piccadilly = piccadilly
        self.piffler = piffler
        self.pithful = pithful
        self.placuntitis = placuntitis
        self.plectopterous = plectopterous
        self.pneumocele = pneumocele
        self.poliorcetic = poliorcetic
        self.poormaster = poormaster
        self.potwhisky = potwhisky
        self.practicalizer = practicalizer
        self.prefreshman = prefreshman
        self.prehensility = prehensility
        self.prevoidance = prevoidance
        self.probant = probant
        self.protext = protext

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        juror = from_list(lambda x: from_union([from_bool, JurorClass.from_dict], x), obj["juror"])
        kongoni = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x)], x), obj["kongoni"])
        ladronism = from_list(lambda x: from_union([LadronismClass.from_dict, from_float, from_str], x), obj["ladronism"])
        landlubberly = from_list(lambda x: from_union([from_bool, LandlubberlyClass.from_dict, from_int], x), obj["landlubberly"])
        listener = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int], x), obj["listener"])
        lupus = from_list(lambda x: from_union([LupusClass.from_dict, from_int], x), obj["lupus"])
        maslin = from_list(Maslin.from_dict, obj["maslin"])
        monazite = from_list(lambda x: from_union([MonaziteClass.from_dict, from_float], x), obj["monazite"])
        monoliteral = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool], x), obj["monoliteral"])
        monotheistically = from_list(lambda x: from_union([lambda x: from_list(from_none, x), MonotheisticallyClass.from_dict], x), obj["monotheistically"])
        montage = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_float, from_str], x), obj["montage"])
        moralness = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_float, from_none], x), obj["moralness"])
        mowra = from_list(lambda x: from_union([MonaziteClass.from_dict, from_none], x), obj["mowra"])
        mulishly = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_float, from_none], x), obj["mulishly"])
        myoscope = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_int], x), obj["myoscope"])
        nach = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_none], x), obj["nach"])
        neuromastic = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_float], x), obj["neuromastic"])
        noncontributing = from_list(Noncontributing.from_dict, obj["noncontributing"])
        nonnervous = from_list(lambda x: from_union([from_bool, from_int], x), obj["nonnervous"])
        nonvaluation = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_float], x), obj["nonvaluation"])
        occupationalist = from_list(lambda x: from_union([lambda x: from_list(from_none, x), OccupationalistClass.from_dict, from_none], x), obj["occupationalist"])
        outrival = from_list(lambda x: from_union([OutrivalClass.from_dict, from_float, from_none], x), obj["outrival"])
        paleographically = from_list(lambda x: from_union([from_float, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), obj["paleographically"])
        pamphletwise = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x), from_str], x), obj["pamphletwise"])
        pediatrics = from_list(lambda x: from_union([from_bool, from_float, from_none], x), obj["pediatrics"])
        perceptive = from_list(from_bool, obj["perceptive"])
        piaculum = from_list(lambda x: from_union([PiaculumClass.from_dict, from_float], x), obj["piaculum"])
        piccadilly = from_list(lambda x: from_union([from_float, from_none, from_str], x), obj["piccadilly"])
        piffler = from_list(lambda x: from_union([lambda x: from_list(from_none, x), MonaziteClass.from_dict], x), obj["piffler"])
        pithful = from_list(lambda x: from_union([from_bool, from_int, from_none], x), obj["pithful"])
        placuntitis = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x)], x), obj["placuntitis"])
        plectopterous = from_list(lambda x: from_union([from_float, lambda x: from_dict(from_int, x)], x), obj["plectopterous"])
        pneumocele = from_list(lambda x: from_union([Pneumocele.from_dict, from_none], x), obj["pneumocele"])
        poliorcetic = from_list(lambda x: from_union([from_bool, MonaziteClass.from_dict], x), obj["poliorcetic"])
        poormaster = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x), from_none], x), obj["poormaster"])
        potwhisky = from_list(lambda x: from_union([PotwhiskyClass.from_dict, from_int, from_none], x), obj["potwhisky"])
        practicalizer = from_list(lambda x: from_union([lambda x: from_list(from_none, x), MonaziteClass.from_dict, from_str], x), obj["practicalizer"])
        prefreshman = from_list(lambda x: from_union([lambda x: from_list(from_none, x), PrefreshmanClass.from_dict, from_str], x), obj["prefreshman"])
        prehensility = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, MonaziteClass.from_dict], x), obj["prehensility"])
        prevoidance = from_list(lambda x: from_union([lambda x: from_list(from_int, x), MonaziteClass.from_dict, from_int], x), obj["prevoidance"])
        probant = from_list(lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), obj["probant"])
        protext = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, MonaziteClass.from_dict], x), obj["protext"])
        return TopLevel(juror, kongoni, ladronism, landlubberly, listener, lupus, maslin, monazite, monoliteral, monotheistically, montage, moralness, mowra, mulishly, myoscope, nach, neuromastic, noncontributing, nonnervous, nonvaluation, occupationalist, outrival, paleographically, pamphletwise, pediatrics, perceptive, piaculum, piccadilly, piffler, pithful, placuntitis, plectopterous, pneumocele, poliorcetic, poormaster, potwhisky, practicalizer, prefreshman, prehensility, prevoidance, probant, protext)

    def to_dict(self):
        result = {}
        result["juror"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(JurorClass, x)], x), self.juror)
        result["kongoni"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x)], x), self.kongoni)
        result["ladronism"] = from_list(lambda x: from_union([lambda x: to_class(LadronismClass, x), to_float, from_str], x), self.ladronism)
        result["landlubberly"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(LandlubberlyClass, x), from_int], x), self.landlubberly)
        result["listener"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_int], x), self.listener)
        result["lupus"] = from_list(lambda x: from_union([lambda x: to_class(LupusClass, x), from_int], x), self.lupus)
        result["maslin"] = from_list(lambda x: to_class(Maslin, x), self.maslin)
        result["monazite"] = from_list(lambda x: from_union([lambda x: to_class(MonaziteClass, x), to_float], x), self.monazite)
        result["monoliteral"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool], x), self.monoliteral)
        result["monotheistically"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(MonotheisticallyClass, x)], x), self.monotheistically)
        result["montage"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), to_float, from_str], x), self.montage)
        result["moralness"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), to_float, from_none], x), self.moralness)
        result["mowra"] = from_list(lambda x: from_union([lambda x: to_class(MonaziteClass, x), from_none], x), self.mowra)
        result["mulishly"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), to_float, from_none], x), self.mulishly)
        result["myoscope"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, from_int], x), self.myoscope)
        result["nach"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), from_none], x), self.nach)
        result["neuromastic"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), to_float], x), self.neuromastic)
        result["noncontributing"] = from_list(lambda x: to_class(Noncontributing, x), self.noncontributing)
        result["nonnervous"] = from_list(lambda x: from_union([from_bool, from_int], x), self.nonnervous)
        result["nonvaluation"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, to_float], x), self.nonvaluation)
        result["occupationalist"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(OccupationalistClass, x), from_none], x), self.occupationalist)
        result["outrival"] = from_list(lambda x: from_union([lambda x: to_class(OutrivalClass, x), to_float, from_none], x), self.outrival)
        result["paleographically"] = from_list(lambda x: from_union([to_float, lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x)], x), self.paleographically)
        result["pamphletwise"] = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x), from_str], x), self.pamphletwise)
        result["pediatrics"] = from_list(lambda x: from_union([from_bool, to_float, from_none], x), self.pediatrics)
        result["perceptive"] = from_list(from_bool, self.perceptive)
        result["piaculum"] = from_list(lambda x: from_union([lambda x: to_class(PiaculumClass, x), to_float], x), self.piaculum)
        result["piccadilly"] = from_list(lambda x: from_union([to_float, from_none, from_str], x), self.piccadilly)
        result["piffler"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(MonaziteClass, x)], x), self.piffler)
        result["pithful"] = from_list(lambda x: from_union([from_bool, from_int, from_none], x), self.pithful)
        result["placuntitis"] = from_list(lambda x: from_union([from_int, lambda x: from_dict(from_int, x)], x), self.placuntitis)
        result["plectopterous"] = from_list(lambda x: from_union([to_float, lambda x: from_dict(from_int, x)], x), self.plectopterous)
        result["pneumocele"] = from_list(lambda x: from_union([lambda x: to_class(Pneumocele, x), from_none], x), self.pneumocele)
        result["poliorcetic"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(MonaziteClass, x)], x), self.poliorcetic)
        result["poormaster"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: from_dict(from_int, x), from_none], x), self.poormaster)
        result["potwhisky"] = from_list(lambda x: from_union([lambda x: to_class(PotwhiskyClass, x), from_int, from_none], x), self.potwhisky)
        result["practicalizer"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(MonaziteClass, x), from_str], x), self.practicalizer)
        result["prefreshman"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), lambda x: to_class(PrefreshmanClass, x), from_str], x), self.prefreshman)
        result["prehensility"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_bool, lambda x: to_class(MonaziteClass, x)], x), self.prehensility)
        result["prevoidance"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(MonaziteClass, x), from_int], x), self.prevoidance)
        result["probant"] = from_list(lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), self.probant)
        result["protext"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool, lambda x: to_class(MonaziteClass, x)], x), self.protext)
        return result


def top_level_from_dict(s):
    return TopLevel.from_dict(s)


def top_level_to_dict(x):
    return to_class(TopLevel, x)
