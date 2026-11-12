// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    List<dynamic> abranchiata;
    List<dynamic> academe;
    List<dynamic> acquirable;
    List<dynamic> aerometry;
    List<dynamic> alexin;
    List<dynamic> alleviate;
    List<dynamic> amaas;
    List<dynamic> ambassage;
    List<Amphithyron?> amphithyron;
    List<String?> andriana;
    List<dynamic> ankee;
    List<Map<String, int?>?> annihilator;
    dynamic annulose;
    List<dynamic> ansarie;
    List<dynamic> aphasia;
    List<dynamic> asprawl;
    List<bool?> attractive;
    Map<String, int> barksome;
    List<dynamic> bedesman;
    List<dynamic> belard;
    List<dynamic> bocking;
    List<dynamic> brawlingly;
    List<dynamic> brookie;
    List<dynamic> bumboatman;
    List<dynamic> bystreet;
    List<dynamic> calaverite;
    List<dynamic> catallactic;
    List<dynamic> cemental;
    List<dynamic> chytridiaceae;
    List<dynamic> discordia;
    List<dynamic> endomyces;
    List<dynamic> epinephelidae;
    List<dynamic> eupatorium;
    List<dynamic> gryphosaurus;
    List<dynamic> koryak;
    List<dynamic> lavinia;
    List<dynamic> oskar;
    List<dynamic> rebecca;
    List<dynamic> rhomboganoidei;
    bool rigsmal;
    List<dynamic> ruellia;
    List<dynamic> school;
    List<dynamic> shakespearolater;
    List<double> svan;
    Map<String, double> wayao;

    TopLevel({
        required this.abranchiata,
        required this.academe,
        required this.acquirable,
        required this.aerometry,
        required this.alexin,
        required this.alleviate,
        required this.amaas,
        required this.ambassage,
        required this.amphithyron,
        required this.andriana,
        required this.ankee,
        required this.annihilator,
        required this.annulose,
        required this.ansarie,
        required this.aphasia,
        required this.asprawl,
        required this.attractive,
        required this.barksome,
        required this.bedesman,
        required this.belard,
        required this.bocking,
        required this.brawlingly,
        required this.brookie,
        required this.bumboatman,
        required this.bystreet,
        required this.calaverite,
        required this.catallactic,
        required this.cemental,
        required this.chytridiaceae,
        required this.discordia,
        required this.endomyces,
        required this.epinephelidae,
        required this.eupatorium,
        required this.gryphosaurus,
        required this.koryak,
        required this.lavinia,
        required this.oskar,
        required this.rebecca,
        required this.rhomboganoidei,
        required this.rigsmal,
        required this.ruellia,
        required this.school,
        required this.shakespearolater,
        required this.svan,
        required this.wayao,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        abranchiata: List<dynamic>.from(json["Abranchiata"].map((x) => x)),
        academe: List<dynamic>.from(json["academe"].map((x) => x)),
        acquirable: List<dynamic>.from(json["acquirable"].map((x) => x)),
        aerometry: List<dynamic>.from(json["aerometry"].map((x) => x)),
        alexin: List<dynamic>.from(json["alexin"].map((x) => x)),
        alleviate: List<dynamic>.from(json["alleviate"].map((x) => x)),
        amaas: List<dynamic>.from(json["amaas"].map((x) => x)),
        ambassage: List<dynamic>.from(json["ambassage"].map((x) => x)),
        amphithyron: List<Amphithyron?>.from(json["amphithyron"].map((x) => x == null ? null : Amphithyron.fromJson(x))),
        andriana: List<String?>.from(json["Andriana"].map((x) => x)),
        ankee: List<dynamic>.from(json["ankee"].map((x) => x)),
        annihilator: List<Map<String, int?>?>.from(json["annihilator"].map((x) => x == null ? null : Map.from(x!).map((k, v) => MapEntry<String, int?>(k, v)))),
        annulose: (json.containsKey("annulose") ? json["annulose"] : throw FormatException('Missing required property')),
        ansarie: List<dynamic>.from(json["Ansarie"].map((x) => x)),
        aphasia: List<dynamic>.from(json["aphasia"].map((x) => x)),
        asprawl: List<dynamic>.from(json["asprawl"].map((x) => x)),
        attractive: List<bool?>.from(json["attractive"].map((x) => x)),
        barksome: Map.from(json["barksome"]).map((k, v) => MapEntry<String, int>(k, v)),
        bedesman: List<dynamic>.from(json["bedesman"].map((x) => x)),
        belard: List<dynamic>.from(json["belard"].map((x) => x)),
        bocking: List<dynamic>.from(json["bocking"].map((x) => x)),
        brawlingly: List<dynamic>.from(json["brawlingly"].map((x) => x)),
        brookie: List<dynamic>.from(json["brookie"].map((x) => x)),
        bumboatman: List<dynamic>.from(json["bumboatman"].map((x) => x)),
        bystreet: List<dynamic>.from(json["bystreet"].map((x) => x)),
        calaverite: List<dynamic>.from(json["calaverite"].map((x) => x)),
        catallactic: List<dynamic>.from(json["catallactic"].map((x) => x)),
        cemental: List<dynamic>.from(json["cemental"].map((x) => x)),
        chytridiaceae: List<dynamic>.from(json["Chytridiaceae"].map((x) => x)),
        discordia: List<dynamic>.from(json["Discordia"].map((x) => x)),
        endomyces: List<dynamic>.from(json["Endomyces"].map((x) => x)),
        epinephelidae: List<dynamic>.from(json["Epinephelidae"].map((x) => x)),
        eupatorium: List<dynamic>.from(json["Eupatorium"].map((x) => x)),
        gryphosaurus: List<dynamic>.from(json["Gryphosaurus"].map((x) => x)),
        koryak: List<dynamic>.from(json["Koryak"].map((x) => x)),
        lavinia: List<dynamic>.from(json["Lavinia"].map((x) => x)),
        oskar: List<dynamic>.from(json["Oskar"].map((x) => x)),
        rebecca: List<dynamic>.from(json["Rebecca"].map((x) => x)),
        rhomboganoidei: List<dynamic>.from(json["Rhomboganoidei"].map((x) => x)),
        rigsmal: json["Rigsmal"],
        ruellia: List<dynamic>.from(json["Ruellia"].map((x) => x)),
        school: List<dynamic>.from(json["School"].map((x) => x)),
        shakespearolater: List<dynamic>.from(json["Shakespearolater"].map((x) => x)),
        svan: List<double>.from(json["Svan"].map((x) => x?.toDouble())),
        wayao: Map.from(json["Wayao"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "Abranchiata": List<dynamic>.from(abranchiata.map((x) => x)),
        "academe": List<dynamic>.from(academe.map((x) => x)),
        "acquirable": List<dynamic>.from(acquirable.map((x) => x)),
        "aerometry": List<dynamic>.from(aerometry.map((x) => x)),
        "alexin": List<dynamic>.from(alexin.map((x) => x)),
        "alleviate": List<dynamic>.from(alleviate.map((x) => x)),
        "amaas": List<dynamic>.from(amaas.map((x) => x)),
        "ambassage": List<dynamic>.from(ambassage.map((x) => x)),
        "amphithyron": List<dynamic>.from(amphithyron.map((x) => x?.toJson())),
        "Andriana": List<dynamic>.from(andriana.map((x) => x)),
        "ankee": List<dynamic>.from(ankee.map((x) => x)),
        "annihilator": List<dynamic>.from(annihilator.map((x) => x == null ? null : Map.from(x!).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "annulose": annulose,
        "Ansarie": List<dynamic>.from(ansarie.map((x) => x)),
        "aphasia": List<dynamic>.from(aphasia.map((x) => x)),
        "asprawl": List<dynamic>.from(asprawl.map((x) => x)),
        "attractive": List<dynamic>.from(attractive.map((x) => x)),
        "barksome": Map.from(barksome).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "bedesman": List<dynamic>.from(bedesman.map((x) => x)),
        "belard": List<dynamic>.from(belard.map((x) => x)),
        "bocking": List<dynamic>.from(bocking.map((x) => x)),
        "brawlingly": List<dynamic>.from(brawlingly.map((x) => x)),
        "brookie": List<dynamic>.from(brookie.map((x) => x)),
        "bumboatman": List<dynamic>.from(bumboatman.map((x) => x)),
        "bystreet": List<dynamic>.from(bystreet.map((x) => x)),
        "calaverite": List<dynamic>.from(calaverite.map((x) => x)),
        "catallactic": List<dynamic>.from(catallactic.map((x) => x)),
        "cemental": List<dynamic>.from(cemental.map((x) => x)),
        "Chytridiaceae": List<dynamic>.from(chytridiaceae.map((x) => x)),
        "Discordia": List<dynamic>.from(discordia.map((x) => x)),
        "Endomyces": List<dynamic>.from(endomyces.map((x) => x)),
        "Epinephelidae": List<dynamic>.from(epinephelidae.map((x) => x)),
        "Eupatorium": List<dynamic>.from(eupatorium.map((x) => x)),
        "Gryphosaurus": List<dynamic>.from(gryphosaurus.map((x) => x)),
        "Koryak": List<dynamic>.from(koryak.map((x) => x)),
        "Lavinia": List<dynamic>.from(lavinia.map((x) => x)),
        "Oskar": List<dynamic>.from(oskar.map((x) => x)),
        "Rebecca": List<dynamic>.from(rebecca.map((x) => x)),
        "Rhomboganoidei": List<dynamic>.from(rhomboganoidei.map((x) => x)),
        "Rigsmal": rigsmal,
        "Ruellia": List<dynamic>.from(ruellia.map((x) => x)),
        "School": List<dynamic>.from(school.map((x) => x)),
        "Shakespearolater": List<dynamic>.from(shakespearolater.map((x) => x)),
        "Svan": List<dynamic>.from(svan.map((x) => x)),
        "Wayao": Map.from(wayao).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class AlleviateClass {
    dynamic apriori;
    dynamic beggarer;
    dynamic brokenheartedly;
    dynamic debilitation;
    dynamic frike;
    dynamic gastrolith;
    dynamic hulsean;
    dynamic orthocentric;
    dynamic petaly;
    dynamic probudgeting;
    dynamic reacquire;
    dynamic scow;
    dynamic shutoff;
    dynamic subcontiguous;
    dynamic suffumigate;
    dynamic transformable;
    dynamic uncoroneted;
    dynamic unparking;
    dynamic unvarnishedness;
    dynamic wherewithal;

    AlleviateClass({
        required this.apriori,
        required this.beggarer,
        required this.brokenheartedly,
        required this.debilitation,
        required this.frike,
        required this.gastrolith,
        required this.hulsean,
        required this.orthocentric,
        required this.petaly,
        required this.probudgeting,
        required this.reacquire,
        required this.scow,
        required this.shutoff,
        required this.subcontiguous,
        required this.suffumigate,
        required this.transformable,
        required this.uncoroneted,
        required this.unparking,
        required this.unvarnishedness,
        required this.wherewithal,
    });

    factory AlleviateClass.fromJson(Map<String, dynamic> json) => AlleviateClass(
        apriori: (json.containsKey("apriori") ? json["apriori"] : throw FormatException('Missing required property')),
        beggarer: (json.containsKey("beggarer") ? json["beggarer"] : throw FormatException('Missing required property')),
        brokenheartedly: (json.containsKey("brokenheartedly") ? json["brokenheartedly"] : throw FormatException('Missing required property')),
        debilitation: (json.containsKey("debilitation") ? json["debilitation"] : throw FormatException('Missing required property')),
        frike: (json.containsKey("frike") ? json["frike"] : throw FormatException('Missing required property')),
        gastrolith: (json.containsKey("gastrolith") ? json["gastrolith"] : throw FormatException('Missing required property')),
        hulsean: (json.containsKey("Hulsean") ? json["Hulsean"] : throw FormatException('Missing required property')),
        orthocentric: (json.containsKey("orthocentric") ? json["orthocentric"] : throw FormatException('Missing required property')),
        petaly: (json.containsKey("petaly") ? json["petaly"] : throw FormatException('Missing required property')),
        probudgeting: (json.containsKey("probudgeting") ? json["probudgeting"] : throw FormatException('Missing required property')),
        reacquire: (json.containsKey("reacquire") ? json["reacquire"] : throw FormatException('Missing required property')),
        scow: (json.containsKey("scow") ? json["scow"] : throw FormatException('Missing required property')),
        shutoff: (json.containsKey("shutoff") ? json["shutoff"] : throw FormatException('Missing required property')),
        subcontiguous: (json.containsKey("subcontiguous") ? json["subcontiguous"] : throw FormatException('Missing required property')),
        suffumigate: (json.containsKey("suffumigate") ? json["suffumigate"] : throw FormatException('Missing required property')),
        transformable: (json.containsKey("transformable") ? json["transformable"] : throw FormatException('Missing required property')),
        uncoroneted: (json.containsKey("uncoroneted") ? json["uncoroneted"] : throw FormatException('Missing required property')),
        unparking: (json.containsKey("unparking") ? json["unparking"] : throw FormatException('Missing required property')),
        unvarnishedness: (json.containsKey("unvarnishedness") ? json["unvarnishedness"] : throw FormatException('Missing required property')),
        wherewithal: (json.containsKey("wherewithal") ? json["wherewithal"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "apriori": apriori,
        "beggarer": beggarer,
        "brokenheartedly": brokenheartedly,
        "debilitation": debilitation,
        "frike": frike,
        "gastrolith": gastrolith,
        "Hulsean": hulsean,
        "orthocentric": orthocentric,
        "petaly": petaly,
        "probudgeting": probudgeting,
        "reacquire": reacquire,
        "scow": scow,
        "shutoff": shutoff,
        "subcontiguous": subcontiguous,
        "suffumigate": suffumigate,
        "transformable": transformable,
        "uncoroneted": uncoroneted,
        "unparking": unparking,
        "unvarnishedness": unvarnishedness,
        "wherewithal": wherewithal,
    };
}

class Rebecca {
    double catharticalness;
    int chirotherium;
    String disdiapason;
    bool homocerc;
    dynamic nonbookish;

    Rebecca({
        required this.catharticalness,
        required this.chirotherium,
        required this.disdiapason,
        required this.homocerc,
        required this.nonbookish,
    });

    factory Rebecca.fromJson(Map<String, dynamic> json) => Rebecca(
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

class Amphithyron {
    int? akroasis;
    int? antiphonical;
    int? basebred;
    double? catharticalness;
    int? chirotherium;
    int? conductometric;
    String? disdiapason;
    int? ensilation;
    int? eyebolt;
    int? fistulated;
    int? heteropod;
    bool? homocerc;
    int? juniperus;
    int? labyrinthically;
    int? martyrization;
    int? mispolicy;
    int? multipara;
    int? nazirite;
    dynamic nonbookish;
    int? possessorial;
    int? shamed;
    int? shelfworn;
    int? stagnum;
    int? those;
    int? undecimal;

    Amphithyron({
        this.akroasis,
        this.antiphonical,
        this.basebred,
        this.catharticalness,
        this.chirotherium,
        this.conductometric,
        this.disdiapason,
        this.ensilation,
        this.eyebolt,
        this.fistulated,
        this.heteropod,
        this.homocerc,
        this.juniperus,
        this.labyrinthically,
        this.martyrization,
        this.mispolicy,
        this.multipara,
        this.nazirite,
        this.nonbookish,
        this.possessorial,
        this.shamed,
        this.shelfworn,
        this.stagnum,
        this.those,
        this.undecimal,
    });

    factory Amphithyron.fromJson(Map<String, dynamic> json) => Amphithyron(
        akroasis: json["akroasis"],
        antiphonical: json["antiphonical"],
        basebred: json["basebred"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        conductometric: json["conductometric"],
        disdiapason: json["disdiapason"],
        ensilation: json["ensilation"],
        eyebolt: json["eyebolt"],
        fistulated: json["fistulated"],
        heteropod: json["heteropod"],
        homocerc: json["homocerc"],
        juniperus: json["Juniperus"],
        labyrinthically: json["labyrinthically"],
        martyrization: json["martyrization"],
        mispolicy: json["mispolicy"],
        multipara: json["multipara"],
        nazirite: json["Nazirite"],
        nonbookish: json["nonbookish"],
        possessorial: json["possessorial"],
        shamed: json["shamed"],
        shelfworn: json["shelfworn"],
        stagnum: json["stagnum"],
        those: json["Those"],
        undecimal: json["undecimal"],
    );

    Map<String, dynamic> toJson() => {
        "akroasis": akroasis,
        "antiphonical": antiphonical,
        "basebred": basebred,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "conductometric": conductometric,
        "disdiapason": disdiapason,
        "ensilation": ensilation,
        "eyebolt": eyebolt,
        "fistulated": fistulated,
        "heteropod": heteropod,
        "homocerc": homocerc,
        "Juniperus": juniperus,
        "labyrinthically": labyrinthically,
        "martyrization": martyrization,
        "mispolicy": mispolicy,
        "multipara": multipara,
        "Nazirite": nazirite,
        "nonbookish": nonbookish,
        "possessorial": possessorial,
        "shamed": shamed,
        "shelfworn": shelfworn,
        "stagnum": stagnum,
        "Those": those,
        "undecimal": undecimal,
    };
}

class AnkeeClass {
    dynamic anomoean;
    dynamic barleyhood;
    dynamic befriender;
    dynamic brutishness;
    dynamic cephalalgy;
    dynamic cirurgian;
    dynamic conventionally;
    dynamic jackshay;
    dynamic milammeter;
    dynamic naja;
    dynamic ombrological;
    dynamic phonasthenia;
    dynamic retrievableness;
    dynamic snakily;
    dynamic swot;
    dynamic tartlet;
    dynamic thiofuran;
    dynamic tracheophone;
    dynamic tuglike;
    dynamic unscratchingly;

    AnkeeClass({
        required this.anomoean,
        required this.barleyhood,
        required this.befriender,
        required this.brutishness,
        required this.cephalalgy,
        required this.cirurgian,
        required this.conventionally,
        required this.jackshay,
        required this.milammeter,
        required this.naja,
        required this.ombrological,
        required this.phonasthenia,
        required this.retrievableness,
        required this.snakily,
        required this.swot,
        required this.tartlet,
        required this.thiofuran,
        required this.tracheophone,
        required this.tuglike,
        required this.unscratchingly,
    });

    factory AnkeeClass.fromJson(Map<String, dynamic> json) => AnkeeClass(
        anomoean: (json.containsKey("Anomoean") ? json["Anomoean"] : throw FormatException('Missing required property')),
        barleyhood: (json.containsKey("barleyhood") ? json["barleyhood"] : throw FormatException('Missing required property')),
        befriender: (json.containsKey("befriender") ? json["befriender"] : throw FormatException('Missing required property')),
        brutishness: (json.containsKey("brutishness") ? json["brutishness"] : throw FormatException('Missing required property')),
        cephalalgy: (json.containsKey("cephalalgy") ? json["cephalalgy"] : throw FormatException('Missing required property')),
        cirurgian: (json.containsKey("cirurgian") ? json["cirurgian"] : throw FormatException('Missing required property')),
        conventionally: (json.containsKey("conventionally") ? json["conventionally"] : throw FormatException('Missing required property')),
        jackshay: (json.containsKey("jackshay") ? json["jackshay"] : throw FormatException('Missing required property')),
        milammeter: (json.containsKey("milammeter") ? json["milammeter"] : throw FormatException('Missing required property')),
        naja: (json.containsKey("Naja") ? json["Naja"] : throw FormatException('Missing required property')),
        ombrological: (json.containsKey("ombrological") ? json["ombrological"] : throw FormatException('Missing required property')),
        phonasthenia: (json.containsKey("phonasthenia") ? json["phonasthenia"] : throw FormatException('Missing required property')),
        retrievableness: (json.containsKey("retrievableness") ? json["retrievableness"] : throw FormatException('Missing required property')),
        snakily: (json.containsKey("snakily") ? json["snakily"] : throw FormatException('Missing required property')),
        swot: (json.containsKey("swot") ? json["swot"] : throw FormatException('Missing required property')),
        tartlet: (json.containsKey("tartlet") ? json["tartlet"] : throw FormatException('Missing required property')),
        thiofuran: (json.containsKey("thiofuran") ? json["thiofuran"] : throw FormatException('Missing required property')),
        tracheophone: (json.containsKey("tracheophone") ? json["tracheophone"] : throw FormatException('Missing required property')),
        tuglike: (json.containsKey("tuglike") ? json["tuglike"] : throw FormatException('Missing required property')),
        unscratchingly: (json.containsKey("unscratchingly") ? json["unscratchingly"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Anomoean": anomoean,
        "barleyhood": barleyhood,
        "befriender": befriender,
        "brutishness": brutishness,
        "cephalalgy": cephalalgy,
        "cirurgian": cirurgian,
        "conventionally": conventionally,
        "jackshay": jackshay,
        "milammeter": milammeter,
        "Naja": naja,
        "ombrological": ombrological,
        "phonasthenia": phonasthenia,
        "retrievableness": retrievableness,
        "snakily": snakily,
        "swot": swot,
        "tartlet": tartlet,
        "thiofuran": thiofuran,
        "tracheophone": tracheophone,
        "tuglike": tuglike,
        "unscratchingly": unscratchingly,
    };
}

class AnsarieClass {
    dynamic accension;
    dynamic alida;
    dynamic asteria;
    dynamic beriberic;
    dynamic edgebone;
    dynamic gastrodialysis;
    dynamic geographic;
    dynamic ictonyx;
    dynamic metrocele;
    dynamic misgraft;
    dynamic monteith;
    dynamic notcher;
    dynamic prorestriction;
    dynamic ramist;
    dynamic throatlet;
    dynamic unfair;
    dynamic unsynonymous;
    dynamic water;
    dynamic zestfully;
    dynamic zincic;

    AnsarieClass({
        required this.accension,
        required this.alida,
        required this.asteria,
        required this.beriberic,
        required this.edgebone,
        required this.gastrodialysis,
        required this.geographic,
        required this.ictonyx,
        required this.metrocele,
        required this.misgraft,
        required this.monteith,
        required this.notcher,
        required this.prorestriction,
        required this.ramist,
        required this.throatlet,
        required this.unfair,
        required this.unsynonymous,
        required this.water,
        required this.zestfully,
        required this.zincic,
    });

    factory AnsarieClass.fromJson(Map<String, dynamic> json) => AnsarieClass(
        accension: (json.containsKey("accension") ? json["accension"] : throw FormatException('Missing required property')),
        alida: (json.containsKey("Alida") ? json["Alida"] : throw FormatException('Missing required property')),
        asteria: (json.containsKey("asteria") ? json["asteria"] : throw FormatException('Missing required property')),
        beriberic: (json.containsKey("beriberic") ? json["beriberic"] : throw FormatException('Missing required property')),
        edgebone: (json.containsKey("edgebone") ? json["edgebone"] : throw FormatException('Missing required property')),
        gastrodialysis: (json.containsKey("gastrodialysis") ? json["gastrodialysis"] : throw FormatException('Missing required property')),
        geographic: (json.containsKey("geographic") ? json["geographic"] : throw FormatException('Missing required property')),
        ictonyx: (json.containsKey("Ictonyx") ? json["Ictonyx"] : throw FormatException('Missing required property')),
        metrocele: (json.containsKey("metrocele") ? json["metrocele"] : throw FormatException('Missing required property')),
        misgraft: (json.containsKey("misgraft") ? json["misgraft"] : throw FormatException('Missing required property')),
        monteith: (json.containsKey("monteith") ? json["monteith"] : throw FormatException('Missing required property')),
        notcher: (json.containsKey("notcher") ? json["notcher"] : throw FormatException('Missing required property')),
        prorestriction: (json.containsKey("prorestriction") ? json["prorestriction"] : throw FormatException('Missing required property')),
        ramist: (json.containsKey("Ramist") ? json["Ramist"] : throw FormatException('Missing required property')),
        throatlet: (json.containsKey("throatlet") ? json["throatlet"] : throw FormatException('Missing required property')),
        unfair: (json.containsKey("unfair") ? json["unfair"] : throw FormatException('Missing required property')),
        unsynonymous: (json.containsKey("unsynonymous") ? json["unsynonymous"] : throw FormatException('Missing required property')),
        water: (json.containsKey("water") ? json["water"] : throw FormatException('Missing required property')),
        zestfully: (json.containsKey("zestfully") ? json["zestfully"] : throw FormatException('Missing required property')),
        zincic: (json.containsKey("zincic") ? json["zincic"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "accension": accension,
        "Alida": alida,
        "asteria": asteria,
        "beriberic": beriberic,
        "edgebone": edgebone,
        "gastrodialysis": gastrodialysis,
        "geographic": geographic,
        "Ictonyx": ictonyx,
        "metrocele": metrocele,
        "misgraft": misgraft,
        "monteith": monteith,
        "notcher": notcher,
        "prorestriction": prorestriction,
        "Ramist": ramist,
        "throatlet": throatlet,
        "unfair": unfair,
        "unsynonymous": unsynonymous,
        "water": water,
        "zestfully": zestfully,
        "zincic": zincic,
    };
}

class ChytridiaceaeClass {
    dynamic batidaceae;
    dynamic brechites;
    dynamic codespairer;
    dynamic emery;
    dynamic enervative;
    dynamic excriminate;
    dynamic goshenite;
    dynamic grime;
    dynamic gritten;
    dynamic hectorly;
    dynamic intermediation;
    dynamic meeterly;
    dynamic narraganset;
    dynamic onymatic;
    dynamic paddlecock;
    dynamic thana;
    dynamic thornily;
    dynamic uckia;
    dynamic unmettle;
    dynamic vorticellid;

    ChytridiaceaeClass({
        required this.batidaceae,
        required this.brechites,
        required this.codespairer,
        required this.emery,
        required this.enervative,
        required this.excriminate,
        required this.goshenite,
        required this.grime,
        required this.gritten,
        required this.hectorly,
        required this.intermediation,
        required this.meeterly,
        required this.narraganset,
        required this.onymatic,
        required this.paddlecock,
        required this.thana,
        required this.thornily,
        required this.uckia,
        required this.unmettle,
        required this.vorticellid,
    });

    factory ChytridiaceaeClass.fromJson(Map<String, dynamic> json) => ChytridiaceaeClass(
        batidaceae: (json.containsKey("Batidaceae") ? json["Batidaceae"] : throw FormatException('Missing required property')),
        brechites: (json.containsKey("Brechites") ? json["Brechites"] : throw FormatException('Missing required property')),
        codespairer: (json.containsKey("codespairer") ? json["codespairer"] : throw FormatException('Missing required property')),
        emery: (json.containsKey("Emery") ? json["Emery"] : throw FormatException('Missing required property')),
        enervative: (json.containsKey("enervative") ? json["enervative"] : throw FormatException('Missing required property')),
        excriminate: (json.containsKey("excriminate") ? json["excriminate"] : throw FormatException('Missing required property')),
        goshenite: (json.containsKey("goshenite") ? json["goshenite"] : throw FormatException('Missing required property')),
        grime: (json.containsKey("grime") ? json["grime"] : throw FormatException('Missing required property')),
        gritten: (json.containsKey("gritten") ? json["gritten"] : throw FormatException('Missing required property')),
        hectorly: (json.containsKey("hectorly") ? json["hectorly"] : throw FormatException('Missing required property')),
        intermediation: (json.containsKey("intermediation") ? json["intermediation"] : throw FormatException('Missing required property')),
        meeterly: (json.containsKey("meeterly") ? json["meeterly"] : throw FormatException('Missing required property')),
        narraganset: (json.containsKey("Narraganset") ? json["Narraganset"] : throw FormatException('Missing required property')),
        onymatic: (json.containsKey("onymatic") ? json["onymatic"] : throw FormatException('Missing required property')),
        paddlecock: (json.containsKey("paddlecock") ? json["paddlecock"] : throw FormatException('Missing required property')),
        thana: (json.containsKey("thana") ? json["thana"] : throw FormatException('Missing required property')),
        thornily: (json.containsKey("thornily") ? json["thornily"] : throw FormatException('Missing required property')),
        uckia: (json.containsKey("uckia") ? json["uckia"] : throw FormatException('Missing required property')),
        unmettle: (json.containsKey("unmettle") ? json["unmettle"] : throw FormatException('Missing required property')),
        vorticellid: (json.containsKey("vorticellid") ? json["vorticellid"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Batidaceae": batidaceae,
        "Brechites": brechites,
        "codespairer": codespairer,
        "Emery": emery,
        "enervative": enervative,
        "excriminate": excriminate,
        "goshenite": goshenite,
        "grime": grime,
        "gritten": gritten,
        "hectorly": hectorly,
        "intermediation": intermediation,
        "meeterly": meeterly,
        "Narraganset": narraganset,
        "onymatic": onymatic,
        "paddlecock": paddlecock,
        "thana": thana,
        "thornily": thornily,
        "uckia": uckia,
        "unmettle": unmettle,
        "vorticellid": vorticellid,
    };
}

class DiscordiaClass {
    int? altaic;
    int? amoristic;
    int? blennophthalmia;
    double? catharticalness;
    int? chirotherium;
    int? disciplinability;
    String? disdiapason;
    int? goofer;
    bool? homocerc;
    int? laryngograph;
    int? leucitis;
    int? lymphocyst;
    int? microcosmology;
    int? nauseation;
    dynamic nonbookish;
    int? patarin;
    int? preliberal;
    int? prettifier;
    int? rangework;
    int? redient;
    int? subfusiform;
    int? suicidical;
    int? swow;
    int? wastrel;
    int? wingle;

    DiscordiaClass({
        this.altaic,
        this.amoristic,
        this.blennophthalmia,
        this.catharticalness,
        this.chirotherium,
        this.disciplinability,
        this.disdiapason,
        this.goofer,
        this.homocerc,
        this.laryngograph,
        this.leucitis,
        this.lymphocyst,
        this.microcosmology,
        this.nauseation,
        this.nonbookish,
        this.patarin,
        this.preliberal,
        this.prettifier,
        this.rangework,
        this.redient,
        this.subfusiform,
        this.suicidical,
        this.swow,
        this.wastrel,
        this.wingle,
    });

    factory DiscordiaClass.fromJson(Map<String, dynamic> json) => DiscordiaClass(
        altaic: json["Altaic"],
        amoristic: json["amoristic"],
        blennophthalmia: json["blennophthalmia"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        disciplinability: json["disciplinability"],
        disdiapason: json["disdiapason"],
        goofer: json["goofer"],
        homocerc: json["homocerc"],
        laryngograph: json["laryngograph"],
        leucitis: json["leucitis"],
        lymphocyst: json["lymphocyst"],
        microcosmology: json["microcosmology"],
        nauseation: json["nauseation"],
        nonbookish: json["nonbookish"],
        patarin: json["Patarin"],
        preliberal: json["preliberal"],
        prettifier: json["prettifier"],
        rangework: json["rangework"],
        redient: json["redient"],
        subfusiform: json["subfusiform"],
        suicidical: json["suicidical"],
        swow: json["swow"],
        wastrel: json["wastrel"],
        wingle: json["wingle"],
    );

    Map<String, dynamic> toJson() => {
        "Altaic": altaic,
        "amoristic": amoristic,
        "blennophthalmia": blennophthalmia,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "disciplinability": disciplinability,
        "disdiapason": disdiapason,
        "goofer": goofer,
        "homocerc": homocerc,
        "laryngograph": laryngograph,
        "leucitis": leucitis,
        "lymphocyst": lymphocyst,
        "microcosmology": microcosmology,
        "nauseation": nauseation,
        "nonbookish": nonbookish,
        "Patarin": patarin,
        "preliberal": preliberal,
        "prettifier": prettifier,
        "rangework": rangework,
        "redient": redient,
        "subfusiform": subfusiform,
        "suicidical": suicidical,
        "swow": swow,
        "wastrel": wastrel,
        "wingle": wingle,
    };
}

class GryphosaurusClass {
    dynamic amissibility;
    dynamic burushaski;
    dynamic citronin;
    dynamic coplaintiff;
    dynamic disquisitionary;
    dynamic enoplan;
    dynamic faintness;
    dynamic hebetomy;
    dynamic islandry;
    dynamic lameduck;
    dynamic overbattle;
    dynamic overinterested;
    dynamic phrenologic;
    dynamic rainband;
    dynamic shiningly;
    dynamic stamineous;
    dynamic subscapularis;
    dynamic tahami;
    dynamic undaubed;
    dynamic underntime;

    GryphosaurusClass({
        required this.amissibility,
        required this.burushaski,
        required this.citronin,
        required this.coplaintiff,
        required this.disquisitionary,
        required this.enoplan,
        required this.faintness,
        required this.hebetomy,
        required this.islandry,
        required this.lameduck,
        required this.overbattle,
        required this.overinterested,
        required this.phrenologic,
        required this.rainband,
        required this.shiningly,
        required this.stamineous,
        required this.subscapularis,
        required this.tahami,
        required this.undaubed,
        required this.underntime,
    });

    factory GryphosaurusClass.fromJson(Map<String, dynamic> json) => GryphosaurusClass(
        amissibility: (json.containsKey("amissibility") ? json["amissibility"] : throw FormatException('Missing required property')),
        burushaski: (json.containsKey("Burushaski") ? json["Burushaski"] : throw FormatException('Missing required property')),
        citronin: (json.containsKey("citronin") ? json["citronin"] : throw FormatException('Missing required property')),
        coplaintiff: (json.containsKey("coplaintiff") ? json["coplaintiff"] : throw FormatException('Missing required property')),
        disquisitionary: (json.containsKey("disquisitionary") ? json["disquisitionary"] : throw FormatException('Missing required property')),
        enoplan: (json.containsKey("enoplan") ? json["enoplan"] : throw FormatException('Missing required property')),
        faintness: (json.containsKey("faintness") ? json["faintness"] : throw FormatException('Missing required property')),
        hebetomy: (json.containsKey("hebetomy") ? json["hebetomy"] : throw FormatException('Missing required property')),
        islandry: (json.containsKey("islandry") ? json["islandry"] : throw FormatException('Missing required property')),
        lameduck: (json.containsKey("lameduck") ? json["lameduck"] : throw FormatException('Missing required property')),
        overbattle: (json.containsKey("overbattle") ? json["overbattle"] : throw FormatException('Missing required property')),
        overinterested: (json.containsKey("overinterested") ? json["overinterested"] : throw FormatException('Missing required property')),
        phrenologic: (json.containsKey("phrenologic") ? json["phrenologic"] : throw FormatException('Missing required property')),
        rainband: (json.containsKey("rainband") ? json["rainband"] : throw FormatException('Missing required property')),
        shiningly: (json.containsKey("shiningly") ? json["shiningly"] : throw FormatException('Missing required property')),
        stamineous: (json.containsKey("stamineous") ? json["stamineous"] : throw FormatException('Missing required property')),
        subscapularis: (json.containsKey("subscapularis") ? json["subscapularis"] : throw FormatException('Missing required property')),
        tahami: (json.containsKey("Tahami") ? json["Tahami"] : throw FormatException('Missing required property')),
        undaubed: (json.containsKey("undaubed") ? json["undaubed"] : throw FormatException('Missing required property')),
        underntime: (json.containsKey("underntime") ? json["underntime"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "amissibility": amissibility,
        "Burushaski": burushaski,
        "citronin": citronin,
        "coplaintiff": coplaintiff,
        "disquisitionary": disquisitionary,
        "enoplan": enoplan,
        "faintness": faintness,
        "hebetomy": hebetomy,
        "islandry": islandry,
        "lameduck": lameduck,
        "overbattle": overbattle,
        "overinterested": overinterested,
        "phrenologic": phrenologic,
        "rainband": rainband,
        "shiningly": shiningly,
        "stamineous": stamineous,
        "subscapularis": subscapularis,
        "Tahami": tahami,
        "undaubed": undaubed,
        "underntime": underntime,
    };
}

class LaviniaClass {
    int? agitable;
    int? asininity;
    int? benefiter;
    int? bronzelike;
    double? catharticalness;
    int? chirotherium;
    int? cholesteatomatous;
    int? deprivement;
    String? disdiapason;
    int? flippantness;
    int? fogproof;
    bool? homocerc;
    int? merrymeeting;
    dynamic nonbookish;
    int? overcareful;
    int? panaris;
    int? preacceptance;
    int? quinoxaline;
    int? sig;
    int? superconfusion;
    int? tacana;
    int? tillotter;
    int? tranquillize;
    int? unquestionable;
    int? uproute;

    LaviniaClass({
        this.agitable,
        this.asininity,
        this.benefiter,
        this.bronzelike,
        this.catharticalness,
        this.chirotherium,
        this.cholesteatomatous,
        this.deprivement,
        this.disdiapason,
        this.flippantness,
        this.fogproof,
        this.homocerc,
        this.merrymeeting,
        this.nonbookish,
        this.overcareful,
        this.panaris,
        this.preacceptance,
        this.quinoxaline,
        this.sig,
        this.superconfusion,
        this.tacana,
        this.tillotter,
        this.tranquillize,
        this.unquestionable,
        this.uproute,
    });

    factory LaviniaClass.fromJson(Map<String, dynamic> json) => LaviniaClass(
        agitable: json["agitable"],
        asininity: json["asininity"],
        benefiter: json["benefiter"],
        bronzelike: json["bronzelike"],
        catharticalness: json["catharticalness"]?.toDouble(),
        chirotherium: json["Chirotherium"],
        cholesteatomatous: json["cholesteatomatous"],
        deprivement: json["deprivement"],
        disdiapason: json["disdiapason"],
        flippantness: json["flippantness"],
        fogproof: json["fogproof"],
        homocerc: json["homocerc"],
        merrymeeting: json["merrymeeting"],
        nonbookish: json["nonbookish"],
        overcareful: json["overcareful"],
        panaris: json["panaris"],
        preacceptance: json["preacceptance"],
        quinoxaline: json["quinoxaline"],
        sig: json["sig"],
        superconfusion: json["superconfusion"],
        tacana: json["Tacana"],
        tillotter: json["tillotter"],
        tranquillize: json["tranquillize"],
        unquestionable: json["unquestionable"],
        uproute: json["uproute"],
    );

    Map<String, dynamic> toJson() => {
        "agitable": agitable,
        "asininity": asininity,
        "benefiter": benefiter,
        "bronzelike": bronzelike,
        "catharticalness": catharticalness,
        "Chirotherium": chirotherium,
        "cholesteatomatous": cholesteatomatous,
        "deprivement": deprivement,
        "disdiapason": disdiapason,
        "flippantness": flippantness,
        "fogproof": fogproof,
        "homocerc": homocerc,
        "merrymeeting": merrymeeting,
        "nonbookish": nonbookish,
        "overcareful": overcareful,
        "panaris": panaris,
        "preacceptance": preacceptance,
        "quinoxaline": quinoxaline,
        "sig": sig,
        "superconfusion": superconfusion,
        "Tacana": tacana,
        "tillotter": tillotter,
        "tranquillize": tranquillize,
        "unquestionable": unquestionable,
        "uproute": uproute,
    };
}

class OskarClass {
    dynamic acrobates;
    dynamic beanshooter;
    dynamic bearhound;
    dynamic cayuga;
    dynamic guarneri;
    dynamic hypochondriacism;
    dynamic indication;
    dynamic jaculative;
    dynamic nagana;
    dynamic netherlandish;
    dynamic noctivagous;
    dynamic nonphysiological;
    dynamic praxis;
    dynamic provision;
    dynamic subterhuman;
    dynamic sunlit;
    dynamic syncraniate;
    dynamic teachment;
    dynamic unmutinous;
    dynamic unstoppable;

    OskarClass({
        required this.acrobates,
        required this.beanshooter,
        required this.bearhound,
        required this.cayuga,
        required this.guarneri,
        required this.hypochondriacism,
        required this.indication,
        required this.jaculative,
        required this.nagana,
        required this.netherlandish,
        required this.noctivagous,
        required this.nonphysiological,
        required this.praxis,
        required this.provision,
        required this.subterhuman,
        required this.sunlit,
        required this.syncraniate,
        required this.teachment,
        required this.unmutinous,
        required this.unstoppable,
    });

    factory OskarClass.fromJson(Map<String, dynamic> json) => OskarClass(
        acrobates: (json.containsKey("Acrobates") ? json["Acrobates"] : throw FormatException('Missing required property')),
        beanshooter: (json.containsKey("beanshooter") ? json["beanshooter"] : throw FormatException('Missing required property')),
        bearhound: (json.containsKey("bearhound") ? json["bearhound"] : throw FormatException('Missing required property')),
        cayuga: (json.containsKey("Cayuga") ? json["Cayuga"] : throw FormatException('Missing required property')),
        guarneri: (json.containsKey("guarneri") ? json["guarneri"] : throw FormatException('Missing required property')),
        hypochondriacism: (json.containsKey("hypochondriacism") ? json["hypochondriacism"] : throw FormatException('Missing required property')),
        indication: (json.containsKey("indication") ? json["indication"] : throw FormatException('Missing required property')),
        jaculative: (json.containsKey("jaculative") ? json["jaculative"] : throw FormatException('Missing required property')),
        nagana: (json.containsKey("nagana") ? json["nagana"] : throw FormatException('Missing required property')),
        netherlandish: (json.containsKey("Netherlandish") ? json["Netherlandish"] : throw FormatException('Missing required property')),
        noctivagous: (json.containsKey("noctivagous") ? json["noctivagous"] : throw FormatException('Missing required property')),
        nonphysiological: (json.containsKey("nonphysiological") ? json["nonphysiological"] : throw FormatException('Missing required property')),
        praxis: (json.containsKey("praxis") ? json["praxis"] : throw FormatException('Missing required property')),
        provision: (json.containsKey("provision") ? json["provision"] : throw FormatException('Missing required property')),
        subterhuman: (json.containsKey("subterhuman") ? json["subterhuman"] : throw FormatException('Missing required property')),
        sunlit: (json.containsKey("sunlit") ? json["sunlit"] : throw FormatException('Missing required property')),
        syncraniate: (json.containsKey("syncraniate") ? json["syncraniate"] : throw FormatException('Missing required property')),
        teachment: (json.containsKey("teachment") ? json["teachment"] : throw FormatException('Missing required property')),
        unmutinous: (json.containsKey("unmutinous") ? json["unmutinous"] : throw FormatException('Missing required property')),
        unstoppable: (json.containsKey("unstoppable") ? json["unstoppable"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "Acrobates": acrobates,
        "beanshooter": beanshooter,
        "bearhound": bearhound,
        "Cayuga": cayuga,
        "guarneri": guarneri,
        "hypochondriacism": hypochondriacism,
        "indication": indication,
        "jaculative": jaculative,
        "nagana": nagana,
        "Netherlandish": netherlandish,
        "noctivagous": noctivagous,
        "nonphysiological": nonphysiological,
        "praxis": praxis,
        "provision": provision,
        "subterhuman": subterhuman,
        "sunlit": sunlit,
        "syncraniate": syncraniate,
        "teachment": teachment,
        "unmutinous": unmutinous,
        "unstoppable": unstoppable,
    };
}
