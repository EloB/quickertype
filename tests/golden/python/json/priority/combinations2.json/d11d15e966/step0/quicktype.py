def from_none(x):
    assert x is None
    return x


def from_float(x):
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_list(f, x):
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_dict(f, x):
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c, x):
    assert isinstance(x, c)
    return x.to_dict()


class AlleviateClass:
    def __init__(self, apriori, beggarer, brokenheartedly, debilitation, frike, gastrolith, hulsean, orthocentric, petaly, probudgeting, reacquire, scow, shutoff, subcontiguous, suffumigate, transformable, uncoroneted, unparking, unvarnishedness, wherewithal):
        self.apriori = apriori
        self.beggarer = beggarer
        self.brokenheartedly = brokenheartedly
        self.debilitation = debilitation
        self.frike = frike
        self.gastrolith = gastrolith
        self.hulsean = hulsean
        self.orthocentric = orthocentric
        self.petaly = petaly
        self.probudgeting = probudgeting
        self.reacquire = reacquire
        self.scow = scow
        self.shutoff = shutoff
        self.subcontiguous = subcontiguous
        self.suffumigate = suffumigate
        self.transformable = transformable
        self.uncoroneted = uncoroneted
        self.unparking = unparking
        self.unvarnishedness = unvarnishedness
        self.wherewithal = wherewithal

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        apriori = from_none(obj["apriori"])
        beggarer = from_none(obj["beggarer"])
        brokenheartedly = from_none(obj["brokenheartedly"])
        debilitation = from_none(obj["debilitation"])
        frike = from_none(obj["frike"])
        gastrolith = from_none(obj["gastrolith"])
        hulsean = from_none(obj["Hulsean"])
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
        return AlleviateClass(apriori, beggarer, brokenheartedly, debilitation, frike, gastrolith, hulsean, orthocentric, petaly, probudgeting, reacquire, scow, shutoff, subcontiguous, suffumigate, transformable, uncoroneted, unparking, unvarnishedness, wherewithal)

    def to_dict(self):
        result = {}
        result["apriori"] = from_none(self.apriori)
        result["beggarer"] = from_none(self.beggarer)
        result["brokenheartedly"] = from_none(self.brokenheartedly)
        result["debilitation"] = from_none(self.debilitation)
        result["frike"] = from_none(self.frike)
        result["gastrolith"] = from_none(self.gastrolith)
        result["Hulsean"] = from_none(self.hulsean)
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


class Rebecca:
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
        return Rebecca(catharticalness, chirotherium, disdiapason, homocerc, nonbookish)

    def to_dict(self):
        result = {}
        result["catharticalness"] = to_float(self.catharticalness)
        result["Chirotherium"] = from_int(self.chirotherium)
        result["disdiapason"] = from_str(self.disdiapason)
        result["homocerc"] = from_bool(self.homocerc)
        result["nonbookish"] = from_none(self.nonbookish)
        return result


class Amphithyron:
    def __init__(self, akroasis, antiphonical, basebred, catharticalness, chirotherium, conductometric, disdiapason, ensilation, eyebolt, fistulated, heteropod, homocerc, juniperus, labyrinthically, martyrization, mispolicy, multipara, nazirite, nonbookish, possessorial, shamed, shelfworn, stagnum, those, undecimal):
        self.akroasis = akroasis
        self.antiphonical = antiphonical
        self.basebred = basebred
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.conductometric = conductometric
        self.disdiapason = disdiapason
        self.ensilation = ensilation
        self.eyebolt = eyebolt
        self.fistulated = fistulated
        self.heteropod = heteropod
        self.homocerc = homocerc
        self.juniperus = juniperus
        self.labyrinthically = labyrinthically
        self.martyrization = martyrization
        self.mispolicy = mispolicy
        self.multipara = multipara
        self.nazirite = nazirite
        self.nonbookish = nonbookish
        self.possessorial = possessorial
        self.shamed = shamed
        self.shelfworn = shelfworn
        self.stagnum = stagnum
        self.those = those
        self.undecimal = undecimal

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        akroasis = from_union([from_int, from_none], obj.get("akroasis"))
        antiphonical = from_union([from_int, from_none], obj.get("antiphonical"))
        basebred = from_union([from_int, from_none], obj.get("basebred"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
        conductometric = from_union([from_int, from_none], obj.get("conductometric"))
        disdiapason = from_union([from_none, from_str], obj.get("disdiapason"))
        ensilation = from_union([from_int, from_none], obj.get("ensilation"))
        eyebolt = from_union([from_int, from_none], obj.get("eyebolt"))
        fistulated = from_union([from_int, from_none], obj.get("fistulated"))
        heteropod = from_union([from_int, from_none], obj.get("heteropod"))
        homocerc = from_union([from_bool, from_none], obj.get("homocerc"))
        juniperus = from_union([from_int, from_none], obj.get("Juniperus"))
        labyrinthically = from_union([from_int, from_none], obj.get("labyrinthically"))
        martyrization = from_union([from_int, from_none], obj.get("martyrization"))
        mispolicy = from_union([from_int, from_none], obj.get("mispolicy"))
        multipara = from_union([from_int, from_none], obj.get("multipara"))
        nazirite = from_union([from_int, from_none], obj.get("Nazirite"))
        nonbookish = from_none(obj.get("nonbookish"))
        possessorial = from_union([from_int, from_none], obj.get("possessorial"))
        shamed = from_union([from_int, from_none], obj.get("shamed"))
        shelfworn = from_union([from_int, from_none], obj.get("shelfworn"))
        stagnum = from_union([from_int, from_none], obj.get("stagnum"))
        those = from_union([from_int, from_none], obj.get("Those"))
        undecimal = from_union([from_int, from_none], obj.get("undecimal"))
        return Amphithyron(akroasis, antiphonical, basebred, catharticalness, chirotherium, conductometric, disdiapason, ensilation, eyebolt, fistulated, heteropod, homocerc, juniperus, labyrinthically, martyrization, mispolicy, multipara, nazirite, nonbookish, possessorial, shamed, shelfworn, stagnum, those, undecimal)

    def to_dict(self):
        result = {}
        if self.akroasis is not None:
            result["akroasis"] = from_union([from_int, from_none], self.akroasis)
        if self.antiphonical is not None:
            result["antiphonical"] = from_union([from_int, from_none], self.antiphonical)
        if self.basebred is not None:
            result["basebred"] = from_union([from_int, from_none], self.basebred)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.juniperus is not None:
            result["Juniperus"] = from_union([from_int, from_none], self.juniperus)
        if self.labyrinthically is not None:
            result["labyrinthically"] = from_union([from_int, from_none], self.labyrinthically)
        if self.martyrization is not None:
            result["martyrization"] = from_union([from_int, from_none], self.martyrization)
        if self.mispolicy is not None:
            result["mispolicy"] = from_union([from_int, from_none], self.mispolicy)
        if self.multipara is not None:
            result["multipara"] = from_union([from_int, from_none], self.multipara)
        if self.nazirite is not None:
            result["Nazirite"] = from_union([from_int, from_none], self.nazirite)
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
        if self.those is not None:
            result["Those"] = from_union([from_int, from_none], self.those)
        if self.undecimal is not None:
            result["undecimal"] = from_union([from_int, from_none], self.undecimal)
        return result


class AnkeeClass:
    def __init__(self, anomoean, barleyhood, befriender, brutishness, cephalalgy, cirurgian, conventionally, jackshay, milammeter, naja, ombrological, phonasthenia, retrievableness, snakily, swot, tartlet, thiofuran, tracheophone, tuglike, unscratchingly):
        self.anomoean = anomoean
        self.barleyhood = barleyhood
        self.befriender = befriender
        self.brutishness = brutishness
        self.cephalalgy = cephalalgy
        self.cirurgian = cirurgian
        self.conventionally = conventionally
        self.jackshay = jackshay
        self.milammeter = milammeter
        self.naja = naja
        self.ombrological = ombrological
        self.phonasthenia = phonasthenia
        self.retrievableness = retrievableness
        self.snakily = snakily
        self.swot = swot
        self.tartlet = tartlet
        self.thiofuran = thiofuran
        self.tracheophone = tracheophone
        self.tuglike = tuglike
        self.unscratchingly = unscratchingly

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        anomoean = from_none(obj["Anomoean"])
        barleyhood = from_none(obj["barleyhood"])
        befriender = from_none(obj["befriender"])
        brutishness = from_none(obj["brutishness"])
        cephalalgy = from_none(obj["cephalalgy"])
        cirurgian = from_none(obj["cirurgian"])
        conventionally = from_none(obj["conventionally"])
        jackshay = from_none(obj["jackshay"])
        milammeter = from_none(obj["milammeter"])
        naja = from_none(obj["Naja"])
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
        return AnkeeClass(anomoean, barleyhood, befriender, brutishness, cephalalgy, cirurgian, conventionally, jackshay, milammeter, naja, ombrological, phonasthenia, retrievableness, snakily, swot, tartlet, thiofuran, tracheophone, tuglike, unscratchingly)

    def to_dict(self):
        result = {}
        result["Anomoean"] = from_none(self.anomoean)
        result["barleyhood"] = from_none(self.barleyhood)
        result["befriender"] = from_none(self.befriender)
        result["brutishness"] = from_none(self.brutishness)
        result["cephalalgy"] = from_none(self.cephalalgy)
        result["cirurgian"] = from_none(self.cirurgian)
        result["conventionally"] = from_none(self.conventionally)
        result["jackshay"] = from_none(self.jackshay)
        result["milammeter"] = from_none(self.milammeter)
        result["Naja"] = from_none(self.naja)
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


class AnsarieClass:
    def __init__(self, accension, alida, asteria, beriberic, edgebone, gastrodialysis, geographic, ictonyx, metrocele, misgraft, monteith, notcher, prorestriction, ramist, throatlet, unfair, unsynonymous, water, zestfully, zincic):
        self.accension = accension
        self.alida = alida
        self.asteria = asteria
        self.beriberic = beriberic
        self.edgebone = edgebone
        self.gastrodialysis = gastrodialysis
        self.geographic = geographic
        self.ictonyx = ictonyx
        self.metrocele = metrocele
        self.misgraft = misgraft
        self.monteith = monteith
        self.notcher = notcher
        self.prorestriction = prorestriction
        self.ramist = ramist
        self.throatlet = throatlet
        self.unfair = unfair
        self.unsynonymous = unsynonymous
        self.water = water
        self.zestfully = zestfully
        self.zincic = zincic

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        accension = from_none(obj["accension"])
        alida = from_none(obj["Alida"])
        asteria = from_none(obj["asteria"])
        beriberic = from_none(obj["beriberic"])
        edgebone = from_none(obj["edgebone"])
        gastrodialysis = from_none(obj["gastrodialysis"])
        geographic = from_none(obj["geographic"])
        ictonyx = from_none(obj["Ictonyx"])
        metrocele = from_none(obj["metrocele"])
        misgraft = from_none(obj["misgraft"])
        monteith = from_none(obj["monteith"])
        notcher = from_none(obj["notcher"])
        prorestriction = from_none(obj["prorestriction"])
        ramist = from_none(obj["Ramist"])
        throatlet = from_none(obj["throatlet"])
        unfair = from_none(obj["unfair"])
        unsynonymous = from_none(obj["unsynonymous"])
        water = from_none(obj["water"])
        zestfully = from_none(obj["zestfully"])
        zincic = from_none(obj["zincic"])
        return AnsarieClass(accension, alida, asteria, beriberic, edgebone, gastrodialysis, geographic, ictonyx, metrocele, misgraft, monteith, notcher, prorestriction, ramist, throatlet, unfair, unsynonymous, water, zestfully, zincic)

    def to_dict(self):
        result = {}
        result["accension"] = from_none(self.accension)
        result["Alida"] = from_none(self.alida)
        result["asteria"] = from_none(self.asteria)
        result["beriberic"] = from_none(self.beriberic)
        result["edgebone"] = from_none(self.edgebone)
        result["gastrodialysis"] = from_none(self.gastrodialysis)
        result["geographic"] = from_none(self.geographic)
        result["Ictonyx"] = from_none(self.ictonyx)
        result["metrocele"] = from_none(self.metrocele)
        result["misgraft"] = from_none(self.misgraft)
        result["monteith"] = from_none(self.monteith)
        result["notcher"] = from_none(self.notcher)
        result["prorestriction"] = from_none(self.prorestriction)
        result["Ramist"] = from_none(self.ramist)
        result["throatlet"] = from_none(self.throatlet)
        result["unfair"] = from_none(self.unfair)
        result["unsynonymous"] = from_none(self.unsynonymous)
        result["water"] = from_none(self.water)
        result["zestfully"] = from_none(self.zestfully)
        result["zincic"] = from_none(self.zincic)
        return result


class ChytridiaceaeClass:
    def __init__(self, batidaceae, brechites, codespairer, emery, enervative, excriminate, goshenite, grime, gritten, hectorly, intermediation, meeterly, narraganset, onymatic, paddlecock, thana, thornily, uckia, unmettle, vorticellid):
        self.batidaceae = batidaceae
        self.brechites = brechites
        self.codespairer = codespairer
        self.emery = emery
        self.enervative = enervative
        self.excriminate = excriminate
        self.goshenite = goshenite
        self.grime = grime
        self.gritten = gritten
        self.hectorly = hectorly
        self.intermediation = intermediation
        self.meeterly = meeterly
        self.narraganset = narraganset
        self.onymatic = onymatic
        self.paddlecock = paddlecock
        self.thana = thana
        self.thornily = thornily
        self.uckia = uckia
        self.unmettle = unmettle
        self.vorticellid = vorticellid

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        batidaceae = from_none(obj["Batidaceae"])
        brechites = from_none(obj["Brechites"])
        codespairer = from_none(obj["codespairer"])
        emery = from_none(obj["Emery"])
        enervative = from_none(obj["enervative"])
        excriminate = from_none(obj["excriminate"])
        goshenite = from_none(obj["goshenite"])
        grime = from_none(obj["grime"])
        gritten = from_none(obj["gritten"])
        hectorly = from_none(obj["hectorly"])
        intermediation = from_none(obj["intermediation"])
        meeterly = from_none(obj["meeterly"])
        narraganset = from_none(obj["Narraganset"])
        onymatic = from_none(obj["onymatic"])
        paddlecock = from_none(obj["paddlecock"])
        thana = from_none(obj["thana"])
        thornily = from_none(obj["thornily"])
        uckia = from_none(obj["uckia"])
        unmettle = from_none(obj["unmettle"])
        vorticellid = from_none(obj["vorticellid"])
        return ChytridiaceaeClass(batidaceae, brechites, codespairer, emery, enervative, excriminate, goshenite, grime, gritten, hectorly, intermediation, meeterly, narraganset, onymatic, paddlecock, thana, thornily, uckia, unmettle, vorticellid)

    def to_dict(self):
        result = {}
        result["Batidaceae"] = from_none(self.batidaceae)
        result["Brechites"] = from_none(self.brechites)
        result["codespairer"] = from_none(self.codespairer)
        result["Emery"] = from_none(self.emery)
        result["enervative"] = from_none(self.enervative)
        result["excriminate"] = from_none(self.excriminate)
        result["goshenite"] = from_none(self.goshenite)
        result["grime"] = from_none(self.grime)
        result["gritten"] = from_none(self.gritten)
        result["hectorly"] = from_none(self.hectorly)
        result["intermediation"] = from_none(self.intermediation)
        result["meeterly"] = from_none(self.meeterly)
        result["Narraganset"] = from_none(self.narraganset)
        result["onymatic"] = from_none(self.onymatic)
        result["paddlecock"] = from_none(self.paddlecock)
        result["thana"] = from_none(self.thana)
        result["thornily"] = from_none(self.thornily)
        result["uckia"] = from_none(self.uckia)
        result["unmettle"] = from_none(self.unmettle)
        result["vorticellid"] = from_none(self.vorticellid)
        return result


class DiscordiaClass:
    def __init__(self, altaic, amoristic, blennophthalmia, catharticalness, chirotherium, disciplinability, disdiapason, goofer, homocerc, laryngograph, leucitis, lymphocyst, microcosmology, nauseation, nonbookish, patarin, preliberal, prettifier, rangework, redient, subfusiform, suicidical, swow, wastrel, wingle):
        self.altaic = altaic
        self.amoristic = amoristic
        self.blennophthalmia = blennophthalmia
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.disciplinability = disciplinability
        self.disdiapason = disdiapason
        self.goofer = goofer
        self.homocerc = homocerc
        self.laryngograph = laryngograph
        self.leucitis = leucitis
        self.lymphocyst = lymphocyst
        self.microcosmology = microcosmology
        self.nauseation = nauseation
        self.nonbookish = nonbookish
        self.patarin = patarin
        self.preliberal = preliberal
        self.prettifier = prettifier
        self.rangework = rangework
        self.redient = redient
        self.subfusiform = subfusiform
        self.suicidical = suicidical
        self.swow = swow
        self.wastrel = wastrel
        self.wingle = wingle

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        altaic = from_union([from_int, from_none], obj.get("Altaic"))
        amoristic = from_union([from_int, from_none], obj.get("amoristic"))
        blennophthalmia = from_union([from_int, from_none], obj.get("blennophthalmia"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
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
        patarin = from_union([from_int, from_none], obj.get("Patarin"))
        preliberal = from_union([from_int, from_none], obj.get("preliberal"))
        prettifier = from_union([from_int, from_none], obj.get("prettifier"))
        rangework = from_union([from_int, from_none], obj.get("rangework"))
        redient = from_union([from_int, from_none], obj.get("redient"))
        subfusiform = from_union([from_int, from_none], obj.get("subfusiform"))
        suicidical = from_union([from_int, from_none], obj.get("suicidical"))
        swow = from_union([from_int, from_none], obj.get("swow"))
        wastrel = from_union([from_int, from_none], obj.get("wastrel"))
        wingle = from_union([from_int, from_none], obj.get("wingle"))
        return DiscordiaClass(altaic, amoristic, blennophthalmia, catharticalness, chirotherium, disciplinability, disdiapason, goofer, homocerc, laryngograph, leucitis, lymphocyst, microcosmology, nauseation, nonbookish, patarin, preliberal, prettifier, rangework, redient, subfusiform, suicidical, swow, wastrel, wingle)

    def to_dict(self):
        result = {}
        if self.altaic is not None:
            result["Altaic"] = from_union([from_int, from_none], self.altaic)
        if self.amoristic is not None:
            result["amoristic"] = from_union([from_int, from_none], self.amoristic)
        if self.blennophthalmia is not None:
            result["blennophthalmia"] = from_union([from_int, from_none], self.blennophthalmia)
        if self.catharticalness is not None:
            result["catharticalness"] = from_union([to_float, from_none], self.catharticalness)
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.patarin is not None:
            result["Patarin"] = from_union([from_int, from_none], self.patarin)
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


class GryphosaurusClass:
    def __init__(self, amissibility, burushaski, citronin, coplaintiff, disquisitionary, enoplan, faintness, hebetomy, islandry, lameduck, overbattle, overinterested, phrenologic, rainband, shiningly, stamineous, subscapularis, tahami, undaubed, underntime):
        self.amissibility = amissibility
        self.burushaski = burushaski
        self.citronin = citronin
        self.coplaintiff = coplaintiff
        self.disquisitionary = disquisitionary
        self.enoplan = enoplan
        self.faintness = faintness
        self.hebetomy = hebetomy
        self.islandry = islandry
        self.lameduck = lameduck
        self.overbattle = overbattle
        self.overinterested = overinterested
        self.phrenologic = phrenologic
        self.rainband = rainband
        self.shiningly = shiningly
        self.stamineous = stamineous
        self.subscapularis = subscapularis
        self.tahami = tahami
        self.undaubed = undaubed
        self.underntime = underntime

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        amissibility = from_none(obj["amissibility"])
        burushaski = from_none(obj["Burushaski"])
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
        tahami = from_none(obj["Tahami"])
        undaubed = from_none(obj["undaubed"])
        underntime = from_none(obj["underntime"])
        return GryphosaurusClass(amissibility, burushaski, citronin, coplaintiff, disquisitionary, enoplan, faintness, hebetomy, islandry, lameduck, overbattle, overinterested, phrenologic, rainband, shiningly, stamineous, subscapularis, tahami, undaubed, underntime)

    def to_dict(self):
        result = {}
        result["amissibility"] = from_none(self.amissibility)
        result["Burushaski"] = from_none(self.burushaski)
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
        result["Tahami"] = from_none(self.tahami)
        result["undaubed"] = from_none(self.undaubed)
        result["underntime"] = from_none(self.underntime)
        return result


class LaviniaClass:
    def __init__(self, agitable, asininity, benefiter, bronzelike, catharticalness, chirotherium, cholesteatomatous, deprivement, disdiapason, flippantness, fogproof, homocerc, merrymeeting, nonbookish, overcareful, panaris, preacceptance, quinoxaline, sig, superconfusion, tacana, tillotter, tranquillize, unquestionable, uproute):
        self.agitable = agitable
        self.asininity = asininity
        self.benefiter = benefiter
        self.bronzelike = bronzelike
        self.catharticalness = catharticalness
        self.chirotherium = chirotherium
        self.cholesteatomatous = cholesteatomatous
        self.deprivement = deprivement
        self.disdiapason = disdiapason
        self.flippantness = flippantness
        self.fogproof = fogproof
        self.homocerc = homocerc
        self.merrymeeting = merrymeeting
        self.nonbookish = nonbookish
        self.overcareful = overcareful
        self.panaris = panaris
        self.preacceptance = preacceptance
        self.quinoxaline = quinoxaline
        self.sig = sig
        self.superconfusion = superconfusion
        self.tacana = tacana
        self.tillotter = tillotter
        self.tranquillize = tranquillize
        self.unquestionable = unquestionable
        self.uproute = uproute

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        agitable = from_union([from_int, from_none], obj.get("agitable"))
        asininity = from_union([from_int, from_none], obj.get("asininity"))
        benefiter = from_union([from_int, from_none], obj.get("benefiter"))
        bronzelike = from_union([from_int, from_none], obj.get("bronzelike"))
        catharticalness = from_union([from_float, from_none], obj.get("catharticalness"))
        chirotherium = from_union([from_int, from_none], obj.get("Chirotherium"))
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
        tacana = from_union([from_int, from_none], obj.get("Tacana"))
        tillotter = from_union([from_int, from_none], obj.get("tillotter"))
        tranquillize = from_union([from_int, from_none], obj.get("tranquillize"))
        unquestionable = from_union([from_int, from_none], obj.get("unquestionable"))
        uproute = from_union([from_int, from_none], obj.get("uproute"))
        return LaviniaClass(agitable, asininity, benefiter, bronzelike, catharticalness, chirotherium, cholesteatomatous, deprivement, disdiapason, flippantness, fogproof, homocerc, merrymeeting, nonbookish, overcareful, panaris, preacceptance, quinoxaline, sig, superconfusion, tacana, tillotter, tranquillize, unquestionable, uproute)

    def to_dict(self):
        result = {}
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
        if self.chirotherium is not None:
            result["Chirotherium"] = from_union([from_int, from_none], self.chirotherium)
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
        if self.tacana is not None:
            result["Tacana"] = from_union([from_int, from_none], self.tacana)
        if self.tillotter is not None:
            result["tillotter"] = from_union([from_int, from_none], self.tillotter)
        if self.tranquillize is not None:
            result["tranquillize"] = from_union([from_int, from_none], self.tranquillize)
        if self.unquestionable is not None:
            result["unquestionable"] = from_union([from_int, from_none], self.unquestionable)
        if self.uproute is not None:
            result["uproute"] = from_union([from_int, from_none], self.uproute)
        return result


class OskarClass:
    def __init__(self, acrobates, beanshooter, bearhound, cayuga, guarneri, hypochondriacism, indication, jaculative, nagana, netherlandish, noctivagous, nonphysiological, praxis, provision, subterhuman, sunlit, syncraniate, teachment, unmutinous, unstoppable):
        self.acrobates = acrobates
        self.beanshooter = beanshooter
        self.bearhound = bearhound
        self.cayuga = cayuga
        self.guarneri = guarneri
        self.hypochondriacism = hypochondriacism
        self.indication = indication
        self.jaculative = jaculative
        self.nagana = nagana
        self.netherlandish = netherlandish
        self.noctivagous = noctivagous
        self.nonphysiological = nonphysiological
        self.praxis = praxis
        self.provision = provision
        self.subterhuman = subterhuman
        self.sunlit = sunlit
        self.syncraniate = syncraniate
        self.teachment = teachment
        self.unmutinous = unmutinous
        self.unstoppable = unstoppable

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        acrobates = from_none(obj["Acrobates"])
        beanshooter = from_none(obj["beanshooter"])
        bearhound = from_none(obj["bearhound"])
        cayuga = from_none(obj["Cayuga"])
        guarneri = from_none(obj["guarneri"])
        hypochondriacism = from_none(obj["hypochondriacism"])
        indication = from_none(obj["indication"])
        jaculative = from_none(obj["jaculative"])
        nagana = from_none(obj["nagana"])
        netherlandish = from_none(obj["Netherlandish"])
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
        return OskarClass(acrobates, beanshooter, bearhound, cayuga, guarneri, hypochondriacism, indication, jaculative, nagana, netherlandish, noctivagous, nonphysiological, praxis, provision, subterhuman, sunlit, syncraniate, teachment, unmutinous, unstoppable)

    def to_dict(self):
        result = {}
        result["Acrobates"] = from_none(self.acrobates)
        result["beanshooter"] = from_none(self.beanshooter)
        result["bearhound"] = from_none(self.bearhound)
        result["Cayuga"] = from_none(self.cayuga)
        result["guarneri"] = from_none(self.guarneri)
        result["hypochondriacism"] = from_none(self.hypochondriacism)
        result["indication"] = from_none(self.indication)
        result["jaculative"] = from_none(self.jaculative)
        result["nagana"] = from_none(self.nagana)
        result["Netherlandish"] = from_none(self.netherlandish)
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


class TopLevel:
    def __init__(self, abranchiata, academe, acquirable, aerometry, alexin, alleviate, amaas, ambassage, amphithyron, andriana, ankee, annihilator, annulose, ansarie, aphasia, asprawl, attractive, barksome, bedesman, belard, bocking, brawlingly, brookie, bumboatman, bystreet, calaverite, catallactic, cemental, chytridiaceae, discordia, endomyces, epinephelidae, eupatorium, gryphosaurus, koryak, lavinia, oskar, rebecca, rhomboganoidei, rigsmal, ruellia, school, shakespearolater, svan, wayao):
        self.abranchiata = abranchiata
        self.academe = academe
        self.acquirable = acquirable
        self.aerometry = aerometry
        self.alexin = alexin
        self.alleviate = alleviate
        self.amaas = amaas
        self.ambassage = ambassage
        self.amphithyron = amphithyron
        self.andriana = andriana
        self.ankee = ankee
        self.annihilator = annihilator
        self.annulose = annulose
        self.ansarie = ansarie
        self.aphasia = aphasia
        self.asprawl = asprawl
        self.attractive = attractive
        self.barksome = barksome
        self.bedesman = bedesman
        self.belard = belard
        self.bocking = bocking
        self.brawlingly = brawlingly
        self.brookie = brookie
        self.bumboatman = bumboatman
        self.bystreet = bystreet
        self.calaverite = calaverite
        self.catallactic = catallactic
        self.cemental = cemental
        self.chytridiaceae = chytridiaceae
        self.discordia = discordia
        self.endomyces = endomyces
        self.epinephelidae = epinephelidae
        self.eupatorium = eupatorium
        self.gryphosaurus = gryphosaurus
        self.koryak = koryak
        self.lavinia = lavinia
        self.oskar = oskar
        self.rebecca = rebecca
        self.rhomboganoidei = rhomboganoidei
        self.rigsmal = rigsmal
        self.ruellia = ruellia
        self.school = school
        self.shakespearolater = shakespearolater
        self.svan = svan
        self.wayao = wayao

    @staticmethod
    def from_dict(obj):
        assert isinstance(obj, dict)
        abranchiata = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_none], x), obj["Abranchiata"])
        academe = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, lambda x: from_dict(from_int, x)], x), obj["academe"])
        acquirable = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: from_dict(from_int, x)], x), obj["acquirable"])
        aerometry = from_list(lambda x: from_union([from_bool, from_float], x), obj["aerometry"])
        alexin = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool], x), obj["alexin"])
        alleviate = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), AlleviateClass.from_dict], x), obj["alleviate"])
        amaas = from_list(lambda x: from_union([from_bool, Rebecca.from_dict, from_int], x), obj["amaas"])
        ambassage = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_str], x), obj["ambassage"])
        amphithyron = from_list(lambda x: from_union([Amphithyron.from_dict, from_none], x), obj["amphithyron"])
        andriana = from_list(lambda x: from_union([from_none, from_str], x), obj["Andriana"])
        ankee = from_list(lambda x: from_union([lambda x: from_list(from_int, x), AnkeeClass.from_dict, from_int], x), obj["ankee"])
        annihilator = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_none], x), obj["annihilator"])
        annulose = from_none(obj["annulose"])
        ansarie = from_list(lambda x: from_union([lambda x: from_list(from_int, x), AnsarieClass.from_dict, from_none], x), obj["Ansarie"])
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
        return TopLevel(abranchiata, academe, acquirable, aerometry, alexin, alleviate, amaas, ambassage, amphithyron, andriana, ankee, annihilator, annulose, ansarie, aphasia, asprawl, attractive, barksome, bedesman, belard, bocking, brawlingly, brookie, bumboatman, bystreet, calaverite, catallactic, cemental, chytridiaceae, discordia, endomyces, epinephelidae, eupatorium, gryphosaurus, koryak, lavinia, oskar, rebecca, rhomboganoidei, rigsmal, ruellia, school, shakespearolater, svan, wayao)

    def to_dict(self):
        result = {}
        result["Abranchiata"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, from_none], x), self.abranchiata)
        result["academe"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_int, lambda x: from_dict(from_int, x)], x), self.academe)
        result["acquirable"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: from_dict(from_int, x)], x), self.acquirable)
        result["aerometry"] = from_list(lambda x: from_union([from_bool, to_float], x), self.aerometry)
        result["alexin"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), from_bool], x), self.alexin)
        result["alleviate"] = from_list(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_int, from_none], x), x), lambda x: to_class(AlleviateClass, x)], x), self.alleviate)
        result["amaas"] = from_list(lambda x: from_union([from_bool, lambda x: to_class(Rebecca, x), from_int], x), self.amaas)
        result["ambassage"] = from_list(lambda x: from_union([lambda x: from_list(from_none, x), from_str], x), self.ambassage)
        result["amphithyron"] = from_list(lambda x: from_union([lambda x: to_class(Amphithyron, x), from_none], x), self.amphithyron)
        result["Andriana"] = from_list(lambda x: from_union([from_none, from_str], x), self.andriana)
        result["ankee"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(AnkeeClass, x), from_int], x), self.ankee)
        result["annihilator"] = from_list(lambda x: from_union([lambda x: from_dict(lambda x: from_union([from_int, from_none], x), x), from_none], x), self.annihilator)
        result["annulose"] = from_none(self.annulose)
        result["Ansarie"] = from_list(lambda x: from_union([lambda x: from_list(from_int, x), lambda x: to_class(AnsarieClass, x), from_none], x), self.ansarie)
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
        return result


def top_level_from_dict(s):
    return TopLevel.from_dict(s)


def top_level_to_dict(x):
    return to_class(TopLevel, x)
