package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    val a : A,
    val b : B,
    val c : C
) derives OptionPickler.ReadWriter

case class A (
    @upickle.implicits.key("!@#$%^&*()`~")
    val a : String,
    val `-0` : String,
    val `0,00` : String,
    val `0.0/0.0` : String,
    val `-1` : String,
    val `1/0` : String,
    val `1'000'000.00` : String,
    val `1/2` : String,
    val `1E02` : String,
    val `';alert(123);t='` : String,
    val False : String,
    val `<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>` : String,
    @upickle.implicits.key("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    val `(null)` : String,
    val TRUE : String,
    @upickle.implicits.key("\u202btest\u202b")
    val aTest : String,
    val True : String,
    @upickle.implicits.key("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF")
    val abcDivStyleXExpX00RessionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF")
    val abcDivStyleXExpX5CressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX09ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0BexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX20ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX3AexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF : String,
    val `;alert(123);` : String,
    val `";alert(123);t="` : String,
    @upickle.implicits.key("\\\";alert('XSS');//")
    val alertXSS : String,
    val `<>?:"{}|_+` : String,
    val `# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often` : String,
    val `Arsenal canal` : String,
    val `" autofocus onkeyup="javascript:alert(123)` : String,
    val AUX : String,
    val `⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢` : String,
    @upickle.implicits.key("#\tChanging length when lowercased")
    val changingLengthWhenLowercased : String,
    @upickle.implicits.key("#\tCharacters which increase in length (2 to 3 bytes) when lowercased")
    val charactersWhichIncreaseInLength2To3BytesWhenLowercased : String,
    val classic : String,
    @upickle.implicits.key("#\tCommand Injection (Ruby)")
    val commandInjectionRuby : String,
    @upickle.implicits.key("\\")
    val cunning : String,
    val `%d` : String,
    val `Dick Van Dyke` : String,
    val dontMakeAMap : Boolean,
    val `Dr. Herman I. Libshitz` : String,
    val ` ` : String,
    val `$ENV{'HOME'}` : String,
    val `../../../../../../../../../../../etc/hosts` : String,
    val `../../../../../../../../../../../etc/passwd%00` : String,
    val `'"'` : String,
    val `{0}` : String,
    val `#       fonts, and have a number of special behaviors` : String,
    @upickle.implicits.key("<foo val=`bar' />")
    val fooValBar : String,
    @upickle.implicits.key("\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f")
    val frisky : String,
    val `-.` : String,
    val `$HOME` : String,
    @upickle.implicits.key("#\tHuman injection")
    val humanInjection : String,
    val `̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰` : String,
    val `<!--[if<img src=x onerror=javascript:alert(1)//]> -->` : String,
    val `<!--[if]><script>javascript:alert(1)</script -->` : String,
    val `<IMG SRC="jav   ascript:alert('XSS');">` : String,
    val `<IMG SRC="jav&#x0A;ascript:alert('XSS');">` : String,
    val `<IMG SRC="jav&#x0D;ascript:alert('XSS');">` : String,
    val `<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>` : String,
    @upickle.implicits.key("<img src\\x09=x onerror=\"javascript:alert(1)\">")
    val imgSrcX09XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src\\x11=x onerror=\"javascript:alert(1)\">")
    val imgSrcX11XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x onerror=\\x00\"javascript:alert(1)\">")
    val imgSrcXOnerrorX00JavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x onerror=\\x09\"javascript:alert(1)\">")
    val imgSrcXOnerrorX09JavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x\\x09onerror=\"javascript:alert(1)\">")
    val imgSrcXX09OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x\\x10onerror=\"javascript:alert(1)\">")
    val imgSrcXX10OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x\\x11onerror=\"javascript:alert(1)\">")
    val imgSrcXX11OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x\\x12onerror=\"javascript:alert(1)\">")
    val imgSrcXX12OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x\\x13onerror=\"javascript:alert(1)\">")
    val imgSrcXX13OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>")
    val imgSrcXxxXX00OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>")
    val imgSrcXxxXX0BonerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>")
    val imgSrcXxxXX2FonerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x00src=x onerror=\"alert(1)\">")
    val imgX00SrcXOnerrorAlert1 : String,
    @upickle.implicits.key("<img\\x10src=x onerror=\"javascript:alert(1)\">")
    val imgX10SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img\\x13src=x onerror=\"javascript:alert(1)\">")
    val imgX13SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img\\x32src=x onerror=\"javascript:alert(1)\">")
    val imgX32SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x39src=x onerror=\"javascript:alert(1)\">")
    val imgX39SrcXOnerrorJavascriptAlert1 : String,
    val `-,` : String,
    @upickle.implicits.key(",./;'[]\\-=")
    val indigo : String,
    val INF : String,
    val `-Infinity` : String,
    @upickle.implicits.key("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)")
    val innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem : String,
    val `Jimmy Clitheroe` : String,
    val `Kernel.exit(1)` : String,
    @upickle.implicits.key("#\tKnown CVEs and Vulnerabilities")
    val knownCVEsAndVulnerabilities : String,
    val `Lightwater Country Park` : String,
    val LPT2 : String,
    val LPT3 : String,
    @upickle.implicits.key("`ls -al /`")
    val lsAl : String,
    @upickle.implicits.key("\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f")
    val magenta : String,
    @upickle.implicits.key("₀₁₂")
    val mischievous : String,
    @upickle.implicits.key("#\tMSDOS/Windows Special Filenames")
    val msdosWindowsSpecialFilenames : String,
    val nil : String,
    val `# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.` : String,
    val None : String,
    val ` onfocus=JaVaSCript:alert(123) autofocus` : String,
    val `' OR '1'='1` : String,
    val `Penistone Community Church` : String,
    @upickle.implicits.key("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out")
    val perlEPrintIMGSRCJava0ScriptAlertXSSOut : String,
    val PRN : String,
    val `'` : String,
    val `0` : String,
    val `1` : String,
    val `false` : String,
    @upickle.implicits.key("\u2066test\u2067")
    val purpleTest : String,
    val `RomansInSussex.co.uk` : String,
    val `%s` : String,
    val `<<< %s(un='%s') = %u` : String,
    val `<sc<script>ript>alert(123)</sc</script>ript>` : String,
    val `"><script>alert(123);</script x="` : String,
    @upickle.implicits.key("#\tScript Injection")
    val scriptInjection : String,
    val `<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >` : String,
    val `<SCRIPT/SRC="http://ha.ckers.org/xss.js"></SCRIPT>` : String,
    val `</script><script>alert(123)</script>` : String,
    @upickle.implicits.key("\"`'><script>\\x00javascript:alert(1)</script>")
    val scriptX00JavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX09TypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x0Cjavascript:alert(1)</script>")
    val scriptX0CjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x0Djavascript:alert(1)</script>")
    val scriptX0DjavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX20TypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX3EtypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xC2\\x85javascript:alert(1)</script>")
    val scriptXC2X85JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>")
    val scriptXC2XA0JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>")
    val scriptXE1X9AX80JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>")
    val scriptXE1XA0X8EjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>")
    val scriptXE2X80X81JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>")
    val scriptXE2X80X86JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>")
    val scriptXE2X80X89JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>")
    val scriptXE2X81X9FjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>")
    val scriptXEFXBBXBFjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>")
    val scriptXF0X90X96X9AjavascriptAlert1Script : String,
    val `<SCRIPT/XSS SRC="http://ha.ckers.org/xss.js"></SCRIPT>` : String,
    @upickle.implicits.key("#\tSQL Injection")
    val sqlInjection : String,
    @upickle.implicits.key(",")
    val sticky : String,
    @upickle.implicits.key("#\tString which can reveal system files when parsed by a badly configured XML parser")
    val stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser : String,
    @upickle.implicits.key("#\tStrings that test for known vulnerabilities")
    val stringsThatTestForKnownVulnerabilities : String,
    @upickle.implicits.key("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.")
    val stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString : String,
    @upickle.implicits.key("#\tStrings which can call system commands within Ruby/Rails applications")
    val stringsWhichCanCallSystemCommandsWithinRubyRailsApplications : String,
    @upickle.implicits.key("#\tStrings which consists of Japanese-style emoticons which are popular on the web")
    val stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb : String,
    @upickle.implicits.key("#\tStrings which contain bold/italic/etc. versions of normal characters")
    val stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters : String,
    @upickle.implicits.key("#\tStrings which contain common unicode symbols (e.g. smart quotes)")
    val stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes : String,
    @upickle.implicits.key("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always")
    val stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways : String,
    @upickle.implicits.key("#\tStrings which contain misplaced quotation marks; can cause encoding errors")
    val stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors : String,
    @upickle.implicits.key("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues")
    val stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues : String,
    @upickle.implicits.key("#\tStrings which crashed iMessage in various versions of iOS")
    val stringsWhichCrashedIMessageInVariousVersionsOfIOS : String,
    @upickle.implicits.key("#\tStrings which may cause human to reinterpret worldview")
    val stringsWhichMayCauseHumanToReinterpretWorldview : String,
    val `Super Bowl XXX` : String,
    val `(╯°□°）╯︵ ┻━┻)` : String,
    @upickle.implicits.key("\u202a\u202atest\u202a")
    val test : String,
    val `</textarea><script>alert(123)</script>` : String,
    val `+0` : String,
    val `0..0` : String,
    val `0,0,0` : String,
    val `0,0/0,0` : String,
    val `00˙Ɩ$-` : String,
    val `0x0` : String,
    val `𝑻𝒉𝒆 𝒒𝒖𝒊𝒄𝒌 𝒃𝒓𝒐𝒘𝒏 𝒇𝒐𝒙 𝒋𝒖𝒎𝒑𝒔 𝒐𝒗𝒆𝒓 𝒕𝒉𝒆 𝒍𝒂𝒛𝒚 𝒅𝒐𝒈` : String,
    @upickle.implicits.key("\ufeff")
    val the10 : String,
    val `1.00` : String,
    val `1.0/0.0` : String,
    val `1'000,00` : String,
    val `1 000 000.00` : String,
    val `ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ` : String,
    @upickle.implicits.key("\ufffe")
    val the12 : String,
    val `123456789012345678901234567890123456789` : String,
    val `1;DROP TABLE users` : String,
    val `-1E02` : String,
    val `1E2` : String,
    val `1#QNAN` : String,
    val `1#SNAN` : String,
    val `𝓣𝓱𝓮 𝓺𝓾𝓲𝓬𝓴 𝓫𝓻𝓸𝔀𝓷 𝓯𝓸𝔁 𝓳𝓾𝓶𝓹𝓼 𝓸𝓿𝓮𝓻 𝓽𝓱𝓮 𝓵𝓪𝔃𝔂 𝓭𝓸𝓰` : String,
    val `𝕿𝖍𝖊 𝖖𝖚𝖎𝖈𝖐 𝖇𝖗𝖔𝖜𝖓 𝖋𝖔𝖝 𝖏𝖚𝖒𝖕𝖘 𝖔𝖛𝖊𝖗 𝖙𝖍𝖊 𝖑𝖆𝖟𝖞 𝖉𝖔𝖌` : String,
    val `🇺🇸🇷🇺🇸 🇦🇫🇦🇲🇸` : String,
    @upickle.implicits.key("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6")
    val the5 : String,
    @upickle.implicits.key("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2")
    val the6 : String,
    @upickle.implicits.key("\ud83d\udc69\ud83c\udffd")
    val the7 : String,
    val `🚾 🆒 🆓 🆕 🆖 🆗 🆙 🏧` : String,
    @upickle.implicits.key("﷽")
    val the9 : String,
    val `999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999` : String,
    val `# The next two lines may appear to be blank or mojibake in some viewers.` : String,
    @upickle.implicits.key("The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]")
    val theQuicKBrownFoXBeeeep : String,
    @upickle.implicits.key("٠١٢٣٤٥٦٧٨٩")
    val the٠١٢٣٤٥٦٧٨٩ : String,
    @upickle.implicits.key("#\tTwo-Byte Characters")
    val twoByteCharacters : String,
    val `# U+0000, U+000A, or U+000D (NUL, LF, CR).` : String,
    val `<u oncopy=alert()> Copy me</u>` : String,
    val undef : String,
    @upickle.implicits.key("#\tUnicode font")
    val unicodeFont : String,
    @upickle.implicits.key("#\tUnicode Numbers")
    val unicodeNumbers : String,
    @upickle.implicits.key("#\tUnwanted Interpolation")
    val unwantedInterpolation : String,
    val `%x('ls -al /')` : String,
    val Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮ : String,
    @upickle.implicits.key("¡™£¢∞§¶•ªº–≠")
    val ªº : String,
    @upickle.implicits.key("¸˛Ç◊ı˜Â¯˘¿")
    val çIÂ : String,
    @upickle.implicits.key("Œ„´‰ˇÁ¨ˆØ∏”’")
    val œÁØ : String,
    @upickle.implicits.key("œ∑´®†¥¨ˆøπ“‘")
    val œØπ : String,
    val `( ͡° ͜ʖ ͡°)` : String,
    val `הָיְתָהtestالصفحات التّحول` : String,
    val `ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.` : String,
    val `ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็` : String,
    val Ⱥ : String,
    val Ⱦ : String,
    val パーティーへ行かないか : String,
    val 和製漢語 : String,
    val 田中さんにあげて下さい : String,
    @upickle.implicits.key("`⁄€‹›ﬁﬂ‡°·‚—±")
    val ﬁﬂ : String,
    val `｀ｨ(´∀｀∩` : String
) derives OptionPickler.ReadWriter

case class B (
    @upickle.implicits.key("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">")
    val aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A : String,
    @upickle.implicits.key("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF")
    val abcDivStyleXExpressionX5CJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0AexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0DexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF : String,
    val `# appear in input.` : String,
    val `+++ATH0` : String,
    val `' autofocus onkeyup='javascript:alert(123)` : String,
    @upickle.implicits.key("\t\u000b\u000c \u0085             \u200b\u2028\u2029  　")
    val b : String,
    val `1'000.00` : String,
    val FALSE : String,
    val `<IMG SRC=# onmouseover="alert('xxs')">` : String,
    val `null` : String,
    val `--><script>alert(123)</script>` : String,
    @upickle.implicits.key("`touch /tmp/blns.fail`")
    val bTouchTmpBlnsFail : String,
    val basement : String,
    @upickle.implicits.key("But now...\u001b[20Cfor my greatest trick...\u001b[8m")
    val butNow20CforMyGreatestTrick8M : String,
    val `# "Byte order marks", U+FEFF and U+FFFE, each on its own line.` : String,
    val COM1 : String,
    val COM3 : String,
    val `# Commonly misinterpreted as additional graphic characters.` : String,
    val CON : String,
    val `# contexts.  Divided into three groups based on (US-layout) keyboard position.` : String,
    @upickle.implicits.key("#\tCredit: https://twitter.com/jifa/status/625776454479970304")
    val creditHTTPSTwitterCOMJifaStatus625776454479970304 : String,
    val `/dev/null; touch /tmp/blns.fail ; echo` : String,
    val dontMakeAMap : Boolean,
    @upickle.implicits.key("\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f")
    val empty : String,
    val `eval("puts 'hello world'")` : String,
    val expression : String,
    val `File:///` : String,
    @upickle.implicits.key("#\tFile Inclusion")
    val fileInclusion : String,
    val `#` : String,
    val `<foo val=”bar“ />` : String,
    val `# general category Cf (in Unicode 8.0.0).` : String,
    val `̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕` : String,
    val `--help` : String,
    @upickle.implicits.key("\ud83d\ude0d")
    val hilarious : String,
    val `http://a/%%30%30` : String,
    @upickle.implicits.key("#\tiOS Vulnerabilities")
    val iOSVulnerabilities : String,
    val `If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.` : String,
    val `<iframe src=http://ha.ckers.org/scriptlet.html <` : String,
    val `<IMG SRC=" &#14;  javascript:alert('XSS');">` : String,
    val `<IMG SRC="jav&#x09;ascript:alert('XSS');">` : String,
    val `<IMG SRC= onmouseover="alert('xxs')">` : String,
    val `<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>` : String,
    val `<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>` : String,
    @upickle.implicits.key("<img src\\x00=x onerror=\"javascript:alert(1)\">")
    val imgSrcX00XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x onerror=\\x11\"javascript:alert(1)\">")
    val imgSrcXOnerrorX11JavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x onerror=\\x12\"javascript:alert(1)\">")
    val imgSrcXOnerrorX12JavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>")
    val imgSrcXxxXX0AonerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>")
    val imgSrcXxxXX0ConerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>")
    val imgSrcXxxXX0DonerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x00src=x onerror=\"javascript:alert(1)\">")
    val imgX00SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x11src=x onerror=\"javascript:alert(1)\">")
    val imgX11SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x12src=x onerror=\"javascript:alert(1)\">")
    val imgX12SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x47src=x onerror=\"javascript:alert(1)\">")
    val imgX47SrcXOnerrorJavascriptAlert1 : String,
    val `𝕋𝕙𝕖 𝕢𝕦𝕚𝕔𝕜 𝕓𝕣𝕠𝕨𝕟 𝕗𝕠𝕩 𝕛𝕦𝕞𝕡𝕤 𝕠𝕧𝕖𝕣 𝕥𝕙𝕖 𝕝𝕒𝕫𝕪 𝕕𝕠𝕘` : String,
    val `❤️ 💔 💌 💕 💞 💓 💗 💖 💘 💝 💟 💜 💛 💚 💙` : String,
    val `#   IRC specific strings` : String,
    @upickle.implicits.key("#\tJapanese Emoticons")
    val japaneseEmoticons : String,
    val `Kernel.exec("ls -al /")` : String,
    val `Linda Callahan` : String,
    val NIL : String,
    val NUL : String,
    @upickle.implicits.key("#\tNumeric Strings")
    val numericStrings : String,
    val `# Often forbidden to appear in various text-based file formats (e.g. XML),` : String,
    val `" onfocus=JaVaSCript:alert(123) autofocus` : String,
    val `' OR 1=1 -- 1` : String,
    val `"` : String,
    val `<script>alert(123)</script>` : String,
    @upickle.implicits.key("#\tQuotation Marks")
    val quotationMarks : String,
    val `#       Regional Indicator Symbols` : String,
    val `#       Regional Indicator Symbols can be displayed differently across` : String,
    @upickle.implicits.key("#\tReserved Strings")
    val reservedStrings : String,
    val `"><script>alert(123)</script>` : String,
    val `><script>alert(123);</script x=` : String,
    val `<<SCRIPT>alert("XSS");//<</SCRIPT>` : String,
    val `<SCRIPT SRC=//ha.ckers.org/.j>` : String,
    @upickle.implicits.key("<script src=\"\\\\%(jscript)s\"></script>")
    val scriptSrcJscriptSScript : String,
    @upickle.implicits.key("\"`'><script>\\x09javascript:alert(1)</script>")
    val scriptX09JavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0AtypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0DtypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x21javascript:alert(1)</script>")
    val scriptX21JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x3Bjavascript:alert(1)</script>")
    val scriptX3BjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>")
    val scriptXE2X80X85JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>")
    val scriptXE2X80X87JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>")
    val scriptXE2X80X8AjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>")
    val scriptXE2X80XA8JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>")
    val scriptXE2X80XA9JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>")
    val scriptXE2X80XAFjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>")
    val scriptXE3X80X80JavascriptAlert1Script : String,
    @upickle.implicits.key("#\tScunthorpe Problem")
    val scunthorpeProblem : String,
    @upickle.implicits.key("⁰⁴⁵₀₁₂")
    val sticky : String,
    val `#   Strings that may occur on IRC clients that make security products freak out` : String,
    @upickle.implicits.key("#\tStrings which are reserved characters in MSDOS/Windows")
    val stringsWhichAreReservedCharactersInMSDOSWindows : String,
    @upickle.implicits.key("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS")
    val stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS : String,
    @upickle.implicits.key("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)")
    val stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew : String,
    @upickle.implicits.key("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues")
    val stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues : String,
    @upickle.implicits.key("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric")
    val stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric : String,
    @upickle.implicits.key("#\tStrings which may be used elsewhere in code")
    val stringsWhichMayBeUsedElsewhereInCode : String,
    val `(｡◕ ∀ ◕｡)` : String,
    @upickle.implicits.key("#\tTerminal escape codes")
    val terminalEscapeCodes : String,
    val `0.00` : String,
    val `01000` : String,
    val `08` : String,
    val `09` : String,
    val `0xffffffffffffffff` : String,
    val `$1.00` : String,
    val `1,0/0,0` : String,
    val `1 000.00` : String,
    val `1 000 000,00` : String,
    val `1'; DROP TABLE users-- 1` : String,
    val `1#IND` : String,
    val `1#INF` : String,
    val `-2147483648/-1` : String,
    val `2.2250738585072011e-308` : String,
    val `# The next line may appear to be blank, mojibake, or dingbats in some viewers.` : String,
    val `# The next line may appear to be blank or mojibake in some viewers.` : String,
    val `# The next line may be flagged for "trailing whitespace" in some viewers.` : String,
    @upickle.implicits.key("１２３")
    val the１２３ : String,
    val `# This file unfortunately cannot express strings containing` : String,
    val `$(touch /tmp/blns.fail)` : String,
    val `() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }` : String,
    val `Tyson Gay` : String,
    @upickle.implicits.key("#\tUnicode Symbols")
    val unicodeSymbols : String,
    @upickle.implicits.key("'`\"><\\x00script>javascript:alert(1)</script>")
    val x00ScriptJavascriptAlert1Script : String,
    @upickle.implicits.key("'`\"><\\x3Cscript>javascript:alert(1)</script>")
    val x3CscriptJavascriptAlert1Script : String,
    @upickle.implicits.key("åß∂ƒ©˙∆˚¬…æ")
    val åßƑÆ : String,
    val `˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥` : String,
    @upickle.implicits.key("Ω≈ç√∫˜µ≤≥÷")
    val ωÇΜ : String,
    val `ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ` : String,
    val `Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣` : String,
    val 社會科學院語學研究所 : String,
    val 部落格 : String,
    val `사회과학원 어학연구소` : String,
    val `찦차를 타고 온 펲시맨과 쑛다리 똠방각하` : String,
    val ﷺ : String,
    val `__ﾛ(,_,*)` : String
) derives OptionPickler.ReadWriter

case class C (
    val `A:` : String,
    @upickle.implicits.key("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")
    val aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA : String,
    @upickle.implicits.key("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF")
    val abcDivStyleXExpressionX00JavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF")
    val abcDivStyleXX00ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXX0CexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF")
    val abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF")
    val abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF : String,
    @upickle.implicits.key("_")
    val ambitious : String,
    val `# and U+007F (DEL)` : String,
    val `# ASCII punctuation.  All of these characters may need to be escaped in some` : String,
    @upickle.implicits.key("<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>")
    val bodyOnloadAlertXSS : String,
    val `𝐓𝐡𝐞 𝐪𝐮𝐢𝐜𝐤 𝐛𝐫𝐨𝐰𝐧 𝐟𝐨𝐱 𝐣𝐮𝐦𝐩𝐬 𝐨𝐯𝐞𝐫 𝐭𝐡𝐞 𝐥𝐚𝐳𝐲 𝐝𝐨𝐠` : String,
    val `"'"'"''''"` : String,
    val `-0.0` : String,
    val `0.0/0` : String,
    val `--1` : String,
    val `-1.00` : String,
    val `1,000.00` : String,
    val `1,000,000.00` : String,
    val `1E+02` : String,
    val NULL : String,
    val `><script>alert(123)</script>` : String,
    val `true` : String,
    val `CLOCK$` : String,
    val COM2 : String,
    val COM4 : String,
    val `Craig Cockburn, Software Specialist` : String,
    @upickle.implicits.key("⁰⁴⁵")
    val cunning : String,
    val `DCC SEND STARTKEYLOGGER 0 0 0` : String,
    val dontMakeAMap : Boolean,
    @upickle.implicits.key("#\tEmoji")
    val emoji : String,
    val `""` : String,
    val evaluate : String,
    val 𠜎𠜱𠝹𠱓𠱸𠲖𠳏 : String,
    val `%` : String,
    val `0/0` : String,
    val `<foo val=“bar” />` : String,
    val `✋🏿 💪🏿 👐🏿 🙌🏿 👏🏿 🙏🏿` : String,
    val hasOwnProperty : String,
    @upickle.implicits.key("\\\\")
    val hilarious : String,
    val `Horniman Museum` : String,
    val `http://www.cum.qc.ca/` : String,
    val `<i onwheel=alert(1)> Scroll over me </i>` : String,
    val `<img[a][b][c]src[d]=x[e]onerror=[f]"alert(1)">` : String,
    val `<IMG onmouseover="alert('xxs')">` : String,
    val `<IMG """><SCRIPT>alert("XSS")</SCRIPT>">` : String,
    val `<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>` : String,
    val `<IMG SRC="javascript:alert('XSS')"` : String,
    val `<img src onerror /" '"= alt=javascript:alert(1)//">` : String,
    @upickle.implicits.key("<img src\\x10=x onerror=\"javascript:alert(1)\">")
    val imgSrcX10XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src\\x12=x onerror=\"javascript:alert(1)\">")
    val imgSrcX12XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src\\x13=x onerror=\"javascript:alert(1)\">")
    val imgSrcX13XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src\\x32=x onerror=\"javascript:alert(1)\">")
    val imgSrcX32XOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img src\\x47=x onerror=\"javascript:alert(1)\">")
    val imgSrcX47XOnerrorJavascriptAlert1 : String,
    val `<img src=x onerror=alert(123) />` : String,
    @upickle.implicits.key("<img src=x onerror=\\x10\"javascript:alert(1)\">")
    val imgSrcXOnerrorX10JavascriptAlert1 : String,
    @upickle.implicits.key("<img src=x onerror=\\x32\"javascript:alert(1)\">")
    val imgSrcXOnerrorX32JavascriptAlert1 : String,
    @upickle.implicits.key("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>")
    val imgSrcXScriptJavascriptAlert1Script : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>")
    val imgSrcXxxXX09OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>")
    val imgSrcXxxXX20OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>")
    val imgSrcXxxXX22OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>")
    val imgSrcXxxXX27OnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img\\x11src=x onerror=\"javascript:alert(1)\">")
    val imgX11SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img \\x34src=x onerror=\"javascript:alert(1)\">")
    val imgX34SrcXOnerrorJavascriptAlert1 : String,
    @upickle.implicits.key("<img\\x47src=x onerror=\"javascript:alert(1)\">")
    val imgX47SrcXOnerrorJavascriptAlert1 : String,
    val `.` : String,
    val `--` : String,
    val `Infinity` : String,
    val `JavaSCript:alert(123)` : String,
    val LPT1 : String,
    val `&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;` : String,
    @upickle.implicits.key("⅛⅜⅝⅞")
    val magenta : String,
    val `magna cum laude` : String,
    val `medieval erection of parapets` : String,
    val `・(￣∀￣)・:*:` : String,
    val mocha : String,
    val NaN : String,
    val `# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,` : String,
    val `' onfocus=JaVaSCript:alert(123) autofocus` : String,
    val `# or reused for internal delimiters on the theory that they should never` : String,
    val `<plaintext>` : String,
    val `Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗` : String,
    val `"''''"'"` : String,
    val `0,,0` : String,
    val `1.000,00` : String,
    val `1.000.000,00` : String,
    val `＜script＞alert(123)＜/script＞` : String,
    @upickle.implicits.key("#\tRight-To-Left Strings")
    val rightToLeftStrings : String,
    @upickle.implicits.key("Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue")
    val rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue : String,
    val `%*.*s` : String,
    val `'><script>alert(123)</script>` : String,
    val `'><script>alert(123);</script x='` : String,
    @upickle.implicits.key("\"`'><script>-javascript:alert(1)</script>")
    val scriptJavascriptAlert1Script : String,
    val `< / script >< script >alert(123)< / script >` : String,
    @upickle.implicits.key("<script src=\"/\\%(jscript)s\"></script>")
    val scriptSrcJscriptSScript : String,
    @upickle.implicits.key("\"`'><script>\\x0Ajavascript:alert(1)</script>")
    val scriptX0AjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x0Bjavascript:alert(1)</script>")
    val scriptX0BjavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX0CtypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x20javascript:alert(1)</script>")
    val scriptX20JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x2Bjavascript:alert(1)</script>")
    val scriptX2BjavascriptAlert1Script : String,
    @upickle.implicits.key("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>")
    val scriptX2FtypeTextJavascriptJavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\x7Ejavascript:alert(1)</script>")
    val scriptX7EjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>")
    val scriptXE2X80X80JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>")
    val scriptXE2X80X82JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>")
    val scriptXE2X80X83JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>")
    val scriptXE2X80X84JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>")
    val scriptXE2X80X88JavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>")
    val scriptXE2X80X8BjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>")
    val scriptXEFXBFXAEjavascriptAlert1Script : String,
    @upickle.implicits.key("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>")
    val scriptXEFXBFXBEjavascriptAlert1Script : String,
    val `Scunthorpe General Hospital` : String,
    @upickle.implicits.key("#\tServer Code Injection")
    val serverCodeInjection : String,
    val `shitake mushrooms` : String,
    @upickle.implicits.key("#\tSpecial Characters")
    val specialCharacters : String,
    val `src=JaVaSCript:prompt(132)` : String,
    val `-` : String,
    @upickle.implicits.key("#\tStrings which can be interpreted as numeric")
    val stringsWhichCanBeInterpretedAsNumeric : String,
    @upickle.implicits.key("#\tStrings which can cause a SQL injection if inputs are not sanitized")
    val stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized : String,
    @upickle.implicits.key("#\tStrings which can cause user to pull in files that should not be a part of a web server")
    val stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer : String,
    @upickle.implicits.key("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)")
    val stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153 : String,
    @upickle.implicits.key("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)")
    val stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet : String,
    @upickle.implicits.key("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)")
    val stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM : String,
    @upickle.implicits.key("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)")
    val stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF : String,
    @upickle.implicits.key("#\tStrings which punish the fools who use cat/type on this file")
    val stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile : String,
    val `<svg><script>123<1>alert(123)</script>` : String,
    val `System("ls -al /")` : String,
    val `@{[system "touch /tmp/blns.fail"]}` : String,
    val `''` : String,
    @upickle.implicits.key("\u2029test\u2029")
    val test : String,
    @upickle.implicits.key("test\u2060test\u202b")
    val testTest : String,
    @upickle.implicits.key("\ud83c\udff30\ud83c\udf08️")
    val the0 : String,
    val `+0.0` : String,
    val `0.0.0` : String,
    val `0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ 🔟` : String,
    val `() { 0; }; touch /tmp/blns.shellshock1.fail;` : String,
    val `0xabad1dea` : String,
    val `0xffffffff` : String,
    val `𝚃𝚑𝚎 𝚚𝚞𝚒𝚌𝚔 𝚋𝚛𝚘𝚠𝚗 𝚏𝚘𝚡 𝚓𝚞𝚖𝚙𝚜 𝚘𝚟𝚎𝚛 𝚝𝚑𝚎 𝚕𝚊𝚣𝚢 𝚍𝚘𝚐` : String,
    val `-$1.00` : String,
    val `1 000,00` : String,
    val `1'000'000,00` : String,
    val `-1/2` : String,
    val `-1E+02` : String,
    val `-1E2` : String,
    val `-1#IND` : String,
    val `🐵 🙈 🙉 🙊` : String,
    val `👾 🙇 💁 🙅 🙆 🙋 🙎 🙍` : String,
    val `-9223372036854775808/-1` : String,
    @upickle.implicits.key("١٢٣")
    val the١٢٣ : String,
    val `<title onpropertychange=javascript:alert(1)></title><title title=>` : String,
    val `# treated as whitespace in some contexts.` : String,
    @upickle.implicits.key("#\tTrick Unicode")
    val trickUnicode : String,
    val undefined : String,
    val `# Unicode additional control characters: all of the characters with` : String,
    @upickle.implicits.key("#\tUnicode Subscript/Superscript/Accents")
    val unicodeSubscriptSuperscriptAccents : String,
    @upickle.implicits.key("#\tUnicode Upsidedown")
    val unicodeUpsidedown : String,
    val `$USER` : String,
    val `--version` : String,
    val `# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),` : String,
    val `# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode` : String,
    val `<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/passwd" >]><foo>&xxe;</foo>` : String,
    val `#      XXE Injection (XML)` : String,
    @upickle.implicits.key("#\tZalgo Text")
    val zalgoText : String,
    val `ZZ:` : String,
    @upickle.implicits.key("ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃")
    val åíîïÓôÒúæ : String,
    val `,。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’` : String,
    val ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя : String,
    val `בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ` : String,
    val `مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ` : String,
    val `̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟` : String,
    val `┬─┬ノ( º _ ºノ)` : String,
    val 울란바토르 : String,
    val `Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ` : String,
    val `(ﾉಥ益ಥ）ﾉ﻿ ┻━┻` : String
) derives OptionPickler.ReadWriter
