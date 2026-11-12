// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String centrodesmose;
    final List<dynamic> cerograph;
    final List<dynamic> chemotherapeutics;
    final List<dynamic> cimelia;
    final int citrated;
    final List<dynamic> clinodome;
    final List<dynamic> coadjust;
    final List<dynamic> consilience;
    final List<dynamic> constructor;
    final List<dynamic> continuative;
    final List<dynamic> credulity;
    final List<dynamic> creviced;
    final List<List<int?>> cubiculum;
    final List<dynamic> deruralize;
    final List<dynamic> diaereses;
    final List<List<dynamic>?> dissolution;
    final List<dynamic> downstroke;
    final List<double?> electrotautomerism;
    final List<dynamic> eleutheromania;
    final Encrust encrust;
    final List<dynamic> entomoid;
    final List<dynamic> epipaleolithic;
    final List<dynamic> expropriable;
    final List<dynamic> faggingly;
    final List<dynamic> fenks;
    final List<dynamic> flagmaking;
    final List<dynamic> fluorometer;
    final List<int?> fulsome;
    final List<dynamic> fuzzy;
    final List<dynamic> gardenwards;
    final List<dynamic> generalissimo;
    final List<Map<String, int>?> habeas;
    final List<dynamic> hemicrystalline;
    final List<dynamic> hemocoele;
    final List<dynamic> hoister;
    final List<dynamic> hyperpiesis;
    final List<dynamic> hyppish;
    final List<dynamic> idealizer;
    final List<dynamic> incrustator;
    final List<dynamic> intentiveness;
    final Interacinar interacinar;
    final List<List<int>?> intercorrelation;
    final List<dynamic> jacutinga;

    TopLevel({
        required this.centrodesmose,
        required this.cerograph,
        required this.chemotherapeutics,
        required this.cimelia,
        required this.citrated,
        required this.clinodome,
        required this.coadjust,
        required this.consilience,
        required this.constructor,
        required this.continuative,
        required this.credulity,
        required this.creviced,
        required this.cubiculum,
        required this.deruralize,
        required this.diaereses,
        required this.dissolution,
        required this.downstroke,
        required this.electrotautomerism,
        required this.eleutheromania,
        required this.encrust,
        required this.entomoid,
        required this.epipaleolithic,
        required this.expropriable,
        required this.faggingly,
        required this.fenks,
        required this.flagmaking,
        required this.fluorometer,
        required this.fulsome,
        required this.fuzzy,
        required this.gardenwards,
        required this.generalissimo,
        required this.habeas,
        required this.hemicrystalline,
        required this.hemocoele,
        required this.hoister,
        required this.hyperpiesis,
        required this.hyppish,
        required this.idealizer,
        required this.incrustator,
        required this.intentiveness,
        required this.interacinar,
        required this.intercorrelation,
        required this.jacutinga,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        centrodesmose: json["centrodesmose"],
        cerograph: List<dynamic>.from(json["cerograph"].map((x) => x)),
        chemotherapeutics: List<dynamic>.from(json["chemotherapeutics"].map((x) => x)),
        cimelia: List<dynamic>.from(json["cimelia"].map((x) => x)),
        citrated: json["citrated"],
        clinodome: List<dynamic>.from(json["clinodome"].map((x) => x)),
        coadjust: List<dynamic>.from(json["coadjust"].map((x) => x)),
        consilience: List<dynamic>.from(json["consilience"].map((x) => x)),
        constructor: List<dynamic>.from(json["constructor"].map((x) => x)),
        continuative: List<dynamic>.from(json["continuative"].map((x) => x)),
        credulity: List<dynamic>.from(json["credulity"].map((x) => x)),
        creviced: List<dynamic>.from(json["creviced"].map((x) => x)),
        cubiculum: List<List<int?>>.from(json["cubiculum"].map((x) => List<int?>.from(x.map((x) => x)))),
        deruralize: List<dynamic>.from(json["deruralize"].map((x) => x)),
        diaereses: List<dynamic>.from(json["diaereses"].map((x) => x)),
        dissolution: List<List<dynamic>?>.from(json["dissolution"].map((x) => x == null ? null : List<dynamic>.from(x!.map((x) => x)))),
        downstroke: List<dynamic>.from(json["downstroke"].map((x) => x)),
        electrotautomerism: List<double?>.from(json["electrotautomerism"].map((x) => x?.toDouble())),
        eleutheromania: List<dynamic>.from(json["eleutheromania"].map((x) => x)),
        encrust: Encrust.fromJson(json["encrust"]),
        entomoid: List<dynamic>.from(json["entomoid"].map((x) => x)),
        epipaleolithic: List<dynamic>.from(json["epipaleolithic"].map((x) => x)),
        expropriable: List<dynamic>.from(json["expropriable"].map((x) => x)),
        faggingly: List<dynamic>.from(json["faggingly"].map((x) => x)),
        fenks: List<dynamic>.from(json["fenks"].map((x) => x)),
        flagmaking: List<dynamic>.from(json["flagmaking"].map((x) => x)),
        fluorometer: List<dynamic>.from(json["fluorometer"].map((x) => x)),
        fulsome: List<int?>.from(json["fulsome"].map((x) => x)),
        fuzzy: List<dynamic>.from(json["fuzzy"].map((x) => x)),
        gardenwards: List<dynamic>.from(json["gardenwards"].map((x) => x)),
        generalissimo: List<dynamic>.from(json["generalissimo"].map((x) => x)),
        habeas: List<Map<String, int>?>.from(json["habeas"].map((x) => x == null ? null : Map.from(x!).map((k, v) => MapEntry<String, int>(k, v)))),
        hemicrystalline: List<dynamic>.from(json["hemicrystalline"].map((x) => x)),
        hemocoele: List<dynamic>.from(json["hemocoele"].map((x) => x)),
        hoister: List<dynamic>.from(json["hoister"].map((x) => x)),
        hyperpiesis: List<dynamic>.from(json["hyperpiesis"].map((x) => x)),
        hyppish: List<dynamic>.from(json["hyppish"].map((x) => x)),
        idealizer: List<dynamic>.from(json["idealizer"].map((x) => x)),
        incrustator: List<dynamic>.from(json["incrustator"].map((x) => x)),
        intentiveness: List<dynamic>.from(json["intentiveness"].map((x) => x)),
        interacinar: Interacinar.fromJson(json["interacinar"]),
        intercorrelation: List<List<int>?>.from(json["intercorrelation"].map((x) => x == null ? null : List<int>.from(x!.map((x) => x)))),
        jacutinga: List<dynamic>.from(json["jacutinga"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "centrodesmose": centrodesmose,
        "cerograph": List<dynamic>.from(cerograph.map((x) => x)),
        "chemotherapeutics": List<dynamic>.from(chemotherapeutics.map((x) => x)),
        "cimelia": List<dynamic>.from(cimelia.map((x) => x)),
        "citrated": citrated,
        "clinodome": List<dynamic>.from(clinodome.map((x) => x)),
        "coadjust": List<dynamic>.from(coadjust.map((x) => x)),
        "consilience": List<dynamic>.from(consilience.map((x) => x)),
        "constructor": List<dynamic>.from(constructor.map((x) => x)),
        "continuative": List<dynamic>.from(continuative.map((x) => x)),
        "credulity": List<dynamic>.from(credulity.map((x) => x)),
        "creviced": List<dynamic>.from(creviced.map((x) => x)),
        "cubiculum": List<dynamic>.from(cubiculum.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "deruralize": List<dynamic>.from(deruralize.map((x) => x)),
        "diaereses": List<dynamic>.from(diaereses.map((x) => x)),
        "dissolution": List<dynamic>.from(dissolution.map((x) => x == null ? null : List<dynamic>.from(x!.map((x) => x)))),
        "downstroke": List<dynamic>.from(downstroke.map((x) => x)),
        "electrotautomerism": List<dynamic>.from(electrotautomerism.map((x) => x)),
        "eleutheromania": List<dynamic>.from(eleutheromania.map((x) => x)),
        "encrust": encrust.toJson(),
        "entomoid": List<dynamic>.from(entomoid.map((x) => x)),
        "epipaleolithic": List<dynamic>.from(epipaleolithic.map((x) => x)),
        "expropriable": List<dynamic>.from(expropriable.map((x) => x)),
        "faggingly": List<dynamic>.from(faggingly.map((x) => x)),
        "fenks": List<dynamic>.from(fenks.map((x) => x)),
        "flagmaking": List<dynamic>.from(flagmaking.map((x) => x)),
        "fluorometer": List<dynamic>.from(fluorometer.map((x) => x)),
        "fulsome": List<dynamic>.from(fulsome.map((x) => x)),
        "fuzzy": List<dynamic>.from(fuzzy.map((x) => x)),
        "gardenwards": List<dynamic>.from(gardenwards.map((x) => x)),
        "generalissimo": List<dynamic>.from(generalissimo.map((x) => x)),
        "habeas": List<dynamic>.from(habeas.map((x) => x == null ? null : Map.from(x!).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "hemicrystalline": List<dynamic>.from(hemicrystalline.map((x) => x)),
        "hemocoele": List<dynamic>.from(hemocoele.map((x) => x)),
        "hoister": List<dynamic>.from(hoister.map((x) => x)),
        "hyperpiesis": List<dynamic>.from(hyperpiesis.map((x) => x)),
        "hyppish": List<dynamic>.from(hyppish.map((x) => x)),
        "idealizer": List<dynamic>.from(idealizer.map((x) => x)),
        "incrustator": List<dynamic>.from(incrustator.map((x) => x)),
        "intentiveness": List<dynamic>.from(intentiveness.map((x) => x)),
        "interacinar": interacinar.toJson(),
        "intercorrelation": List<dynamic>.from(intercorrelation.map((x) => x == null ? null : List<dynamic>.from(x!.map((x) => x)))),
        "jacutinga": List<dynamic>.from(jacutinga.map((x) => x)),
    };
}

class CerographClass {
    final dynamic apotropaion;
    final dynamic casuary;
    final dynamic creaker;
    final dynamic disqualification;
    final dynamic imperatorious;
    final dynamic impermeabilize;
    final dynamic metastoma;
    final dynamic noctidiurnal;
    final dynamic nonreserve;
    final dynamic ophthalmotonometry;
    final dynamic pailful;
    final dynamic pigfish;
    final dynamic pongee;
    final dynamic prosodical;
    final dynamic scrofuloderm;
    final dynamic storekeeping;
    final dynamic therologist;
    final dynamic tolowa;
    final dynamic tradeful;
    final dynamic unriveting;

    CerographClass({
        required this.apotropaion,
        required this.casuary,
        required this.creaker,
        required this.disqualification,
        required this.imperatorious,
        required this.impermeabilize,
        required this.metastoma,
        required this.noctidiurnal,
        required this.nonreserve,
        required this.ophthalmotonometry,
        required this.pailful,
        required this.pigfish,
        required this.pongee,
        required this.prosodical,
        required this.scrofuloderm,
        required this.storekeeping,
        required this.therologist,
        required this.tolowa,
        required this.tradeful,
        required this.unriveting,
    });

    factory CerographClass.fromJson(Map<String, dynamic> json) => CerographClass(
        apotropaion: (json.containsKey("apotropaion") ? json["apotropaion"] : throw FormatException('Missing required property')),
        casuary: (json.containsKey("casuary") ? json["casuary"] : throw FormatException('Missing required property')),
        creaker: (json.containsKey("creaker") ? json["creaker"] : throw FormatException('Missing required property')),
        disqualification: (json.containsKey("disqualification") ? json["disqualification"] : throw FormatException('Missing required property')),
        imperatorious: (json.containsKey("imperatorious") ? json["imperatorious"] : throw FormatException('Missing required property')),
        impermeabilize: (json.containsKey("impermeabilize") ? json["impermeabilize"] : throw FormatException('Missing required property')),
        metastoma: (json.containsKey("metastoma") ? json["metastoma"] : throw FormatException('Missing required property')),
        noctidiurnal: (json.containsKey("noctidiurnal") ? json["noctidiurnal"] : throw FormatException('Missing required property')),
        nonreserve: (json.containsKey("nonreserve") ? json["nonreserve"] : throw FormatException('Missing required property')),
        ophthalmotonometry: (json.containsKey("ophthalmotonometry") ? json["ophthalmotonometry"] : throw FormatException('Missing required property')),
        pailful: (json.containsKey("pailful") ? json["pailful"] : throw FormatException('Missing required property')),
        pigfish: (json.containsKey("pigfish") ? json["pigfish"] : throw FormatException('Missing required property')),
        pongee: (json.containsKey("pongee") ? json["pongee"] : throw FormatException('Missing required property')),
        prosodical: (json.containsKey("prosodical") ? json["prosodical"] : throw FormatException('Missing required property')),
        scrofuloderm: (json.containsKey("scrofuloderm") ? json["scrofuloderm"] : throw FormatException('Missing required property')),
        storekeeping: (json.containsKey("storekeeping") ? json["storekeeping"] : throw FormatException('Missing required property')),
        therologist: (json.containsKey("therologist") ? json["therologist"] : throw FormatException('Missing required property')),
        tolowa: (json.containsKey("Tolowa") ? json["Tolowa"] : throw FormatException('Missing required property')),
        tradeful: (json.containsKey("tradeful") ? json["tradeful"] : throw FormatException('Missing required property')),
        unriveting: (json.containsKey("unriveting") ? json["unriveting"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "apotropaion": apotropaion,
        "casuary": casuary,
        "creaker": creaker,
        "disqualification": disqualification,
        "imperatorious": imperatorious,
        "impermeabilize": impermeabilize,
        "metastoma": metastoma,
        "noctidiurnal": noctidiurnal,
        "nonreserve": nonreserve,
        "ophthalmotonometry": ophthalmotonometry,
        "pailful": pailful,
        "pigfish": pigfish,
        "pongee": pongee,
        "prosodical": prosodical,
        "scrofuloderm": scrofuloderm,
        "storekeeping": storekeeping,
        "therologist": therologist,
        "Tolowa": tolowa,
        "tradeful": tradeful,
        "unriveting": unriveting,
    };
}

class ChemotherapeuticClass {
    final dynamic angioneurotic;
    final dynamic availment;
    final dynamic bladelet;
    final double? catharticalness;
    final dynamic caulis;
    final dynamic chalcus;
    final int? chirotherium;
    final String? disdiapason;
    final dynamic enteradenological;
    final bool? homocerc;
    final dynamic imporosity;
    final dynamic insistently;
    final dynamic intraparietal;
    final dynamic ivied;
    final dynamic maureen;
    final dynamic nonbookish;
    final dynamic nostochine;
    final dynamic nutcracker;
    final dynamic ofttimes;
    final dynamic phenocryst;
    final dynamic precoincident;
    final dynamic ramiferous;
    final dynamic stagmometer;
    final dynamic tetherball;
    final dynamic unshy;

    ChemotherapeuticClass({
        this.angioneurotic,
        this.availment,
        this.bladelet,
        this.catharticalness,
        this.caulis,
        this.chalcus,
        this.chirotherium,
        this.disdiapason,
        this.enteradenological,
        this.homocerc,
        this.imporosity,
        this.insistently,
        this.intraparietal,
        this.ivied,
        this.maureen,
        this.nonbookish,
        this.nostochine,
        this.nutcracker,
        this.ofttimes,
        this.phenocryst,
        this.precoincident,
        this.ramiferous,
        this.stagmometer,
        this.tetherball,
        this.unshy,
    });

    factory ChemotherapeuticClass.fromJson(Map<String, dynamic> json) => ChemotherapeuticClass(
        angioneurotic: json["angioneurotic"],
        availment: json["availment"],
        bladelet: json["bladelet"],
        catharticalness: json["catharticalness"]?.toDouble(),
        caulis: json["caulis"],
        chalcus: json["chalcus"],
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        enteradenological: json["enteradenological"],
        homocerc: json["homocerc"],
        imporosity: json["imporosity"],
        insistently: json["insistently"],
        intraparietal: json["intraparietal"],
        ivied: json["ivied"],
        maureen: json["Maureen"],
        nonbookish: json["nonbookish"],
        nostochine: json["nostochine"],
        nutcracker: json["nutcracker"],
        ofttimes: json["ofttimes"],
        phenocryst: json["phenocryst"],
        precoincident: json["precoincident"],
        ramiferous: json["ramiferous"],
        stagmometer: json["stagmometer"],
        tetherball: json["tetherball"],
        unshy: json["unshy"],
    );

    Map<String, dynamic> toJson() => {
        "angioneurotic": angioneurotic,
        "availment": availment,
        "bladelet": bladelet,
        "catharticalness": catharticalness,
        "caulis": caulis,
        "chalcus": chalcus,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "enteradenological": enteradenological,
        "homocerc": homocerc,
        "imporosity": imporosity,
        "insistently": insistently,
        "intraparietal": intraparietal,
        "ivied": ivied,
        "Maureen": maureen,
        "nonbookish": nonbookish,
        "nostochine": nostochine,
        "nutcracker": nutcracker,
        "ofttimes": ofttimes,
        "phenocryst": phenocryst,
        "precoincident": precoincident,
        "ramiferous": ramiferous,
        "stagmometer": stagmometer,
        "tetherball": tetherball,
        "unshy": unshy,
    };
}

class CimeliaClass {
    final double catharticalness;
    final int chirotherium;
    final String disdiapason;
    final bool homocerc;
    final dynamic nonbookish;

    CimeliaClass({
        required this.catharticalness,
        required this.chirotherium,
        required this.disdiapason,
        required this.homocerc,
        required this.nonbookish,
    });

    factory CimeliaClass.fromJson(Map<String, dynamic> json) => CimeliaClass(
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        homocerc: json["homocerc"],
        nonbookish: (json.containsKey("nonbookish") ? json["nonbookish"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "homocerc": homocerc,
        "nonbookish": nonbookish,
    };
}

class CoadjustClass {
    final dynamic amidosulphonal;
    final dynamic benny;
    final double? catharticalness;
    final int? chirotherium;
    final String? disdiapason;
    final dynamic ensnare;
    final bool? homocerc;
    final dynamic hybridizer;
    final dynamic leastwise;
    final dynamic lof;
    final dynamic monkhood;
    final dynamic netherlandish;
    final dynamic nonbookish;
    final dynamic peonism;
    final dynamic phonelescope;
    final dynamic porphyrogeniture;
    final dynamic preindemnify;
    final dynamic rosal;
    final dynamic scalenous;
    final dynamic scopine;
    final dynamic sedaceae;
    final dynamic suberinize;
    final dynamic symbiot;
    final dynamic tablefellow;
    final dynamic unchargeable;

    CoadjustClass({
        this.amidosulphonal,
        this.benny,
        this.catharticalness,
        this.chirotherium,
        this.disdiapason,
        this.ensnare,
        this.homocerc,
        this.hybridizer,
        this.leastwise,
        this.lof,
        this.monkhood,
        this.netherlandish,
        this.nonbookish,
        this.peonism,
        this.phonelescope,
        this.porphyrogeniture,
        this.preindemnify,
        this.rosal,
        this.scalenous,
        this.scopine,
        this.sedaceae,
        this.suberinize,
        this.symbiot,
        this.tablefellow,
        this.unchargeable,
    });

    factory CoadjustClass.fromJson(Map<String, dynamic> json) => CoadjustClass(
        amidosulphonal: json["amidosulphonal"],
        benny: json["Benny"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        ensnare: json["ensnare"],
        homocerc: json["homocerc"],
        hybridizer: json["hybridizer"],
        leastwise: json["leastwise"],
        lof: json["lof"],
        monkhood: json["monkhood"],
        netherlandish: json["Netherlandish"],
        nonbookish: json["nonbookish"],
        peonism: json["peonism"],
        phonelescope: json["Phonelescope"],
        porphyrogeniture: json["porphyrogeniture"],
        preindemnify: json["preindemnify"],
        rosal: json["rosal"],
        scalenous: json["scalenous"],
        scopine: json["scopine"],
        sedaceae: json["Sedaceae"],
        suberinize: json["suberinize"],
        symbiot: json["symbiot"],
        tablefellow: json["tablefellow"],
        unchargeable: json["unchargeable"],
    );

    Map<String, dynamic> toJson() => {
        "amidosulphonal": amidosulphonal,
        "Benny": benny,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "ensnare": ensnare,
        "homocerc": homocerc,
        "hybridizer": hybridizer,
        "leastwise": leastwise,
        "lof": lof,
        "monkhood": monkhood,
        "Netherlandish": netherlandish,
        "nonbookish": nonbookish,
        "peonism": peonism,
        "Phonelescope": phonelescope,
        "porphyrogeniture": porphyrogeniture,
        "preindemnify": preindemnify,
        "rosal": rosal,
        "scalenous": scalenous,
        "scopine": scopine,
        "Sedaceae": sedaceae,
        "suberinize": suberinize,
        "symbiot": symbiot,
        "tablefellow": tablefellow,
        "unchargeable": unchargeable,
    };
}

class CredulityClass {
    final dynamic ammonolytic;
    final dynamic bushmaster;
    final dynamic considering;
    final dynamic consuetudinary;
    final dynamic embarras;
    final dynamic fineness;
    final dynamic flaithship;
    final dynamic flavia;
    final dynamic gruffly;
    final dynamic hedychium;
    final dynamic leadwort;
    final dynamic overseriously;
    final dynamic parabola;
    final dynamic pectinatodenticulate;
    final dynamic popean;
    final dynamic pornocrat;
    final dynamic quadrisect;
    final dynamic seriality;
    final dynamic vamphorn;
    final dynamic wharp;

    CredulityClass({
        required this.ammonolytic,
        required this.bushmaster,
        required this.considering,
        required this.consuetudinary,
        required this.embarras,
        required this.fineness,
        required this.flaithship,
        required this.flavia,
        required this.gruffly,
        required this.hedychium,
        required this.leadwort,
        required this.overseriously,
        required this.parabola,
        required this.pectinatodenticulate,
        required this.popean,
        required this.pornocrat,
        required this.quadrisect,
        required this.seriality,
        required this.vamphorn,
        required this.wharp,
    });

    factory CredulityClass.fromJson(Map<String, dynamic> json) => CredulityClass(
        ammonolytic: (json.containsKey("ammonolytic") ? json["ammonolytic"] : throw FormatException('Missing required property')),
        bushmaster: (json.containsKey("bushmaster") ? json["bushmaster"] : throw FormatException('Missing required property')),
        considering: (json.containsKey("considering") ? json["considering"] : throw FormatException('Missing required property')),
        consuetudinary: (json.containsKey("consuetudinary") ? json["consuetudinary"] : throw FormatException('Missing required property')),
        embarras: (json.containsKey("embarras") ? json["embarras"] : throw FormatException('Missing required property')),
        fineness: (json.containsKey("fineness") ? json["fineness"] : throw FormatException('Missing required property')),
        flaithship: (json.containsKey("flaithship") ? json["flaithship"] : throw FormatException('Missing required property')),
        flavia: (json.containsKey("Flavia") ? json["Flavia"] : throw FormatException('Missing required property')),
        gruffly: (json.containsKey("gruffly") ? json["gruffly"] : throw FormatException('Missing required property')),
        hedychium: (json.containsKey("Hedychium") ? json["Hedychium"] : throw FormatException('Missing required property')),
        leadwort: (json.containsKey("leadwort") ? json["leadwort"] : throw FormatException('Missing required property')),
        overseriously: (json.containsKey("overseriously") ? json["overseriously"] : throw FormatException('Missing required property')),
        parabola: (json.containsKey("parabola") ? json["parabola"] : throw FormatException('Missing required property')),
        pectinatodenticulate: (json.containsKey("pectinatodenticulate") ? json["pectinatodenticulate"] : throw FormatException('Missing required property')),
        popean: (json.containsKey("Popean") ? json["Popean"] : throw FormatException('Missing required property')),
        pornocrat: (json.containsKey("pornocrat") ? json["pornocrat"] : throw FormatException('Missing required property')),
        quadrisect: (json.containsKey("quadrisect") ? json["quadrisect"] : throw FormatException('Missing required property')),
        seriality: (json.containsKey("seriality") ? json["seriality"] : throw FormatException('Missing required property')),
        vamphorn: (json.containsKey("vamphorn") ? json["vamphorn"] : throw FormatException('Missing required property')),
        wharp: (json.containsKey("wharp") ? json["wharp"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "ammonolytic": ammonolytic,
        "bushmaster": bushmaster,
        "considering": considering,
        "consuetudinary": consuetudinary,
        "embarras": embarras,
        "fineness": fineness,
        "flaithship": flaithship,
        "Flavia": flavia,
        "gruffly": gruffly,
        "Hedychium": hedychium,
        "leadwort": leadwort,
        "overseriously": overseriously,
        "parabola": parabola,
        "pectinatodenticulate": pectinatodenticulate,
        "Popean": popean,
        "pornocrat": pornocrat,
        "quadrisect": quadrisect,
        "seriality": seriality,
        "vamphorn": vamphorn,
        "wharp": wharp,
    };
}

class DeruralizeClass {
    final dynamic bockerel;
    final dynamic boulder;
    final dynamic churrus;
    final dynamic counterdigged;
    final dynamic dialogite;
    final dynamic digenic;
    final dynamic dunbird;
    final dynamic ergatogyne;
    final dynamic fiendful;
    final dynamic jackrod;
    final dynamic jehovistic;
    final dynamic paninean;
    final dynamic panther;
    final dynamic placentigerous;
    final dynamic romney;
    final dynamic sparm;
    final dynamic tocsin;
    final dynamic unnicked;
    final dynamic unstavable;
    final dynamic windfirm;

    DeruralizeClass({
        required this.bockerel,
        required this.boulder,
        required this.churrus,
        required this.counterdigged,
        required this.dialogite,
        required this.digenic,
        required this.dunbird,
        required this.ergatogyne,
        required this.fiendful,
        required this.jackrod,
        required this.jehovistic,
        required this.paninean,
        required this.panther,
        required this.placentigerous,
        required this.romney,
        required this.sparm,
        required this.tocsin,
        required this.unnicked,
        required this.unstavable,
        required this.windfirm,
    });

    factory DeruralizeClass.fromJson(Map<String, dynamic> json) => DeruralizeClass(
        bockerel: (json.containsKey("bockerel") ? json["bockerel"] : throw FormatException('Missing required property')),
        boulder: (json.containsKey("boulder") ? json["boulder"] : throw FormatException('Missing required property')),
        churrus: (json.containsKey("churrus") ? json["churrus"] : throw FormatException('Missing required property')),
        counterdigged: (json.containsKey("counterdigged") ? json["counterdigged"] : throw FormatException('Missing required property')),
        dialogite: (json.containsKey("dialogite") ? json["dialogite"] : throw FormatException('Missing required property')),
        digenic: (json.containsKey("digenic") ? json["digenic"] : throw FormatException('Missing required property')),
        dunbird: (json.containsKey("dunbird") ? json["dunbird"] : throw FormatException('Missing required property')),
        ergatogyne: (json.containsKey("ergatogyne") ? json["ergatogyne"] : throw FormatException('Missing required property')),
        fiendful: (json.containsKey("fiendful") ? json["fiendful"] : throw FormatException('Missing required property')),
        jackrod: (json.containsKey("jackrod") ? json["jackrod"] : throw FormatException('Missing required property')),
        jehovistic: (json.containsKey("Jehovistic") ? json["Jehovistic"] : throw FormatException('Missing required property')),
        paninean: (json.containsKey("Paninean") ? json["Paninean"] : throw FormatException('Missing required property')),
        panther: (json.containsKey("panther") ? json["panther"] : throw FormatException('Missing required property')),
        placentigerous: (json.containsKey("placentigerous") ? json["placentigerous"] : throw FormatException('Missing required property')),
        romney: (json.containsKey("Romney") ? json["Romney"] : throw FormatException('Missing required property')),
        sparm: (json.containsKey("sparm") ? json["sparm"] : throw FormatException('Missing required property')),
        tocsin: (json.containsKey("tocsin") ? json["tocsin"] : throw FormatException('Missing required property')),
        unnicked: (json.containsKey("unnicked") ? json["unnicked"] : throw FormatException('Missing required property')),
        unstavable: (json.containsKey("unstavable") ? json["unstavable"] : throw FormatException('Missing required property')),
        windfirm: (json.containsKey("windfirm") ? json["windfirm"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "bockerel": bockerel,
        "boulder": boulder,
        "churrus": churrus,
        "counterdigged": counterdigged,
        "dialogite": dialogite,
        "digenic": digenic,
        "dunbird": dunbird,
        "ergatogyne": ergatogyne,
        "fiendful": fiendful,
        "jackrod": jackrod,
        "Jehovistic": jehovistic,
        "Paninean": paninean,
        "panther": panther,
        "placentigerous": placentigerous,
        "Romney": romney,
        "sparm": sparm,
        "tocsin": tocsin,
        "unnicked": unnicked,
        "unstavable": unstavable,
        "windfirm": windfirm,
    };
}

class DiaereseClass {
    final dynamic amoreuxia;
    final dynamic ani;
    final dynamic bernicle;
    final dynamic blackwasher;
    final dynamic blowhard;
    final dynamic broma;
    final dynamic closecross;
    final dynamic congregationalism;
    final dynamic grayly;
    final dynamic historically;
    final dynamic hoast;
    final dynamic irretentive;
    final dynamic parcener;
    final dynamic pedder;
    final dynamic pseudoanatomic;
    final dynamic rhizocarpian;
    final dynamic samel;
    final dynamic silker;
    final dynamic subdentated;
    final dynamic subobscure;

    DiaereseClass({
        required this.amoreuxia,
        required this.ani,
        required this.bernicle,
        required this.blackwasher,
        required this.blowhard,
        required this.broma,
        required this.closecross,
        required this.congregationalism,
        required this.grayly,
        required this.historically,
        required this.hoast,
        required this.irretentive,
        required this.parcener,
        required this.pedder,
        required this.pseudoanatomic,
        required this.rhizocarpian,
        required this.samel,
        required this.silker,
        required this.subdentated,
        required this.subobscure,
    });

    factory DiaereseClass.fromJson(Map<String, dynamic> json) => DiaereseClass(
        amoreuxia: (json.containsKey("Amoreuxia") ? json["Amoreuxia"] : throw FormatException('Missing required property')),
        ani: (json.containsKey("ani") ? json["ani"] : throw FormatException('Missing required property')),
        bernicle: (json.containsKey("bernicle") ? json["bernicle"] : throw FormatException('Missing required property')),
        blackwasher: (json.containsKey("blackwasher") ? json["blackwasher"] : throw FormatException('Missing required property')),
        blowhard: (json.containsKey("blowhard") ? json["blowhard"] : throw FormatException('Missing required property')),
        broma: (json.containsKey("broma") ? json["broma"] : throw FormatException('Missing required property')),
        closecross: (json.containsKey("closecross") ? json["closecross"] : throw FormatException('Missing required property')),
        congregationalism: (json.containsKey("congregationalism") ? json["congregationalism"] : throw FormatException('Missing required property')),
        grayly: (json.containsKey("grayly") ? json["grayly"] : throw FormatException('Missing required property')),
        historically: (json.containsKey("historically") ? json["historically"] : throw FormatException('Missing required property')),
        hoast: (json.containsKey("hoast") ? json["hoast"] : throw FormatException('Missing required property')),
        irretentive: (json.containsKey("irretentive") ? json["irretentive"] : throw FormatException('Missing required property')),
        parcener: (json.containsKey("parcener") ? json["parcener"] : throw FormatException('Missing required property')),
        pedder: (json.containsKey("pedder") ? json["pedder"] : throw FormatException('Missing required property')),
        pseudoanatomic: (json.containsKey("pseudoanatomic") ? json["pseudoanatomic"] : throw FormatException('Missing required property')),
        rhizocarpian: (json.containsKey("rhizocarpian") ? json["rhizocarpian"] : throw FormatException('Missing required property')),
        samel: (json.containsKey("samel") ? json["samel"] : throw FormatException('Missing required property')),
        silker: (json.containsKey("silker") ? json["silker"] : throw FormatException('Missing required property')),
        subdentated: (json.containsKey("subdentated") ? json["subdentated"] : throw FormatException('Missing required property')),
        subobscure: (json.containsKey("subobscure") ? json["subobscure"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Amoreuxia": amoreuxia,
        "ani": ani,
        "bernicle": bernicle,
        "blackwasher": blackwasher,
        "blowhard": blowhard,
        "broma": broma,
        "closecross": closecross,
        "congregationalism": congregationalism,
        "grayly": grayly,
        "historically": historically,
        "hoast": hoast,
        "irretentive": irretentive,
        "parcener": parcener,
        "pedder": pedder,
        "pseudoanatomic": pseudoanatomic,
        "rhizocarpian": rhizocarpian,
        "samel": samel,
        "silker": silker,
        "subdentated": subdentated,
        "subobscure": subobscure,
    };
}

class Encrust {
    final dynamic comradely;
    final dynamic diacanthous;
    final dynamic feminineness;
    final dynamic gossamered;
    final dynamic hibernia;
    final dynamic hibiscus;
    final dynamic lepidosauria;
    final dynamic lollingly;
    final dynamic manager;
    final dynamic mechanic;
    final dynamic overminuteness;
    final dynamic papelonne;
    final dynamic plebification;
    final dynamic pugmiller;
    final dynamic recoveror;
    final dynamic spermatoblastic;
    final dynamic syllidae;
    final dynamic ungyved;
    final dynamic whirlabout;
    final dynamic woodenware;

    Encrust({
        required this.comradely,
        required this.diacanthous,
        required this.feminineness,
        required this.gossamered,
        required this.hibernia,
        required this.hibiscus,
        required this.lepidosauria,
        required this.lollingly,
        required this.manager,
        required this.mechanic,
        required this.overminuteness,
        required this.papelonne,
        required this.plebification,
        required this.pugmiller,
        required this.recoveror,
        required this.spermatoblastic,
        required this.syllidae,
        required this.ungyved,
        required this.whirlabout,
        required this.woodenware,
    });

    factory Encrust.fromJson(Map<String, dynamic> json) => Encrust(
        comradely: (json.containsKey("comradely") ? json["comradely"] : throw FormatException('Missing required property')),
        diacanthous: (json.containsKey("diacanthous") ? json["diacanthous"] : throw FormatException('Missing required property')),
        feminineness: (json.containsKey("feminineness") ? json["feminineness"] : throw FormatException('Missing required property')),
        gossamered: (json.containsKey("gossamered") ? json["gossamered"] : throw FormatException('Missing required property')),
        hibernia: (json.containsKey("Hibernia") ? json["Hibernia"] : throw FormatException('Missing required property')),
        hibiscus: (json.containsKey("Hibiscus") ? json["Hibiscus"] : throw FormatException('Missing required property')),
        lepidosauria: (json.containsKey("Lepidosauria") ? json["Lepidosauria"] : throw FormatException('Missing required property')),
        lollingly: (json.containsKey("lollingly") ? json["lollingly"] : throw FormatException('Missing required property')),
        manager: (json.containsKey("manager") ? json["manager"] : throw FormatException('Missing required property')),
        mechanic: (json.containsKey("mechanic") ? json["mechanic"] : throw FormatException('Missing required property')),
        overminuteness: (json.containsKey("overminuteness") ? json["overminuteness"] : throw FormatException('Missing required property')),
        papelonne: (json.containsKey("papelonne") ? json["papelonne"] : throw FormatException('Missing required property')),
        plebification: (json.containsKey("plebification") ? json["plebification"] : throw FormatException('Missing required property')),
        pugmiller: (json.containsKey("pugmiller") ? json["pugmiller"] : throw FormatException('Missing required property')),
        recoveror: (json.containsKey("recoveror") ? json["recoveror"] : throw FormatException('Missing required property')),
        spermatoblastic: (json.containsKey("spermatoblastic") ? json["spermatoblastic"] : throw FormatException('Missing required property')),
        syllidae: (json.containsKey("Syllidae") ? json["Syllidae"] : throw FormatException('Missing required property')),
        ungyved: (json.containsKey("ungyved") ? json["ungyved"] : throw FormatException('Missing required property')),
        whirlabout: (json.containsKey("whirlabout") ? json["whirlabout"] : throw FormatException('Missing required property')),
        woodenware: (json.containsKey("woodenware") ? json["woodenware"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "comradely": comradely,
        "diacanthous": diacanthous,
        "feminineness": feminineness,
        "gossamered": gossamered,
        "Hibernia": hibernia,
        "Hibiscus": hibiscus,
        "Lepidosauria": lepidosauria,
        "lollingly": lollingly,
        "manager": manager,
        "mechanic": mechanic,
        "overminuteness": overminuteness,
        "papelonne": papelonne,
        "plebification": plebification,
        "pugmiller": pugmiller,
        "recoveror": recoveror,
        "spermatoblastic": spermatoblastic,
        "Syllidae": syllidae,
        "ungyved": ungyved,
        "whirlabout": whirlabout,
        "woodenware": woodenware,
    };
}

class FagginglyClass {
    final dynamic abranchian;
    final dynamic aculeiform;
    final dynamic adiaphoristic;
    final dynamic adoptionism;
    final dynamic anglic;
    final dynamic antrotomy;
    final dynamic coerciveness;
    final dynamic decorist;
    final dynamic duckhood;
    final dynamic heteromeri;
    final dynamic hypochnose;
    final dynamic lochage;
    final dynamic melee;
    final dynamic nonconformitant;
    final dynamic poinsettia;
    final dynamic putatively;
    final dynamic semivolatile;
    final dynamic soleas;
    final dynamic unfastenable;
    final dynamic unmillinered;

    FagginglyClass({
        required this.abranchian,
        required this.aculeiform,
        required this.adiaphoristic,
        required this.adoptionism,
        required this.anglic,
        required this.antrotomy,
        required this.coerciveness,
        required this.decorist,
        required this.duckhood,
        required this.heteromeri,
        required this.hypochnose,
        required this.lochage,
        required this.melee,
        required this.nonconformitant,
        required this.poinsettia,
        required this.putatively,
        required this.semivolatile,
        required this.soleas,
        required this.unfastenable,
        required this.unmillinered,
    });

    factory FagginglyClass.fromJson(Map<String, dynamic> json) => FagginglyClass(
        abranchian: (json.containsKey("abranchian") ? json["abranchian"] : throw FormatException('Missing required property')),
        aculeiform: (json.containsKey("aculeiform") ? json["aculeiform"] : throw FormatException('Missing required property')),
        adiaphoristic: (json.containsKey("adiaphoristic") ? json["adiaphoristic"] : throw FormatException('Missing required property')),
        adoptionism: (json.containsKey("adoptionism") ? json["adoptionism"] : throw FormatException('Missing required property')),
        anglic: (json.containsKey("Anglic") ? json["Anglic"] : throw FormatException('Missing required property')),
        antrotomy: (json.containsKey("antrotomy") ? json["antrotomy"] : throw FormatException('Missing required property')),
        coerciveness: (json.containsKey("coerciveness") ? json["coerciveness"] : throw FormatException('Missing required property')),
        decorist: (json.containsKey("decorist") ? json["decorist"] : throw FormatException('Missing required property')),
        duckhood: (json.containsKey("duckhood") ? json["duckhood"] : throw FormatException('Missing required property')),
        heteromeri: (json.containsKey("Heteromeri") ? json["Heteromeri"] : throw FormatException('Missing required property')),
        hypochnose: (json.containsKey("hypochnose") ? json["hypochnose"] : throw FormatException('Missing required property')),
        lochage: (json.containsKey("lochage") ? json["lochage"] : throw FormatException('Missing required property')),
        melee: (json.containsKey("melee") ? json["melee"] : throw FormatException('Missing required property')),
        nonconformitant: (json.containsKey("nonconformitant") ? json["nonconformitant"] : throw FormatException('Missing required property')),
        poinsettia: (json.containsKey("Poinsettia") ? json["Poinsettia"] : throw FormatException('Missing required property')),
        putatively: (json.containsKey("putatively") ? json["putatively"] : throw FormatException('Missing required property')),
        semivolatile: (json.containsKey("semivolatile") ? json["semivolatile"] : throw FormatException('Missing required property')),
        soleas: (json.containsKey("soleas") ? json["soleas"] : throw FormatException('Missing required property')),
        unfastenable: (json.containsKey("unfastenable") ? json["unfastenable"] : throw FormatException('Missing required property')),
        unmillinered: (json.containsKey("unmillinered") ? json["unmillinered"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "abranchian": abranchian,
        "aculeiform": aculeiform,
        "adiaphoristic": adiaphoristic,
        "adoptionism": adoptionism,
        "Anglic": anglic,
        "antrotomy": antrotomy,
        "coerciveness": coerciveness,
        "decorist": decorist,
        "duckhood": duckhood,
        "Heteromeri": heteromeri,
        "hypochnose": hypochnose,
        "lochage": lochage,
        "melee": melee,
        "nonconformitant": nonconformitant,
        "Poinsettia": poinsettia,
        "putatively": putatively,
        "semivolatile": semivolatile,
        "soleas": soleas,
        "unfastenable": unfastenable,
        "unmillinered": unmillinered,
    };
}

class FenkClass {
    final dynamic apoise;
    final dynamic astronomize;
    final dynamic cockhorse;
    final dynamic copular;
    final dynamic dagomba;
    final dynamic draffy;
    final dynamic foreigner;
    final dynamic guyandot;
    final dynamic neurogliosis;
    final dynamic osmious;
    final dynamic palpitate;
    final dynamic rebukeable;
    final dynamic reinwardtia;
    final dynamic reservatory;
    final dynamic scalt;
    final dynamic scripturalize;
    final dynamic tintometer;
    final dynamic tritoness;
    final dynamic undergrade;
    final dynamic undermountain;

    FenkClass({
        required this.apoise,
        required this.astronomize,
        required this.cockhorse,
        required this.copular,
        required this.dagomba,
        required this.draffy,
        required this.foreigner,
        required this.guyandot,
        required this.neurogliosis,
        required this.osmious,
        required this.palpitate,
        required this.rebukeable,
        required this.reinwardtia,
        required this.reservatory,
        required this.scalt,
        required this.scripturalize,
        required this.tintometer,
        required this.tritoness,
        required this.undergrade,
        required this.undermountain,
    });

    factory FenkClass.fromJson(Map<String, dynamic> json) => FenkClass(
        apoise: (json.containsKey("apoise") ? json["apoise"] : throw FormatException('Missing required property')),
        astronomize: (json.containsKey("astronomize") ? json["astronomize"] : throw FormatException('Missing required property')),
        cockhorse: (json.containsKey("cockhorse") ? json["cockhorse"] : throw FormatException('Missing required property')),
        copular: (json.containsKey("copular") ? json["copular"] : throw FormatException('Missing required property')),
        dagomba: (json.containsKey("Dagomba") ? json["Dagomba"] : throw FormatException('Missing required property')),
        draffy: (json.containsKey("draffy") ? json["draffy"] : throw FormatException('Missing required property')),
        foreigner: (json.containsKey("foreigner") ? json["foreigner"] : throw FormatException('Missing required property')),
        guyandot: (json.containsKey("Guyandot") ? json["Guyandot"] : throw FormatException('Missing required property')),
        neurogliosis: (json.containsKey("neurogliosis") ? json["neurogliosis"] : throw FormatException('Missing required property')),
        osmious: (json.containsKey("osmious") ? json["osmious"] : throw FormatException('Missing required property')),
        palpitate: (json.containsKey("palpitate") ? json["palpitate"] : throw FormatException('Missing required property')),
        rebukeable: (json.containsKey("rebukeable") ? json["rebukeable"] : throw FormatException('Missing required property')),
        reinwardtia: (json.containsKey("Reinwardtia") ? json["Reinwardtia"] : throw FormatException('Missing required property')),
        reservatory: (json.containsKey("reservatory") ? json["reservatory"] : throw FormatException('Missing required property')),
        scalt: (json.containsKey("scalt") ? json["scalt"] : throw FormatException('Missing required property')),
        scripturalize: (json.containsKey("scripturalize") ? json["scripturalize"] : throw FormatException('Missing required property')),
        tintometer: (json.containsKey("tintometer") ? json["tintometer"] : throw FormatException('Missing required property')),
        tritoness: (json.containsKey("Tritoness") ? json["Tritoness"] : throw FormatException('Missing required property')),
        undergrade: (json.containsKey("undergrade") ? json["undergrade"] : throw FormatException('Missing required property')),
        undermountain: (json.containsKey("undermountain") ? json["undermountain"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "apoise": apoise,
        "astronomize": astronomize,
        "cockhorse": cockhorse,
        "copular": copular,
        "Dagomba": dagomba,
        "draffy": draffy,
        "foreigner": foreigner,
        "Guyandot": guyandot,
        "neurogliosis": neurogliosis,
        "osmious": osmious,
        "palpitate": palpitate,
        "rebukeable": rebukeable,
        "Reinwardtia": reinwardtia,
        "reservatory": reservatory,
        "scalt": scalt,
        "scripturalize": scripturalize,
        "tintometer": tintometer,
        "Tritoness": tritoness,
        "undergrade": undergrade,
        "undermountain": undermountain,
    };
}

class FlagmakingClass {
    final dynamic albarco;
    final dynamic bunodonta;
    final dynamic hornify;
    final dynamic hydrocorisae;
    final dynamic hypoglossus;
    final dynamic inexpiably;
    final dynamic ingratitude;
    final dynamic ladyfly;
    final dynamic medicament;
    final dynamic monogrammatic;
    final dynamic nobbut;
    final dynamic notacanthidae;
    final dynamic polyplacophore;
    final dynamic proexercise;
    final dynamic protoplast;
    final dynamic puzzling;
    final dynamic splanchnoskeleton;
    final dynamic unloveliness;
    final dynamic unquarantined;
    final dynamic unrenounceable;

    FlagmakingClass({
        required this.albarco,
        required this.bunodonta,
        required this.hornify,
        required this.hydrocorisae,
        required this.hypoglossus,
        required this.inexpiably,
        required this.ingratitude,
        required this.ladyfly,
        required this.medicament,
        required this.monogrammatic,
        required this.nobbut,
        required this.notacanthidae,
        required this.polyplacophore,
        required this.proexercise,
        required this.protoplast,
        required this.puzzling,
        required this.splanchnoskeleton,
        required this.unloveliness,
        required this.unquarantined,
        required this.unrenounceable,
    });

    factory FlagmakingClass.fromJson(Map<String, dynamic> json) => FlagmakingClass(
        albarco: (json.containsKey("albarco") ? json["albarco"] : throw FormatException('Missing required property')),
        bunodonta: (json.containsKey("Bunodonta") ? json["Bunodonta"] : throw FormatException('Missing required property')),
        hornify: (json.containsKey("hornify") ? json["hornify"] : throw FormatException('Missing required property')),
        hydrocorisae: (json.containsKey("Hydrocorisae") ? json["Hydrocorisae"] : throw FormatException('Missing required property')),
        hypoglossus: (json.containsKey("hypoglossus") ? json["hypoglossus"] : throw FormatException('Missing required property')),
        inexpiably: (json.containsKey("inexpiably") ? json["inexpiably"] : throw FormatException('Missing required property')),
        ingratitude: (json.containsKey("ingratitude") ? json["ingratitude"] : throw FormatException('Missing required property')),
        ladyfly: (json.containsKey("ladyfly") ? json["ladyfly"] : throw FormatException('Missing required property')),
        medicament: (json.containsKey("medicament") ? json["medicament"] : throw FormatException('Missing required property')),
        monogrammatic: (json.containsKey("monogrammatic") ? json["monogrammatic"] : throw FormatException('Missing required property')),
        nobbut: (json.containsKey("nobbut") ? json["nobbut"] : throw FormatException('Missing required property')),
        notacanthidae: (json.containsKey("Notacanthidae") ? json["Notacanthidae"] : throw FormatException('Missing required property')),
        polyplacophore: (json.containsKey("polyplacophore") ? json["polyplacophore"] : throw FormatException('Missing required property')),
        proexercise: (json.containsKey("proexercise") ? json["proexercise"] : throw FormatException('Missing required property')),
        protoplast: (json.containsKey("protoplast") ? json["protoplast"] : throw FormatException('Missing required property')),
        puzzling: (json.containsKey("puzzling") ? json["puzzling"] : throw FormatException('Missing required property')),
        splanchnoskeleton: (json.containsKey("splanchnoskeleton") ? json["splanchnoskeleton"] : throw FormatException('Missing required property')),
        unloveliness: (json.containsKey("unloveliness") ? json["unloveliness"] : throw FormatException('Missing required property')),
        unquarantined: (json.containsKey("unquarantined") ? json["unquarantined"] : throw FormatException('Missing required property')),
        unrenounceable: (json.containsKey("unrenounceable") ? json["unrenounceable"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "albarco": albarco,
        "Bunodonta": bunodonta,
        "hornify": hornify,
        "Hydrocorisae": hydrocorisae,
        "hypoglossus": hypoglossus,
        "inexpiably": inexpiably,
        "ingratitude": ingratitude,
        "ladyfly": ladyfly,
        "medicament": medicament,
        "monogrammatic": monogrammatic,
        "nobbut": nobbut,
        "Notacanthidae": notacanthidae,
        "polyplacophore": polyplacophore,
        "proexercise": proexercise,
        "protoplast": protoplast,
        "puzzling": puzzling,
        "splanchnoskeleton": splanchnoskeleton,
        "unloveliness": unloveliness,
        "unquarantined": unquarantined,
        "unrenounceable": unrenounceable,
    };
}

class HemocoeleClass {
    final dynamic acrogamy;
    final dynamic amelification;
    final dynamic autobiographic;
    final dynamic berat;
    final double? catharticalness;
    final int? chirotherium;
    final String? disdiapason;
    final dynamic disproportionably;
    final dynamic erythrite;
    final dynamic graphic;
    final dynamic hepatological;
    final bool? homocerc;
    final dynamic incommensurably;
    final dynamic misaffirm;
    final dynamic nonbookish;
    final dynamic pocketbook;
    final dynamic sclerometric;
    final dynamic stambouline;
    final dynamic stickpin;
    final dynamic tubulure;
    final dynamic undelated;
    final dynamic unsalt;
    final dynamic untutelar;
    final dynamic vagrant;
    final dynamic walt;

    HemocoeleClass({
        this.acrogamy,
        this.amelification,
        this.autobiographic,
        this.berat,
        this.catharticalness,
        this.chirotherium,
        this.disdiapason,
        this.disproportionably,
        this.erythrite,
        this.graphic,
        this.hepatological,
        this.homocerc,
        this.incommensurably,
        this.misaffirm,
        this.nonbookish,
        this.pocketbook,
        this.sclerometric,
        this.stambouline,
        this.stickpin,
        this.tubulure,
        this.undelated,
        this.unsalt,
        this.untutelar,
        this.vagrant,
        this.walt,
    });

    factory HemocoeleClass.fromJson(Map<String, dynamic> json) => HemocoeleClass(
        acrogamy: json["acrogamy"],
        amelification: json["amelification"],
        autobiographic: json["autobiographic"],
        berat: json["berat"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        disproportionably: json["disproportionably"],
        erythrite: json["erythrite"],
        graphic: json["graphic"],
        hepatological: json["hepatological"],
        homocerc: json["homocerc"],
        incommensurably: json["incommensurably"],
        misaffirm: json["misaffirm"],
        nonbookish: json["nonbookish"],
        pocketbook: json["pocketbook"],
        sclerometric: json["sclerometric"],
        stambouline: json["stambouline"],
        stickpin: json["stickpin"],
        tubulure: json["tubulure"],
        undelated: json["undelated"],
        unsalt: json["unsalt"],
        untutelar: json["untutelar"],
        vagrant: json["vagrant"],
        walt: json["Walt"],
    );

    Map<String, dynamic> toJson() => {
        "acrogamy": acrogamy,
        "amelification": amelification,
        "autobiographic": autobiographic,
        "berat": berat,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "disproportionably": disproportionably,
        "erythrite": erythrite,
        "graphic": graphic,
        "hepatological": hepatological,
        "homocerc": homocerc,
        "incommensurably": incommensurably,
        "misaffirm": misaffirm,
        "nonbookish": nonbookish,
        "pocketbook": pocketbook,
        "sclerometric": sclerometric,
        "stambouline": stambouline,
        "stickpin": stickpin,
        "tubulure": tubulure,
        "undelated": undelated,
        "unsalt": unsalt,
        "untutelar": untutelar,
        "vagrant": vagrant,
        "Walt": walt,
    };
}

class Interacinar {
    final double assapan;
    final bool benefactorship;
    final String triseriatim;
    final int tubbing;
    final dynamic untrimmed;

    Interacinar({
        required this.assapan,
        required this.benefactorship,
        required this.triseriatim,
        required this.tubbing,
        required this.untrimmed,
    });

    factory Interacinar.fromJson(Map<String, dynamic> json) => Interacinar(
        assapan: json["assapan"]?.toDouble(),
        benefactorship: json["benefactorship"],
        triseriatim: json["triseriatim"],
        tubbing: json["tubbing"],
        untrimmed: (json.containsKey("untrimmed") ? json["untrimmed"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "assapan": assapan,
        "benefactorship": benefactorship,
        "triseriatim": triseriatim,
        "tubbing": tubbing,
        "untrimmed": untrimmed,
    };
}
