// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    List<dynamic> protrusive;
    List<dynamic> pulpitism;
    List<dynamic> pyodermia;
    List<dynamic> quebrachine;
    List<dynamic> querier;
    List<dynamic> rebarbative;
    List<Reimagine> reimagine;
    Ressaut ressaut;
    List<dynamic> retrocervical;
    List<dynamic> revert;
    List<dynamic> rewrite;
    List<dynamic> saccoderm;
    List<dynamic> santir;
    List<dynamic> saprophilous;
    List<dynamic> saxten;
    List<Scatty?> scatty;
    List<dynamic> scoffer;
    List<dynamic> scrampum;
    double semantic;
    List<dynamic> serpentinic;
    List<dynamic> shadowable;
    List<dynamic> sistering;
    List<Staghunting> staghunting;
    List<dynamic> stagmometer;
    List<dynamic> stimulability;
    List<dynamic> strangleable;
    List<dynamic> strenuosity;
    List<dynamic> tabaxir;
    List<dynamic> talpiform;
    List<dynamic> thwack;
    List<double?> to;
    List<dynamic> tortricine;
    List<dynamic> truantcy;
    List<String> turgesce;
    List<dynamic> unbeginning;
    List<double> underdunged;
    List<dynamic> undesirability;
    List<dynamic> unerasing;
    List<dynamic> unguentarium;
    List<dynamic> unimpeachably;
    List<dynamic> unmortgaged;
    List<dynamic> unobstructed;
    List<dynamic> unreceptivity;
    List<dynamic> unsatisfactoriness;
    List<int> unsecurity;
    List<dynamic> unstressed;
    List<dynamic> untasked;
    List<dynamic> unvarying;
    List<dynamic> vehemently;
    Map<String, bool> warriorship;
    List<dynamic> whitepot;
    List<dynamic> wrothy;

    TopLevel({
        required this.protrusive,
        required this.pulpitism,
        required this.pyodermia,
        required this.quebrachine,
        required this.querier,
        required this.rebarbative,
        required this.reimagine,
        required this.ressaut,
        required this.retrocervical,
        required this.revert,
        required this.rewrite,
        required this.saccoderm,
        required this.santir,
        required this.saprophilous,
        required this.saxten,
        required this.scatty,
        required this.scoffer,
        required this.scrampum,
        required this.semantic,
        required this.serpentinic,
        required this.shadowable,
        required this.sistering,
        required this.staghunting,
        required this.stagmometer,
        required this.stimulability,
        required this.strangleable,
        required this.strenuosity,
        required this.tabaxir,
        required this.talpiform,
        required this.thwack,
        required this.to,
        required this.tortricine,
        required this.truantcy,
        required this.turgesce,
        required this.unbeginning,
        required this.underdunged,
        required this.undesirability,
        required this.unerasing,
        required this.unguentarium,
        required this.unimpeachably,
        required this.unmortgaged,
        required this.unobstructed,
        required this.unreceptivity,
        required this.unsatisfactoriness,
        required this.unsecurity,
        required this.unstressed,
        required this.untasked,
        required this.unvarying,
        required this.vehemently,
        required this.warriorship,
        required this.whitepot,
        required this.wrothy,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        protrusive: List<dynamic>.from(json["protrusive"].map((x) => x)),
        pulpitism: List<dynamic>.from(json["pulpitism"].map((x) => x)),
        pyodermia: List<dynamic>.from(json["pyodermia"].map((x) => x)),
        quebrachine: List<dynamic>.from(json["quebrachine"].map((x) => x)),
        querier: List<dynamic>.from(json["querier"].map((x) => x)),
        rebarbative: List<dynamic>.from(json["rebarbative"].map((x) => x)),
        reimagine: List<Reimagine>.from(json["reimagine"].map((x) => Reimagine.fromJson(x))),
        ressaut: Ressaut.fromJson(json["ressaut"]),
        retrocervical: List<dynamic>.from(json["retrocervical"].map((x) => x)),
        revert: List<dynamic>.from(json["revert"].map((x) => x)),
        rewrite: List<dynamic>.from(json["rewrite"].map((x) => x)),
        saccoderm: List<dynamic>.from(json["saccoderm"].map((x) => x)),
        santir: List<dynamic>.from(json["santir"].map((x) => x)),
        saprophilous: List<dynamic>.from(json["saprophilous"].map((x) => x)),
        saxten: List<dynamic>.from(json["saxten"].map((x) => x)),
        scatty: List<Scatty?>.from(json["scatty"].map((x) => x == null ? null : Scatty.fromJson(x))),
        scoffer: List<dynamic>.from(json["scoffer"].map((x) => x)),
        scrampum: List<dynamic>.from(json["scrampum"].map((x) => x)),
        semantic: json["semantic"]?.toDouble(),
        serpentinic: List<dynamic>.from(json["serpentinic"].map((x) => x)),
        shadowable: List<dynamic>.from(json["shadowable"].map((x) => x)),
        sistering: List<dynamic>.from(json["sistering"].map((x) => x)),
        staghunting: List<Staghunting>.from(json["staghunting"].map((x) => Staghunting.fromJson(x))),
        stagmometer: List<dynamic>.from(json["stagmometer"].map((x) => x)),
        stimulability: List<dynamic>.from(json["stimulability"].map((x) => x)),
        strangleable: List<dynamic>.from(json["strangleable"].map((x) => x)),
        strenuosity: List<dynamic>.from(json["strenuosity"].map((x) => x)),
        tabaxir: List<dynamic>.from(json["tabaxir"].map((x) => x)),
        talpiform: List<dynamic>.from(json["talpiform"].map((x) => x)),
        thwack: List<dynamic>.from(json["thwack"].map((x) => x)),
        to: List<double?>.from(json["to"].map((x) => x?.toDouble())),
        tortricine: List<dynamic>.from(json["tortricine"].map((x) => x)),
        truantcy: List<dynamic>.from(json["truantcy"].map((x) => x)),
        turgesce: List<String>.from(json["turgesce"].map((x) => x)),
        unbeginning: List<dynamic>.from(json["unbeginning"].map((x) => x)),
        underdunged: List<double>.from(json["underdunged"].map((x) => x?.toDouble())),
        undesirability: List<dynamic>.from(json["undesirability"].map((x) => x)),
        unerasing: List<dynamic>.from(json["unerasing"].map((x) => x)),
        unguentarium: List<dynamic>.from(json["unguentarium"].map((x) => x)),
        unimpeachably: List<dynamic>.from(json["unimpeachably"].map((x) => x)),
        unmortgaged: List<dynamic>.from(json["unmortgaged"].map((x) => x)),
        unobstructed: List<dynamic>.from(json["unobstructed"].map((x) => x)),
        unreceptivity: List<dynamic>.from(json["unreceptivity"].map((x) => x)),
        unsatisfactoriness: List<dynamic>.from(json["unsatisfactoriness"].map((x) => x)),
        unsecurity: List<int>.from(json["unsecurity"].map((x) => x)),
        unstressed: List<dynamic>.from(json["unstressed"].map((x) => x)),
        untasked: List<dynamic>.from(json["untasked"].map((x) => x)),
        unvarying: List<dynamic>.from(json["unvarying"].map((x) => x)),
        vehemently: List<dynamic>.from(json["vehemently"].map((x) => x)),
        warriorship: Map.from(json["warriorship"]).map((k, v) => MapEntry<String, bool>(k, v)),
        whitepot: List<dynamic>.from(json["whitepot"].map((x) => x)),
        wrothy: List<dynamic>.from(json["wrothy"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "protrusive": List<dynamic>.from(protrusive.map((x) => x)),
        "pulpitism": List<dynamic>.from(pulpitism.map((x) => x)),
        "pyodermia": List<dynamic>.from(pyodermia.map((x) => x)),
        "quebrachine": List<dynamic>.from(quebrachine.map((x) => x)),
        "querier": List<dynamic>.from(querier.map((x) => x)),
        "rebarbative": List<dynamic>.from(rebarbative.map((x) => x)),
        "reimagine": List<dynamic>.from(reimagine.map((x) => x.toJson())),
        "ressaut": ressaut.toJson(),
        "retrocervical": List<dynamic>.from(retrocervical.map((x) => x)),
        "revert": List<dynamic>.from(revert.map((x) => x)),
        "rewrite": List<dynamic>.from(rewrite.map((x) => x)),
        "saccoderm": List<dynamic>.from(saccoderm.map((x) => x)),
        "santir": List<dynamic>.from(santir.map((x) => x)),
        "saprophilous": List<dynamic>.from(saprophilous.map((x) => x)),
        "saxten": List<dynamic>.from(saxten.map((x) => x)),
        "scatty": List<dynamic>.from(scatty.map((x) => x?.toJson())),
        "scoffer": List<dynamic>.from(scoffer.map((x) => x)),
        "scrampum": List<dynamic>.from(scrampum.map((x) => x)),
        "semantic": semantic,
        "serpentinic": List<dynamic>.from(serpentinic.map((x) => x)),
        "shadowable": List<dynamic>.from(shadowable.map((x) => x)),
        "sistering": List<dynamic>.from(sistering.map((x) => x)),
        "staghunting": List<dynamic>.from(staghunting.map((x) => x.toJson())),
        "stagmometer": List<dynamic>.from(stagmometer.map((x) => x)),
        "stimulability": List<dynamic>.from(stimulability.map((x) => x)),
        "strangleable": List<dynamic>.from(strangleable.map((x) => x)),
        "strenuosity": List<dynamic>.from(strenuosity.map((x) => x)),
        "tabaxir": List<dynamic>.from(tabaxir.map((x) => x)),
        "talpiform": List<dynamic>.from(talpiform.map((x) => x)),
        "thwack": List<dynamic>.from(thwack.map((x) => x)),
        "to": List<dynamic>.from(to.map((x) => x)),
        "tortricine": List<dynamic>.from(tortricine.map((x) => x)),
        "truantcy": List<dynamic>.from(truantcy.map((x) => x)),
        "turgesce": List<dynamic>.from(turgesce.map((x) => x)),
        "unbeginning": List<dynamic>.from(unbeginning.map((x) => x)),
        "underdunged": List<dynamic>.from(underdunged.map((x) => x)),
        "undesirability": List<dynamic>.from(undesirability.map((x) => x)),
        "unerasing": List<dynamic>.from(unerasing.map((x) => x)),
        "unguentarium": List<dynamic>.from(unguentarium.map((x) => x)),
        "unimpeachably": List<dynamic>.from(unimpeachably.map((x) => x)),
        "unmortgaged": List<dynamic>.from(unmortgaged.map((x) => x)),
        "unobstructed": List<dynamic>.from(unobstructed.map((x) => x)),
        "unreceptivity": List<dynamic>.from(unreceptivity.map((x) => x)),
        "unsatisfactoriness": List<dynamic>.from(unsatisfactoriness.map((x) => x)),
        "unsecurity": List<dynamic>.from(unsecurity.map((x) => x)),
        "unstressed": List<dynamic>.from(unstressed.map((x) => x)),
        "untasked": List<dynamic>.from(untasked.map((x) => x)),
        "unvarying": List<dynamic>.from(unvarying.map((x) => x)),
        "vehemently": List<dynamic>.from(vehemently.map((x) => x)),
        "warriorship": Map.from(warriorship).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "whitepot": List<dynamic>.from(whitepot.map((x) => x)),
        "wrothy": List<dynamic>.from(wrothy.map((x) => x)),
    };
}

class PulpitismClass {
    dynamic abnet;
    dynamic buckhorn;
    dynamic calciform;
    dynamic chelophore;
    dynamic cogitation;
    dynamic decreeable;
    dynamic despicable;
    dynamic isodiazo;
    dynamic jadedly;
    dynamic leptochlorite;
    dynamic nursling;
    dynamic palamedean;
    dynamic photoheliograph;
    dynamic pipewood;
    dynamic roberd;
    dynamic statable;
    dynamic superassume;
    dynamic syllabe;
    dynamic toughhead;
    dynamic underburn;

    PulpitismClass({
        required this.abnet,
        required this.buckhorn,
        required this.calciform,
        required this.chelophore,
        required this.cogitation,
        required this.decreeable,
        required this.despicable,
        required this.isodiazo,
        required this.jadedly,
        required this.leptochlorite,
        required this.nursling,
        required this.palamedean,
        required this.photoheliograph,
        required this.pipewood,
        required this.roberd,
        required this.statable,
        required this.superassume,
        required this.syllabe,
        required this.toughhead,
        required this.underburn,
    });

    factory PulpitismClass.fromJson(Map<String, dynamic> json) => PulpitismClass(
        abnet: (json.containsKey("abnet") ? json["abnet"] : throw FormatException('Missing required property')),
        buckhorn: (json.containsKey("buckhorn") ? json["buckhorn"] : throw FormatException('Missing required property')),
        calciform: (json.containsKey("calciform") ? json["calciform"] : throw FormatException('Missing required property')),
        chelophore: (json.containsKey("chelophore") ? json["chelophore"] : throw FormatException('Missing required property')),
        cogitation: (json.containsKey("cogitation") ? json["cogitation"] : throw FormatException('Missing required property')),
        decreeable: (json.containsKey("decreeable") ? json["decreeable"] : throw FormatException('Missing required property')),
        despicable: (json.containsKey("despicable") ? json["despicable"] : throw FormatException('Missing required property')),
        isodiazo: (json.containsKey("isodiazo") ? json["isodiazo"] : throw FormatException('Missing required property')),
        jadedly: (json.containsKey("jadedly") ? json["jadedly"] : throw FormatException('Missing required property')),
        leptochlorite: (json.containsKey("leptochlorite") ? json["leptochlorite"] : throw FormatException('Missing required property')),
        nursling: (json.containsKey("nursling") ? json["nursling"] : throw FormatException('Missing required property')),
        palamedean: (json.containsKey("palamedean") ? json["palamedean"] : throw FormatException('Missing required property')),
        photoheliograph: (json.containsKey("photoheliograph") ? json["photoheliograph"] : throw FormatException('Missing required property')),
        pipewood: (json.containsKey("pipewood") ? json["pipewood"] : throw FormatException('Missing required property')),
        roberd: (json.containsKey("roberd") ? json["roberd"] : throw FormatException('Missing required property')),
        statable: (json.containsKey("statable") ? json["statable"] : throw FormatException('Missing required property')),
        superassume: (json.containsKey("superassume") ? json["superassume"] : throw FormatException('Missing required property')),
        syllabe: (json.containsKey("syllabe") ? json["syllabe"] : throw FormatException('Missing required property')),
        toughhead: (json.containsKey("toughhead") ? json["toughhead"] : throw FormatException('Missing required property')),
        underburn: (json.containsKey("underburn") ? json["underburn"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "abnet": abnet,
        "buckhorn": buckhorn,
        "calciform": calciform,
        "chelophore": chelophore,
        "cogitation": cogitation,
        "decreeable": decreeable,
        "despicable": despicable,
        "isodiazo": isodiazo,
        "jadedly": jadedly,
        "leptochlorite": leptochlorite,
        "nursling": nursling,
        "palamedean": palamedean,
        "photoheliograph": photoheliograph,
        "pipewood": pipewood,
        "roberd": roberd,
        "statable": statable,
        "superassume": superassume,
        "syllabe": syllabe,
        "toughhead": toughhead,
        "underburn": underburn,
    };
}

class PyodermiaClass {
    dynamic aphoristically;
    dynamic apophyllous;
    dynamic cognize;
    dynamic dermonosology;
    dynamic gyppo;
    dynamic ither;
    dynamic juglandaceous;
    dynamic litho;
    dynamic macropterous;
    dynamic photographer;
    dynamic romancing;
    dynamic rumness;
    dynamic somniloquist;
    dynamic stressfully;
    dynamic tactically;
    dynamic tracheophony;
    dynamic unappositely;
    dynamic unclothedly;
    dynamic unimplied;
    dynamic unsyncopated;

    PyodermiaClass({
        required this.aphoristically,
        required this.apophyllous,
        required this.cognize,
        required this.dermonosology,
        required this.gyppo,
        required this.ither,
        required this.juglandaceous,
        required this.litho,
        required this.macropterous,
        required this.photographer,
        required this.romancing,
        required this.rumness,
        required this.somniloquist,
        required this.stressfully,
        required this.tactically,
        required this.tracheophony,
        required this.unappositely,
        required this.unclothedly,
        required this.unimplied,
        required this.unsyncopated,
    });

    factory PyodermiaClass.fromJson(Map<String, dynamic> json) => PyodermiaClass(
        aphoristically: (json.containsKey("aphoristically") ? json["aphoristically"] : throw FormatException('Missing required property')),
        apophyllous: (json.containsKey("apophyllous") ? json["apophyllous"] : throw FormatException('Missing required property')),
        cognize: (json.containsKey("cognize") ? json["cognize"] : throw FormatException('Missing required property')),
        dermonosology: (json.containsKey("dermonosology") ? json["dermonosology"] : throw FormatException('Missing required property')),
        gyppo: (json.containsKey("Gyppo") ? json["Gyppo"] : throw FormatException('Missing required property')),
        ither: (json.containsKey("ither") ? json["ither"] : throw FormatException('Missing required property')),
        juglandaceous: (json.containsKey("juglandaceous") ? json["juglandaceous"] : throw FormatException('Missing required property')),
        litho: (json.containsKey("litho") ? json["litho"] : throw FormatException('Missing required property')),
        macropterous: (json.containsKey("macropterous") ? json["macropterous"] : throw FormatException('Missing required property')),
        photographer: (json.containsKey("photographer") ? json["photographer"] : throw FormatException('Missing required property')),
        romancing: (json.containsKey("romancing") ? json["romancing"] : throw FormatException('Missing required property')),
        rumness: (json.containsKey("rumness") ? json["rumness"] : throw FormatException('Missing required property')),
        somniloquist: (json.containsKey("somniloquist") ? json["somniloquist"] : throw FormatException('Missing required property')),
        stressfully: (json.containsKey("stressfully") ? json["stressfully"] : throw FormatException('Missing required property')),
        tactically: (json.containsKey("tactically") ? json["tactically"] : throw FormatException('Missing required property')),
        tracheophony: (json.containsKey("tracheophony") ? json["tracheophony"] : throw FormatException('Missing required property')),
        unappositely: (json.containsKey("unappositely") ? json["unappositely"] : throw FormatException('Missing required property')),
        unclothedly: (json.containsKey("unclothedly") ? json["unclothedly"] : throw FormatException('Missing required property')),
        unimplied: (json.containsKey("unimplied") ? json["unimplied"] : throw FormatException('Missing required property')),
        unsyncopated: (json.containsKey("unsyncopated") ? json["unsyncopated"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "aphoristically": aphoristically,
        "apophyllous": apophyllous,
        "cognize": cognize,
        "dermonosology": dermonosology,
        "Gyppo": gyppo,
        "ither": ither,
        "juglandaceous": juglandaceous,
        "litho": litho,
        "macropterous": macropterous,
        "photographer": photographer,
        "romancing": romancing,
        "rumness": rumness,
        "somniloquist": somniloquist,
        "stressfully": stressfully,
        "tactically": tactically,
        "tracheophony": tracheophony,
        "unappositely": unappositely,
        "unclothedly": unclothedly,
        "unimplied": unimplied,
        "unsyncopated": unsyncopated,
    };
}

class QuebrachineClass {
    double catharticalness;
    int chirotherium;
    String disdiapason;
    bool homocerc;
    dynamic nonbookish;

    QuebrachineClass({
        required this.catharticalness,
        required this.chirotherium,
        required this.disdiapason,
        required this.homocerc,
        required this.nonbookish,
    });

    factory QuebrachineClass.fromJson(Map<String, dynamic> json) => QuebrachineClass(
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

class Reimagine {
    dynamic adducible;
    dynamic anabolin;
    dynamic brainy;
    double? catharticalness;
    int? chirotherium;
    dynamic chrysamine;
    String? disdiapason;
    dynamic fluxweed;
    dynamic glaucine;
    dynamic grobianism;
    dynamic hermo;
    dynamic hieroglyphist;
    bool? homocerc;
    dynamic icteroid;
    dynamic immortal;
    dynamic impetulant;
    dynamic irrigate;
    dynamic myxedema;
    dynamic nonbookish;
    dynamic onyx;
    dynamic repasser;
    dynamic septomarginal;
    dynamic subdie;
    dynamic tibiometatarsal;
    dynamic waltzlike;

    Reimagine({
        this.adducible,
        this.anabolin,
        this.brainy,
        this.catharticalness,
        this.chirotherium,
        this.chrysamine,
        this.disdiapason,
        this.fluxweed,
        this.glaucine,
        this.grobianism,
        this.hermo,
        this.hieroglyphist,
        this.homocerc,
        this.icteroid,
        this.immortal,
        this.impetulant,
        this.irrigate,
        this.myxedema,
        this.nonbookish,
        this.onyx,
        this.repasser,
        this.septomarginal,
        this.subdie,
        this.tibiometatarsal,
        this.waltzlike,
    });

    factory Reimagine.fromJson(Map<String, dynamic> json) => Reimagine(
        adducible: json["adducible"],
        anabolin: json["anabolin"],
        brainy: json["brainy"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        chrysamine: json["chrysamine"],
        disdiapason: json["disdiapason"],
        fluxweed: json["fluxweed"],
        glaucine: json["glaucine"],
        grobianism: json["grobianism"],
        hermo: json["Hermo"],
        hieroglyphist: json["hieroglyphist"],
        homocerc: json["homocerc"],
        icteroid: json["icteroid"],
        immortal: json["immortal"],
        impetulant: json["impetulant"],
        irrigate: json["irrigate"],
        myxedema: json["myxedema"],
        nonbookish: json["nonbookish"],
        onyx: json["onyx"],
        repasser: json["repasser"],
        septomarginal: json["septomarginal"],
        subdie: json["subdie"],
        tibiometatarsal: json["tibiometatarsal"],
        waltzlike: json["waltzlike"],
    );

    Map<String, dynamic> toJson() => {
        "adducible": adducible,
        "anabolin": anabolin,
        "brainy": brainy,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "chrysamine": chrysamine,
        "disdiapason": disdiapason,
        "fluxweed": fluxweed,
        "glaucine": glaucine,
        "grobianism": grobianism,
        "Hermo": hermo,
        "hieroglyphist": hieroglyphist,
        "homocerc": homocerc,
        "icteroid": icteroid,
        "immortal": immortal,
        "impetulant": impetulant,
        "irrigate": irrigate,
        "myxedema": myxedema,
        "nonbookish": nonbookish,
        "onyx": onyx,
        "repasser": repasser,
        "septomarginal": septomarginal,
        "subdie": subdie,
        "tibiometatarsal": tibiometatarsal,
        "waltzlike": waltzlike,
    };
}

class Ressaut {
    String apperceptive;
    String cuttoo;
    String douser;
    String drinkproof;
    String forementioned;
    String freesia;
    String genevieve;
    String hyperdiabolical;
    String hypocone;
    String irreverentially;
    String jumart;
    String mimosaceae;
    String mollicrush;
    String nedder;
    String retinasphalt;
    String sough;
    String steading;
    String theopaschitism;
    String undurableness;
    String unmingleable;

    Ressaut({
        required this.apperceptive,
        required this.cuttoo,
        required this.douser,
        required this.drinkproof,
        required this.forementioned,
        required this.freesia,
        required this.genevieve,
        required this.hyperdiabolical,
        required this.hypocone,
        required this.irreverentially,
        required this.jumart,
        required this.mimosaceae,
        required this.mollicrush,
        required this.nedder,
        required this.retinasphalt,
        required this.sough,
        required this.steading,
        required this.theopaschitism,
        required this.undurableness,
        required this.unmingleable,
    });

    factory Ressaut.fromJson(Map<String, dynamic> json) => Ressaut(
        apperceptive: json["apperceptive"],
        cuttoo: json["cuttoo"],
        douser: json["douser"],
        drinkproof: json["drinkproof"],
        forementioned: json["forementioned"],
        freesia: json["Freesia"],
        genevieve: json["Genevieve"],
        hyperdiabolical: json["hyperdiabolical"],
        hypocone: json["hypocone"],
        irreverentially: json["irreverentially"],
        jumart: json["jumart"],
        mimosaceae: json["Mimosaceae"],
        mollicrush: json["mollicrush"],
        nedder: json["nedder"],
        retinasphalt: json["retinasphalt"],
        sough: json["sough"],
        steading: json["steading"],
        theopaschitism: json["Theopaschitism"],
        undurableness: json["undurableness"],
        unmingleable: json["unmingleable"],
    );

    Map<String, dynamic> toJson() => {
        "apperceptive": apperceptive,
        "cuttoo": cuttoo,
        "douser": douser,
        "drinkproof": drinkproof,
        "forementioned": forementioned,
        "Freesia": freesia,
        "Genevieve": genevieve,
        "hyperdiabolical": hyperdiabolical,
        "hypocone": hypocone,
        "irreverentially": irreverentially,
        "jumart": jumart,
        "Mimosaceae": mimosaceae,
        "mollicrush": mollicrush,
        "nedder": nedder,
        "retinasphalt": retinasphalt,
        "sough": sough,
        "steading": steading,
        "Theopaschitism": theopaschitism,
        "undurableness": undurableness,
        "unmingleable": unmingleable,
    };
}

class RewriteClass {
    dynamic accountancy;
    dynamic cacotrophic;
    dynamic contest;
    dynamic couthily;
    dynamic falculate;
    dynamic foreseize;
    dynamic hyades;
    dynamic lemnad;
    dynamic monotheistically;
    dynamic nonflying;
    dynamic ptenoglossa;
    dynamic repatch;
    dynamic rodman;
    dynamic strung;
    dynamic titmal;
    dynamic twalpennyworth;
    dynamic unblamable;
    dynamic vertical;
    dynamic whiggification;
    dynamic yardman;

    RewriteClass({
        required this.accountancy,
        required this.cacotrophic,
        required this.contest,
        required this.couthily,
        required this.falculate,
        required this.foreseize,
        required this.hyades,
        required this.lemnad,
        required this.monotheistically,
        required this.nonflying,
        required this.ptenoglossa,
        required this.repatch,
        required this.rodman,
        required this.strung,
        required this.titmal,
        required this.twalpennyworth,
        required this.unblamable,
        required this.vertical,
        required this.whiggification,
        required this.yardman,
    });

    factory RewriteClass.fromJson(Map<String, dynamic> json) => RewriteClass(
        accountancy: (json.containsKey("accountancy") ? json["accountancy"] : throw FormatException('Missing required property')),
        cacotrophic: (json.containsKey("cacotrophic") ? json["cacotrophic"] : throw FormatException('Missing required property')),
        contest: (json.containsKey("contest") ? json["contest"] : throw FormatException('Missing required property')),
        couthily: (json.containsKey("couthily") ? json["couthily"] : throw FormatException('Missing required property')),
        falculate: (json.containsKey("falculate") ? json["falculate"] : throw FormatException('Missing required property')),
        foreseize: (json.containsKey("foreseize") ? json["foreseize"] : throw FormatException('Missing required property')),
        hyades: (json.containsKey("Hyades") ? json["Hyades"] : throw FormatException('Missing required property')),
        lemnad: (json.containsKey("lemnad") ? json["lemnad"] : throw FormatException('Missing required property')),
        monotheistically: (json.containsKey("monotheistically") ? json["monotheistically"] : throw FormatException('Missing required property')),
        nonflying: (json.containsKey("nonflying") ? json["nonflying"] : throw FormatException('Missing required property')),
        ptenoglossa: (json.containsKey("Ptenoglossa") ? json["Ptenoglossa"] : throw FormatException('Missing required property')),
        repatch: (json.containsKey("repatch") ? json["repatch"] : throw FormatException('Missing required property')),
        rodman: (json.containsKey("rodman") ? json["rodman"] : throw FormatException('Missing required property')),
        strung: (json.containsKey("strung") ? json["strung"] : throw FormatException('Missing required property')),
        titmal: (json.containsKey("titmal") ? json["titmal"] : throw FormatException('Missing required property')),
        twalpennyworth: (json.containsKey("twalpennyworth") ? json["twalpennyworth"] : throw FormatException('Missing required property')),
        unblamable: (json.containsKey("unblamable") ? json["unblamable"] : throw FormatException('Missing required property')),
        vertical: (json.containsKey("vertical") ? json["vertical"] : throw FormatException('Missing required property')),
        whiggification: (json.containsKey("Whiggification") ? json["Whiggification"] : throw FormatException('Missing required property')),
        yardman: (json.containsKey("yardman") ? json["yardman"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "accountancy": accountancy,
        "cacotrophic": cacotrophic,
        "contest": contest,
        "couthily": couthily,
        "falculate": falculate,
        "foreseize": foreseize,
        "Hyades": hyades,
        "lemnad": lemnad,
        "monotheistically": monotheistically,
        "nonflying": nonflying,
        "Ptenoglossa": ptenoglossa,
        "repatch": repatch,
        "rodman": rodman,
        "strung": strung,
        "titmal": titmal,
        "twalpennyworth": twalpennyworth,
        "unblamable": unblamable,
        "vertical": vertical,
        "Whiggification": whiggification,
        "yardman": yardman,
    };
}

class SantirClass {
    dynamic admiredly;
    dynamic demicaponier;
    dynamic epitympanic;
    dynamic investitor;
    dynamic lupiform;
    dynamic monoflagellate;
    dynamic paleoethnic;
    dynamic prediscountable;
    dynamic rhetoricals;
    dynamic roomth;
    dynamic saccharose;
    dynamic septonasal;
    dynamic serpenticide;
    dynamic setarious;
    dynamic spaework;
    dynamic stylite;
    dynamic suessiones;
    dynamic timelily;
    dynamic unprofaned;
    dynamic vorticular;

    SantirClass({
        required this.admiredly,
        required this.demicaponier,
        required this.epitympanic,
        required this.investitor,
        required this.lupiform,
        required this.monoflagellate,
        required this.paleoethnic,
        required this.prediscountable,
        required this.rhetoricals,
        required this.roomth,
        required this.saccharose,
        required this.septonasal,
        required this.serpenticide,
        required this.setarious,
        required this.spaework,
        required this.stylite,
        required this.suessiones,
        required this.timelily,
        required this.unprofaned,
        required this.vorticular,
    });

    factory SantirClass.fromJson(Map<String, dynamic> json) => SantirClass(
        admiredly: (json.containsKey("admiredly") ? json["admiredly"] : throw FormatException('Missing required property')),
        demicaponier: (json.containsKey("demicaponier") ? json["demicaponier"] : throw FormatException('Missing required property')),
        epitympanic: (json.containsKey("epitympanic") ? json["epitympanic"] : throw FormatException('Missing required property')),
        investitor: (json.containsKey("investitor") ? json["investitor"] : throw FormatException('Missing required property')),
        lupiform: (json.containsKey("lupiform") ? json["lupiform"] : throw FormatException('Missing required property')),
        monoflagellate: (json.containsKey("monoflagellate") ? json["monoflagellate"] : throw FormatException('Missing required property')),
        paleoethnic: (json.containsKey("paleoethnic") ? json["paleoethnic"] : throw FormatException('Missing required property')),
        prediscountable: (json.containsKey("prediscountable") ? json["prediscountable"] : throw FormatException('Missing required property')),
        rhetoricals: (json.containsKey("rhetoricals") ? json["rhetoricals"] : throw FormatException('Missing required property')),
        roomth: (json.containsKey("roomth") ? json["roomth"] : throw FormatException('Missing required property')),
        saccharose: (json.containsKey("saccharose") ? json["saccharose"] : throw FormatException('Missing required property')),
        septonasal: (json.containsKey("septonasal") ? json["septonasal"] : throw FormatException('Missing required property')),
        serpenticide: (json.containsKey("serpenticide") ? json["serpenticide"] : throw FormatException('Missing required property')),
        setarious: (json.containsKey("setarious") ? json["setarious"] : throw FormatException('Missing required property')),
        spaework: (json.containsKey("spaework") ? json["spaework"] : throw FormatException('Missing required property')),
        stylite: (json.containsKey("stylite") ? json["stylite"] : throw FormatException('Missing required property')),
        suessiones: (json.containsKey("Suessiones") ? json["Suessiones"] : throw FormatException('Missing required property')),
        timelily: (json.containsKey("timelily") ? json["timelily"] : throw FormatException('Missing required property')),
        unprofaned: (json.containsKey("unprofaned") ? json["unprofaned"] : throw FormatException('Missing required property')),
        vorticular: (json.containsKey("vorticular") ? json["vorticular"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "admiredly": admiredly,
        "demicaponier": demicaponier,
        "epitympanic": epitympanic,
        "investitor": investitor,
        "lupiform": lupiform,
        "monoflagellate": monoflagellate,
        "paleoethnic": paleoethnic,
        "prediscountable": prediscountable,
        "rhetoricals": rhetoricals,
        "roomth": roomth,
        "saccharose": saccharose,
        "septonasal": septonasal,
        "serpenticide": serpenticide,
        "setarious": setarious,
        "spaework": spaework,
        "stylite": stylite,
        "Suessiones": suessiones,
        "timelily": timelily,
        "unprofaned": unprofaned,
        "vorticular": vorticular,
    };
}

class SaxtenClass {
    dynamic algarrobilla;
    dynamic bowgrace;
    double? catharticalness;
    dynamic centaurid;
    int? chirotherium;
    String? disdiapason;
    dynamic flix;
    dynamic germanely;
    bool? homocerc;
    dynamic inhume;
    dynamic lepidote;
    dynamic megalochirous;
    dynamic ninepenny;
    dynamic nonbookish;
    dynamic nondeist;
    dynamic nymphaeaceous;
    dynamic parietofrontal;
    dynamic sancyite;
    dynamic subjectivist;
    dynamic tibiad;
    dynamic transonic;
    dynamic tripetalous;
    dynamic trunchman;
    dynamic urger;
    dynamic withdrawnness;

    SaxtenClass({
        this.algarrobilla,
        this.bowgrace,
        this.catharticalness,
        this.centaurid,
        this.chirotherium,
        this.disdiapason,
        this.flix,
        this.germanely,
        this.homocerc,
        this.inhume,
        this.lepidote,
        this.megalochirous,
        this.ninepenny,
        this.nonbookish,
        this.nondeist,
        this.nymphaeaceous,
        this.parietofrontal,
        this.sancyite,
        this.subjectivist,
        this.tibiad,
        this.transonic,
        this.tripetalous,
        this.trunchman,
        this.urger,
        this.withdrawnness,
    });

    factory SaxtenClass.fromJson(Map<String, dynamic> json) => SaxtenClass(
        algarrobilla: json["algarrobilla"],
        bowgrace: json["bowgrace"],
        catharticalness: json["catharticalness"]?.toDouble(),
        centaurid: json["Centaurid"],
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        flix: json["flix"],
        germanely: json["germanely"],
        homocerc: json["homocerc"],
        inhume: json["inhume"],
        lepidote: json["lepidote"],
        megalochirous: json["megalochirous"],
        ninepenny: json["ninepenny"],
        nonbookish: json["nonbookish"],
        nondeist: json["nondeist"],
        nymphaeaceous: json["nymphaeaceous"],
        parietofrontal: json["parietofrontal"],
        sancyite: json["sancyite"],
        subjectivist: json["subjectivist"],
        tibiad: json["tibiad"],
        transonic: json["transonic"],
        tripetalous: json["tripetalous"],
        trunchman: json["trunchman"],
        urger: json["urger"],
        withdrawnness: json["withdrawnness"],
    );

    Map<String, dynamic> toJson() => {
        "algarrobilla": algarrobilla,
        "bowgrace": bowgrace,
        "catharticalness": catharticalness,
        "Centaurid": centaurid,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "flix": flix,
        "germanely": germanely,
        "homocerc": homocerc,
        "inhume": inhume,
        "lepidote": lepidote,
        "megalochirous": megalochirous,
        "ninepenny": ninepenny,
        "nonbookish": nonbookish,
        "nondeist": nondeist,
        "nymphaeaceous": nymphaeaceous,
        "parietofrontal": parietofrontal,
        "sancyite": sancyite,
        "subjectivist": subjectivist,
        "tibiad": tibiad,
        "transonic": transonic,
        "tripetalous": tripetalous,
        "trunchman": trunchman,
        "urger": urger,
        "withdrawnness": withdrawnness,
    };
}

class Scatty {
    dynamic aeriferous;
    dynamic antical;
    dynamic antighostism;
    dynamic arcanum;
    dynamic autotrophy;
    dynamic baronial;
    dynamic caffeine;
    dynamic gorgoniacean;
    dynamic heroical;
    dynamic hydropical;
    dynamic mechanology;
    dynamic musicopoetic;
    dynamic officiality;
    dynamic oftentimes;
    dynamic ophthalmotonometer;
    dynamic reflectively;
    dynamic springer;
    dynamic tabasco;
    dynamic teleianthous;
    dynamic uncombated;

    Scatty({
        required this.aeriferous,
        required this.antical,
        required this.antighostism,
        required this.arcanum,
        required this.autotrophy,
        required this.baronial,
        required this.caffeine,
        required this.gorgoniacean,
        required this.heroical,
        required this.hydropical,
        required this.mechanology,
        required this.musicopoetic,
        required this.officiality,
        required this.oftentimes,
        required this.ophthalmotonometer,
        required this.reflectively,
        required this.springer,
        required this.tabasco,
        required this.teleianthous,
        required this.uncombated,
    });

    factory Scatty.fromJson(Map<String, dynamic> json) => Scatty(
        aeriferous: (json.containsKey("aeriferous") ? json["aeriferous"] : throw FormatException('Missing required property')),
        antical: (json.containsKey("antical") ? json["antical"] : throw FormatException('Missing required property')),
        antighostism: (json.containsKey("antighostism") ? json["antighostism"] : throw FormatException('Missing required property')),
        arcanum: (json.containsKey("arcanum") ? json["arcanum"] : throw FormatException('Missing required property')),
        autotrophy: (json.containsKey("autotrophy") ? json["autotrophy"] : throw FormatException('Missing required property')),
        baronial: (json.containsKey("baronial") ? json["baronial"] : throw FormatException('Missing required property')),
        caffeine: (json.containsKey("caffeine") ? json["caffeine"] : throw FormatException('Missing required property')),
        gorgoniacean: (json.containsKey("gorgoniacean") ? json["gorgoniacean"] : throw FormatException('Missing required property')),
        heroical: (json.containsKey("heroical") ? json["heroical"] : throw FormatException('Missing required property')),
        hydropical: (json.containsKey("hydropical") ? json["hydropical"] : throw FormatException('Missing required property')),
        mechanology: (json.containsKey("mechanology") ? json["mechanology"] : throw FormatException('Missing required property')),
        musicopoetic: (json.containsKey("musicopoetic") ? json["musicopoetic"] : throw FormatException('Missing required property')),
        officiality: (json.containsKey("officiality") ? json["officiality"] : throw FormatException('Missing required property')),
        oftentimes: (json.containsKey("oftentimes") ? json["oftentimes"] : throw FormatException('Missing required property')),
        ophthalmotonometer: (json.containsKey("ophthalmotonometer") ? json["ophthalmotonometer"] : throw FormatException('Missing required property')),
        reflectively: (json.containsKey("reflectively") ? json["reflectively"] : throw FormatException('Missing required property')),
        springer: (json.containsKey("springer") ? json["springer"] : throw FormatException('Missing required property')),
        tabasco: (json.containsKey("Tabasco") ? json["Tabasco"] : throw FormatException('Missing required property')),
        teleianthous: (json.containsKey("teleianthous") ? json["teleianthous"] : throw FormatException('Missing required property')),
        uncombated: (json.containsKey("uncombated") ? json["uncombated"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "aeriferous": aeriferous,
        "antical": antical,
        "antighostism": antighostism,
        "arcanum": arcanum,
        "autotrophy": autotrophy,
        "baronial": baronial,
        "caffeine": caffeine,
        "gorgoniacean": gorgoniacean,
        "heroical": heroical,
        "hydropical": hydropical,
        "mechanology": mechanology,
        "musicopoetic": musicopoetic,
        "officiality": officiality,
        "oftentimes": oftentimes,
        "ophthalmotonometer": ophthalmotonometer,
        "reflectively": reflectively,
        "springer": springer,
        "Tabasco": tabasco,
        "teleianthous": teleianthous,
        "uncombated": uncombated,
    };
}

class SisteringClass {
    dynamic amphicarpic;
    dynamic chianti;
    dynamic frigorific;
    dynamic haplomi;
    dynamic hyperkinesis;
    dynamic laudable;
    dynamic madwoman;
    dynamic maimedly;
    dynamic micropterygidae;
    dynamic microrhabdus;
    dynamic nondense;
    dynamic phlebemphraxis;
    dynamic redsear;
    dynamic schismatical;
    dynamic tartryl;
    dynamic unabhorred;
    dynamic undeliberateness;
    dynamic unmixable;
    dynamic untruckling;
    dynamic vineal;

    SisteringClass({
        required this.amphicarpic,
        required this.chianti,
        required this.frigorific,
        required this.haplomi,
        required this.hyperkinesis,
        required this.laudable,
        required this.madwoman,
        required this.maimedly,
        required this.micropterygidae,
        required this.microrhabdus,
        required this.nondense,
        required this.phlebemphraxis,
        required this.redsear,
        required this.schismatical,
        required this.tartryl,
        required this.unabhorred,
        required this.undeliberateness,
        required this.unmixable,
        required this.untruckling,
        required this.vineal,
    });

    factory SisteringClass.fromJson(Map<String, dynamic> json) => SisteringClass(
        amphicarpic: (json.containsKey("amphicarpic") ? json["amphicarpic"] : throw FormatException('Missing required property')),
        chianti: (json.containsKey("Chianti") ? json["Chianti"] : throw FormatException('Missing required property')),
        frigorific: (json.containsKey("frigorific") ? json["frigorific"] : throw FormatException('Missing required property')),
        haplomi: (json.containsKey("Haplomi") ? json["Haplomi"] : throw FormatException('Missing required property')),
        hyperkinesis: (json.containsKey("hyperkinesis") ? json["hyperkinesis"] : throw FormatException('Missing required property')),
        laudable: (json.containsKey("laudable") ? json["laudable"] : throw FormatException('Missing required property')),
        madwoman: (json.containsKey("madwoman") ? json["madwoman"] : throw FormatException('Missing required property')),
        maimedly: (json.containsKey("maimedly") ? json["maimedly"] : throw FormatException('Missing required property')),
        micropterygidae: (json.containsKey("Micropterygidae") ? json["Micropterygidae"] : throw FormatException('Missing required property')),
        microrhabdus: (json.containsKey("microrhabdus") ? json["microrhabdus"] : throw FormatException('Missing required property')),
        nondense: (json.containsKey("nondense") ? json["nondense"] : throw FormatException('Missing required property')),
        phlebemphraxis: (json.containsKey("phlebemphraxis") ? json["phlebemphraxis"] : throw FormatException('Missing required property')),
        redsear: (json.containsKey("redsear") ? json["redsear"] : throw FormatException('Missing required property')),
        schismatical: (json.containsKey("schismatical") ? json["schismatical"] : throw FormatException('Missing required property')),
        tartryl: (json.containsKey("tartryl") ? json["tartryl"] : throw FormatException('Missing required property')),
        unabhorred: (json.containsKey("unabhorred") ? json["unabhorred"] : throw FormatException('Missing required property')),
        undeliberateness: (json.containsKey("undeliberateness") ? json["undeliberateness"] : throw FormatException('Missing required property')),
        unmixable: (json.containsKey("unmixable") ? json["unmixable"] : throw FormatException('Missing required property')),
        untruckling: (json.containsKey("untruckling") ? json["untruckling"] : throw FormatException('Missing required property')),
        vineal: (json.containsKey("vineal") ? json["vineal"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "amphicarpic": amphicarpic,
        "Chianti": chianti,
        "frigorific": frigorific,
        "Haplomi": haplomi,
        "hyperkinesis": hyperkinesis,
        "laudable": laudable,
        "madwoman": madwoman,
        "maimedly": maimedly,
        "Micropterygidae": micropterygidae,
        "microrhabdus": microrhabdus,
        "nondense": nondense,
        "phlebemphraxis": phlebemphraxis,
        "redsear": redsear,
        "schismatical": schismatical,
        "tartryl": tartryl,
        "unabhorred": unabhorred,
        "undeliberateness": undeliberateness,
        "unmixable": unmixable,
        "untruckling": untruckling,
        "vineal": vineal,
    };
}

class Staghunting {
    int? calorimetric;
    int? canid;
    double? catharticalness;
    int? chirotherium;
    String? disdiapason;
    int? ditriglyphic;
    int? floriferousness;
    int? gamelike;
    int? grig;
    bool? homocerc;
    int? interloan;
    int? lithotomy;
    int? loric;
    int? membranocoriaceous;
    int? membranogenic;
    dynamic nonbookish;
    int? overtrump;
    int? scotino;
    int? seasonable;
    int? sephen;
    int? stigmarioid;
    int? tired;
    int? trifid;
    int? undefeatedly;
    int? ungirlish;

    Staghunting({
        this.calorimetric,
        this.canid,
        this.catharticalness,
        this.chirotherium,
        this.disdiapason,
        this.ditriglyphic,
        this.floriferousness,
        this.gamelike,
        this.grig,
        this.homocerc,
        this.interloan,
        this.lithotomy,
        this.loric,
        this.membranocoriaceous,
        this.membranogenic,
        this.nonbookish,
        this.overtrump,
        this.scotino,
        this.seasonable,
        this.sephen,
        this.stigmarioid,
        this.tired,
        this.trifid,
        this.undefeatedly,
        this.ungirlish,
    });

    factory Staghunting.fromJson(Map<String, dynamic> json) => Staghunting(
        calorimetric: json["calorimetric"],
        canid: json["canid"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        ditriglyphic: json["ditriglyphic"],
        floriferousness: json["floriferousness"],
        gamelike: json["gamelike"],
        grig: json["grig"],
        homocerc: json["homocerc"],
        interloan: json["interloan"],
        lithotomy: json["lithotomy"],
        loric: json["loric"],
        membranocoriaceous: json["membranocoriaceous"],
        membranogenic: json["membranogenic"],
        nonbookish: json["nonbookish"],
        overtrump: json["overtrump"],
        scotino: json["scotino"],
        seasonable: json["seasonable"],
        sephen: json["sephen"],
        stigmarioid: json["stigmarioid"],
        tired: json["tired"],
        trifid: json["trifid"],
        undefeatedly: json["undefeatedly"],
        ungirlish: json["ungirlish"],
    );

    Map<String, dynamic> toJson() => {
        "calorimetric": calorimetric,
        "canid": canid,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "ditriglyphic": ditriglyphic,
        "floriferousness": floriferousness,
        "gamelike": gamelike,
        "grig": grig,
        "homocerc": homocerc,
        "interloan": interloan,
        "lithotomy": lithotomy,
        "loric": loric,
        "membranocoriaceous": membranocoriaceous,
        "membranogenic": membranogenic,
        "nonbookish": nonbookish,
        "overtrump": overtrump,
        "scotino": scotino,
        "seasonable": seasonable,
        "sephen": sephen,
        "stigmarioid": stigmarioid,
        "tired": tired,
        "trifid": trifid,
        "undefeatedly": undefeatedly,
        "ungirlish": ungirlish,
    };
}

class StrenuosityClass {
    int? bliss;
    int? buccate;
    int? bulletproof;
    double? catharticalness;
    int? chirotherium;
    int? crumblingness;
    String? disdiapason;
    int? engagedly;
    int? fightable;
    int? hoariness;
    bool? homocerc;
    int? hypopodium;
    int? luxurist;
    int? mechanician;
    dynamic nonbookish;
    int? onopordon;
    int? podgily;
    int? reformableness;
    int? scatterbrains;
    int? seminuria;
    int? sodomite;
    int? tramp;
    int? undueness;
    int? worthily;
    int? yankeeist;

    StrenuosityClass({
        this.bliss,
        this.buccate,
        this.bulletproof,
        this.catharticalness,
        this.chirotherium,
        this.crumblingness,
        this.disdiapason,
        this.engagedly,
        this.fightable,
        this.hoariness,
        this.homocerc,
        this.hypopodium,
        this.luxurist,
        this.mechanician,
        this.nonbookish,
        this.onopordon,
        this.podgily,
        this.reformableness,
        this.scatterbrains,
        this.seminuria,
        this.sodomite,
        this.tramp,
        this.undueness,
        this.worthily,
        this.yankeeist,
    });

    factory StrenuosityClass.fromJson(Map<String, dynamic> json) => StrenuosityClass(
        bliss: json["bliss"],
        buccate: json["buccate"],
        bulletproof: json["bulletproof"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        crumblingness: json["crumblingness"],
        disdiapason: json["disdiapason"],
        engagedly: json["engagedly"],
        fightable: json["fightable"],
        hoariness: json["hoariness"],
        homocerc: json["homocerc"],
        hypopodium: json["hypopodium"],
        luxurist: json["luxurist"],
        mechanician: json["mechanician"],
        nonbookish: json["nonbookish"],
        onopordon: json["Onopordon"],
        podgily: json["podgily"],
        reformableness: json["reformableness"],
        scatterbrains: json["scatterbrains"],
        seminuria: json["seminuria"],
        sodomite: json["Sodomite"],
        tramp: json["tramp"],
        undueness: json["undueness"],
        worthily: json["worthily"],
        yankeeist: json["Yankeeist"],
    );

    Map<String, dynamic> toJson() => {
        "bliss": bliss,
        "buccate": buccate,
        "bulletproof": bulletproof,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "crumblingness": crumblingness,
        "disdiapason": disdiapason,
        "engagedly": engagedly,
        "fightable": fightable,
        "hoariness": hoariness,
        "homocerc": homocerc,
        "hypopodium": hypopodium,
        "luxurist": luxurist,
        "mechanician": mechanician,
        "nonbookish": nonbookish,
        "Onopordon": onopordon,
        "podgily": podgily,
        "reformableness": reformableness,
        "scatterbrains": scatterbrains,
        "seminuria": seminuria,
        "Sodomite": sodomite,
        "tramp": tramp,
        "undueness": undueness,
        "worthily": worthily,
        "Yankeeist": yankeeist,
    };
}

class TruantcyClass {
    dynamic alfiona;
    dynamic ascaridiasis;
    dynamic bungey;
    double? catharticalness;
    dynamic ceroxyle;
    int? chirotherium;
    dynamic chorology;
    String? disdiapason;
    dynamic enmarble;
    dynamic epeira;
    dynamic eurylaimi;
    dynamic germination;
    dynamic hallelujah;
    bool? homocerc;
    dynamic lev;
    dynamic mouthing;
    dynamic nonbookish;
    dynamic philliloo;
    dynamic planetal;
    dynamic poney;
    dynamic punctualist;
    dynamic returnlessly;
    dynamic skelder;
    dynamic windwaywardly;
    dynamic yuman;

    TruantcyClass({
        this.alfiona,
        this.ascaridiasis,
        this.bungey,
        this.catharticalness,
        this.ceroxyle,
        this.chirotherium,
        this.chorology,
        this.disdiapason,
        this.enmarble,
        this.epeira,
        this.eurylaimi,
        this.germination,
        this.hallelujah,
        this.homocerc,
        this.lev,
        this.mouthing,
        this.nonbookish,
        this.philliloo,
        this.planetal,
        this.poney,
        this.punctualist,
        this.returnlessly,
        this.skelder,
        this.windwaywardly,
        this.yuman,
    });

    factory TruantcyClass.fromJson(Map<String, dynamic> json) => TruantcyClass(
        alfiona: json["alfiona"],
        ascaridiasis: json["ascaridiasis"],
        bungey: json["bungey"],
        catharticalness: json["catharticalness"]?.toDouble(),
        ceroxyle: json["ceroxyle"],
        chirotherium: json["Chirotherium"],
        chorology: json["chorology"],
        disdiapason: json["disdiapason"],
        enmarble: json["enmarble"],
        epeira: json["Epeira"],
        eurylaimi: json["Eurylaimi"],
        germination: json["germination"],
        hallelujah: json["hallelujah"],
        homocerc: json["homocerc"],
        lev: json["lev"],
        mouthing: json["mouthing"],
        nonbookish: json["nonbookish"],
        philliloo: json["philliloo"],
        planetal: json["planetal"],
        poney: json["poney"],
        punctualist: json["punctualist"],
        returnlessly: json["returnlessly"],
        skelder: json["skelder"],
        windwaywardly: json["windwaywardly"],
        yuman: json["Yuman"],
    );

    Map<String, dynamic> toJson() => {
        "alfiona": alfiona,
        "ascaridiasis": ascaridiasis,
        "bungey": bungey,
        "catharticalness": catharticalness,
        "ceroxyle": ceroxyle,
        "Chirotherium": chirotherium,
        "chorology": chorology,
        "disdiapason": disdiapason,
        "enmarble": enmarble,
        "Epeira": epeira,
        "Eurylaimi": eurylaimi,
        "germination": germination,
        "hallelujah": hallelujah,
        "homocerc": homocerc,
        "lev": lev,
        "mouthing": mouthing,
        "nonbookish": nonbookish,
        "philliloo": philliloo,
        "planetal": planetal,
        "poney": poney,
        "punctualist": punctualist,
        "returnlessly": returnlessly,
        "skelder": skelder,
        "windwaywardly": windwaywardly,
        "Yuman": yuman,
    };
}

class UnimpeachablyClass {
    int? acerin;
    int? bobadil;
    double? catharticalness;
    int? chirotherium;
    int? chlorophylligenous;
    int? conversational;
    int? demiowl;
    String? disdiapason;
    int? ectorhinal;
    int? gamblesomeness;
    bool? homocerc;
    int? irrorate;
    int? kindergartening;
    int? lateritic;
    int? mespil;
    int? misconfiguration;
    dynamic nonbookish;
    int? planometry;
    int? quiina;
    int? robert;
    int? rot;
    int? subcinctorium;
    int? tussocker;
    int? ultraproud;
    int? unsuggestedness;

    UnimpeachablyClass({
        this.acerin,
        this.bobadil,
        this.catharticalness,
        this.chirotherium,
        this.chlorophylligenous,
        this.conversational,
        this.demiowl,
        this.disdiapason,
        this.ectorhinal,
        this.gamblesomeness,
        this.homocerc,
        this.irrorate,
        this.kindergartening,
        this.lateritic,
        this.mespil,
        this.misconfiguration,
        this.nonbookish,
        this.planometry,
        this.quiina,
        this.robert,
        this.rot,
        this.subcinctorium,
        this.tussocker,
        this.ultraproud,
        this.unsuggestedness,
    });

    factory UnimpeachablyClass.fromJson(Map<String, dynamic> json) => UnimpeachablyClass(
        acerin: json["acerin"],
        bobadil: json["Bobadil"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        chlorophylligenous: json["chlorophylligenous"],
        conversational: json["conversational"],
        demiowl: json["demiowl"],
        disdiapason: json["disdiapason"],
        ectorhinal: json["ectorhinal"],
        gamblesomeness: json["gamblesomeness"],
        homocerc: json["homocerc"],
        irrorate: json["irrorate"],
        kindergartening: json["kindergartening"],
        lateritic: json["lateritic"],
        mespil: json["mespil"],
        misconfiguration: json["misconfiguration"],
        nonbookish: json["nonbookish"],
        planometry: json["planometry"],
        quiina: json["Quiina"],
        robert: json["Robert"],
        rot: json["rot"],
        subcinctorium: json["subcinctorium"],
        tussocker: json["tussocker"],
        ultraproud: json["ultraproud"],
        unsuggestedness: json["unsuggestedness"],
    );

    Map<String, dynamic> toJson() => {
        "acerin": acerin,
        "Bobadil": bobadil,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "chlorophylligenous": chlorophylligenous,
        "conversational": conversational,
        "demiowl": demiowl,
        "disdiapason": disdiapason,
        "ectorhinal": ectorhinal,
        "gamblesomeness": gamblesomeness,
        "homocerc": homocerc,
        "irrorate": irrorate,
        "kindergartening": kindergartening,
        "lateritic": lateritic,
        "mespil": mespil,
        "misconfiguration": misconfiguration,
        "nonbookish": nonbookish,
        "planometry": planometry,
        "Quiina": quiina,
        "Robert": robert,
        "rot": rot,
        "subcinctorium": subcinctorium,
        "tussocker": tussocker,
        "ultraproud": ultraproud,
        "unsuggestedness": unsuggestedness,
    };
}

class UnstressedClass {
    dynamic alain;
    dynamic amphirhina;
    dynamic antimachinery;
    dynamic coldish;
    dynamic crantara;
    dynamic distinguishing;
    dynamic elytroposis;
    dynamic gentianwort;
    dynamic heliosis;
    dynamic instrumental;
    dynamic introinflection;
    dynamic kala;
    dynamic lincolnian;
    dynamic metad;
    dynamic sarcophilus;
    dynamic swingingly;
    dynamic unconformity;
    dynamic undecreed;
    dynamic venerable;
    dynamic vowellessness;

    UnstressedClass({
        required this.alain,
        required this.amphirhina,
        required this.antimachinery,
        required this.coldish,
        required this.crantara,
        required this.distinguishing,
        required this.elytroposis,
        required this.gentianwort,
        required this.heliosis,
        required this.instrumental,
        required this.introinflection,
        required this.kala,
        required this.lincolnian,
        required this.metad,
        required this.sarcophilus,
        required this.swingingly,
        required this.unconformity,
        required this.undecreed,
        required this.venerable,
        required this.vowellessness,
    });

    factory UnstressedClass.fromJson(Map<String, dynamic> json) => UnstressedClass(
        alain: (json.containsKey("Alain") ? json["Alain"] : throw FormatException('Missing required property')),
        amphirhina: (json.containsKey("Amphirhina") ? json["Amphirhina"] : throw FormatException('Missing required property')),
        antimachinery: (json.containsKey("antimachinery") ? json["antimachinery"] : throw FormatException('Missing required property')),
        coldish: (json.containsKey("coldish") ? json["coldish"] : throw FormatException('Missing required property')),
        crantara: (json.containsKey("crantara") ? json["crantara"] : throw FormatException('Missing required property')),
        distinguishing: (json.containsKey("distinguishing") ? json["distinguishing"] : throw FormatException('Missing required property')),
        elytroposis: (json.containsKey("elytroposis") ? json["elytroposis"] : throw FormatException('Missing required property')),
        gentianwort: (json.containsKey("gentianwort") ? json["gentianwort"] : throw FormatException('Missing required property')),
        heliosis: (json.containsKey("heliosis") ? json["heliosis"] : throw FormatException('Missing required property')),
        instrumental: (json.containsKey("instrumental") ? json["instrumental"] : throw FormatException('Missing required property')),
        introinflection: (json.containsKey("introinflection") ? json["introinflection"] : throw FormatException('Missing required property')),
        kala: (json.containsKey("kala") ? json["kala"] : throw FormatException('Missing required property')),
        lincolnian: (json.containsKey("Lincolnian") ? json["Lincolnian"] : throw FormatException('Missing required property')),
        metad: (json.containsKey("metad") ? json["metad"] : throw FormatException('Missing required property')),
        sarcophilus: (json.containsKey("Sarcophilus") ? json["Sarcophilus"] : throw FormatException('Missing required property')),
        swingingly: (json.containsKey("swingingly") ? json["swingingly"] : throw FormatException('Missing required property')),
        unconformity: (json.containsKey("unconformity") ? json["unconformity"] : throw FormatException('Missing required property')),
        undecreed: (json.containsKey("undecreed") ? json["undecreed"] : throw FormatException('Missing required property')),
        venerable: (json.containsKey("venerable") ? json["venerable"] : throw FormatException('Missing required property')),
        vowellessness: (json.containsKey("vowellessness") ? json["vowellessness"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Alain": alain,
        "Amphirhina": amphirhina,
        "antimachinery": antimachinery,
        "coldish": coldish,
        "crantara": crantara,
        "distinguishing": distinguishing,
        "elytroposis": elytroposis,
        "gentianwort": gentianwort,
        "heliosis": heliosis,
        "instrumental": instrumental,
        "introinflection": introinflection,
        "kala": kala,
        "Lincolnian": lincolnian,
        "metad": metad,
        "Sarcophilus": sarcophilus,
        "swingingly": swingingly,
        "unconformity": unconformity,
        "undecreed": undecreed,
        "venerable": venerable,
        "vowellessness": vowellessness,
    };
}

class WrothyClass {
    dynamic aeschynanthus;
    dynamic aquiferous;
    dynamic cheapener;
    dynamic enumeration;
    dynamic ephesine;
    dynamic escadrille;
    dynamic estrous;
    dynamic interestedly;
    dynamic katakinetomer;
    dynamic mortification;
    dynamic morula;
    dynamic orthosymmetrical;
    dynamic overbark;
    dynamic politist;
    dynamic qualified;
    dynamic sphenomalar;
    dynamic throatful;
    dynamic transhumance;
    dynamic triandrian;
    dynamic unbooked;

    WrothyClass({
        required this.aeschynanthus,
        required this.aquiferous,
        required this.cheapener,
        required this.enumeration,
        required this.ephesine,
        required this.escadrille,
        required this.estrous,
        required this.interestedly,
        required this.katakinetomer,
        required this.mortification,
        required this.morula,
        required this.orthosymmetrical,
        required this.overbark,
        required this.politist,
        required this.qualified,
        required this.sphenomalar,
        required this.throatful,
        required this.transhumance,
        required this.triandrian,
        required this.unbooked,
    });

    factory WrothyClass.fromJson(Map<String, dynamic> json) => WrothyClass(
        aeschynanthus: (json.containsKey("Aeschynanthus") ? json["Aeschynanthus"] : throw FormatException('Missing required property')),
        aquiferous: (json.containsKey("aquiferous") ? json["aquiferous"] : throw FormatException('Missing required property')),
        cheapener: (json.containsKey("cheapener") ? json["cheapener"] : throw FormatException('Missing required property')),
        enumeration: (json.containsKey("enumeration") ? json["enumeration"] : throw FormatException('Missing required property')),
        ephesine: (json.containsKey("Ephesine") ? json["Ephesine"] : throw FormatException('Missing required property')),
        escadrille: (json.containsKey("escadrille") ? json["escadrille"] : throw FormatException('Missing required property')),
        estrous: (json.containsKey("estrous") ? json["estrous"] : throw FormatException('Missing required property')),
        interestedly: (json.containsKey("interestedly") ? json["interestedly"] : throw FormatException('Missing required property')),
        katakinetomer: (json.containsKey("katakinetomer") ? json["katakinetomer"] : throw FormatException('Missing required property')),
        mortification: (json.containsKey("mortification") ? json["mortification"] : throw FormatException('Missing required property')),
        morula: (json.containsKey("morula") ? json["morula"] : throw FormatException('Missing required property')),
        orthosymmetrical: (json.containsKey("orthosymmetrical") ? json["orthosymmetrical"] : throw FormatException('Missing required property')),
        overbark: (json.containsKey("overbark") ? json["overbark"] : throw FormatException('Missing required property')),
        politist: (json.containsKey("politist") ? json["politist"] : throw FormatException('Missing required property')),
        qualified: (json.containsKey("qualified") ? json["qualified"] : throw FormatException('Missing required property')),
        sphenomalar: (json.containsKey("sphenomalar") ? json["sphenomalar"] : throw FormatException('Missing required property')),
        throatful: (json.containsKey("throatful") ? json["throatful"] : throw FormatException('Missing required property')),
        transhumance: (json.containsKey("transhumance") ? json["transhumance"] : throw FormatException('Missing required property')),
        triandrian: (json.containsKey("triandrian") ? json["triandrian"] : throw FormatException('Missing required property')),
        unbooked: (json.containsKey("unbooked") ? json["unbooked"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Aeschynanthus": aeschynanthus,
        "aquiferous": aquiferous,
        "cheapener": cheapener,
        "enumeration": enumeration,
        "Ephesine": ephesine,
        "escadrille": escadrille,
        "estrous": estrous,
        "interestedly": interestedly,
        "katakinetomer": katakinetomer,
        "mortification": mortification,
        "morula": morula,
        "orthosymmetrical": orthosymmetrical,
        "overbark": overbark,
        "politist": politist,
        "qualified": qualified,
        "sphenomalar": sphenomalar,
        "throatful": throatful,
        "transhumance": transhumance,
        "triandrian": triandrian,
        "unbooked": unbooked,
    };
}
