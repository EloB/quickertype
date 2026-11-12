// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let a: A
    let b: B
    let c: C

    enum CodingKeys: String, CodingKey {
        case a = "a"
        case b = "b"
        case c = "c"
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        a: A? = nil,
        b: B? = nil,
        c: C? = nil
    ) -> TopLevel {
        return TopLevel(
            a: a ?? self.a,
            b: b ?? self.b,
            c: c ?? self.c
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - A
struct A: Codable {
    let a: String
    let a0: String
    let a000: String
    let a0000: String
    let a1: String
    let a100000000: String
    let a1E02: String
    let aAlert123T: String
    let aFalse: String
    let aHrefJava123456781112ScriptJavascriptAlert1XXXA: String
    let aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA: String
    let aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aNil: String
    let aTRUE: String
    let aTest: String
    let aTrue: String
    let abcDivStyleXExpX00RessionJavascriptAlert1DEF: String
    let abcDivStyleXExpX5CressionJavascriptAlert1DEF: String
    let abcDivStyleXX09ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXX0BexpressionJavascriptAlert1DEF: String
    let abcDivStyleXX20ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXX3AexpressionJavascriptAlert1DEF: String
    let abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF: String
    let alert123: String
    let alert123T: String
    let alertXSS: String
    let ambitious: String
    let andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften: String
    let arsenalCanal: String
    let autofocusOnkeyupJavascriptAlert123: String
    let aux: String
    let braggadocious: String
    let changingLengthWhenLowercased: String
    let charactersWhichIncreaseInLength2To3BytesWhenLowercased: String
    let classic: String
    let commandInjectionRuby: String
    let cunning: String
    let d: String
    let dickVanDyke: String
    let dontMakeAMap: Bool
    let drHermanILibshitz: String
    let empty: String
    let envHome: String
    let etcHosts: String
    let etcPasswd00: String
    let fluffy: String
    let fluffy0: String
    let fontsAndHaveANumberOfSpecialBehaviors: String
    let fooValBar: String
    let frisky: String
    let hilarious: String
    let home: String
    let humanInjection: String
    let iNVOkINGTHEFÈẸLINGOFCHÁOS: String
    let ifImgSrcXOnerrorJavascriptAlert1: String
    let ifScriptJavascriptAlert1Script: String
    let imgSRCJavAscriptAlertXSS: String
    let imgSRCJavX0AAscriptAlertXSS: String
    let imgSRCJavX0DAscriptAlertXSS: String
    let imgSrc106971189711599114105112116589710810111411640398883833941: String
    let imgSrcX09XOnerrorJavascriptAlert1: String
    let imgSrcX11XOnerrorJavascriptAlert1: String
    let imgSrcXOnerrorX00JavascriptAlert1: String
    let imgSrcXOnerrorX09JavascriptAlert1: String
    let imgSrcXX09OnerrorJavascriptAlert1: String
    let imgSrcXX10OnerrorJavascriptAlert1: String
    let imgSrcXX11OnerrorJavascriptAlert1: String
    let imgSrcXX12OnerrorJavascriptAlert1: String
    let imgSrcXX13OnerrorJavascriptAlert1: String
    let imgSrcXxxXX00OnerrorJavascriptAlert1: String
    let imgSrcXxxXX0BonerrorJavascriptAlert1: String
    let imgSrcXxxXX2FonerrorJavascriptAlert1: String
    let imgX00SrcXOnerrorAlert1: String
    let imgX10SrcXOnerrorJavascriptAlert1: String
    let imgX13SrcXOnerrorJavascriptAlert1: String
    let imgX32SrcXOnerrorJavascriptAlert1: String
    let imgX39SrcXOnerrorJavascriptAlert1: String
    let indecent: String
    let indigo: String
    let inf: String
    let infinity: String
    let innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem: String
    let jimmyClitheroe: String
    let kernelExit1: String
    let knownCVEsAndVulnerabilities: String
    let lightwaterCountryPark: String
    let lpt2: String
    let lpt3: String
    let lsAl: String
    let magenta: String
    let mischievous: String
    let msdosWindowsSpecialFilenames: String
    let nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: String
    let none: String
    let null: String
    let onfocusJaVaSCriptAlert123Autofocus: String
    let or11: String
    let penistoneCommunityChurch: String
    let perlEPrintIMGSRCJava0ScriptAlertXSSOut: String
    let prn: String
    let purple: String
    let purple0: String
    let purpleFalse: String
    let purpleTest: String
    let romansInSussexCoUk: String
    let s: String
    let sUnSU: String
    let scScriptRiptAlert123ScScriptRipt: String
    let scriptAlert123ScriptX: String
    let scriptInjection: String
    let scriptSRCHTTPHaCkersOrgXSSJSB: String
    let scriptSRCHTTPHaCkersOrgXSSJSSCRIPT: String
    let scriptScriptAlert123Script: String
    let scriptX00JavascriptAlert1Script: String
    let scriptX09TypeTextJavascriptJavascriptAlert1Script: String
    let scriptX0CjavascriptAlert1Script: String
    let scriptX0DjavascriptAlert1Script: String
    let scriptX20TypeTextJavascriptJavascriptAlert1Script: String
    let scriptX3EtypeTextJavascriptJavascriptAlert1Script: String
    let scriptXC2X85JavascriptAlert1Script: String
    let scriptXC2XA0JavascriptAlert1Script: String
    let scriptXE1X9AX80JavascriptAlert1Script: String
    let scriptXE1XA0X8EjavascriptAlert1Script: String
    let scriptXE2X80X81JavascriptAlert1Script: String
    let scriptXE2X80X86JavascriptAlert1Script: String
    let scriptXE2X80X89JavascriptAlert1Script: String
    let scriptXE2X81X9FjavascriptAlert1Script: String
    let scriptXEFXBBXBFjavascriptAlert1Script: String
    let scriptXF0X90X96X9AjavascriptAlert1Script: String
    let scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT: String
    let sqlInjection: String
    let sticky: String
    let stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser: String
    let stringsThatTestForKnownVulnerabilities: String
    let stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: String
    let stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: String
    let stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: String
    let stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: String
    let stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: String
    let stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: String
    let stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: String
    let stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: String
    let stringsWhichCrashedIMessageInVariousVersionsOfIOS: String
    let stringsWhichMayCauseHumanToReinterpretWorldview: String
    let superBowlXXX: String
    let tentacled: String
    let test: String
    let textareaScriptAlert123Script: String
    let the0: String
    let the00: String
    let the000: String
    let the0000: String
    let the00Ɩ: String
    let the0X0: String
    let the1: String
    let the10: String
    let the100: String
    let the1000: String
    let the100000: String
    let the100000000: String
    let the11: String
    let the12: String
    let the123456789012345678901234567890123456789: String
    let the13: String
    let the14: String
    let the15: String
    let the1DROPTABLEUsers: String
    let the1E02: String
    let the1E2: String
    let the1Qnan: String
    let the1Snan: String
    let the2: String
    let the3: String
    let the4: String
    let the5: String
    let the6: String
    let the7: String
    let the8: String
    let the9: String
    let the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: String
    let theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: String
    let theQuicKBrownFoXBeeeep: String
    let the٠١٢٣٤٥٦٧٨٩: String
    let twoByteCharacters: String
    let u0000U000AOrU000DNULLFCR: String
    let uOncopyAlertCopyMeU: String
    let undef: String
    let unicodeFont: String
    let unicodeNumbers: String
    let unwantedInterpolation: String
    let xLsAl: String
    let zḀḶGO: String
    let ªº: String
    let çIÂ: String
    let œÁØ: String
    let œØπ: String
    let ʖ: String
    let היתהTestالصفحاتالتحول: String
    let ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: String
    let ดดด: String
    let ⱥ: String
    let ⱦ: String
    let パティへ行かないか: String
    let 和製漢語: String
    let 田中さんにあげて下さい: String
    let ﬁﬂ: String
    let ｨ: String

    enum CodingKeys: String, CodingKey {
        case a = "!@#$%^&*()`~"
        case a0 = "-0"
        case a000 = "0,00"
        case a0000 = "0.0/0.0"
        case a1 = "1"
        case a100000000 = "1'000'000.00"
        case a1E02 = "1E02"
        case aAlert123T = "';alert(123);t='"
        case aFalse = "False"
        case aHrefJava123456781112ScriptJavascriptAlert1XXXA = "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"
        case aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA = "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA = "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA = "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aNil = "nil"
        case aTRUE = "TRUE"
        case aTest = "\u{202b}test\u{202b}"
        case aTrue = "True"
        case abcDivStyleXExpX00RessionJavascriptAlert1DEF = "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"
        case abcDivStyleXExpX5CressionJavascriptAlert1DEF = "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"
        case abcDivStyleXX09ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"
        case abcDivStyleXX0BexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"
        case abcDivStyleXX20ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"
        case abcDivStyleXX3AexpressionJavascriptAlert1DEF = "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"
        case abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"
        case alert123 = ";alert(123);"
        case alert123T = "\";alert(123);t=\""
        case alertXSS = "\\\";alert('XSS');//"
        case ambitious = "<>?:\"{}|_+"
        case andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften = "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"
        case arsenalCanal = "Arsenal canal"
        case autofocusOnkeyupJavascriptAlert123 = "\" autofocus onkeyup=\"javascript:alert(123)"
        case aux = "AUX"
        case braggadocious = "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"
        case changingLengthWhenLowercased = "#\tChanging length when lowercased"
        case charactersWhichIncreaseInLength2To3BytesWhenLowercased = "#\tCharacters which increase in length (2 to 3 bytes) when lowercased"
        case classic = "classic"
        case commandInjectionRuby = "#\tCommand Injection (Ruby)"
        case cunning = "\\"
        case d = "%d"
        case dickVanDyke = "Dick Van Dyke"
        case dontMakeAMap = "dontMakeAMap"
        case drHermanILibshitz = "Dr. Herman I. Libshitz"
        case empty = " "
        case envHome = "$ENV{'HOME'}"
        case etcHosts = "../../../../../../../../../../../etc/hosts"
        case etcPasswd00 = "../../../../../../../../../../../etc/passwd%00"
        case fluffy = "'\"'"
        case fluffy0 = "{0}"
        case fontsAndHaveANumberOfSpecialBehaviors = "#       fonts, and have a number of special behaviors"
        case fooValBar = "<foo val=`bar' />"
        case frisky = "\u{ad}\u{600}\u{601}\u{602}\u{603}\u{604}\u{605}\u{61c}\u{6dd}\u{70f}\u{180e}\u{200b}\u{200c}\u{200d}\u{200e}\u{200f}\u{202a}\u{202b}\u{202c}\u{202d}\u{202e}\u{2060}\u{2061}\u{2062}\u{2063}\u{2064}\u{2066}\u{2067}\u{2068}\u{2069}\u{206a}\u{206b}\u{206c}\u{206d}\u{206e}\u{206f}\u{feff}\u{fff9}\u{fffa}\u{fffb}\u{110bd}\u{1bca0}\u{1bca1}\u{1bca2}\u{1bca3}\u{1d173}\u{1d174}\u{1d175}\u{1d176}\u{1d177}\u{1d178}\u{1d179}\u{1d17a}\u{e0001}\u{e0020}\u{e0021}\u{e0022}\u{e0023}\u{e0024}\u{e0025}\u{e0026}\u{e0027}\u{e0028}\u{e0029}\u{e002a}\u{e002b}\u{e002c}\u{e002d}\u{e002e}\u{e002f}\u{e0030}\u{e0031}\u{e0032}\u{e0033}\u{e0034}\u{e0035}\u{e0036}\u{e0037}\u{e0038}\u{e0039}\u{e003a}\u{e003b}\u{e003c}\u{e003d}\u{e003e}\u{e003f}\u{e0040}\u{e0041}\u{e0042}\u{e0043}\u{e0044}\u{e0045}\u{e0046}\u{e0047}\u{e0048}\u{e0049}\u{e004a}\u{e004b}\u{e004c}\u{e004d}\u{e004e}\u{e004f}\u{e0050}\u{e0051}\u{e0052}\u{e0053}\u{e0054}\u{e0055}\u{e0056}\u{e0057}\u{e0058}\u{e0059}\u{e005a}\u{e005b}\u{e005c}\u{e005d}\u{e005e}\u{e005f}\u{e0060}\u{e0061}\u{e0062}\u{e0063}\u{e0064}\u{e0065}\u{e0066}\u{e0067}\u{e0068}\u{e0069}\u{e006a}\u{e006b}\u{e006c}\u{e006d}\u{e006e}\u{e006f}\u{e0070}\u{e0071}\u{e0072}\u{e0073}\u{e0074}\u{e0075}\u{e0076}\u{e0077}\u{e0078}\u{e0079}\u{e007a}\u{e007b}\u{e007c}\u{e007d}\u{e007e}\u{e007f}"
        case hilarious = "-."
        case home = "$HOME"
        case humanInjection = "#\tHuman injection"
        case iNVOkINGTHEFÈẸLINGOFCHÁOS = "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"
        case ifImgSrcXOnerrorJavascriptAlert1 = "<!--[if<img src=x onerror=javascript:alert(1)//]> -->"
        case ifScriptJavascriptAlert1Script = "<!--[if]><script>javascript:alert(1)</script -->"
        case imgSRCJavAscriptAlertXSS = "<IMG SRC=\"jav   ascript:alert('XSS');\">"
        case imgSRCJavX0AAscriptAlertXSS = "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"
        case imgSRCJavX0DAscriptAlertXSS = "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"
        case imgSrc106971189711599114105112116589710810111411640398883833941 = "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"
        case imgSrcX09XOnerrorJavascriptAlert1 = "<img src\\x09=x onerror=\"javascript:alert(1)\">"
        case imgSrcX11XOnerrorJavascriptAlert1 = "<img src\\x11=x onerror=\"javascript:alert(1)\">"
        case imgSrcXOnerrorX00JavascriptAlert1 = "<img src=x onerror=\\x00\"javascript:alert(1)\">"
        case imgSrcXOnerrorX09JavascriptAlert1 = "<img src=x onerror=\\x09\"javascript:alert(1)\">"
        case imgSrcXX09OnerrorJavascriptAlert1 = "<img src=x\\x09onerror=\"javascript:alert(1)\">"
        case imgSrcXX10OnerrorJavascriptAlert1 = "<img src=x\\x10onerror=\"javascript:alert(1)\">"
        case imgSrcXX11OnerrorJavascriptAlert1 = "<img src=x\\x11onerror=\"javascript:alert(1)\">"
        case imgSrcXX12OnerrorJavascriptAlert1 = "<img src=x\\x12onerror=\"javascript:alert(1)\">"
        case imgSrcXX13OnerrorJavascriptAlert1 = "<img src=x\\x13onerror=\"javascript:alert(1)\">"
        case imgSrcXxxXX00OnerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"
        case imgSrcXxxXX0BonerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"
        case imgSrcXxxXX2FonerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"
        case imgX00SrcXOnerrorAlert1 = "<img \\x00src=x onerror=\"alert(1)\">"
        case imgX10SrcXOnerrorJavascriptAlert1 = "<img\\x10src=x onerror=\"javascript:alert(1)\">"
        case imgX13SrcXOnerrorJavascriptAlert1 = "<img\\x13src=x onerror=\"javascript:alert(1)\">"
        case imgX32SrcXOnerrorJavascriptAlert1 = "<img\\x32src=x onerror=\"javascript:alert(1)\">"
        case imgX39SrcXOnerrorJavascriptAlert1 = "<img \\x39src=x onerror=\"javascript:alert(1)\">"
        case indecent = "-,"
        case indigo = ",./;'[]\\-="
        case inf = "INF"
        case infinity = "-Infinity"
        case innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem = "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"
        case jimmyClitheroe = "Jimmy Clitheroe"
        case kernelExit1 = "Kernel.exit(1)"
        case knownCVEsAndVulnerabilities = "#\tKnown CVEs and Vulnerabilities"
        case lightwaterCountryPark = "Lightwater Country Park"
        case lpt2 = "LPT2"
        case lpt3 = "LPT3"
        case lsAl = "`ls -al /`"
        case magenta = "\u{80}\u{81}\u{82}\u{83}\u{84}\u{86}\u{87}\u{88}\u{89}\u{8a}\u{8b}\u{8c}\u{8d}\u{8e}\u{8f}\u{90}\u{91}\u{92}\u{93}\u{94}\u{95}\u{96}\u{97}\u{98}\u{99}\u{9a}\u{9b}\u{9c}\u{9d}\u{9e}\u{9f}"
        case mischievous = "₀₁₂"
        case msdosWindowsSpecialFilenames = "#\tMSDOS/Windows Special Filenames"
        case nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F = "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."
        case none = "None"
        case null = "(null)"
        case onfocusJaVaSCriptAlert123Autofocus = " onfocus=JaVaSCript:alert(123) autofocus"
        case or11 = "' OR '1'='1"
        case penistoneCommunityChurch = "Penistone Community Church"
        case perlEPrintIMGSRCJava0ScriptAlertXSSOut = "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"
        case prn = "PRN"
        case purple = "'"
        case purple0 = "0"
        case purpleFalse = "false"
        case purpleTest = "\u{2066}test\u{2067}"
        case romansInSussexCoUk = "RomansInSussex.co.uk"
        case s = "%s"
        case sUnSU = "<<< %s(un='%s') = %u"
        case scScriptRiptAlert123ScScriptRipt = "<sc<script>ript>alert(123)</sc</script>ript>"
        case scriptAlert123ScriptX = "\"><script>alert(123);</script x=\""
        case scriptInjection = "#\tScript Injection"
        case scriptSRCHTTPHaCkersOrgXSSJSB = "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"
        case scriptSRCHTTPHaCkersOrgXSSJSSCRIPT = "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"
        case scriptScriptAlert123Script = "</script><script>alert(123)</script>"
        case scriptX00JavascriptAlert1Script = "\"`'><script>\\x00javascript:alert(1)</script>"
        case scriptX09TypeTextJavascriptJavascriptAlert1Script = "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX0CjavascriptAlert1Script = "\"`'><script>\\x0Cjavascript:alert(1)</script>"
        case scriptX0DjavascriptAlert1Script = "\"`'><script>\\x0Djavascript:alert(1)</script>"
        case scriptX20TypeTextJavascriptJavascriptAlert1Script = "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX3EtypeTextJavascriptJavascriptAlert1Script = "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"
        case scriptXC2X85JavascriptAlert1Script = "\"`'><script>\\xC2\\x85javascript:alert(1)</script>"
        case scriptXC2XA0JavascriptAlert1Script = "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"
        case scriptXE1X9AX80JavascriptAlert1Script = "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"
        case scriptXE1XA0X8EjavascriptAlert1Script = "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"
        case scriptXE2X80X81JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"
        case scriptXE2X80X86JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"
        case scriptXE2X80X89JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"
        case scriptXE2X81X9FjavascriptAlert1Script = "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"
        case scriptXEFXBBXBFjavascriptAlert1Script = "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"
        case scriptXF0X90X96X9AjavascriptAlert1Script = "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"
        case scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT = "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"
        case sqlInjection = "#\tSQL Injection"
        case sticky = ","
        case stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser = "#\tString which can reveal system files when parsed by a badly configured XML parser"
        case stringsThatTestForKnownVulnerabilities = "#\tStrings that test for known vulnerabilities"
        case stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString = "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."
        case stringsWhichCanCallSystemCommandsWithinRubyRailsApplications = "#\tStrings which can call system commands within Ruby/Rails applications"
        case stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb = "#\tStrings which consists of Japanese-style emoticons which are popular on the web"
        case stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters = "#\tStrings which contain bold/italic/etc. versions of normal characters"
        case stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes = "#\tStrings which contain common unicode symbols (e.g. smart quotes)"
        case stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways = "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"
        case stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors = "#\tStrings which contain misplaced quotation marks; can cause encoding errors"
        case stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues = "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"
        case stringsWhichCrashedIMessageInVariousVersionsOfIOS = "#\tStrings which crashed iMessage in various versions of iOS"
        case stringsWhichMayCauseHumanToReinterpretWorldview = "#\tStrings which may cause human to reinterpret worldview"
        case superBowlXXX = "Super Bowl XXX"
        case tentacled = "(╯°□°）╯︵ ┻━┻)"
        case test = "\u{202a}\u{202a}test\u{202a}"
        case textareaScriptAlert123Script = "</textarea><script>alert(123)</script>"
        case the0 = "+0"
        case the00 = "0..0"
        case the000 = "0,0,0"
        case the0000 = "0,0/0,0"
        case the00Ɩ = "00˙Ɩ$-"
        case the0X0 = "0x0"
        case the1 = "-1"
        case the10 = "1/0"
        case the100 = "1.00"
        case the1000 = "1.0/0.0"
        case the100000 = "1'000,00"
        case the100000000 = "1 000 000.00"
        case the11 = "﷽"
        case the12 = "1/2"
        case the123456789012345678901234567890123456789 = "123456789012345678901234567890123456789"
        case the13 = "\u{feff}"
        case the14 = "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"
        case the15 = "\u{fffe}"
        case the1DROPTABLEUsers = "1;DROP TABLE users"
        case the1E02 = "-1E02"
        case the1E2 = "1E2"
        case the1Qnan = "1#QNAN"
        case the1Snan = "1#SNAN"
        case the2 = "\u{1d47b}\u{1d489}\u{1d486} \u{1d492}\u{1d496}\u{1d48a}\u{1d484}\u{1d48c} \u{1d483}\u{1d493}\u{1d490}\u{1d498}\u{1d48f} \u{1d487}\u{1d490}\u{1d499} \u{1d48b}\u{1d496}\u{1d48e}\u{1d491}\u{1d494} \u{1d490}\u{1d497}\u{1d486}\u{1d493} \u{1d495}\u{1d489}\u{1d486} \u{1d48d}\u{1d482}\u{1d49b}\u{1d49a} \u{1d485}\u{1d490}\u{1d488}"
        case the3 = "\u{1d4e3}\u{1d4f1}\u{1d4ee} \u{1d4fa}\u{1d4fe}\u{1d4f2}\u{1d4ec}\u{1d4f4} \u{1d4eb}\u{1d4fb}\u{1d4f8}\u{1d500}\u{1d4f7} \u{1d4ef}\u{1d4f8}\u{1d501} \u{1d4f3}\u{1d4fe}\u{1d4f6}\u{1d4f9}\u{1d4fc} \u{1d4f8}\u{1d4ff}\u{1d4ee}\u{1d4fb} \u{1d4fd}\u{1d4f1}\u{1d4ee} \u{1d4f5}\u{1d4ea}\u{1d503}\u{1d502} \u{1d4ed}\u{1d4f8}\u{1d4f0}"
        case the4 = "\u{1d57f}\u{1d58d}\u{1d58a} \u{1d596}\u{1d59a}\u{1d58e}\u{1d588}\u{1d590} \u{1d587}\u{1d597}\u{1d594}\u{1d59c}\u{1d593} \u{1d58b}\u{1d594}\u{1d59d} \u{1d58f}\u{1d59a}\u{1d592}\u{1d595}\u{1d598} \u{1d594}\u{1d59b}\u{1d58a}\u{1d597} \u{1d599}\u{1d58d}\u{1d58a} \u{1d591}\u{1d586}\u{1d59f}\u{1d59e} \u{1d589}\u{1d594}\u{1d58c}"
        case the5 = "\u{1f1fa}\u{1f1f8}\u{1f1f7}\u{1f1fa}\u{1f1f8} \u{1f1e6}\u{1f1eb}\u{1f1e6}\u{1f1f2}\u{1f1f8}"
        case the6 = "\u{1f1fa}\u{1f1f8}\u{1f1f7}\u{1f1fa}\u{1f1f8}\u{1f1e6}"
        case the7 = "\u{1f1fa}\u{1f1f8}\u{1f1f7}\u{1f1fa}\u{1f1f8}\u{1f1e6}\u{1f1eb}\u{1f1e6}\u{1f1f2}"
        case the8 = "\u{1f469}\u{1f3fd}"
        case the9 = "\u{1f6be} \u{1f192} \u{1f193} \u{1f195} \u{1f196} \u{1f197} \u{1f199} \u{1f3e7}"
        case the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
        case theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers = "# The next two lines may appear to be blank or mojibake in some viewers."
        case theQuicKBrownFoXBeeeep = "The quic\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}k brown fo\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}\u{7}x... [Beeeep]"
        case the٠١٢٣٤٥٦٧٨٩ = "٠١٢٣٤٥٦٧٨٩"
        case twoByteCharacters = "#\tTwo-Byte Characters"
        case u0000U000AOrU000DNULLFCR = "# U+0000, U+000A, or U+000D (NUL, LF, CR)."
        case uOncopyAlertCopyMeU = "<u oncopy=alert()> Copy me</u>"
        case undef = "undef"
        case unicodeFont = "#\tUnicode font"
        case unicodeNumbers = "#\tUnicode Numbers"
        case unwantedInterpolation = "#\tUnwanted Interpolation"
        case xLsAl = "%x('ls -al /')"
        case zḀḶGO = "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"
        case ªº = "¡™£¢∞§¶•ªº–≠"
        case çIÂ = "¸˛Ç◊ı˜Â¯˘¿"
        case œÁØ = "Œ„´‰ˇÁ¨ˆØ∏”’"
        case œØπ = "œ∑´®†¥¨ˆøπ“‘"
        case ʖ = "( ͡° ͜ʖ ͡°)"
        case היתהTestالصفحاتالتحول = "הָיְתָהtestالصفحات التّحول"
        case ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو = "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."
        case ดดด = "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"
        case ⱥ = "Ⱥ"
        case ⱦ = "Ⱦ"
        case パティへ行かないか = "パーティーへ行かないか"
        case 和製漢語 = "和製漢語"
        case 田中さんにあげて下さい = "田中さんにあげて下さい"
        case ﬁﬂ = "`⁄€‹›ﬁﬂ‡°·‚—±"
        case ｨ = "｀ｨ(´∀｀∩"
    }
}

// MARK: A convenience initializers and mutators

extension A {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(A.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        a: String? = nil,
        a0: String? = nil,
        a000: String? = nil,
        a0000: String? = nil,
        a1: String? = nil,
        a100000000: String? = nil,
        a1E02: String? = nil,
        aAlert123T: String? = nil,
        aFalse: String? = nil,
        aHrefJava123456781112ScriptJavascriptAlert1XXXA: String? = nil,
        aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aNil: String? = nil,
        aTRUE: String? = nil,
        aTest: String? = nil,
        aTrue: String? = nil,
        abcDivStyleXExpX00RessionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXExpX5CressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX09ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX0BexpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX20ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX3AexpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF: String? = nil,
        alert123: String? = nil,
        alert123T: String? = nil,
        alertXSS: String? = nil,
        ambitious: String? = nil,
        andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften: String? = nil,
        arsenalCanal: String? = nil,
        autofocusOnkeyupJavascriptAlert123: String? = nil,
        aux: String? = nil,
        braggadocious: String? = nil,
        changingLengthWhenLowercased: String? = nil,
        charactersWhichIncreaseInLength2To3BytesWhenLowercased: String? = nil,
        classic: String? = nil,
        commandInjectionRuby: String? = nil,
        cunning: String? = nil,
        d: String? = nil,
        dickVanDyke: String? = nil,
        dontMakeAMap: Bool? = nil,
        drHermanILibshitz: String? = nil,
        empty: String? = nil,
        envHome: String? = nil,
        etcHosts: String? = nil,
        etcPasswd00: String? = nil,
        fluffy: String? = nil,
        fluffy0: String? = nil,
        fontsAndHaveANumberOfSpecialBehaviors: String? = nil,
        fooValBar: String? = nil,
        frisky: String? = nil,
        hilarious: String? = nil,
        home: String? = nil,
        humanInjection: String? = nil,
        iNVOkINGTHEFÈẸLINGOFCHÁOS: String? = nil,
        ifImgSrcXOnerrorJavascriptAlert1: String? = nil,
        ifScriptJavascriptAlert1Script: String? = nil,
        imgSRCJavAscriptAlertXSS: String? = nil,
        imgSRCJavX0AAscriptAlertXSS: String? = nil,
        imgSRCJavX0DAscriptAlertXSS: String? = nil,
        imgSrc106971189711599114105112116589710810111411640398883833941: String? = nil,
        imgSrcX09XOnerrorJavascriptAlert1: String? = nil,
        imgSrcX11XOnerrorJavascriptAlert1: String? = nil,
        imgSrcXOnerrorX00JavascriptAlert1: String? = nil,
        imgSrcXOnerrorX09JavascriptAlert1: String? = nil,
        imgSrcXX09OnerrorJavascriptAlert1: String? = nil,
        imgSrcXX10OnerrorJavascriptAlert1: String? = nil,
        imgSrcXX11OnerrorJavascriptAlert1: String? = nil,
        imgSrcXX12OnerrorJavascriptAlert1: String? = nil,
        imgSrcXX13OnerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX00OnerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX0BonerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX2FonerrorJavascriptAlert1: String? = nil,
        imgX00SrcXOnerrorAlert1: String? = nil,
        imgX10SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX13SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX32SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX39SrcXOnerrorJavascriptAlert1: String? = nil,
        indecent: String? = nil,
        indigo: String? = nil,
        inf: String? = nil,
        infinity: String? = nil,
        innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem: String? = nil,
        jimmyClitheroe: String? = nil,
        kernelExit1: String? = nil,
        knownCVEsAndVulnerabilities: String? = nil,
        lightwaterCountryPark: String? = nil,
        lpt2: String? = nil,
        lpt3: String? = nil,
        lsAl: String? = nil,
        magenta: String? = nil,
        mischievous: String? = nil,
        msdosWindowsSpecialFilenames: String? = nil,
        nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: String? = nil,
        none: String? = nil,
        null: String? = nil,
        onfocusJaVaSCriptAlert123Autofocus: String? = nil,
        or11: String? = nil,
        penistoneCommunityChurch: String? = nil,
        perlEPrintIMGSRCJava0ScriptAlertXSSOut: String? = nil,
        prn: String? = nil,
        purple: String? = nil,
        purple0: String? = nil,
        purpleFalse: String? = nil,
        purpleTest: String? = nil,
        romansInSussexCoUk: String? = nil,
        s: String? = nil,
        sUnSU: String? = nil,
        scScriptRiptAlert123ScScriptRipt: String? = nil,
        scriptAlert123ScriptX: String? = nil,
        scriptInjection: String? = nil,
        scriptSRCHTTPHaCkersOrgXSSJSB: String? = nil,
        scriptSRCHTTPHaCkersOrgXSSJSSCRIPT: String? = nil,
        scriptScriptAlert123Script: String? = nil,
        scriptX00JavascriptAlert1Script: String? = nil,
        scriptX09TypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX0CjavascriptAlert1Script: String? = nil,
        scriptX0DjavascriptAlert1Script: String? = nil,
        scriptX20TypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX3EtypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptXC2X85JavascriptAlert1Script: String? = nil,
        scriptXC2XA0JavascriptAlert1Script: String? = nil,
        scriptXE1X9AX80JavascriptAlert1Script: String? = nil,
        scriptXE1XA0X8EjavascriptAlert1Script: String? = nil,
        scriptXE2X80X81JavascriptAlert1Script: String? = nil,
        scriptXE2X80X86JavascriptAlert1Script: String? = nil,
        scriptXE2X80X89JavascriptAlert1Script: String? = nil,
        scriptXE2X81X9FjavascriptAlert1Script: String? = nil,
        scriptXEFXBBXBFjavascriptAlert1Script: String? = nil,
        scriptXF0X90X96X9AjavascriptAlert1Script: String? = nil,
        scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT: String? = nil,
        sqlInjection: String? = nil,
        sticky: String? = nil,
        stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser: String? = nil,
        stringsThatTestForKnownVulnerabilities: String? = nil,
        stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: String? = nil,
        stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: String? = nil,
        stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: String? = nil,
        stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: String? = nil,
        stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: String? = nil,
        stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: String? = nil,
        stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: String? = nil,
        stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: String? = nil,
        stringsWhichCrashedIMessageInVariousVersionsOfIOS: String? = nil,
        stringsWhichMayCauseHumanToReinterpretWorldview: String? = nil,
        superBowlXXX: String? = nil,
        tentacled: String? = nil,
        test: String? = nil,
        textareaScriptAlert123Script: String? = nil,
        the0: String? = nil,
        the00: String? = nil,
        the000: String? = nil,
        the0000: String? = nil,
        the00Ɩ: String? = nil,
        the0X0: String? = nil,
        the1: String? = nil,
        the10: String? = nil,
        the100: String? = nil,
        the1000: String? = nil,
        the100000: String? = nil,
        the100000000: String? = nil,
        the11: String? = nil,
        the12: String? = nil,
        the123456789012345678901234567890123456789: String? = nil,
        the13: String? = nil,
        the14: String? = nil,
        the15: String? = nil,
        the1DROPTABLEUsers: String? = nil,
        the1E02: String? = nil,
        the1E2: String? = nil,
        the1Qnan: String? = nil,
        the1Snan: String? = nil,
        the2: String? = nil,
        the3: String? = nil,
        the4: String? = nil,
        the5: String? = nil,
        the6: String? = nil,
        the7: String? = nil,
        the8: String? = nil,
        the9: String? = nil,
        the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: String? = nil,
        theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: String? = nil,
        theQuicKBrownFoXBeeeep: String? = nil,
        the٠١٢٣٤٥٦٧٨٩: String? = nil,
        twoByteCharacters: String? = nil,
        u0000U000AOrU000DNULLFCR: String? = nil,
        uOncopyAlertCopyMeU: String? = nil,
        undef: String? = nil,
        unicodeFont: String? = nil,
        unicodeNumbers: String? = nil,
        unwantedInterpolation: String? = nil,
        xLsAl: String? = nil,
        zḀḶGO: String? = nil,
        ªº: String? = nil,
        çIÂ: String? = nil,
        œÁØ: String? = nil,
        œØπ: String? = nil,
        ʖ: String? = nil,
        היתהTestالصفحاتالتحول: String? = nil,
        ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: String? = nil,
        ดดด: String? = nil,
        ⱥ: String? = nil,
        ⱦ: String? = nil,
        パティへ行かないか: String? = nil,
        和製漢語: String? = nil,
        田中さんにあげて下さい: String? = nil,
        ﬁﬂ: String? = nil,
        ｨ: String? = nil
    ) -> A {
        return A(
            a: a ?? self.a,
            a0: a0 ?? self.a0,
            a000: a000 ?? self.a000,
            a0000: a0000 ?? self.a0000,
            a1: a1 ?? self.a1,
            a100000000: a100000000 ?? self.a100000000,
            a1E02: a1E02 ?? self.a1E02,
            aAlert123T: aAlert123T ?? self.aAlert123T,
            aFalse: aFalse ?? self.aFalse,
            aHrefJava123456781112ScriptJavascriptAlert1XXXA: aHrefJava123456781112ScriptJavascriptAlert1XXXA ?? self.aHrefJava123456781112ScriptJavascriptAlert1XXXA,
            aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA: aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA ?? self.aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA,
            aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA: aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA,
            aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA: aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA,
            aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aNil: aNil ?? self.aNil,
            aTRUE: aTRUE ?? self.aTRUE,
            aTest: aTest ?? self.aTest,
            aTrue: aTrue ?? self.aTrue,
            abcDivStyleXExpX00RessionJavascriptAlert1DEF: abcDivStyleXExpX00RessionJavascriptAlert1DEF ?? self.abcDivStyleXExpX00RessionJavascriptAlert1DEF,
            abcDivStyleXExpX5CressionJavascriptAlert1DEF: abcDivStyleXExpX5CressionJavascriptAlert1DEF ?? self.abcDivStyleXExpX5CressionJavascriptAlert1DEF,
            abcDivStyleXX09ExpressionJavascriptAlert1DEF: abcDivStyleXX09ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXX09ExpressionJavascriptAlert1DEF,
            abcDivStyleXX0BexpressionJavascriptAlert1DEF: abcDivStyleXX0BexpressionJavascriptAlert1DEF ?? self.abcDivStyleXX0BexpressionJavascriptAlert1DEF,
            abcDivStyleXX20ExpressionJavascriptAlert1DEF: abcDivStyleXX20ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXX20ExpressionJavascriptAlert1DEF,
            abcDivStyleXX3AexpressionJavascriptAlert1DEF: abcDivStyleXX3AexpressionJavascriptAlert1DEF ?? self.abcDivStyleXX3AexpressionJavascriptAlert1DEF,
            abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF: abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF,
            alert123: alert123 ?? self.alert123,
            alert123T: alert123T ?? self.alert123T,
            alertXSS: alertXSS ?? self.alertXSS,
            ambitious: ambitious ?? self.ambitious,
            andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften: andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften ?? self.andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften,
            arsenalCanal: arsenalCanal ?? self.arsenalCanal,
            autofocusOnkeyupJavascriptAlert123: autofocusOnkeyupJavascriptAlert123 ?? self.autofocusOnkeyupJavascriptAlert123,
            aux: aux ?? self.aux,
            braggadocious: braggadocious ?? self.braggadocious,
            changingLengthWhenLowercased: changingLengthWhenLowercased ?? self.changingLengthWhenLowercased,
            charactersWhichIncreaseInLength2To3BytesWhenLowercased: charactersWhichIncreaseInLength2To3BytesWhenLowercased ?? self.charactersWhichIncreaseInLength2To3BytesWhenLowercased,
            classic: classic ?? self.classic,
            commandInjectionRuby: commandInjectionRuby ?? self.commandInjectionRuby,
            cunning: cunning ?? self.cunning,
            d: d ?? self.d,
            dickVanDyke: dickVanDyke ?? self.dickVanDyke,
            dontMakeAMap: dontMakeAMap ?? self.dontMakeAMap,
            drHermanILibshitz: drHermanILibshitz ?? self.drHermanILibshitz,
            empty: empty ?? self.empty,
            envHome: envHome ?? self.envHome,
            etcHosts: etcHosts ?? self.etcHosts,
            etcPasswd00: etcPasswd00 ?? self.etcPasswd00,
            fluffy: fluffy ?? self.fluffy,
            fluffy0: fluffy0 ?? self.fluffy0,
            fontsAndHaveANumberOfSpecialBehaviors: fontsAndHaveANumberOfSpecialBehaviors ?? self.fontsAndHaveANumberOfSpecialBehaviors,
            fooValBar: fooValBar ?? self.fooValBar,
            frisky: frisky ?? self.frisky,
            hilarious: hilarious ?? self.hilarious,
            home: home ?? self.home,
            humanInjection: humanInjection ?? self.humanInjection,
            iNVOkINGTHEFÈẸLINGOFCHÁOS: iNVOkINGTHEFÈẸLINGOFCHÁOS ?? self.iNVOkINGTHEFÈẸLINGOFCHÁOS,
            ifImgSrcXOnerrorJavascriptAlert1: ifImgSrcXOnerrorJavascriptAlert1 ?? self.ifImgSrcXOnerrorJavascriptAlert1,
            ifScriptJavascriptAlert1Script: ifScriptJavascriptAlert1Script ?? self.ifScriptJavascriptAlert1Script,
            imgSRCJavAscriptAlertXSS: imgSRCJavAscriptAlertXSS ?? self.imgSRCJavAscriptAlertXSS,
            imgSRCJavX0AAscriptAlertXSS: imgSRCJavX0AAscriptAlertXSS ?? self.imgSRCJavX0AAscriptAlertXSS,
            imgSRCJavX0DAscriptAlertXSS: imgSRCJavX0DAscriptAlertXSS ?? self.imgSRCJavX0DAscriptAlertXSS,
            imgSrc106971189711599114105112116589710810111411640398883833941: imgSrc106971189711599114105112116589710810111411640398883833941 ?? self.imgSrc106971189711599114105112116589710810111411640398883833941,
            imgSrcX09XOnerrorJavascriptAlert1: imgSrcX09XOnerrorJavascriptAlert1 ?? self.imgSrcX09XOnerrorJavascriptAlert1,
            imgSrcX11XOnerrorJavascriptAlert1: imgSrcX11XOnerrorJavascriptAlert1 ?? self.imgSrcX11XOnerrorJavascriptAlert1,
            imgSrcXOnerrorX00JavascriptAlert1: imgSrcXOnerrorX00JavascriptAlert1 ?? self.imgSrcXOnerrorX00JavascriptAlert1,
            imgSrcXOnerrorX09JavascriptAlert1: imgSrcXOnerrorX09JavascriptAlert1 ?? self.imgSrcXOnerrorX09JavascriptAlert1,
            imgSrcXX09OnerrorJavascriptAlert1: imgSrcXX09OnerrorJavascriptAlert1 ?? self.imgSrcXX09OnerrorJavascriptAlert1,
            imgSrcXX10OnerrorJavascriptAlert1: imgSrcXX10OnerrorJavascriptAlert1 ?? self.imgSrcXX10OnerrorJavascriptAlert1,
            imgSrcXX11OnerrorJavascriptAlert1: imgSrcXX11OnerrorJavascriptAlert1 ?? self.imgSrcXX11OnerrorJavascriptAlert1,
            imgSrcXX12OnerrorJavascriptAlert1: imgSrcXX12OnerrorJavascriptAlert1 ?? self.imgSrcXX12OnerrorJavascriptAlert1,
            imgSrcXX13OnerrorJavascriptAlert1: imgSrcXX13OnerrorJavascriptAlert1 ?? self.imgSrcXX13OnerrorJavascriptAlert1,
            imgSrcXxxXX00OnerrorJavascriptAlert1: imgSrcXxxXX00OnerrorJavascriptAlert1 ?? self.imgSrcXxxXX00OnerrorJavascriptAlert1,
            imgSrcXxxXX0BonerrorJavascriptAlert1: imgSrcXxxXX0BonerrorJavascriptAlert1 ?? self.imgSrcXxxXX0BonerrorJavascriptAlert1,
            imgSrcXxxXX2FonerrorJavascriptAlert1: imgSrcXxxXX2FonerrorJavascriptAlert1 ?? self.imgSrcXxxXX2FonerrorJavascriptAlert1,
            imgX00SrcXOnerrorAlert1: imgX00SrcXOnerrorAlert1 ?? self.imgX00SrcXOnerrorAlert1,
            imgX10SrcXOnerrorJavascriptAlert1: imgX10SrcXOnerrorJavascriptAlert1 ?? self.imgX10SrcXOnerrorJavascriptAlert1,
            imgX13SrcXOnerrorJavascriptAlert1: imgX13SrcXOnerrorJavascriptAlert1 ?? self.imgX13SrcXOnerrorJavascriptAlert1,
            imgX32SrcXOnerrorJavascriptAlert1: imgX32SrcXOnerrorJavascriptAlert1 ?? self.imgX32SrcXOnerrorJavascriptAlert1,
            imgX39SrcXOnerrorJavascriptAlert1: imgX39SrcXOnerrorJavascriptAlert1 ?? self.imgX39SrcXOnerrorJavascriptAlert1,
            indecent: indecent ?? self.indecent,
            indigo: indigo ?? self.indigo,
            inf: inf ?? self.inf,
            infinity: infinity ?? self.infinity,
            innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem: innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem ?? self.innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem,
            jimmyClitheroe: jimmyClitheroe ?? self.jimmyClitheroe,
            kernelExit1: kernelExit1 ?? self.kernelExit1,
            knownCVEsAndVulnerabilities: knownCVEsAndVulnerabilities ?? self.knownCVEsAndVulnerabilities,
            lightwaterCountryPark: lightwaterCountryPark ?? self.lightwaterCountryPark,
            lpt2: lpt2 ?? self.lpt2,
            lpt3: lpt3 ?? self.lpt3,
            lsAl: lsAl ?? self.lsAl,
            magenta: magenta ?? self.magenta,
            mischievous: mischievous ?? self.mischievous,
            msdosWindowsSpecialFilenames: msdosWindowsSpecialFilenames ?? self.msdosWindowsSpecialFilenames,
            nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F ?? self.nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F,
            none: none ?? self.none,
            null: null ?? self.null,
            onfocusJaVaSCriptAlert123Autofocus: onfocusJaVaSCriptAlert123Autofocus ?? self.onfocusJaVaSCriptAlert123Autofocus,
            or11: or11 ?? self.or11,
            penistoneCommunityChurch: penistoneCommunityChurch ?? self.penistoneCommunityChurch,
            perlEPrintIMGSRCJava0ScriptAlertXSSOut: perlEPrintIMGSRCJava0ScriptAlertXSSOut ?? self.perlEPrintIMGSRCJava0ScriptAlertXSSOut,
            prn: prn ?? self.prn,
            purple: purple ?? self.purple,
            purple0: purple0 ?? self.purple0,
            purpleFalse: purpleFalse ?? self.purpleFalse,
            purpleTest: purpleTest ?? self.purpleTest,
            romansInSussexCoUk: romansInSussexCoUk ?? self.romansInSussexCoUk,
            s: s ?? self.s,
            sUnSU: sUnSU ?? self.sUnSU,
            scScriptRiptAlert123ScScriptRipt: scScriptRiptAlert123ScScriptRipt ?? self.scScriptRiptAlert123ScScriptRipt,
            scriptAlert123ScriptX: scriptAlert123ScriptX ?? self.scriptAlert123ScriptX,
            scriptInjection: scriptInjection ?? self.scriptInjection,
            scriptSRCHTTPHaCkersOrgXSSJSB: scriptSRCHTTPHaCkersOrgXSSJSB ?? self.scriptSRCHTTPHaCkersOrgXSSJSB,
            scriptSRCHTTPHaCkersOrgXSSJSSCRIPT: scriptSRCHTTPHaCkersOrgXSSJSSCRIPT ?? self.scriptSRCHTTPHaCkersOrgXSSJSSCRIPT,
            scriptScriptAlert123Script: scriptScriptAlert123Script ?? self.scriptScriptAlert123Script,
            scriptX00JavascriptAlert1Script: scriptX00JavascriptAlert1Script ?? self.scriptX00JavascriptAlert1Script,
            scriptX09TypeTextJavascriptJavascriptAlert1Script: scriptX09TypeTextJavascriptJavascriptAlert1Script ?? self.scriptX09TypeTextJavascriptJavascriptAlert1Script,
            scriptX0CjavascriptAlert1Script: scriptX0CjavascriptAlert1Script ?? self.scriptX0CjavascriptAlert1Script,
            scriptX0DjavascriptAlert1Script: scriptX0DjavascriptAlert1Script ?? self.scriptX0DjavascriptAlert1Script,
            scriptX20TypeTextJavascriptJavascriptAlert1Script: scriptX20TypeTextJavascriptJavascriptAlert1Script ?? self.scriptX20TypeTextJavascriptJavascriptAlert1Script,
            scriptX3EtypeTextJavascriptJavascriptAlert1Script: scriptX3EtypeTextJavascriptJavascriptAlert1Script ?? self.scriptX3EtypeTextJavascriptJavascriptAlert1Script,
            scriptXC2X85JavascriptAlert1Script: scriptXC2X85JavascriptAlert1Script ?? self.scriptXC2X85JavascriptAlert1Script,
            scriptXC2XA0JavascriptAlert1Script: scriptXC2XA0JavascriptAlert1Script ?? self.scriptXC2XA0JavascriptAlert1Script,
            scriptXE1X9AX80JavascriptAlert1Script: scriptXE1X9AX80JavascriptAlert1Script ?? self.scriptXE1X9AX80JavascriptAlert1Script,
            scriptXE1XA0X8EjavascriptAlert1Script: scriptXE1XA0X8EjavascriptAlert1Script ?? self.scriptXE1XA0X8EjavascriptAlert1Script,
            scriptXE2X80X81JavascriptAlert1Script: scriptXE2X80X81JavascriptAlert1Script ?? self.scriptXE2X80X81JavascriptAlert1Script,
            scriptXE2X80X86JavascriptAlert1Script: scriptXE2X80X86JavascriptAlert1Script ?? self.scriptXE2X80X86JavascriptAlert1Script,
            scriptXE2X80X89JavascriptAlert1Script: scriptXE2X80X89JavascriptAlert1Script ?? self.scriptXE2X80X89JavascriptAlert1Script,
            scriptXE2X81X9FjavascriptAlert1Script: scriptXE2X81X9FjavascriptAlert1Script ?? self.scriptXE2X81X9FjavascriptAlert1Script,
            scriptXEFXBBXBFjavascriptAlert1Script: scriptXEFXBBXBFjavascriptAlert1Script ?? self.scriptXEFXBBXBFjavascriptAlert1Script,
            scriptXF0X90X96X9AjavascriptAlert1Script: scriptXF0X90X96X9AjavascriptAlert1Script ?? self.scriptXF0X90X96X9AjavascriptAlert1Script,
            scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT: scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT ?? self.scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT,
            sqlInjection: sqlInjection ?? self.sqlInjection,
            sticky: sticky ?? self.sticky,
            stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser: stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser ?? self.stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser,
            stringsThatTestForKnownVulnerabilities: stringsThatTestForKnownVulnerabilities ?? self.stringsThatTestForKnownVulnerabilities,
            stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString ?? self.stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString,
            stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: stringsWhichCanCallSystemCommandsWithinRubyRailsApplications ?? self.stringsWhichCanCallSystemCommandsWithinRubyRailsApplications,
            stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb ?? self.stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb,
            stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters ?? self.stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters,
            stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes ?? self.stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes,
            stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways ?? self.stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways,
            stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors ?? self.stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors,
            stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues ?? self.stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues,
            stringsWhichCrashedIMessageInVariousVersionsOfIOS: stringsWhichCrashedIMessageInVariousVersionsOfIOS ?? self.stringsWhichCrashedIMessageInVariousVersionsOfIOS,
            stringsWhichMayCauseHumanToReinterpretWorldview: stringsWhichMayCauseHumanToReinterpretWorldview ?? self.stringsWhichMayCauseHumanToReinterpretWorldview,
            superBowlXXX: superBowlXXX ?? self.superBowlXXX,
            tentacled: tentacled ?? self.tentacled,
            test: test ?? self.test,
            textareaScriptAlert123Script: textareaScriptAlert123Script ?? self.textareaScriptAlert123Script,
            the0: the0 ?? self.the0,
            the00: the00 ?? self.the00,
            the000: the000 ?? self.the000,
            the0000: the0000 ?? self.the0000,
            the00Ɩ: the00Ɩ ?? self.the00Ɩ,
            the0X0: the0X0 ?? self.the0X0,
            the1: the1 ?? self.the1,
            the10: the10 ?? self.the10,
            the100: the100 ?? self.the100,
            the1000: the1000 ?? self.the1000,
            the100000: the100000 ?? self.the100000,
            the100000000: the100000000 ?? self.the100000000,
            the11: the11 ?? self.the11,
            the12: the12 ?? self.the12,
            the123456789012345678901234567890123456789: the123456789012345678901234567890123456789 ?? self.the123456789012345678901234567890123456789,
            the13: the13 ?? self.the13,
            the14: the14 ?? self.the14,
            the15: the15 ?? self.the15,
            the1DROPTABLEUsers: the1DROPTABLEUsers ?? self.the1DROPTABLEUsers,
            the1E02: the1E02 ?? self.the1E02,
            the1E2: the1E2 ?? self.the1E2,
            the1Qnan: the1Qnan ?? self.the1Qnan,
            the1Snan: the1Snan ?? self.the1Snan,
            the2: the2 ?? self.the2,
            the3: the3 ?? self.the3,
            the4: the4 ?? self.the4,
            the5: the5 ?? self.the5,
            the6: the6 ?? self.the6,
            the7: the7 ?? self.the7,
            the8: the8 ?? self.the8,
            the9: the9 ?? self.the9,
            the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 ?? self.the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999,
            theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers ?? self.theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers,
            theQuicKBrownFoXBeeeep: theQuicKBrownFoXBeeeep ?? self.theQuicKBrownFoXBeeeep,
            the٠١٢٣٤٥٦٧٨٩: the٠١٢٣٤٥٦٧٨٩ ?? self.the٠١٢٣٤٥٦٧٨٩,
            twoByteCharacters: twoByteCharacters ?? self.twoByteCharacters,
            u0000U000AOrU000DNULLFCR: u0000U000AOrU000DNULLFCR ?? self.u0000U000AOrU000DNULLFCR,
            uOncopyAlertCopyMeU: uOncopyAlertCopyMeU ?? self.uOncopyAlertCopyMeU,
            undef: undef ?? self.undef,
            unicodeFont: unicodeFont ?? self.unicodeFont,
            unicodeNumbers: unicodeNumbers ?? self.unicodeNumbers,
            unwantedInterpolation: unwantedInterpolation ?? self.unwantedInterpolation,
            xLsAl: xLsAl ?? self.xLsAl,
            zḀḶGO: zḀḶGO ?? self.zḀḶGO,
            ªº: ªº ?? self.ªº,
            çIÂ: çIÂ ?? self.çIÂ,
            œÁØ: œÁØ ?? self.œÁØ,
            œØπ: œØπ ?? self.œØπ,
            ʖ: ʖ ?? self.ʖ,
            היתהTestالصفحاتالتحول: היתהTestالصفحاتالتحول ?? self.היתהTestالصفحاتالتحول,
            ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو ?? self.ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو,
            ดดด: ดดด ?? self.ดดด,
            ⱥ: ⱥ ?? self.ⱥ,
            ⱦ: ⱦ ?? self.ⱦ,
            パティへ行かないか: パティへ行かないか ?? self.パティへ行かないか,
            和製漢語: 和製漢語 ?? self.和製漢語,
            田中さんにあげて下さい: 田中さんにあげて下さい ?? self.田中さんにあげて下さい,
            ﬁﬂ: ﬁﬂ ?? self.ﬁﬂ,
            ｨ: ｨ ?? self.ｨ
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - B
struct B: Codable {
    let aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: String
    let aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA: String
    let aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let abcDivStyleXExpressionX5CJavascriptAlert1DEF: String
    let abcDivStyleXX0AexpressionJavascriptAlert1DEF: String
    let abcDivStyleXX0DexpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF: String
    let appearInInput: String
    let ath0: String
    let autofocusOnkeyupJavascriptAlert123: String
    let b: String
    let b100000: String
    let bFALSE: String
    let bIMGSRCOnmouseoverAlertXxs: String
    let bNIL: String
    let bScriptAlert123Script: String
    let bTouchTmpBlnsFail: String
    let basement: String
    let butNow20CforMyGreatestTrick8M: String
    let byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine: String
    let com1: String
    let com3: String
    let commonlyMisinterpretedAsAdditionalGraphicCharacters: String
    let con: String
    let contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition: String
    let creditHTTPSTwitterCOMJifaStatus625776454479970304: String
    let devNullTouchTmpBlnsFailEcho: String
    let dontMakeAMap: Bool
    let empty: String
    let evalPutsHelloWorld: String
    let expression: String
    let file: String
    let fileInclusion: String
    let fluffy: String
    let fooValBar: String
    let generalCategoryCFInUnicode800: String
    let hEWHOWAĮTSBEHINDTHEWALḼ: String
    let help: String
    let hilarious: String
    let httpA3030: String
    let iOSVulnerabilities: String
    let ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: String
    let iframeSrcHTTPHaCkersOrgScriptletHTML: String
    let imgSRC14JavascriptAlertXSS: String
    let imgSRCJavX09AscriptAlertXSS: String
    let imgSRCOnmouseoverAlertXxs: String
    let imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: String
    let imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: String
    let imgSrcX00XOnerrorJavascriptAlert1: String
    let imgSrcXOnerrorX11JavascriptAlert1: String
    let imgSrcXOnerrorX12JavascriptAlert1: String
    let imgSrcXxxXX0AonerrorJavascriptAlert1: String
    let imgSrcXxxXX0ConerrorJavascriptAlert1: String
    let imgSrcXxxXX0DonerrorJavascriptAlert1: String
    let imgX00SrcXOnerrorJavascriptAlert1: String
    let imgX11SrcXOnerrorJavascriptAlert1: String
    let imgX12SrcXOnerrorJavascriptAlert1: String
    let imgX47SrcXOnerrorJavascriptAlert1: String
    let indecent: String
    let indigo: String
    let ircSpecificStrings: String
    let japaneseEmoticons: String
    let kernelExecLsAl: String
    let lindaCallahan: String
    let nul: String
    let null: String
    let numericStrings: String
    let oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML: String
    let onfocusJaVaSCriptAlert123Autofocus: String
    let or111: String
    let purple: String
    let purpleScriptAlert123Script: String
    let quotationMarks: String
    let regionalIndicatorSymbols: String
    let regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: String
    let reservedStrings: String
    let scriptAlert123Script: String
    let scriptAlert123ScriptX: String
    let scriptAlertXSSSCRIPT: String
    let scriptSRCHaCkersOrgJ: String
    let scriptSrcJscriptSScript: String
    let scriptX09JavascriptAlert1Script: String
    let scriptX0AtypeTextJavascriptJavascriptAlert1Script: String
    let scriptX0DtypeTextJavascriptJavascriptAlert1Script: String
    let scriptX21JavascriptAlert1Script: String
    let scriptX3BjavascriptAlert1Script: String
    let scriptXE2X80X85JavascriptAlert1Script: String
    let scriptXE2X80X87JavascriptAlert1Script: String
    let scriptXE2X80X8AjavascriptAlert1Script: String
    let scriptXE2X80XA8JavascriptAlert1Script: String
    let scriptXE2X80XA9JavascriptAlert1Script: String
    let scriptXE2X80XAFjavascriptAlert1Script: String
    let scriptXE3X80X80JavascriptAlert1Script: String
    let scunthorpeProblem: String
    let sticky: String
    let stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut: String
    let stringsWhichAreReservedCharactersInMSDOSWindows: String
    let stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS: String
    let stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew: String
    let stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: String
    let stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: String
    let stringsWhichMayBeUsedElsewhereInCode: String
    let tentacled: String
    let terminalEscapeCodes: String
    let the000: String
    let the01000: String
    let the08: String
    let the09: String
    let the0Xffffffffffffffff: String
    let the100: String
    let the1000: String
    let the100000: String
    let the100000000: String
    let the1DROPTABLEUsers1: String
    let the1Ind: String
    let the1Inf: String
    let the21474836481: String
    let the22250738585072011E308: String
    let theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: String
    let theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: String
    let theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: String
    let the１２３: String
    let thisFileUnfortunatelyCannotExpressStringsContaining: String
    let touchTmpBlnsFail: String
    let touchTmpBlnsShellshock2Fail: String
    let tysonGay: String
    let unicodeSymbols: String
    let x00ScriptJavascriptAlert1Script: String
    let x3CscriptJavascriptAlert1Script: String
    let åßƑÆ: String
    let ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo: String
    let ωÇΜ: String
    let ຈلຈﾉຈلຈﾉ: String
    let ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS: String
    let 社會科學院語學研究所: String
    let 部落格: String
    let 사회과학원어학연구소: String
    let 찦차를타고온펲시맨과쑛다리똠방각하: String
    let ﷺ: String
    let ﾛ_: String

    enum CodingKeys: String, CodingKey {
        case aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A = "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"
        case aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA = "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA = "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case abcDivStyleXExpressionX5CJavascriptAlert1DEF = "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"
        case abcDivStyleXX0AexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"
        case abcDivStyleXX0DexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"
        case appearInInput = "# appear in input."
        case ath0 = "+++ATH0"
        case autofocusOnkeyupJavascriptAlert123 = "' autofocus onkeyup='javascript:alert(123)"
        case b = "\t\u{b}\u{c} \u{85}             \u{200b}\u{2028}\u{2029}  　"
        case b100000 = "1'000.00"
        case bFALSE = "FALSE"
        case bIMGSRCOnmouseoverAlertXxs = "<IMG SRC=# onmouseover=\"alert('xxs')\">"
        case bNIL = "NIL"
        case bScriptAlert123Script = "--><script>alert(123)</script>"
        case bTouchTmpBlnsFail = "`touch /tmp/blns.fail`"
        case basement = "basement"
        case butNow20CforMyGreatestTrick8M = "But now...\u{1b}[20Cfor my greatest trick...\u{1b}[8m"
        case byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine = "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."
        case com1 = "COM1"
        case com3 = "COM3"
        case commonlyMisinterpretedAsAdditionalGraphicCharacters = "# Commonly misinterpreted as additional graphic characters."
        case con = "CON"
        case contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition = "# contexts.  Divided into three groups based on (US-layout) keyboard position."
        case creditHTTPSTwitterCOMJifaStatus625776454479970304 = "#\tCredit: https://twitter.com/jifa/status/625776454479970304"
        case devNullTouchTmpBlnsFailEcho = "/dev/null; touch /tmp/blns.fail ; echo"
        case dontMakeAMap = "dontMakeAMap"
        case empty = "\u{1}\u{2}\u{3}\u{4}\u{5}\u{6}\u{7}\u{8}\u{e}\u{f}\u{10}\u{11}\u{12}\u{13}\u{14}\u{15}\u{16}\u{17}\u{18}\u{19}\u{1a}\u{1b}\u{1c}\u{1d}\u{1e}\u{1f}\u{7f}"
        case evalPutsHelloWorld = "eval(\"puts 'hello world'\")"
        case expression = "expression"
        case file = "File:///"
        case fileInclusion = "#\tFile Inclusion"
        case fluffy = "#"
        case fooValBar = "<foo val=”bar“ />"
        case generalCategoryCFInUnicode800 = "# general category Cf (in Unicode 8.0.0)."
        case hEWHOWAĮTSBEHINDTHEWALḼ = "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"
        case help = "--help"
        case hilarious = "\u{1f60d}"
        case httpA3030 = "http://a/%%30%30"
        case iOSVulnerabilities = "#\tiOS Vulnerabilities"
        case ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou = "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."
        case iframeSrcHTTPHaCkersOrgScriptletHTML = "<iframe src=http://ha.ckers.org/scriptlet.html <"
        case imgSRC14JavascriptAlertXSS = "<IMG SRC=\" &#14;  javascript:alert('XSS');\">"
        case imgSRCJavX09AscriptAlertXSS = "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"
        case imgSRCOnmouseoverAlertXxs = "<IMG SRC= onmouseover=\"alert('xxs')\">"
        case imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29 = "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"
        case imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041 = "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"
        case imgSrcX00XOnerrorJavascriptAlert1 = "<img src\\x00=x onerror=\"javascript:alert(1)\">"
        case imgSrcXOnerrorX11JavascriptAlert1 = "<img src=x onerror=\\x11\"javascript:alert(1)\">"
        case imgSrcXOnerrorX12JavascriptAlert1 = "<img src=x onerror=\\x12\"javascript:alert(1)\">"
        case imgSrcXxxXX0AonerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"
        case imgSrcXxxXX0ConerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"
        case imgSrcXxxXX0DonerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"
        case imgX00SrcXOnerrorJavascriptAlert1 = "<img \\x00src=x onerror=\"javascript:alert(1)\">"
        case imgX11SrcXOnerrorJavascriptAlert1 = "<img \\x11src=x onerror=\"javascript:alert(1)\">"
        case imgX12SrcXOnerrorJavascriptAlert1 = "<img \\x12src=x onerror=\"javascript:alert(1)\">"
        case imgX47SrcXOnerrorJavascriptAlert1 = "<img \\x47src=x onerror=\"javascript:alert(1)\">"
        case indecent = "\u{1d54b}\u{1d559}\u{1d556} \u{1d562}\u{1d566}\u{1d55a}\u{1d554}\u{1d55c} \u{1d553}\u{1d563}\u{1d560}\u{1d568}\u{1d55f} \u{1d557}\u{1d560}\u{1d569} \u{1d55b}\u{1d566}\u{1d55e}\u{1d561}\u{1d564} \u{1d560}\u{1d567}\u{1d556}\u{1d563} \u{1d565}\u{1d559}\u{1d556} \u{1d55d}\u{1d552}\u{1d56b}\u{1d56a} \u{1d555}\u{1d560}\u{1d558}"
        case indigo = "❤️ \u{1f494} \u{1f48c} \u{1f495} \u{1f49e} \u{1f493} \u{1f497} \u{1f496} \u{1f498} \u{1f49d} \u{1f49f} \u{1f49c} \u{1f49b} \u{1f49a} \u{1f499}"
        case ircSpecificStrings = "#   IRC specific strings"
        case japaneseEmoticons = "#\tJapanese Emoticons"
        case kernelExecLsAl = "Kernel.exec(\"ls -al /\")"
        case lindaCallahan = "Linda Callahan"
        case nul = "NUL"
        case null = "null"
        case numericStrings = "#\tNumeric Strings"
        case oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML = "# Often forbidden to appear in various text-based file formats (e.g. XML),"
        case onfocusJaVaSCriptAlert123Autofocus = "\" onfocus=JaVaSCript:alert(123) autofocus"
        case or111 = "' OR 1=1 -- 1"
        case purple = "\""
        case purpleScriptAlert123Script = "<script>alert(123)</script>"
        case quotationMarks = "#\tQuotation Marks"
        case regionalIndicatorSymbols = "#       Regional Indicator Symbols"
        case regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross = "#       Regional Indicator Symbols can be displayed differently across"
        case reservedStrings = "#\tReserved Strings"
        case scriptAlert123Script = "\"><script>alert(123)</script>"
        case scriptAlert123ScriptX = "><script>alert(123);</script x="
        case scriptAlertXSSSCRIPT = "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"
        case scriptSRCHaCkersOrgJ = "<SCRIPT SRC=//ha.ckers.org/.j>"
        case scriptSrcJscriptSScript = "<script src=\"\\\\%(jscript)s\"></script>"
        case scriptX09JavascriptAlert1Script = "\"`'><script>\\x09javascript:alert(1)</script>"
        case scriptX0AtypeTextJavascriptJavascriptAlert1Script = "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX0DtypeTextJavascriptJavascriptAlert1Script = "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX21JavascriptAlert1Script = "\"`'><script>\\x21javascript:alert(1)</script>"
        case scriptX3BjavascriptAlert1Script = "\"`'><script>\\x3Bjavascript:alert(1)</script>"
        case scriptXE2X80X85JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"
        case scriptXE2X80X87JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"
        case scriptXE2X80X8AjavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"
        case scriptXE2X80XA8JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"
        case scriptXE2X80XA9JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"
        case scriptXE2X80XAFjavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"
        case scriptXE3X80X80JavascriptAlert1Script = "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"
        case scunthorpeProblem = "#\tScunthorpe Problem"
        case sticky = "⁰⁴⁵₀₁₂"
        case stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut = "#   Strings that may occur on IRC clients that make security products freak out"
        case stringsWhichAreReservedCharactersInMSDOSWindows = "#\tStrings which are reserved characters in MSDOS/Windows"
        case stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS = "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"
        case stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew = "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"
        case stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues = "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"
        case stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric = "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"
        case stringsWhichMayBeUsedElsewhereInCode = "#\tStrings which may be used elsewhere in code"
        case tentacled = "(｡◕ ∀ ◕｡)"
        case terminalEscapeCodes = "#\tTerminal escape codes"
        case the000 = "0.00"
        case the01000 = "01000"
        case the08 = "08"
        case the09 = "09"
        case the0Xffffffffffffffff = "0xffffffffffffffff"
        case the100 = "$1.00"
        case the1000 = "1,0/0,0"
        case the100000 = "1 000.00"
        case the100000000 = "1 000 000,00"
        case the1DROPTABLEUsers1 = "1'; DROP TABLE users-- 1"
        case the1Ind = "1#IND"
        case the1Inf = "1#INF"
        case the21474836481 = "-2147483648/-1"
        case the22250738585072011E308 = "2.2250738585072011e-308"
        case theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers = "# The next line may appear to be blank, mojibake, or dingbats in some viewers."
        case theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers = "# The next line may appear to be blank or mojibake in some viewers."
        case theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers = "# The next line may be flagged for \"trailing whitespace\" in some viewers."
        case the１２３ = "１２３"
        case thisFileUnfortunatelyCannotExpressStringsContaining = "# This file unfortunately cannot express strings containing"
        case touchTmpBlnsFail = "$(touch /tmp/blns.fail)"
        case touchTmpBlnsShellshock2Fail = "() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }"
        case tysonGay = "Tyson Gay"
        case unicodeSymbols = "#\tUnicode Symbols"
        case x00ScriptJavascriptAlert1Script = "'`\"><\\x00script>javascript:alert(1)</script>"
        case x3CscriptJavascriptAlert1Script = "'`\"><\\x3Cscript>javascript:alert(1)</script>"
        case åßƑÆ = "åß∂ƒ©˙∆˚¬…æ"
        case ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo = "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"
        case ωÇΜ = "Ω≈ç√∫˜µ≤≥÷"
        case ຈلຈﾉຈلຈﾉ = "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"
        case ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS = "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"
        case 社會科學院語學研究所 = "社會科學院語學研究所"
        case 部落格 = "部落格"
        case 사회과학원어학연구소 = "사회과학원 어학연구소"
        case 찦차를타고온펲시맨과쑛다리똠방각하 = "찦차를 타고 온 펲시맨과 쑛다리 똠방각하"
        case ﷺ = "ﷺ"
        case ﾛ_ = "__ﾛ(,_,*)"
    }
}

// MARK: B convenience initializers and mutators

extension B {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(B.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: String? = nil,
        aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        abcDivStyleXExpressionX5CJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX0AexpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX0DexpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF: String? = nil,
        appearInInput: String? = nil,
        ath0: String? = nil,
        autofocusOnkeyupJavascriptAlert123: String? = nil,
        b: String? = nil,
        b100000: String? = nil,
        bFALSE: String? = nil,
        bIMGSRCOnmouseoverAlertXxs: String? = nil,
        bNIL: String? = nil,
        bScriptAlert123Script: String? = nil,
        bTouchTmpBlnsFail: String? = nil,
        basement: String? = nil,
        butNow20CforMyGreatestTrick8M: String? = nil,
        byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine: String? = nil,
        com1: String? = nil,
        com3: String? = nil,
        commonlyMisinterpretedAsAdditionalGraphicCharacters: String? = nil,
        con: String? = nil,
        contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition: String? = nil,
        creditHTTPSTwitterCOMJifaStatus625776454479970304: String? = nil,
        devNullTouchTmpBlnsFailEcho: String? = nil,
        dontMakeAMap: Bool? = nil,
        empty: String? = nil,
        evalPutsHelloWorld: String? = nil,
        expression: String? = nil,
        file: String? = nil,
        fileInclusion: String? = nil,
        fluffy: String? = nil,
        fooValBar: String? = nil,
        generalCategoryCFInUnicode800: String? = nil,
        hEWHOWAĮTSBEHINDTHEWALḼ: String? = nil,
        help: String? = nil,
        hilarious: String? = nil,
        httpA3030: String? = nil,
        iOSVulnerabilities: String? = nil,
        ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: String? = nil,
        iframeSrcHTTPHaCkersOrgScriptletHTML: String? = nil,
        imgSRC14JavascriptAlertXSS: String? = nil,
        imgSRCJavX09AscriptAlertXSS: String? = nil,
        imgSRCOnmouseoverAlertXxs: String? = nil,
        imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: String? = nil,
        imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: String? = nil,
        imgSrcX00XOnerrorJavascriptAlert1: String? = nil,
        imgSrcXOnerrorX11JavascriptAlert1: String? = nil,
        imgSrcXOnerrorX12JavascriptAlert1: String? = nil,
        imgSrcXxxXX0AonerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX0ConerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX0DonerrorJavascriptAlert1: String? = nil,
        imgX00SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX11SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX12SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX47SrcXOnerrorJavascriptAlert1: String? = nil,
        indecent: String? = nil,
        indigo: String? = nil,
        ircSpecificStrings: String? = nil,
        japaneseEmoticons: String? = nil,
        kernelExecLsAl: String? = nil,
        lindaCallahan: String? = nil,
        nul: String? = nil,
        null: String? = nil,
        numericStrings: String? = nil,
        oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML: String? = nil,
        onfocusJaVaSCriptAlert123Autofocus: String? = nil,
        or111: String? = nil,
        purple: String? = nil,
        purpleScriptAlert123Script: String? = nil,
        quotationMarks: String? = nil,
        regionalIndicatorSymbols: String? = nil,
        regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: String? = nil,
        reservedStrings: String? = nil,
        scriptAlert123Script: String? = nil,
        scriptAlert123ScriptX: String? = nil,
        scriptAlertXSSSCRIPT: String? = nil,
        scriptSRCHaCkersOrgJ: String? = nil,
        scriptSrcJscriptSScript: String? = nil,
        scriptX09JavascriptAlert1Script: String? = nil,
        scriptX0AtypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX0DtypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX21JavascriptAlert1Script: String? = nil,
        scriptX3BjavascriptAlert1Script: String? = nil,
        scriptXE2X80X85JavascriptAlert1Script: String? = nil,
        scriptXE2X80X87JavascriptAlert1Script: String? = nil,
        scriptXE2X80X8AjavascriptAlert1Script: String? = nil,
        scriptXE2X80XA8JavascriptAlert1Script: String? = nil,
        scriptXE2X80XA9JavascriptAlert1Script: String? = nil,
        scriptXE2X80XAFjavascriptAlert1Script: String? = nil,
        scriptXE3X80X80JavascriptAlert1Script: String? = nil,
        scunthorpeProblem: String? = nil,
        sticky: String? = nil,
        stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut: String? = nil,
        stringsWhichAreReservedCharactersInMSDOSWindows: String? = nil,
        stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS: String? = nil,
        stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew: String? = nil,
        stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: String? = nil,
        stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: String? = nil,
        stringsWhichMayBeUsedElsewhereInCode: String? = nil,
        tentacled: String? = nil,
        terminalEscapeCodes: String? = nil,
        the000: String? = nil,
        the01000: String? = nil,
        the08: String? = nil,
        the09: String? = nil,
        the0Xffffffffffffffff: String? = nil,
        the100: String? = nil,
        the1000: String? = nil,
        the100000: String? = nil,
        the100000000: String? = nil,
        the1DROPTABLEUsers1: String? = nil,
        the1Ind: String? = nil,
        the1Inf: String? = nil,
        the21474836481: String? = nil,
        the22250738585072011E308: String? = nil,
        theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: String? = nil,
        theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: String? = nil,
        theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: String? = nil,
        the１２３: String? = nil,
        thisFileUnfortunatelyCannotExpressStringsContaining: String? = nil,
        touchTmpBlnsFail: String? = nil,
        touchTmpBlnsShellshock2Fail: String? = nil,
        tysonGay: String? = nil,
        unicodeSymbols: String? = nil,
        x00ScriptJavascriptAlert1Script: String? = nil,
        x3CscriptJavascriptAlert1Script: String? = nil,
        åßƑÆ: String? = nil,
        ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo: String? = nil,
        ωÇΜ: String? = nil,
        ຈلຈﾉຈلຈﾉ: String? = nil,
        ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS: String? = nil,
        社會科學院語學研究所: String? = nil,
        部落格: String? = nil,
        사회과학원어학연구소: String? = nil,
        찦차를타고온펲시맨과쑛다리똠방각하: String? = nil,
        ﷺ: String? = nil,
        ﾛ_: String? = nil
    ) -> B {
        return B(
            aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A ?? self.aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A,
            aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA: aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA ?? self.aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA,
            aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA: aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA,
            aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA,
            abcDivStyleXExpressionX5CJavascriptAlert1DEF: abcDivStyleXExpressionX5CJavascriptAlert1DEF ?? self.abcDivStyleXExpressionX5CJavascriptAlert1DEF,
            abcDivStyleXX0AexpressionJavascriptAlert1DEF: abcDivStyleXX0AexpressionJavascriptAlert1DEF ?? self.abcDivStyleXX0AexpressionJavascriptAlert1DEF,
            abcDivStyleXX0DexpressionJavascriptAlert1DEF: abcDivStyleXX0DexpressionJavascriptAlert1DEF ?? self.abcDivStyleXX0DexpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF,
            appearInInput: appearInInput ?? self.appearInInput,
            ath0: ath0 ?? self.ath0,
            autofocusOnkeyupJavascriptAlert123: autofocusOnkeyupJavascriptAlert123 ?? self.autofocusOnkeyupJavascriptAlert123,
            b: b ?? self.b,
            b100000: b100000 ?? self.b100000,
            bFALSE: bFALSE ?? self.bFALSE,
            bIMGSRCOnmouseoverAlertXxs: bIMGSRCOnmouseoverAlertXxs ?? self.bIMGSRCOnmouseoverAlertXxs,
            bNIL: bNIL ?? self.bNIL,
            bScriptAlert123Script: bScriptAlert123Script ?? self.bScriptAlert123Script,
            bTouchTmpBlnsFail: bTouchTmpBlnsFail ?? self.bTouchTmpBlnsFail,
            basement: basement ?? self.basement,
            butNow20CforMyGreatestTrick8M: butNow20CforMyGreatestTrick8M ?? self.butNow20CforMyGreatestTrick8M,
            byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine: byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine ?? self.byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine,
            com1: com1 ?? self.com1,
            com3: com3 ?? self.com3,
            commonlyMisinterpretedAsAdditionalGraphicCharacters: commonlyMisinterpretedAsAdditionalGraphicCharacters ?? self.commonlyMisinterpretedAsAdditionalGraphicCharacters,
            con: con ?? self.con,
            contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition: contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition ?? self.contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition,
            creditHTTPSTwitterCOMJifaStatus625776454479970304: creditHTTPSTwitterCOMJifaStatus625776454479970304 ?? self.creditHTTPSTwitterCOMJifaStatus625776454479970304,
            devNullTouchTmpBlnsFailEcho: devNullTouchTmpBlnsFailEcho ?? self.devNullTouchTmpBlnsFailEcho,
            dontMakeAMap: dontMakeAMap ?? self.dontMakeAMap,
            empty: empty ?? self.empty,
            evalPutsHelloWorld: evalPutsHelloWorld ?? self.evalPutsHelloWorld,
            expression: expression ?? self.expression,
            file: file ?? self.file,
            fileInclusion: fileInclusion ?? self.fileInclusion,
            fluffy: fluffy ?? self.fluffy,
            fooValBar: fooValBar ?? self.fooValBar,
            generalCategoryCFInUnicode800: generalCategoryCFInUnicode800 ?? self.generalCategoryCFInUnicode800,
            hEWHOWAĮTSBEHINDTHEWALḼ: hEWHOWAĮTSBEHINDTHEWALḼ ?? self.hEWHOWAĮTSBEHINDTHEWALḼ,
            help: help ?? self.help,
            hilarious: hilarious ?? self.hilarious,
            httpA3030: httpA3030 ?? self.httpA3030,
            iOSVulnerabilities: iOSVulnerabilities ?? self.iOSVulnerabilities,
            ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou ?? self.ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou,
            iframeSrcHTTPHaCkersOrgScriptletHTML: iframeSrcHTTPHaCkersOrgScriptletHTML ?? self.iframeSrcHTTPHaCkersOrgScriptletHTML,
            imgSRC14JavascriptAlertXSS: imgSRC14JavascriptAlertXSS ?? self.imgSRC14JavascriptAlertXSS,
            imgSRCJavX09AscriptAlertXSS: imgSRCJavX09AscriptAlertXSS ?? self.imgSRCJavX09AscriptAlertXSS,
            imgSRCOnmouseoverAlertXxs: imgSRCOnmouseoverAlertXxs ?? self.imgSRCOnmouseoverAlertXxs,
            imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29 ?? self.imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29,
            imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041 ?? self.imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041,
            imgSrcX00XOnerrorJavascriptAlert1: imgSrcX00XOnerrorJavascriptAlert1 ?? self.imgSrcX00XOnerrorJavascriptAlert1,
            imgSrcXOnerrorX11JavascriptAlert1: imgSrcXOnerrorX11JavascriptAlert1 ?? self.imgSrcXOnerrorX11JavascriptAlert1,
            imgSrcXOnerrorX12JavascriptAlert1: imgSrcXOnerrorX12JavascriptAlert1 ?? self.imgSrcXOnerrorX12JavascriptAlert1,
            imgSrcXxxXX0AonerrorJavascriptAlert1: imgSrcXxxXX0AonerrorJavascriptAlert1 ?? self.imgSrcXxxXX0AonerrorJavascriptAlert1,
            imgSrcXxxXX0ConerrorJavascriptAlert1: imgSrcXxxXX0ConerrorJavascriptAlert1 ?? self.imgSrcXxxXX0ConerrorJavascriptAlert1,
            imgSrcXxxXX0DonerrorJavascriptAlert1: imgSrcXxxXX0DonerrorJavascriptAlert1 ?? self.imgSrcXxxXX0DonerrorJavascriptAlert1,
            imgX00SrcXOnerrorJavascriptAlert1: imgX00SrcXOnerrorJavascriptAlert1 ?? self.imgX00SrcXOnerrorJavascriptAlert1,
            imgX11SrcXOnerrorJavascriptAlert1: imgX11SrcXOnerrorJavascriptAlert1 ?? self.imgX11SrcXOnerrorJavascriptAlert1,
            imgX12SrcXOnerrorJavascriptAlert1: imgX12SrcXOnerrorJavascriptAlert1 ?? self.imgX12SrcXOnerrorJavascriptAlert1,
            imgX47SrcXOnerrorJavascriptAlert1: imgX47SrcXOnerrorJavascriptAlert1 ?? self.imgX47SrcXOnerrorJavascriptAlert1,
            indecent: indecent ?? self.indecent,
            indigo: indigo ?? self.indigo,
            ircSpecificStrings: ircSpecificStrings ?? self.ircSpecificStrings,
            japaneseEmoticons: japaneseEmoticons ?? self.japaneseEmoticons,
            kernelExecLsAl: kernelExecLsAl ?? self.kernelExecLsAl,
            lindaCallahan: lindaCallahan ?? self.lindaCallahan,
            nul: nul ?? self.nul,
            null: null ?? self.null,
            numericStrings: numericStrings ?? self.numericStrings,
            oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML: oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML ?? self.oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML,
            onfocusJaVaSCriptAlert123Autofocus: onfocusJaVaSCriptAlert123Autofocus ?? self.onfocusJaVaSCriptAlert123Autofocus,
            or111: or111 ?? self.or111,
            purple: purple ?? self.purple,
            purpleScriptAlert123Script: purpleScriptAlert123Script ?? self.purpleScriptAlert123Script,
            quotationMarks: quotationMarks ?? self.quotationMarks,
            regionalIndicatorSymbols: regionalIndicatorSymbols ?? self.regionalIndicatorSymbols,
            regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross ?? self.regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross,
            reservedStrings: reservedStrings ?? self.reservedStrings,
            scriptAlert123Script: scriptAlert123Script ?? self.scriptAlert123Script,
            scriptAlert123ScriptX: scriptAlert123ScriptX ?? self.scriptAlert123ScriptX,
            scriptAlertXSSSCRIPT: scriptAlertXSSSCRIPT ?? self.scriptAlertXSSSCRIPT,
            scriptSRCHaCkersOrgJ: scriptSRCHaCkersOrgJ ?? self.scriptSRCHaCkersOrgJ,
            scriptSrcJscriptSScript: scriptSrcJscriptSScript ?? self.scriptSrcJscriptSScript,
            scriptX09JavascriptAlert1Script: scriptX09JavascriptAlert1Script ?? self.scriptX09JavascriptAlert1Script,
            scriptX0AtypeTextJavascriptJavascriptAlert1Script: scriptX0AtypeTextJavascriptJavascriptAlert1Script ?? self.scriptX0AtypeTextJavascriptJavascriptAlert1Script,
            scriptX0DtypeTextJavascriptJavascriptAlert1Script: scriptX0DtypeTextJavascriptJavascriptAlert1Script ?? self.scriptX0DtypeTextJavascriptJavascriptAlert1Script,
            scriptX21JavascriptAlert1Script: scriptX21JavascriptAlert1Script ?? self.scriptX21JavascriptAlert1Script,
            scriptX3BjavascriptAlert1Script: scriptX3BjavascriptAlert1Script ?? self.scriptX3BjavascriptAlert1Script,
            scriptXE2X80X85JavascriptAlert1Script: scriptXE2X80X85JavascriptAlert1Script ?? self.scriptXE2X80X85JavascriptAlert1Script,
            scriptXE2X80X87JavascriptAlert1Script: scriptXE2X80X87JavascriptAlert1Script ?? self.scriptXE2X80X87JavascriptAlert1Script,
            scriptXE2X80X8AjavascriptAlert1Script: scriptXE2X80X8AjavascriptAlert1Script ?? self.scriptXE2X80X8AjavascriptAlert1Script,
            scriptXE2X80XA8JavascriptAlert1Script: scriptXE2X80XA8JavascriptAlert1Script ?? self.scriptXE2X80XA8JavascriptAlert1Script,
            scriptXE2X80XA9JavascriptAlert1Script: scriptXE2X80XA9JavascriptAlert1Script ?? self.scriptXE2X80XA9JavascriptAlert1Script,
            scriptXE2X80XAFjavascriptAlert1Script: scriptXE2X80XAFjavascriptAlert1Script ?? self.scriptXE2X80XAFjavascriptAlert1Script,
            scriptXE3X80X80JavascriptAlert1Script: scriptXE3X80X80JavascriptAlert1Script ?? self.scriptXE3X80X80JavascriptAlert1Script,
            scunthorpeProblem: scunthorpeProblem ?? self.scunthorpeProblem,
            sticky: sticky ?? self.sticky,
            stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut: stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut ?? self.stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut,
            stringsWhichAreReservedCharactersInMSDOSWindows: stringsWhichAreReservedCharactersInMSDOSWindows ?? self.stringsWhichAreReservedCharactersInMSDOSWindows,
            stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS: stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS ?? self.stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS,
            stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew: stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew ?? self.stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew,
            stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues ?? self.stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues,
            stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric ?? self.stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric,
            stringsWhichMayBeUsedElsewhereInCode: stringsWhichMayBeUsedElsewhereInCode ?? self.stringsWhichMayBeUsedElsewhereInCode,
            tentacled: tentacled ?? self.tentacled,
            terminalEscapeCodes: terminalEscapeCodes ?? self.terminalEscapeCodes,
            the000: the000 ?? self.the000,
            the01000: the01000 ?? self.the01000,
            the08: the08 ?? self.the08,
            the09: the09 ?? self.the09,
            the0Xffffffffffffffff: the0Xffffffffffffffff ?? self.the0Xffffffffffffffff,
            the100: the100 ?? self.the100,
            the1000: the1000 ?? self.the1000,
            the100000: the100000 ?? self.the100000,
            the100000000: the100000000 ?? self.the100000000,
            the1DROPTABLEUsers1: the1DROPTABLEUsers1 ?? self.the1DROPTABLEUsers1,
            the1Ind: the1Ind ?? self.the1Ind,
            the1Inf: the1Inf ?? self.the1Inf,
            the21474836481: the21474836481 ?? self.the21474836481,
            the22250738585072011E308: the22250738585072011E308 ?? self.the22250738585072011E308,
            theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers ?? self.theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers,
            theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers ?? self.theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers,
            theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers ?? self.theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers,
            the１２３: the１２３ ?? self.the１２３,
            thisFileUnfortunatelyCannotExpressStringsContaining: thisFileUnfortunatelyCannotExpressStringsContaining ?? self.thisFileUnfortunatelyCannotExpressStringsContaining,
            touchTmpBlnsFail: touchTmpBlnsFail ?? self.touchTmpBlnsFail,
            touchTmpBlnsShellshock2Fail: touchTmpBlnsShellshock2Fail ?? self.touchTmpBlnsShellshock2Fail,
            tysonGay: tysonGay ?? self.tysonGay,
            unicodeSymbols: unicodeSymbols ?? self.unicodeSymbols,
            x00ScriptJavascriptAlert1Script: x00ScriptJavascriptAlert1Script ?? self.x00ScriptJavascriptAlert1Script,
            x3CscriptJavascriptAlert1Script: x3CscriptJavascriptAlert1Script ?? self.x3CscriptJavascriptAlert1Script,
            åßƑÆ: åßƑÆ ?? self.åßƑÆ,
            ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo: ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo ?? self.ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo,
            ωÇΜ: ωÇΜ ?? self.ωÇΜ,
            ຈلຈﾉຈلຈﾉ: ຈلຈﾉຈلຈﾉ ?? self.ຈلຈﾉຈلຈﾉ,
            ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS: ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS ?? self.ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS,
            社會科學院語學研究所: 社會科學院語學研究所 ?? self.社會科學院語學研究所,
            部落格: 部落格 ?? self.部落格,
            사회과학원어학연구소: 사회과학원어학연구소 ?? self.사회과학원어학연구소,
            찦차를타고온펲시맨과쑛다리똠방각하: 찦차를타고온펲시맨과쑛다리똠방각하 ?? self.찦차를타고온펲시맨과쑛다리똠방각하,
            ﷺ: ﷺ ?? self.ﷺ,
            ﾛ_: ﾛ_ ?? self.ﾛ_
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - C
struct C: Codable {
    let _1: String
    let a: String
    let aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String
    let abcDivStyleXExpressionX00JavascriptAlert1DEF: String
    let abcDivStyleXX00ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXX0CexpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF: String
    let abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF: String
    let ambitious: String
    let andU007FDEL: String
    let asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: String
    let bodyOnloadAlertXSS: String
    let braggadocious: String
    let c: String
    let c00: String
    let c000: String
    let c100: String
    let c100000: String
    let c100000000: String
    let c1E02: String
    let cScriptAlert123Script: String
    let cTrue: String
    let clock: String
    let com2: String
    let com4: String
    let craigCockburnSoftwareSpecialist: String
    let cunning: String
    let dccSendStartkeylogger000: String
    let dontMakeAMap: Bool
    let emoji: String
    let empty: String
    let evaluate: String
    let fluffy: String
    let fluffy00: String
    let fooValBar: String
    let frisky: String
    let hasOwnProperty: String
    let hilarious: String
    let hornimanMuseum: String
    let httpWWWCumQcCA: String
    let iOnwheelAlert1ScrollOverMeI: String
    let imgABCSrcDXEOnerrorFAlert1: String
    let imgOnmouseoverAlertXxs: String
    let imgSCRIPTAlertXSSSCRIPT: String
    let imgSRCJavascriptAlertStringFromCharCode888383: String
    let imgSRCJavascriptAlertXSS: String
    let imgSrcOnerrorAltJavascriptAlert1: String
    let imgSrcX10XOnerrorJavascriptAlert1: String
    let imgSrcX12XOnerrorJavascriptAlert1: String
    let imgSrcX13XOnerrorJavascriptAlert1: String
    let imgSrcX32XOnerrorJavascriptAlert1: String
    let imgSrcX47XOnerrorJavascriptAlert1: String
    let imgSrcXOnerrorAlert123: String
    let imgSrcXOnerrorX10JavascriptAlert1: String
    let imgSrcXOnerrorX32JavascriptAlert1: String
    let imgSrcXScriptJavascriptAlert1Script: String
    let imgSrcXxxXX09OnerrorJavascriptAlert1: String
    let imgSrcXxxXX20OnerrorJavascriptAlert1: String
    let imgSrcXxxXX22OnerrorJavascriptAlert1: String
    let imgSrcXxxXX27OnerrorJavascriptAlert1: String
    let imgX11SrcXOnerrorJavascriptAlert1: String
    let imgX34SrcXOnerrorJavascriptAlert1: String
    let imgX47SrcXOnerrorJavascriptAlert1: String
    let indecent: String
    let indigo: String
    let infinity: String
    let javaSCriptAlert123: String
    let lpt1: String
    let ltScriptGtAlert3912339LtScriptGt: String
    let magenta: String
    let magnaCumLaude: String
    let medievalErectionOfParapets: String
    let mischievous: String
    let mocha: String
    let naN: String
    let nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: String
    let null: String
    let onfocusJaVaSCriptAlert123Autofocus: String
    let orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: String
    let plaintext: String
    let powerللصبللصبررH冗: String
    let purple: String
    let purple00: String
    let purple100000: String
    let purple100000000: String
    let purpleScriptAlert123Script: String
    let rightToLeftStrings: String
    let rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: String
    let s: String
    let scriptAlert123Script: String
    let scriptAlert123ScriptX: String
    let scriptJavascriptAlert1Script: String
    let scriptScriptAlert123Script: String
    let scriptSrcJscriptSScript: String
    let scriptX0AjavascriptAlert1Script: String
    let scriptX0BjavascriptAlert1Script: String
    let scriptX0CtypeTextJavascriptJavascriptAlert1Script: String
    let scriptX20JavascriptAlert1Script: String
    let scriptX2BjavascriptAlert1Script: String
    let scriptX2FtypeTextJavascriptJavascriptAlert1Script: String
    let scriptX7EjavascriptAlert1Script: String
    let scriptXE2X80X80JavascriptAlert1Script: String
    let scriptXE2X80X82JavascriptAlert1Script: String
    let scriptXE2X80X83JavascriptAlert1Script: String
    let scriptXE2X80X84JavascriptAlert1Script: String
    let scriptXE2X80X88JavascriptAlert1Script: String
    let scriptXE2X80X8BjavascriptAlert1Script: String
    let scriptXEFXBFXAEjavascriptAlert1Script: String
    let scriptXEFXBFXBEjavascriptAlert1Script: String
    let scunthorpeGeneralHospital: String
    let serverCodeInjection: String
    let shitakeMushrooms: String
    let specialCharacters: String
    let srcJaVaSCriptPrompt132: String
    let sticky: String
    let stringsWhichCanBeInterpretedAsNumeric: String
    let stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized: String
    let stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: String
    let stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153: String
    let stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet: String
    let stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM: String
    let stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF: String
    let stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: String
    let svgScript1231Alert123Script: String
    let systemLsAl: String
    let systemTouchTmpBlnsFail: String
    let tentacled: String
    let test: String
    let testTest: String
    let the0: String
    let the00: String
    let the000: String
    let the0123456789: String
    let the0TouchTmpBlnsShellshock1Fail: String
    let the0Xabad1Dea: String
    let the0Xffffffff: String
    let the1: String
    let the100: String
    let the100000: String
    let the100000000: String
    let the12: String
    let the1E02: String
    let the1E2: String
    let the1Ind: String
    let the2: String
    let the3: String
    let the4: String
    let the92233720368547758081: String
    let the١٢٣: String
    let titleOnpropertychangeJavascriptAlert1TitleTitleTitle: String
    let treatedAsWhitespaceInSomeContexts: String
    let trickUnicode: String
    let undefined: String
    let unicodeAdditionalControlCharactersAllOfTheCharactersWith: String
    let unicodeSubscriptSuperscriptAccents: String
    let unicodeUpsidedown: String
    let user: String
    let version: String
    let version800PlusU0009HTU000BVTU000CFFU0085NEL: String
    let whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: String
    let xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo: String
    let xxeInjectionXML: String
    let zalgoText: String
    let zz: String
    let åíîïÓôÒúæ: String
    let ω: String
    let ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя: String
    let בראשיתבראאלהיםאתהשמיםואתהארץ: String
    let مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية: String
    let ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO: String
    let ノº_ºノ: String
    let 울란바토르: String
    let ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ: String
    let ﾉಥ益ಥﾉ: String

    enum CodingKeys: String, CodingKey {
        case _1 = "\u{2070e}\u{20731}\u{20779}\u{20c53}\u{20c78}\u{20c96}\u{20ccf}"
        case a = "A:"
        case aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA = "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"
        case abcDivStyleXExpressionX00JavascriptAlert1DEF = "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"
        case abcDivStyleXX00ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"
        case abcDivStyleXX0CexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"
        case abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF = "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"
        case ambitious = "_"
        case andU007FDEL = "# and U+007F (DEL)"
        case asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome = "# ASCII punctuation.  All of these characters may need to be escaped in some"
        case bodyOnloadAlertXSS = "<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"
        case braggadocious = "\u{1d413}\u{1d421}\u{1d41e} \u{1d42a}\u{1d42e}\u{1d422}\u{1d41c}\u{1d424} \u{1d41b}\u{1d42b}\u{1d428}\u{1d430}\u{1d427} \u{1d41f}\u{1d428}\u{1d431} \u{1d423}\u{1d42e}\u{1d426}\u{1d429}\u{1d42c} \u{1d428}\u{1d42f}\u{1d41e}\u{1d42b} \u{1d42d}\u{1d421}\u{1d41e} \u{1d425}\u{1d41a}\u{1d433}\u{1d432} \u{1d41d}\u{1d428}\u{1d420}"
        case c = "\"'\"'\"''''\""
        case c00 = "-0.0"
        case c000 = "0.0/0"
        case c100 = "-1.00"
        case c100000 = "1,000.00"
        case c100000000 = "1,000,000.00"
        case c1E02 = "1E+02"
        case cScriptAlert123Script = "><script>alert(123)</script>"
        case cTrue = "true"
        case clock = "CLOCK$"
        case com2 = "COM2"
        case com4 = "COM4"
        case craigCockburnSoftwareSpecialist = "Craig Cockburn, Software Specialist"
        case cunning = "⁰⁴⁵"
        case dccSendStartkeylogger000 = "DCC SEND STARTKEYLOGGER 0 0 0"
        case dontMakeAMap = "dontMakeAMap"
        case emoji = "#\tEmoji"
        case empty = "\"\""
        case evaluate = "evaluate"
        case fluffy = "%"
        case fluffy00 = "0/0"
        case fooValBar = "<foo val=“bar” />"
        case frisky = "✋\u{1f3ff} \u{1f4aa}\u{1f3ff} \u{1f450}\u{1f3ff} \u{1f64c}\u{1f3ff} \u{1f44f}\u{1f3ff} \u{1f64f}\u{1f3ff}"
        case hasOwnProperty = "hasOwnProperty"
        case hilarious = "\\\\"
        case hornimanMuseum = "Horniman Museum"
        case httpWWWCumQcCA = "http://www.cum.qc.ca/"
        case iOnwheelAlert1ScrollOverMeI = "<i onwheel=alert(1)> Scroll over me </i>"
        case imgABCSrcDXEOnerrorFAlert1 = "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"
        case imgOnmouseoverAlertXxs = "<IMG onmouseover=\"alert('xxs')\">"
        case imgSCRIPTAlertXSSSCRIPT = "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"
        case imgSRCJavascriptAlertStringFromCharCode888383 = "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"
        case imgSRCJavascriptAlertXSS = "<IMG SRC=\"javascript:alert('XSS')\""
        case imgSrcOnerrorAltJavascriptAlert1 = "<img src onerror /\" '\"= alt=javascript:alert(1)//\">"
        case imgSrcX10XOnerrorJavascriptAlert1 = "<img src\\x10=x onerror=\"javascript:alert(1)\">"
        case imgSrcX12XOnerrorJavascriptAlert1 = "<img src\\x12=x onerror=\"javascript:alert(1)\">"
        case imgSrcX13XOnerrorJavascriptAlert1 = "<img src\\x13=x onerror=\"javascript:alert(1)\">"
        case imgSrcX32XOnerrorJavascriptAlert1 = "<img src\\x32=x onerror=\"javascript:alert(1)\">"
        case imgSrcX47XOnerrorJavascriptAlert1 = "<img src\\x47=x onerror=\"javascript:alert(1)\">"
        case imgSrcXOnerrorAlert123 = "<img src=x onerror=alert(123) />"
        case imgSrcXOnerrorX10JavascriptAlert1 = "<img src=x onerror=\\x10\"javascript:alert(1)\">"
        case imgSrcXOnerrorX32JavascriptAlert1 = "<img src=x onerror=\\x32\"javascript:alert(1)\">"
        case imgSrcXScriptJavascriptAlert1Script = "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"
        case imgSrcXxxXX09OnerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"
        case imgSrcXxxXX20OnerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"
        case imgSrcXxxXX22OnerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"
        case imgSrcXxxXX27OnerrorJavascriptAlert1 = "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"
        case imgX11SrcXOnerrorJavascriptAlert1 = "<img\\x11src=x onerror=\"javascript:alert(1)\">"
        case imgX34SrcXOnerrorJavascriptAlert1 = "<img \\x34src=x onerror=\"javascript:alert(1)\">"
        case imgX47SrcXOnerrorJavascriptAlert1 = "<img\\x47src=x onerror=\"javascript:alert(1)\">"
        case indecent = "."
        case indigo = "--"
        case infinity = "Infinity"
        case javaSCriptAlert123 = "JavaSCript:alert(123)"
        case lpt1 = "LPT1"
        case ltScriptGtAlert3912339LtScriptGt = "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"
        case magenta = "⅛⅜⅝⅞"
        case magnaCumLaude = "magna cum laude"
        case medievalErectionOfParapets = "medieval erection of parapets"
        case mischievous = "・(￣∀￣)・:*:"
        case mocha = "mocha"
        case naN = "NaN"
        case nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F = "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"
        case null = "NULL"
        case onfocusJaVaSCriptAlert123Autofocus = "' onfocus=JaVaSCript:alert(123) autofocus"
        case orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever = "# or reused for internal delimiters on the theory that they should never"
        case plaintext = "<plaintext>"
        case powerللصبللصبررH冗 = "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"
        case purple = "\"''''\"'\""
        case purple00 = "0,,0"
        case purple100000 = "1.000,00"
        case purple100000000 = "1.000.000,00"
        case purpleScriptAlert123Script = "＜script＞alert(123)＜/script＞"
        case rightToLeftStrings = "#\tRight-To-Left Strings"
        case rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue = "Roses are \u{1b}[0;31mred\u{1b}[0m, violets are \u{1b}[0;34mblue. Hope you enjoy terminal hue"
        case s = "%*.*s"
        case scriptAlert123Script = "'><script>alert(123)</script>"
        case scriptAlert123ScriptX = "'><script>alert(123);</script x='"
        case scriptJavascriptAlert1Script = "\"`'><script>-javascript:alert(1)</script>"
        case scriptScriptAlert123Script = "< / script >< script >alert(123)< / script >"
        case scriptSrcJscriptSScript = "<script src=\"/\\%(jscript)s\"></script>"
        case scriptX0AjavascriptAlert1Script = "\"`'><script>\\x0Ajavascript:alert(1)</script>"
        case scriptX0BjavascriptAlert1Script = "\"`'><script>\\x0Bjavascript:alert(1)</script>"
        case scriptX0CtypeTextJavascriptJavascriptAlert1Script = "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX20JavascriptAlert1Script = "\"`'><script>\\x20javascript:alert(1)</script>"
        case scriptX2BjavascriptAlert1Script = "\"`'><script>\\x2Bjavascript:alert(1)</script>"
        case scriptX2FtypeTextJavascriptJavascriptAlert1Script = "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"
        case scriptX7EjavascriptAlert1Script = "\"`'><script>\\x7Ejavascript:alert(1)</script>"
        case scriptXE2X80X80JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"
        case scriptXE2X80X82JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"
        case scriptXE2X80X83JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"
        case scriptXE2X80X84JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"
        case scriptXE2X80X88JavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"
        case scriptXE2X80X8BjavascriptAlert1Script = "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"
        case scriptXEFXBFXAEjavascriptAlert1Script = "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"
        case scriptXEFXBFXBEjavascriptAlert1Script = "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"
        case scunthorpeGeneralHospital = "Scunthorpe General Hospital"
        case serverCodeInjection = "#\tServer Code Injection"
        case shitakeMushrooms = "shitake mushrooms"
        case specialCharacters = "#\tSpecial Characters"
        case srcJaVaSCriptPrompt132 = "src=JaVaSCript:prompt(132)"
        case sticky = "-"
        case stringsWhichCanBeInterpretedAsNumeric = "#\tStrings which can be interpreted as numeric"
        case stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized = "#\tStrings which can cause a SQL injection if inputs are not sanitized"
        case stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer = "#\tStrings which can cause user to pull in files that should not be a part of a web server"
        case stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153 = "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"
        case stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet = "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"
        case stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM = "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"
        case stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF = "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"
        case stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile = "#\tStrings which punish the fools who use cat/type on this file"
        case svgScript1231Alert123Script = "<svg><script>123<1>alert(123)</script>"
        case systemLsAl = "System(\"ls -al /\")"
        case systemTouchTmpBlnsFail = "@{[system \"touch /tmp/blns.fail\"]}"
        case tentacled = "''"
        case test = "\u{2029}test\u{2029}"
        case testTest = "test\u{2060}test\u{202b}"
        case the0 = "\u{1f3f3}0\u{1f308}️"
        case the00 = "+0.0"
        case the000 = "0.0.0"
        case the0123456789 = "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \u{1f51f}"
        case the0TouchTmpBlnsShellshock1Fail = "() { 0; }; touch /tmp/blns.shellshock1.fail;"
        case the0Xabad1Dea = "0xabad1dea"
        case the0Xffffffff = "0xffffffff"
        case the1 = "--1"
        case the100 = "-$1.00"
        case the100000 = "1 000,00"
        case the100000000 = "1'000'000,00"
        case the12 = "-1/2"
        case the1E02 = "-1E+02"
        case the1E2 = "-1E2"
        case the1Ind = "-1#IND"
        case the2 = "\u{1d683}\u{1d691}\u{1d68e} \u{1d69a}\u{1d69e}\u{1d692}\u{1d68c}\u{1d694} \u{1d68b}\u{1d69b}\u{1d698}\u{1d6a0}\u{1d697} \u{1d68f}\u{1d698}\u{1d6a1} \u{1d693}\u{1d69e}\u{1d696}\u{1d699}\u{1d69c} \u{1d698}\u{1d69f}\u{1d68e}\u{1d69b} \u{1d69d}\u{1d691}\u{1d68e} \u{1d695}\u{1d68a}\u{1d6a3}\u{1d6a2} \u{1d68d}\u{1d698}\u{1d690}"
        case the3 = "\u{1f435} \u{1f648} \u{1f649} \u{1f64a}"
        case the4 = "\u{1f47e} \u{1f647} \u{1f481} \u{1f645} \u{1f646} \u{1f64b} \u{1f64e} \u{1f64d}"
        case the92233720368547758081 = "-9223372036854775808/-1"
        case the١٢٣ = "١٢٣"
        case titleOnpropertychangeJavascriptAlert1TitleTitleTitle = "<title onpropertychange=javascript:alert(1)></title><title title=>"
        case treatedAsWhitespaceInSomeContexts = "# treated as whitespace in some contexts."
        case trickUnicode = "#\tTrick Unicode"
        case undefined = "undefined"
        case unicodeAdditionalControlCharactersAllOfTheCharactersWith = "# Unicode additional control characters: all of the characters with"
        case unicodeSubscriptSuperscriptAccents = "#\tUnicode Subscript/Superscript/Accents"
        case unicodeUpsidedown = "#\tUnicode Upsidedown"
        case user = "$USER"
        case version = "--version"
        case version800PlusU0009HTU000BVTU000CFFU0085NEL = "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"
        case whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode = "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"
        case xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"
        case xxeInjectionXML = "#      XXE Injection (XML)"
        case zalgoText = "#\tZalgo Text"
        case zz = "ZZ:"
        case åíîïÓôÒúæ = "ÅÍÎÏ˝ÓÔ\u{f8ff}ÒÚÆ☃"
        case ω = ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"
        case ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя = "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"
        case בראשיתבראאלהיםאתהשמיםואתהארץ = "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"
        case مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية = "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "
        case ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO = "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"
        case ノº_ºノ = "┬─┬ノ( º _ ºノ)"
        case 울란바토르 = "울란바토르"
        case ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ = "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"
        case ﾉಥ益ಥﾉ = "(ﾉಥ益ಥ）ﾉ\u{feff} ┻━┻"
    }
}

// MARK: C convenience initializers and mutators

extension C {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(C.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        _1: String? = nil,
        a: String? = nil,
        aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String? = nil,
        abcDivStyleXExpressionX00JavascriptAlert1DEF: String? = nil,
        abcDivStyleXX00ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXX0CexpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF: String? = nil,
        abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF: String? = nil,
        ambitious: String? = nil,
        andU007FDEL: String? = nil,
        asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: String? = nil,
        bodyOnloadAlertXSS: String? = nil,
        braggadocious: String? = nil,
        c: String? = nil,
        c00: String? = nil,
        c000: String? = nil,
        c100: String? = nil,
        c100000: String? = nil,
        c100000000: String? = nil,
        c1E02: String? = nil,
        cScriptAlert123Script: String? = nil,
        cTrue: String? = nil,
        clock: String? = nil,
        com2: String? = nil,
        com4: String? = nil,
        craigCockburnSoftwareSpecialist: String? = nil,
        cunning: String? = nil,
        dccSendStartkeylogger000: String? = nil,
        dontMakeAMap: Bool? = nil,
        emoji: String? = nil,
        empty: String? = nil,
        evaluate: String? = nil,
        fluffy: String? = nil,
        fluffy00: String? = nil,
        fooValBar: String? = nil,
        frisky: String? = nil,
        hasOwnProperty: String? = nil,
        hilarious: String? = nil,
        hornimanMuseum: String? = nil,
        httpWWWCumQcCA: String? = nil,
        iOnwheelAlert1ScrollOverMeI: String? = nil,
        imgABCSrcDXEOnerrorFAlert1: String? = nil,
        imgOnmouseoverAlertXxs: String? = nil,
        imgSCRIPTAlertXSSSCRIPT: String? = nil,
        imgSRCJavascriptAlertStringFromCharCode888383: String? = nil,
        imgSRCJavascriptAlertXSS: String? = nil,
        imgSrcOnerrorAltJavascriptAlert1: String? = nil,
        imgSrcX10XOnerrorJavascriptAlert1: String? = nil,
        imgSrcX12XOnerrorJavascriptAlert1: String? = nil,
        imgSrcX13XOnerrorJavascriptAlert1: String? = nil,
        imgSrcX32XOnerrorJavascriptAlert1: String? = nil,
        imgSrcX47XOnerrorJavascriptAlert1: String? = nil,
        imgSrcXOnerrorAlert123: String? = nil,
        imgSrcXOnerrorX10JavascriptAlert1: String? = nil,
        imgSrcXOnerrorX32JavascriptAlert1: String? = nil,
        imgSrcXScriptJavascriptAlert1Script: String? = nil,
        imgSrcXxxXX09OnerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX20OnerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX22OnerrorJavascriptAlert1: String? = nil,
        imgSrcXxxXX27OnerrorJavascriptAlert1: String? = nil,
        imgX11SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX34SrcXOnerrorJavascriptAlert1: String? = nil,
        imgX47SrcXOnerrorJavascriptAlert1: String? = nil,
        indecent: String? = nil,
        indigo: String? = nil,
        infinity: String? = nil,
        javaSCriptAlert123: String? = nil,
        lpt1: String? = nil,
        ltScriptGtAlert3912339LtScriptGt: String? = nil,
        magenta: String? = nil,
        magnaCumLaude: String? = nil,
        medievalErectionOfParapets: String? = nil,
        mischievous: String? = nil,
        mocha: String? = nil,
        naN: String? = nil,
        nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: String? = nil,
        null: String? = nil,
        onfocusJaVaSCriptAlert123Autofocus: String? = nil,
        orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: String? = nil,
        plaintext: String? = nil,
        powerللصبللصبررH冗: String? = nil,
        purple: String? = nil,
        purple00: String? = nil,
        purple100000: String? = nil,
        purple100000000: String? = nil,
        purpleScriptAlert123Script: String? = nil,
        rightToLeftStrings: String? = nil,
        rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: String? = nil,
        s: String? = nil,
        scriptAlert123Script: String? = nil,
        scriptAlert123ScriptX: String? = nil,
        scriptJavascriptAlert1Script: String? = nil,
        scriptScriptAlert123Script: String? = nil,
        scriptSrcJscriptSScript: String? = nil,
        scriptX0AjavascriptAlert1Script: String? = nil,
        scriptX0BjavascriptAlert1Script: String? = nil,
        scriptX0CtypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX20JavascriptAlert1Script: String? = nil,
        scriptX2BjavascriptAlert1Script: String? = nil,
        scriptX2FtypeTextJavascriptJavascriptAlert1Script: String? = nil,
        scriptX7EjavascriptAlert1Script: String? = nil,
        scriptXE2X80X80JavascriptAlert1Script: String? = nil,
        scriptXE2X80X82JavascriptAlert1Script: String? = nil,
        scriptXE2X80X83JavascriptAlert1Script: String? = nil,
        scriptXE2X80X84JavascriptAlert1Script: String? = nil,
        scriptXE2X80X88JavascriptAlert1Script: String? = nil,
        scriptXE2X80X8BjavascriptAlert1Script: String? = nil,
        scriptXEFXBFXAEjavascriptAlert1Script: String? = nil,
        scriptXEFXBFXBEjavascriptAlert1Script: String? = nil,
        scunthorpeGeneralHospital: String? = nil,
        serverCodeInjection: String? = nil,
        shitakeMushrooms: String? = nil,
        specialCharacters: String? = nil,
        srcJaVaSCriptPrompt132: String? = nil,
        sticky: String? = nil,
        stringsWhichCanBeInterpretedAsNumeric: String? = nil,
        stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized: String? = nil,
        stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: String? = nil,
        stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153: String? = nil,
        stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet: String? = nil,
        stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM: String? = nil,
        stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF: String? = nil,
        stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: String? = nil,
        svgScript1231Alert123Script: String? = nil,
        systemLsAl: String? = nil,
        systemTouchTmpBlnsFail: String? = nil,
        tentacled: String? = nil,
        test: String? = nil,
        testTest: String? = nil,
        the0: String? = nil,
        the00: String? = nil,
        the000: String? = nil,
        the0123456789: String? = nil,
        the0TouchTmpBlnsShellshock1Fail: String? = nil,
        the0Xabad1Dea: String? = nil,
        the0Xffffffff: String? = nil,
        the1: String? = nil,
        the100: String? = nil,
        the100000: String? = nil,
        the100000000: String? = nil,
        the12: String? = nil,
        the1E02: String? = nil,
        the1E2: String? = nil,
        the1Ind: String? = nil,
        the2: String? = nil,
        the3: String? = nil,
        the4: String? = nil,
        the92233720368547758081: String? = nil,
        the١٢٣: String? = nil,
        titleOnpropertychangeJavascriptAlert1TitleTitleTitle: String? = nil,
        treatedAsWhitespaceInSomeContexts: String? = nil,
        trickUnicode: String? = nil,
        undefined: String? = nil,
        unicodeAdditionalControlCharactersAllOfTheCharactersWith: String? = nil,
        unicodeSubscriptSuperscriptAccents: String? = nil,
        unicodeUpsidedown: String? = nil,
        user: String? = nil,
        version: String? = nil,
        version800PlusU0009HTU000BVTU000CFFU0085NEL: String? = nil,
        whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: String? = nil,
        xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo: String? = nil,
        xxeInjectionXML: String? = nil,
        zalgoText: String? = nil,
        zz: String? = nil,
        åíîïÓôÒúæ: String? = nil,
        ω: String? = nil,
        ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя: String? = nil,
        בראשיתבראאלהיםאתהשמיםואתהארץ: String? = nil,
        مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية: String? = nil,
        ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO: String? = nil,
        ノº_ºノ: String? = nil,
        울란바토르: String? = nil,
        ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ: String? = nil,
        ﾉಥ益ಥﾉ: String? = nil
    ) -> C {
        return C(
            _1: _1 ?? self._1,
            a: a ?? self.a,
            aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA,
            aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA ?? self.aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA,
            abcDivStyleXExpressionX00JavascriptAlert1DEF: abcDivStyleXExpressionX00JavascriptAlert1DEF ?? self.abcDivStyleXExpressionX00JavascriptAlert1DEF,
            abcDivStyleXX00ExpressionJavascriptAlert1DEF: abcDivStyleXX00ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXX00ExpressionJavascriptAlert1DEF,
            abcDivStyleXX0CexpressionJavascriptAlert1DEF: abcDivStyleXX0CexpressionJavascriptAlert1DEF ?? self.abcDivStyleXX0CexpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF: abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF,
            abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF: abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF ?? self.abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF,
            abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF: abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF ?? self.abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF,
            ambitious: ambitious ?? self.ambitious,
            andU007FDEL: andU007FDEL ?? self.andU007FDEL,
            asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome ?? self.asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome,
            bodyOnloadAlertXSS: bodyOnloadAlertXSS ?? self.bodyOnloadAlertXSS,
            braggadocious: braggadocious ?? self.braggadocious,
            c: c ?? self.c,
            c00: c00 ?? self.c00,
            c000: c000 ?? self.c000,
            c100: c100 ?? self.c100,
            c100000: c100000 ?? self.c100000,
            c100000000: c100000000 ?? self.c100000000,
            c1E02: c1E02 ?? self.c1E02,
            cScriptAlert123Script: cScriptAlert123Script ?? self.cScriptAlert123Script,
            cTrue: cTrue ?? self.cTrue,
            clock: clock ?? self.clock,
            com2: com2 ?? self.com2,
            com4: com4 ?? self.com4,
            craigCockburnSoftwareSpecialist: craigCockburnSoftwareSpecialist ?? self.craigCockburnSoftwareSpecialist,
            cunning: cunning ?? self.cunning,
            dccSendStartkeylogger000: dccSendStartkeylogger000 ?? self.dccSendStartkeylogger000,
            dontMakeAMap: dontMakeAMap ?? self.dontMakeAMap,
            emoji: emoji ?? self.emoji,
            empty: empty ?? self.empty,
            evaluate: evaluate ?? self.evaluate,
            fluffy: fluffy ?? self.fluffy,
            fluffy00: fluffy00 ?? self.fluffy00,
            fooValBar: fooValBar ?? self.fooValBar,
            frisky: frisky ?? self.frisky,
            hasOwnProperty: hasOwnProperty ?? self.hasOwnProperty,
            hilarious: hilarious ?? self.hilarious,
            hornimanMuseum: hornimanMuseum ?? self.hornimanMuseum,
            httpWWWCumQcCA: httpWWWCumQcCA ?? self.httpWWWCumQcCA,
            iOnwheelAlert1ScrollOverMeI: iOnwheelAlert1ScrollOverMeI ?? self.iOnwheelAlert1ScrollOverMeI,
            imgABCSrcDXEOnerrorFAlert1: imgABCSrcDXEOnerrorFAlert1 ?? self.imgABCSrcDXEOnerrorFAlert1,
            imgOnmouseoverAlertXxs: imgOnmouseoverAlertXxs ?? self.imgOnmouseoverAlertXxs,
            imgSCRIPTAlertXSSSCRIPT: imgSCRIPTAlertXSSSCRIPT ?? self.imgSCRIPTAlertXSSSCRIPT,
            imgSRCJavascriptAlertStringFromCharCode888383: imgSRCJavascriptAlertStringFromCharCode888383 ?? self.imgSRCJavascriptAlertStringFromCharCode888383,
            imgSRCJavascriptAlertXSS: imgSRCJavascriptAlertXSS ?? self.imgSRCJavascriptAlertXSS,
            imgSrcOnerrorAltJavascriptAlert1: imgSrcOnerrorAltJavascriptAlert1 ?? self.imgSrcOnerrorAltJavascriptAlert1,
            imgSrcX10XOnerrorJavascriptAlert1: imgSrcX10XOnerrorJavascriptAlert1 ?? self.imgSrcX10XOnerrorJavascriptAlert1,
            imgSrcX12XOnerrorJavascriptAlert1: imgSrcX12XOnerrorJavascriptAlert1 ?? self.imgSrcX12XOnerrorJavascriptAlert1,
            imgSrcX13XOnerrorJavascriptAlert1: imgSrcX13XOnerrorJavascriptAlert1 ?? self.imgSrcX13XOnerrorJavascriptAlert1,
            imgSrcX32XOnerrorJavascriptAlert1: imgSrcX32XOnerrorJavascriptAlert1 ?? self.imgSrcX32XOnerrorJavascriptAlert1,
            imgSrcX47XOnerrorJavascriptAlert1: imgSrcX47XOnerrorJavascriptAlert1 ?? self.imgSrcX47XOnerrorJavascriptAlert1,
            imgSrcXOnerrorAlert123: imgSrcXOnerrorAlert123 ?? self.imgSrcXOnerrorAlert123,
            imgSrcXOnerrorX10JavascriptAlert1: imgSrcXOnerrorX10JavascriptAlert1 ?? self.imgSrcXOnerrorX10JavascriptAlert1,
            imgSrcXOnerrorX32JavascriptAlert1: imgSrcXOnerrorX32JavascriptAlert1 ?? self.imgSrcXOnerrorX32JavascriptAlert1,
            imgSrcXScriptJavascriptAlert1Script: imgSrcXScriptJavascriptAlert1Script ?? self.imgSrcXScriptJavascriptAlert1Script,
            imgSrcXxxXX09OnerrorJavascriptAlert1: imgSrcXxxXX09OnerrorJavascriptAlert1 ?? self.imgSrcXxxXX09OnerrorJavascriptAlert1,
            imgSrcXxxXX20OnerrorJavascriptAlert1: imgSrcXxxXX20OnerrorJavascriptAlert1 ?? self.imgSrcXxxXX20OnerrorJavascriptAlert1,
            imgSrcXxxXX22OnerrorJavascriptAlert1: imgSrcXxxXX22OnerrorJavascriptAlert1 ?? self.imgSrcXxxXX22OnerrorJavascriptAlert1,
            imgSrcXxxXX27OnerrorJavascriptAlert1: imgSrcXxxXX27OnerrorJavascriptAlert1 ?? self.imgSrcXxxXX27OnerrorJavascriptAlert1,
            imgX11SrcXOnerrorJavascriptAlert1: imgX11SrcXOnerrorJavascriptAlert1 ?? self.imgX11SrcXOnerrorJavascriptAlert1,
            imgX34SrcXOnerrorJavascriptAlert1: imgX34SrcXOnerrorJavascriptAlert1 ?? self.imgX34SrcXOnerrorJavascriptAlert1,
            imgX47SrcXOnerrorJavascriptAlert1: imgX47SrcXOnerrorJavascriptAlert1 ?? self.imgX47SrcXOnerrorJavascriptAlert1,
            indecent: indecent ?? self.indecent,
            indigo: indigo ?? self.indigo,
            infinity: infinity ?? self.infinity,
            javaSCriptAlert123: javaSCriptAlert123 ?? self.javaSCriptAlert123,
            lpt1: lpt1 ?? self.lpt1,
            ltScriptGtAlert3912339LtScriptGt: ltScriptGtAlert3912339LtScriptGt ?? self.ltScriptGtAlert3912339LtScriptGt,
            magenta: magenta ?? self.magenta,
            magnaCumLaude: magnaCumLaude ?? self.magnaCumLaude,
            medievalErectionOfParapets: medievalErectionOfParapets ?? self.medievalErectionOfParapets,
            mischievous: mischievous ?? self.mischievous,
            mocha: mocha ?? self.mocha,
            naN: naN ?? self.naN,
            nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F ?? self.nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F,
            null: null ?? self.null,
            onfocusJaVaSCriptAlert123Autofocus: onfocusJaVaSCriptAlert123Autofocus ?? self.onfocusJaVaSCriptAlert123Autofocus,
            orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever ?? self.orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever,
            plaintext: plaintext ?? self.plaintext,
            powerللصبللصبررH冗: powerللصبللصبررH冗 ?? self.powerللصبللصبررH冗,
            purple: purple ?? self.purple,
            purple00: purple00 ?? self.purple00,
            purple100000: purple100000 ?? self.purple100000,
            purple100000000: purple100000000 ?? self.purple100000000,
            purpleScriptAlert123Script: purpleScriptAlert123Script ?? self.purpleScriptAlert123Script,
            rightToLeftStrings: rightToLeftStrings ?? self.rightToLeftStrings,
            rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue ?? self.rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue,
            s: s ?? self.s,
            scriptAlert123Script: scriptAlert123Script ?? self.scriptAlert123Script,
            scriptAlert123ScriptX: scriptAlert123ScriptX ?? self.scriptAlert123ScriptX,
            scriptJavascriptAlert1Script: scriptJavascriptAlert1Script ?? self.scriptJavascriptAlert1Script,
            scriptScriptAlert123Script: scriptScriptAlert123Script ?? self.scriptScriptAlert123Script,
            scriptSrcJscriptSScript: scriptSrcJscriptSScript ?? self.scriptSrcJscriptSScript,
            scriptX0AjavascriptAlert1Script: scriptX0AjavascriptAlert1Script ?? self.scriptX0AjavascriptAlert1Script,
            scriptX0BjavascriptAlert1Script: scriptX0BjavascriptAlert1Script ?? self.scriptX0BjavascriptAlert1Script,
            scriptX0CtypeTextJavascriptJavascriptAlert1Script: scriptX0CtypeTextJavascriptJavascriptAlert1Script ?? self.scriptX0CtypeTextJavascriptJavascriptAlert1Script,
            scriptX20JavascriptAlert1Script: scriptX20JavascriptAlert1Script ?? self.scriptX20JavascriptAlert1Script,
            scriptX2BjavascriptAlert1Script: scriptX2BjavascriptAlert1Script ?? self.scriptX2BjavascriptAlert1Script,
            scriptX2FtypeTextJavascriptJavascriptAlert1Script: scriptX2FtypeTextJavascriptJavascriptAlert1Script ?? self.scriptX2FtypeTextJavascriptJavascriptAlert1Script,
            scriptX7EjavascriptAlert1Script: scriptX7EjavascriptAlert1Script ?? self.scriptX7EjavascriptAlert1Script,
            scriptXE2X80X80JavascriptAlert1Script: scriptXE2X80X80JavascriptAlert1Script ?? self.scriptXE2X80X80JavascriptAlert1Script,
            scriptXE2X80X82JavascriptAlert1Script: scriptXE2X80X82JavascriptAlert1Script ?? self.scriptXE2X80X82JavascriptAlert1Script,
            scriptXE2X80X83JavascriptAlert1Script: scriptXE2X80X83JavascriptAlert1Script ?? self.scriptXE2X80X83JavascriptAlert1Script,
            scriptXE2X80X84JavascriptAlert1Script: scriptXE2X80X84JavascriptAlert1Script ?? self.scriptXE2X80X84JavascriptAlert1Script,
            scriptXE2X80X88JavascriptAlert1Script: scriptXE2X80X88JavascriptAlert1Script ?? self.scriptXE2X80X88JavascriptAlert1Script,
            scriptXE2X80X8BjavascriptAlert1Script: scriptXE2X80X8BjavascriptAlert1Script ?? self.scriptXE2X80X8BjavascriptAlert1Script,
            scriptXEFXBFXAEjavascriptAlert1Script: scriptXEFXBFXAEjavascriptAlert1Script ?? self.scriptXEFXBFXAEjavascriptAlert1Script,
            scriptXEFXBFXBEjavascriptAlert1Script: scriptXEFXBFXBEjavascriptAlert1Script ?? self.scriptXEFXBFXBEjavascriptAlert1Script,
            scunthorpeGeneralHospital: scunthorpeGeneralHospital ?? self.scunthorpeGeneralHospital,
            serverCodeInjection: serverCodeInjection ?? self.serverCodeInjection,
            shitakeMushrooms: shitakeMushrooms ?? self.shitakeMushrooms,
            specialCharacters: specialCharacters ?? self.specialCharacters,
            srcJaVaSCriptPrompt132: srcJaVaSCriptPrompt132 ?? self.srcJaVaSCriptPrompt132,
            sticky: sticky ?? self.sticky,
            stringsWhichCanBeInterpretedAsNumeric: stringsWhichCanBeInterpretedAsNumeric ?? self.stringsWhichCanBeInterpretedAsNumeric,
            stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized: stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized ?? self.stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized,
            stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer ?? self.stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer,
            stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153: stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153 ?? self.stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153,
            stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet: stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet ?? self.stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet,
            stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM: stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM ?? self.stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM,
            stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF: stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF ?? self.stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF,
            stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile ?? self.stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile,
            svgScript1231Alert123Script: svgScript1231Alert123Script ?? self.svgScript1231Alert123Script,
            systemLsAl: systemLsAl ?? self.systemLsAl,
            systemTouchTmpBlnsFail: systemTouchTmpBlnsFail ?? self.systemTouchTmpBlnsFail,
            tentacled: tentacled ?? self.tentacled,
            test: test ?? self.test,
            testTest: testTest ?? self.testTest,
            the0: the0 ?? self.the0,
            the00: the00 ?? self.the00,
            the000: the000 ?? self.the000,
            the0123456789: the0123456789 ?? self.the0123456789,
            the0TouchTmpBlnsShellshock1Fail: the0TouchTmpBlnsShellshock1Fail ?? self.the0TouchTmpBlnsShellshock1Fail,
            the0Xabad1Dea: the0Xabad1Dea ?? self.the0Xabad1Dea,
            the0Xffffffff: the0Xffffffff ?? self.the0Xffffffff,
            the1: the1 ?? self.the1,
            the100: the100 ?? self.the100,
            the100000: the100000 ?? self.the100000,
            the100000000: the100000000 ?? self.the100000000,
            the12: the12 ?? self.the12,
            the1E02: the1E02 ?? self.the1E02,
            the1E2: the1E2 ?? self.the1E2,
            the1Ind: the1Ind ?? self.the1Ind,
            the2: the2 ?? self.the2,
            the3: the3 ?? self.the3,
            the4: the4 ?? self.the4,
            the92233720368547758081: the92233720368547758081 ?? self.the92233720368547758081,
            the١٢٣: the١٢٣ ?? self.the١٢٣,
            titleOnpropertychangeJavascriptAlert1TitleTitleTitle: titleOnpropertychangeJavascriptAlert1TitleTitleTitle ?? self.titleOnpropertychangeJavascriptAlert1TitleTitleTitle,
            treatedAsWhitespaceInSomeContexts: treatedAsWhitespaceInSomeContexts ?? self.treatedAsWhitespaceInSomeContexts,
            trickUnicode: trickUnicode ?? self.trickUnicode,
            undefined: undefined ?? self.undefined,
            unicodeAdditionalControlCharactersAllOfTheCharactersWith: unicodeAdditionalControlCharactersAllOfTheCharactersWith ?? self.unicodeAdditionalControlCharactersAllOfTheCharactersWith,
            unicodeSubscriptSuperscriptAccents: unicodeSubscriptSuperscriptAccents ?? self.unicodeSubscriptSuperscriptAccents,
            unicodeUpsidedown: unicodeUpsidedown ?? self.unicodeUpsidedown,
            user: user ?? self.user,
            version: version ?? self.version,
            version800PlusU0009HTU000BVTU000CFFU0085NEL: version800PlusU0009HTU000BVTU000CFFU0085NEL ?? self.version800PlusU0009HTU000BVTU000CFFU0085NEL,
            whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode ?? self.whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode,
            xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo: xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo ?? self.xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo,
            xxeInjectionXML: xxeInjectionXML ?? self.xxeInjectionXML,
            zalgoText: zalgoText ?? self.zalgoText,
            zz: zz ?? self.zz,
            åíîïÓôÒúæ: åíîïÓôÒúæ ?? self.åíîïÓôÒúæ,
            ω: ω ?? self.ω,
            ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя: ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя ?? self.ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя,
            בראשיתבראאלהיםאתהשמיםואתהארץ: בראשיתבראאלהיםאתהשמיםואתהארץ ?? self.בראשיתבראאלהיםאתהשמיםואתהארץ,
            مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية: مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية ?? self.مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية,
            ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO: ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO ?? self.ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO,
            ノº_ºノ: ノº_ºノ ?? self.ノº_ºノ,
            울란바토르: 울란바토르 ?? self.울란바토르,
            ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ: ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ ?? self.ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ,
            ﾉಥ益ಥﾉ: ﾉಥ益ಥﾉ ?? self.ﾉಥ益ಥﾉ
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
    })
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    encoder.dateEncodingStrategy = .formatted(formatter)
    return encoder
}
