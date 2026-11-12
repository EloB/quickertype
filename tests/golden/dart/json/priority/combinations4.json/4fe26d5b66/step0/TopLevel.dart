// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromMap(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toMap());

class TopLevel {
    final List<dynamic> protrusive;
    final List<dynamic> pulpitism;
    final List<dynamic> pyodermia;
    final List<dynamic> quebrachine;
    final List<dynamic> querier;
    final List<dynamic> rebarbative;
    final List<Reimagine> reimagine;
    final Ressaut ressaut;
    final List<dynamic> retrocervical;
    final List<dynamic> revert;
    final List<dynamic> rewrite;
    final List<dynamic> saccoderm;
    final List<dynamic> santir;
    final List<dynamic> saprophilous;
    final List<dynamic> saxten;
    final List<Scatty?> scatty;
    final List<dynamic> scoffer;
    final List<dynamic> scrampum;
    final double semantic;
    final List<dynamic> serpentinic;
    final List<dynamic> shadowable;
    final List<dynamic> sistering;
    final List<Staghunting> staghunting;
    final List<dynamic> stagmometer;
    final List<dynamic> stimulability;
    final List<dynamic> strangleable;
    final List<dynamic> strenuosity;
    final List<dynamic> tabaxir;
    final List<dynamic> talpiform;
    final List<dynamic> thwack;
    final List<double?> to;
    final List<dynamic> tortricine;
    final List<dynamic> truantcy;
    final List<String> turgesce;
    final List<dynamic> unbeginning;
    final List<double> underdunged;
    final List<dynamic> undesirability;
    final List<dynamic> unerasing;
    final List<dynamic> unguentarium;
    final List<dynamic> unimpeachably;
    final List<dynamic> unmortgaged;
    final List<dynamic> unobstructed;
    final List<dynamic> unreceptivity;
    final List<dynamic> unsatisfactoriness;
    final List<int> unsecurity;
    final List<dynamic> unstressed;
    final List<dynamic> untasked;
    final List<dynamic> unvarying;
    final List<dynamic> vehemently;
    final Map<String, bool> warriorship;
    final List<dynamic> whitepot;
    final List<dynamic> wrothy;

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

    factory TopLevel.fromMap(Map<String, dynamic> json) => TopLevel(
        protrusive: List<dynamic>.from(json["protrusive"].map((x) => x)),
        pulpitism: List<dynamic>.from(json["pulpitism"].map((x) => x)),
        pyodermia: List<dynamic>.from(json["pyodermia"].map((x) => x)),
        quebrachine: List<dynamic>.from(json["quebrachine"].map((x) => x)),
        querier: List<dynamic>.from(json["querier"].map((x) => x)),
        rebarbative: List<dynamic>.from(json["rebarbative"].map((x) => x)),
        reimagine: List<Reimagine>.from(json["reimagine"].map((x) => Reimagine.fromMap(x))),
        ressaut: Ressaut.fromMap(json["ressaut"]),
        retrocervical: List<dynamic>.from(json["retrocervical"].map((x) => x)),
        revert: List<dynamic>.from(json["revert"].map((x) => x)),
        rewrite: List<dynamic>.from(json["rewrite"].map((x) => x)),
        saccoderm: List<dynamic>.from(json["saccoderm"].map((x) => x)),
        santir: List<dynamic>.from(json["santir"].map((x) => x)),
        saprophilous: List<dynamic>.from(json["saprophilous"].map((x) => x)),
        saxten: List<dynamic>.from(json["saxten"].map((x) => x)),
        scatty: List<Scatty?>.from(json["scatty"].map((x) => x == null ? null : Scatty.fromMap(x))),
        scoffer: List<dynamic>.from(json["scoffer"].map((x) => x)),
        scrampum: List<dynamic>.from(json["scrampum"].map((x) => x)),
        semantic: json["semantic"]?.toDouble(),
        serpentinic: List<dynamic>.from(json["serpentinic"].map((x) => x)),
        shadowable: List<dynamic>.from(json["shadowable"].map((x) => x)),
        sistering: List<dynamic>.from(json["sistering"].map((x) => x)),
        staghunting: List<Staghunting>.from(json["staghunting"].map((x) => Staghunting.fromMap(x))),
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

    Map<String, dynamic> toMap() => {
        "protrusive": List<dynamic>.from(protrusive.map((x) => x)),
        "pulpitism": List<dynamic>.from(pulpitism.map((x) => x)),
        "pyodermia": List<dynamic>.from(pyodermia.map((x) => x)),
        "quebrachine": List<dynamic>.from(quebrachine.map((x) => x)),
        "querier": List<dynamic>.from(querier.map((x) => x)),
        "rebarbative": List<dynamic>.from(rebarbative.map((x) => x)),
        "reimagine": List<dynamic>.from(reimagine.map((x) => x.toMap())),
        "ressaut": ressaut.toMap(),
        "retrocervical": List<dynamic>.from(retrocervical.map((x) => x)),
        "revert": List<dynamic>.from(revert.map((x) => x)),
        "rewrite": List<dynamic>.from(rewrite.map((x) => x)),
        "saccoderm": List<dynamic>.from(saccoderm.map((x) => x)),
        "santir": List<dynamic>.from(santir.map((x) => x)),
        "saprophilous": List<dynamic>.from(saprophilous.map((x) => x)),
        "saxten": List<dynamic>.from(saxten.map((x) => x)),
        "scatty": List<dynamic>.from(scatty.map((x) => x?.toMap())),
        "scoffer": List<dynamic>.from(scoffer.map((x) => x)),
        "scrampum": List<dynamic>.from(scrampum.map((x) => x)),
        "semantic": semantic,
        "serpentinic": List<dynamic>.from(serpentinic.map((x) => x)),
        "shadowable": List<dynamic>.from(shadowable.map((x) => x)),
        "sistering": List<dynamic>.from(sistering.map((x) => x)),
        "staghunting": List<dynamic>.from(staghunting.map((x) => x.toMap())),
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
    final dynamic abnet;
    final dynamic buckhorn;
    final dynamic calciform;
    final dynamic chelophore;
    final dynamic cogitation;
    final dynamic decreeable;
    final dynamic despicable;
    final dynamic isodiazo;
    final dynamic jadedly;
    final dynamic leptochlorite;
    final dynamic nursling;
    final dynamic palamedean;
    final dynamic photoheliograph;
    final dynamic pipewood;
    final dynamic roberd;
    final dynamic statable;
    final dynamic superassume;
    final dynamic syllabe;
    final dynamic toughhead;
    final dynamic underburn;

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

    factory PulpitismClass.fromMap(Map<String, dynamic> json) => PulpitismClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic aphoristically;
    final dynamic apophyllous;
    final dynamic cognize;
    final dynamic dermonosology;
    final dynamic gyppo;
    final dynamic ither;
    final dynamic juglandaceous;
    final dynamic litho;
    final dynamic macropterous;
    final dynamic photographer;
    final dynamic romancing;
    final dynamic rumness;
    final dynamic somniloquist;
    final dynamic stressfully;
    final dynamic tactically;
    final dynamic tracheophony;
    final dynamic unappositely;
    final dynamic unclothedly;
    final dynamic unimplied;
    final dynamic unsyncopated;

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

    factory PyodermiaClass.fromMap(Map<String, dynamic> json) => PyodermiaClass(
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

    Map<String, dynamic> toMap() => {
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
    final double catharticalness;
    final int chirotherium;
    final String disdiapason;
    final bool homocerc;
    final dynamic nonbookish;

    QuebrachineClass({
        required this.catharticalness,
        required this.chirotherium,
        required this.disdiapason,
        required this.homocerc,
        required this.nonbookish,
    });

    factory QuebrachineClass.fromMap(Map<String, dynamic> json) => QuebrachineClass(
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disdiapason: json["disdiapason"],
        homocerc: json["homocerc"],
        nonbookish: (json.containsKey("nonbookish") ? json["nonbookish"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toMap() => {
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disdiapason": disdiapason,
        "homocerc": homocerc,
        "nonbookish": nonbookish,
    };
}

class Reimagine {
    final dynamic adducible;
    final dynamic anabolin;
    final dynamic brainy;
    final double? catharticalness;
    final int? chirotherium;
    final dynamic chrysamine;
    final String? disdiapason;
    final dynamic fluxweed;
    final dynamic glaucine;
    final dynamic grobianism;
    final dynamic hermo;
    final dynamic hieroglyphist;
    final bool? homocerc;
    final dynamic icteroid;
    final dynamic immortal;
    final dynamic impetulant;
    final dynamic irrigate;
    final dynamic myxedema;
    final dynamic nonbookish;
    final dynamic onyx;
    final dynamic repasser;
    final dynamic septomarginal;
    final dynamic subdie;
    final dynamic tibiometatarsal;
    final dynamic waltzlike;

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

    factory Reimagine.fromMap(Map<String, dynamic> json) => Reimagine(
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

    Map<String, dynamic> toMap() => {
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
    final String apperceptive;
    final String cuttoo;
    final String douser;
    final String drinkproof;
    final String forementioned;
    final String freesia;
    final String genevieve;
    final String hyperdiabolical;
    final String hypocone;
    final String irreverentially;
    final String jumart;
    final String mimosaceae;
    final String mollicrush;
    final String nedder;
    final String retinasphalt;
    final String sough;
    final String steading;
    final String theopaschitism;
    final String undurableness;
    final String unmingleable;

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

    factory Ressaut.fromMap(Map<String, dynamic> json) => Ressaut(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic accountancy;
    final dynamic cacotrophic;
    final dynamic contest;
    final dynamic couthily;
    final dynamic falculate;
    final dynamic foreseize;
    final dynamic hyades;
    final dynamic lemnad;
    final dynamic monotheistically;
    final dynamic nonflying;
    final dynamic ptenoglossa;
    final dynamic repatch;
    final dynamic rodman;
    final dynamic strung;
    final dynamic titmal;
    final dynamic twalpennyworth;
    final dynamic unblamable;
    final dynamic vertical;
    final dynamic whiggification;
    final dynamic yardman;

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

    factory RewriteClass.fromMap(Map<String, dynamic> json) => RewriteClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic admiredly;
    final dynamic demicaponier;
    final dynamic epitympanic;
    final dynamic investitor;
    final dynamic lupiform;
    final dynamic monoflagellate;
    final dynamic paleoethnic;
    final dynamic prediscountable;
    final dynamic rhetoricals;
    final dynamic roomth;
    final dynamic saccharose;
    final dynamic septonasal;
    final dynamic serpenticide;
    final dynamic setarious;
    final dynamic spaework;
    final dynamic stylite;
    final dynamic suessiones;
    final dynamic timelily;
    final dynamic unprofaned;
    final dynamic vorticular;

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

    factory SantirClass.fromMap(Map<String, dynamic> json) => SantirClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic algarrobilla;
    final dynamic bowgrace;
    final double? catharticalness;
    final dynamic centaurid;
    final int? chirotherium;
    final String? disdiapason;
    final dynamic flix;
    final dynamic germanely;
    final bool? homocerc;
    final dynamic inhume;
    final dynamic lepidote;
    final dynamic megalochirous;
    final dynamic ninepenny;
    final dynamic nonbookish;
    final dynamic nondeist;
    final dynamic nymphaeaceous;
    final dynamic parietofrontal;
    final dynamic sancyite;
    final dynamic subjectivist;
    final dynamic tibiad;
    final dynamic transonic;
    final dynamic tripetalous;
    final dynamic trunchman;
    final dynamic urger;
    final dynamic withdrawnness;

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

    factory SaxtenClass.fromMap(Map<String, dynamic> json) => SaxtenClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic aeriferous;
    final dynamic antical;
    final dynamic antighostism;
    final dynamic arcanum;
    final dynamic autotrophy;
    final dynamic baronial;
    final dynamic caffeine;
    final dynamic gorgoniacean;
    final dynamic heroical;
    final dynamic hydropical;
    final dynamic mechanology;
    final dynamic musicopoetic;
    final dynamic officiality;
    final dynamic oftentimes;
    final dynamic ophthalmotonometer;
    final dynamic reflectively;
    final dynamic springer;
    final dynamic tabasco;
    final dynamic teleianthous;
    final dynamic uncombated;

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

    factory Scatty.fromMap(Map<String, dynamic> json) => Scatty(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic amphicarpic;
    final dynamic chianti;
    final dynamic frigorific;
    final dynamic haplomi;
    final dynamic hyperkinesis;
    final dynamic laudable;
    final dynamic madwoman;
    final dynamic maimedly;
    final dynamic micropterygidae;
    final dynamic microrhabdus;
    final dynamic nondense;
    final dynamic phlebemphraxis;
    final dynamic redsear;
    final dynamic schismatical;
    final dynamic tartryl;
    final dynamic unabhorred;
    final dynamic undeliberateness;
    final dynamic unmixable;
    final dynamic untruckling;
    final dynamic vineal;

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

    factory SisteringClass.fromMap(Map<String, dynamic> json) => SisteringClass(
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

    Map<String, dynamic> toMap() => {
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
    final int? calorimetric;
    final int? canid;
    final double? catharticalness;
    final int? chirotherium;
    final String? disdiapason;
    final int? ditriglyphic;
    final int? floriferousness;
    final int? gamelike;
    final int? grig;
    final bool? homocerc;
    final int? interloan;
    final int? lithotomy;
    final int? loric;
    final int? membranocoriaceous;
    final int? membranogenic;
    final dynamic nonbookish;
    final int? overtrump;
    final int? scotino;
    final int? seasonable;
    final int? sephen;
    final int? stigmarioid;
    final int? tired;
    final int? trifid;
    final int? undefeatedly;
    final int? ungirlish;

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

    factory Staghunting.fromMap(Map<String, dynamic> json) => Staghunting(
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

    Map<String, dynamic> toMap() => {
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
    final int? bliss;
    final int? buccate;
    final int? bulletproof;
    final double? catharticalness;
    final int? chirotherium;
    final int? crumblingness;
    final String? disdiapason;
    final int? engagedly;
    final int? fightable;
    final int? hoariness;
    final bool? homocerc;
    final int? hypopodium;
    final int? luxurist;
    final int? mechanician;
    final dynamic nonbookish;
    final int? onopordon;
    final int? podgily;
    final int? reformableness;
    final int? scatterbrains;
    final int? seminuria;
    final int? sodomite;
    final int? tramp;
    final int? undueness;
    final int? worthily;
    final int? yankeeist;

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

    factory StrenuosityClass.fromMap(Map<String, dynamic> json) => StrenuosityClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic alfiona;
    final dynamic ascaridiasis;
    final dynamic bungey;
    final double? catharticalness;
    final dynamic ceroxyle;
    final int? chirotherium;
    final dynamic chorology;
    final String? disdiapason;
    final dynamic enmarble;
    final dynamic epeira;
    final dynamic eurylaimi;
    final dynamic germination;
    final dynamic hallelujah;
    final bool? homocerc;
    final dynamic lev;
    final dynamic mouthing;
    final dynamic nonbookish;
    final dynamic philliloo;
    final dynamic planetal;
    final dynamic poney;
    final dynamic punctualist;
    final dynamic returnlessly;
    final dynamic skelder;
    final dynamic windwaywardly;
    final dynamic yuman;

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

    factory TruantcyClass.fromMap(Map<String, dynamic> json) => TruantcyClass(
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

    Map<String, dynamic> toMap() => {
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
    final int? acerin;
    final int? bobadil;
    final double? catharticalness;
    final int? chirotherium;
    final int? chlorophylligenous;
    final int? conversational;
    final int? demiowl;
    final String? disdiapason;
    final int? ectorhinal;
    final int? gamblesomeness;
    final bool? homocerc;
    final int? irrorate;
    final int? kindergartening;
    final int? lateritic;
    final int? mespil;
    final int? misconfiguration;
    final dynamic nonbookish;
    final int? planometry;
    final int? quiina;
    final int? robert;
    final int? rot;
    final int? subcinctorium;
    final int? tussocker;
    final int? ultraproud;
    final int? unsuggestedness;

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

    factory UnimpeachablyClass.fromMap(Map<String, dynamic> json) => UnimpeachablyClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic alain;
    final dynamic amphirhina;
    final dynamic antimachinery;
    final dynamic coldish;
    final dynamic crantara;
    final dynamic distinguishing;
    final dynamic elytroposis;
    final dynamic gentianwort;
    final dynamic heliosis;
    final dynamic instrumental;
    final dynamic introinflection;
    final dynamic kala;
    final dynamic lincolnian;
    final dynamic metad;
    final dynamic sarcophilus;
    final dynamic swingingly;
    final dynamic unconformity;
    final dynamic undecreed;
    final dynamic venerable;
    final dynamic vowellessness;

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

    factory UnstressedClass.fromMap(Map<String, dynamic> json) => UnstressedClass(
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

    Map<String, dynamic> toMap() => {
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
    final dynamic aeschynanthus;
    final dynamic aquiferous;
    final dynamic cheapener;
    final dynamic enumeration;
    final dynamic ephesine;
    final dynamic escadrille;
    final dynamic estrous;
    final dynamic interestedly;
    final dynamic katakinetomer;
    final dynamic mortification;
    final dynamic morula;
    final dynamic orthosymmetrical;
    final dynamic overbark;
    final dynamic politist;
    final dynamic qualified;
    final dynamic sphenomalar;
    final dynamic throatful;
    final dynamic transhumance;
    final dynamic triandrian;
    final dynamic unbooked;

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

    factory WrothyClass.fromMap(Map<String, dynamic> json) => WrothyClass(
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

    Map<String, dynamic> toMap() => {
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
