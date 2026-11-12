// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic> juror;
    final List<dynamic> kongoni;
    final List<dynamic> ladronism;
    final List<dynamic> landlubberly;
    final List<dynamic> listener;
    final List<dynamic> lupus;
    final List<Maslin> maslin;
    final List<dynamic> monazite;
    final List<dynamic> monoliteral;
    final List<dynamic> monotheistically;
    final List<dynamic> montage;
    final List<dynamic> moralness;
    final List<MonaziteClass?> mowra;
    final List<dynamic> mulishly;
    final List<dynamic> myoscope;
    final List<List<int?>?> nach;
    final List<dynamic> neuromastic;
    final List<Noncontributing> noncontributing;
    final List<dynamic> nonnervous;
    final List<dynamic> nonvaluation;
    final List<dynamic> occupationalist;
    final List<dynamic> outrival;
    final List<dynamic> paleographically;
    final List<dynamic> pamphletwise;
    final List<dynamic> pediatrics;
    final List<bool> perceptive;
    final List<dynamic> piaculum;
    final List<dynamic> piccadilly;
    final List<dynamic> piffler;
    final List<dynamic> pithful;
    final List<dynamic> placuntitis;
    final List<dynamic> plectopterous;
    final List<Pneumocele?> pneumocele;
    final List<dynamic> poliorcetic;
    final List<dynamic> poormaster;
    final List<dynamic> potwhisky;
    final List<dynamic> practicalizer;
    final List<dynamic> prefreshman;
    final List<dynamic> prehensility;
    final List<dynamic> prevoidance;
    final List<Map<String, int?>> probant;
    final List<dynamic> protext;

    TopLevel({
        required this.juror,
        required this.kongoni,
        required this.ladronism,
        required this.landlubberly,
        required this.listener,
        required this.lupus,
        required this.maslin,
        required this.monazite,
        required this.monoliteral,
        required this.monotheistically,
        required this.montage,
        required this.moralness,
        required this.mowra,
        required this.mulishly,
        required this.myoscope,
        required this.nach,
        required this.neuromastic,
        required this.noncontributing,
        required this.nonnervous,
        required this.nonvaluation,
        required this.occupationalist,
        required this.outrival,
        required this.paleographically,
        required this.pamphletwise,
        required this.pediatrics,
        required this.perceptive,
        required this.piaculum,
        required this.piccadilly,
        required this.piffler,
        required this.pithful,
        required this.placuntitis,
        required this.plectopterous,
        required this.pneumocele,
        required this.poliorcetic,
        required this.poormaster,
        required this.potwhisky,
        required this.practicalizer,
        required this.prefreshman,
        required this.prehensility,
        required this.prevoidance,
        required this.probant,
        required this.protext,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        juror: List<dynamic>.from(json["juror"].map((x) => x)),
        kongoni: List<dynamic>.from(json["kongoni"].map((x) => x)),
        ladronism: List<dynamic>.from(json["ladronism"].map((x) => x)),
        landlubberly: List<dynamic>.from(json["landlubberly"].map((x) => x)),
        listener: List<dynamic>.from(json["listener"].map((x) => x)),
        lupus: List<dynamic>.from(json["lupus"].map((x) => x)),
        maslin: List<Maslin>.from(json["maslin"].map((x) => Maslin.fromJson(x))),
        monazite: List<dynamic>.from(json["monazite"].map((x) => x)),
        monoliteral: List<dynamic>.from(json["monoliteral"].map((x) => x)),
        monotheistically: List<dynamic>.from(json["monotheistically"].map((x) => x)),
        montage: List<dynamic>.from(json["montage"].map((x) => x)),
        moralness: List<dynamic>.from(json["moralness"].map((x) => x)),
        mowra: List<MonaziteClass?>.from(json["mowra"].map((x) => x == null ? null : MonaziteClass.fromJson(x))),
        mulishly: List<dynamic>.from(json["mulishly"].map((x) => x)),
        myoscope: List<dynamic>.from(json["myoscope"].map((x) => x)),
        nach: List<List<int?>?>.from(json["nach"].map((x) => x == null ? null : List<int?>.from(x!.map((x) => x)))),
        neuromastic: List<dynamic>.from(json["neuromastic"].map((x) => x)),
        noncontributing: List<Noncontributing>.from(json["noncontributing"].map((x) => Noncontributing.fromJson(x))),
        nonnervous: List<dynamic>.from(json["nonnervous"].map((x) => x)),
        nonvaluation: List<dynamic>.from(json["nonvaluation"].map((x) => x)),
        occupationalist: List<dynamic>.from(json["occupationalist"].map((x) => x)),
        outrival: List<dynamic>.from(json["outrival"].map((x) => x)),
        paleographically: List<dynamic>.from(json["paleographically"].map((x) => x)),
        pamphletwise: List<dynamic>.from(json["pamphletwise"].map((x) => x)),
        pediatrics: List<dynamic>.from(json["pediatrics"].map((x) => x)),
        perceptive: List<bool>.from(json["perceptive"].map((x) => x)),
        piaculum: List<dynamic>.from(json["piaculum"].map((x) => x)),
        piccadilly: List<dynamic>.from(json["piccadilly"].map((x) => x)),
        piffler: List<dynamic>.from(json["piffler"].map((x) => x)),
        pithful: List<dynamic>.from(json["pithful"].map((x) => x)),
        placuntitis: List<dynamic>.from(json["placuntitis"].map((x) => x)),
        plectopterous: List<dynamic>.from(json["plectopterous"].map((x) => x)),
        pneumocele: List<Pneumocele?>.from(json["pneumocele"].map((x) => x == null ? null : Pneumocele.fromJson(x))),
        poliorcetic: List<dynamic>.from(json["poliorcetic"].map((x) => x)),
        poormaster: List<dynamic>.from(json["poormaster"].map((x) => x)),
        potwhisky: List<dynamic>.from(json["potwhisky"].map((x) => x)),
        practicalizer: List<dynamic>.from(json["practicalizer"].map((x) => x)),
        prefreshman: List<dynamic>.from(json["prefreshman"].map((x) => x)),
        prehensility: List<dynamic>.from(json["prehensility"].map((x) => x)),
        prevoidance: List<dynamic>.from(json["prevoidance"].map((x) => x)),
        probant: List<Map<String, int?>>.from(json["probant"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int?>(k, v)))),
        protext: List<dynamic>.from(json["protext"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "juror": List<dynamic>.from(juror.map((x) => x)),
        "kongoni": List<dynamic>.from(kongoni.map((x) => x)),
        "ladronism": List<dynamic>.from(ladronism.map((x) => x)),
        "landlubberly": List<dynamic>.from(landlubberly.map((x) => x)),
        "listener": List<dynamic>.from(listener.map((x) => x)),
        "lupus": List<dynamic>.from(lupus.map((x) => x)),
        "maslin": List<dynamic>.from(maslin.map((x) => x.toJson())),
        "monazite": List<dynamic>.from(monazite.map((x) => x)),
        "monoliteral": List<dynamic>.from(monoliteral.map((x) => x)),
        "monotheistically": List<dynamic>.from(monotheistically.map((x) => x)),
        "montage": List<dynamic>.from(montage.map((x) => x)),
        "moralness": List<dynamic>.from(moralness.map((x) => x)),
        "mowra": List<dynamic>.from(mowra.map((x) => x?.toJson())),
        "mulishly": List<dynamic>.from(mulishly.map((x) => x)),
        "myoscope": List<dynamic>.from(myoscope.map((x) => x)),
        "nach": List<dynamic>.from(nach.map((x) => x == null ? null : List<dynamic>.from(x!.map((x) => x)))),
        "neuromastic": List<dynamic>.from(neuromastic.map((x) => x)),
        "noncontributing": List<dynamic>.from(noncontributing.map((x) => x.toJson())),
        "nonnervous": List<dynamic>.from(nonnervous.map((x) => x)),
        "nonvaluation": List<dynamic>.from(nonvaluation.map((x) => x)),
        "occupationalist": List<dynamic>.from(occupationalist.map((x) => x)),
        "outrival": List<dynamic>.from(outrival.map((x) => x)),
        "paleographically": List<dynamic>.from(paleographically.map((x) => x)),
        "pamphletwise": List<dynamic>.from(pamphletwise.map((x) => x)),
        "pediatrics": List<dynamic>.from(pediatrics.map((x) => x)),
        "perceptive": List<dynamic>.from(perceptive.map((x) => x)),
        "piaculum": List<dynamic>.from(piaculum.map((x) => x)),
        "piccadilly": List<dynamic>.from(piccadilly.map((x) => x)),
        "piffler": List<dynamic>.from(piffler.map((x) => x)),
        "pithful": List<dynamic>.from(pithful.map((x) => x)),
        "placuntitis": List<dynamic>.from(placuntitis.map((x) => x)),
        "plectopterous": List<dynamic>.from(plectopterous.map((x) => x)),
        "pneumocele": List<dynamic>.from(pneumocele.map((x) => x?.toJson())),
        "poliorcetic": List<dynamic>.from(poliorcetic.map((x) => x)),
        "poormaster": List<dynamic>.from(poormaster.map((x) => x)),
        "potwhisky": List<dynamic>.from(potwhisky.map((x) => x)),
        "practicalizer": List<dynamic>.from(practicalizer.map((x) => x)),
        "prefreshman": List<dynamic>.from(prefreshman.map((x) => x)),
        "prehensility": List<dynamic>.from(prehensility.map((x) => x)),
        "prevoidance": List<dynamic>.from(prevoidance.map((x) => x)),
        "probant": List<dynamic>.from(probant.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "protext": List<dynamic>.from(protext.map((x) => x)),
    };
}

class JurorClass {
    final dynamic adipsy;
    final dynamic auxiliator;
    final dynamic benda;
    final dynamic benjamin;
    final dynamic brandling;
    final dynamic epicurishly;
    final dynamic eremochaetous;
    final dynamic marten;
    final dynamic monocline;
    final dynamic olea;
    final dynamic palgat;
    final dynamic pennyworth;
    final dynamic pioury;
    final dynamic pragmatistic;
    final dynamic stylelessness;
    final dynamic systematical;
    final dynamic thready;
    final dynamic uncontemporary;
    final dynamic uncouched;
    final dynamic uninhabitedness;

    JurorClass({
        required this.adipsy,
        required this.auxiliator,
        required this.benda,
        required this.benjamin,
        required this.brandling,
        required this.epicurishly,
        required this.eremochaetous,
        required this.marten,
        required this.monocline,
        required this.olea,
        required this.palgat,
        required this.pennyworth,
        required this.pioury,
        required this.pragmatistic,
        required this.stylelessness,
        required this.systematical,
        required this.thready,
        required this.uncontemporary,
        required this.uncouched,
        required this.uninhabitedness,
    });

    factory JurorClass.fromJson(Map<String, dynamic> json) => JurorClass(
        adipsy: (json.containsKey("adipsy") ? json["adipsy"] : throw FormatException('Missing required property')),
        auxiliator: (json.containsKey("auxiliator") ? json["auxiliator"] : throw FormatException('Missing required property')),
        benda: (json.containsKey("benda") ? json["benda"] : throw FormatException('Missing required property')),
        benjamin: (json.containsKey("benjamin") ? json["benjamin"] : throw FormatException('Missing required property')),
        brandling: (json.containsKey("brandling") ? json["brandling"] : throw FormatException('Missing required property')),
        epicurishly: (json.containsKey("epicurishly") ? json["epicurishly"] : throw FormatException('Missing required property')),
        eremochaetous: (json.containsKey("eremochaetous") ? json["eremochaetous"] : throw FormatException('Missing required property')),
        marten: (json.containsKey("marten") ? json["marten"] : throw FormatException('Missing required property')),
        monocline: (json.containsKey("monocline") ? json["monocline"] : throw FormatException('Missing required property')),
        olea: (json.containsKey("Olea") ? json["Olea"] : throw FormatException('Missing required property')),
        palgat: (json.containsKey("palgat") ? json["palgat"] : throw FormatException('Missing required property')),
        pennyworth: (json.containsKey("pennyworth") ? json["pennyworth"] : throw FormatException('Missing required property')),
        pioury: (json.containsKey("pioury") ? json["pioury"] : throw FormatException('Missing required property')),
        pragmatistic: (json.containsKey("pragmatistic") ? json["pragmatistic"] : throw FormatException('Missing required property')),
        stylelessness: (json.containsKey("stylelessness") ? json["stylelessness"] : throw FormatException('Missing required property')),
        systematical: (json.containsKey("systematical") ? json["systematical"] : throw FormatException('Missing required property')),
        thready: (json.containsKey("thready") ? json["thready"] : throw FormatException('Missing required property')),
        uncontemporary: (json.containsKey("uncontemporary") ? json["uncontemporary"] : throw FormatException('Missing required property')),
        uncouched: (json.containsKey("uncouched") ? json["uncouched"] : throw FormatException('Missing required property')),
        uninhabitedness: (json.containsKey("uninhabitedness") ? json["uninhabitedness"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "adipsy": adipsy,
        "auxiliator": auxiliator,
        "benda": benda,
        "benjamin": benjamin,
        "brandling": brandling,
        "epicurishly": epicurishly,
        "eremochaetous": eremochaetous,
        "marten": marten,
        "monocline": monocline,
        "Olea": olea,
        "palgat": palgat,
        "pennyworth": pennyworth,
        "pioury": pioury,
        "pragmatistic": pragmatistic,
        "stylelessness": stylelessness,
        "systematical": systematical,
        "thready": thready,
        "uncontemporary": uncontemporary,
        "uncouched": uncouched,
        "uninhabitedness": uninhabitedness,
    };
}

class LadronismClass {
    final dynamic acclaimer;
    final dynamic achree;
    final dynamic base;
    final dynamic conundrumize;
    final dynamic degerminator;
    final dynamic describable;
    final dynamic exasperatedly;
    final dynamic heroine;
    final dynamic indazin;
    final dynamic luteous;
    final dynamic papular;
    final dynamic pritch;
    final dynamic prodenia;
    final dynamic seege;
    final dynamic shopgirl;
    final dynamic tragedietta;
    final dynamic unsparse;
    final dynamic uplook;
    final dynamic vermiformis;
    final dynamic whafabout;

    LadronismClass({
        required this.acclaimer,
        required this.achree,
        required this.base,
        required this.conundrumize,
        required this.degerminator,
        required this.describable,
        required this.exasperatedly,
        required this.heroine,
        required this.indazin,
        required this.luteous,
        required this.papular,
        required this.pritch,
        required this.prodenia,
        required this.seege,
        required this.shopgirl,
        required this.tragedietta,
        required this.unsparse,
        required this.uplook,
        required this.vermiformis,
        required this.whafabout,
    });

    factory LadronismClass.fromJson(Map<String, dynamic> json) => LadronismClass(
        acclaimer: (json.containsKey("acclaimer") ? json["acclaimer"] : throw FormatException('Missing required property')),
        achree: (json.containsKey("achree") ? json["achree"] : throw FormatException('Missing required property')),
        base: (json.containsKey("base") ? json["base"] : throw FormatException('Missing required property')),
        conundrumize: (json.containsKey("conundrumize") ? json["conundrumize"] : throw FormatException('Missing required property')),
        degerminator: (json.containsKey("degerminator") ? json["degerminator"] : throw FormatException('Missing required property')),
        describable: (json.containsKey("describable") ? json["describable"] : throw FormatException('Missing required property')),
        exasperatedly: (json.containsKey("exasperatedly") ? json["exasperatedly"] : throw FormatException('Missing required property')),
        heroine: (json.containsKey("heroine") ? json["heroine"] : throw FormatException('Missing required property')),
        indazin: (json.containsKey("indazin") ? json["indazin"] : throw FormatException('Missing required property')),
        luteous: (json.containsKey("luteous") ? json["luteous"] : throw FormatException('Missing required property')),
        papular: (json.containsKey("papular") ? json["papular"] : throw FormatException('Missing required property')),
        pritch: (json.containsKey("pritch") ? json["pritch"] : throw FormatException('Missing required property')),
        prodenia: (json.containsKey("Prodenia") ? json["Prodenia"] : throw FormatException('Missing required property')),
        seege: (json.containsKey("seege") ? json["seege"] : throw FormatException('Missing required property')),
        shopgirl: (json.containsKey("shopgirl") ? json["shopgirl"] : throw FormatException('Missing required property')),
        tragedietta: (json.containsKey("tragedietta") ? json["tragedietta"] : throw FormatException('Missing required property')),
        unsparse: (json.containsKey("unsparse") ? json["unsparse"] : throw FormatException('Missing required property')),
        uplook: (json.containsKey("uplook") ? json["uplook"] : throw FormatException('Missing required property')),
        vermiformis: (json.containsKey("vermiformis") ? json["vermiformis"] : throw FormatException('Missing required property')),
        whafabout: (json.containsKey("whafabout") ? json["whafabout"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "acclaimer": acclaimer,
        "achree": achree,
        "base": base,
        "conundrumize": conundrumize,
        "degerminator": degerminator,
        "describable": describable,
        "exasperatedly": exasperatedly,
        "heroine": heroine,
        "indazin": indazin,
        "luteous": luteous,
        "papular": papular,
        "pritch": pritch,
        "Prodenia": prodenia,
        "seege": seege,
        "shopgirl": shopgirl,
        "tragedietta": tragedietta,
        "unsparse": unsparse,
        "uplook": uplook,
        "vermiformis": vermiformis,
        "whafabout": whafabout,
    };
}

class LandlubberlyClass {
    final dynamic acropoleis;
    final dynamic aminate;
    final dynamic amyraldism;
    final dynamic bipenniform;
    final dynamic bugre;
    final dynamic calycule;
    final dynamic caoutchouc;
    final dynamic disprover;
    final dynamic fitroot;
    final dynamic fulgently;
    final dynamic kickup;
    final dynamic laevoversion;
    final dynamic moter;
    final dynamic objectivity;
    final dynamic posterity;
    final dynamic postnuptial;
    final dynamic precedentary;
    final dynamic saddling;
    final dynamic subcurrent;
    final dynamic unrecriminative;

    LandlubberlyClass({
        required this.acropoleis,
        required this.aminate,
        required this.amyraldism,
        required this.bipenniform,
        required this.bugre,
        required this.calycule,
        required this.caoutchouc,
        required this.disprover,
        required this.fitroot,
        required this.fulgently,
        required this.kickup,
        required this.laevoversion,
        required this.moter,
        required this.objectivity,
        required this.posterity,
        required this.postnuptial,
        required this.precedentary,
        required this.saddling,
        required this.subcurrent,
        required this.unrecriminative,
    });

    factory LandlubberlyClass.fromJson(Map<String, dynamic> json) => LandlubberlyClass(
        acropoleis: (json.containsKey("acropoleis") ? json["acropoleis"] : throw FormatException('Missing required property')),
        aminate: (json.containsKey("aminate") ? json["aminate"] : throw FormatException('Missing required property')),
        amyraldism: (json.containsKey("Amyraldism") ? json["Amyraldism"] : throw FormatException('Missing required property')),
        bipenniform: (json.containsKey("bipenniform") ? json["bipenniform"] : throw FormatException('Missing required property')),
        bugre: (json.containsKey("bugre") ? json["bugre"] : throw FormatException('Missing required property')),
        calycule: (json.containsKey("calycule") ? json["calycule"] : throw FormatException('Missing required property')),
        caoutchouc: (json.containsKey("caoutchouc") ? json["caoutchouc"] : throw FormatException('Missing required property')),
        disprover: (json.containsKey("disprover") ? json["disprover"] : throw FormatException('Missing required property')),
        fitroot: (json.containsKey("fitroot") ? json["fitroot"] : throw FormatException('Missing required property')),
        fulgently: (json.containsKey("fulgently") ? json["fulgently"] : throw FormatException('Missing required property')),
        kickup: (json.containsKey("kickup") ? json["kickup"] : throw FormatException('Missing required property')),
        laevoversion: (json.containsKey("laevoversion") ? json["laevoversion"] : throw FormatException('Missing required property')),
        moter: (json.containsKey("moter") ? json["moter"] : throw FormatException('Missing required property')),
        objectivity: (json.containsKey("objectivity") ? json["objectivity"] : throw FormatException('Missing required property')),
        posterity: (json.containsKey("posterity") ? json["posterity"] : throw FormatException('Missing required property')),
        postnuptial: (json.containsKey("postnuptial") ? json["postnuptial"] : throw FormatException('Missing required property')),
        precedentary: (json.containsKey("precedentary") ? json["precedentary"] : throw FormatException('Missing required property')),
        saddling: (json.containsKey("saddling") ? json["saddling"] : throw FormatException('Missing required property')),
        subcurrent: (json.containsKey("subcurrent") ? json["subcurrent"] : throw FormatException('Missing required property')),
        unrecriminative: (json.containsKey("unrecriminative") ? json["unrecriminative"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "acropoleis": acropoleis,
        "aminate": aminate,
        "Amyraldism": amyraldism,
        "bipenniform": bipenniform,
        "bugre": bugre,
        "calycule": calycule,
        "caoutchouc": caoutchouc,
        "disprover": disprover,
        "fitroot": fitroot,
        "fulgently": fulgently,
        "kickup": kickup,
        "laevoversion": laevoversion,
        "moter": moter,
        "objectivity": objectivity,
        "posterity": posterity,
        "postnuptial": postnuptial,
        "precedentary": precedentary,
        "saddling": saddling,
        "subcurrent": subcurrent,
        "unrecriminative": unrecriminative,
    };
}

class LupusClass {
    final double? catharticalness;
    final int? chirotherium;
    final int? chlorioninae;
    final int? corvinae;
    final int? crassina;
    final String? disdiapason;
    final int? exiguity;
    final int? farcist;
    final int? holographical;
    final bool? homocerc;
    final int? ichthyophagan;
    final int? implacable;
    final dynamic nonbookish;
    final int? outshiner;
    final int? overweather;
    final int? protonegroid;
    final int? shallowish;
    final int? snoke;
    final int? snout;
    final int? surveillance;
    final int? threshingtime;
    final int? thysanocarpus;
    final int? unsignificantly;
    final int? unsnap;
    final int? vendible;

    LupusClass({
        this.catharticalness,
        this.chirotherium,
        this.chlorioninae,
        this.corvinae,
        this.crassina,
        this.disdiapason,
        this.exiguity,
        this.farcist,
        this.holographical,
        this.homocerc,
        this.ichthyophagan,
        this.implacable,
        this.nonbookish,
        this.outshiner,
        this.overweather,
        this.protonegroid,
        this.shallowish,
        this.snoke,
        this.snout,
        this.surveillance,
        this.threshingtime,
        this.thysanocarpus,
        this.unsignificantly,
        this.unsnap,
        this.vendible,
    });

    factory LupusClass.fromJson(Map<String, dynamic> json) => LupusClass(
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        chlorioninae: json["Chlorioninae"],
        corvinae: json["Corvinae"],
        crassina: json["Crassina"],
        disdiapason: json["disdiapason"],
        exiguity: json["exiguity"],
        farcist: json["farcist"],
        holographical: json["holographical"],
        homocerc: json["homocerc"],
        ichthyophagan: json["ichthyophagan"],
        implacable: json["implacable"],
        nonbookish: json["nonbookish"],
        outshiner: json["outshiner"],
        overweather: json["overweather"],
        protonegroid: json["protonegroid"],
        shallowish: json["shallowish"],
        snoke: json["snoke"],
        snout: json["snout"],
        surveillance: json["surveillance"],
        threshingtime: json["threshingtime"],
        thysanocarpus: json["Thysanocarpus"],
        unsignificantly: json["unsignificantly"],
        unsnap: json["unsnap"],
        vendible: json["vendible"],
    );

    Map<String, dynamic> toJson() => {
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "Chlorioninae": chlorioninae,
        "Corvinae": corvinae,
        "Crassina": crassina,
        "disdiapason": disdiapason,
        "exiguity": exiguity,
        "farcist": farcist,
        "holographical": holographical,
        "homocerc": homocerc,
        "ichthyophagan": ichthyophagan,
        "implacable": implacable,
        "nonbookish": nonbookish,
        "outshiner": outshiner,
        "overweather": overweather,
        "protonegroid": protonegroid,
        "shallowish": shallowish,
        "snoke": snoke,
        "snout": snout,
        "surveillance": surveillance,
        "threshingtime": threshingtime,
        "Thysanocarpus": thysanocarpus,
        "unsignificantly": unsignificantly,
        "unsnap": unsnap,
        "vendible": vendible,
    };
}

class Maslin {
    final int? alicant;
    final dynamic antiatonement;
    final int? anticorrosive;
    final dynamic aphidozer;
    final dynamic bakuninist;
    final int? be;
    final double? catharticalness;
    final int? chirotherium;
    final int? chub;
    final int? cuprosilicon;
    final int? curtailedly;
    final int? dellenite;
    final int? dimitry;
    final String? disdiapason;
    final dynamic edifying;
    final int? ethmoiditis;
    final dynamic gastralgy;
    final int? goatherd;
    final int? hammerdress;
    final dynamic hangfire;
    final bool? homocerc;
    final int? lacunosity;
    final dynamic longiloquence;
    final int? mameliere;
    final dynamic motherless;
    final dynamic nonbookish;
    final dynamic noncorrodible;
    final dynamic nonsensicality;
    final int? oafishly;
    final dynamic pfund;
    final dynamic preadvisory;
    final dynamic retroflexed;
    final int? saccharulmic;
    final int? scowlful;
    final dynamic secluded;
    final dynamic slackage;
    final int? sphaeridial;
    final dynamic spondulics;
    final int? subsecive;
    final dynamic swellmobsman;
    final int? trachyglossate;
    final dynamic trialogue;
    final int? unassuaged;
    final dynamic ungross;
    final dynamic unjudiciously;

    Maslin({
        this.alicant,
        this.antiatonement,
        this.anticorrosive,
        this.aphidozer,
        this.bakuninist,
        this.be,
        this.catharticalness,
        this.chirotherium,
        this.chub,
        this.cuprosilicon,
        this.curtailedly,
        this.dellenite,
        this.dimitry,
        this.disdiapason,
        this.edifying,
        this.ethmoiditis,
        this.gastralgy,
        this.goatherd,
        this.hammerdress,
        this.hangfire,
        this.homocerc,
        this.lacunosity,
        this.longiloquence,
        this.mameliere,
        this.motherless,
        this.nonbookish,
        this.noncorrodible,
        this.nonsensicality,
        this.oafishly,
        this.pfund,
        this.preadvisory,
        this.retroflexed,
        this.saccharulmic,
        this.scowlful,
        this.secluded,
        this.slackage,
        this.sphaeridial,
        this.spondulics,
        this.subsecive,
        this.swellmobsman,
        this.trachyglossate,
        this.trialogue,
        this.unassuaged,
        this.ungross,
        this.unjudiciously,
    });

    factory Maslin.fromJson(Map<String, dynamic> json) => Maslin(
        alicant: json["Alicant"],
        antiatonement: json["antiatonement"],
        anticorrosive: json["anticorrosive"],
        aphidozer: json["aphidozer"],
        bakuninist: json["Bakuninist"],
        be: json["be"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        chub: json["chub"],
        cuprosilicon: json["cuprosilicon"],
        curtailedly: json["curtailedly"],
        dellenite: json["dellenite"],
        dimitry: json["Dimitry"],
        disdiapason: json["disdiapason"],
        edifying: json["edifying"],
        ethmoiditis: json["ethmoiditis"],
        gastralgy: json["gastralgy"],
        goatherd: json["goatherd"],
        hammerdress: json["hammerdress"],
        hangfire: json["hangfire"],
        homocerc: json["homocerc"],
        lacunosity: json["lacunosity"],
        longiloquence: json["longiloquence"],
        mameliere: json["mameliere"],
        motherless: json["motherless"],
        nonbookish: json["nonbookish"],
        noncorrodible: json["noncorrodible"],
        nonsensicality: json["nonsensicality"],
        oafishly: json["oafishly"],
        pfund: json["pfund"],
        preadvisory: json["preadvisory"],
        retroflexed: json["retroflexed"],
        saccharulmic: json["saccharulmic"],
        scowlful: json["scowlful"],
        secluded: json["secluded"],
        slackage: json["slackage"],
        sphaeridial: json["sphaeridial"],
        spondulics: json["spondulics"],
        subsecive: json["subsecive"],
        swellmobsman: json["swellmobsman"],
        trachyglossate: json["trachyglossate"],
        trialogue: json["trialogue"],
        unassuaged: json["unassuaged"],
        ungross: json["ungross"],
        unjudiciously: json["unjudiciously"],
    );

    Map<String, dynamic> toJson() => {
        "Alicant": alicant,
        "antiatonement": antiatonement,
        "anticorrosive": anticorrosive,
        "aphidozer": aphidozer,
        "Bakuninist": bakuninist,
        "be": be,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "chub": chub,
        "cuprosilicon": cuprosilicon,
        "curtailedly": curtailedly,
        "dellenite": dellenite,
        "Dimitry": dimitry,
        "disdiapason": disdiapason,
        "edifying": edifying,
        "ethmoiditis": ethmoiditis,
        "gastralgy": gastralgy,
        "goatherd": goatherd,
        "hammerdress": hammerdress,
        "hangfire": hangfire,
        "homocerc": homocerc,
        "lacunosity": lacunosity,
        "longiloquence": longiloquence,
        "mameliere": mameliere,
        "motherless": motherless,
        "nonbookish": nonbookish,
        "noncorrodible": noncorrodible,
        "nonsensicality": nonsensicality,
        "oafishly": oafishly,
        "pfund": pfund,
        "preadvisory": preadvisory,
        "retroflexed": retroflexed,
        "saccharulmic": saccharulmic,
        "scowlful": scowlful,
        "secluded": secluded,
        "slackage": slackage,
        "sphaeridial": sphaeridial,
        "spondulics": spondulics,
        "subsecive": subsecive,
        "swellmobsman": swellmobsman,
        "trachyglossate": trachyglossate,
        "trialogue": trialogue,
        "unassuaged": unassuaged,
        "ungross": ungross,
        "unjudiciously": unjudiciously,
    };
}

class MonaziteClass {
    final double catharticalness;
    final int chirotherium;
    final String disdiapason;
    final bool homocerc;
    final dynamic nonbookish;

    MonaziteClass({
        required this.catharticalness,
        required this.chirotherium,
        required this.disdiapason,
        required this.homocerc,
        required this.nonbookish,
    });

    factory MonaziteClass.fromJson(Map<String, dynamic> json) => MonaziteClass(
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

class MonotheisticallyClass {
    final dynamic blaspheme;
    final double? catharticalness;
    final dynamic celiosalpingectomy;
    final int? chirotherium;
    final dynamic consummativeness;
    final String? disdiapason;
    final dynamic egestive;
    final dynamic enchylema;
    final dynamic gasconade;
    final dynamic holidayer;
    final bool? homocerc;
    final dynamic intuitionalism;
    final dynamic lophiostomate;
    final dynamic nonbookish;
    final dynamic nonvolition;
    final dynamic palatableness;
    final dynamic pimpery;
    final dynamic previolation;
    final dynamic reconveyance;
    final dynamic registership;
    final dynamic rhyacolite;
    final dynamic smithereens;
    final dynamic superedification;
    final dynamic trust;
    final dynamic whitestone;

    MonotheisticallyClass({
        this.blaspheme,
        this.catharticalness,
        this.celiosalpingectomy,
        this.chirotherium,
        this.consummativeness,
        this.disdiapason,
        this.egestive,
        this.enchylema,
        this.gasconade,
        this.holidayer,
        this.homocerc,
        this.intuitionalism,
        this.lophiostomate,
        this.nonbookish,
        this.nonvolition,
        this.palatableness,
        this.pimpery,
        this.previolation,
        this.reconveyance,
        this.registership,
        this.rhyacolite,
        this.smithereens,
        this.superedification,
        this.trust,
        this.whitestone,
    });

    factory MonotheisticallyClass.fromJson(Map<String, dynamic> json) => MonotheisticallyClass(
        blaspheme: json["blaspheme"],
        catharticalness: json["catharticalness"]?.toDouble(),
        celiosalpingectomy: json["celiosalpingectomy"],
        chirotherium: json["Chirotherium"],
        consummativeness: json["consummativeness"],
        disdiapason: json["disdiapason"],
        egestive: json["egestive"],
        enchylema: json["enchylema"],
        gasconade: json["gasconade"],
        holidayer: json["holidayer"],
        homocerc: json["homocerc"],
        intuitionalism: json["intuitionalism"],
        lophiostomate: json["lophiostomate"],
        nonbookish: json["nonbookish"],
        nonvolition: json["nonvolition"],
        palatableness: json["palatableness"],
        pimpery: json["pimpery"],
        previolation: json["previolation"],
        reconveyance: json["reconveyance"],
        registership: json["registership"],
        rhyacolite: json["rhyacolite"],
        smithereens: json["smithereens"],
        superedification: json["superedification"],
        trust: json["trust"],
        whitestone: json["whitestone"],
    );

    Map<String, dynamic> toJson() => {
        "blaspheme": blaspheme,
        "catharticalness": catharticalness,
        "celiosalpingectomy": celiosalpingectomy,
        "Chirotherium": chirotherium,
        "consummativeness": consummativeness,
        "disdiapason": disdiapason,
        "egestive": egestive,
        "enchylema": enchylema,
        "gasconade": gasconade,
        "holidayer": holidayer,
        "homocerc": homocerc,
        "intuitionalism": intuitionalism,
        "lophiostomate": lophiostomate,
        "nonbookish": nonbookish,
        "nonvolition": nonvolition,
        "palatableness": palatableness,
        "pimpery": pimpery,
        "previolation": previolation,
        "reconveyance": reconveyance,
        "registership": registership,
        "rhyacolite": rhyacolite,
        "smithereens": smithereens,
        "superedification": superedification,
        "trust": trust,
        "whitestone": whitestone,
    };
}

class Noncontributing {
    final String estevin;
    final double jolterhead;
    final int sauternes;
    final bool sparsely;
    final dynamic unrequested;

    Noncontributing({
        required this.estevin,
        required this.jolterhead,
        required this.sauternes,
        required this.sparsely,
        required this.unrequested,
    });

    factory Noncontributing.fromJson(Map<String, dynamic> json) => Noncontributing(
        estevin: json["estevin"],
        jolterhead: json["jolterhead"]?.toDouble(),
        sauternes: json["sauternes"],
        sparsely: json["sparsely"],
        unrequested: (json.containsKey("unrequested") ? json["unrequested"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "estevin": estevin,
        "jolterhead": jolterhead,
        "sauternes": sauternes,
        "sparsely": sparsely,
        "unrequested": unrequested,
    };
}

class OccupationalistClass {
    final dynamic beholdable;
    final dynamic brotuliform;
    final dynamic chimakum;
    final dynamic doodler;
    final dynamic emulsin;
    final dynamic fin;
    final dynamic flourishing;
    final dynamic flueless;
    final dynamic furtively;
    final dynamic gritter;
    final dynamic interwish;
    final dynamic monoxylic;
    final dynamic myristic;
    final dynamic nightwear;
    final dynamic peruser;
    final dynamic theoastrological;
    final dynamic thumby;
    final dynamic tingitid;
    final dynamic trailless;
    final dynamic unpocketed;

    OccupationalistClass({
        required this.beholdable,
        required this.brotuliform,
        required this.chimakum,
        required this.doodler,
        required this.emulsin,
        required this.fin,
        required this.flourishing,
        required this.flueless,
        required this.furtively,
        required this.gritter,
        required this.interwish,
        required this.monoxylic,
        required this.myristic,
        required this.nightwear,
        required this.peruser,
        required this.theoastrological,
        required this.thumby,
        required this.tingitid,
        required this.trailless,
        required this.unpocketed,
    });

    factory OccupationalistClass.fromJson(Map<String, dynamic> json) => OccupationalistClass(
        beholdable: (json.containsKey("beholdable") ? json["beholdable"] : throw FormatException('Missing required property')),
        brotuliform: (json.containsKey("brotuliform") ? json["brotuliform"] : throw FormatException('Missing required property')),
        chimakum: (json.containsKey("Chimakum") ? json["Chimakum"] : throw FormatException('Missing required property')),
        doodler: (json.containsKey("doodler") ? json["doodler"] : throw FormatException('Missing required property')),
        emulsin: (json.containsKey("emulsin") ? json["emulsin"] : throw FormatException('Missing required property')),
        fin: (json.containsKey("Fin") ? json["Fin"] : throw FormatException('Missing required property')),
        flourishing: (json.containsKey("flourishing") ? json["flourishing"] : throw FormatException('Missing required property')),
        flueless: (json.containsKey("flueless") ? json["flueless"] : throw FormatException('Missing required property')),
        furtively: (json.containsKey("furtively") ? json["furtively"] : throw FormatException('Missing required property')),
        gritter: (json.containsKey("gritter") ? json["gritter"] : throw FormatException('Missing required property')),
        interwish: (json.containsKey("interwish") ? json["interwish"] : throw FormatException('Missing required property')),
        monoxylic: (json.containsKey("monoxylic") ? json["monoxylic"] : throw FormatException('Missing required property')),
        myristic: (json.containsKey("myristic") ? json["myristic"] : throw FormatException('Missing required property')),
        nightwear: (json.containsKey("nightwear") ? json["nightwear"] : throw FormatException('Missing required property')),
        peruser: (json.containsKey("peruser") ? json["peruser"] : throw FormatException('Missing required property')),
        theoastrological: (json.containsKey("theoastrological") ? json["theoastrological"] : throw FormatException('Missing required property')),
        thumby: (json.containsKey("thumby") ? json["thumby"] : throw FormatException('Missing required property')),
        tingitid: (json.containsKey("tingitid") ? json["tingitid"] : throw FormatException('Missing required property')),
        trailless: (json.containsKey("trailless") ? json["trailless"] : throw FormatException('Missing required property')),
        unpocketed: (json.containsKey("unpocketed") ? json["unpocketed"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "beholdable": beholdable,
        "brotuliform": brotuliform,
        "Chimakum": chimakum,
        "doodler": doodler,
        "emulsin": emulsin,
        "Fin": fin,
        "flourishing": flourishing,
        "flueless": flueless,
        "furtively": furtively,
        "gritter": gritter,
        "interwish": interwish,
        "monoxylic": monoxylic,
        "myristic": myristic,
        "nightwear": nightwear,
        "peruser": peruser,
        "theoastrological": theoastrological,
        "thumby": thumby,
        "tingitid": tingitid,
        "trailless": trailless,
        "unpocketed": unpocketed,
    };
}

class OutrivalClass {
    final dynamic adroitly;
    final dynamic bridehood;
    final dynamic castoroides;
    final dynamic czechoslovak;
    final dynamic diagenesis;
    final dynamic dihexahedron;
    final dynamic dopester;
    final dynamic eumerism;
    final dynamic flyness;
    final dynamic fouler;
    final dynamic laudanosine;
    final dynamic lingulidae;
    final dynamic minutary;
    final dynamic mitra;
    final dynamic opisthorchiasis;
    final dynamic pensively;
    final dynamic pubigerous;
    final dynamic rebellious;
    final dynamic recodify;
    final dynamic unpaced;

    OutrivalClass({
        required this.adroitly,
        required this.bridehood,
        required this.castoroides,
        required this.czechoslovak,
        required this.diagenesis,
        required this.dihexahedron,
        required this.dopester,
        required this.eumerism,
        required this.flyness,
        required this.fouler,
        required this.laudanosine,
        required this.lingulidae,
        required this.minutary,
        required this.mitra,
        required this.opisthorchiasis,
        required this.pensively,
        required this.pubigerous,
        required this.rebellious,
        required this.recodify,
        required this.unpaced,
    });

    factory OutrivalClass.fromJson(Map<String, dynamic> json) => OutrivalClass(
        adroitly: (json.containsKey("adroitly") ? json["adroitly"] : throw FormatException('Missing required property')),
        bridehood: (json.containsKey("bridehood") ? json["bridehood"] : throw FormatException('Missing required property')),
        castoroides: (json.containsKey("Castoroides") ? json["Castoroides"] : throw FormatException('Missing required property')),
        czechoslovak: (json.containsKey("Czechoslovak") ? json["Czechoslovak"] : throw FormatException('Missing required property')),
        diagenesis: (json.containsKey("diagenesis") ? json["diagenesis"] : throw FormatException('Missing required property')),
        dihexahedron: (json.containsKey("dihexahedron") ? json["dihexahedron"] : throw FormatException('Missing required property')),
        dopester: (json.containsKey("dopester") ? json["dopester"] : throw FormatException('Missing required property')),
        eumerism: (json.containsKey("eumerism") ? json["eumerism"] : throw FormatException('Missing required property')),
        flyness: (json.containsKey("flyness") ? json["flyness"] : throw FormatException('Missing required property')),
        fouler: (json.containsKey("fouler") ? json["fouler"] : throw FormatException('Missing required property')),
        laudanosine: (json.containsKey("laudanosine") ? json["laudanosine"] : throw FormatException('Missing required property')),
        lingulidae: (json.containsKey("Lingulidae") ? json["Lingulidae"] : throw FormatException('Missing required property')),
        minutary: (json.containsKey("minutary") ? json["minutary"] : throw FormatException('Missing required property')),
        mitra: (json.containsKey("mitra") ? json["mitra"] : throw FormatException('Missing required property')),
        opisthorchiasis: (json.containsKey("opisthorchiasis") ? json["opisthorchiasis"] : throw FormatException('Missing required property')),
        pensively: (json.containsKey("pensively") ? json["pensively"] : throw FormatException('Missing required property')),
        pubigerous: (json.containsKey("pubigerous") ? json["pubigerous"] : throw FormatException('Missing required property')),
        rebellious: (json.containsKey("rebellious") ? json["rebellious"] : throw FormatException('Missing required property')),
        recodify: (json.containsKey("recodify") ? json["recodify"] : throw FormatException('Missing required property')),
        unpaced: (json.containsKey("unpaced") ? json["unpaced"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "adroitly": adroitly,
        "bridehood": bridehood,
        "Castoroides": castoroides,
        "Czechoslovak": czechoslovak,
        "diagenesis": diagenesis,
        "dihexahedron": dihexahedron,
        "dopester": dopester,
        "eumerism": eumerism,
        "flyness": flyness,
        "fouler": fouler,
        "laudanosine": laudanosine,
        "Lingulidae": lingulidae,
        "minutary": minutary,
        "mitra": mitra,
        "opisthorchiasis": opisthorchiasis,
        "pensively": pensively,
        "pubigerous": pubigerous,
        "rebellious": rebellious,
        "recodify": recodify,
        "unpaced": unpaced,
    };
}

class PiaculumClass {
    final int? alada;
    final int? amphistomous;
    final int? boysenberry;
    final double? catharticalness;
    final int? chirotherium;
    final int? decardinalize;
    final int? discouragement;
    final String? disdiapason;
    final int? doitrified;
    final int? hexaspermous;
    final bool? homocerc;
    final int? insinking;
    final int? loathfulness;
    final int? miasmatical;
    final int? neurofibril;
    final dynamic nonbookish;
    final int? phonendoscope;
    final int? pilferment;
    final int? predismissory;
    final int? preinscription;
    final int? quotative;
    final int? sienna;
    final int? thorax;
    final int? yachting;
    final int? zipper;

    PiaculumClass({
        this.alada,
        this.amphistomous,
        this.boysenberry,
        this.catharticalness,
        this.chirotherium,
        this.decardinalize,
        this.discouragement,
        this.disdiapason,
        this.doitrified,
        this.hexaspermous,
        this.homocerc,
        this.insinking,
        this.loathfulness,
        this.miasmatical,
        this.neurofibril,
        this.nonbookish,
        this.phonendoscope,
        this.pilferment,
        this.predismissory,
        this.preinscription,
        this.quotative,
        this.sienna,
        this.thorax,
        this.yachting,
        this.zipper,
    });

    factory PiaculumClass.fromJson(Map<String, dynamic> json) => PiaculumClass(
        alada: json["alada"],
        amphistomous: json["amphistomous"],
        boysenberry: json["boysenberry"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        decardinalize: json["decardinalize"],
        discouragement: json["discouragement"],
        disdiapason: json["disdiapason"],
        doitrified: json["doitrified"],
        hexaspermous: json["hexaspermous"],
        homocerc: json["homocerc"],
        insinking: json["insinking"],
        loathfulness: json["loathfulness"],
        miasmatical: json["miasmatical"],
        neurofibril: json["neurofibril"],
        nonbookish: json["nonbookish"],
        phonendoscope: json["phonendoscope"],
        pilferment: json["pilferment"],
        predismissory: json["predismissory"],
        preinscription: json["preinscription"],
        quotative: json["quotative"],
        sienna: json["sienna"],
        thorax: json["thorax"],
        yachting: json["yachting"],
        zipper: json["Zipper"],
    );

    Map<String, dynamic> toJson() => {
        "alada": alada,
        "amphistomous": amphistomous,
        "boysenberry": boysenberry,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "decardinalize": decardinalize,
        "discouragement": discouragement,
        "disdiapason": disdiapason,
        "doitrified": doitrified,
        "hexaspermous": hexaspermous,
        "homocerc": homocerc,
        "insinking": insinking,
        "loathfulness": loathfulness,
        "miasmatical": miasmatical,
        "neurofibril": neurofibril,
        "nonbookish": nonbookish,
        "phonendoscope": phonendoscope,
        "pilferment": pilferment,
        "predismissory": predismissory,
        "preinscription": preinscription,
        "quotative": quotative,
        "sienna": sienna,
        "thorax": thorax,
        "yachting": yachting,
        "Zipper": zipper,
    };
}

class Pneumocele {
    final dynamic carbonarism;
    final double? catharticalness;
    final int? chirotherium;
    final dynamic cineolic;
    final dynamic cobbly;
    final dynamic conchyliferous;
    final dynamic congregation;
    final String? disdiapason;
    final dynamic enterotomy;
    final dynamic entophytal;
    final dynamic fewtrils;
    final dynamic herem;
    final bool? homocerc;
    final dynamic koniga;
    final dynamic meticulosity;
    final dynamic micky;
    final dynamic mismarriage;
    final dynamic neurotrophic;
    final dynamic nonbookish;
    final dynamic persuasively;
    final dynamic replaceable;
    final dynamic silex;
    final dynamic taillight;
    final dynamic unjealous;
    final dynamic visitorial;

    Pneumocele({
        this.carbonarism,
        this.catharticalness,
        this.chirotherium,
        this.cineolic,
        this.cobbly,
        this.conchyliferous,
        this.congregation,
        this.disdiapason,
        this.enterotomy,
        this.entophytal,
        this.fewtrils,
        this.herem,
        this.homocerc,
        this.koniga,
        this.meticulosity,
        this.micky,
        this.mismarriage,
        this.neurotrophic,
        this.nonbookish,
        this.persuasively,
        this.replaceable,
        this.silex,
        this.taillight,
        this.unjealous,
        this.visitorial,
    });

    factory Pneumocele.fromJson(Map<String, dynamic> json) => Pneumocele(
        carbonarism: json["Carbonarism"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        cineolic: json["cineolic"],
        cobbly: json["cobbly"],
        conchyliferous: json["conchyliferous"],
        congregation: json["congregation"],
        disdiapason: json["disdiapason"],
        enterotomy: json["enterotomy"],
        entophytal: json["entophytal"],
        fewtrils: json["fewtrils"],
        herem: json["herem"],
        homocerc: json["homocerc"],
        koniga: json["Koniga"],
        meticulosity: json["meticulosity"],
        micky: json["Micky"],
        mismarriage: json["mismarriage"],
        neurotrophic: json["neurotrophic"],
        nonbookish: json["nonbookish"],
        persuasively: json["persuasively"],
        replaceable: json["replaceable"],
        silex: json["silex"],
        taillight: json["taillight"],
        unjealous: json["unjealous"],
        visitorial: json["visitorial"],
    );

    Map<String, dynamic> toJson() => {
        "Carbonarism": carbonarism,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "cineolic": cineolic,
        "cobbly": cobbly,
        "conchyliferous": conchyliferous,
        "congregation": congregation,
        "disdiapason": disdiapason,
        "enterotomy": enterotomy,
        "entophytal": entophytal,
        "fewtrils": fewtrils,
        "herem": herem,
        "homocerc": homocerc,
        "Koniga": koniga,
        "meticulosity": meticulosity,
        "Micky": micky,
        "mismarriage": mismarriage,
        "neurotrophic": neurotrophic,
        "nonbookish": nonbookish,
        "persuasively": persuasively,
        "replaceable": replaceable,
        "silex": silex,
        "taillight": taillight,
        "unjealous": unjealous,
        "visitorial": visitorial,
    };
}

class PotwhiskyClass {
    final dynamic arciform;
    final dynamic cresolin;
    final dynamic disheartener;
    final dynamic disproportionable;
    final dynamic euchorda;
    final dynamic ferryway;
    final dynamic filamentiferous;
    final dynamic flemish;
    final dynamic forgainst;
    final dynamic grainering;
    final dynamic irrevoluble;
    final dynamic kindredship;
    final dynamic pinguitudinous;
    final dynamic simpletonic;
    final dynamic singsong;
    final dynamic submergement;
    final dynamic supraoesophagal;
    final dynamic thrashel;
    final dynamic tyremesis;
    final dynamic yoruba;

    PotwhiskyClass({
        required this.arciform,
        required this.cresolin,
        required this.disheartener,
        required this.disproportionable,
        required this.euchorda,
        required this.ferryway,
        required this.filamentiferous,
        required this.flemish,
        required this.forgainst,
        required this.grainering,
        required this.irrevoluble,
        required this.kindredship,
        required this.pinguitudinous,
        required this.simpletonic,
        required this.singsong,
        required this.submergement,
        required this.supraoesophagal,
        required this.thrashel,
        required this.tyremesis,
        required this.yoruba,
    });

    factory PotwhiskyClass.fromJson(Map<String, dynamic> json) => PotwhiskyClass(
        arciform: (json.containsKey("arciform") ? json["arciform"] : throw FormatException('Missing required property')),
        cresolin: (json.containsKey("cresolin") ? json["cresolin"] : throw FormatException('Missing required property')),
        disheartener: (json.containsKey("disheartener") ? json["disheartener"] : throw FormatException('Missing required property')),
        disproportionable: (json.containsKey("disproportionable") ? json["disproportionable"] : throw FormatException('Missing required property')),
        euchorda: (json.containsKey("Euchorda") ? json["Euchorda"] : throw FormatException('Missing required property')),
        ferryway: (json.containsKey("ferryway") ? json["ferryway"] : throw FormatException('Missing required property')),
        filamentiferous: (json.containsKey("filamentiferous") ? json["filamentiferous"] : throw FormatException('Missing required property')),
        flemish: (json.containsKey("flemish") ? json["flemish"] : throw FormatException('Missing required property')),
        forgainst: (json.containsKey("forgainst") ? json["forgainst"] : throw FormatException('Missing required property')),
        grainering: (json.containsKey("grainering") ? json["grainering"] : throw FormatException('Missing required property')),
        irrevoluble: (json.containsKey("irrevoluble") ? json["irrevoluble"] : throw FormatException('Missing required property')),
        kindredship: (json.containsKey("kindredship") ? json["kindredship"] : throw FormatException('Missing required property')),
        pinguitudinous: (json.containsKey("pinguitudinous") ? json["pinguitudinous"] : throw FormatException('Missing required property')),
        simpletonic: (json.containsKey("simpletonic") ? json["simpletonic"] : throw FormatException('Missing required property')),
        singsong: (json.containsKey("singsong") ? json["singsong"] : throw FormatException('Missing required property')),
        submergement: (json.containsKey("submergement") ? json["submergement"] : throw FormatException('Missing required property')),
        supraoesophagal: (json.containsKey("supraoesophagal") ? json["supraoesophagal"] : throw FormatException('Missing required property')),
        thrashel: (json.containsKey("thrashel") ? json["thrashel"] : throw FormatException('Missing required property')),
        tyremesis: (json.containsKey("tyremesis") ? json["tyremesis"] : throw FormatException('Missing required property')),
        yoruba: (json.containsKey("Yoruba") ? json["Yoruba"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "arciform": arciform,
        "cresolin": cresolin,
        "disheartener": disheartener,
        "disproportionable": disproportionable,
        "Euchorda": euchorda,
        "ferryway": ferryway,
        "filamentiferous": filamentiferous,
        "flemish": flemish,
        "forgainst": forgainst,
        "grainering": grainering,
        "irrevoluble": irrevoluble,
        "kindredship": kindredship,
        "pinguitudinous": pinguitudinous,
        "simpletonic": simpletonic,
        "singsong": singsong,
        "submergement": submergement,
        "supraoesophagal": supraoesophagal,
        "thrashel": thrashel,
        "tyremesis": tyremesis,
        "Yoruba": yoruba,
    };
}

class PrefreshmanClass {
    final dynamic azorubine;
    final dynamic choroiditis;
    final dynamic coagulatory;
    final dynamic cyclorama;
    final dynamic dolphus;
    final dynamic duckhearted;
    final dynamic ficus;
    final dynamic gemaric;
    final dynamic jugation;
    final dynamic myoliposis;
    final dynamic nonnomination;
    final dynamic palay;
    final dynamic pentactinal;
    final dynamic phaet;
    final dynamic piquant;
    final dynamic registration;
    final dynamic remancipation;
    final dynamic scutatiform;
    final dynamic theodolite;
    final dynamic underward;

    PrefreshmanClass({
        required this.azorubine,
        required this.choroiditis,
        required this.coagulatory,
        required this.cyclorama,
        required this.dolphus,
        required this.duckhearted,
        required this.ficus,
        required this.gemaric,
        required this.jugation,
        required this.myoliposis,
        required this.nonnomination,
        required this.palay,
        required this.pentactinal,
        required this.phaet,
        required this.piquant,
        required this.registration,
        required this.remancipation,
        required this.scutatiform,
        required this.theodolite,
        required this.underward,
    });

    factory PrefreshmanClass.fromJson(Map<String, dynamic> json) => PrefreshmanClass(
        azorubine: (json.containsKey("azorubine") ? json["azorubine"] : throw FormatException('Missing required property')),
        choroiditis: (json.containsKey("choroiditis") ? json["choroiditis"] : throw FormatException('Missing required property')),
        coagulatory: (json.containsKey("coagulatory") ? json["coagulatory"] : throw FormatException('Missing required property')),
        cyclorama: (json.containsKey("cyclorama") ? json["cyclorama"] : throw FormatException('Missing required property')),
        dolphus: (json.containsKey("Dolphus") ? json["Dolphus"] : throw FormatException('Missing required property')),
        duckhearted: (json.containsKey("duckhearted") ? json["duckhearted"] : throw FormatException('Missing required property')),
        ficus: (json.containsKey("Ficus") ? json["Ficus"] : throw FormatException('Missing required property')),
        gemaric: (json.containsKey("Gemaric") ? json["Gemaric"] : throw FormatException('Missing required property')),
        jugation: (json.containsKey("jugation") ? json["jugation"] : throw FormatException('Missing required property')),
        myoliposis: (json.containsKey("myoliposis") ? json["myoliposis"] : throw FormatException('Missing required property')),
        nonnomination: (json.containsKey("nonnomination") ? json["nonnomination"] : throw FormatException('Missing required property')),
        palay: (json.containsKey("palay") ? json["palay"] : throw FormatException('Missing required property')),
        pentactinal: (json.containsKey("pentactinal") ? json["pentactinal"] : throw FormatException('Missing required property')),
        phaet: (json.containsKey("Phaet") ? json["Phaet"] : throw FormatException('Missing required property')),
        piquant: (json.containsKey("piquant") ? json["piquant"] : throw FormatException('Missing required property')),
        registration: (json.containsKey("registration") ? json["registration"] : throw FormatException('Missing required property')),
        remancipation: (json.containsKey("remancipation") ? json["remancipation"] : throw FormatException('Missing required property')),
        scutatiform: (json.containsKey("scutatiform") ? json["scutatiform"] : throw FormatException('Missing required property')),
        theodolite: (json.containsKey("theodolite") ? json["theodolite"] : throw FormatException('Missing required property')),
        underward: (json.containsKey("underward") ? json["underward"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "azorubine": azorubine,
        "choroiditis": choroiditis,
        "coagulatory": coagulatory,
        "cyclorama": cyclorama,
        "Dolphus": dolphus,
        "duckhearted": duckhearted,
        "Ficus": ficus,
        "Gemaric": gemaric,
        "jugation": jugation,
        "myoliposis": myoliposis,
        "nonnomination": nonnomination,
        "palay": palay,
        "pentactinal": pentactinal,
        "Phaet": phaet,
        "piquant": piquant,
        "registration": registration,
        "remancipation": remancipation,
        "scutatiform": scutatiform,
        "theodolite": theodolite,
        "underward": underward,
    };
}
