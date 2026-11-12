// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val a: A,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val b: B,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val c: C
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class A (
    @get:JsonProperty("!@#\$%^&*()`~", required=true)@field:JsonProperty("!@#\$%^&*()`~", required=true)
    val a: String,

    @get:JsonProperty("-0", required=true)@field:JsonProperty("-0", required=true)
    val a0: String,

    @get:JsonProperty("0,00", required=true)@field:JsonProperty("0,00", required=true)
    val a000: String,

    @get:JsonProperty("0.0/0.0", required=true)@field:JsonProperty("0.0/0.0", required=true)
    val a0000: String,

    @get:JsonProperty("1", required=true)@field:JsonProperty("1", required=true)
    val a1: String,

    @get:JsonProperty("1'000'000.00", required=true)@field:JsonProperty("1'000'000.00", required=true)
    val a100000000: String,

    @get:JsonProperty("1E02", required=true)@field:JsonProperty("1E02", required=true)
    val a1E02: String,

    @get:JsonProperty("';alert(123);t='", required=true)@field:JsonProperty("';alert(123);t='", required=true)
    val aAlert123T: String,

    @get:JsonProperty("False", required=true)@field:JsonProperty("False", required=true)
    val aFalse: String,

    @get:JsonProperty("<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>", required=true)@field:JsonProperty("<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>", required=true)
    val aHrefJava123456781112ScriptJavascriptAlert1XXXA: String,

    @get:JsonProperty("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefJavascriptX09JavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefJavascriptX0AJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefJavascriptX3AJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX01JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX05JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX08JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX09JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0CjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX10JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX11JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX13JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX17JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXC2XA0JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE1X9AX80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE1XA0X8EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X83JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X84JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X86JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X87JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80XA8JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("(null)", required=true)@field:JsonProperty("(null)", required=true)
    val aNull: String,

    @get:JsonProperty("TRUE", required=true)@field:JsonProperty("TRUE", required=true)
    val aTRUE: String,

    @get:JsonProperty("\u202btest\u202b", required=true)@field:JsonProperty("\u202btest\u202b", required=true)
    val aTest: String,

    @get:JsonProperty("True", required=true)@field:JsonProperty("True", required=true)
    val aTrue: String,

    @get:JsonProperty("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXExpX00RessionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXExpX5CressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX09ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX0BexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX20ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX3AexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXC2XA0ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X80ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X84ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X89ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X8BexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty(";alert(123);", required=true)@field:JsonProperty(";alert(123);", required=true)
    val alert123: String,

    @get:JsonProperty("\";alert(123);t=\"", required=true)@field:JsonProperty("\";alert(123);t=\"", required=true)
    val alert123T: String,

    @get:JsonProperty("\\\";alert('XSS');//", required=true)@field:JsonProperty("\\\";alert('XSS');//", required=true)
    val alertXSS: String,

    @get:JsonProperty("<>?:\"{}|_+", required=true)@field:JsonProperty("<>?:\"{}|_+", required=true)
    val ambitious: String,

    @get:JsonProperty("# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often", required=true)@field:JsonProperty("# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often", required=true)
    val andU200BZEROWIDTHSPACEWhichAreInTheCCategoriesButAreOften: String,

    @get:JsonProperty("Arsenal canal", required=true)@field:JsonProperty("Arsenal canal", required=true)
    val arsenalCanal: String,

    @get:JsonProperty("\" autofocus onkeyup=\"javascript:alert(123)", required=true)@field:JsonProperty("\" autofocus onkeyup=\"javascript:alert(123)", required=true)
    val autofocusOnkeyupJavascriptAlert123: String,

    @get:JsonProperty("AUX", required=true)@field:JsonProperty("AUX", required=true)
    val aux: String,

    @get:JsonProperty("⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢", required=true)@field:JsonProperty("⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢", required=true)
    val braggadocious: String,

    @get:JsonProperty("#\tChanging length when lowercased", required=true)@field:JsonProperty("#\tChanging length when lowercased", required=true)
    val changingLengthWhenLowercased: String,

    @get:JsonProperty("#\tCharacters which increase in length (2 to 3 bytes) when lowercased", required=true)@field:JsonProperty("#\tCharacters which increase in length (2 to 3 bytes) when lowercased", required=true)
    val charactersWhichIncreaseInLength2To3BytesWhenLowercased: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val classic: String,

    @get:JsonProperty("#\tCommand Injection (Ruby)", required=true)@field:JsonProperty("#\tCommand Injection (Ruby)", required=true)
    val commandInjectionRuby: String,

    @get:JsonProperty("\\", required=true)@field:JsonProperty("\\", required=true)
    val cunning: String,

    @get:JsonProperty("%d", required=true)@field:JsonProperty("%d", required=true)
    val d: String,

    @get:JsonProperty("Dick Van Dyke", required=true)@field:JsonProperty("Dick Van Dyke", required=true)
    val dickVanDyke: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dontMakeAMap: Boolean,

    @get:JsonProperty("Dr. Herman I. Libshitz", required=true)@field:JsonProperty("Dr. Herman I. Libshitz", required=true)
    val drHermanILibshitz: String,

    @get:JsonProperty(" ", required=true)@field:JsonProperty(" ", required=true)
    val empty: String,

    @get:JsonProperty("\$ENV{'HOME'}", required=true)@field:JsonProperty("\$ENV{'HOME'}", required=true)
    val envHome: String,

    @get:JsonProperty("../../../../../../../../../../../etc/hosts", required=true)@field:JsonProperty("../../../../../../../../../../../etc/hosts", required=true)
    val etcHosts: String,

    @get:JsonProperty("../../../../../../../../../../../etc/passwd%00", required=true)@field:JsonProperty("../../../../../../../../../../../etc/passwd%00", required=true)
    val etcPasswd00: String,

    @get:JsonProperty("'\"'", required=true)@field:JsonProperty("'\"'", required=true)
    val fluffy: String,

    @get:JsonProperty("{0}", required=true)@field:JsonProperty("{0}", required=true)
    val fluffy0: String,

    @get:JsonProperty("#       fonts, and have a number of special behaviors", required=true)@field:JsonProperty("#       fonts, and have a number of special behaviors", required=true)
    val fontsAndHaveANumberOfSpecialBehaviors: String,

    @get:JsonProperty("<foo val=`bar' />", required=true)@field:JsonProperty("<foo val=`bar' />", required=true)
    val fooValBar: String,

    @get:JsonProperty("\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f", required=true)@field:JsonProperty("\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\ud804\udcbd\ud82f\udca0\ud82f\udca1\ud82f\udca2\ud82f\udca3\ud834\udd73\ud834\udd74\ud834\udd75\ud834\udd76\ud834\udd77\ud834\udd78\ud834\udd79\ud834\udd7a\udb40\udc01\udb40\udc20\udb40\udc21\udb40\udc22\udb40\udc23\udb40\udc24\udb40\udc25\udb40\udc26\udb40\udc27\udb40\udc28\udb40\udc29\udb40\udc2a\udb40\udc2b\udb40\udc2c\udb40\udc2d\udb40\udc2e\udb40\udc2f\udb40\udc30\udb40\udc31\udb40\udc32\udb40\udc33\udb40\udc34\udb40\udc35\udb40\udc36\udb40\udc37\udb40\udc38\udb40\udc39\udb40\udc3a\udb40\udc3b\udb40\udc3c\udb40\udc3d\udb40\udc3e\udb40\udc3f\udb40\udc40\udb40\udc41\udb40\udc42\udb40\udc43\udb40\udc44\udb40\udc45\udb40\udc46\udb40\udc47\udb40\udc48\udb40\udc49\udb40\udc4a\udb40\udc4b\udb40\udc4c\udb40\udc4d\udb40\udc4e\udb40\udc4f\udb40\udc50\udb40\udc51\udb40\udc52\udb40\udc53\udb40\udc54\udb40\udc55\udb40\udc56\udb40\udc57\udb40\udc58\udb40\udc59\udb40\udc5a\udb40\udc5b\udb40\udc5c\udb40\udc5d\udb40\udc5e\udb40\udc5f\udb40\udc60\udb40\udc61\udb40\udc62\udb40\udc63\udb40\udc64\udb40\udc65\udb40\udc66\udb40\udc67\udb40\udc68\udb40\udc69\udb40\udc6a\udb40\udc6b\udb40\udc6c\udb40\udc6d\udb40\udc6e\udb40\udc6f\udb40\udc70\udb40\udc71\udb40\udc72\udb40\udc73\udb40\udc74\udb40\udc75\udb40\udc76\udb40\udc77\udb40\udc78\udb40\udc79\udb40\udc7a\udb40\udc7b\udb40\udc7c\udb40\udc7d\udb40\udc7e\udb40\udc7f", required=true)
    val frisky: String,

    @get:JsonProperty("-.", required=true)@field:JsonProperty("-.", required=true)
    val hilarious: String,

    @get:JsonProperty("\$HOME", required=true)@field:JsonProperty("\$HOME", required=true)
    val home: String,

    @get:JsonProperty("#\tHuman injection", required=true)@field:JsonProperty("#\tHuman injection", required=true)
    val humanInjection: String,

    @get:JsonProperty("̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰", required=true)@field:JsonProperty("̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰", required=true)
    val iNVOkINGTHEFÈẸLINGOFCHÁOS: String,

    @get:JsonProperty("<!--[if<img src=x onerror=javascript:alert(1)//]> -->", required=true)@field:JsonProperty("<!--[if<img src=x onerror=javascript:alert(1)//]> -->", required=true)
    val ifImgSrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<!--[if]><script>javascript:alert(1)</script -->", required=true)@field:JsonProperty("<!--[if]><script>javascript:alert(1)</script -->", required=true)
    val ifScriptJavascriptAlert1Script: String,

    @get:JsonProperty("<IMG SRC=\"jav   ascript:alert('XSS');\">", required=true)@field:JsonProperty("<IMG SRC=\"jav   ascript:alert('XSS');\">", required=true)
    val imgSRCJavAscriptAlertXSS: String,

    @get:JsonProperty("<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">", required=true)@field:JsonProperty("<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">", required=true)
    val imgSRCJavX0AAscriptAlertXSS: String,

    @get:JsonProperty("<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">", required=true)@field:JsonProperty("<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">", required=true)
    val imgSRCJavX0DAscriptAlertXSS: String,

    @get:JsonProperty("<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>", required=true)@field:JsonProperty("<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>", required=true)
    val imgSrc106971189711599114105112116589710810111411640398883833941: String,

    @get:JsonProperty("<img src\\x09=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x09=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX09XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x11=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x11=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX11XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=\\x00\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x00\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX00JavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=\\x09\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x09\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX09JavascriptAlert1: String,

    @get:JsonProperty("<img src=x\\x09onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x\\x09onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcXX09OnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x\\x10onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x\\x10onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcXX10OnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x\\x11onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x\\x11onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcXX11OnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x\\x12onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x\\x12onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcXX12OnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x\\x13onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x\\x13onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcXX13OnerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX00OnerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX0BonerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX2FonerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x00src=x onerror=\"alert(1)\">", required=true)@field:JsonProperty("<img \\x00src=x onerror=\"alert(1)\">", required=true)
    val imgX00SrcXOnerrorAlert1: String,

    @get:JsonProperty("<img\\x10src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img\\x10src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX10SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img\\x13src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img\\x13src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX13SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img\\x32src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img\\x32src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX32SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x39src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x39src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX39SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("-,", required=true)@field:JsonProperty("-,", required=true)
    val indecent: String,

    @get:JsonProperty(",./;'[]\\-=", required=true)@field:JsonProperty(",./;'[]\\-=", required=true)
    val indigo: String,

    @get:JsonProperty("INF", required=true)@field:JsonProperty("INF", required=true)
    val inf: String,

    @get:JsonProperty("-Infinity", required=true)@field:JsonProperty("-Infinity", required=true)
    val infinity: String,

    @get:JsonProperty("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)", required=true)@field:JsonProperty("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)", required=true)
    val innocuousStringsWhichMayBeBlockedByProfanityFiltersHTTPSEnWikipediaOrgWikiScunthorpeProblem: String,

    @get:JsonProperty("Jimmy Clitheroe", required=true)@field:JsonProperty("Jimmy Clitheroe", required=true)
    val jimmyClitheroe: String,

    @get:JsonProperty("Kernel.exit(1)", required=true)@field:JsonProperty("Kernel.exit(1)", required=true)
    val kernelExit1: String,

    @get:JsonProperty("#\tKnown CVEs and Vulnerabilities", required=true)@field:JsonProperty("#\tKnown CVEs and Vulnerabilities", required=true)
    val knownCVEsAndVulnerabilities: String,

    @get:JsonProperty("Lightwater Country Park", required=true)@field:JsonProperty("Lightwater Country Park", required=true)
    val lightwaterCountryPark: String,

    @get:JsonProperty("LPT2", required=true)@field:JsonProperty("LPT2", required=true)
    val lpt2: String,

    @get:JsonProperty("LPT3", required=true)@field:JsonProperty("LPT3", required=true)
    val lpt3: String,

    @get:JsonProperty("`ls -al /`", required=true)@field:JsonProperty("`ls -al /`", required=true)
    val lsAl: String,

    @get:JsonProperty("\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f", required=true)@field:JsonProperty("\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f", required=true)
    val magenta: String,

    @get:JsonProperty("₀₁₂", required=true)@field:JsonProperty("₀₁₂", required=true)
    val mischievous: String,

    @get:JsonProperty("#\tMSDOS/Windows Special Filenames", required=true)@field:JsonProperty("#\tMSDOS/Windows Special Filenames", required=true)
    val msdosWindowsSpecialFilenames: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nil: String,

    @get:JsonProperty("# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.", required=true)@field:JsonProperty("# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.", required=true)
    val nonWhitespaceC1ControlsU0080ThroughU0084AndU0086ThroughU009F: String,

    @get:JsonProperty("None", required=true)@field:JsonProperty("None", required=true)
    val none: String,

    @get:JsonProperty(" onfocus=JaVaSCript:alert(123) autofocus", required=true)@field:JsonProperty(" onfocus=JaVaSCript:alert(123) autofocus", required=true)
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @get:JsonProperty("' OR '1'='1", required=true)@field:JsonProperty("' OR '1'='1", required=true)
    val or11: String,

    @get:JsonProperty("Penistone Community Church", required=true)@field:JsonProperty("Penistone Community Church", required=true)
    val penistoneCommunityChurch: String,

    @get:JsonProperty("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out", required=true)@field:JsonProperty("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out", required=true)
    val perlEPrintIMGSRCJava0ScriptAlertXSSOut: String,

    @get:JsonProperty("PRN", required=true)@field:JsonProperty("PRN", required=true)
    val prn: String,

    @get:JsonProperty("'", required=true)@field:JsonProperty("'", required=true)
    val purple: String,

    @get:JsonProperty("0", required=true)@field:JsonProperty("0", required=true)
    val purple0: String,

    @get:JsonProperty("false", required=true)@field:JsonProperty("false", required=true)
    val purpleFalse: String,

    @get:JsonProperty("\u2066test\u2067", required=true)@field:JsonProperty("\u2066test\u2067", required=true)
    val purpleTest: String,

    @get:JsonProperty("RomansInSussex.co.uk", required=true)@field:JsonProperty("RomansInSussex.co.uk", required=true)
    val romansInSussexCoUk: String,

    @get:JsonProperty("%s", required=true)@field:JsonProperty("%s", required=true)
    val s: String,

    @get:JsonProperty("<<< %s(un='%s') = %u", required=true)@field:JsonProperty("<<< %s(un='%s') = %u", required=true)
    val sUnSU: String,

    @get:JsonProperty("<sc<script>ript>alert(123)</sc</script>ript>", required=true)@field:JsonProperty("<sc<script>ript>alert(123)</sc</script>ript>", required=true)
    val scScriptRiptAlert123ScScriptRipt: String,

    @get:JsonProperty("\"><script>alert(123);</script x=\"", required=true)@field:JsonProperty("\"><script>alert(123);</script x=\"", required=true)
    val scriptAlert123ScriptX: String,

    @get:JsonProperty("#\tScript Injection", required=true)@field:JsonProperty("#\tScript Injection", required=true)
    val scriptInjection: String,

    @get:JsonProperty("<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >", required=true)@field:JsonProperty("<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >", required=true)
    val scriptSRCHTTPHaCkersOrgXSSJSB: String,

    @get:JsonProperty("<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", required=true)@field:JsonProperty("<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", required=true)
    val scriptSRCHTTPHaCkersOrgXSSJSSCRIPT: String,

    @get:JsonProperty("</script><script>alert(123)</script>", required=true)@field:JsonProperty("</script><script>alert(123)</script>", required=true)
    val scriptScriptAlert123Script: String,

    @get:JsonProperty("\"`'><script>\\x00javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x00javascript:alert(1)</script>", required=true)
    val scriptX00JavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX09TypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x0Cjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x0Cjavascript:alert(1)</script>", required=true)
    val scriptX0CjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x0Djavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x0Djavascript:alert(1)</script>", required=true)
    val scriptX0DjavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX20TypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX3EtypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xC2\\x85javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xC2\\x85javascript:alert(1)</script>", required=true)
    val scriptXC2X85JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>", required=true)
    val scriptXC2XA0JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>", required=true)
    val scriptXE1X9AX80JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>", required=true)
    val scriptXE1XA0X8EjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>", required=true)
    val scriptXE2X80X81JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>", required=true)
    val scriptXE2X80X86JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>", required=true)
    val scriptXE2X80X89JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>", required=true)
    val scriptXE2X81X9FjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>", required=true)
    val scriptXEFXBBXBFjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>", required=true)
    val scriptXF0X90X96X9AjavascriptAlert1Script: String,

    @get:JsonProperty("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", required=true)@field:JsonProperty("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", required=true)
    val scriptXSSSRCHTTPHaCkersOrgXSSJSSCRIPT: String,

    @get:JsonProperty("#\tSQL Injection", required=true)@field:JsonProperty("#\tSQL Injection", required=true)
    val sqlInjection: String,

    @get:JsonProperty(",", required=true)@field:JsonProperty(",", required=true)
    val sticky: String,

    @get:JsonProperty("#\tString which can reveal system files when parsed by a badly configured XML parser", required=true)@field:JsonProperty("#\tString which can reveal system files when parsed by a badly configured XML parser", required=true)
    val stringWhichCanRevealSystemFilesWhenParsedByABadlyConfiguredXMLParser: String,

    @get:JsonProperty("#\tStrings that test for known vulnerabilities", required=true)@field:JsonProperty("#\tStrings that test for known vulnerabilities", required=true)
    val stringsThatTestForKnownVulnerabilities: String,

    @get:JsonProperty("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.", required=true)@field:JsonProperty("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.", required=true)
    val stringsWhichCanBeAccidentallyExpandedIntoDifferentStringsIfEvaluatedInTheWrongContextEGUsedAsAPrintfFormatStringOrViaPERLOrShellEvalMightExposeSensitiveDataFromTheProgramDoingTheInterpolationOrMightJustRepresentTheWrongString: String,

    @get:JsonProperty("#\tStrings which can call system commands within Ruby/Rails applications", required=true)@field:JsonProperty("#\tStrings which can call system commands within Ruby/Rails applications", required=true)
    val stringsWhichCanCallSystemCommandsWithinRubyRailsApplications: String,

    @get:JsonProperty("#\tStrings which consists of Japanese-style emoticons which are popular on the web", required=true)@field:JsonProperty("#\tStrings which consists of Japanese-style emoticons which are popular on the web", required=true)
    val stringsWhichConsistsOfJapaneseStyleEmoticonsWhichArePopularOnTheWeb: String,

    @get:JsonProperty("#\tStrings which contain bold/italic/etc. versions of normal characters", required=true)@field:JsonProperty("#\tStrings which contain bold/italic/etc. versions of normal characters", required=true)
    val stringsWhichContainBoldItalicEtcVersionsOfNormalCharacters: String,

    @get:JsonProperty("#\tStrings which contain common unicode symbols (e.g. smart quotes)", required=true)@field:JsonProperty("#\tStrings which contain common unicode symbols (e.g. smart quotes)", required=true)
    val stringsWhichContainCommonUnicodeSymbolsEGSmartQuotes: String,

    @get:JsonProperty("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always", required=true)@field:JsonProperty("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always", required=true)
    val stringsWhichContainEmojiShouldBeTheSameBehaviorAsTwoByteCharactersButNotAlways: String,

    @get:JsonProperty("#\tStrings which contain misplaced quotation marks; can cause encoding errors", required=true)@field:JsonProperty("#\tStrings which contain misplaced quotation marks; can cause encoding errors", required=true)
    val stringsWhichContainMisplacedQuotationMarksCanCauseEncodingErrors: String,

    @get:JsonProperty("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues", required=true)@field:JsonProperty("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues", required=true)
    val stringsWhichContainUnicodeSubscriptsSuperscriptsCanCauseRenderingIssues: String,

    @get:JsonProperty("#\tStrings which crashed iMessage in various versions of iOS", required=true)@field:JsonProperty("#\tStrings which crashed iMessage in various versions of iOS", required=true)
    val stringsWhichCrashedIMessageInVariousVersionsOfIOS: String,

    @get:JsonProperty("#\tStrings which may cause human to reinterpret worldview", required=true)@field:JsonProperty("#\tStrings which may cause human to reinterpret worldview", required=true)
    val stringsWhichMayCauseHumanToReinterpretWorldview: String,

    @get:JsonProperty("Super Bowl XXX", required=true)@field:JsonProperty("Super Bowl XXX", required=true)
    val superBowlXXX: String,

    @get:JsonProperty("(╯°□°）╯︵ ┻━┻)", required=true)@field:JsonProperty("(╯°□°）╯︵ ┻━┻)", required=true)
    val tentacled: String,

    @get:JsonProperty("\u202a\u202atest\u202a", required=true)@field:JsonProperty("\u202a\u202atest\u202a", required=true)
    val test: String,

    @get:JsonProperty("</textarea><script>alert(123)</script>", required=true)@field:JsonProperty("</textarea><script>alert(123)</script>", required=true)
    val textareaScriptAlert123Script: String,

    @get:JsonProperty("+0", required=true)@field:JsonProperty("+0", required=true)
    val the0: String,

    @get:JsonProperty("0..0", required=true)@field:JsonProperty("0..0", required=true)
    val the00: String,

    @get:JsonProperty("0,0,0", required=true)@field:JsonProperty("0,0,0", required=true)
    val the000: String,

    @get:JsonProperty("0,0/0,0", required=true)@field:JsonProperty("0,0/0,0", required=true)
    val the0000: String,

    @get:JsonProperty("00˙Ɩ\$-", required=true)@field:JsonProperty("00˙Ɩ\$-", required=true)
    val the00Ɩ: String,

    @get:JsonProperty("0x0", required=true)@field:JsonProperty("0x0", required=true)
    val the0X0: String,

    @get:JsonProperty("-1", required=true)@field:JsonProperty("-1", required=true)
    val the1: String,

    @get:JsonProperty("1/0", required=true)@field:JsonProperty("1/0", required=true)
    val the10: String,

    @get:JsonProperty("1.00", required=true)@field:JsonProperty("1.00", required=true)
    val the100: String,

    @get:JsonProperty("1.0/0.0", required=true)@field:JsonProperty("1.0/0.0", required=true)
    val the1000: String,

    @get:JsonProperty("1'000,00", required=true)@field:JsonProperty("1'000,00", required=true)
    val the100000: String,

    @get:JsonProperty("1 000 000.00", required=true)@field:JsonProperty("1 000 000.00", required=true)
    val the100000000: String,

    @get:JsonProperty("﷽", required=true)@field:JsonProperty("﷽", required=true)
    val the11: String,

    @get:JsonProperty("1/2", required=true)@field:JsonProperty("1/2", required=true)
    val the12: String,

    @get:JsonProperty("123456789012345678901234567890123456789", required=true)@field:JsonProperty("123456789012345678901234567890123456789", required=true)
    val the123456789012345678901234567890123456789: String,

    @get:JsonProperty("\ufeff", required=true)@field:JsonProperty("\ufeff", required=true)
    val the13: String,

    @get:JsonProperty("ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ", required=true)@field:JsonProperty("ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ", required=true)
    val the14: String,

    @get:JsonProperty("\ufffe", required=true)@field:JsonProperty("\ufffe", required=true)
    val the15: String,

    @get:JsonProperty("1;DROP TABLE users", required=true)@field:JsonProperty("1;DROP TABLE users", required=true)
    val the1DROPTABLEUsers: String,

    @get:JsonProperty("-1E02", required=true)@field:JsonProperty("-1E02", required=true)
    val the1E02: String,

    @get:JsonProperty("1E2", required=true)@field:JsonProperty("1E2", required=true)
    val the1E2: String,

    @get:JsonProperty("1#QNAN", required=true)@field:JsonProperty("1#QNAN", required=true)
    val the1Qnan: String,

    @get:JsonProperty("1#SNAN", required=true)@field:JsonProperty("1#SNAN", required=true)
    val the1Snan: String,

    @get:JsonProperty("\ud835\udc7b\ud835\udc89\ud835\udc86 \ud835\udc92\ud835\udc96\ud835\udc8a\ud835\udc84\ud835\udc8c \ud835\udc83\ud835\udc93\ud835\udc90\ud835\udc98\ud835\udc8f \ud835\udc87\ud835\udc90\ud835\udc99 \ud835\udc8b\ud835\udc96\ud835\udc8e\ud835\udc91\ud835\udc94 \ud835\udc90\ud835\udc97\ud835\udc86\ud835\udc93 \ud835\udc95\ud835\udc89\ud835\udc86 \ud835\udc8d\ud835\udc82\ud835\udc9b\ud835\udc9a \ud835\udc85\ud835\udc90\ud835\udc88", required=true)@field:JsonProperty("\ud835\udc7b\ud835\udc89\ud835\udc86 \ud835\udc92\ud835\udc96\ud835\udc8a\ud835\udc84\ud835\udc8c \ud835\udc83\ud835\udc93\ud835\udc90\ud835\udc98\ud835\udc8f \ud835\udc87\ud835\udc90\ud835\udc99 \ud835\udc8b\ud835\udc96\ud835\udc8e\ud835\udc91\ud835\udc94 \ud835\udc90\ud835\udc97\ud835\udc86\ud835\udc93 \ud835\udc95\ud835\udc89\ud835\udc86 \ud835\udc8d\ud835\udc82\ud835\udc9b\ud835\udc9a \ud835\udc85\ud835\udc90\ud835\udc88", required=true)
    val the2: String,

    @get:JsonProperty("\ud835\udce3\ud835\udcf1\ud835\udcee \ud835\udcfa\ud835\udcfe\ud835\udcf2\ud835\udcec\ud835\udcf4 \ud835\udceb\ud835\udcfb\ud835\udcf8\ud835\udd00\ud835\udcf7 \ud835\udcef\ud835\udcf8\ud835\udd01 \ud835\udcf3\ud835\udcfe\ud835\udcf6\ud835\udcf9\ud835\udcfc \ud835\udcf8\ud835\udcff\ud835\udcee\ud835\udcfb \ud835\udcfd\ud835\udcf1\ud835\udcee \ud835\udcf5\ud835\udcea\ud835\udd03\ud835\udd02 \ud835\udced\ud835\udcf8\ud835\udcf0", required=true)@field:JsonProperty("\ud835\udce3\ud835\udcf1\ud835\udcee \ud835\udcfa\ud835\udcfe\ud835\udcf2\ud835\udcec\ud835\udcf4 \ud835\udceb\ud835\udcfb\ud835\udcf8\ud835\udd00\ud835\udcf7 \ud835\udcef\ud835\udcf8\ud835\udd01 \ud835\udcf3\ud835\udcfe\ud835\udcf6\ud835\udcf9\ud835\udcfc \ud835\udcf8\ud835\udcff\ud835\udcee\ud835\udcfb \ud835\udcfd\ud835\udcf1\ud835\udcee \ud835\udcf5\ud835\udcea\ud835\udd03\ud835\udd02 \ud835\udced\ud835\udcf8\ud835\udcf0", required=true)
    val the3: String,

    @get:JsonProperty("\ud835\udd7f\ud835\udd8d\ud835\udd8a \ud835\udd96\ud835\udd9a\ud835\udd8e\ud835\udd88\ud835\udd90 \ud835\udd87\ud835\udd97\ud835\udd94\ud835\udd9c\ud835\udd93 \ud835\udd8b\ud835\udd94\ud835\udd9d \ud835\udd8f\ud835\udd9a\ud835\udd92\ud835\udd95\ud835\udd98 \ud835\udd94\ud835\udd9b\ud835\udd8a\ud835\udd97 \ud835\udd99\ud835\udd8d\ud835\udd8a \ud835\udd91\ud835\udd86\ud835\udd9f\ud835\udd9e \ud835\udd89\ud835\udd94\ud835\udd8c", required=true)@field:JsonProperty("\ud835\udd7f\ud835\udd8d\ud835\udd8a \ud835\udd96\ud835\udd9a\ud835\udd8e\ud835\udd88\ud835\udd90 \ud835\udd87\ud835\udd97\ud835\udd94\ud835\udd9c\ud835\udd93 \ud835\udd8b\ud835\udd94\ud835\udd9d \ud835\udd8f\ud835\udd9a\ud835\udd92\ud835\udd95\ud835\udd98 \ud835\udd94\ud835\udd9b\ud835\udd8a\ud835\udd97 \ud835\udd99\ud835\udd8d\ud835\udd8a \ud835\udd91\ud835\udd86\ud835\udd9f\ud835\udd9e \ud835\udd89\ud835\udd94\ud835\udd8c", required=true)
    val the4: String,

    @get:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8 \ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2\ud83c\uddf8", required=true)@field:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8 \ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2\ud83c\uddf8", required=true)
    val the5: String,

    @get:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6", required=true)@field:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6", required=true)
    val the6: String,

    @get:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2", required=true)@field:JsonProperty("\ud83c\uddfa\ud83c\uddf8\ud83c\uddf7\ud83c\uddfa\ud83c\uddf8\ud83c\udde6\ud83c\uddeb\ud83c\udde6\ud83c\uddf2", required=true)
    val the7: String,

    @get:JsonProperty("\ud83d\udc69\ud83c\udffd", required=true)@field:JsonProperty("\ud83d\udc69\ud83c\udffd", required=true)
    val the8: String,

    @get:JsonProperty("\ud83d\udebe \ud83c\udd92 \ud83c\udd93 \ud83c\udd95 \ud83c\udd96 \ud83c\udd97 \ud83c\udd99 \ud83c\udfe7", required=true)@field:JsonProperty("\ud83d\udebe \ud83c\udd92 \ud83c\udd93 \ud83c\udd95 \ud83c\udd96 \ud83c\udd97 \ud83c\udd99 \ud83c\udfe7", required=true)
    val the9: String,

    @get:JsonProperty("999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999", required=true)@field:JsonProperty("999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999", required=true)
    val the999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: String,

    @get:JsonProperty("# The next two lines may appear to be blank or mojibake in some viewers.", required=true)@field:JsonProperty("# The next two lines may appear to be blank or mojibake in some viewers.", required=true)
    val theNextTwoLinesMayAppearToBeBlankOrMojibakeInSomeViewers: String,

    @get:JsonProperty("The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]", required=true)@field:JsonProperty("The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]", required=true)
    val theQuicKBrownFoXBeeeep: String,

    @get:JsonProperty("٠١٢٣٤٥٦٧٨٩", required=true)@field:JsonProperty("٠١٢٣٤٥٦٧٨٩", required=true)
    val the٠١٢٣٤٥٦٧٨٩: String,

    @get:JsonProperty("#\tTwo-Byte Characters", required=true)@field:JsonProperty("#\tTwo-Byte Characters", required=true)
    val twoByteCharacters: String,

    @get:JsonProperty("# U+0000, U+000A, or U+000D (NUL, LF, CR).", required=true)@field:JsonProperty("# U+0000, U+000A, or U+000D (NUL, LF, CR).", required=true)
    val u0000U000AOrU000DNULLFCR: String,

    @get:JsonProperty("<u oncopy=alert()> Copy me</u>", required=true)@field:JsonProperty("<u oncopy=alert()> Copy me</u>", required=true)
    val uOncopyAlertCopyMeU: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undef: String,

    @get:JsonProperty("#\tUnicode font", required=true)@field:JsonProperty("#\tUnicode font", required=true)
    val unicodeFont: String,

    @get:JsonProperty("#\tUnicode Numbers", required=true)@field:JsonProperty("#\tUnicode Numbers", required=true)
    val unicodeNumbers: String,

    @get:JsonProperty("#\tUnwanted Interpolation", required=true)@field:JsonProperty("#\tUnwanted Interpolation", required=true)
    val unwantedInterpolation: String,

    @get:JsonProperty("%x('ls -al /')", required=true)@field:JsonProperty("%x('ls -al /')", required=true)
    val xLsAl: String,

    @get:JsonProperty("Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮", required=true)@field:JsonProperty("Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮", required=true)
    val zḀḶGO: String,

    @get:JsonProperty("¡™£¢∞§¶•ªº–≠", required=true)@field:JsonProperty("¡™£¢∞§¶•ªº–≠", required=true)
    val ªº: String,

    @get:JsonProperty("¸˛Ç◊ı˜Â¯˘¿", required=true)@field:JsonProperty("¸˛Ç◊ı˜Â¯˘¿", required=true)
    val çIÂ: String,

    @get:JsonProperty("Œ„´‰ˇÁ¨ˆØ∏”’", required=true)@field:JsonProperty("Œ„´‰ˇÁ¨ˆØ∏”’", required=true)
    val œÁØ: String,

    @get:JsonProperty("œ∑´®†¥¨ˆøπ“‘", required=true)@field:JsonProperty("œ∑´®†¥¨ˆøπ“‘", required=true)
    val œØπ: String,

    @get:JsonProperty("( ͡° ͜ʖ ͡°)", required=true)@field:JsonProperty("( ͡° ͜ʖ ͡°)", required=true)
    val ʖ: String,

    @get:JsonProperty("הָיְתָהtestالصفحات التّحول", required=true)@field:JsonProperty("הָיְתָהtestالصفحات التّحول", required=true)
    val היתהTestالصفحاتالتحول: String,

    @get:JsonProperty("ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.", required=true)@field:JsonProperty("ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.", required=true)
    val ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: String,

    @get:JsonProperty("ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็", required=true)@field:JsonProperty("ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็", required=true)
    val ดดด: String,

    @get:JsonProperty("Ⱥ", required=true)@field:JsonProperty("Ⱥ", required=true)
    val ⱥ: String,

    @get:JsonProperty("Ⱦ", required=true)@field:JsonProperty("Ⱦ", required=true)
    val ⱦ: String,

    @get:JsonProperty("パーティーへ行かないか", required=true)@field:JsonProperty("パーティーへ行かないか", required=true)
    val パティへ行かないか: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val 和製漢語: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val 田中さんにあげて下さい: String,

    @get:JsonProperty("`⁄€‹›ﬁﬂ‡°·‚—±", required=true)@field:JsonProperty("`⁄€‹›ﬁﬂ‡°·‚—±", required=true)
    val ﬁﬂ: String,

    @get:JsonProperty("｀ｨ(´∀｀∩", required=true)@field:JsonProperty("｀ｨ(´∀｀∩", required=true)
    val ｨ: String
)

data class B (
    @get:JsonProperty("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">", required=true)@field:JsonProperty("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">", required=true)
    val aHrefHTTPFooBarXYAImgAltImgSrcXXOnerrorJavascriptAlert1A: String,

    @get:JsonProperty("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefJavascriptX00JavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefJavascriptX0DJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX02JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX04JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0DjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX16JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX19JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1DjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1EjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X81JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X82JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80XA9JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80XAFjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXExpressionX5CJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX0AexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX0DexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X82ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X83ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X85ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X87ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X8AexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("# appear in input.", required=true)@field:JsonProperty("# appear in input.", required=true)
    val appearInInput: String,

    @get:JsonProperty("+++ATH0", required=true)@field:JsonProperty("+++ATH0", required=true)
    val ath0: String,

    @get:JsonProperty("' autofocus onkeyup='javascript:alert(123)", required=true)@field:JsonProperty("' autofocus onkeyup='javascript:alert(123)", required=true)
    val autofocusOnkeyupJavascriptAlert123: String,

    @get:JsonProperty("\t\u000b\u000c \u0085             \u200b\u2028\u2029  　", required=true)@field:JsonProperty("\t\u000b\u000c \u0085             \u200b\u2028\u2029  　", required=true)
    val b: String,

    @get:JsonProperty("1'000.00", required=true)@field:JsonProperty("1'000.00", required=true)
    val b100000: String,

    @get:JsonProperty("FALSE", required=true)@field:JsonProperty("FALSE", required=true)
    val bFALSE: String,

    @get:JsonProperty("<IMG SRC=# onmouseover=\"alert('xxs')\">", required=true)@field:JsonProperty("<IMG SRC=# onmouseover=\"alert('xxs')\">", required=true)
    val bIMGSRCOnmouseoverAlertXxs: String,

    @get:JsonProperty("null", required=true)@field:JsonProperty("null", required=true)
    val bNull: String,

    @get:JsonProperty("--><script>alert(123)</script>", required=true)@field:JsonProperty("--><script>alert(123)</script>", required=true)
    val bScriptAlert123Script: String,

    @get:JsonProperty("`touch /tmp/blns.fail`", required=true)@field:JsonProperty("`touch /tmp/blns.fail`", required=true)
    val bTouchTmpBlnsFail: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val basement: String,

    @get:JsonProperty("But now...\u001b[20Cfor my greatest trick...\u001b[8m", required=true)@field:JsonProperty("But now...\u001b[20Cfor my greatest trick...\u001b[8m", required=true)
    val butNow20CforMyGreatestTrick8M: String,

    @get:JsonProperty("# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.", required=true)@field:JsonProperty("# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.", required=true)
    val byteOrderMarksUFEFFAndUFFFEEachOnItsOwnLine: String,

    @get:JsonProperty("COM1", required=true)@field:JsonProperty("COM1", required=true)
    val com1: String,

    @get:JsonProperty("COM3", required=true)@field:JsonProperty("COM3", required=true)
    val com3: String,

    @get:JsonProperty("# Commonly misinterpreted as additional graphic characters.", required=true)@field:JsonProperty("# Commonly misinterpreted as additional graphic characters.", required=true)
    val commonlyMisinterpretedAsAdditionalGraphicCharacters: String,

    @get:JsonProperty("CON", required=true)@field:JsonProperty("CON", required=true)
    val con: String,

    @get:JsonProperty("# contexts.  Divided into three groups based on (US-layout) keyboard position.", required=true)@field:JsonProperty("# contexts.  Divided into three groups based on (US-layout) keyboard position.", required=true)
    val contextsDividedIntoThreeGroupsBasedOnUSLayoutKeyboardPosition: String,

    @get:JsonProperty("#\tCredit: https://twitter.com/jifa/status/625776454479970304", required=true)@field:JsonProperty("#\tCredit: https://twitter.com/jifa/status/625776454479970304", required=true)
    val creditHTTPSTwitterCOMJifaStatus625776454479970304: String,

    @get:JsonProperty("/dev/null; touch /tmp/blns.fail ; echo", required=true)@field:JsonProperty("/dev/null; touch /tmp/blns.fail ; echo", required=true)
    val devNullTouchTmpBlnsFailEcho: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dontMakeAMap: Boolean,

    @get:JsonProperty("\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f", required=true)@field:JsonProperty("\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f", required=true)
    val empty: String,

    @get:JsonProperty("eval(\"puts 'hello world'\")", required=true)@field:JsonProperty("eval(\"puts 'hello world'\")", required=true)
    val evalPutsHelloWorld: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val expression: String,

    @get:JsonProperty("File:///", required=true)@field:JsonProperty("File:///", required=true)
    val file: String,

    @get:JsonProperty("#\tFile Inclusion", required=true)@field:JsonProperty("#\tFile Inclusion", required=true)
    val fileInclusion: String,

    @get:JsonProperty("#", required=true)@field:JsonProperty("#", required=true)
    val fluffy: String,

    @get:JsonProperty("<foo val=”bar“ />", required=true)@field:JsonProperty("<foo val=”bar“ />", required=true)
    val fooValBar: String,

    @get:JsonProperty("# general category Cf (in Unicode 8.0.0).", required=true)@field:JsonProperty("# general category Cf (in Unicode 8.0.0).", required=true)
    val generalCategoryCFInUnicode800: String,

    @get:JsonProperty("̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕", required=true)@field:JsonProperty("̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕", required=true)
    val hEWHOWAĮTSBEHINDTHEWALḼ: String,

    @get:JsonProperty("--help", required=true)@field:JsonProperty("--help", required=true)
    val help: String,

    @get:JsonProperty("\ud83d\ude0d", required=true)@field:JsonProperty("\ud83d\ude0d", required=true)
    val hilarious: String,

    @get:JsonProperty("http://a/%%30%30", required=true)@field:JsonProperty("http://a/%%30%30", required=true)
    val httpA3030: String,

    @get:JsonProperty("#\tiOS Vulnerabilities", required=true)@field:JsonProperty("#\tiOS Vulnerabilities", required=true)
    val iOSVulnerabilities: String,

    @get:JsonProperty("If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.", required=true)@field:JsonProperty("If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.", required=true)
    val ifYouReReadingThisYouVeBeenInAComaForAlmost20YearsNowWeReTryingANewTechniqueWeDonTKnowWhereThisMessageWillEndUpInYourDreamButWeHopeItWorksPleaseWakeUpWeMissYou: String,

    @get:JsonProperty("<iframe src=http://ha.ckers.org/scriptlet.html <", required=true)@field:JsonProperty("<iframe src=http://ha.ckers.org/scriptlet.html <", required=true)
    val iframeSrcHTTPHaCkersOrgScriptletHTML: String,

    @get:JsonProperty("<IMG SRC=\" &#14;  javascript:alert('XSS');\">", required=true)@field:JsonProperty("<IMG SRC=\" &#14;  javascript:alert('XSS');\">", required=true)
    val imgSRC14JavascriptAlertXSS: String,

    @get:JsonProperty("<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">", required=true)@field:JsonProperty("<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">", required=true)
    val imgSRCJavX09AscriptAlertXSS: String,

    @get:JsonProperty("<IMG SRC= onmouseover=\"alert('xxs')\">", required=true)@field:JsonProperty("<IMG SRC= onmouseover=\"alert('xxs')\">", required=true)
    val imgSRCOnmouseoverAlertXxs: String,

    @get:JsonProperty("<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>", required=true)@field:JsonProperty("<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>", required=true)
    val imgSRCX6AX61X76X61X73X63X72X69X70X74X3AX61X6CX65X72X74X28X27X58X53X53X27X29: String,

    @get:JsonProperty("<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>", required=true)@field:JsonProperty("<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>", required=true)
    val imgSrc00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: String,

    @get:JsonProperty("<img src\\x00=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x00=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX00XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=\\x11\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x11\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX11JavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=\\x12\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x12\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX12JavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX0AonerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX0ConerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX0DonerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x00src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x00src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX00SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x11src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x11src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX11SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x12src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x12src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX12SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x47src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x47src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX47SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("\ud835\udd4b\ud835\udd59\ud835\udd56 \ud835\udd62\ud835\udd66\ud835\udd5a\ud835\udd54\ud835\udd5c \ud835\udd53\ud835\udd63\ud835\udd60\ud835\udd68\ud835\udd5f \ud835\udd57\ud835\udd60\ud835\udd69 \ud835\udd5b\ud835\udd66\ud835\udd5e\ud835\udd61\ud835\udd64 \ud835\udd60\ud835\udd67\ud835\udd56\ud835\udd63 \ud835\udd65\ud835\udd59\ud835\udd56 \ud835\udd5d\ud835\udd52\ud835\udd6b\ud835\udd6a \ud835\udd55\ud835\udd60\ud835\udd58", required=true)@field:JsonProperty("\ud835\udd4b\ud835\udd59\ud835\udd56 \ud835\udd62\ud835\udd66\ud835\udd5a\ud835\udd54\ud835\udd5c \ud835\udd53\ud835\udd63\ud835\udd60\ud835\udd68\ud835\udd5f \ud835\udd57\ud835\udd60\ud835\udd69 \ud835\udd5b\ud835\udd66\ud835\udd5e\ud835\udd61\ud835\udd64 \ud835\udd60\ud835\udd67\ud835\udd56\ud835\udd63 \ud835\udd65\ud835\udd59\ud835\udd56 \ud835\udd5d\ud835\udd52\ud835\udd6b\ud835\udd6a \ud835\udd55\ud835\udd60\ud835\udd58", required=true)
    val indecent: String,

    @get:JsonProperty("❤️ \ud83d\udc94 \ud83d\udc8c \ud83d\udc95 \ud83d\udc9e \ud83d\udc93 \ud83d\udc97 \ud83d\udc96 \ud83d\udc98 \ud83d\udc9d \ud83d\udc9f \ud83d\udc9c \ud83d\udc9b \ud83d\udc9a \ud83d\udc99", required=true)@field:JsonProperty("❤️ \ud83d\udc94 \ud83d\udc8c \ud83d\udc95 \ud83d\udc9e \ud83d\udc93 \ud83d\udc97 \ud83d\udc96 \ud83d\udc98 \ud83d\udc9d \ud83d\udc9f \ud83d\udc9c \ud83d\udc9b \ud83d\udc9a \ud83d\udc99", required=true)
    val indigo: String,

    @get:JsonProperty("#   IRC specific strings", required=true)@field:JsonProperty("#   IRC specific strings", required=true)
    val ircSpecificStrings: String,

    @get:JsonProperty("#\tJapanese Emoticons", required=true)@field:JsonProperty("#\tJapanese Emoticons", required=true)
    val japaneseEmoticons: String,

    @get:JsonProperty("Kernel.exec(\"ls -al /\")", required=true)@field:JsonProperty("Kernel.exec(\"ls -al /\")", required=true)
    val kernelExecLsAl: String,

    @get:JsonProperty("Linda Callahan", required=true)@field:JsonProperty("Linda Callahan", required=true)
    val lindaCallahan: String,

    @get:JsonProperty("NIL", required=true)@field:JsonProperty("NIL", required=true)
    val nil: String,

    @get:JsonProperty("NUL", required=true)@field:JsonProperty("NUL", required=true)
    val nul: String,

    @get:JsonProperty("#\tNumeric Strings", required=true)@field:JsonProperty("#\tNumeric Strings", required=true)
    val numericStrings: String,

    @get:JsonProperty("# Often forbidden to appear in various text-based file formats (e.g. XML),", required=true)@field:JsonProperty("# Often forbidden to appear in various text-based file formats (e.g. XML),", required=true)
    val oftenForbiddenToAppearInVariousTextBasedFileFormatsEGXML: String,

    @get:JsonProperty("\" onfocus=JaVaSCript:alert(123) autofocus", required=true)@field:JsonProperty("\" onfocus=JaVaSCript:alert(123) autofocus", required=true)
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @get:JsonProperty("' OR 1=1 -- 1", required=true)@field:JsonProperty("' OR 1=1 -- 1", required=true)
    val or111: String,

    @get:JsonProperty("\"", required=true)@field:JsonProperty("\"", required=true)
    val purple: String,

    @get:JsonProperty("<script>alert(123)</script>", required=true)@field:JsonProperty("<script>alert(123)</script>", required=true)
    val purpleScriptAlert123Script: String,

    @get:JsonProperty("#\tQuotation Marks", required=true)@field:JsonProperty("#\tQuotation Marks", required=true)
    val quotationMarks: String,

    @get:JsonProperty("#       Regional Indicator Symbols", required=true)@field:JsonProperty("#       Regional Indicator Symbols", required=true)
    val regionalIndicatorSymbols: String,

    @get:JsonProperty("#       Regional Indicator Symbols can be displayed differently across", required=true)@field:JsonProperty("#       Regional Indicator Symbols can be displayed differently across", required=true)
    val regionalIndicatorSymbolsCanBeDisplayedDifferentlyAcross: String,

    @get:JsonProperty("#\tReserved Strings", required=true)@field:JsonProperty("#\tReserved Strings", required=true)
    val reservedStrings: String,

    @get:JsonProperty("\"><script>alert(123)</script>", required=true)@field:JsonProperty("\"><script>alert(123)</script>", required=true)
    val scriptAlert123Script: String,

    @get:JsonProperty("><script>alert(123);</script x=", required=true)@field:JsonProperty("><script>alert(123);</script x=", required=true)
    val scriptAlert123ScriptX: String,

    @get:JsonProperty("<<SCRIPT>alert(\"XSS\");//<</SCRIPT>", required=true)@field:JsonProperty("<<SCRIPT>alert(\"XSS\");//<</SCRIPT>", required=true)
    val scriptAlertXSSSCRIPT: String,

    @get:JsonProperty("<SCRIPT SRC=//ha.ckers.org/.j>", required=true)@field:JsonProperty("<SCRIPT SRC=//ha.ckers.org/.j>", required=true)
    val scriptSRCHaCkersOrgJ: String,

    @get:JsonProperty("<script src=\"\\\\%(jscript)s\"></script>", required=true)@field:JsonProperty("<script src=\"\\\\%(jscript)s\"></script>", required=true)
    val scriptSrcJscriptSScript: String,

    @get:JsonProperty("\"`'><script>\\x09javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x09javascript:alert(1)</script>", required=true)
    val scriptX09JavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX0AtypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX0DtypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x21javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x21javascript:alert(1)</script>", required=true)
    val scriptX21JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x3Bjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x3Bjavascript:alert(1)</script>", required=true)
    val scriptX3BjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>", required=true)
    val scriptXE2X80X85JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>", required=true)
    val scriptXE2X80X87JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>", required=true)
    val scriptXE2X80X8AjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>", required=true)
    val scriptXE2X80XA8JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>", required=true)
    val scriptXE2X80XA9JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>", required=true)
    val scriptXE2X80XAFjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>", required=true)
    val scriptXE3X80X80JavascriptAlert1Script: String,

    @get:JsonProperty("#\tScunthorpe Problem", required=true)@field:JsonProperty("#\tScunthorpe Problem", required=true)
    val scunthorpeProblem: String,

    @get:JsonProperty("⁰⁴⁵₀₁₂", required=true)@field:JsonProperty("⁰⁴⁵₀₁₂", required=true)
    val sticky: String,

    @get:JsonProperty("#   Strings that may occur on IRC clients that make security products freak out", required=true)@field:JsonProperty("#   Strings that may occur on IRC clients that make security products freak out", required=true)
    val stringsThatMayOccurOnIRCClientsThatMakeSecurityProductsFreakOut: String,

    @get:JsonProperty("#\tStrings which are reserved characters in MSDOS/Windows", required=true)@field:JsonProperty("#\tStrings which are reserved characters in MSDOS/Windows", required=true)
    val stringsWhichAreReservedCharactersInMSDOSWindows: String,

    @get:JsonProperty("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS", required=true)@field:JsonProperty("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS", required=true)
    val stringsWhichAttemptToInvokeABenignScriptInjectionShowsVulnerabilityToXSS: String,

    @get:JsonProperty("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)", required=true)@field:JsonProperty("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)", required=true)
    val stringsWhichContainTextThatShouldBeRenderedRTLIfPossibleEGArabicHebrew: String,

    @get:JsonProperty("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues", required=true)@field:JsonProperty("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues", required=true)
    val stringsWhichContainTwoByteCharactersCanCauseRenderingIssuesOrCharacterLengthIssues: String,

    @get:JsonProperty("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric", required=true)@field:JsonProperty("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric", required=true)
    val stringsWhichContainUnicodeNumbersIfTheCodeIsLocalizedItShouldSeeTheInputAsNumeric: String,

    @get:JsonProperty("#\tStrings which may be used elsewhere in code", required=true)@field:JsonProperty("#\tStrings which may be used elsewhere in code", required=true)
    val stringsWhichMayBeUsedElsewhereInCode: String,

    @get:JsonProperty("(｡◕ ∀ ◕｡)", required=true)@field:JsonProperty("(｡◕ ∀ ◕｡)", required=true)
    val tentacled: String,

    @get:JsonProperty("#\tTerminal escape codes", required=true)@field:JsonProperty("#\tTerminal escape codes", required=true)
    val terminalEscapeCodes: String,

    @get:JsonProperty("0.00", required=true)@field:JsonProperty("0.00", required=true)
    val the000: String,

    @get:JsonProperty("01000", required=true)@field:JsonProperty("01000", required=true)
    val the01000: String,

    @get:JsonProperty("08", required=true)@field:JsonProperty("08", required=true)
    val the08: String,

    @get:JsonProperty("09", required=true)@field:JsonProperty("09", required=true)
    val the09: String,

    @get:JsonProperty("0xffffffffffffffff", required=true)@field:JsonProperty("0xffffffffffffffff", required=true)
    val the0Xffffffffffffffff: String,

    @get:JsonProperty("\$1.00", required=true)@field:JsonProperty("\$1.00", required=true)
    val the100: String,

    @get:JsonProperty("1,0/0,0", required=true)@field:JsonProperty("1,0/0,0", required=true)
    val the1000: String,

    @get:JsonProperty("1 000.00", required=true)@field:JsonProperty("1 000.00", required=true)
    val the100000: String,

    @get:JsonProperty("1 000 000,00", required=true)@field:JsonProperty("1 000 000,00", required=true)
    val the100000000: String,

    @get:JsonProperty("1'; DROP TABLE users-- 1", required=true)@field:JsonProperty("1'; DROP TABLE users-- 1", required=true)
    val the1DROPTABLEUsers1: String,

    @get:JsonProperty("1#IND", required=true)@field:JsonProperty("1#IND", required=true)
    val the1Ind: String,

    @get:JsonProperty("1#INF", required=true)@field:JsonProperty("1#INF", required=true)
    val the1Inf: String,

    @get:JsonProperty("-2147483648/-1", required=true)@field:JsonProperty("-2147483648/-1", required=true)
    val the21474836481: String,

    @get:JsonProperty("2.2250738585072011e-308", required=true)@field:JsonProperty("2.2250738585072011e-308", required=true)
    val the22250738585072011E308: String,

    @get:JsonProperty("# The next line may appear to be blank, mojibake, or dingbats in some viewers.", required=true)@field:JsonProperty("# The next line may appear to be blank, mojibake, or dingbats in some viewers.", required=true)
    val theNextLineMayAppearToBeBlankMojibakeOrDingbatsInSomeViewers: String,

    @get:JsonProperty("# The next line may appear to be blank or mojibake in some viewers.", required=true)@field:JsonProperty("# The next line may appear to be blank or mojibake in some viewers.", required=true)
    val theNextLineMayAppearToBeBlankOrMojibakeInSomeViewers: String,

    @get:JsonProperty("# The next line may be flagged for \"trailing whitespace\" in some viewers.", required=true)@field:JsonProperty("# The next line may be flagged for \"trailing whitespace\" in some viewers.", required=true)
    val theNextLineMayBeFlaggedForTrailingWhitespaceInSomeViewers: String,

    @get:JsonProperty("１２３", required=true)@field:JsonProperty("１２３", required=true)
    val the１２３: String,

    @get:JsonProperty("# This file unfortunately cannot express strings containing", required=true)@field:JsonProperty("# This file unfortunately cannot express strings containing", required=true)
    val thisFileUnfortunatelyCannotExpressStringsContaining: String,

    @get:JsonProperty("\$(touch /tmp/blns.fail)", required=true)@field:JsonProperty("\$(touch /tmp/blns.fail)", required=true)
    val touchTmpBlnsFail: String,

    @get:JsonProperty("() { _; } >_[\$(\$())] { touch /tmp/blns.shellshock2.fail; }", required=true)@field:JsonProperty("() { _; } >_[\$(\$())] { touch /tmp/blns.shellshock2.fail; }", required=true)
    val touchTmpBlnsShellshock2Fail: String,

    @get:JsonProperty("Tyson Gay", required=true)@field:JsonProperty("Tyson Gay", required=true)
    val tysonGay: String,

    @get:JsonProperty("#\tUnicode Symbols", required=true)@field:JsonProperty("#\tUnicode Symbols", required=true)
    val unicodeSymbols: String,

    @get:JsonProperty("'`\"><\\x00script>javascript:alert(1)</script>", required=true)@field:JsonProperty("'`\"><\\x00script>javascript:alert(1)</script>", required=true)
    val x00ScriptJavascriptAlert1Script: String,

    @get:JsonProperty("'`\"><\\x3Cscript>javascript:alert(1)</script>", required=true)@field:JsonProperty("'`\"><\\x3Cscript>javascript:alert(1)</script>", required=true)
    val x3CscriptJavascriptAlert1Script: String,

    @get:JsonProperty("åß∂ƒ©˙∆˚¬…æ", required=true)@field:JsonProperty("åß∂ƒ©˙∆˚¬…æ", required=true)
    val åßƑÆ: String,

    @get:JsonProperty("˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥", required=true)@field:JsonProperty("˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥", required=true)
    val ɐnbᴉlɐⱯuƃɐɯƎɹolopꞱǝƎɹoqɐlꞱnꞱunpᴉpᴉɔuᴉɹodɯǝʇPoɯsnᴉǝOpPǝsꞱᴉlǝƂuᴉɔsᴉdᴉpɐɹnʇǝʇɔǝsuoɔꞱǝɯɐꞱᴉsɹolopƜnsdᴉƜǝɹo: String,

    @get:JsonProperty("Ω≈ç√∫˜µ≤≥÷", required=true)@field:JsonProperty("Ω≈ç√∫˜µ≤≥÷", required=true)
    val ωÇΜ: String,

    @get:JsonProperty("ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ", required=true)@field:JsonProperty("ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ", required=true)
    val ຈلຈﾉຈلຈﾉ: String,

    @get:JsonProperty("Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣", required=true)@field:JsonProperty("Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣", required=true)
    val ṱOINVOKèTHEHIVEMINDREPRESEǸTINGCHAOS: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val 社會科學院語學研究所: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val 部落格: String,

    @get:JsonProperty("사회과학원 어학연구소", required=true)@field:JsonProperty("사회과학원 어학연구소", required=true)
    val 사회과학원어학연구소: String,

    @get:JsonProperty("찦차를 타고 온 펲시맨과 쑛다리 똠방각하", required=true)@field:JsonProperty("찦차를 타고 온 펲시맨과 쑛다리 똠방각하", required=true)
    val 찦차를타고온펲시맨과쑛다리똠방각하: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ﷺ: String,

    @get:JsonProperty("__ﾛ(,_,*)", required=true)@field:JsonProperty("__ﾛ(,_,*)", required=true)
    val ﾛ_: String
)

data class C (
    @get:JsonProperty("\ud841\udf0e\ud841\udf31\ud841\udf79\ud843\udc53\ud843\udc78\ud843\udc96\ud843\udccf", required=true)@field:JsonProperty("\ud841\udf0e\ud841\udf31\ud841\udf79\ud843\udc53\ud843\udc78\ud843\udc96\ud843\udccf", required=true)
    val _1: String,

    @get:JsonProperty("A:", required=true)@field:JsonProperty("A:", required=true)
    val a: String,

    @get:JsonProperty("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX00JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX03JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX06JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX07JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX0BjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX12JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX14JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX15JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX18JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1BjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX1CjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefX20JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X85JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X88JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X89JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X80X8AjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE2X81X9FjavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)@field:JsonProperty("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>", required=true)
    val aHrefXE3X80X80JavascriptJavascriptAlert1IDFuzzelement1TestA: String,

    @get:JsonProperty("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXExpressionX00JavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX00ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXX0CexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X81ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X86ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE2X80X88ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXE3X80X80ExpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF", required=true)@field:JsonProperty("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF", required=true)
    val abcDivStyleXXEFXBBXBFexpressionJavascriptAlert1DEF: String,

    @get:JsonProperty("_", required=true)@field:JsonProperty("_", required=true)
    val ambitious: String,

    @get:JsonProperty("# and U+007F (DEL)", required=true)@field:JsonProperty("# and U+007F (DEL)", required=true)
    val andU007FDEL: String,

    @get:JsonProperty("# ASCII punctuation.  All of these characters may need to be escaped in some", required=true)@field:JsonProperty("# ASCII punctuation.  All of these characters may need to be escaped in some", required=true)
    val asciiPunctuationAllOfTheseCharactersMayNeedToBeEscapedInSome: String,

    @get:JsonProperty("<BODY onload!#\$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>", required=true)@field:JsonProperty("<BODY onload!#\$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>", required=true)
    val bodyOnloadAlertXSS: String,

    @get:JsonProperty("\ud835\udc13\ud835\udc21\ud835\udc1e \ud835\udc2a\ud835\udc2e\ud835\udc22\ud835\udc1c\ud835\udc24 \ud835\udc1b\ud835\udc2b\ud835\udc28\ud835\udc30\ud835\udc27 \ud835\udc1f\ud835\udc28\ud835\udc31 \ud835\udc23\ud835\udc2e\ud835\udc26\ud835\udc29\ud835\udc2c \ud835\udc28\ud835\udc2f\ud835\udc1e\ud835\udc2b \ud835\udc2d\ud835\udc21\ud835\udc1e \ud835\udc25\ud835\udc1a\ud835\udc33\ud835\udc32 \ud835\udc1d\ud835\udc28\ud835\udc20", required=true)@field:JsonProperty("\ud835\udc13\ud835\udc21\ud835\udc1e \ud835\udc2a\ud835\udc2e\ud835\udc22\ud835\udc1c\ud835\udc24 \ud835\udc1b\ud835\udc2b\ud835\udc28\ud835\udc30\ud835\udc27 \ud835\udc1f\ud835\udc28\ud835\udc31 \ud835\udc23\ud835\udc2e\ud835\udc26\ud835\udc29\ud835\udc2c \ud835\udc28\ud835\udc2f\ud835\udc1e\ud835\udc2b \ud835\udc2d\ud835\udc21\ud835\udc1e \ud835\udc25\ud835\udc1a\ud835\udc33\ud835\udc32 \ud835\udc1d\ud835\udc28\ud835\udc20", required=true)
    val braggadocious: String,

    @get:JsonProperty("\"'\"'\"''''\"", required=true)@field:JsonProperty("\"'\"'\"''''\"", required=true)
    val c: String,

    @get:JsonProperty("-0.0", required=true)@field:JsonProperty("-0.0", required=true)
    val c00: String,

    @get:JsonProperty("0.0/0", required=true)@field:JsonProperty("0.0/0", required=true)
    val c000: String,

    @get:JsonProperty("-1.00", required=true)@field:JsonProperty("-1.00", required=true)
    val c100: String,

    @get:JsonProperty("1,000.00", required=true)@field:JsonProperty("1,000.00", required=true)
    val c100000: String,

    @get:JsonProperty("1,000,000.00", required=true)@field:JsonProperty("1,000,000.00", required=true)
    val c100000000: String,

    @get:JsonProperty("1E+02", required=true)@field:JsonProperty("1E+02", required=true)
    val c1E02: String,

    @get:JsonProperty("NULL", required=true)@field:JsonProperty("NULL", required=true)
    val cNULL: String,

    @get:JsonProperty("><script>alert(123)</script>", required=true)@field:JsonProperty("><script>alert(123)</script>", required=true)
    val cScriptAlert123Script: String,

    @get:JsonProperty("true", required=true)@field:JsonProperty("true", required=true)
    val cTrue: String,

    @get:JsonProperty("CLOCK\$", required=true)@field:JsonProperty("CLOCK\$", required=true)
    val clock: String,

    @get:JsonProperty("COM2", required=true)@field:JsonProperty("COM2", required=true)
    val com2: String,

    @get:JsonProperty("COM4", required=true)@field:JsonProperty("COM4", required=true)
    val com4: String,

    @get:JsonProperty("Craig Cockburn, Software Specialist", required=true)@field:JsonProperty("Craig Cockburn, Software Specialist", required=true)
    val craigCockburnSoftwareSpecialist: String,

    @get:JsonProperty("⁰⁴⁵", required=true)@field:JsonProperty("⁰⁴⁵", required=true)
    val cunning: String,

    @get:JsonProperty("DCC SEND STARTKEYLOGGER 0 0 0", required=true)@field:JsonProperty("DCC SEND STARTKEYLOGGER 0 0 0", required=true)
    val dccSendStartkeylogger000: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dontMakeAMap: Boolean,

    @get:JsonProperty("#\tEmoji", required=true)@field:JsonProperty("#\tEmoji", required=true)
    val emoji: String,

    @get:JsonProperty("\"\"", required=true)@field:JsonProperty("\"\"", required=true)
    val empty: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val evaluate: String,

    @get:JsonProperty("%", required=true)@field:JsonProperty("%", required=true)
    val fluffy: String,

    @get:JsonProperty("0/0", required=true)@field:JsonProperty("0/0", required=true)
    val fluffy00: String,

    @get:JsonProperty("<foo val=“bar” />", required=true)@field:JsonProperty("<foo val=“bar” />", required=true)
    val fooValBar: String,

    @get:JsonProperty("✋\ud83c\udfff \ud83d\udcaa\ud83c\udfff \ud83d\udc50\ud83c\udfff \ud83d\ude4c\ud83c\udfff \ud83d\udc4f\ud83c\udfff \ud83d\ude4f\ud83c\udfff", required=true)@field:JsonProperty("✋\ud83c\udfff \ud83d\udcaa\ud83c\udfff \ud83d\udc50\ud83c\udfff \ud83d\ude4c\ud83c\udfff \ud83d\udc4f\ud83c\udfff \ud83d\ude4f\ud83c\udfff", required=true)
    val frisky: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hasOwnProperty: String,

    @get:JsonProperty("\\\\", required=true)@field:JsonProperty("\\\\", required=true)
    val hilarious: String,

    @get:JsonProperty("Horniman Museum", required=true)@field:JsonProperty("Horniman Museum", required=true)
    val hornimanMuseum: String,

    @get:JsonProperty("http://www.cum.qc.ca/", required=true)@field:JsonProperty("http://www.cum.qc.ca/", required=true)
    val httpWWWCumQcCA: String,

    @get:JsonProperty("<i onwheel=alert(1)> Scroll over me </i>", required=true)@field:JsonProperty("<i onwheel=alert(1)> Scroll over me </i>", required=true)
    val iOnwheelAlert1ScrollOverMeI: String,

    @get:JsonProperty("<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">", required=true)@field:JsonProperty("<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">", required=true)
    val imgABCSrcDXEOnerrorFAlert1: String,

    @get:JsonProperty("<IMG onmouseover=\"alert('xxs')\">", required=true)@field:JsonProperty("<IMG onmouseover=\"alert('xxs')\">", required=true)
    val imgOnmouseoverAlertXxs: String,

    @get:JsonProperty("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">", required=true)@field:JsonProperty("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">", required=true)
    val imgSCRIPTAlertXSSSCRIPT: String,

    @get:JsonProperty("<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>", required=true)@field:JsonProperty("<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>", required=true)
    val imgSRCJavascriptAlertStringFromCharCode888383: String,

    @get:JsonProperty("<IMG SRC=\"javascript:alert('XSS')\"", required=true)@field:JsonProperty("<IMG SRC=\"javascript:alert('XSS')\"", required=true)
    val imgSRCJavascriptAlertXSS: String,

    @get:JsonProperty("<img src onerror /\" '\"= alt=javascript:alert(1)//\">", required=true)@field:JsonProperty("<img src onerror /\" '\"= alt=javascript:alert(1)//\">", required=true)
    val imgSrcOnerrorAltJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x10=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x10=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX10XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x12=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x12=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX12XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x13=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x13=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX13XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x32=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x32=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX32XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src\\x47=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src\\x47=x onerror=\"javascript:alert(1)\">", required=true)
    val imgSrcX47XOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=alert(123) />", required=true)@field:JsonProperty("<img src=x onerror=alert(123) />", required=true)
    val imgSrcXOnerrorAlert123: String,

    @get:JsonProperty("<img src=x onerror=\\x10\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x10\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX10JavascriptAlert1: String,

    @get:JsonProperty("<img src=x onerror=\\x32\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img src=x onerror=\\x32\"javascript:alert(1)\">", required=true)
    val imgSrcXOnerrorX32JavascriptAlert1: String,

    @get:JsonProperty("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>", required=true)@field:JsonProperty("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>", required=true)
    val imgSrcXScriptJavascriptAlert1Script: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX09OnerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX20OnerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX22OnerrorJavascriptAlert1: String,

    @get:JsonProperty("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>", required=true)@field:JsonProperty("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>", required=true)
    val imgSrcXxxXX27OnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img\\x11src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img\\x11src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX11SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img \\x34src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img \\x34src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX34SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty("<img\\x47src=x onerror=\"javascript:alert(1)\">", required=true)@field:JsonProperty("<img\\x47src=x onerror=\"javascript:alert(1)\">", required=true)
    val imgX47SrcXOnerrorJavascriptAlert1: String,

    @get:JsonProperty(".", required=true)@field:JsonProperty(".", required=true)
    val indecent: String,

    @get:JsonProperty("--", required=true)@field:JsonProperty("--", required=true)
    val indigo: String,

    @get:JsonProperty("Infinity", required=true)@field:JsonProperty("Infinity", required=true)
    val infinity: String,

    @get:JsonProperty("JavaSCript:alert(123)", required=true)@field:JsonProperty("JavaSCript:alert(123)", required=true)
    val javaSCriptAlert123: String,

    @get:JsonProperty("LPT1", required=true)@field:JsonProperty("LPT1", required=true)
    val lpt1: String,

    @get:JsonProperty("&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;", required=true)@field:JsonProperty("&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;", required=true)
    val ltScriptGtAlert3912339LtScriptGt: String,

    @get:JsonProperty("⅛⅜⅝⅞", required=true)@field:JsonProperty("⅛⅜⅝⅞", required=true)
    val magenta: String,

    @get:JsonProperty("magna cum laude", required=true)@field:JsonProperty("magna cum laude", required=true)
    val magnaCumLaude: String,

    @get:JsonProperty("medieval erection of parapets", required=true)@field:JsonProperty("medieval erection of parapets", required=true)
    val medievalErectionOfParapets: String,

    @get:JsonProperty("・(￣∀￣)・:*:", required=true)@field:JsonProperty("・(￣∀￣)・:*:", required=true)
    val mischievous: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mocha: String,

    @get:JsonProperty("NaN", required=true)@field:JsonProperty("NaN", required=true)
    val naN: String,

    @get:JsonProperty("# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,", required=true)@field:JsonProperty("# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,", required=true)
    val nonWhitespaceC0ControlsU0001ThroughU0008U000EThroughU001F: String,

    @get:JsonProperty("' onfocus=JaVaSCript:alert(123) autofocus", required=true)@field:JsonProperty("' onfocus=JaVaSCript:alert(123) autofocus", required=true)
    val onfocusJaVaSCriptAlert123Autofocus: String,

    @get:JsonProperty("# or reused for internal delimiters on the theory that they should never", required=true)@field:JsonProperty("# or reused for internal delimiters on the theory that they should never", required=true)
    val orReusedForInternalDelimitersOnTheTheoryThatTheyShouldNever: String,

    @get:JsonProperty("<plaintext>", required=true)@field:JsonProperty("<plaintext>", required=true)
    val plaintext: String,

    @get:JsonProperty("Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗", required=true)@field:JsonProperty("Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗", required=true)
    val powerللصبللصبررH冗: String,

    @get:JsonProperty("\"''''\"'\"", required=true)@field:JsonProperty("\"''''\"'\"", required=true)
    val purple: String,

    @get:JsonProperty("0,,0", required=true)@field:JsonProperty("0,,0", required=true)
    val purple00: String,

    @get:JsonProperty("1.000,00", required=true)@field:JsonProperty("1.000,00", required=true)
    val purple100000: String,

    @get:JsonProperty("1.000.000,00", required=true)@field:JsonProperty("1.000.000,00", required=true)
    val purple100000000: String,

    @get:JsonProperty("＜script＞alert(123)＜/script＞", required=true)@field:JsonProperty("＜script＞alert(123)＜/script＞", required=true)
    val purpleScriptAlert123Script: String,

    @get:JsonProperty("#\tRight-To-Left Strings", required=true)@field:JsonProperty("#\tRight-To-Left Strings", required=true)
    val rightToLeftStrings: String,

    @get:JsonProperty("Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue", required=true)@field:JsonProperty("Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue", required=true)
    val rosesAre031Mred0MVioletsAre034MblueHopeYouEnjoyTerminalHue: String,

    @get:JsonProperty("%*.*s", required=true)@field:JsonProperty("%*.*s", required=true)
    val s: String,

    @get:JsonProperty("'><script>alert(123)</script>", required=true)@field:JsonProperty("'><script>alert(123)</script>", required=true)
    val scriptAlert123Script: String,

    @get:JsonProperty("'><script>alert(123);</script x='", required=true)@field:JsonProperty("'><script>alert(123);</script x='", required=true)
    val scriptAlert123ScriptX: String,

    @get:JsonProperty("\"`'><script>-javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>-javascript:alert(1)</script>", required=true)
    val scriptJavascriptAlert1Script: String,

    @get:JsonProperty("< / script >< script >alert(123)< / script >", required=true)@field:JsonProperty("< / script >< script >alert(123)< / script >", required=true)
    val scriptScriptAlert123Script: String,

    @get:JsonProperty("<script src=\"/\\%(jscript)s\"></script>", required=true)@field:JsonProperty("<script src=\"/\\%(jscript)s\"></script>", required=true)
    val scriptSrcJscriptSScript: String,

    @get:JsonProperty("\"`'><script>\\x0Ajavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x0Ajavascript:alert(1)</script>", required=true)
    val scriptX0AjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x0Bjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x0Bjavascript:alert(1)</script>", required=true)
    val scriptX0BjavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX0CtypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x20javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x20javascript:alert(1)</script>", required=true)
    val scriptX20JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x2Bjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x2Bjavascript:alert(1)</script>", required=true)
    val scriptX2BjavascriptAlert1Script: String,

    @get:JsonProperty("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>", required=true)@field:JsonProperty("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>", required=true)
    val scriptX2FtypeTextJavascriptJavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\x7Ejavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\x7Ejavascript:alert(1)</script>", required=true)
    val scriptX7EjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>", required=true)
    val scriptXE2X80X80JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>", required=true)
    val scriptXE2X80X82JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>", required=true)
    val scriptXE2X80X83JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>", required=true)
    val scriptXE2X80X84JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>", required=true)
    val scriptXE2X80X88JavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>", required=true)
    val scriptXE2X80X8BjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>", required=true)
    val scriptXEFXBFXAEjavascriptAlert1Script: String,

    @get:JsonProperty("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>", required=true)@field:JsonProperty("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>", required=true)
    val scriptXEFXBFXBEjavascriptAlert1Script: String,

    @get:JsonProperty("Scunthorpe General Hospital", required=true)@field:JsonProperty("Scunthorpe General Hospital", required=true)
    val scunthorpeGeneralHospital: String,

    @get:JsonProperty("#\tServer Code Injection", required=true)@field:JsonProperty("#\tServer Code Injection", required=true)
    val serverCodeInjection: String,

    @get:JsonProperty("shitake mushrooms", required=true)@field:JsonProperty("shitake mushrooms", required=true)
    val shitakeMushrooms: String,

    @get:JsonProperty("#\tSpecial Characters", required=true)@field:JsonProperty("#\tSpecial Characters", required=true)
    val specialCharacters: String,

    @get:JsonProperty("src=JaVaSCript:prompt(132)", required=true)@field:JsonProperty("src=JaVaSCript:prompt(132)", required=true)
    val srcJaVaSCriptPrompt132: String,

    @get:JsonProperty("-", required=true)@field:JsonProperty("-", required=true)
    val sticky: String,

    @get:JsonProperty("#\tStrings which can be interpreted as numeric", required=true)@field:JsonProperty("#\tStrings which can be interpreted as numeric", required=true)
    val stringsWhichCanBeInterpretedAsNumeric: String,

    @get:JsonProperty("#\tStrings which can cause a SQL injection if inputs are not sanitized", required=true)@field:JsonProperty("#\tStrings which can cause a SQL injection if inputs are not sanitized", required=true)
    val stringsWhichCanCauseASQLInjectionIfInputsAreNotSanitized: String,

    @get:JsonProperty("#\tStrings which can cause user to pull in files that should not be a part of a web server", required=true)@field:JsonProperty("#\tStrings which can cause user to pull in files that should not be a part of a web server", required=true)
    val stringsWhichCanCauseUserToPullInFilesThatShouldNotBeAPartOfAWebServer: String,

    @get:JsonProperty("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)", required=true)@field:JsonProperty("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)", required=true)
    val stringsWhichCanCauseUserToRunCodeOnServerAsAPrivilegedUserCFHTTPSNewsYcombinatorCOMItemID7665153: String,

    @get:JsonProperty("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)", required=true)@field:JsonProperty("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)", required=true)
    val stringsWhichContainCorruptedTextTheCorruptionWillNotAppearInNonHTMLTextHoweverViaHTTPWWWEeemoNet: String,

    @get:JsonProperty("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)", required=true)@field:JsonProperty("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)", required=true)
    val stringsWhichContainUnicodeWithAnUpsidedownEffectViaHTTPWWWUpsidedowntextCOM: String,

    @get:JsonProperty("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)", required=true)@field:JsonProperty("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)", required=true)
    val stringsWhichContainUnicodeWithUnusualPropertiesEGRightToLeftOverrideCFHTTPWWWUnicodeOrgChartsPDFU2000PDF: String,

    @get:JsonProperty("#\tStrings which punish the fools who use cat/type on this file", required=true)@field:JsonProperty("#\tStrings which punish the fools who use cat/type on this file", required=true)
    val stringsWhichPunishTheFoolsWhoUseCatTypeOnThisFile: String,

    @get:JsonProperty("<svg><script>123<1>alert(123)</script>", required=true)@field:JsonProperty("<svg><script>123<1>alert(123)</script>", required=true)
    val svgScript1231Alert123Script: String,

    @get:JsonProperty("System(\"ls -al /\")", required=true)@field:JsonProperty("System(\"ls -al /\")", required=true)
    val systemLsAl: String,

    @get:JsonProperty("@{[system \"touch /tmp/blns.fail\"]}", required=true)@field:JsonProperty("@{[system \"touch /tmp/blns.fail\"]}", required=true)
    val systemTouchTmpBlnsFail: String,

    @get:JsonProperty("''", required=true)@field:JsonProperty("''", required=true)
    val tentacled: String,

    @get:JsonProperty("\u2029test\u2029", required=true)@field:JsonProperty("\u2029test\u2029", required=true)
    val test: String,

    @get:JsonProperty("test\u2060test\u202b", required=true)@field:JsonProperty("test\u2060test\u202b", required=true)
    val testTest: String,

    @get:JsonProperty("\ud83c\udff30\ud83c\udf08️", required=true)@field:JsonProperty("\ud83c\udff30\ud83c\udf08️", required=true)
    val the0: String,

    @get:JsonProperty("+0.0", required=true)@field:JsonProperty("+0.0", required=true)
    val the00: String,

    @get:JsonProperty("0.0.0", required=true)@field:JsonProperty("0.0.0", required=true)
    val the000: String,

    @get:JsonProperty("0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \ud83d\udd1f", required=true)@field:JsonProperty("0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \ud83d\udd1f", required=true)
    val the0123456789: String,

    @get:JsonProperty("() { 0; }; touch /tmp/blns.shellshock1.fail;", required=true)@field:JsonProperty("() { 0; }; touch /tmp/blns.shellshock1.fail;", required=true)
    val the0TouchTmpBlnsShellshock1Fail: String,

    @get:JsonProperty("0xabad1dea", required=true)@field:JsonProperty("0xabad1dea", required=true)
    val the0Xabad1Dea: String,

    @get:JsonProperty("0xffffffff", required=true)@field:JsonProperty("0xffffffff", required=true)
    val the0Xffffffff: String,

    @get:JsonProperty("--1", required=true)@field:JsonProperty("--1", required=true)
    val the1: String,

    @get:JsonProperty("-\$1.00", required=true)@field:JsonProperty("-\$1.00", required=true)
    val the100: String,

    @get:JsonProperty("1 000,00", required=true)@field:JsonProperty("1 000,00", required=true)
    val the100000: String,

    @get:JsonProperty("1'000'000,00", required=true)@field:JsonProperty("1'000'000,00", required=true)
    val the100000000: String,

    @get:JsonProperty("-1/2", required=true)@field:JsonProperty("-1/2", required=true)
    val the12: String,

    @get:JsonProperty("-1E+02", required=true)@field:JsonProperty("-1E+02", required=true)
    val the1E02: String,

    @get:JsonProperty("-1E2", required=true)@field:JsonProperty("-1E2", required=true)
    val the1E2: String,

    @get:JsonProperty("-1#IND", required=true)@field:JsonProperty("-1#IND", required=true)
    val the1Ind: String,

    @get:JsonProperty("\ud835\ude83\ud835\ude91\ud835\ude8e \ud835\ude9a\ud835\ude9e\ud835\ude92\ud835\ude8c\ud835\ude94 \ud835\ude8b\ud835\ude9b\ud835\ude98\ud835\udea0\ud835\ude97 \ud835\ude8f\ud835\ude98\ud835\udea1 \ud835\ude93\ud835\ude9e\ud835\ude96\ud835\ude99\ud835\ude9c \ud835\ude98\ud835\ude9f\ud835\ude8e\ud835\ude9b \ud835\ude9d\ud835\ude91\ud835\ude8e \ud835\ude95\ud835\ude8a\ud835\udea3\ud835\udea2 \ud835\ude8d\ud835\ude98\ud835\ude90", required=true)@field:JsonProperty("\ud835\ude83\ud835\ude91\ud835\ude8e \ud835\ude9a\ud835\ude9e\ud835\ude92\ud835\ude8c\ud835\ude94 \ud835\ude8b\ud835\ude9b\ud835\ude98\ud835\udea0\ud835\ude97 \ud835\ude8f\ud835\ude98\ud835\udea1 \ud835\ude93\ud835\ude9e\ud835\ude96\ud835\ude99\ud835\ude9c \ud835\ude98\ud835\ude9f\ud835\ude8e\ud835\ude9b \ud835\ude9d\ud835\ude91\ud835\ude8e \ud835\ude95\ud835\ude8a\ud835\udea3\ud835\udea2 \ud835\ude8d\ud835\ude98\ud835\ude90", required=true)
    val the2: String,

    @get:JsonProperty("\ud83d\udc35 \ud83d\ude48 \ud83d\ude49 \ud83d\ude4a", required=true)@field:JsonProperty("\ud83d\udc35 \ud83d\ude48 \ud83d\ude49 \ud83d\ude4a", required=true)
    val the3: String,

    @get:JsonProperty("\ud83d\udc7e \ud83d\ude47 \ud83d\udc81 \ud83d\ude45 \ud83d\ude46 \ud83d\ude4b \ud83d\ude4e \ud83d\ude4d", required=true)@field:JsonProperty("\ud83d\udc7e \ud83d\ude47 \ud83d\udc81 \ud83d\ude45 \ud83d\ude46 \ud83d\ude4b \ud83d\ude4e \ud83d\ude4d", required=true)
    val the4: String,

    @get:JsonProperty("-9223372036854775808/-1", required=true)@field:JsonProperty("-9223372036854775808/-1", required=true)
    val the92233720368547758081: String,

    @get:JsonProperty("١٢٣", required=true)@field:JsonProperty("١٢٣", required=true)
    val the١٢٣: String,

    @get:JsonProperty("<title onpropertychange=javascript:alert(1)></title><title title=>", required=true)@field:JsonProperty("<title onpropertychange=javascript:alert(1)></title><title title=>", required=true)
    val titleOnpropertychangeJavascriptAlert1TitleTitleTitle: String,

    @get:JsonProperty("# treated as whitespace in some contexts.", required=true)@field:JsonProperty("# treated as whitespace in some contexts.", required=true)
    val treatedAsWhitespaceInSomeContexts: String,

    @get:JsonProperty("#\tTrick Unicode", required=true)@field:JsonProperty("#\tTrick Unicode", required=true)
    val trickUnicode: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undefined: String,

    @get:JsonProperty("# Unicode additional control characters: all of the characters with", required=true)@field:JsonProperty("# Unicode additional control characters: all of the characters with", required=true)
    val unicodeAdditionalControlCharactersAllOfTheCharactersWith: String,

    @get:JsonProperty("#\tUnicode Subscript/Superscript/Accents", required=true)@field:JsonProperty("#\tUnicode Subscript/Superscript/Accents", required=true)
    val unicodeSubscriptSuperscriptAccents: String,

    @get:JsonProperty("#\tUnicode Upsidedown", required=true)@field:JsonProperty("#\tUnicode Upsidedown", required=true)
    val unicodeUpsidedown: String,

    @get:JsonProperty("\$USER", required=true)@field:JsonProperty("\$USER", required=true)
    val user: String,

    @get:JsonProperty("--version", required=true)@field:JsonProperty("--version", required=true)
    val version: String,

    @get:JsonProperty("# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),", required=true)@field:JsonProperty("# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),", required=true)
    val version800PlusU0009HTU000BVTU000CFFU0085NEL: String,

    @get:JsonProperty("# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode", required=true)@field:JsonProperty("# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode", required=true)
    val whitespaceAllOfTheCharactersWithCategoryZsZlOrZpInUnicode: String,

    @get:JsonProperty("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>", required=true)@field:JsonProperty("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>", required=true)
    val xmlVersion10EncodingISO88591DOCTYPEFooELEMENTFooANYENTITYXxeSYSTEMFileEtcPasswdFooXxeFoo: String,

    @get:JsonProperty("#      XXE Injection (XML)", required=true)@field:JsonProperty("#      XXE Injection (XML)", required=true)
    val xxeInjectionXML: String,

    @get:JsonProperty("#\tZalgo Text", required=true)@field:JsonProperty("#\tZalgo Text", required=true)
    val zalgoText: String,

    @get:JsonProperty("ZZ:", required=true)@field:JsonProperty("ZZ:", required=true)
    val zz: String,

    @get:JsonProperty("ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃", required=true)@field:JsonProperty("ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃", required=true)
    val åíîïÓôÒúæ: String,

    @get:JsonProperty(",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’", required=true)@field:JsonProperty(",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’", required=true)
    val ω: String,

    @get:JsonProperty("ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя", required=true)@field:JsonProperty("ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя", required=true)
    val ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэюЯабвгдежзийклмнопрстуфхцчшщъыьэюя: String,

    @get:JsonProperty("בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ", required=true)@field:JsonProperty("בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ", required=true)
    val בראשיתבראאלהיםאתהשמיםואתהארץ: String,

    @get:JsonProperty("مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ", required=true)@field:JsonProperty("مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ", required=true)
    val مناقشةسبلاستخداماللغةفيالنظمالقائمةوفيميخصالتطبيقاتالحاسوبية: String,

    @get:JsonProperty("̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟", required=true)@field:JsonProperty("̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟", required=true)
    val ṯHENEZPERDIANHIVḘMINḌǪFCḤAƠSZALGO: String,

    @get:JsonProperty("┬─┬ノ( º _ ºノ)", required=true)@field:JsonProperty("┬─┬ノ( º _ ºノ)", required=true)
    val ノº_ºノ: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val 울란바토르: String,

    @get:JsonProperty("Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ", required=true)@field:JsonProperty("Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ", required=true)
    val ｔｈｅＱｕｉｃｋＢｒｏｗｎＦｏｘＪｕｍｐｓＯｖｅｒＴｈｅＬａｚｙＤｏｇ: String,

    @get:JsonProperty("(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻", required=true)@field:JsonProperty("(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻", required=true)
    val ﾉಥ益ಥﾉ: String
)
