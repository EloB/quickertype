// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<dynamic> topLevelFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String topLevelToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class TopLevelElement {
    final int alienlevel;
    final Breed breed;
    final int charDimension;
    final int charInstance;
    final String defenderRankTitle;
    final Firstname firstname;
    final int headid;
    final Lastname lastname;
    final int levelx;
    final String name;
    final String prof;
    final String profTitle;
    final int pvprating;
    final Pvptitle pvptitle;
    final int rank;
    final RankTitle rankTitle;
    final Sex sex;

    TopLevelElement({
        required this.alienlevel,
        required this.breed,
        required this.charDimension,
        required this.charInstance,
        required this.defenderRankTitle,
        required this.firstname,
        required this.headid,
        required this.lastname,
        required this.levelx,
        required this.name,
        required this.prof,
        required this.profTitle,
        required this.pvprating,
        required this.pvptitle,
        required this.rank,
        required this.rankTitle,
        required this.sex,
    });

    factory TopLevelElement.fromJson(Map<String, dynamic> json) => TopLevelElement(
        alienlevel: json["ALIENLEVEL"],
        breed: breedValues.map[json["BREED"]]!,
        charDimension: json["CHAR_DIMENSION"],
        charInstance: json["CHAR_INSTANCE"],
        defenderRankTitle: json["DEFENDER_RANK_TITLE"],
        firstname: firstnameValues.map[json["FIRSTNAME"]]!,
        headid: json["HEADID"],
        lastname: lastnameValues.map[json["LASTNAME"]]!,
        levelx: json["LEVELX"],
        name: json["NAME"],
        prof: json["PROF"],
        profTitle: json["PROF_TITLE"],
        pvprating: json["PVPRATING"],
        pvptitle: pvptitleValues.map[json["PVPTITLE"]]!,
        rank: json["RANK"],
        rankTitle: rankTitleValues.map[json["RANK_TITLE"]]!,
        sex: sexValues.map[json["SEX"]]!,
    );

    Map<String, dynamic> toJson() => {
        "ALIENLEVEL": alienlevel,
        "BREED": breedValues.reverse[breed],
        "CHAR_DIMENSION": charDimension,
        "CHAR_INSTANCE": charInstance,
        "DEFENDER_RANK_TITLE": defenderRankTitle,
        "FIRSTNAME": firstnameValues.reverse[firstname],
        "HEADID": headid,
        "LASTNAME": lastnameValues.reverse[lastname],
        "LEVELX": levelx,
        "NAME": name,
        "PROF": prof,
        "PROF_TITLE": profTitle,
        "PVPRATING": pvprating,
        "PVPTITLE": pvptitleValues.reverse[pvptitle],
        "RANK": rank,
        "RANK_TITLE": rankTitleValues.reverse[rankTitle],
        "SEX": sexValues.reverse[sex],
    };
}

enum Breed {
    ATROX,
    SOLITUS,
    OPIFEX,
    NANO
}

final breedValues = EnumValues({
    "Atrox": Breed.ATROX,
    "Solitus": Breed.SOLITUS,
    "Opifex": Breed.OPIFEX,
    "Nano": Breed.NANO
});

enum Firstname {
    EMPTY,
    CHI
}

final firstnameValues = EnumValues({
    "": Firstname.EMPTY,
    "Chi": Firstname.CHI
});

enum Lastname {
    EMPTY,
    WASHKO
}

final lastnameValues = EnumValues({
    "": Lastname.EMPTY,
    "Washko": Lastname.WASHKO
});

enum Pvptitle {
    FRESHMAN
}

final pvptitleValues = EnumValues({
    "Freshman": Pvptitle.FRESHMAN
});

enum RankTitle {
    PRESIDENT,
    ADVISOR,
    VETERAN,
    APPLICANT
}

final rankTitleValues = EnumValues({
    "President": RankTitle.PRESIDENT,
    "Advisor": RankTitle.ADVISOR,
    "Veteran": RankTitle.VETERAN,
    "Applicant": RankTitle.APPLICANT
});

enum Sex {
    NEUTER,
    MALE,
    FEMALE
}

final sexValues = EnumValues({
    "Neuter": Sex.NEUTER,
    "Male": Sex.MALE,
    "Female": Sex.FEMALE
});

class PurpleTopLevel {
    final int adventurercount;
    final int agentcount;
    final int atroxcount;
    final double avglvl;
    final int btcount;
    final String description;
    final int doctorcount;
    final int enfcount;
    final int engineeercount;
    final int femalecount;
    final int fixercount;
    final String governingname;
    final String history;
    final int keepercount;
    final int macount;
    final int malecount;
    final int maxlvl;
    final int metacount;
    final int minlvl;
    final int monstercount;
    final String name;
    final int nanocount;
    final int nanoracecount;
    final int neutercount;
    final int nummembers;
    final String objective;
    final int opifexcount;
    final int orgDimension;
    final int orgInstance;
    final int shadecount;
    final int side;
    final String sideName;
    final int solidercount;
    final int solituscount;
    final int tradercount;

    PurpleTopLevel({
        required this.adventurercount,
        required this.agentcount,
        required this.atroxcount,
        required this.avglvl,
        required this.btcount,
        required this.description,
        required this.doctorcount,
        required this.enfcount,
        required this.engineeercount,
        required this.femalecount,
        required this.fixercount,
        required this.governingname,
        required this.history,
        required this.keepercount,
        required this.macount,
        required this.malecount,
        required this.maxlvl,
        required this.metacount,
        required this.minlvl,
        required this.monstercount,
        required this.name,
        required this.nanocount,
        required this.nanoracecount,
        required this.neutercount,
        required this.nummembers,
        required this.objective,
        required this.opifexcount,
        required this.orgDimension,
        required this.orgInstance,
        required this.shadecount,
        required this.side,
        required this.sideName,
        required this.solidercount,
        required this.solituscount,
        required this.tradercount,
    });

    factory PurpleTopLevel.fromJson(Map<String, dynamic> json) => PurpleTopLevel(
        adventurercount: json["ADVENTURERCOUNT"],
        agentcount: json["AGENTCOUNT"],
        atroxcount: json["ATROXCOUNT"],
        avglvl: json["AVGLVL"]?.toDouble(),
        btcount: json["BTCOUNT"],
        description: json["DESCRIPTION"],
        doctorcount: json["DOCTORCOUNT"],
        enfcount: json["ENFCOUNT"],
        engineeercount: json["ENGINEEERCOUNT"],
        femalecount: json["FEMALECOUNT"],
        fixercount: json["FIXERCOUNT"],
        governingname: json["GOVERNINGNAME"],
        history: json["HISTORY"],
        keepercount: json["KEEPERCOUNT"],
        macount: json["MACOUNT"],
        malecount: json["MALECOUNT"],
        maxlvl: json["MAXLVL"],
        metacount: json["METACOUNT"],
        minlvl: json["MINLVL"],
        monstercount: json["MONSTERCOUNT"],
        name: json["NAME"],
        nanocount: json["NANOCOUNT"],
        nanoracecount: json["NANORACECOUNT"],
        neutercount: json["NEUTERCOUNT"],
        nummembers: json["NUMMEMBERS"],
        objective: json["OBJECTIVE"],
        opifexcount: json["OPIFEXCOUNT"],
        orgDimension: json["ORG_DIMENSION"],
        orgInstance: json["ORG_INSTANCE"],
        shadecount: json["SHADECOUNT"],
        side: json["SIDE"],
        sideName: json["SIDE_NAME"],
        solidercount: json["SOLIDERCOUNT"],
        solituscount: json["SOLITUSCOUNT"],
        tradercount: json["TRADERCOUNT"],
    );

    Map<String, dynamic> toJson() => {
        "ADVENTURERCOUNT": adventurercount,
        "AGENTCOUNT": agentcount,
        "ATROXCOUNT": atroxcount,
        "AVGLVL": avglvl,
        "BTCOUNT": btcount,
        "DESCRIPTION": description,
        "DOCTORCOUNT": doctorcount,
        "ENFCOUNT": enfcount,
        "ENGINEEERCOUNT": engineeercount,
        "FEMALECOUNT": femalecount,
        "FIXERCOUNT": fixercount,
        "GOVERNINGNAME": governingname,
        "HISTORY": history,
        "KEEPERCOUNT": keepercount,
        "MACOUNT": macount,
        "MALECOUNT": malecount,
        "MAXLVL": maxlvl,
        "METACOUNT": metacount,
        "MINLVL": minlvl,
        "MONSTERCOUNT": monstercount,
        "NAME": name,
        "NANOCOUNT": nanocount,
        "NANORACECOUNT": nanoracecount,
        "NEUTERCOUNT": neutercount,
        "NUMMEMBERS": nummembers,
        "OBJECTIVE": objective,
        "OPIFEXCOUNT": opifexcount,
        "ORG_DIMENSION": orgDimension,
        "ORG_INSTANCE": orgInstance,
        "SHADECOUNT": shadecount,
        "SIDE": side,
        "SIDE_NAME": sideName,
        "SOLIDERCOUNT": solidercount,
        "SOLITUSCOUNT": solituscount,
        "TRADERCOUNT": tradercount,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
