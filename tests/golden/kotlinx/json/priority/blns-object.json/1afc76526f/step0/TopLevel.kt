// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val a: A,
    val b: B,
    val c: C
)

@Serializable
data class A (
    @SerialName("!@#\$%^&*()`~")
    val a: String,

    @SerialName("-0")
    val a0: String,

    @SerialName("0,00")
    val a000: String,

    @SerialName("0.0/0.0")
    val a0000: String,

    @SerialName("1")
    val a1: String,

    @SerialName("1'000'000.00")
    val a100000000: String,

    @SerialName("1E02")
    val a1E02: String,

    @SerialName("';alert(123);t='")
    val aAlert123T: String,

    @SerialName("False")
    val aFalse: String,

    @SerialName("<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>")
    val aHrefJava123456781112ScriptJavascriptAlert1XXXA: String,

    @SerialName("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("(null)")
    val aNull: String,

    @SerialName("TRUE")
    val aTRUE: String,

    @SerialName("\u202btest\u202b")
    val aTest: String,

    @SerialName("True")
    val aTrue: String,

    @SerialName("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF")
    val abcDivStyleXExpX00RessionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF")
    val abcDivStyleXExpX5CressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX09ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0BexpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX20ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX3AexpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF: String,

    @SerialName(";alert(123);")
    val alert123: String,

    @SerialName("\";alert(123);t=\"")
    val alert123T: String,

    @SerialName("\\\";alert('XSS');//")
    val alertXSS: String,

    @SerialName("<>?:\"{}|_+")
    val ambitious: String,

    @SerialName("# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often")
    val andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften: String,

    @SerialName("Arsenal canal")
    val arsenalCanal: String,

    @SerialName("\" autofocus onkeyup=\"javascript:alert(123)")
    val autofocusOnkeyupJavascriptAlert123: String,

    @SerialName("AUX")
    val aux: String,

    @SerialName("⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢")
    val braggadocious: String,

    @SerialName("#\tChanging length when lowercased")
    val changingLengthWhenLowercased: String,

    @SerialName("#\tCharacters which increase in length (2 to 3 bytes) when lowercased")
    val charactersWhichIncreaseInLength2To3BytesWhenLowercased: String,

    val classic: String,

    @SerialName("#\tCommand Injection (Ruby)")
    val commandInjectionRuby: String,

    @SerialName("\\")
    val cunning: String,

    @SerialName("%d")
    val d: String,

    @SerialName("Dick Van Dyke")
    val dickVanDyke: String,

    val dontMakeAMap: Boolean,

    @SerialName("Dr. Herman I. Libshitz")
    val drHermanILibshitz: String,

    @SerialName(" ")
    val empty: String,

    @SerialName("\$ENV{'HOME'}")
    val envHome: String,

    @SerialName("../../../../../../../../../../../etc/hosts")
    val etcHosts: String,

    @SerialName("../../../../../../../../../../../etc/passwd%00")
    val etcPasswd00: String,

    @SerialName("'\"'")
    val fluffy: String,

    @SerialName("{0}")
    val fluffy0: String,

    @SerialName("#       fonts, and have a number of special behaviors")
    val fontsAndHaveANumberOfSpecialBehaviors: String,

    @SerialName("<foo val=`bar' />")
    val fooValBar: String,

    @SerialName("\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f")
    val frisky: String,

    @SerialName("-.")
    val hilarious: String,

    @SerialName("\$HOME")
    val home: String,

    @SerialName("#\tHuman injection")
    val humanInjection: String,

    @SerialName("̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰")
    val iNVOkINGTHEFÈẸLINGOFCHÁOS: String,

    @SerialName("<!--[if<img src=x onerror=javascript:alert(1)//]> -->")
    val ifImgSrcXOnerrorJavascriptAlert1: String,

    @SerialName("<!--[if]><script>javascript:alert(1)</script -->")
    val ifScriptJavascriptAlert1Script: String,

    @SerialName("<IMG SRC=\"jav   ascript:alert('XSS');\">")
    val imgSRCJavAscriptAlertXSS: String,

    @SerialName("<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">")
    val imgSRCJavX0AAscriptAlertXSS: String,

    @SerialName("<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">")
    val imgSRCJavX0DAscriptAlertXSS: String,

    @SerialName("<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>")
    val imgSrc106971189711599114105112116589710810111411640398883833941: String,

    @SerialName("<img src\\x09=x onerror=\"javascript:alert(1)\">")
    val imgSrcX09XOnerrorJavascriptAlert1: String,

    @SerialName("<img src\\x11=x onerror=\"javascript:alert(1)\">")
    val imgSrcX11XOnerrorJavascriptAlert1: String,

    @SerialName("<img src=x onerror=\\x00\"javascript:alert(1)\">")
    val imgSrcXOnerrorX00JavascriptAlert1: String,

    @SerialName("<img src=x onerror=\\x09\"javascript:alert(1)\">")
    val imgSrcXOnerrorX09JavascriptAlert1: String,

    @SerialName("<img src=x\\x09onerror=\"javascript:alert(1)\">")
    val imgSrcXX09OnerrorJavascriptAlert1: String,

    @SerialName("<img src=x\\x10onerror=\"javascript:alert(1)\">")
    val imgSrcXX10OnerrorJavascriptAlert1: String,

    @SerialName("<img src=x\\x11onerror=\"javascript:alert(1)\">")
    val imgSrcXX11OnerrorJavascriptAlert1: String,

    @SerialName("<img src=x\\x12onerror=\"javascript:alert(1)\">")
    val imgSrcXX12OnerrorJavascriptAlert1: String,

    @SerialName("<img src=x\\x13onerror=\"javascript:alert(1)\">")
    val imgSrcXX13OnerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>")
    val imgSrcXxxXX00OnerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>")
    val imgSrcXxxXX0BonerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>")
    val imgSrcXxxXX2FonerrorJavascriptAlert1: String,

    @SerialName("<img \\x00src=x onerror=\"alert(1)\">")
    val imgX00SrcXOnerrorAlert1: String,

    @SerialName("<img\\x10src=x onerror=\"javascript:alert(1)\">")
    val imgX10SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img\\x13src=x onerror=\"javascript:alert(1)\">")
    val imgX13SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img\\x32src=x onerror=\"javascript:alert(1)\">")
    val imgX32SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img \\x39src=x onerror=\"javascript:alert(1)\">")
    val imgX39SrcXOnerrorJavascriptAlert1: String,

    @SerialName("-,")
    val indecent: String,

    @SerialName(",./;'[]\\-=")
    val indigo: String,

    @SerialName("INF")
    val inf: String,

    @SerialName("-Infinity")
    val infinity: String,

    @SerialName("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)")
    val innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem: String,

    @SerialName("Jimmy Clitheroe")
    val jimmyClitheroe: String,

    @SerialName("Kernel.exit(1)")
    val kernelExit1: String,

    @SerialName("#\tKnown CVEs and Vulnerabilities")
    val knownCVEsAndVulnerabilities: String,

    @SerialName("Lightwater Country Park")
    val lightwaterCountryPark: String,

    @SerialName("LPT2")
    val lpt2: String,

    @SerialName("LPT3")
    val lpt3: String,

    @SerialName("`ls -al /`")
    val lsAl: String,

    @SerialName("\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f")
    val magenta: String,

    @SerialName("₀₁₂")
    val mischievous: String,

    @SerialName("#\tMSDOS/Windows Special Filenames")
    val msdosWindowsSpecialFilenames: String,

    val nil: String,

    @SerialName("# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.")
    val nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: String,

    @SerialName("None")
    val none: String,

    @SerialName(" onfocus=JaVaSCript:alert(123) autofocus")
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @SerialName("' OR '1'='1")
    val or11: String,

    @SerialName("Penistone Community Church")
    val penistoneCommunityChurch: String,

    @SerialName("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out")
    val perlEPrintIMGSRCJava0ScriptAlertXSSOut: String,

    @SerialName("PRN")
    val prn: String,

    @SerialName("'")
    val purple: String,

    @SerialName("0")
    val purple0: String,

    @SerialName("false")
    val purpleFalse: String,

    @SerialName("\u2066test\u2067")
    val purpleTest: String,

    @SerialName("RomansInSussex.co.uk")
    val romansInSussexCoUk: String,

    @SerialName("%s")
    val s: String,

    @SerialName("<<< %s(un='%s') = %u")
    val sUnSU: String,

    @SerialName("<sc<script>ript>alert(123)</sc</script>ript>")
    val scScriptRiptAlert123ScScriptRipt: String,

    @SerialName("\"><script>alert(123);</script x=\"")
    val scriptAlert123ScriptX: String,

    @SerialName("#\tScript Injection")
    val scriptInjection: String,

    @SerialName("<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >")
    val scriptSRCHTTPHaCkersOrgXSSJSB: String,

    @SerialName("<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>")
    val scriptSRCHTTPHaCkersOrgXSSJSSCRIPT: String,

    @SerialName("</script><script>alert(123)</script>")
    val scriptScriptAlert123Script: String,

    @SerialName("\"`'><script>\\x00javascript:alert(1)</script>")
    val scriptX00JavascriptAlert1Script: String,

    @SerialName("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX09TypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x0Cjavascript:alert(1)</script>")
    val scriptX0CjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x0Djavascript:alert(1)</script>")
    val scriptX0DjavascriptAlert1Script: String,

    @SerialName("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX20TypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX3EtypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xC2\\x85javascript:alert(1)</script>")
    val scriptXC2X85JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>")
    val scriptXC2XA0JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>")
    val scriptXE1X9AX80JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>")
    val scriptXE1XA0X8EjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>")
    val scriptXE2X80X81JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>")
    val scriptXE2X80X86JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>")
    val scriptXE2X80X89JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>")
    val scriptXE2X81X9FjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>")
    val scriptXEFXBBXBFjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>")
    val scriptXF0X90X96X9AjavascriptAlert1Script: String,

    @SerialName("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>")
    val scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT: String,

    @SerialName("#\tSQL Injection")
    val sqlInjection: String,

    @SerialName(",")
    val sticky: String,

    @SerialName("#\tString which can reveal system files when parsed by a badly configured XML parser")
    val stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser: String,

    @SerialName("#\tStrings that test for known vulnerabilities")
    val stringsThatTestForKnownVulnerabilities: String,

    @SerialName("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.")
    val stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: String,

    @SerialName("#\tStrings which can call system commands within Ruby/Rails applications")
    val stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: String,

    @SerialName("#\tStrings which consists of Japanese-style emoticons which are popular on the web")
    val stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: String,

    @SerialName("#\tStrings which contain bold/italic/etc. versions of normal characters")
    val stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: String,

    @SerialName("#\tStrings which contain common unicode symbols (e.g. smart quotes)")
    val stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: String,

    @SerialName("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always")
    val stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: String,

    @SerialName("#\tStrings which contain misplaced quotation marks; can cause encoding errors")
    val stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: String,

    @SerialName("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues")
    val stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: String,

    @SerialName("#\tStrings which crashed iMessage in various versions of iOS")
    val stringsWhichCrashedIMessageInVariousVersionsOfIOS: String,

    @SerialName("#\tStrings which may cause human to reinterpret worldview")
    val stringsWhichMayCauseHumanToReinterpretWorldview: String,

    @SerialName("Super Bowl XXX")
    val superBowlXXX: String,

    @SerialName("(╯°□°）╯︵ ┻━┻)")
    val tentacled: String,

    @SerialName("\u202a\u202atest\u202a")
    val test: String,

    @SerialName("</textarea><script>alert(123)</script>")
    val textareaScriptAlert123Script: String,

    @SerialName("+0")
    val the0: String,

    @SerialName("0..0")
    val the00: String,

    @SerialName("0,0,0")
    val the000: String,

    @SerialName("0,0/0,0")
    val the0000: String,

    @SerialName("00˙Ɩ\$-")
    val the00Ɩ: String,

    @SerialName("0x0")
    val the0X0: String,

    @SerialName("-1")
    val the1: String,

    @SerialName("1/0")
    val the10: String,

    @SerialName("1.00")
    val the100: String,

    @SerialName("1.0/0.0")
    val the1000: String,

    @SerialName("1'000,00")
    val the100000: String,

    @SerialName("1 000 000.00")
    val the100000000: String,

    @SerialName("﷽")
    val the11: String,

    @SerialName("1/2")
    val the12: String,

    @SerialName("123456789012345678901234567890123456789")
    val the123456789012345678901234567890123456789: String,

    @SerialName("\ufeff")
    val the13: String,

    @SerialName("ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ")
    val the14: String,

    @SerialName("\ufffe")
    val the15: String,

    @SerialName("1;DROP TABLE users")
    val the1DROPTABLEUsers: String,

    @SerialName("-1E02")
    val the1E02: String,

    @SerialName("1E2")
    val the1E2: String,

    @SerialName("1#QNAN")
    val the1Qnan: String,

    @SerialName("1#SNAN")
    val the1Snan: String,

    @SerialName("\ud835\udc7b\ud835\udc89\ud835\udc86 \ud835\udc92\ud835\udc96\ud835\udc8a\ud835\udc84\ud835\udc8c \ud835\udc83\ud835\udc93\ud835\udc90\ud835\udc98\ud835\udc8f \ud835\udc87\ud835\udc90\ud835\udc99 \ud835\udc8b\ud835\udc96\ud835\udc8e\ud835\udc91\ud835\udc94 \ud835\udc90\ud835\udc97\ud835\udc86\ud835\udc93 \ud835\udc95\ud835\udc89\ud835\udc86 \ud835\udc8d\ud835\udc82\ud835\udc9b\ud835\udc9a \ud835\udc85\ud835\udc90\ud835\udc88")
    val the2: String,

    @SerialName("\ud835\udce3\ud835\udcf1\ud835\udcee \ud835\udcfa\ud835\udcfe\ud835\udcf2\ud835\udcec\ud835\udcf4 \ud835\udceb\ud835\udcfb\ud835\udcf8\ud835\udd00\ud835\udcf7 \ud835\udcef\ud835\udcf8\ud835\udd01 \ud835\udcf3\ud835\udcfe\ud835\udcf6\ud835\udcf9\ud835\udcfc \ud835\udcf8\ud835\udcff\ud835\udcee\ud835\udcfb \ud835\udcfd\ud835\udcf1\ud835\udcee \ud835\udcf5\ud835\udcea\ud835\udd03\ud835\udd02 \ud835\udced\ud835\udcf8\ud835\udcf0")
    val the3: String,

    @SerialName("\ud835\udd7f\ud835\udd8d\ud835\udd8a \ud835\udd96\ud835\udd9a\ud835\udd8e\ud835\udd88\ud835\udd90 \ud835\udd87\ud835\udd97\ud835\udd94\ud835\udd9c\ud835\udd93 \ud835\udd8b\ud835\udd94\ud835\udd9d \ud835\udd8f\ud835\udd9a\ud835\udd92\ud835\udd95\ud835\udd98 \ud835\udd94\ud835\udd9b\ud835\udd8a\ud835\udd97 \ud835\udd99\ud835\udd8d\ud835\udd8a \ud835\udd91\ud835\udd86\ud835\udd9f\ud835\udd9e \ud835\udd89\ud835\udd94\ud835\udd8c")
    val the4: String,

    @SerialName("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8 \ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2\ud83c\uddf8")
    val the5: String,

    @SerialName("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6")
    val the6: String,

    @SerialName("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2")
    val the7: String,

    @SerialName("\ud83d\udc69\ud83c\udffd")
    val the8: String,

    @SerialName("\ud83d\udebe \ud83c\udd92 \ud83c\udd93 \ud83c\udd95 \ud83c\udd96 \ud83c\udd97 \ud83c\udd99 \ud83c\udfe7")
    val the9: String,

    @SerialName("999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
    val the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: String,

    @SerialName("# The next two lines may appear to be blank or mojibake in some viewers.")
    val theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: String,

    @SerialName("The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]")
    val theQuicKBrownFoXBeeeep: String,

    @SerialName("٠١٢٣٤٥٦٧٨٩")
    val the٠١٢٣٤٥٦٧٨٩: String,

    @SerialName("#\tTwo-Byte Characters")
    val twoByteCharacters: String,

    @SerialName("# U+0000, U+000A, or U+000D (NUL, LF, CR).")
    val u0000U000AOrU000DNULLFCR: String,

    @SerialName("<u oncopy=alert()> Copy me</u>")
    val uOncopyAlertCopyMeU: String,

    val undef: String,

    @SerialName("#\tUnicode font")
    val unicodeFont: String,

    @SerialName("#\tUnicode Numbers")
    val unicodeNumbers: String,

    @SerialName("#\tUnwanted Interpolation")
    val unwantedInterpolation: String,

    @SerialName("%x('ls -al /')")
    val xLsAl: String,

    @SerialName("Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮")
    val zḀḶGO: String,

    @SerialName("¡™£¢∞§¶•ªº–≠")
    val ªº: String,

    @SerialName("¸˛Ç◊ı˜Â¯˘¿")
    val çIÂ: String,

    @SerialName("Œ„´‰ˇÁ¨ˆØ∏”’")
    val œÁØ: String,

    @SerialName("œ∑´®†¥¨ˆøπ“‘")
    val œØπ: String,

    @SerialName("( ͡° ͜ʖ ͡°)")
    val ʖ: String,

    @SerialName("הָיְתָהtestالصفحات التّحول")
    val היתהTestالصفحاتالتحول: String,

    @SerialName("ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.")
    val ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: String,

    @SerialName("ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็")
    val ดดด: String,

    @SerialName("Ⱥ")
    val ⱥ: String,

    @SerialName("Ⱦ")
    val ⱦ: String,

    @SerialName("パーティーへ行かないか")
    val パティへ行かないか: String,

    val 和製漢語: String,
    val 田中さんにあげて下さい: String,

    @SerialName("`⁄€‹›ﬁﬂ‡°·‚—±")
    val ﬁﬂ: String,

    @SerialName("｀ｨ(´∀｀∩")
    val ｨ: String
)

@Serializable
data class B (
    @SerialName("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">")
    val aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: String,

    @SerialName("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF")
    val abcDivStyleXExpressionX5CJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0AexpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0DexpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF: String,

    @SerialName("# appear in input.")
    val appearInInput: String,

    @SerialName("+++ATH0")
    val ath0: String,

    @SerialName("' autofocus onkeyup='javascript:alert(123)")
    val autofocusOnkeyupJavascriptAlert123: String,

    @SerialName("\t\u000b\u000c \u0085             \u200b\u2028\u2029  　")
    val b: String,

    @SerialName("1'000.00")
    val b100000: String,

    @SerialName("FALSE")
    val bFALSE: String,

    @SerialName("<IMG SRC=# onmouseover=\"alert('xxs')\">")
    val bIMGSRCOnmouseoverAlertXxs: String,

    @SerialName("null")
    val bNull: String,

    @SerialName("--><script>alert(123)</script>")
    val bScriptAlert123Script: String,

    @SerialName("`touch /tmp/blns.fail`")
    val bTouchTmpBlnsFail: String,

    val basement: String,

    @SerialName("But now...\u001b[20Cfor my greatest trick...\u001b[8m")
    val butNow20CforMyGreatestTrick8M: String,

    @SerialName("# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.")
    val byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine: String,

    @SerialName("COM1")
    val com1: String,

    @SerialName("COM3")
    val com3: String,

    @SerialName("# Commonly misinterpreted as additional graphic characters.")
    val commonlyMisinterpretedAsAdditionalGraphicCharacters: String,

    @SerialName("CON")
    val con: String,

    @SerialName("# contexts.  Divided into three groups based on (US-layout) keyboard position.")
    val contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition: String,

    @SerialName("#\tCredit: https://twitter.com/jifa/status/625776454479970304")
    val creditHTTPSTwitterCOMJifaStatus625776454479970304: String,

    @SerialName("/dev/null; touch /tmp/blns.fail ; echo")
    val devNullTouchTmpBlnsFailEcho: String,

    val dontMakeAMap: Boolean,

    @SerialName("\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f")
    val empty: String,

    @SerialName("eval(\"puts 'hello world'\")")
    val evalPutsHelloWorld: String,

    val expression: String,

    @SerialName("File:///")
    val file: String,

    @SerialName("#\tFile Inclusion")
    val fileInclusion: String,

    @SerialName("#")
    val fluffy: String,

    @SerialName("<foo val=”bar“ />")
    val fooValBar: String,

    @SerialName("# general category Cf (in Unicode 8.0.0).")
    val generalCategoryCFInUnicode800: String,

    @SerialName("̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕")
    val hEWHOWAĮTSBEHINDTHEWALḼ: String,

    @SerialName("--help")
    val help: String,

    @SerialName("\ud83d\ude0d")
    val hilarious: String,

    @SerialName("http://a/%%30%30")
    val httpA3030: String,

    @SerialName("#\tiOS Vulnerabilities")
    val iOSVulnerabilities: String,

    @SerialName("If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.")
    val ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: String,

    @SerialName("<iframe src=http://ha.ckers.org/scriptlet.html <")
    val iframeSrcHTTPHaCkersOrgScriptletHTML: String,

    @SerialName("<IMG SRC=\" &#14;  javascript:alert('XSS');\">")
    val imgSRC14JavascriptAlertXSS: String,

    @SerialName("<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">")
    val imgSRCJavX09AscriptAlertXSS: String,

    @SerialName("<IMG SRC= onmouseover=\"alert('xxs')\">")
    val imgSRCOnmouseoverAlertXxs: String,

    @SerialName("<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>")
    val imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: String,

    @SerialName("<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>")
    val imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: String,

    @SerialName("<img src\\x00=x onerror=\"javascript:alert(1)\">")
    val imgSrcX00XOnerrorJavascriptAlert1: String,

    @SerialName("<img src=x onerror=\\x11\"javascript:alert(1)\">")
    val imgSrcXOnerrorX11JavascriptAlert1: String,

    @SerialName("<img src=x onerror=\\x12\"javascript:alert(1)\">")
    val imgSrcXOnerrorX12JavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>")
    val imgSrcXxxXX0AonerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>")
    val imgSrcXxxXX0ConerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>")
    val imgSrcXxxXX0DonerrorJavascriptAlert1: String,

    @SerialName("<img \\x00src=x onerror=\"javascript:alert(1)\">")
    val imgX00SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img \\x11src=x onerror=\"javascript:alert(1)\">")
    val imgX11SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img \\x12src=x onerror=\"javascript:alert(1)\">")
    val imgX12SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img \\x47src=x onerror=\"javascript:alert(1)\">")
    val imgX47SrcXOnerrorJavascriptAlert1: String,

    @SerialName("\ud835\udd4b\ud835\udd59\ud835\udd56 \ud835\udd62\ud835\udd66\ud835\udd5a\ud835\udd54\ud835\udd5c \ud835\udd53\ud835\udd63\ud835\udd60\ud835\udd68\ud835\udd5f \ud835\udd57\ud835\udd60\ud835\udd69 \ud835\udd5b\ud835\udd66\ud835\udd5e\ud835\udd61\ud835\udd64 \ud835\udd60\ud835\udd67\ud835\udd56\ud835\udd63 \ud835\udd65\ud835\udd59\ud835\udd56 \ud835\udd5d\ud835\udd52\ud835\udd6b\ud835\udd6a \ud835\udd55\ud835\udd60\ud835\udd58")
    val indecent: String,

    @SerialName("❤️ \ud83d\udc94 \ud83d\udc8c \ud83d\udc95 \ud83d\udc9e \ud83d\udc93 \ud83d\udc97 \ud83d\udc96 \ud83d\udc98 \ud83d\udc9d \ud83d\udc9f \ud83d\udc9c \ud83d\udc9b \ud83d\udc9a \ud83d\udc99")
    val indigo: String,

    @SerialName("#   IRC specific strings")
    val ircSpecificStrings: String,

    @SerialName("#\tJapanese Emoticons")
    val japaneseEmoticons: String,

    @SerialName("Kernel.exec(\"ls -al /\")")
    val kernelExecLsAl: String,

    @SerialName("Linda Callahan")
    val lindaCallahan: String,

    @SerialName("NIL")
    val nil: String,

    @SerialName("NUL")
    val nul: String,

    @SerialName("#\tNumeric Strings")
    val numericStrings: String,

    @SerialName("# Often forbidden to appear in various text-based file formats (e.g. XML),")
    val oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML: String,

    @SerialName("\" onfocus=JaVaSCript:alert(123) autofocus")
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @SerialName("' OR 1=1 -- 1")
    val or111: String,

    @SerialName("\"")
    val purple: String,

    @SerialName("<script>alert(123)</script>")
    val purpleScriptAlert123Script: String,

    @SerialName("#\tQuotation Marks")
    val quotationMarks: String,

    @SerialName("#       Regional Indicator Symbols")
    val regionalIndicatorSymbols: String,

    @SerialName("#       Regional Indicator Symbols can be displayed differently across")
    val regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: String,

    @SerialName("#\tReserved Strings")
    val reservedStrings: String,

    @SerialName("\"><script>alert(123)</script>")
    val scriptAlert123Script: String,

    @SerialName("><script>alert(123);</script x=")
    val scriptAlert123ScriptX: String,

    @SerialName("<<SCRIPT>alert(\"XSS\");//<</SCRIPT>")
    val scriptAlertXSSSCRIPT: String,

    @SerialName("<SCRIPT SRC=//ha.ckers.org/.j>")
    val scriptSRCHaCkersOrgJ: String,

    @SerialName("<script src=\"\\\\%(jscript)s\"></script>")
    val scriptSrcJscriptSScript: String,

    @SerialName("\"`'><script>\\x09javascript:alert(1)</script>")
    val scriptX09JavascriptAlert1Script: String,

    @SerialName("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0AtypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0DtypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x21javascript:alert(1)</script>")
    val scriptX21JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x3Bjavascript:alert(1)</script>")
    val scriptX3BjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>")
    val scriptXE2X80X85JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>")
    val scriptXE2X80X87JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>")
    val scriptXE2X80X8AjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>")
    val scriptXE2X80XA8JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>")
    val scriptXE2X80XA9JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>")
    val scriptXE2X80XAFjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>")
    val scriptXE3X80X80JavascriptAlert1Script: String,

    @SerialName("#\tScunthorpe Problem")
    val scunthorpeProblem: String,

    @SerialName("⁰⁴⁵₀₁₂")
    val sticky: String,

    @SerialName("#   Strings that may occur on IRC clients that make security products freak out")
    val stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut: String,

    @SerialName("#\tStrings which are reserved characters in MSDOS/Windows")
    val stringsWhichAreReservedCharactersInMSDOSWindows: String,

    @SerialName("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS")
    val stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS: String,

    @SerialName("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)")
    val stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew: String,

    @SerialName("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues")
    val stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: String,

    @SerialName("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric")
    val stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: String,

    @SerialName("#\tStrings which may be used elsewhere in code")
    val stringsWhichMayBeUsedElsewhereInCode: String,

    @SerialName("(｡◕ ∀ ◕｡)")
    val tentacled: String,

    @SerialName("#\tTerminal escape codes")
    val terminalEscapeCodes: String,

    @SerialName("0.00")
    val the000: String,

    @SerialName("01000")
    val the01000: String,

    @SerialName("08")
    val the08: String,

    @SerialName("09")
    val the09: String,

    @SerialName("0xffffffffffffffff")
    val the0Xffffffffffffffff: String,

    @SerialName("\$1.00")
    val the100: String,

    @SerialName("1,0/0,0")
    val the1000: String,

    @SerialName("1 000.00")
    val the100000: String,

    @SerialName("1 000 000,00")
    val the100000000: String,

    @SerialName("1'; DROP TABLE users-- 1")
    val the1DROPTABLEUsers1: String,

    @SerialName("1#IND")
    val the1Ind: String,

    @SerialName("1#INF")
    val the1Inf: String,

    @SerialName("-2147483648/-1")
    val the21474836481: String,

    @SerialName("2.2250738585072011e-308")
    val the22250738585072011E308: String,

    @SerialName("# The next line may appear to be blank, mojibake, or dingbats in some viewers.")
    val theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: String,

    @SerialName("# The next line may appear to be blank or mojibake in some viewers.")
    val theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: String,

    @SerialName("# The next line may be flagged for \"trailing whitespace\" in some viewers.")
    val theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: String,

    @SerialName("１２３")
    val the１２３: String,

    @SerialName("# This file unfortunately cannot express strings containing")
    val thisFileUnfortunatelyCannotExpressStringsContaining: String,

    @SerialName("\$(touch /tmp/blns.fail)")
    val touchTmpBlnsFail: String,

    @SerialName("() { _; } >_[\$(\$())] { touch /tmp/blns.shellshock2.fail; }")
    val touchTmpBlnsShellshock2Fail: String,

    @SerialName("Tyson Gay")
    val tysonGay: String,

    @SerialName("#\tUnicode Symbols")
    val unicodeSymbols: String,

    @SerialName("'`\"><\\x00script>javascript:alert(1)</script>")
    val x00ScriptJavascriptAlert1Script: String,

    @SerialName("'`\"><\\x3Cscript>javascript:alert(1)</script>")
    val x3CscriptJavascriptAlert1Script: String,

    @SerialName("åß∂ƒ©˙∆˚¬…æ")
    val åßƑÆ: String,

    @SerialName("˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥")
    val ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo: String,

    @SerialName("Ω≈ç√∫˜µ≤≥÷")
    val ωÇΜ: String,

    @SerialName("ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ")
    val ຈلຈﾉຈلຈﾉ: String,

    @SerialName("Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣")
    val ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS: String,

    val 社會科學院語學研究所: String,
    val 部落格: String,

    @SerialName("사회과학원 어학연구소")
    val 사회과학원어학연구소: String,

    @SerialName("찦차를 타고 온 펲시맨과 쑛다리 똠방각하")
    val 찦차를타고온펲시맨과쑛다리똠방각하: String,

    val ﷺ: String,

    @SerialName("__ﾛ(,_,*)")
    val ﾛ_: String
)

@Serializable
data class C (
    @SerialName("\ud841\udf0e\ud841\udf31\ud841\udf79\ud843\udc53\ud843\udc78\ud843\udc96\ud843\udccf")
    val _1: String,

    @SerialName("A:")
    val a: String,

    @SerialName("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @SerialName("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF")
    val abcDivStyleXExpressionX00JavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX00ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0CexpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF: String,

    @SerialName("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF: String,

    @SerialName("_")
    val ambitious: String,

    @SerialName("# and U+007F (DEL)")
    val andU007FDEL: String,

    @SerialName("# ASCII punctuation.  All of these characters may need to be escaped in some")
    val asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: String,

    @SerialName("<BODY onload!#\$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>")
    val bodyOnloadAlertXSS: String,

    @SerialName("\ud835\udc13\ud835\udc21\ud835\udc1e \ud835\udc2a\ud835\udc2e\ud835\udc22\ud835\udc1c\ud835\udc24 \ud835\udc1b\ud835\udc2b\ud835\udc28\ud835\udc30\ud835\udc27 \ud835\udc1f\ud835\udc28\ud835\udc31 \ud835\udc23\ud835\udc2e\ud835\udc26\ud835\udc29\ud835\udc2c \ud835\udc28\ud835\udc2f\ud835\udc1e\ud835\udc2b \ud835\udc2d\ud835\udc21\ud835\udc1e \ud835\udc25\ud835\udc1a\ud835\udc33\ud835\udc32 \ud835\udc1d\ud835\udc28\ud835\udc20")
    val braggadocious: String,

    @SerialName("\"'\"'\"''''\"")
    val c: String,

    @SerialName("-0.0")
    val c00: String,

    @SerialName("0.0/0")
    val c000: String,

    @SerialName("-1.00")
    val c100: String,

    @SerialName("1,000.00")
    val c100000: String,

    @SerialName("1,000,000.00")
    val c100000000: String,

    @SerialName("1E+02")
    val c1E02: String,

    @SerialName("NULL")
    val cNULL: String,

    @SerialName("><script>alert(123)</script>")
    val cScriptAlert123Script: String,

    @SerialName("true")
    val cTrue: String,

    @SerialName("CLOCK\$")
    val clock: String,

    @SerialName("COM2")
    val com2: String,

    @SerialName("COM4")
    val com4: String,

    @SerialName("Craig Cockburn, Software Specialist")
    val craigCockburnSoftwareSpecialist: String,

    @SerialName("⁰⁴⁵")
    val cunning: String,

    @SerialName("DCC SEND STARTKEYLOGGER 0 0 0")
    val dccSendStartkeylogger000: String,

    val dontMakeAMap: Boolean,

    @SerialName("#\tEmoji")
    val emoji: String,

    @SerialName("\"\"")
    val empty: String,

    val evaluate: String,

    @SerialName("%")
    val fluffy: String,

    @SerialName("0/0")
    val fluffy00: String,

    @SerialName("<foo val=“bar” />")
    val fooValBar: String,

    @SerialName("✋\ud83c\udfff \ud83d\udcaa\ud83c\udfff \ud83d\udc50\ud83c\udfff \ud83d\ude4c\ud83c\udfff \ud83d\udc4f\ud83c\udfff \ud83d\ude4f\ud83c\udfff")
    val frisky: String,

    val hasOwnProperty: String,

    @SerialName("\\\\")
    val hilarious: String,

    @SerialName("Horniman Museum")
    val hornimanMuseum: String,

    @SerialName("http://www.cum.qc.ca/")
    val httpWWWCumQcCA: String,

    @SerialName("<i onwheel=alert(1)> Scroll over me </i>")
    val iOnwheelAlert1ScrollOverMeI: String,

    @SerialName("<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">")
    val imgABCSrcDXEOnerrorFAlert1: String,

    @SerialName("<IMG onmouseover=\"alert('xxs')\">")
    val imgOnmouseoverAlertXxs: String,

    @SerialName("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">")
    val imgSCRIPTAlertXSSSCRIPT: String,

    @SerialName("<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>")
    val imgSRCJavascriptAlertStringFromCharCode888383: String,

    @SerialName("<IMG SRC=\"javascript:alert('XSS')\"")
    val imgSRCJavascriptAlertXSS: String,

    @SerialName("<img src onerror /\" '\"= alt=javascript:alert(1)//\">")
    val imgSrcOnerrorAltJavascriptAlert1: String,

    @SerialName("<img src\\x10=x onerror=\"javascript:alert(1)\">")
    val imgSrcX10XOnerrorJavascriptAlert1: String,

    @SerialName("<img src\\x12=x onerror=\"javascript:alert(1)\">")
    val imgSrcX12XOnerrorJavascriptAlert1: String,

    @SerialName("<img src\\x13=x onerror=\"javascript:alert(1)\">")
    val imgSrcX13XOnerrorJavascriptAlert1: String,

    @SerialName("<img src\\x32=x onerror=\"javascript:alert(1)\">")
    val imgSrcX32XOnerrorJavascriptAlert1: String,

    @SerialName("<img src\\x47=x onerror=\"javascript:alert(1)\">")
    val imgSrcX47XOnerrorJavascriptAlert1: String,

    @SerialName("<img src=x onerror=alert(123) />")
    val imgSrcXOnerrorAlert123: String,

    @SerialName("<img src=x onerror=\\x10\"javascript:alert(1)\">")
    val imgSrcXOnerrorX10JavascriptAlert1: String,

    @SerialName("<img src=x onerror=\\x32\"javascript:alert(1)\">")
    val imgSrcXOnerrorX32JavascriptAlert1: String,

    @SerialName("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>")
    val imgSrcXScriptJavascriptAlert1Script: String,

    @SerialName("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>")
    val imgSrcXxxXX09OnerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>")
    val imgSrcXxxXX20OnerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>")
    val imgSrcXxxXX22OnerrorJavascriptAlert1: String,

    @SerialName("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>")
    val imgSrcXxxXX27OnerrorJavascriptAlert1: String,

    @SerialName("<img\\x11src=x onerror=\"javascript:alert(1)\">")
    val imgX11SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img \\x34src=x onerror=\"javascript:alert(1)\">")
    val imgX34SrcXOnerrorJavascriptAlert1: String,

    @SerialName("<img\\x47src=x onerror=\"javascript:alert(1)\">")
    val imgX47SrcXOnerrorJavascriptAlert1: String,

    @SerialName(".")
    val indecent: String,

    @SerialName("--")
    val indigo: String,

    @SerialName("Infinity")
    val infinity: String,

    @SerialName("JavaSCript:alert(123)")
    val javaSCriptAlert123: String,

    @SerialName("LPT1")
    val lpt1: String,

    @SerialName("&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;")
    val ltScriptGtAlert3912339LtScriptGt: String,

    @SerialName("⅛⅜⅝⅞")
    val magenta: String,

    @SerialName("magna cum laude")
    val magnaCumLaude: String,

    @SerialName("medieval erection of parapets")
    val medievalErectionOfParapets: String,

    @SerialName("・(￣∀￣)・:*:")
    val mischievous: String,

    val mocha: String,

    @SerialName("NaN")
    val naN: String,

    @SerialName("# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,")
    val nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: String,

    @SerialName("' onfocus=JaVaSCript:alert(123) autofocus")
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @SerialName("# or reused for internal delimiters on the theory that they should never")
    val orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: String,

    @SerialName("<plaintext>")
    val plaintext: String,

    @SerialName("Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗")
    val powerللصبللصبررH冗: String,

    @SerialName("\"''''\"'\"")
    val purple: String,

    @SerialName("0,,0")
    val purple00: String,

    @SerialName("1.000,00")
    val purple100000: String,

    @SerialName("1.000.000,00")
    val purple100000000: String,

    @SerialName("＜script＞alert(123)＜/script＞")
    val purpleScriptAlert123Script: String,

    @SerialName("#\tRight-To-Left Strings")
    val rightToLeftStrings: String,

    @SerialName("Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue")
    val rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: String,

    @SerialName("%*.*s")
    val s: String,

    @SerialName("'><script>alert(123)</script>")
    val scriptAlert123Script: String,

    @SerialName("'><script>alert(123);</script x='")
    val scriptAlert123ScriptX: String,

    @SerialName("\"`'><script>-javascript:alert(1)</script>")
    val scriptJavascriptAlert1Script: String,

    @SerialName("< / script >< script >alert(123)< / script >")
    val scriptScriptAlert123Script: String,

    @SerialName("<script src=\"/\\%(jscript)s\"></script>")
    val scriptSrcJscriptSScript: String,

    @SerialName("\"`'><script>\\x0Ajavascript:alert(1)</script>")
    val scriptX0AjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x0Bjavascript:alert(1)</script>")
    val scriptX0BjavascriptAlert1Script: String,

    @SerialName("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0CtypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x20javascript:alert(1)</script>")
    val scriptX20JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x2Bjavascript:alert(1)</script>")
    val scriptX2BjavascriptAlert1Script: String,

    @SerialName("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX2FtypeTextJavascriptJavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\x7Ejavascript:alert(1)</script>")
    val scriptX7EjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>")
    val scriptXE2X80X80JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>")
    val scriptXE2X80X82JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>")
    val scriptXE2X80X83JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>")
    val scriptXE2X80X84JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>")
    val scriptXE2X80X88JavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>")
    val scriptXE2X80X8BjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>")
    val scriptXEFXBFXAEjavascriptAlert1Script: String,

    @SerialName("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>")
    val scriptXEFXBFXBEjavascriptAlert1Script: String,

    @SerialName("Scunthorpe General Hospital")
    val scunthorpeGeneralHospital: String,

    @SerialName("#\tServer Code Injection")
    val serverCodeInjection: String,

    @SerialName("shitake mushrooms")
    val shitakeMushrooms: String,

    @SerialName("#\tSpecial Characters")
    val specialCharacters: String,

    @SerialName("src=JaVaSCript:prompt(132)")
    val srcJaVaSCriptPrompt132: String,

    @SerialName("-")
    val sticky: String,

    @SerialName("#\tStrings which can be interpreted as numeric")
    val stringsWhichCanBeInterpretedAsNumeric: String,

    @SerialName("#\tStrings which can cause a SQL injection if inputs are not sanitized")
    val stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized: String,

    @SerialName("#\tStrings which can cause user to pull in files that should not be a part of a web server")
    val stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: String,

    @SerialName("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)")
    val stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153: String,

    @SerialName("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)")
    val stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet: String,

    @SerialName("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)")
    val stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM: String,

    @SerialName("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)")
    val stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF: String,

    @SerialName("#\tStrings which punish the fools who use cat/type on this file")
    val stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: String,

    @SerialName("<svg><script>123<1>alert(123)</script>")
    val svgScript1231Alert123Script: String,

    @SerialName("System(\"ls -al /\")")
    val systemLsAl: String,

    @SerialName("@{[system \"touch /tmp/blns.fail\"]}")
    val systemTouchTmpBlnsFail: String,

    @SerialName("''")
    val tentacled: String,

    @SerialName("\u2029test\u2029")
    val test: String,

    @SerialName("test\u2060test\u202b")
    val testTest: String,

    @SerialName("\ud83c\udff30\ud83c\udf08️")
    val the0: String,

    @SerialName("+0.0")
    val the00: String,

    @SerialName("0.0.0")
    val the000: String,

    @SerialName("0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \ud83d\udd1f")
    val the0123456789: String,

    @SerialName("() { 0; }; touch /tmp/blns.shellshock1.fail;")
    val the0TouchTmpBlnsShellshock1Fail: String,

    @SerialName("0xabad1dea")
    val the0Xabad1Dea: String,

    @SerialName("0xffffffff")
    val the0Xffffffff: String,

    @SerialName("--1")
    val the1: String,

    @SerialName("-\$1.00")
    val the100: String,

    @SerialName("1 000,00")
    val the100000: String,

    @SerialName("1'000'000,00")
    val the100000000: String,

    @SerialName("-1/2")
    val the12: String,

    @SerialName("-1E+02")
    val the1E02: String,

    @SerialName("-1E2")
    val the1E2: String,

    @SerialName("-1#IND")
    val the1Ind: String,

    @SerialName("\ud835\ude83\ud835\ude91\ud835\ude8e \ud835\ude9a\ud835\ude9e\ud835\ude92\ud835\ude8c\ud835\ude94 \ud835\ude8b\ud835\ude9b\ud835\ude98\ud835\udea0\ud835\ude97 \ud835\ude8f\ud835\ude98\ud835\udea1 \ud835\ude93\ud835\ude9e\ud835\ude96\ud835\ude99\ud835\ude9c \ud835\ude98\ud835\ude9f\ud835\ude8e\ud835\ude9b \ud835\ude9d\ud835\ude91\ud835\ude8e \ud835\ude95\ud835\ude8a\ud835\udea3\ud835\udea2 \ud835\ude8d\ud835\ude98\ud835\ude90")
    val the2: String,

    @SerialName("\ud83d\udc35 \ud83d\ude48 \ud83d\ude49 \ud83d\ude4a")
    val the3: String,

    @SerialName("\ud83d\udc7e \ud83d\ude47 \ud83d\udc81 \ud83d\ude45 \ud83d\ude46 \ud83d\ude4b \ud83d\ude4e \ud83d\ude4d")
    val the4: String,

    @SerialName("-9223372036854775808/-1")
    val the92233720368547758081: String,

    @SerialName("١٢٣")
    val the١٢٣: String,

    @SerialName("<title onpropertychange=javascript:alert(1)></title><title title=>")
    val titleOnpropertychangeJavascriptAlert1TitleTitleTitle: String,

    @SerialName("# treated as whitespace in some contexts.")
    val treatedAsWhitespaceInSomeContexts: String,

    @SerialName("#\tTrick Unicode")
    val trickUnicode: String,

    val undefined: String,

    @SerialName("# Unicode additional control characters: all of the characters with")
    val unicodeAdditionalControlCharactersAllOfTheCharactersWith: String,

    @SerialName("#\tUnicode Subscript/Superscript/Accents")
    val unicodeSubscriptSuperscriptAccents: String,

    @SerialName("#\tUnicode Upsidedown")
    val unicodeUpsidedown: String,

    @SerialName("\$USER")
    val user: String,

    @SerialName("--version")
    val version: String,

    @SerialName("# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),")
    val version800PlusU0009HTU000BVTU000CFFU0085NEL: String,

    @SerialName("# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode")
    val whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: String,

    @SerialName("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>")
    val xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo: String,

    @SerialName("#      XXE Injection (XML)")
    val xxeInjectionXML: String,

    @SerialName("#\tZalgo Text")
    val zalgoText: String,

    @SerialName("ZZ:")
    val zz: String,

    @SerialName("ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃")
    val åíîïÓôÒúæ: String,

    @SerialName(",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’")
    val ω: String,

    @SerialName("ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя")
    val ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя: String,

    @SerialName("בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ")
    val בראשיתבראאלהיםאתהשמיםואתהארץ: String,

    @SerialName("مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ")
    val مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية: String,

    @SerialName("̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟")
    val ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO: String,

    @SerialName("┬─┬ノ( º _ ºノ)")
    val ノº_ºノ: String,

    val 울란바토르: String,

    @SerialName("Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ")
    val ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ: String,

    @SerialName("(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻")
    val ﾉಥ益ಥﾉ: String
)
