// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final A a;
    final B b;
    final C c;

    TopLevel({
        required this.a,
        required this.b,
        required this.c,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        a: A.fromJson(json["a"]),
        b: B.fromJson(json["b"]),
        c: C.fromJson(json["c"]),
    );

    Map<String, dynamic> toJson() => {
        "a": a.toJson(),
        "b": b.toJson(),
        "c": c.toJson(),
    };
}

class A {
    final String a;
    final String a0;
    final String a00;
    final String a000;
    final String a0000;
    final String a1;
    final String a10;
    final String a100000000;
    final String a12;
    final String a1E02;
    final String aAlert123T;
    final String aFalse;
    final String aHrefJava123456781112ScriptJavascriptAlert1XxxA;
    final String aHrefJavascriptX09JavascriptAlert1IdFuzzelement1TestA;
    final String aHrefJavascriptX0AJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefJavascriptX3AJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX01JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX05JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX08JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX09JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0CjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX10JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX11JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX13JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX17JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1FjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXC2XA0JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE1X9AX80JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE1XA0X8EjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X83JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X84JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X86JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X87JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80XA8JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aNull;
    final String aTest;
    final String aTrue;
    final String abcDivStyleXExpX00RessionJavascriptAlert1Def;
    final String abcDivStyleXExpX5CressionJavascriptAlert1Def;
    final String abcDivStyleXX09ExpressionJavascriptAlert1Def;
    final String abcDivStyleXX0BexpressionJavascriptAlert1Def;
    final String abcDivStyleXX20ExpressionJavascriptAlert1Def;
    final String abcDivStyleXX3AexpressionJavascriptAlert1Def;
    final String abcDivStyleXXC2XA0ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X80ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X84ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X89ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X8BexpressionJavascriptAlert1Def;
    final String alert123;
    final String alert123T;
    final String alertXss;
    final String ambitious;
    final String andU200BZeroWidthSpaceWhichAreInTheCCategoriesButAreOften;
    final String arsenalCanal;
    final String autofocusOnkeyupJavascriptAlert123;
    final String aux;
    final String braggadocious;
    final String changingLengthWhenLowercased;
    final String charactersWhichIncreaseInLength2To3BytesWhenLowercased;
    final String classic;
    final String commandInjectionRuby;
    final String cunning;
    final String d;
    final String dickVanDyke;
    final bool dontMakeAMap;
    final String drHermanILibshitz;
    final String empty;
    final String envHome;
    final String etcHosts;
    final String etcPasswd00;
    final String fluffy;
    final String fluffy0;
    final String fluffyTest;
    final String fontsAndHaveANumberOfSpecialBehaviors;
    final String fooValBar;
    final String frisky;
    final String hilarious;
    final String home;
    final String humanInjection;
    final String iNVOkINGTHEFLINGOFCHOS;
    final String ifImgSrcXOnerrorJavascriptAlert1;
    final String ifScriptJavascriptAlert1Script;
    final String imgSrc106971189711599114105112116589710810111411640398883833941;
    final String imgSrcJavAscriptAlertXss;
    final String imgSrcJavX0AAscriptAlertXss;
    final String imgSrcJavX0DAscriptAlertXss;
    final String imgSrcX09XOnerrorJavascriptAlert1;
    final String imgSrcX11XOnerrorJavascriptAlert1;
    final String imgSrcXOnerrorX00JavascriptAlert1;
    final String imgSrcXOnerrorX09JavascriptAlert1;
    final String imgSrcXX09OnerrorJavascriptAlert1;
    final String imgSrcXX10OnerrorJavascriptAlert1;
    final String imgSrcXX11OnerrorJavascriptAlert1;
    final String imgSrcXX12OnerrorJavascriptAlert1;
    final String imgSrcXX13OnerrorJavascriptAlert1;
    final String imgSrcXxxXX00OnerrorJavascriptAlert1;
    final String imgSrcXxxXX0BonerrorJavascriptAlert1;
    final String imgSrcXxxXX2FonerrorJavascriptAlert1;
    final String imgX00SrcXOnerrorAlert1;
    final String imgX10SrcXOnerrorJavascriptAlert1;
    final String imgX13SrcXOnerrorJavascriptAlert1;
    final String imgX32SrcXOnerrorJavascriptAlert1;
    final String imgX39SrcXOnerrorJavascriptAlert1;
    final String indecent;
    final String indigo;
    final String inf;
    final String infinity;
    final String innocuousStringsWhichMayBeBlockedByProfanityFiltersHttpsEnWikipediaOrgWikiScunthorpeProblem;
    final String jimmyClitheroe;
    final String kernelExit1;
    final String knownCvEsAndVulnerabilities;
    final String lightwaterCountryPark;
    final String lpt2;
    final String lpt3;
    final String lsAl;
    final String magenta;
    final String mischievous;
    final String msdosWindowsSpecialFilenames;
    final String nil;
    final String nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F;
    final String none;
    final String onfocusJaVaSCriptAlert123Autofocus;
    final String or11;
    final String penistoneCommunityChurch;
    final String perlEPrintImgSrcJava0ScriptAlertXssOut;
    final String prn;
    final String purple;
    final String purple0;
    final String purple1;
    final String purpleFalse;
    final String purpleTest;
    final String purpleTrue;
    final String romansInSussexCoUk;
    final String s;
    final String sUnSU;
    final String scScriptRiptAlert123ScScriptRipt;
    final String scriptAlert123ScriptX;
    final String scriptInjection;
    final String scriptScriptAlert123Script;
    final String scriptSrcHttpHaCkersOrgXssJsB;
    final String scriptSrcHttpHaCkersOrgXssJsScript;
    final String scriptX00JavascriptAlert1Script;
    final String scriptX09TypeTextJavascriptJavascriptAlert1Script;
    final String scriptX0CjavascriptAlert1Script;
    final String scriptX0DjavascriptAlert1Script;
    final String scriptX20TypeTextJavascriptJavascriptAlert1Script;
    final String scriptX3EtypeTextJavascriptJavascriptAlert1Script;
    final String scriptXC2X85JavascriptAlert1Script;
    final String scriptXC2XA0JavascriptAlert1Script;
    final String scriptXE1X9AX80JavascriptAlert1Script;
    final String scriptXE1XA0X8EjavascriptAlert1Script;
    final String scriptXE2X80X81JavascriptAlert1Script;
    final String scriptXE2X80X86JavascriptAlert1Script;
    final String scriptXE2X80X89JavascriptAlert1Script;
    final String scriptXE2X81X9FjavascriptAlert1Script;
    final String scriptXEfXBbXBFjavascriptAlert1Script;
    final String scriptXF0X90X96X9AjavascriptAlert1Script;
    final String scriptXssSrcHttpHaCkersOrgXssJsScript;
    final String sqlInjection;
    final String sticky;
    final String stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXmlParser;
    final String stringsThatTestForKnownVulnerabilities;
    final String stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPerlOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString;
    final String stringsWhichCanCallSystemCommandsWithinRubyRailsApplications;
    final String stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb;
    final String stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters;
    final String stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes;
    final String stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways;
    final String stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors;
    final String stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues;
    final String stringsWhichCrashedIMessageInVariousVersionsOfIOs;
    final String stringsWhichMayCauseHumanToReinterpretWorldview;
    final String superBowlXxx;
    final String tentacled;
    final String test;
    final String textareaScriptAlert123Script;
    final String the0;
    final String the00;
    final String the000;
    final String the0000;
    final String the0X0;
    final String the1;
    final String the10;
    final String the100;
    final String the1000;
    final String the100000;
    final String the100000000;
    final String the11;
    final String the12;
    final String the123456789012345678901234567890123456789;
    final String the13;
    final String the14;
    final String the15;
    final String the16;
    final String the17;
    final String the18;
    final String the19;
    final String the1DropTableUsers;
    final String the1E02;
    final String the1E2;
    final String the1Qnan;
    final String the1Snan;
    final String the2;
    final String the20;
    final String the21;
    final String the22;
    final String the23;
    final String the24;
    final String the25;
    final String the26;
    final String the27;
    final String the3;
    final String the4;
    final String the5;
    final String the6;
    final String the7;
    final String the8;
    final String the9;
    final String the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
    final String theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers;
    final String theQuicKBrownFoXBeeeep;
    final String twoByteCharacters;
    final String u0000U000AOrU000DNulLfCr;
    final String uOncopyAlertCopyMeU;
    final String undef;
    final String unicodeFont;
    final String unicodeNumbers;
    final String unwantedInterpolation;
    final String xLsAl;
    final String zGO;

    A({
        required this.a,
        required this.a0,
        required this.a00,
        required this.a000,
        required this.a0000,
        required this.a1,
        required this.a10,
        required this.a100000000,
        required this.a12,
        required this.a1E02,
        required this.aAlert123T,
        required this.aFalse,
        required this.aHrefJava123456781112ScriptJavascriptAlert1XxxA,
        required this.aHrefJavascriptX09JavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefJavascriptX0AJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefJavascriptX3AJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX01JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX05JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX08JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX09JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0CjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX10JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX11JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX13JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX17JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXC2XA0JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE1X9AX80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE1XA0X8EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X83JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X84JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X86JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X87JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80XA8JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aNull,
        required this.aTest,
        required this.aTrue,
        required this.abcDivStyleXExpX00RessionJavascriptAlert1Def,
        required this.abcDivStyleXExpX5CressionJavascriptAlert1Def,
        required this.abcDivStyleXX09ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXX0BexpressionJavascriptAlert1Def,
        required this.abcDivStyleXX20ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXX3AexpressionJavascriptAlert1Def,
        required this.abcDivStyleXXC2XA0ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X80ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X84ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X89ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X8BexpressionJavascriptAlert1Def,
        required this.alert123,
        required this.alert123T,
        required this.alertXss,
        required this.ambitious,
        required this.andU200BZeroWidthSpaceWhichAreInTheCCategoriesButAreOften,
        required this.arsenalCanal,
        required this.autofocusOnkeyupJavascriptAlert123,
        required this.aux,
        required this.braggadocious,
        required this.changingLengthWhenLowercased,
        required this.charactersWhichIncreaseInLength2To3BytesWhenLowercased,
        required this.classic,
        required this.commandInjectionRuby,
        required this.cunning,
        required this.d,
        required this.dickVanDyke,
        required this.dontMakeAMap,
        required this.drHermanILibshitz,
        required this.empty,
        required this.envHome,
        required this.etcHosts,
        required this.etcPasswd00,
        required this.fluffy,
        required this.fluffy0,
        required this.fluffyTest,
        required this.fontsAndHaveANumberOfSpecialBehaviors,
        required this.fooValBar,
        required this.frisky,
        required this.hilarious,
        required this.home,
        required this.humanInjection,
        required this.iNVOkINGTHEFLINGOFCHOS,
        required this.ifImgSrcXOnerrorJavascriptAlert1,
        required this.ifScriptJavascriptAlert1Script,
        required this.imgSrc106971189711599114105112116589710810111411640398883833941,
        required this.imgSrcJavAscriptAlertXss,
        required this.imgSrcJavX0AAscriptAlertXss,
        required this.imgSrcJavX0DAscriptAlertXss,
        required this.imgSrcX09XOnerrorJavascriptAlert1,
        required this.imgSrcX11XOnerrorJavascriptAlert1,
        required this.imgSrcXOnerrorX00JavascriptAlert1,
        required this.imgSrcXOnerrorX09JavascriptAlert1,
        required this.imgSrcXX09OnerrorJavascriptAlert1,
        required this.imgSrcXX10OnerrorJavascriptAlert1,
        required this.imgSrcXX11OnerrorJavascriptAlert1,
        required this.imgSrcXX12OnerrorJavascriptAlert1,
        required this.imgSrcXX13OnerrorJavascriptAlert1,
        required this.imgSrcXxxXX00OnerrorJavascriptAlert1,
        required this.imgSrcXxxXX0BonerrorJavascriptAlert1,
        required this.imgSrcXxxXX2FonerrorJavascriptAlert1,
        required this.imgX00SrcXOnerrorAlert1,
        required this.imgX10SrcXOnerrorJavascriptAlert1,
        required this.imgX13SrcXOnerrorJavascriptAlert1,
        required this.imgX32SrcXOnerrorJavascriptAlert1,
        required this.imgX39SrcXOnerrorJavascriptAlert1,
        required this.indecent,
        required this.indigo,
        required this.inf,
        required this.infinity,
        required this.innocuousStringsWhichMayBeBlockedByProfanityFiltersHttpsEnWikipediaOrgWikiScunthorpeProblem,
        required this.jimmyClitheroe,
        required this.kernelExit1,
        required this.knownCvEsAndVulnerabilities,
        required this.lightwaterCountryPark,
        required this.lpt2,
        required this.lpt3,
        required this.lsAl,
        required this.magenta,
        required this.mischievous,
        required this.msdosWindowsSpecialFilenames,
        required this.nil,
        required this.nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F,
        required this.none,
        required this.onfocusJaVaSCriptAlert123Autofocus,
        required this.or11,
        required this.penistoneCommunityChurch,
        required this.perlEPrintImgSrcJava0ScriptAlertXssOut,
        required this.prn,
        required this.purple,
        required this.purple0,
        required this.purple1,
        required this.purpleFalse,
        required this.purpleTest,
        required this.purpleTrue,
        required this.romansInSussexCoUk,
        required this.s,
        required this.sUnSU,
        required this.scScriptRiptAlert123ScScriptRipt,
        required this.scriptAlert123ScriptX,
        required this.scriptInjection,
        required this.scriptScriptAlert123Script,
        required this.scriptSrcHttpHaCkersOrgXssJsB,
        required this.scriptSrcHttpHaCkersOrgXssJsScript,
        required this.scriptX00JavascriptAlert1Script,
        required this.scriptX09TypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX0CjavascriptAlert1Script,
        required this.scriptX0DjavascriptAlert1Script,
        required this.scriptX20TypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX3EtypeTextJavascriptJavascriptAlert1Script,
        required this.scriptXC2X85JavascriptAlert1Script,
        required this.scriptXC2XA0JavascriptAlert1Script,
        required this.scriptXE1X9AX80JavascriptAlert1Script,
        required this.scriptXE1XA0X8EjavascriptAlert1Script,
        required this.scriptXE2X80X81JavascriptAlert1Script,
        required this.scriptXE2X80X86JavascriptAlert1Script,
        required this.scriptXE2X80X89JavascriptAlert1Script,
        required this.scriptXE2X81X9FjavascriptAlert1Script,
        required this.scriptXEfXBbXBFjavascriptAlert1Script,
        required this.scriptXF0X90X96X9AjavascriptAlert1Script,
        required this.scriptXssSrcHttpHaCkersOrgXssJsScript,
        required this.sqlInjection,
        required this.sticky,
        required this.stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXmlParser,
        required this.stringsThatTestForKnownVulnerabilities,
        required this.stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPerlOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString,
        required this.stringsWhichCanCallSystemCommandsWithinRubyRailsApplications,
        required this.stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb,
        required this.stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters,
        required this.stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes,
        required this.stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways,
        required this.stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors,
        required this.stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues,
        required this.stringsWhichCrashedIMessageInVariousVersionsOfIOs,
        required this.stringsWhichMayCauseHumanToReinterpretWorldview,
        required this.superBowlXxx,
        required this.tentacled,
        required this.test,
        required this.textareaScriptAlert123Script,
        required this.the0,
        required this.the00,
        required this.the000,
        required this.the0000,
        required this.the0X0,
        required this.the1,
        required this.the10,
        required this.the100,
        required this.the1000,
        required this.the100000,
        required this.the100000000,
        required this.the11,
        required this.the12,
        required this.the123456789012345678901234567890123456789,
        required this.the13,
        required this.the14,
        required this.the15,
        required this.the16,
        required this.the17,
        required this.the18,
        required this.the19,
        required this.the1DropTableUsers,
        required this.the1E02,
        required this.the1E2,
        required this.the1Qnan,
        required this.the1Snan,
        required this.the2,
        required this.the20,
        required this.the21,
        required this.the22,
        required this.the23,
        required this.the24,
        required this.the25,
        required this.the26,
        required this.the27,
        required this.the3,
        required this.the4,
        required this.the5,
        required this.the6,
        required this.the7,
        required this.the8,
        required this.the9,
        required this.the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999,
        required this.theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers,
        required this.theQuicKBrownFoXBeeeep,
        required this.twoByteCharacters,
        required this.u0000U000AOrU000DNulLfCr,
        required this.uOncopyAlertCopyMeU,
        required this.undef,
        required this.unicodeFont,
        required this.unicodeNumbers,
        required this.unwantedInterpolation,
        required this.xLsAl,
        required this.zGO,
    });

    factory A.fromJson(Map<String, dynamic> json) => A(
        a: json["!@#\u0024%^&*()`~"],
        a0: json["-0"],
        a00: json["00˙Ɩ\u0024-"],
        a000: json["0,00"],
        a0000: json["0.0/0.0"],
        a1: json["-1"],
        a10: json["1/0"],
        a100000000: json["1'000'000.00"],
        a12: json["1/2"],
        a1E02: json["1E02"],
        aAlert123T: json["';alert(123);t='"],
        aFalse: json["False"],
        aHrefJava123456781112ScriptJavascriptAlert1XxxA: json["<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"],
        aHrefJavascriptX09JavascriptAlert1IdFuzzelement1TestA: json["<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefJavascriptX0AJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefJavascriptX3AJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX01JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX05JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX08JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX09JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0CjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX10JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX11JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX13JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX17JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1FjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXC2XA0JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE1X9AX80JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE1XA0X8EjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X83JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X84JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X86JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X87JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80XA8JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aNull: json["(null)"],
        aTest: json["\u202a\u202atest\u202a"],
        aTrue: json["TRUE"],
        abcDivStyleXExpX00RessionJavascriptAlert1Def: json["ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"],
        abcDivStyleXExpX5CressionJavascriptAlert1Def: json["ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"],
        abcDivStyleXX09ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"],
        abcDivStyleXX0BexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"],
        abcDivStyleXX20ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"],
        abcDivStyleXX3AexpressionJavascriptAlert1Def: json["ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"],
        abcDivStyleXXC2XA0ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X80ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X84ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X89ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X8BexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"],
        alert123: json[";alert(123);"],
        alert123T: json["\";alert(123);t=\""],
        alertXss: json["\\\";alert('XSS');//"],
        ambitious: json["-."],
        andU200BZeroWidthSpaceWhichAreInTheCCategoriesButAreOften: json["# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"],
        arsenalCanal: json["Arsenal canal"],
        autofocusOnkeyupJavascriptAlert123: json["\" autofocus onkeyup=\"javascript:alert(123)"],
        aux: json["AUX"],
        braggadocious: json["¡™£¢∞§¶•ªº–≠"],
        changingLengthWhenLowercased: json["#\tChanging length when lowercased"],
        charactersWhichIncreaseInLength2To3BytesWhenLowercased: json["#\tCharacters which increase in length (2 to 3 bytes) when lowercased"],
        classic: json["classic"],
        commandInjectionRuby: json["#\tCommand Injection (Ruby)"],
        cunning: json["<>?:\"{}|_+"],
        d: json["%d"],
        dickVanDyke: json["Dick Van Dyke"],
        dontMakeAMap: json["dontMakeAMap"],
        drHermanILibshitz: json["Dr. Herman I. Libshitz"],
        empty: json[" "],
        envHome: json["\u0024ENV{'HOME'}"],
        etcHosts: json["../../../../../../../../../../../etc/hosts"],
        etcPasswd00: json["../../../../../../../../../../../etc/passwd%00"],
        fluffy: json["'\"'"],
        fluffy0: json["{0}"],
        fluffyTest: json["\u2066test\u2067"],
        fontsAndHaveANumberOfSpecialBehaviors: json["#       fonts, and have a number of special behaviors"],
        fooValBar: json["<foo val=`bar' />"],
        frisky: json["`⁄€‹›ﬁﬂ‡°·‚—±"],
        hilarious: json["-,"],
        home: json["\u0024HOME"],
        humanInjection: json["#\tHuman injection"],
        iNVOkINGTHEFLINGOFCHOS: json["̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"],
        ifImgSrcXOnerrorJavascriptAlert1: json["<!--[if<img src=x onerror=javascript:alert(1)//]> -->"],
        ifScriptJavascriptAlert1Script: json["<!--[if]><script>javascript:alert(1)</script -->"],
        imgSrc106971189711599114105112116589710810111411640398883833941: json["<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"],
        imgSrcJavAscriptAlertXss: json["<IMG SRC=\"jav   ascript:alert('XSS');\">"],
        imgSrcJavX0AAscriptAlertXss: json["<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"],
        imgSrcJavX0DAscriptAlertXss: json["<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"],
        imgSrcX09XOnerrorJavascriptAlert1: json["<img src\\x09=x onerror=\"javascript:alert(1)\">"],
        imgSrcX11XOnerrorJavascriptAlert1: json["<img src\\x11=x onerror=\"javascript:alert(1)\">"],
        imgSrcXOnerrorX00JavascriptAlert1: json["<img src=x onerror=\\x00\"javascript:alert(1)\">"],
        imgSrcXOnerrorX09JavascriptAlert1: json["<img src=x onerror=\\x09\"javascript:alert(1)\">"],
        imgSrcXX09OnerrorJavascriptAlert1: json["<img src=x\\x09onerror=\"javascript:alert(1)\">"],
        imgSrcXX10OnerrorJavascriptAlert1: json["<img src=x\\x10onerror=\"javascript:alert(1)\">"],
        imgSrcXX11OnerrorJavascriptAlert1: json["<img src=x\\x11onerror=\"javascript:alert(1)\">"],
        imgSrcXX12OnerrorJavascriptAlert1: json["<img src=x\\x12onerror=\"javascript:alert(1)\">"],
        imgSrcXX13OnerrorJavascriptAlert1: json["<img src=x\\x13onerror=\"javascript:alert(1)\">"],
        imgSrcXxxXX00OnerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"],
        imgSrcXxxXX0BonerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"],
        imgSrcXxxXX2FonerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"],
        imgX00SrcXOnerrorAlert1: json["<img \\x00src=x onerror=\"alert(1)\">"],
        imgX10SrcXOnerrorJavascriptAlert1: json["<img\\x10src=x onerror=\"javascript:alert(1)\">"],
        imgX13SrcXOnerrorJavascriptAlert1: json["<img\\x13src=x onerror=\"javascript:alert(1)\">"],
        imgX32SrcXOnerrorJavascriptAlert1: json["<img\\x32src=x onerror=\"javascript:alert(1)\">"],
        imgX39SrcXOnerrorJavascriptAlert1: json["<img \\x39src=x onerror=\"javascript:alert(1)\">"],
        indecent: json[",./;'[]\\-="],
        indigo: json[","],
        inf: json["INF"],
        infinity: json["-Infinity"],
        innocuousStringsWhichMayBeBlockedByProfanityFiltersHttpsEnWikipediaOrgWikiScunthorpeProblem: json["#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"],
        jimmyClitheroe: json["Jimmy Clitheroe"],
        kernelExit1: json["Kernel.exit(1)"],
        knownCvEsAndVulnerabilities: json["#\tKnown CVEs and Vulnerabilities"],
        lightwaterCountryPark: json["Lightwater Country Park"],
        lpt2: json["LPT2"],
        lpt3: json["LPT3"],
        lsAl: json["`ls -al /`"],
        magenta: json["\\"],
        mischievous: json["\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f"],
        msdosWindowsSpecialFilenames: json["#\tMSDOS/Windows Special Filenames"],
        nil: json["nil"],
        nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: json["# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."],
        none: json["None"],
        onfocusJaVaSCriptAlert123Autofocus: json[" onfocus=JaVaSCript:alert(123) autofocus"],
        or11: json["' OR '1'='1"],
        penistoneCommunityChurch: json["Penistone Community Church"],
        perlEPrintImgSrcJava0ScriptAlertXssOut: json["perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"],
        prn: json["PRN"],
        purple: json["'"],
        purple0: json["0"],
        purple1: json["1"],
        purpleFalse: json["false"],
        purpleTest: json["\u202btest\u202b"],
        purpleTrue: json["True"],
        romansInSussexCoUk: json["RomansInSussex.co.uk"],
        s: json["%s"],
        sUnSU: json["<<< %s(un='%s') = %u"],
        scScriptRiptAlert123ScScriptRipt: json["<sc<script>ript>alert(123)</sc</script>ript>"],
        scriptAlert123ScriptX: json["\"><script>alert(123);</script x=\""],
        scriptInjection: json["#\tScript Injection"],
        scriptScriptAlert123Script: json["</script><script>alert(123)</script>"],
        scriptSrcHttpHaCkersOrgXssJsB: json["<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"],
        scriptSrcHttpHaCkersOrgXssJsScript: json["<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"],
        scriptX00JavascriptAlert1Script: json["\"`'><script>\\x00javascript:alert(1)</script>"],
        scriptX09TypeTextJavascriptJavascriptAlert1Script: json["<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX0CjavascriptAlert1Script: json["\"`'><script>\\x0Cjavascript:alert(1)</script>"],
        scriptX0DjavascriptAlert1Script: json["\"`'><script>\\x0Djavascript:alert(1)</script>"],
        scriptX20TypeTextJavascriptJavascriptAlert1Script: json["<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX3EtypeTextJavascriptJavascriptAlert1Script: json["<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"],
        scriptXC2X85JavascriptAlert1Script: json["\"`'><script>\\xC2\\x85javascript:alert(1)</script>"],
        scriptXC2XA0JavascriptAlert1Script: json["\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"],
        scriptXE1X9AX80JavascriptAlert1Script: json["\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"],
        scriptXE1XA0X8EjavascriptAlert1Script: json["\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"],
        scriptXE2X80X81JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"],
        scriptXE2X80X86JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"],
        scriptXE2X80X89JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"],
        scriptXE2X81X9FjavascriptAlert1Script: json["\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"],
        scriptXEfXBbXBFjavascriptAlert1Script: json["\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"],
        scriptXF0X90X96X9AjavascriptAlert1Script: json["\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"],
        scriptXssSrcHttpHaCkersOrgXssJsScript: json["<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"],
        sqlInjection: json["#\tSQL Injection"],
        sticky: json["(╯°□°）╯︵ ┻━┻)"],
        stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXmlParser: json["#\tString which can reveal system files when parsed by a badly configured XML parser"],
        stringsThatTestForKnownVulnerabilities: json["#\tStrings that test for known vulnerabilities"],
        stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPerlOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: json["#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."],
        stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: json["#\tStrings which can call system commands within Ruby/Rails applications"],
        stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: json["#\tStrings which consists of Japanese-style emoticons which are popular on the web"],
        stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: json["#\tStrings which contain bold/italic/etc. versions of normal characters"],
        stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: json["#\tStrings which contain common unicode symbols (e.g. smart quotes)"],
        stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: json["#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"],
        stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: json["#\tStrings which contain misplaced quotation marks; can cause encoding errors"],
        stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: json["#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"],
        stringsWhichCrashedIMessageInVariousVersionsOfIOs: json["#\tStrings which crashed iMessage in various versions of iOS"],
        stringsWhichMayCauseHumanToReinterpretWorldview: json["#\tStrings which may cause human to reinterpret worldview"],
        superBowlXxx: json["Super Bowl XXX"],
        tentacled: json["( ͡° ͜ʖ ͡°)"],
        test: json["הָיְתָהtestالصفحات التّحول"],
        textareaScriptAlert123Script: json["</textarea><script>alert(123)</script>"],
        the0: json["+0"],
        the00: json["0..0"],
        the000: json["0,0,0"],
        the0000: json["0,0/0,0"],
        the0X0: json["0x0"],
        the1: json["\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f"],
        the10: json["₀₁₂"],
        the100: json["1.00"],
        the1000: json["1.0/0.0"],
        the100000: json["1'000,00"],
        the100000000: json["1 000 000.00"],
        the11: json["⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"],
        the12: json["パーティーへ行かないか"],
        the123456789012345678901234567890123456789: json["123456789012345678901234567890123456789"],
        the13: json["和製漢語"],
        the14: json["田中さんにあげて下さい"],
        the15: json["\ud835\udc7b\ud835\udc89\ud835\udc86 \ud835\udc92\ud835\udc96\ud835\udc8a\ud835\udc84\ud835\udc8c \ud835\udc83\ud835\udc93\ud835\udc90\ud835\udc98\ud835\udc8f \ud835\udc87\ud835\udc90\ud835\udc99 \ud835\udc8b\ud835\udc96\ud835\udc8e\ud835\udc91\ud835\udc94 \ud835\udc90\ud835\udc97\ud835\udc86\ud835\udc93 \ud835\udc95\ud835\udc89\ud835\udc86 \ud835\udc8d\ud835\udc82\ud835\udc9b\ud835\udc9a \ud835\udc85\ud835\udc90\ud835\udc88"],
        the16: json["\ud835\udce3\ud835\udcf1\ud835\udcee \ud835\udcfa\ud835\udcfe\ud835\udcf2\ud835\udcec\ud835\udcf4 \ud835\udceb\ud835\udcfb\ud835\udcf8\ud835\udd00\ud835\udcf7 \ud835\udcef\ud835\udcf8\ud835\udd01 \ud835\udcf3\ud835\udcfe\ud835\udcf6\ud835\udcf9\ud835\udcfc \ud835\udcf8\ud835\udcff\ud835\udcee\ud835\udcfb \ud835\udcfd\ud835\udcf1\ud835\udcee \ud835\udcf5\ud835\udcea\ud835\udd03\ud835\udd02 \ud835\udced\ud835\udcf8\ud835\udcf0"],
        the17: json["\ud835\udd7f\ud835\udd8d\ud835\udd8a \ud835\udd96\ud835\udd9a\ud835\udd8e\ud835\udd88\ud835\udd90 \ud835\udd87\ud835\udd97\ud835\udd94\ud835\udd9c\ud835\udd93 \ud835\udd8b\ud835\udd94\ud835\udd9d \ud835\udd8f\ud835\udd9a\ud835\udd92\ud835\udd95\ud835\udd98 \ud835\udd94\ud835\udd9b\ud835\udd8a\ud835\udd97 \ud835\udd99\ud835\udd8d\ud835\udd8a \ud835\udd91\ud835\udd86\ud835\udd9f\ud835\udd9e \ud835\udd89\ud835\udd94\ud835\udd8c"],
        the18: json["\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8 \ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2\ud83c\uddf8"],
        the19: json["\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6"],
        the1DropTableUsers: json["1;DROP TABLE users"],
        the1E02: json["-1E02"],
        the1E2: json["1E2"],
        the1Qnan: json["1#QNAN"],
        the1Snan: json["1#SNAN"],
        the2: json["¸˛Ç◊ı˜Â¯˘¿"],
        the20: json["\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2"],
        the21: json["\ud83d\udc69\ud83c\udffd"],
        the22: json["\ud83d\udebe \ud83c\udd92 \ud83c\udd93 \ud83c\udd95 \ud83c\udd96 \ud83c\udd97 \ud83c\udd99 \ud83c\udfe7"],
        the23: json["﷽"],
        the24: json["\ufeff"],
        the25: json["｀ｨ(´∀｀∩"],
        the26: json["ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"],
        the27: json["\ufffe"],
        the3: json["Œ„´‰ˇÁ¨ˆØ∏”’"],
        the4: json["œ∑´®†¥¨ˆøπ“‘"],
        the5: json["Ⱥ"],
        the6: json["Ⱦ"],
        the7: json["ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."],
        the8: json["٠١٢٣٤٥٦٧٨٩"],
        the9: json["ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"],
        the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: json["999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"],
        theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: json["# The next two lines may appear to be blank or mojibake in some viewers."],
        theQuicKBrownFoXBeeeep: json["The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]"],
        twoByteCharacters: json["#\tTwo-Byte Characters"],
        u0000U000AOrU000DNulLfCr: json["# U+0000, U+000A, or U+000D (NUL, LF, CR)."],
        uOncopyAlertCopyMeU: json["<u oncopy=alert()> Copy me</u>"],
        undef: json["undef"],
        unicodeFont: json["#\tUnicode font"],
        unicodeNumbers: json["#\tUnicode Numbers"],
        unwantedInterpolation: json["#\tUnwanted Interpolation"],
        xLsAl: json["%x('ls -al /')"],
        zGO: json["Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"],
    );

    Map<String, dynamic> toJson() => {
        "!@#\u0024%^&*()`~": a,
        "-0": a0,
        "00˙Ɩ\u0024-": a00,
        "0,00": a000,
        "0.0/0.0": a0000,
        "-1": a1,
        "1/0": a10,
        "1'000'000.00": a100000000,
        "1/2": a12,
        "1E02": a1E02,
        "';alert(123);t='": aAlert123T,
        "False": aFalse,
        "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>": aHrefJava123456781112ScriptJavascriptAlert1XxxA,
        "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefJavascriptX09JavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefJavascriptX0AJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefJavascriptX3AJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX01JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX05JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX08JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX09JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0CjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX10JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX11JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX13JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX17JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXC2XA0JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE1X9AX80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE1XA0X8EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X83JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X84JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X86JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X87JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80XA8JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "(null)": aNull,
        "\u202a\u202atest\u202a": aTest,
        "TRUE": aTrue,
        "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF": abcDivStyleXExpX00RessionJavascriptAlert1Def,
        "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF": abcDivStyleXExpX5CressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF": abcDivStyleXX09ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF": abcDivStyleXX0BexpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF": abcDivStyleXX20ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF": abcDivStyleXX3AexpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF": abcDivStyleXXC2XA0ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X80ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X84ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X89ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X8BexpressionJavascriptAlert1Def,
        ";alert(123);": alert123,
        "\";alert(123);t=\"": alert123T,
        "\\\";alert('XSS');//": alertXss,
        "-.": ambitious,
        "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often": andU200BZeroWidthSpaceWhichAreInTheCCategoriesButAreOften,
        "Arsenal canal": arsenalCanal,
        "\" autofocus onkeyup=\"javascript:alert(123)": autofocusOnkeyupJavascriptAlert123,
        "AUX": aux,
        "¡™£¢∞§¶•ªº–≠": braggadocious,
        "#\tChanging length when lowercased": changingLengthWhenLowercased,
        "#\tCharacters which increase in length (2 to 3 bytes) when lowercased": charactersWhichIncreaseInLength2To3BytesWhenLowercased,
        "classic": classic,
        "#\tCommand Injection (Ruby)": commandInjectionRuby,
        "<>?:\"{}|_+": cunning,
        "%d": d,
        "Dick Van Dyke": dickVanDyke,
        "dontMakeAMap": dontMakeAMap,
        "Dr. Herman I. Libshitz": drHermanILibshitz,
        " ": empty,
        "\u0024ENV{'HOME'}": envHome,
        "../../../../../../../../../../../etc/hosts": etcHosts,
        "../../../../../../../../../../../etc/passwd%00": etcPasswd00,
        "'\"'": fluffy,
        "{0}": fluffy0,
        "\u2066test\u2067": fluffyTest,
        "#       fonts, and have a number of special behaviors": fontsAndHaveANumberOfSpecialBehaviors,
        "<foo val=`bar' />": fooValBar,
        "`⁄€‹›ﬁﬂ‡°·‚—±": frisky,
        "-,": hilarious,
        "\u0024HOME": home,
        "#\tHuman injection": humanInjection,
        "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰": iNVOkINGTHEFLINGOFCHOS,
        "<!--[if<img src=x onerror=javascript:alert(1)//]> -->": ifImgSrcXOnerrorJavascriptAlert1,
        "<!--[if]><script>javascript:alert(1)</script -->": ifScriptJavascriptAlert1Script,
        "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>": imgSrc106971189711599114105112116589710810111411640398883833941,
        "<IMG SRC=\"jav   ascript:alert('XSS');\">": imgSrcJavAscriptAlertXss,
        "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">": imgSrcJavX0AAscriptAlertXss,
        "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">": imgSrcJavX0DAscriptAlertXss,
        "<img src\\x09=x onerror=\"javascript:alert(1)\">": imgSrcX09XOnerrorJavascriptAlert1,
        "<img src\\x11=x onerror=\"javascript:alert(1)\">": imgSrcX11XOnerrorJavascriptAlert1,
        "<img src=x onerror=\\x00\"javascript:alert(1)\">": imgSrcXOnerrorX00JavascriptAlert1,
        "<img src=x onerror=\\x09\"javascript:alert(1)\">": imgSrcXOnerrorX09JavascriptAlert1,
        "<img src=x\\x09onerror=\"javascript:alert(1)\">": imgSrcXX09OnerrorJavascriptAlert1,
        "<img src=x\\x10onerror=\"javascript:alert(1)\">": imgSrcXX10OnerrorJavascriptAlert1,
        "<img src=x\\x11onerror=\"javascript:alert(1)\">": imgSrcXX11OnerrorJavascriptAlert1,
        "<img src=x\\x12onerror=\"javascript:alert(1)\">": imgSrcXX12OnerrorJavascriptAlert1,
        "<img src=x\\x13onerror=\"javascript:alert(1)\">": imgSrcXX13OnerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>": imgSrcXxxXX00OnerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>": imgSrcXxxXX0BonerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>": imgSrcXxxXX2FonerrorJavascriptAlert1,
        "<img \\x00src=x onerror=\"alert(1)\">": imgX00SrcXOnerrorAlert1,
        "<img\\x10src=x onerror=\"javascript:alert(1)\">": imgX10SrcXOnerrorJavascriptAlert1,
        "<img\\x13src=x onerror=\"javascript:alert(1)\">": imgX13SrcXOnerrorJavascriptAlert1,
        "<img\\x32src=x onerror=\"javascript:alert(1)\">": imgX32SrcXOnerrorJavascriptAlert1,
        "<img \\x39src=x onerror=\"javascript:alert(1)\">": imgX39SrcXOnerrorJavascriptAlert1,
        ",./;'[]\\-=": indecent,
        ",": indigo,
        "INF": inf,
        "-Infinity": infinity,
        "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)": innocuousStringsWhichMayBeBlockedByProfanityFiltersHttpsEnWikipediaOrgWikiScunthorpeProblem,
        "Jimmy Clitheroe": jimmyClitheroe,
        "Kernel.exit(1)": kernelExit1,
        "#\tKnown CVEs and Vulnerabilities": knownCvEsAndVulnerabilities,
        "Lightwater Country Park": lightwaterCountryPark,
        "LPT2": lpt2,
        "LPT3": lpt3,
        "`ls -al /`": lsAl,
        "\\": magenta,
        "\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f": mischievous,
        "#\tMSDOS/Windows Special Filenames": msdosWindowsSpecialFilenames,
        "nil": nil,
        "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.": nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F,
        "None": none,
        " onfocus=JaVaSCript:alert(123) autofocus": onfocusJaVaSCriptAlert123Autofocus,
        "' OR '1'='1": or11,
        "Penistone Community Church": penistoneCommunityChurch,
        "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out": perlEPrintImgSrcJava0ScriptAlertXssOut,
        "PRN": prn,
        "'": purple,
        "0": purple0,
        "1": purple1,
        "false": purpleFalse,
        "\u202btest\u202b": purpleTest,
        "True": purpleTrue,
        "RomansInSussex.co.uk": romansInSussexCoUk,
        "%s": s,
        "<<< %s(un='%s') = %u": sUnSU,
        "<sc<script>ript>alert(123)</sc</script>ript>": scScriptRiptAlert123ScScriptRipt,
        "\"><script>alert(123);</script x=\"": scriptAlert123ScriptX,
        "#\tScript Injection": scriptInjection,
        "</script><script>alert(123)</script>": scriptScriptAlert123Script,
        "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >": scriptSrcHttpHaCkersOrgXssJsB,
        "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>": scriptSrcHttpHaCkersOrgXssJsScript,
        "\"`'><script>\\x00javascript:alert(1)</script>": scriptX00JavascriptAlert1Script,
        "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>": scriptX09TypeTextJavascriptJavascriptAlert1Script,
        "\"`'><script>\\x0Cjavascript:alert(1)</script>": scriptX0CjavascriptAlert1Script,
        "\"`'><script>\\x0Djavascript:alert(1)</script>": scriptX0DjavascriptAlert1Script,
        "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>": scriptX20TypeTextJavascriptJavascriptAlert1Script,
        "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>": scriptX3EtypeTextJavascriptJavascriptAlert1Script,
        "\"`'><script>\\xC2\\x85javascript:alert(1)</script>": scriptXC2X85JavascriptAlert1Script,
        "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>": scriptXC2XA0JavascriptAlert1Script,
        "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>": scriptXE1X9AX80JavascriptAlert1Script,
        "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>": scriptXE1XA0X8EjavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>": scriptXE2X80X81JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>": scriptXE2X80X86JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>": scriptXE2X80X89JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>": scriptXE2X81X9FjavascriptAlert1Script,
        "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>": scriptXEfXBbXBFjavascriptAlert1Script,
        "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>": scriptXF0X90X96X9AjavascriptAlert1Script,
        "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>": scriptXssSrcHttpHaCkersOrgXssJsScript,
        "#\tSQL Injection": sqlInjection,
        "(╯°□°）╯︵ ┻━┻)": sticky,
        "#\tString which can reveal system files when parsed by a badly configured XML parser": stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXmlParser,
        "#\tStrings that test for known vulnerabilities": stringsThatTestForKnownVulnerabilities,
        "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.": stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPerlOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString,
        "#\tStrings which can call system commands within Ruby/Rails applications": stringsWhichCanCallSystemCommandsWithinRubyRailsApplications,
        "#\tStrings which consists of Japanese-style emoticons which are popular on the web": stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb,
        "#\tStrings which contain bold/italic/etc. versions of normal characters": stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters,
        "#\tStrings which contain common unicode symbols (e.g. smart quotes)": stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes,
        "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always": stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways,
        "#\tStrings which contain misplaced quotation marks; can cause encoding errors": stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors,
        "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues": stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues,
        "#\tStrings which crashed iMessage in various versions of iOS": stringsWhichCrashedIMessageInVariousVersionsOfIOs,
        "#\tStrings which may cause human to reinterpret worldview": stringsWhichMayCauseHumanToReinterpretWorldview,
        "Super Bowl XXX": superBowlXxx,
        "( ͡° ͜ʖ ͡°)": tentacled,
        "הָיְתָהtestالصفحات التّحول": test,
        "</textarea><script>alert(123)</script>": textareaScriptAlert123Script,
        "+0": the0,
        "0..0": the00,
        "0,0,0": the000,
        "0,0/0,0": the0000,
        "0x0": the0X0,
        "\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f": the1,
        "₀₁₂": the10,
        "1.00": the100,
        "1.0/0.0": the1000,
        "1'000,00": the100000,
        "1 000 000.00": the100000000,
        "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢": the11,
        "パーティーへ行かないか": the12,
        "123456789012345678901234567890123456789": the123456789012345678901234567890123456789,
        "和製漢語": the13,
        "田中さんにあげて下さい": the14,
        "\ud835\udc7b\ud835\udc89\ud835\udc86 \ud835\udc92\ud835\udc96\ud835\udc8a\ud835\udc84\ud835\udc8c \ud835\udc83\ud835\udc93\ud835\udc90\ud835\udc98\ud835\udc8f \ud835\udc87\ud835\udc90\ud835\udc99 \ud835\udc8b\ud835\udc96\ud835\udc8e\ud835\udc91\ud835\udc94 \ud835\udc90\ud835\udc97\ud835\udc86\ud835\udc93 \ud835\udc95\ud835\udc89\ud835\udc86 \ud835\udc8d\ud835\udc82\ud835\udc9b\ud835\udc9a \ud835\udc85\ud835\udc90\ud835\udc88": the15,
        "\ud835\udce3\ud835\udcf1\ud835\udcee \ud835\udcfa\ud835\udcfe\ud835\udcf2\ud835\udcec\ud835\udcf4 \ud835\udceb\ud835\udcfb\ud835\udcf8\ud835\udd00\ud835\udcf7 \ud835\udcef\ud835\udcf8\ud835\udd01 \ud835\udcf3\ud835\udcfe\ud835\udcf6\ud835\udcf9\ud835\udcfc \ud835\udcf8\ud835\udcff\ud835\udcee\ud835\udcfb \ud835\udcfd\ud835\udcf1\ud835\udcee \ud835\udcf5\ud835\udcea\ud835\udd03\ud835\udd02 \ud835\udced\ud835\udcf8\ud835\udcf0": the16,
        "\ud835\udd7f\ud835\udd8d\ud835\udd8a \ud835\udd96\ud835\udd9a\ud835\udd8e\ud835\udd88\ud835\udd90 \ud835\udd87\ud835\udd97\ud835\udd94\ud835\udd9c\ud835\udd93 \ud835\udd8b\ud835\udd94\ud835\udd9d \ud835\udd8f\ud835\udd9a\ud835\udd92\ud835\udd95\ud835\udd98 \ud835\udd94\ud835\udd9b\ud835\udd8a\ud835\udd97 \ud835\udd99\ud835\udd8d\ud835\udd8a \ud835\udd91\ud835\udd86\ud835\udd9f\ud835\udd9e \ud835\udd89\ud835\udd94\ud835\udd8c": the17,
        "\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8 \ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2\ud83c\uddf8": the18,
        "\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6": the19,
        "1;DROP TABLE users": the1DropTableUsers,
        "-1E02": the1E02,
        "1E2": the1E2,
        "1#QNAN": the1Qnan,
        "1#SNAN": the1Snan,
        "¸˛Ç◊ı˜Â¯˘¿": the2,
        "\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2": the20,
        "\ud83d\udc69\ud83c\udffd": the21,
        "\ud83d\udebe \ud83c\udd92 \ud83c\udd93 \ud83c\udd95 \ud83c\udd96 \ud83c\udd97 \ud83c\udd99 \ud83c\udfe7": the22,
        "﷽": the23,
        "\ufeff": the24,
        "｀ｨ(´∀｀∩": the25,
        "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ": the26,
        "\ufffe": the27,
        "Œ„´‰ˇÁ¨ˆØ∏”’": the3,
        "œ∑´®†¥¨ˆøπ“‘": the4,
        "Ⱥ": the5,
        "Ⱦ": the6,
        "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.": the7,
        "٠١٢٣٤٥٦٧٨٩": the8,
        "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็": the9,
        "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999": the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999,
        "# The next two lines may appear to be blank or mojibake in some viewers.": theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers,
        "The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]": theQuicKBrownFoXBeeeep,
        "#\tTwo-Byte Characters": twoByteCharacters,
        "# U+0000, U+000A, or U+000D (NUL, LF, CR).": u0000U000AOrU000DNulLfCr,
        "<u oncopy=alert()> Copy me</u>": uOncopyAlertCopyMeU,
        "undef": undef,
        "#\tUnicode font": unicodeFont,
        "#\tUnicode Numbers": unicodeNumbers,
        "#\tUnwanted Interpolation": unwantedInterpolation,
        "%x('ls -al /')": xLsAl,
        "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮": zGO,
    };
}

class B {
    final String aHrefHttpFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A;
    final String aHrefJavascriptX00JavascriptAlert1IdFuzzelement1TestA;
    final String aHrefJavascriptX0DJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX02JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX04JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0AjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0DjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0EjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0FjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX16JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX19JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1AjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1DjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1EjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X81JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X82JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80XA9JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80XAFjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String abcDivStyleXExpressionX5CJavascriptAlert1Def;
    final String abcDivStyleXX0AexpressionJavascriptAlert1Def;
    final String abcDivStyleXX0DexpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X82ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X83ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X85ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X87ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X8AexpressionJavascriptAlert1Def;
    final String ambitious;
    final String appearInInput;
    final String ath0;
    final String autofocusOnkeyupJavascriptAlert123;
    final String b;
    final String b100000;
    final String bFalse;
    final String bImgSrcOnmouseoverAlertXxs;
    final String bNull;
    final String bScriptAlert123Script;
    final String bTouchTmpBlnsFail;
    final String basement;
    final String braggadocious;
    final String butNow20CforMyGreatestTrick8M;
    final String byteOrderMarksUFeffAndUFffeEachOnItsOwnLine;
    final String com1;
    final String com3;
    final String commonlyMisinterpretedAsAdditionalGraphicCharacters;
    final String con;
    final String contextsDividedIntoThreeGroupsBasedOnUsLayoutKeyboardPosition;
    final String creditHttpsTwitterComJifaStatus625776454479970304;
    final String cunning;
    final String devNullTouchTmpBlnsFailEcho;
    final bool dontMakeAMap;
    final String empty;
    final String evalPutsHelloWorld;
    final String expression;
    final String file;
    final String fileInclusion;
    final String fluffy;
    final String fooValBar;
    final String frisky;
    final String generalCategoryCfInUnicode800;
    final String hEWHOWATSBEHINDTHEWAL;
    final String help;
    final String hilarious;
    final String httpA3030;
    final String iOsVulnerabilities;
    final String ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou;
    final String iframeSrcHttpHaCkersOrgScriptletHtml;
    final String imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041;
    final String imgSrc14JavascriptAlertXss;
    final String imgSrcJavX09AscriptAlertXss;
    final String imgSrcOnmouseoverAlertXxs;
    final String imgSrcX00XOnerrorJavascriptAlert1;
    final String imgSrcX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29;
    final String imgSrcXOnerrorX11JavascriptAlert1;
    final String imgSrcXOnerrorX12JavascriptAlert1;
    final String imgSrcXxxXX0AonerrorJavascriptAlert1;
    final String imgSrcXxxXX0ConerrorJavascriptAlert1;
    final String imgSrcXxxXX0DonerrorJavascriptAlert1;
    final String imgX00SrcXOnerrorJavascriptAlert1;
    final String imgX11SrcXOnerrorJavascriptAlert1;
    final String imgX12SrcXOnerrorJavascriptAlert1;
    final String imgX47SrcXOnerrorJavascriptAlert1;
    final String indecent;
    final String indigo;
    final String ircSpecificStrings;
    final String japaneseEmoticons;
    final String kernelExecLsAl;
    final String lindaCallahan;
    final String magenta;
    final String mischievous;
    final String nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO;
    final String nil;
    final String nul;
    final String numericStrings;
    final String oINVOKTHEHIVEMINDREPRESETINGCHAOS;
    final String oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXml;
    final String onfocusJaVaSCriptAlert123Autofocus;
    final String or111;
    final String purple;
    final String purpleScriptAlert123Script;
    final String quotationMarks;
    final String regionalIndicatorSymbols;
    final String regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross;
    final String reservedStrings;
    final String scriptAlert123Script;
    final String scriptAlert123ScriptX;
    final String scriptAlertXssScript;
    final String scriptSrcHaCkersOrgJ;
    final String scriptSrcJscriptSScript;
    final String scriptX09JavascriptAlert1Script;
    final String scriptX0AtypeTextJavascriptJavascriptAlert1Script;
    final String scriptX0DtypeTextJavascriptJavascriptAlert1Script;
    final String scriptX21JavascriptAlert1Script;
    final String scriptX3BjavascriptAlert1Script;
    final String scriptXE2X80X85JavascriptAlert1Script;
    final String scriptXE2X80X87JavascriptAlert1Script;
    final String scriptXE2X80X8AjavascriptAlert1Script;
    final String scriptXE2X80XA8JavascriptAlert1Script;
    final String scriptXE2X80XA9JavascriptAlert1Script;
    final String scriptXE2X80XAFjavascriptAlert1Script;
    final String scriptXE3X80X80JavascriptAlert1Script;
    final String scunthorpeProblem;
    final String sticky;
    final String stringsThatMayOccurOnIrcClientsThatMakeSecurityProductsFreakOut;
    final String stringsWhichAreReservedCharactersInMsdosWindows;
    final String stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXss;
    final String stringsWhichContainTextThatShouldBeRenderedRtlIfPossibleEGArabicHebrew;
    final String stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues;
    final String stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric;
    final String stringsWhichMayBeUsedElsewhereInCode;
    final String tentacled;
    final String terminalEscapeCodes;
    final String the000;
    final String the01000;
    final String the08;
    final String the09;
    final String the0Xffffffffffffffff;
    final String the1;
    final String the100;
    final String the1000;
    final String the100000;
    final String the100000000;
    final String the1DropTableUsers1;
    final String the1Ind;
    final String the1Inf;
    final String the2;
    final String the21474836481;
    final String the22250738585072011E308;
    final String the3;
    final String the4;
    final String theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers;
    final String theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers;
    final String theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers;
    final String thisFileUnfortunatelyCannotExpressStringsContaining;
    final String touchTmpBlnsFail;
    final String touchTmpBlnsShellshock2Fail;
    final String tysonGay;
    final String unicodeSymbols;
    final String x00ScriptJavascriptAlert1Script;
    final String x3CscriptJavascriptAlert1Script;

    B({
        required this.aHrefHttpFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A,
        required this.aHrefJavascriptX00JavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefJavascriptX0DJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX02JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX04JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0DjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX16JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX19JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1DjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X81JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X82JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80XA9JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80XAFjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.abcDivStyleXExpressionX5CJavascriptAlert1Def,
        required this.abcDivStyleXX0AexpressionJavascriptAlert1Def,
        required this.abcDivStyleXX0DexpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X82ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X83ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X85ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X87ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X8AexpressionJavascriptAlert1Def,
        required this.ambitious,
        required this.appearInInput,
        required this.ath0,
        required this.autofocusOnkeyupJavascriptAlert123,
        required this.b,
        required this.b100000,
        required this.bFalse,
        required this.bImgSrcOnmouseoverAlertXxs,
        required this.bNull,
        required this.bScriptAlert123Script,
        required this.bTouchTmpBlnsFail,
        required this.basement,
        required this.braggadocious,
        required this.butNow20CforMyGreatestTrick8M,
        required this.byteOrderMarksUFeffAndUFffeEachOnItsOwnLine,
        required this.com1,
        required this.com3,
        required this.commonlyMisinterpretedAsAdditionalGraphicCharacters,
        required this.con,
        required this.contextsDividedIntoThreeGroupsBasedOnUsLayoutKeyboardPosition,
        required this.creditHttpsTwitterComJifaStatus625776454479970304,
        required this.cunning,
        required this.devNullTouchTmpBlnsFailEcho,
        required this.dontMakeAMap,
        required this.empty,
        required this.evalPutsHelloWorld,
        required this.expression,
        required this.file,
        required this.fileInclusion,
        required this.fluffy,
        required this.fooValBar,
        required this.frisky,
        required this.generalCategoryCfInUnicode800,
        required this.hEWHOWATSBEHINDTHEWAL,
        required this.help,
        required this.hilarious,
        required this.httpA3030,
        required this.iOsVulnerabilities,
        required this.ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou,
        required this.iframeSrcHttpHaCkersOrgScriptletHtml,
        required this.imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041,
        required this.imgSrc14JavascriptAlertXss,
        required this.imgSrcJavX09AscriptAlertXss,
        required this.imgSrcOnmouseoverAlertXxs,
        required this.imgSrcX00XOnerrorJavascriptAlert1,
        required this.imgSrcX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29,
        required this.imgSrcXOnerrorX11JavascriptAlert1,
        required this.imgSrcXOnerrorX12JavascriptAlert1,
        required this.imgSrcXxxXX0AonerrorJavascriptAlert1,
        required this.imgSrcXxxXX0ConerrorJavascriptAlert1,
        required this.imgSrcXxxXX0DonerrorJavascriptAlert1,
        required this.imgX00SrcXOnerrorJavascriptAlert1,
        required this.imgX11SrcXOnerrorJavascriptAlert1,
        required this.imgX12SrcXOnerrorJavascriptAlert1,
        required this.imgX47SrcXOnerrorJavascriptAlert1,
        required this.indecent,
        required this.indigo,
        required this.ircSpecificStrings,
        required this.japaneseEmoticons,
        required this.kernelExecLsAl,
        required this.lindaCallahan,
        required this.magenta,
        required this.mischievous,
        required this.nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO,
        required this.nil,
        required this.nul,
        required this.numericStrings,
        required this.oINVOKTHEHIVEMINDREPRESETINGCHAOS,
        required this.oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXml,
        required this.onfocusJaVaSCriptAlert123Autofocus,
        required this.or111,
        required this.purple,
        required this.purpleScriptAlert123Script,
        required this.quotationMarks,
        required this.regionalIndicatorSymbols,
        required this.regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross,
        required this.reservedStrings,
        required this.scriptAlert123Script,
        required this.scriptAlert123ScriptX,
        required this.scriptAlertXssScript,
        required this.scriptSrcHaCkersOrgJ,
        required this.scriptSrcJscriptSScript,
        required this.scriptX09JavascriptAlert1Script,
        required this.scriptX0AtypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX0DtypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX21JavascriptAlert1Script,
        required this.scriptX3BjavascriptAlert1Script,
        required this.scriptXE2X80X85JavascriptAlert1Script,
        required this.scriptXE2X80X87JavascriptAlert1Script,
        required this.scriptXE2X80X8AjavascriptAlert1Script,
        required this.scriptXE2X80XA8JavascriptAlert1Script,
        required this.scriptXE2X80XA9JavascriptAlert1Script,
        required this.scriptXE2X80XAFjavascriptAlert1Script,
        required this.scriptXE3X80X80JavascriptAlert1Script,
        required this.scunthorpeProblem,
        required this.sticky,
        required this.stringsThatMayOccurOnIrcClientsThatMakeSecurityProductsFreakOut,
        required this.stringsWhichAreReservedCharactersInMsdosWindows,
        required this.stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXss,
        required this.stringsWhichContainTextThatShouldBeRenderedRtlIfPossibleEGArabicHebrew,
        required this.stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues,
        required this.stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric,
        required this.stringsWhichMayBeUsedElsewhereInCode,
        required this.tentacled,
        required this.terminalEscapeCodes,
        required this.the000,
        required this.the01000,
        required this.the08,
        required this.the09,
        required this.the0Xffffffffffffffff,
        required this.the1,
        required this.the100,
        required this.the1000,
        required this.the100000,
        required this.the100000000,
        required this.the1DropTableUsers1,
        required this.the1Ind,
        required this.the1Inf,
        required this.the2,
        required this.the21474836481,
        required this.the22250738585072011E308,
        required this.the3,
        required this.the4,
        required this.theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers,
        required this.theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers,
        required this.theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers,
        required this.thisFileUnfortunatelyCannotExpressStringsContaining,
        required this.touchTmpBlnsFail,
        required this.touchTmpBlnsShellshock2Fail,
        required this.tysonGay,
        required this.unicodeSymbols,
        required this.x00ScriptJavascriptAlert1Script,
        required this.x3CscriptJavascriptAlert1Script,
    });

    factory B.fromJson(Map<String, dynamic> json) => B(
        aHrefHttpFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: json["<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"],
        aHrefJavascriptX00JavascriptAlert1IdFuzzelement1TestA: json["<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefJavascriptX0DJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX02JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX04JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0AjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0DjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0EjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0FjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX16JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX19JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1AjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1DjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1EjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X81JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X82JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80XA9JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80XAFjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        abcDivStyleXExpressionX5CJavascriptAlert1Def: json["ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"],
        abcDivStyleXX0AexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"],
        abcDivStyleXX0DexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X82ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X83ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X85ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X87ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X8AexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"],
        ambitious: json["❤️ \ud83d\udc94 \ud83d\udc8c \ud83d\udc95 \ud83d\udc9e \ud83d\udc93 \ud83d\udc97 \ud83d\udc96 \ud83d\udc98 \ud83d\udc9d \ud83d\udc9f \ud83d\udc9c \ud83d\udc9b \ud83d\udc9a \ud83d\udc99"],
        appearInInput: json["# appear in input."],
        ath0: json["+++ATH0"],
        autofocusOnkeyupJavascriptAlert123: json["' autofocus onkeyup='javascript:alert(123)"],
        b: json["\t\u000b\u000c \u0085             \u200b\u2028\u2029  　"],
        b100000: json["1'000.00"],
        bFalse: json["FALSE"],
        bImgSrcOnmouseoverAlertXxs: json["<IMG SRC=# onmouseover=\"alert('xxs')\">"],
        bNull: json["null"],
        bScriptAlert123Script: json["--><script>alert(123)</script>"],
        bTouchTmpBlnsFail: json["`touch /tmp/blns.fail`"],
        basement: json["basement"],
        braggadocious: json["찦차를 타고 온 펲시맨과 쑛다리 똠방각하"],
        butNow20CforMyGreatestTrick8M: json["But now...\u001b[20Cfor my greatest trick...\u001b[8m"],
        byteOrderMarksUFeffAndUFffeEachOnItsOwnLine: json["# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."],
        com1: json["COM1"],
        com3: json["COM3"],
        commonlyMisinterpretedAsAdditionalGraphicCharacters: json["# Commonly misinterpreted as additional graphic characters."],
        con: json["CON"],
        contextsDividedIntoThreeGroupsBasedOnUsLayoutKeyboardPosition: json["# contexts.  Divided into three groups based on (US-layout) keyboard position."],
        creditHttpsTwitterComJifaStatus625776454479970304: json["#\tCredit: https://twitter.com/jifa/status/625776454479970304"],
        cunning: json["ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"],
        devNullTouchTmpBlnsFailEcho: json["/dev/null; touch /tmp/blns.fail ; echo"],
        dontMakeAMap: json["dontMakeAMap"],
        empty: json["\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f"],
        evalPutsHelloWorld: json["eval(\"puts 'hello world'\")"],
        expression: json["expression"],
        file: json["File:///"],
        fileInclusion: json["#\tFile Inclusion"],
        fluffy: json["#"],
        fooValBar: json["<foo val=”bar“ />"],
        frisky: json["部落格"],
        generalCategoryCfInUnicode800: json["# general category Cf (in Unicode 8.0.0)."],
        hEWHOWATSBEHINDTHEWAL: json["̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"],
        help: json["--help"],
        hilarious: json["⁰⁴⁵₀₁₂"],
        httpA3030: json["http://a/%%30%30"],
        iOsVulnerabilities: json["#\tiOS Vulnerabilities"],
        ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: json["If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."],
        iframeSrcHttpHaCkersOrgScriptletHtml: json["<iframe src=http://ha.ckers.org/scriptlet.html <"],
        imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: json["<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"],
        imgSrc14JavascriptAlertXss: json["<IMG SRC=\" &#14;  javascript:alert('XSS');\">"],
        imgSrcJavX09AscriptAlertXss: json["<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"],
        imgSrcOnmouseoverAlertXxs: json["<IMG SRC= onmouseover=\"alert('xxs')\">"],
        imgSrcX00XOnerrorJavascriptAlert1: json["<img src\\x00=x onerror=\"javascript:alert(1)\">"],
        imgSrcX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: json["<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"],
        imgSrcXOnerrorX11JavascriptAlert1: json["<img src=x onerror=\\x11\"javascript:alert(1)\">"],
        imgSrcXOnerrorX12JavascriptAlert1: json["<img src=x onerror=\\x12\"javascript:alert(1)\">"],
        imgSrcXxxXX0AonerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"],
        imgSrcXxxXX0ConerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"],
        imgSrcXxxXX0DonerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"],
        imgX00SrcXOnerrorJavascriptAlert1: json["<img \\x00src=x onerror=\"javascript:alert(1)\">"],
        imgX11SrcXOnerrorJavascriptAlert1: json["<img \\x11src=x onerror=\"javascript:alert(1)\">"],
        imgX12SrcXOnerrorJavascriptAlert1: json["<img \\x12src=x onerror=\"javascript:alert(1)\">"],
        imgX47SrcXOnerrorJavascriptAlert1: json["<img \\x47src=x onerror=\"javascript:alert(1)\">"],
        indecent: json["Ω≈ç√∫˜µ≤≥÷"],
        indigo: json["åß∂ƒ©˙∆˚¬…æ"],
        ircSpecificStrings: json["#   IRC specific strings"],
        japaneseEmoticons: json["#\tJapanese Emoticons"],
        kernelExecLsAl: json["Kernel.exec(\"ls -al /\")"],
        lindaCallahan: json["Linda Callahan"],
        magenta: json["社會科學院語學研究所"],
        mischievous: json["사회과학원 어학연구소"],
        nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO: json["˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"],
        nil: json["NIL"],
        nul: json["NUL"],
        numericStrings: json["#\tNumeric Strings"],
        oINVOKTHEHIVEMINDREPRESETINGCHAOS: json["Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"],
        oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXml: json["# Often forbidden to appear in various text-based file formats (e.g. XML),"],
        onfocusJaVaSCriptAlert123Autofocus: json["\" onfocus=JaVaSCript:alert(123) autofocus"],
        or111: json["' OR 1=1 -- 1"],
        purple: json["\""],
        purpleScriptAlert123Script: json["<script>alert(123)</script>"],
        quotationMarks: json["#\tQuotation Marks"],
        regionalIndicatorSymbols: json["#       Regional Indicator Symbols"],
        regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: json["#       Regional Indicator Symbols can be displayed differently across"],
        reservedStrings: json["#\tReserved Strings"],
        scriptAlert123Script: json["\"><script>alert(123)</script>"],
        scriptAlert123ScriptX: json["><script>alert(123);</script x="],
        scriptAlertXssScript: json["<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"],
        scriptSrcHaCkersOrgJ: json["<SCRIPT SRC=//ha.ckers.org/.j>"],
        scriptSrcJscriptSScript: json["<script src=\"\\\\%(jscript)s\"></script>"],
        scriptX09JavascriptAlert1Script: json["\"`'><script>\\x09javascript:alert(1)</script>"],
        scriptX0AtypeTextJavascriptJavascriptAlert1Script: json["<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX0DtypeTextJavascriptJavascriptAlert1Script: json["<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX21JavascriptAlert1Script: json["\"`'><script>\\x21javascript:alert(1)</script>"],
        scriptX3BjavascriptAlert1Script: json["\"`'><script>\\x3Bjavascript:alert(1)</script>"],
        scriptXE2X80X85JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"],
        scriptXE2X80X87JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"],
        scriptXE2X80X8AjavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"],
        scriptXE2X80XA8JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"],
        scriptXE2X80XA9JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"],
        scriptXE2X80XAFjavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"],
        scriptXE3X80X80JavascriptAlert1Script: json["\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"],
        scunthorpeProblem: json["#\tScunthorpe Problem"],
        sticky: json["__ﾛ(,_,*)"],
        stringsThatMayOccurOnIrcClientsThatMakeSecurityProductsFreakOut: json["#   Strings that may occur on IRC clients that make security products freak out"],
        stringsWhichAreReservedCharactersInMsdosWindows: json["#\tStrings which are reserved characters in MSDOS/Windows"],
        stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXss: json["#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"],
        stringsWhichContainTextThatShouldBeRenderedRtlIfPossibleEGArabicHebrew: json["#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"],
        stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: json["#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"],
        stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: json["#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"],
        stringsWhichMayBeUsedElsewhereInCode: json["#\tStrings which may be used elsewhere in code"],
        tentacled: json["(｡◕ ∀ ◕｡)"],
        terminalEscapeCodes: json["#\tTerminal escape codes"],
        the000: json["0.00"],
        the01000: json["01000"],
        the08: json["08"],
        the09: json["09"],
        the0Xffffffffffffffff: json["0xffffffffffffffff"],
        the1: json["\ud835\udd4b\ud835\udd59\ud835\udd56 \ud835\udd62\ud835\udd66\ud835\udd5a\ud835\udd54\ud835\udd5c \ud835\udd53\ud835\udd63\ud835\udd60\ud835\udd68\ud835\udd5f \ud835\udd57\ud835\udd60\ud835\udd69 \ud835\udd5b\ud835\udd66\ud835\udd5e\ud835\udd61\ud835\udd64 \ud835\udd60\ud835\udd67\ud835\udd56\ud835\udd63 \ud835\udd65\ud835\udd59\ud835\udd56 \ud835\udd5d\ud835\udd52\ud835\udd6b\ud835\udd6a \ud835\udd55\ud835\udd60\ud835\udd58"],
        the100: json["\u00241.00"],
        the1000: json["1,0/0,0"],
        the100000: json["1 000.00"],
        the100000000: json["1 000 000,00"],
        the1DropTableUsers1: json["1'; DROP TABLE users-- 1"],
        the1Ind: json["1#IND"],
        the1Inf: json["1#INF"],
        the2: json["\ud83d\ude0d"],
        the21474836481: json["-2147483648/-1"],
        the22250738585072011E308: json["2.2250738585072011e-308"],
        the3: json["ﷺ"],
        the4: json["１２３"],
        theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: json["# The next line may appear to be blank, mojibake, or dingbats in some viewers."],
        theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: json["# The next line may appear to be blank or mojibake in some viewers."],
        theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: json["# The next line may be flagged for \"trailing whitespace\" in some viewers."],
        thisFileUnfortunatelyCannotExpressStringsContaining: json["# This file unfortunately cannot express strings containing"],
        touchTmpBlnsFail: json["\u0024(touch /tmp/blns.fail)"],
        touchTmpBlnsShellshock2Fail: json["() { _; } >_[\u0024(\u0024())] { touch /tmp/blns.shellshock2.fail; }"],
        tysonGay: json["Tyson Gay"],
        unicodeSymbols: json["#\tUnicode Symbols"],
        x00ScriptJavascriptAlert1Script: json["'`\"><\\x00script>javascript:alert(1)</script>"],
        x3CscriptJavascriptAlert1Script: json["'`\"><\\x3Cscript>javascript:alert(1)</script>"],
    );

    Map<String, dynamic> toJson() => {
        "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">": aHrefHttpFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A,
        "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefJavascriptX00JavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefJavascriptX0DJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX02JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX04JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0DjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX16JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX19JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1DjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1EjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X81JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X82JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80XA9JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80XAFjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF": abcDivStyleXExpressionX5CJavascriptAlert1Def,
        "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF": abcDivStyleXX0AexpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF": abcDivStyleXX0DexpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X82ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X83ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X85ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X87ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X8AexpressionJavascriptAlert1Def,
        "❤️ \ud83d\udc94 \ud83d\udc8c \ud83d\udc95 \ud83d\udc9e \ud83d\udc93 \ud83d\udc97 \ud83d\udc96 \ud83d\udc98 \ud83d\udc9d \ud83d\udc9f \ud83d\udc9c \ud83d\udc9b \ud83d\udc9a \ud83d\udc99": ambitious,
        "# appear in input.": appearInInput,
        "+++ATH0": ath0,
        "' autofocus onkeyup='javascript:alert(123)": autofocusOnkeyupJavascriptAlert123,
        "\t\u000b\u000c \u0085             \u200b\u2028\u2029  　": b,
        "1'000.00": b100000,
        "FALSE": bFalse,
        "<IMG SRC=# onmouseover=\"alert('xxs')\">": bImgSrcOnmouseoverAlertXxs,
        "null": bNull,
        "--><script>alert(123)</script>": bScriptAlert123Script,
        "`touch /tmp/blns.fail`": bTouchTmpBlnsFail,
        "basement": basement,
        "찦차를 타고 온 펲시맨과 쑛다리 똠방각하": braggadocious,
        "But now...\u001b[20Cfor my greatest trick...\u001b[8m": butNow20CforMyGreatestTrick8M,
        "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.": byteOrderMarksUFeffAndUFffeEachOnItsOwnLine,
        "COM1": com1,
        "COM3": com3,
        "# Commonly misinterpreted as additional graphic characters.": commonlyMisinterpretedAsAdditionalGraphicCharacters,
        "CON": con,
        "# contexts.  Divided into three groups based on (US-layout) keyboard position.": contextsDividedIntoThreeGroupsBasedOnUsLayoutKeyboardPosition,
        "#\tCredit: https://twitter.com/jifa/status/625776454479970304": creditHttpsTwitterComJifaStatus625776454479970304,
        "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ": cunning,
        "/dev/null; touch /tmp/blns.fail ; echo": devNullTouchTmpBlnsFailEcho,
        "dontMakeAMap": dontMakeAMap,
        "\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f": empty,
        "eval(\"puts 'hello world'\")": evalPutsHelloWorld,
        "expression": expression,
        "File:///": file,
        "#\tFile Inclusion": fileInclusion,
        "#": fluffy,
        "<foo val=”bar“ />": fooValBar,
        "部落格": frisky,
        "# general category Cf (in Unicode 8.0.0).": generalCategoryCfInUnicode800,
        "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕": hEWHOWATSBEHINDTHEWAL,
        "--help": help,
        "⁰⁴⁵₀₁₂": hilarious,
        "http://a/%%30%30": httpA3030,
        "#\tiOS Vulnerabilities": iOsVulnerabilities,
        "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.": ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou,
        "<iframe src=http://ha.ckers.org/scriptlet.html <": iframeSrcHttpHaCkersOrgScriptletHtml,
        "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>": imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041,
        "<IMG SRC=\" &#14;  javascript:alert('XSS');\">": imgSrc14JavascriptAlertXss,
        "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">": imgSrcJavX09AscriptAlertXss,
        "<IMG SRC= onmouseover=\"alert('xxs')\">": imgSrcOnmouseoverAlertXxs,
        "<img src\\x00=x onerror=\"javascript:alert(1)\">": imgSrcX00XOnerrorJavascriptAlert1,
        "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>": imgSrcX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29,
        "<img src=x onerror=\\x11\"javascript:alert(1)\">": imgSrcXOnerrorX11JavascriptAlert1,
        "<img src=x onerror=\\x12\"javascript:alert(1)\">": imgSrcXOnerrorX12JavascriptAlert1,
        "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>": imgSrcXxxXX0AonerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>": imgSrcXxxXX0ConerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>": imgSrcXxxXX0DonerrorJavascriptAlert1,
        "<img \\x00src=x onerror=\"javascript:alert(1)\">": imgX00SrcXOnerrorJavascriptAlert1,
        "<img \\x11src=x onerror=\"javascript:alert(1)\">": imgX11SrcXOnerrorJavascriptAlert1,
        "<img \\x12src=x onerror=\"javascript:alert(1)\">": imgX12SrcXOnerrorJavascriptAlert1,
        "<img \\x47src=x onerror=\"javascript:alert(1)\">": imgX47SrcXOnerrorJavascriptAlert1,
        "Ω≈ç√∫˜µ≤≥÷": indecent,
        "åß∂ƒ©˙∆˚¬…æ": indigo,
        "#   IRC specific strings": ircSpecificStrings,
        "#\tJapanese Emoticons": japaneseEmoticons,
        "Kernel.exec(\"ls -al /\")": kernelExecLsAl,
        "Linda Callahan": lindaCallahan,
        "社會科學院語學研究所": magenta,
        "사회과학원 어학연구소": mischievous,
        "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥": nblUOlopOqlNUnppuOdPosnOpPsLUsdpNsuoSOlopNsdO,
        "NIL": nil,
        "NUL": nul,
        "#\tNumeric Strings": numericStrings,
        "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣": oINVOKTHEHIVEMINDREPRESETINGCHAOS,
        "# Often forbidden to appear in various text-based file formats (e.g. XML),": oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXml,
        "\" onfocus=JaVaSCript:alert(123) autofocus": onfocusJaVaSCriptAlert123Autofocus,
        "' OR 1=1 -- 1": or111,
        "\"": purple,
        "<script>alert(123)</script>": purpleScriptAlert123Script,
        "#\tQuotation Marks": quotationMarks,
        "#       Regional Indicator Symbols": regionalIndicatorSymbols,
        "#       Regional Indicator Symbols can be displayed differently across": regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross,
        "#\tReserved Strings": reservedStrings,
        "\"><script>alert(123)</script>": scriptAlert123Script,
        "><script>alert(123);</script x=": scriptAlert123ScriptX,
        "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>": scriptAlertXssScript,
        "<SCRIPT SRC=//ha.ckers.org/.j>": scriptSrcHaCkersOrgJ,
        "<script src=\"\\\\%(jscript)s\"></script>": scriptSrcJscriptSScript,
        "\"`'><script>\\x09javascript:alert(1)</script>": scriptX09JavascriptAlert1Script,
        "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>": scriptX0AtypeTextJavascriptJavascriptAlert1Script,
        "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>": scriptX0DtypeTextJavascriptJavascriptAlert1Script,
        "\"`'><script>\\x21javascript:alert(1)</script>": scriptX21JavascriptAlert1Script,
        "\"`'><script>\\x3Bjavascript:alert(1)</script>": scriptX3BjavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>": scriptXE2X80X85JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>": scriptXE2X80X87JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>": scriptXE2X80X8AjavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>": scriptXE2X80XA8JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>": scriptXE2X80XA9JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>": scriptXE2X80XAFjavascriptAlert1Script,
        "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>": scriptXE3X80X80JavascriptAlert1Script,
        "#\tScunthorpe Problem": scunthorpeProblem,
        "__ﾛ(,_,*)": sticky,
        "#   Strings that may occur on IRC clients that make security products freak out": stringsThatMayOccurOnIrcClientsThatMakeSecurityProductsFreakOut,
        "#\tStrings which are reserved characters in MSDOS/Windows": stringsWhichAreReservedCharactersInMsdosWindows,
        "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS": stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXss,
        "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)": stringsWhichContainTextThatShouldBeRenderedRtlIfPossibleEGArabicHebrew,
        "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues": stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues,
        "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric": stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric,
        "#\tStrings which may be used elsewhere in code": stringsWhichMayBeUsedElsewhereInCode,
        "(｡◕ ∀ ◕｡)": tentacled,
        "#\tTerminal escape codes": terminalEscapeCodes,
        "0.00": the000,
        "01000": the01000,
        "08": the08,
        "09": the09,
        "0xffffffffffffffff": the0Xffffffffffffffff,
        "\ud835\udd4b\ud835\udd59\ud835\udd56 \ud835\udd62\ud835\udd66\ud835\udd5a\ud835\udd54\ud835\udd5c \ud835\udd53\ud835\udd63\ud835\udd60\ud835\udd68\ud835\udd5f \ud835\udd57\ud835\udd60\ud835\udd69 \ud835\udd5b\ud835\udd66\ud835\udd5e\ud835\udd61\ud835\udd64 \ud835\udd60\ud835\udd67\ud835\udd56\ud835\udd63 \ud835\udd65\ud835\udd59\ud835\udd56 \ud835\udd5d\ud835\udd52\ud835\udd6b\ud835\udd6a \ud835\udd55\ud835\udd60\ud835\udd58": the1,
        "\u00241.00": the100,
        "1,0/0,0": the1000,
        "1 000.00": the100000,
        "1 000 000,00": the100000000,
        "1'; DROP TABLE users-- 1": the1DropTableUsers1,
        "1#IND": the1Ind,
        "1#INF": the1Inf,
        "\ud83d\ude0d": the2,
        "-2147483648/-1": the21474836481,
        "2.2250738585072011e-308": the22250738585072011E308,
        "ﷺ": the3,
        "１２３": the4,
        "# The next line may appear to be blank, mojibake, or dingbats in some viewers.": theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers,
        "# The next line may appear to be blank or mojibake in some viewers.": theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers,
        "# The next line may be flagged for \"trailing whitespace\" in some viewers.": theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers,
        "# This file unfortunately cannot express strings containing": thisFileUnfortunatelyCannotExpressStringsContaining,
        "\u0024(touch /tmp/blns.fail)": touchTmpBlnsFail,
        "() { _; } >_[\u0024(\u0024())] { touch /tmp/blns.shellshock2.fail; }": touchTmpBlnsShellshock2Fail,
        "Tyson Gay": tysonGay,
        "#\tUnicode Symbols": unicodeSymbols,
        "'`\"><\\x00script>javascript:alert(1)</script>": x00ScriptJavascriptAlert1Script,
        "'`\"><\\x3Cscript>javascript:alert(1)</script>": x3CscriptJavascriptAlert1Script,
    };
}

class C {
    final String a;
    final String aHrefX00JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX03JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX06JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX07JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX0BjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX12JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX14JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX15JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX18JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1BjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX1CjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefX20JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X85JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X88JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X89JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X80X8AjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE2X81X9FjavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String aHrefXE3X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA;
    final String abcDivStyleXExpressionX00JavascriptAlert1Def;
    final String abcDivStyleXX00ExpressionJavascriptAlert1Def;
    final String abcDivStyleXX0CexpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X81ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X86ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE2X80X88ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXE3X80X80ExpressionJavascriptAlert1Def;
    final String abcDivStyleXXEfXBbXBFexpressionJavascriptAlert1Def;
    final String ambitious;
    final String andU007FDel;
    final String asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome;
    final String bodyOnloadAlertXss;
    final String braggadocious;
    final String c;
    final String c00;
    final String c000;
    final String c1;
    final String c100;
    final String c100000;
    final String c100000000;
    final String c12;
    final String c1E02;
    final String cNull;
    final String cScriptAlert123Script;
    final String cTrue;
    final String clock;
    final String com2;
    final String com4;
    final String craigCockburnSoftwareSpecialist;
    final String cunning;
    final String dccSendStartkeylogger000;
    final bool dontMakeAMap;
    final String emoji;
    final String empty;
    final String evaluate;
    final String fluffy;
    final String fluffy00;
    final String fooValBar;
    final String frisky;
    final String hENEZPERDIANHIVMINFCASZALGO;
    final String hasOwnProperty;
    final String hilarious;
    final String hornimanMuseum;
    final String httpWwwCumQcCa;
    final String iOnwheelAlert1ScrollOverMeI;
    final String imgABCSrcDXEOnerrorFAlert1;
    final String imgOnmouseoverAlertXxs;
    final String imgScriptAlertXssScript;
    final String imgSrcJavascriptAlertStringFromCharCode888383;
    final String imgSrcJavascriptAlertXss;
    final String imgSrcOnerrorAltJavascriptAlert1;
    final String imgSrcX10XOnerrorJavascriptAlert1;
    final String imgSrcX12XOnerrorJavascriptAlert1;
    final String imgSrcX13XOnerrorJavascriptAlert1;
    final String imgSrcX32XOnerrorJavascriptAlert1;
    final String imgSrcX47XOnerrorJavascriptAlert1;
    final String imgSrcXOnerrorAlert123;
    final String imgSrcXOnerrorX10JavascriptAlert1;
    final String imgSrcXOnerrorX32JavascriptAlert1;
    final String imgSrcXScriptJavascriptAlert1Script;
    final String imgSrcXxxXX09OnerrorJavascriptAlert1;
    final String imgSrcXxxXX20OnerrorJavascriptAlert1;
    final String imgSrcXxxXX22OnerrorJavascriptAlert1;
    final String imgSrcXxxXX27OnerrorJavascriptAlert1;
    final String imgX11SrcXOnerrorJavascriptAlert1;
    final String imgX34SrcXOnerrorJavascriptAlert1;
    final String imgX47SrcXOnerrorJavascriptAlert1;
    final String indecent;
    final String indigo;
    final String infinity;
    final String javaSCriptAlert123;
    final String lpt1;
    final String ltScriptGtAlert3912339LtScriptGt;
    final String magenta;
    final String magnaCumLaude;
    final String medievalErectionOfParapets;
    final String mischievous;
    final String mocha;
    final String naN;
    final String nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F;
    final String onfocusJaVaSCriptAlert123Autofocus;
    final String orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever;
    final String plaintext;
    final String powerH;
    final String purple;
    final String purple00;
    final String purple100000;
    final String purple100000000;
    final String purpleScriptAlert123Script;
    final String rightToLeftStrings;
    final String rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue;
    final String s;
    final String scriptAlert123Script;
    final String scriptAlert123ScriptX;
    final String scriptJavascriptAlert1Script;
    final String scriptScriptAlert123Script;
    final String scriptSrcJscriptSScript;
    final String scriptX0AjavascriptAlert1Script;
    final String scriptX0BjavascriptAlert1Script;
    final String scriptX0CtypeTextJavascriptJavascriptAlert1Script;
    final String scriptX20JavascriptAlert1Script;
    final String scriptX2BjavascriptAlert1Script;
    final String scriptX2FtypeTextJavascriptJavascriptAlert1Script;
    final String scriptX7EjavascriptAlert1Script;
    final String scriptXE2X80X80JavascriptAlert1Script;
    final String scriptXE2X80X82JavascriptAlert1Script;
    final String scriptXE2X80X83JavascriptAlert1Script;
    final String scriptXE2X80X84JavascriptAlert1Script;
    final String scriptXE2X80X88JavascriptAlert1Script;
    final String scriptXE2X80X8BjavascriptAlert1Script;
    final String scriptXEfXBfXAEjavascriptAlert1Script;
    final String scriptXEfXBfXBEjavascriptAlert1Script;
    final String scunthorpeGeneralHospital;
    final String serverCodeInjection;
    final String shitakeMushrooms;
    final String specialCharacters;
    final String srcJaVaSCriptPrompt132;
    final String sticky;
    final String stringsWhichCanBeInterpretedAsNumeric;
    final String stringsWhichCanCauseASqlInjectionIfInputsAreNotSanitized;
    final String stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer;
    final String stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHttpsNewsYcombinatorComItemId7665153;
    final String stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHtmlTextHoweverViaHttpWwwEeemoNet;
    final String stringsWhichContainUnicodeWithAnUpsidedownEffectViaHttpWwwUpsidedowntextCom;
    final String stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHttpWwwUnicodeOrgChartsPdfU2000Pdf;
    final String stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile;
    final String svgScript1231Alert123Script;
    final String systemLsAl;
    final String systemTouchTmpBlnsFail;
    final String tentacled;
    final String test;
    final String testTest;
    final String the0;
    final String the00;
    final String the000;
    final String the0123456789;
    final String the0TouchTmpBlnsShellshock1Fail;
    final String the0Xabad1Dea;
    final String the0Xffffffff;
    final String the1;
    final String the10;
    final String the100;
    final String the100000;
    final String the100000000;
    final String the11;
    final String the12;
    final String the13;
    final String the14;
    final String the1E02;
    final String the1E2;
    final String the1Ind;
    final String the2;
    final String the3;
    final String the4;
    final String the5;
    final String the6;
    final String the7;
    final String the8;
    final String the9;
    final String the92233720368547758081;
    final String titleOnpropertychangeJavascriptAlert1TitleTitleTitle;
    final String treatedAsWhitespaceInSomeContexts;
    final String trickUnicode;
    final String undefined;
    final String unicodeAdditionalControlCharactersAllOfTheCharactersWith;
    final String unicodeSubscriptSuperscriptAccents;
    final String unicodeUpsidedown;
    final String user;
    final String version;
    final String version800PlusU0009HtU000BVtU000CFfU0085Nel;
    final String whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode;
    final String xmlVersion10EncodingIso88591DoctypeFooElementFooAnyEntityXxeSystemFileEtcPasswdFooXxeFoo;
    final String xxeInjectionXml;
    final String zalgoText;
    final String zz;

    C({
        required this.a,
        required this.aHrefX00JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX03JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX06JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX07JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX0BjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX12JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX14JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX15JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX18JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1BjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX1CjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefX20JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X85JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X88JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X89JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X80X8AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE2X81X9FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.aHrefXE3X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        required this.abcDivStyleXExpressionX00JavascriptAlert1Def,
        required this.abcDivStyleXX00ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXX0CexpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X81ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X86ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE2X80X88ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXE3X80X80ExpressionJavascriptAlert1Def,
        required this.abcDivStyleXXEfXBbXBFexpressionJavascriptAlert1Def,
        required this.ambitious,
        required this.andU007FDel,
        required this.asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome,
        required this.bodyOnloadAlertXss,
        required this.braggadocious,
        required this.c,
        required this.c00,
        required this.c000,
        required this.c1,
        required this.c100,
        required this.c100000,
        required this.c100000000,
        required this.c12,
        required this.c1E02,
        required this.cNull,
        required this.cScriptAlert123Script,
        required this.cTrue,
        required this.clock,
        required this.com2,
        required this.com4,
        required this.craigCockburnSoftwareSpecialist,
        required this.cunning,
        required this.dccSendStartkeylogger000,
        required this.dontMakeAMap,
        required this.emoji,
        required this.empty,
        required this.evaluate,
        required this.fluffy,
        required this.fluffy00,
        required this.fooValBar,
        required this.frisky,
        required this.hENEZPERDIANHIVMINFCASZALGO,
        required this.hasOwnProperty,
        required this.hilarious,
        required this.hornimanMuseum,
        required this.httpWwwCumQcCa,
        required this.iOnwheelAlert1ScrollOverMeI,
        required this.imgABCSrcDXEOnerrorFAlert1,
        required this.imgOnmouseoverAlertXxs,
        required this.imgScriptAlertXssScript,
        required this.imgSrcJavascriptAlertStringFromCharCode888383,
        required this.imgSrcJavascriptAlertXss,
        required this.imgSrcOnerrorAltJavascriptAlert1,
        required this.imgSrcX10XOnerrorJavascriptAlert1,
        required this.imgSrcX12XOnerrorJavascriptAlert1,
        required this.imgSrcX13XOnerrorJavascriptAlert1,
        required this.imgSrcX32XOnerrorJavascriptAlert1,
        required this.imgSrcX47XOnerrorJavascriptAlert1,
        required this.imgSrcXOnerrorAlert123,
        required this.imgSrcXOnerrorX10JavascriptAlert1,
        required this.imgSrcXOnerrorX32JavascriptAlert1,
        required this.imgSrcXScriptJavascriptAlert1Script,
        required this.imgSrcXxxXX09OnerrorJavascriptAlert1,
        required this.imgSrcXxxXX20OnerrorJavascriptAlert1,
        required this.imgSrcXxxXX22OnerrorJavascriptAlert1,
        required this.imgSrcXxxXX27OnerrorJavascriptAlert1,
        required this.imgX11SrcXOnerrorJavascriptAlert1,
        required this.imgX34SrcXOnerrorJavascriptAlert1,
        required this.imgX47SrcXOnerrorJavascriptAlert1,
        required this.indecent,
        required this.indigo,
        required this.infinity,
        required this.javaSCriptAlert123,
        required this.lpt1,
        required this.ltScriptGtAlert3912339LtScriptGt,
        required this.magenta,
        required this.magnaCumLaude,
        required this.medievalErectionOfParapets,
        required this.mischievous,
        required this.mocha,
        required this.naN,
        required this.nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F,
        required this.onfocusJaVaSCriptAlert123Autofocus,
        required this.orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever,
        required this.plaintext,
        required this.powerH,
        required this.purple,
        required this.purple00,
        required this.purple100000,
        required this.purple100000000,
        required this.purpleScriptAlert123Script,
        required this.rightToLeftStrings,
        required this.rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue,
        required this.s,
        required this.scriptAlert123Script,
        required this.scriptAlert123ScriptX,
        required this.scriptJavascriptAlert1Script,
        required this.scriptScriptAlert123Script,
        required this.scriptSrcJscriptSScript,
        required this.scriptX0AjavascriptAlert1Script,
        required this.scriptX0BjavascriptAlert1Script,
        required this.scriptX0CtypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX20JavascriptAlert1Script,
        required this.scriptX2BjavascriptAlert1Script,
        required this.scriptX2FtypeTextJavascriptJavascriptAlert1Script,
        required this.scriptX7EjavascriptAlert1Script,
        required this.scriptXE2X80X80JavascriptAlert1Script,
        required this.scriptXE2X80X82JavascriptAlert1Script,
        required this.scriptXE2X80X83JavascriptAlert1Script,
        required this.scriptXE2X80X84JavascriptAlert1Script,
        required this.scriptXE2X80X88JavascriptAlert1Script,
        required this.scriptXE2X80X8BjavascriptAlert1Script,
        required this.scriptXEfXBfXAEjavascriptAlert1Script,
        required this.scriptXEfXBfXBEjavascriptAlert1Script,
        required this.scunthorpeGeneralHospital,
        required this.serverCodeInjection,
        required this.shitakeMushrooms,
        required this.specialCharacters,
        required this.srcJaVaSCriptPrompt132,
        required this.sticky,
        required this.stringsWhichCanBeInterpretedAsNumeric,
        required this.stringsWhichCanCauseASqlInjectionIfInputsAreNotSanitized,
        required this.stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer,
        required this.stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHttpsNewsYcombinatorComItemId7665153,
        required this.stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHtmlTextHoweverViaHttpWwwEeemoNet,
        required this.stringsWhichContainUnicodeWithAnUpsidedownEffectViaHttpWwwUpsidedowntextCom,
        required this.stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHttpWwwUnicodeOrgChartsPdfU2000Pdf,
        required this.stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile,
        required this.svgScript1231Alert123Script,
        required this.systemLsAl,
        required this.systemTouchTmpBlnsFail,
        required this.tentacled,
        required this.test,
        required this.testTest,
        required this.the0,
        required this.the00,
        required this.the000,
        required this.the0123456789,
        required this.the0TouchTmpBlnsShellshock1Fail,
        required this.the0Xabad1Dea,
        required this.the0Xffffffff,
        required this.the1,
        required this.the10,
        required this.the100,
        required this.the100000,
        required this.the100000000,
        required this.the11,
        required this.the12,
        required this.the13,
        required this.the14,
        required this.the1E02,
        required this.the1E2,
        required this.the1Ind,
        required this.the2,
        required this.the3,
        required this.the4,
        required this.the5,
        required this.the6,
        required this.the7,
        required this.the8,
        required this.the9,
        required this.the92233720368547758081,
        required this.titleOnpropertychangeJavascriptAlert1TitleTitleTitle,
        required this.treatedAsWhitespaceInSomeContexts,
        required this.trickUnicode,
        required this.undefined,
        required this.unicodeAdditionalControlCharactersAllOfTheCharactersWith,
        required this.unicodeSubscriptSuperscriptAccents,
        required this.unicodeUpsidedown,
        required this.user,
        required this.version,
        required this.version800PlusU0009HtU000BVtU000CFfU0085Nel,
        required this.whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode,
        required this.xmlVersion10EncodingIso88591DoctypeFooElementFooAnyEntityXxeSystemFileEtcPasswdFooXxeFoo,
        required this.xxeInjectionXml,
        required this.zalgoText,
        required this.zz,
    });

    factory C.fromJson(Map<String, dynamic> json) => C(
        a: json["A:"],
        aHrefX00JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX03JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX06JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX07JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX0BjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX12JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX14JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX15JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX18JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1BjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX1CjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefX20JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X85JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X88JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X89JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X80X8AjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE2X81X9FjavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        aHrefXE3X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA: json["<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"],
        abcDivStyleXExpressionX00JavascriptAlert1Def: json["ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"],
        abcDivStyleXX00ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"],
        abcDivStyleXX0CexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X81ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X86ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE2X80X88ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXE3X80X80ExpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"],
        abcDivStyleXXEfXBbXBFexpressionJavascriptAlert1Def: json["ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"],
        ambitious: json["."],
        andU007FDel: json["# and U+007F (DEL)"],
        asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: json["# ASCII punctuation.  All of these characters may need to be escaped in some"],
        bodyOnloadAlertXss: json["<BODY onload!#\u0024%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"],
        braggadocious: json["בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"],
        c: json["\"'\"'\"''''\""],
        c00: json["-0.0"],
        c000: json["0.0/0"],
        c1: json["--1"],
        c100: json["-1.00"],
        c100000: json["1,000.00"],
        c100000000: json["1,000,000.00"],
        c12: json["-1/2"],
        c1E02: json["1E+02"],
        cNull: json["NULL"],
        cScriptAlert123Script: json["><script>alert(123)</script>"],
        cTrue: json["true"],
        clock: json["CLOCK\u0024"],
        com2: json["COM2"],
        com4: json["COM4"],
        craigCockburnSoftwareSpecialist: json["Craig Cockburn, Software Specialist"],
        cunning: json["\\\\"],
        dccSendStartkeylogger000: json["DCC SEND STARTKEYLOGGER 0 0 0"],
        dontMakeAMap: json["dontMakeAMap"],
        emoji: json["#\tEmoji"],
        empty: json["\"\""],
        evaluate: json["evaluate"],
        fluffy: json["%"],
        fluffy00: json["0/0"],
        fooValBar: json["<foo val=“bar” />"],
        frisky: json["ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃"],
        hENEZPERDIANHIVMINFCASZALGO: json["̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"],
        hasOwnProperty: json["hasOwnProperty"],
        hilarious: json["--"],
        hornimanMuseum: json["Horniman Museum"],
        httpWwwCumQcCa: json["http://www.cum.qc.ca/"],
        iOnwheelAlert1ScrollOverMeI: json["<i onwheel=alert(1)> Scroll over me </i>"],
        imgABCSrcDXEOnerrorFAlert1: json["<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"],
        imgOnmouseoverAlertXxs: json["<IMG onmouseover=\"alert('xxs')\">"],
        imgScriptAlertXssScript: json["<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"],
        imgSrcJavascriptAlertStringFromCharCode888383: json["<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"],
        imgSrcJavascriptAlertXss: json["<IMG SRC=\"javascript:alert('XSS')\""],
        imgSrcOnerrorAltJavascriptAlert1: json["<img src onerror /\" '\"= alt=javascript:alert(1)//\">"],
        imgSrcX10XOnerrorJavascriptAlert1: json["<img src\\x10=x onerror=\"javascript:alert(1)\">"],
        imgSrcX12XOnerrorJavascriptAlert1: json["<img src\\x12=x onerror=\"javascript:alert(1)\">"],
        imgSrcX13XOnerrorJavascriptAlert1: json["<img src\\x13=x onerror=\"javascript:alert(1)\">"],
        imgSrcX32XOnerrorJavascriptAlert1: json["<img src\\x32=x onerror=\"javascript:alert(1)\">"],
        imgSrcX47XOnerrorJavascriptAlert1: json["<img src\\x47=x onerror=\"javascript:alert(1)\">"],
        imgSrcXOnerrorAlert123: json["<img src=x onerror=alert(123) />"],
        imgSrcXOnerrorX10JavascriptAlert1: json["<img src=x onerror=\\x10\"javascript:alert(1)\">"],
        imgSrcXOnerrorX32JavascriptAlert1: json["<img src=x onerror=\\x32\"javascript:alert(1)\">"],
        imgSrcXScriptJavascriptAlert1Script: json["<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"],
        imgSrcXxxXX09OnerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"],
        imgSrcXxxXX20OnerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"],
        imgSrcXxxXX22OnerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"],
        imgSrcXxxXX27OnerrorJavascriptAlert1: json["`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"],
        imgX11SrcXOnerrorJavascriptAlert1: json["<img\\x11src=x onerror=\"javascript:alert(1)\">"],
        imgX34SrcXOnerrorJavascriptAlert1: json["<img \\x34src=x onerror=\"javascript:alert(1)\">"],
        imgX47SrcXOnerrorJavascriptAlert1: json["<img\\x47src=x onerror=\"javascript:alert(1)\">"],
        indecent: json["-"],
        indigo: json[",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"],
        infinity: json["Infinity"],
        javaSCriptAlert123: json["JavaSCript:alert(123)"],
        lpt1: json["LPT1"],
        ltScriptGtAlert3912339LtScriptGt: json["&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"],
        magenta: json["_"],
        magnaCumLaude: json["magna cum laude"],
        medievalErectionOfParapets: json["medieval erection of parapets"],
        mischievous: json["ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"],
        mocha: json["mocha"],
        naN: json["NaN"],
        nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: json["# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"],
        onfocusJaVaSCriptAlert123Autofocus: json["' onfocus=JaVaSCript:alert(123) autofocus"],
        orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: json["# or reused for internal delimiters on the theory that they should never"],
        plaintext: json["<plaintext>"],
        powerH: json["Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"],
        purple: json["\"''''\"'\""],
        purple00: json["0,,0"],
        purple100000: json["1.000,00"],
        purple100000000: json["1.000.000,00"],
        purpleScriptAlert123Script: json["＜script＞alert(123)＜/script＞"],
        rightToLeftStrings: json["#\tRight-To-Left Strings"],
        rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: json["Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue"],
        s: json["%*.*s"],
        scriptAlert123Script: json["'><script>alert(123)</script>"],
        scriptAlert123ScriptX: json["'><script>alert(123);</script x='"],
        scriptJavascriptAlert1Script: json["\"`'><script>-javascript:alert(1)</script>"],
        scriptScriptAlert123Script: json["< / script >< script >alert(123)< / script >"],
        scriptSrcJscriptSScript: json["<script src=\"/\\%(jscript)s\"></script>"],
        scriptX0AjavascriptAlert1Script: json["\"`'><script>\\x0Ajavascript:alert(1)</script>"],
        scriptX0BjavascriptAlert1Script: json["\"`'><script>\\x0Bjavascript:alert(1)</script>"],
        scriptX0CtypeTextJavascriptJavascriptAlert1Script: json["<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX20JavascriptAlert1Script: json["\"`'><script>\\x20javascript:alert(1)</script>"],
        scriptX2BjavascriptAlert1Script: json["\"`'><script>\\x2Bjavascript:alert(1)</script>"],
        scriptX2FtypeTextJavascriptJavascriptAlert1Script: json["<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"],
        scriptX7EjavascriptAlert1Script: json["\"`'><script>\\x7Ejavascript:alert(1)</script>"],
        scriptXE2X80X80JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"],
        scriptXE2X80X82JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"],
        scriptXE2X80X83JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"],
        scriptXE2X80X84JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"],
        scriptXE2X80X88JavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"],
        scriptXE2X80X8BjavascriptAlert1Script: json["\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"],
        scriptXEfXBfXAEjavascriptAlert1Script: json["\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"],
        scriptXEfXBfXBEjavascriptAlert1Script: json["\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"],
        scunthorpeGeneralHospital: json["Scunthorpe General Hospital"],
        serverCodeInjection: json["#\tServer Code Injection"],
        shitakeMushrooms: json["shitake mushrooms"],
        specialCharacters: json["#\tSpecial Characters"],
        srcJaVaSCriptPrompt132: json["src=JaVaSCript:prompt(132)"],
        sticky: json["(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻"],
        stringsWhichCanBeInterpretedAsNumeric: json["#\tStrings which can be interpreted as numeric"],
        stringsWhichCanCauseASqlInjectionIfInputsAreNotSanitized: json["#\tStrings which can cause a SQL injection if inputs are not sanitized"],
        stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: json["#\tStrings which can cause user to pull in files that should not be a part of a web server"],
        stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHttpsNewsYcombinatorComItemId7665153: json["#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"],
        stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHtmlTextHoweverViaHttpWwwEeemoNet: json["#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"],
        stringsWhichContainUnicodeWithAnUpsidedownEffectViaHttpWwwUpsidedowntextCom: json["#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"],
        stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHttpWwwUnicodeOrgChartsPdfU2000Pdf: json["#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"],
        stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: json["#\tStrings which punish the fools who use cat/type on this file"],
        svgScript1231Alert123Script: json["<svg><script>123<1>alert(123)</script>"],
        systemLsAl: json["System(\"ls -al /\")"],
        systemTouchTmpBlnsFail: json["@{[system \"touch /tmp/blns.fail\"]}"],
        tentacled: json["''"],
        test: json["\u2029test\u2029"],
        testTest: json["test\u2060test\u202b"],
        the0: json["\ud83c\udff30\ud83c\udf08️"],
        the00: json["+0.0"],
        the000: json["0.0.0"],
        the0123456789: json["0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \ud83d\udd1f"],
        the0TouchTmpBlnsShellshock1Fail: json["() { 0; }; touch /tmp/blns.shellshock1.fail;"],
        the0Xabad1Dea: json["0xabad1dea"],
        the0Xffffffff: json["0xffffffff"],
        the1: json["مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "],
        the10: json["\ud835\ude83\ud835\ude91\ud835\ude8e \ud835\ude9a\ud835\ude9e\ud835\ude92\ud835\ude8c\ud835\ude94 \ud835\ude8b\ud835\ude9b\ud835\ude98\ud835\udea0\ud835\ude97 \ud835\ude8f\ud835\ude98\ud835\udea1 \ud835\ude93\ud835\ude9e\ud835\ude96\ud835\ude99\ud835\ude9c \ud835\ude98\ud835\ude9f\ud835\ude8e\ud835\ude9b \ud835\ude9d\ud835\ude91\ud835\ude8e \ud835\ude95\ud835\ude8a\ud835\udea3\ud835\udea2 \ud835\ude8d\ud835\ude98\ud835\ude90"],
        the100: json["-\u00241.00"],
        the100000: json["1 000,00"],
        the100000000: json["1'000'000,00"],
        the11: json["\ud83d\udc35 \ud83d\ude48 \ud83d\ude49 \ud83d\ude4a"],
        the12: json["\ud83d\udc7e \ud83d\ude47 \ud83d\udc81 \ud83d\ude45 \ud83d\ude46 \ud83d\ude4b \ud83d\ude4e \ud83d\ude4d"],
        the13: json["\ud841\udf0e\ud841\udf31\ud841\udf79\ud843\udc53\ud843\udc78\ud843\udc96\ud843\udccf"],
        the14: json["Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"],
        the1E02: json["-1E+02"],
        the1E2: json["-1E2"],
        the1Ind: json["-1#IND"],
        the2: json["١٢٣"],
        the3: json["⁰⁴⁵"],
        the4: json["⅛⅜⅝⅞"],
        the5: json["┬─┬ノ( º _ ºノ)"],
        the6: json["✋\ud83c\udfff \ud83d\udcaa\ud83c\udfff \ud83d\udc50\ud83c\udfff \ud83d\ude4c\ud83c\udfff \ud83d\udc4f\ud83c\udfff \ud83d\ude4f\ud83c\udfff"],
        the7: json["・(￣∀￣)・:*:"],
        the8: json["울란바토르"],
        the9: json["\ud835\udc13\ud835\udc21\ud835\udc1e \ud835\udc2a\ud835\udc2e\ud835\udc22\ud835\udc1c\ud835\udc24 \ud835\udc1b\ud835\udc2b\ud835\udc28\ud835\udc30\ud835\udc27 \ud835\udc1f\ud835\udc28\ud835\udc31 \ud835\udc23\ud835\udc2e\ud835\udc26\ud835\udc29\ud835\udc2c \ud835\udc28\ud835\udc2f\ud835\udc1e\ud835\udc2b \ud835\udc2d\ud835\udc21\ud835\udc1e \ud835\udc25\ud835\udc1a\ud835\udc33\ud835\udc32 \ud835\udc1d\ud835\udc28\ud835\udc20"],
        the92233720368547758081: json["-9223372036854775808/-1"],
        titleOnpropertychangeJavascriptAlert1TitleTitleTitle: json["<title onpropertychange=javascript:alert(1)></title><title title=>"],
        treatedAsWhitespaceInSomeContexts: json["# treated as whitespace in some contexts."],
        trickUnicode: json["#\tTrick Unicode"],
        undefined: json["undefined"],
        unicodeAdditionalControlCharactersAllOfTheCharactersWith: json["# Unicode additional control characters: all of the characters with"],
        unicodeSubscriptSuperscriptAccents: json["#\tUnicode Subscript/Superscript/Accents"],
        unicodeUpsidedown: json["#\tUnicode Upsidedown"],
        user: json["\u0024USER"],
        version: json["--version"],
        version800PlusU0009HtU000BVtU000CFfU0085Nel: json["# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"],
        whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: json["# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"],
        xmlVersion10EncodingIso88591DoctypeFooElementFooAnyEntityXxeSystemFileEtcPasswdFooXxeFoo: json["<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"],
        xxeInjectionXml: json["#      XXE Injection (XML)"],
        zalgoText: json["#\tZalgo Text"],
        zz: json["ZZ:"],
    );

    Map<String, dynamic> toJson() => {
        "A:": a,
        "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX00JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX03JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX06JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX07JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX0BjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX12JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX14JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX15JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX18JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1BjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX1CjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefX20JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X85JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X88JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X89JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X80X8AjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE2X81X9FjavascriptJavascriptAlert1IdFuzzelement1TestA,
        "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>": aHrefXE3X80X80JavascriptJavascriptAlert1IdFuzzelement1TestA,
        "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF": abcDivStyleXExpressionX00JavascriptAlert1Def,
        "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF": abcDivStyleXX00ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF": abcDivStyleXX0CexpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X81ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X86ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF": abcDivStyleXXE2X80X88ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF": abcDivStyleXXE3X80X80ExpressionJavascriptAlert1Def,
        "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF": abcDivStyleXXEfXBbXBFexpressionJavascriptAlert1Def,
        ".": ambitious,
        "# and U+007F (DEL)": andU007FDel,
        "# ASCII punctuation.  All of these characters may need to be escaped in some": asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome,
        "<BODY onload!#\u0024%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>": bodyOnloadAlertXss,
        "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ": braggadocious,
        "\"'\"'\"''''\"": c,
        "-0.0": c00,
        "0.0/0": c000,
        "--1": c1,
        "-1.00": c100,
        "1,000.00": c100000,
        "1,000,000.00": c100000000,
        "-1/2": c12,
        "1E+02": c1E02,
        "NULL": cNull,
        "><script>alert(123)</script>": cScriptAlert123Script,
        "true": cTrue,
        "CLOCK\u0024": clock,
        "COM2": com2,
        "COM4": com4,
        "Craig Cockburn, Software Specialist": craigCockburnSoftwareSpecialist,
        "\\\\": cunning,
        "DCC SEND STARTKEYLOGGER 0 0 0": dccSendStartkeylogger000,
        "dontMakeAMap": dontMakeAMap,
        "#\tEmoji": emoji,
        "\"\"": empty,
        "evaluate": evaluate,
        "%": fluffy,
        "0/0": fluffy00,
        "<foo val=“bar” />": fooValBar,
        "ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃": frisky,
        "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟": hENEZPERDIANHIVMINFCASZALGO,
        "hasOwnProperty": hasOwnProperty,
        "--": hilarious,
        "Horniman Museum": hornimanMuseum,
        "http://www.cum.qc.ca/": httpWwwCumQcCa,
        "<i onwheel=alert(1)> Scroll over me </i>": iOnwheelAlert1ScrollOverMeI,
        "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">": imgABCSrcDXEOnerrorFAlert1,
        "<IMG onmouseover=\"alert('xxs')\">": imgOnmouseoverAlertXxs,
        "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">": imgScriptAlertXssScript,
        "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>": imgSrcJavascriptAlertStringFromCharCode888383,
        "<IMG SRC=\"javascript:alert('XSS')\"": imgSrcJavascriptAlertXss,
        "<img src onerror /\" '\"= alt=javascript:alert(1)//\">": imgSrcOnerrorAltJavascriptAlert1,
        "<img src\\x10=x onerror=\"javascript:alert(1)\">": imgSrcX10XOnerrorJavascriptAlert1,
        "<img src\\x12=x onerror=\"javascript:alert(1)\">": imgSrcX12XOnerrorJavascriptAlert1,
        "<img src\\x13=x onerror=\"javascript:alert(1)\">": imgSrcX13XOnerrorJavascriptAlert1,
        "<img src\\x32=x onerror=\"javascript:alert(1)\">": imgSrcX32XOnerrorJavascriptAlert1,
        "<img src\\x47=x onerror=\"javascript:alert(1)\">": imgSrcX47XOnerrorJavascriptAlert1,
        "<img src=x onerror=alert(123) />": imgSrcXOnerrorAlert123,
        "<img src=x onerror=\\x10\"javascript:alert(1)\">": imgSrcXOnerrorX10JavascriptAlert1,
        "<img src=x onerror=\\x32\"javascript:alert(1)\">": imgSrcXOnerrorX32JavascriptAlert1,
        "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>": imgSrcXScriptJavascriptAlert1Script,
        "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>": imgSrcXxxXX09OnerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>": imgSrcXxxXX20OnerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>": imgSrcXxxXX22OnerrorJavascriptAlert1,
        "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>": imgSrcXxxXX27OnerrorJavascriptAlert1,
        "<img\\x11src=x onerror=\"javascript:alert(1)\">": imgX11SrcXOnerrorJavascriptAlert1,
        "<img \\x34src=x onerror=\"javascript:alert(1)\">": imgX34SrcXOnerrorJavascriptAlert1,
        "<img\\x47src=x onerror=\"javascript:alert(1)\">": imgX47SrcXOnerrorJavascriptAlert1,
        "-": indecent,
        ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’": indigo,
        "Infinity": infinity,
        "JavaSCript:alert(123)": javaSCriptAlert123,
        "LPT1": lpt1,
        "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;": ltScriptGtAlert3912339LtScriptGt,
        "_": magenta,
        "magna cum laude": magnaCumLaude,
        "medieval erection of parapets": medievalErectionOfParapets,
        "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя": mischievous,
        "mocha": mocha,
        "NaN": naN,
        "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,": nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F,
        "' onfocus=JaVaSCript:alert(123) autofocus": onfocusJaVaSCriptAlert123Autofocus,
        "# or reused for internal delimiters on the theory that they should never": orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever,
        "<plaintext>": plaintext,
        "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗": powerH,
        "\"''''\"'\"": purple,
        "0,,0": purple00,
        "1.000,00": purple100000,
        "1.000.000,00": purple100000000,
        "＜script＞alert(123)＜/script＞": purpleScriptAlert123Script,
        "#\tRight-To-Left Strings": rightToLeftStrings,
        "Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue": rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue,
        "%*.*s": s,
        "'><script>alert(123)</script>": scriptAlert123Script,
        "'><script>alert(123);</script x='": scriptAlert123ScriptX,
        "\"`'><script>-javascript:alert(1)</script>": scriptJavascriptAlert1Script,
        "< / script >< script >alert(123)< / script >": scriptScriptAlert123Script,
        "<script src=\"/\\%(jscript)s\"></script>": scriptSrcJscriptSScript,
        "\"`'><script>\\x0Ajavascript:alert(1)</script>": scriptX0AjavascriptAlert1Script,
        "\"`'><script>\\x0Bjavascript:alert(1)</script>": scriptX0BjavascriptAlert1Script,
        "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>": scriptX0CtypeTextJavascriptJavascriptAlert1Script,
        "\"`'><script>\\x20javascript:alert(1)</script>": scriptX20JavascriptAlert1Script,
        "\"`'><script>\\x2Bjavascript:alert(1)</script>": scriptX2BjavascriptAlert1Script,
        "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>": scriptX2FtypeTextJavascriptJavascriptAlert1Script,
        "\"`'><script>\\x7Ejavascript:alert(1)</script>": scriptX7EjavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>": scriptXE2X80X80JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>": scriptXE2X80X82JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>": scriptXE2X80X83JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>": scriptXE2X80X84JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>": scriptXE2X80X88JavascriptAlert1Script,
        "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>": scriptXE2X80X8BjavascriptAlert1Script,
        "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>": scriptXEfXBfXAEjavascriptAlert1Script,
        "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>": scriptXEfXBfXBEjavascriptAlert1Script,
        "Scunthorpe General Hospital": scunthorpeGeneralHospital,
        "#\tServer Code Injection": serverCodeInjection,
        "shitake mushrooms": shitakeMushrooms,
        "#\tSpecial Characters": specialCharacters,
        "src=JaVaSCript:prompt(132)": srcJaVaSCriptPrompt132,
        "(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻": sticky,
        "#\tStrings which can be interpreted as numeric": stringsWhichCanBeInterpretedAsNumeric,
        "#\tStrings which can cause a SQL injection if inputs are not sanitized": stringsWhichCanCauseASqlInjectionIfInputsAreNotSanitized,
        "#\tStrings which can cause user to pull in files that should not be a part of a web server": stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer,
        "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)": stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHttpsNewsYcombinatorComItemId7665153,
        "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)": stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHtmlTextHoweverViaHttpWwwEeemoNet,
        "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)": stringsWhichContainUnicodeWithAnUpsidedownEffectViaHttpWwwUpsidedowntextCom,
        "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)": stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHttpWwwUnicodeOrgChartsPdfU2000Pdf,
        "#\tStrings which punish the fools who use cat/type on this file": stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile,
        "<svg><script>123<1>alert(123)</script>": svgScript1231Alert123Script,
        "System(\"ls -al /\")": systemLsAl,
        "@{[system \"touch /tmp/blns.fail\"]}": systemTouchTmpBlnsFail,
        "''": tentacled,
        "\u2029test\u2029": test,
        "test\u2060test\u202b": testTest,
        "\ud83c\udff30\ud83c\udf08️": the0,
        "+0.0": the00,
        "0.0.0": the000,
        "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \ud83d\udd1f": the0123456789,
        "() { 0; }; touch /tmp/blns.shellshock1.fail;": the0TouchTmpBlnsShellshock1Fail,
        "0xabad1dea": the0Xabad1Dea,
        "0xffffffff": the0Xffffffff,
        "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ": the1,
        "\ud835\ude83\ud835\ude91\ud835\ude8e \ud835\ude9a\ud835\ude9e\ud835\ude92\ud835\ude8c\ud835\ude94 \ud835\ude8b\ud835\ude9b\ud835\ude98\ud835\udea0\ud835\ude97 \ud835\ude8f\ud835\ude98\ud835\udea1 \ud835\ude93\ud835\ude9e\ud835\ude96\ud835\ude99\ud835\ude9c \ud835\ude98\ud835\ude9f\ud835\ude8e\ud835\ude9b \ud835\ude9d\ud835\ude91\ud835\ude8e \ud835\ude95\ud835\ude8a\ud835\udea3\ud835\udea2 \ud835\ude8d\ud835\ude98\ud835\ude90": the10,
        "-\u00241.00": the100,
        "1 000,00": the100000,
        "1'000'000,00": the100000000,
        "\ud83d\udc35 \ud83d\ude48 \ud83d\ude49 \ud83d\ude4a": the11,
        "\ud83d\udc7e \ud83d\ude47 \ud83d\udc81 \ud83d\ude45 \ud83d\ude46 \ud83d\ude4b \ud83d\ude4e \ud83d\ude4d": the12,
        "\ud841\udf0e\ud841\udf31\ud841\udf79\ud843\udc53\ud843\udc78\ud843\udc96\ud843\udccf": the13,
        "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ": the14,
        "-1E+02": the1E02,
        "-1E2": the1E2,
        "-1#IND": the1Ind,
        "١٢٣": the2,
        "⁰⁴⁵": the3,
        "⅛⅜⅝⅞": the4,
        "┬─┬ノ( º _ ºノ)": the5,
        "✋\ud83c\udfff \ud83d\udcaa\ud83c\udfff \ud83d\udc50\ud83c\udfff \ud83d\ude4c\ud83c\udfff \ud83d\udc4f\ud83c\udfff \ud83d\ude4f\ud83c\udfff": the6,
        "・(￣∀￣)・:*:": the7,
        "울란바토르": the8,
        "\ud835\udc13\ud835\udc21\ud835\udc1e \ud835\udc2a\ud835\udc2e\ud835\udc22\ud835\udc1c\ud835\udc24 \ud835\udc1b\ud835\udc2b\ud835\udc28\ud835\udc30\ud835\udc27 \ud835\udc1f\ud835\udc28\ud835\udc31 \ud835\udc23\ud835\udc2e\ud835\udc26\ud835\udc29\ud835\udc2c \ud835\udc28\ud835\udc2f\ud835\udc1e\ud835\udc2b \ud835\udc2d\ud835\udc21\ud835\udc1e \ud835\udc25\ud835\udc1a\ud835\udc33\ud835\udc32 \ud835\udc1d\ud835\udc28\ud835\udc20": the9,
        "-9223372036854775808/-1": the92233720368547758081,
        "<title onpropertychange=javascript:alert(1)></title><title title=>": titleOnpropertychangeJavascriptAlert1TitleTitleTitle,
        "# treated as whitespace in some contexts.": treatedAsWhitespaceInSomeContexts,
        "#\tTrick Unicode": trickUnicode,
        "undefined": undefined,
        "# Unicode additional control characters: all of the characters with": unicodeAdditionalControlCharactersAllOfTheCharactersWith,
        "#\tUnicode Subscript/Superscript/Accents": unicodeSubscriptSuperscriptAccents,
        "#\tUnicode Upsidedown": unicodeUpsidedown,
        "\u0024USER": user,
        "--version": version,
        "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),": version800PlusU0009HtU000BVtU000CFfU0085Nel,
        "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode": whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode,
        "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>": xmlVersion10EncodingIso88591DoctypeFooElementFooAnyEntityXxeSystemFileEtcPasswdFooXxeFoo,
        "#      XXE Injection (XML)": xxeInjectionXml,
        "#\tZalgo Text": zalgoText,
        "ZZ:": zz,
    };
}
