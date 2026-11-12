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


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
            override fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(JurorElement::class,            { JurorElement.fromJson(it) },            { it.toJson() }, true)
    convert(Kongoni::class,                 { Kongoni.fromJson(it) },                 { it.toJson() }, true)
    convert(LadronismElement::class,        { LadronismElement.fromJson(it) },        { it.toJson() }, true)
    convert(LandlubberlyElement::class,     { LandlubberlyElement.fromJson(it) },     { it.toJson() }, true)
    convert(Listener::class,                { Listener.fromJson(it) },                { it.toJson() }, true)
    convert(LupusElement::class,            { LupusElement.fromJson(it) },            { it.toJson() }, true)
    convert(MonaziteElement::class,         { MonaziteElement.fromJson(it) },         { it.toJson() }, true)
    convert(Monoliteral::class,             { Monoliteral.fromJson(it) },             { it.toJson() }, true)
    convert(MonotheisticallyElement::class, { MonotheisticallyElement.fromJson(it) }, { it.toJson() }, true)
    convert(Montage::class,                 { Montage.fromJson(it) },                 { it.toJson() }, true)
    convert(Moralness::class,               { Moralness.fromJson(it) },               { it.toJson() }, true)
    convert(Mulishly::class,                { Mulishly.fromJson(it) },                { it.toJson() }, true)
    convert(Myoscope::class,                { Myoscope.fromJson(it) },                { it.toJson() }, true)
    convert(Neuromastic::class,             { Neuromastic.fromJson(it) },             { it.toJson() }, true)
    convert(Nonnervous::class,              { Nonnervous.fromJson(it) },              { it.toJson() }, true)
    convert(Nonvaluation::class,            { Nonvaluation.fromJson(it) },            { it.toJson() }, true)
    convert(OccupationalistElement::class,  { OccupationalistElement.fromJson(it) },  { it.toJson() }, true)
    convert(OutrivalElement::class,         { OutrivalElement.fromJson(it) },         { it.toJson() }, true)
    convert(Paleographically::class,        { Paleographically.fromJson(it) },        { it.toJson() }, true)
    convert(Pamphletwise::class,            { Pamphletwise.fromJson(it) },            { it.toJson() }, true)
    convert(Pediatric::class,               { Pediatric.fromJson(it) },               { it.toJson() }, true)
    convert(PiaculumElement::class,         { PiaculumElement.fromJson(it) },         { it.toJson() }, true)
    convert(Piccadilly::class,              { Piccadilly.fromJson(it) },              { it.toJson() }, true)
    convert(Piffler::class,                 { Piffler.fromJson(it) },                 { it.toJson() }, true)
    convert(Pithful::class,                 { Pithful.fromJson(it) },                 { it.toJson() }, true)
    convert(Placuntiti::class,              { Placuntiti.fromJson(it) },              { it.toJson() }, true)
    convert(Plectopterous::class,           { Plectopterous.fromJson(it) },           { it.toJson() }, true)
    convert(Poliorcetic::class,             { Poliorcetic.fromJson(it) },             { it.toJson() }, true)
    convert(Poormaster::class,              { Poormaster.fromJson(it) },              { it.toJson() }, true)
    convert(PotwhiskyElement::class,        { PotwhiskyElement.fromJson(it) },        { it.toJson() }, true)
    convert(Practicalizer::class,           { Practicalizer.fromJson(it) },           { it.toJson() }, true)
    convert(PrefreshmanElement::class,      { PrefreshmanElement.fromJson(it) },      { it.toJson() }, true)
    convert(Prehensility::class,            { Prehensility.fromJson(it) },            { it.toJson() }, true)
    convert(Prevoidance::class,             { Prevoidance.fromJson(it) },             { it.toJson() }, true)
    convert(Protext::class,                 { Protext.fromJson(it) },                 { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val juror: List<JurorElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kongoni: List<Kongoni>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ladronism: List<LadronismElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val landlubberly: List<LandlubberlyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val listener: List<Listener>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lupus: List<LupusElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maslin: List<Maslin>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monazite: List<MonaziteElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monoliteral: List<Monoliteral>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monotheistically: List<MonotheisticallyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val montage: List<Montage>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val moralness: List<Moralness>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mowra: List<MonaziteClass?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mulishly: List<Mulishly>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val myoscope: List<Myoscope>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nach: List<List<Long?>?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val neuromastic: List<Neuromastic>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noncontributing: List<Noncontributing>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonnervous: List<Nonnervous>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonvaluation: List<Nonvaluation>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val occupationalist: List<OccupationalistElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val outrival: List<OutrivalElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val paleographically: List<Paleographically>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pamphletwise: List<Pamphletwise>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pediatrics: List<Pediatric>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val perceptive: List<Boolean>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val piaculum: List<PiaculumElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val piccadilly: List<Piccadilly>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val piffler: List<Piffler>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pithful: List<Pithful>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val placuntitis: List<Placuntiti>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val plectopterous: List<Plectopterous>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pneumocele: List<Pneumocele?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val poliorcetic: List<Poliorcetic>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val poormaster: List<Poormaster>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val potwhisky: List<PotwhiskyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val practicalizer: List<Practicalizer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prefreshman: List<PrefreshmanElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prehensility: List<Prehensility>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prevoidance: List<Prevoidance>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val probant: List<Map<String, Long?>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protext: List<Protext>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class JurorElement {
    class BoolValue(val value: Boolean)          : JurorElement()
    class JurorClassValue(val value: JurorClass) : JurorElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is JurorClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): JurorElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> JurorClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class JurorClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val adipsy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val auxiliator: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val benda: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val benjamin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brandling: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val epicurishly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val eremochaetous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val marten: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monocline: Any? = null,

    @get:JsonProperty("Olea", required=true)@field:JsonProperty("Olea", required=true)
    val olea: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val palgat: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pennyworth: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pioury: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pragmatistic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stylelessness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val systematical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thready: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uncontemporary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uncouched: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uninhabitedness: Any? = null
)

sealed class Kongoni {
    class IntegerArrayValue(val value: List<Long>)      : Kongoni()
    class IntegerMapValue(val value: Map<String, Long>) : Kongoni()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Kongoni = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class LadronismElement {
    class DoubleValue(val value: Double)                 : LadronismElement()
    class LadronismClassValue(val value: LadronismClass) : LadronismElement()
    class StringValue(val value: String)                 : LadronismElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue         -> this.value
        is LadronismClassValue -> this.value
        is StringValue         -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): LadronismElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> LadronismClassValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class LadronismClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val acclaimer: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val achree: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val base: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val conundrumize: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val degerminator: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val describable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val exasperatedly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val heroine: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indazin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val luteous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val papular: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pritch: Any? = null,

    @get:JsonProperty("Prodenia", required=true)@field:JsonProperty("Prodenia", required=true)
    val prodenia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val seege: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shopgirl: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tragedietta: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsparse: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uplook: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vermiformis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val whafabout: Any? = null
)

sealed class LandlubberlyElement {
    class BoolValue(val value: Boolean)                        : LandlubberlyElement()
    class IntegerValue(val value: Long)                        : LandlubberlyElement()
    class LandlubberlyClassValue(val value: LandlubberlyClass) : LandlubberlyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue              -> this.value
        is IntegerValue           -> this.value
        is LandlubberlyClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): LandlubberlyElement = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> LandlubberlyClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class LandlubberlyClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val acropoleis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aminate: Any? = null,

    @get:JsonProperty("Amyraldism", required=true)@field:JsonProperty("Amyraldism", required=true)
    val amyraldism: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bipenniform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bugre: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val calycule: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val caoutchouc: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disprover: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fitroot: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fulgently: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kickup: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val laevoversion: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val moter: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val objectivity: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val posterity: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val postnuptial: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val precedentary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saddling: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subcurrent: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unrecriminative: Any? = null
)

sealed class Listener {
    class IntegerValue(val value: Long)         : Listener()
    class NullArrayValue(val value: List<Any?>) : Listener()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue   -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Listener = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class LupusElement {
    class IntegerValue(val value: Long)          : LupusElement()
    class LupusClassValue(val value: LupusClass) : LupusElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue    -> this.value
        is LupusClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): LupusElement = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> LupusClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class LupusClass (
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    @get:JsonProperty("Chlorioninae")@field:JsonProperty("Chlorioninae")
    val chlorioninae: Long? = null,

    @get:JsonProperty("Corvinae")@field:JsonProperty("Corvinae")
    val corvinae: Long? = null,

    @get:JsonProperty("Crassina")@field:JsonProperty("Crassina")
    val crassina: Long? = null,

    val disdiapason: String? = null,
    val exiguity: Long? = null,
    val farcist: Long? = null,
    val holographical: Long? = null,
    val homocerc: Boolean? = null,
    val ichthyophagan: Long? = null,
    val implacable: Long? = null,
    val nonbookish: Any? = null,
    val outshiner: Long? = null,
    val overweather: Long? = null,
    val protonegroid: Long? = null,
    val shallowish: Long? = null,
    val snoke: Long? = null,
    val snout: Long? = null,
    val surveillance: Long? = null,
    val threshingtime: Long? = null,

    @get:JsonProperty("Thysanocarpus")@field:JsonProperty("Thysanocarpus")
    val thysanocarpus: Long? = null,

    val unsignificantly: Long? = null,
    val unsnap: Long? = null,
    val vendible: Long? = null
)

data class Maslin (
    @get:JsonProperty("Alicant")@field:JsonProperty("Alicant")
    val alicant: Long? = null,

    val antiatonement: Any? = null,
    val anticorrosive: Long? = null,
    val aphidozer: Any? = null,

    @get:JsonProperty("Bakuninist")@field:JsonProperty("Bakuninist")
    val bakuninist: Any? = null,

    val be: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val chub: Long? = null,
    val cuprosilicon: Long? = null,
    val curtailedly: Long? = null,
    val dellenite: Long? = null,

    @get:JsonProperty("Dimitry")@field:JsonProperty("Dimitry")
    val dimitry: Long? = null,

    val disdiapason: String? = null,
    val edifying: Any? = null,
    val ethmoiditis: Long? = null,
    val gastralgy: Any? = null,
    val goatherd: Long? = null,
    val hammerdress: Long? = null,
    val hangfire: Any? = null,
    val homocerc: Boolean? = null,
    val lacunosity: Long? = null,
    val longiloquence: Any? = null,
    val mameliere: Long? = null,
    val motherless: Any? = null,
    val nonbookish: Any? = null,
    val noncorrodible: Any? = null,
    val nonsensicality: Any? = null,
    val oafishly: Long? = null,
    val pfund: Any? = null,
    val preadvisory: Any? = null,
    val retroflexed: Any? = null,
    val saccharulmic: Long? = null,
    val scowlful: Long? = null,
    val secluded: Any? = null,
    val slackage: Any? = null,
    val sphaeridial: Long? = null,
    val spondulics: Any? = null,
    val subsecive: Long? = null,
    val swellmobsman: Any? = null,
    val trachyglossate: Long? = null,
    val trialogue: Any? = null,
    val unassuaged: Long? = null,
    val ungross: Any? = null,
    val unjudiciously: Any? = null
)

sealed class MonaziteElement {
    class DoubleValue(val value: Double)               : MonaziteElement()
    class MonaziteClassValue(val value: MonaziteClass) : MonaziteElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue        -> this.value
        is MonaziteClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): MonaziteElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> MonaziteClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class MonaziteClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val catharticalness: Double,

    @get:JsonProperty("Chirotherium", required=true)@field:JsonProperty("Chirotherium", required=true)
    val chirotherium: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disdiapason: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val homocerc: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonbookish: Any? = null
)

sealed class Monoliteral {
    class BoolValue(val value: Boolean)         : Monoliteral()
    class NullArrayValue(val value: List<Any?>) : Monoliteral()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue      -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Monoliteral = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class MonotheisticallyElement {
    class MonotheisticallyClassValue(val value: MonotheisticallyClass) : MonotheisticallyElement()
    class NullArrayValue(val value: List<Any?>)                        : MonotheisticallyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is MonotheisticallyClassValue -> this.value
        is NullArrayValue             -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): MonotheisticallyElement = when (jn) {
            is ObjectNode -> MonotheisticallyClassValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class MonotheisticallyClass (
    val blaspheme: Any? = null,
    val catharticalness: Double? = null,
    val celiosalpingectomy: Any? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val consummativeness: Any? = null,
    val disdiapason: String? = null,
    val egestive: Any? = null,
    val enchylema: Any? = null,
    val gasconade: Any? = null,
    val holidayer: Any? = null,
    val homocerc: Boolean? = null,
    val intuitionalism: Any? = null,
    val lophiostomate: Any? = null,
    val nonbookish: Any? = null,
    val nonvolition: Any? = null,
    val palatableness: Any? = null,
    val pimpery: Any? = null,
    val previolation: Any? = null,
    val reconveyance: Any? = null,
    val registership: Any? = null,
    val rhyacolite: Any? = null,
    val smithereens: Any? = null,
    val superedification: Any? = null,
    val trust: Any? = null,
    val whitestone: Any? = null
)

sealed class Montage {
    class DoubleValue(val value: Double)        : Montage()
    class NullArrayValue(val value: List<Any?>) : Montage()
    class StringValue(val value: String)        : Montage()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue    -> this.value
        is NullArrayValue -> this.value
        is StringValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Montage = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Moralness {
    class DoubleValue(val value: Double)        : Moralness()
    class NullArrayValue(val value: List<Any?>) : Moralness()
    class NullValue()                           : Moralness()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue    -> this.value
        is NullArrayValue -> this.value
        is NullValue      -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Moralness = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Mulishly {
    class DoubleValue(val value: Double)           : Mulishly()
    class IntegerArrayValue(val value: List<Long>) : Mulishly()
    class NullValue()                              : Mulishly()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Mulishly = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Myoscope {
    class BoolValue(val value: Boolean)         : Myoscope()
    class IntegerValue(val value: Long)         : Myoscope()
    class NullArrayValue(val value: List<Any?>) : Myoscope()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue      -> this.value
        is IntegerValue   -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Myoscope = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Neuromastic {
    class DoubleValue(val value: Double)        : Neuromastic()
    class NullArrayValue(val value: List<Any?>) : Neuromastic()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue    -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Neuromastic = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class Noncontributing (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val estevin: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jolterhead: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sauternes: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sparsely: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unrequested: Any? = null
)

sealed class Nonnervous {
    class BoolValue(val value: Boolean) : Nonnervous()
    class IntegerValue(val value: Long) : Nonnervous()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Nonnervous = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Nonvaluation {
    class BoolValue(val value: Boolean)         : Nonvaluation()
    class DoubleValue(val value: Double)        : Nonvaluation()
    class NullArrayValue(val value: List<Any?>) : Nonvaluation()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue      -> this.value
        is DoubleValue    -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Nonvaluation = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class OccupationalistElement {
    class NullArrayValue(val value: List<Any?>)                      : OccupationalistElement()
    class OccupationalistClassValue(val value: OccupationalistClass) : OccupationalistElement()
    class NullValue()                                                : OccupationalistElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue            -> this.value
        is OccupationalistClassValue -> this.value
        is NullValue                 -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): OccupationalistElement = when (jn) {
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode -> OccupationalistClassValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

data class OccupationalistClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val beholdable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brotuliform: Any? = null,

    @get:JsonProperty("Chimakum", required=true)@field:JsonProperty("Chimakum", required=true)
    val chimakum: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val doodler: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val emulsin: Any? = null,

    @get:JsonProperty("Fin", required=true)@field:JsonProperty("Fin", required=true)
    val fin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flourishing: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flueless: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val furtively: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gritter: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val interwish: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monoxylic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val myristic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nightwear: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val peruser: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val theoastrological: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thumby: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tingitid: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val trailless: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unpocketed: Any? = null
)

sealed class OutrivalElement {
    class DoubleValue(val value: Double)               : OutrivalElement()
    class OutrivalClassValue(val value: OutrivalClass) : OutrivalElement()
    class NullValue()                                  : OutrivalElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue        -> this.value
        is OutrivalClassValue -> this.value
        is NullValue          -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): OutrivalElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> OutrivalClassValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class OutrivalClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val adroitly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bridehood: Any? = null,

    @get:JsonProperty("Castoroides", required=true)@field:JsonProperty("Castoroides", required=true)
    val castoroides: Any? = null,

    @get:JsonProperty("Czechoslovak", required=true)@field:JsonProperty("Czechoslovak", required=true)
    val czechoslovak: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val diagenesis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dihexahedron: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dopester: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val eumerism: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flyness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fouler: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val laudanosine: Any? = null,

    @get:JsonProperty("Lingulidae", required=true)@field:JsonProperty("Lingulidae", required=true)
    val lingulidae: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minutary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mitra: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val opisthorchiasis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pensively: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pubigerous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rebellious: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val recodify: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unpaced: Any? = null
)

sealed class Paleographically {
    class DoubleValue(val value: Double)               : Paleographically()
    class UnionMapValue(val value: Map<String, Long?>) : Paleographically()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue   -> this.value
        is UnionMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Paleographically = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> UnionMapValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Pamphletwise {
    class IntegerMapValue(val value: Map<String, Long>) : Pamphletwise()
    class IntegerValue(val value: Long)                 : Pamphletwise()
    class StringValue(val value: String)                : Pamphletwise()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is IntegerValue    -> this.value
        is StringValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Pamphletwise = when (jn) {
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Pediatric {
    class BoolValue(val value: Boolean)  : Pediatric()
    class DoubleValue(val value: Double) : Pediatric()
    class NullValue()                    : Pediatric()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is DoubleValue -> this.value
        is NullValue   -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Pediatric = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class PiaculumElement {
    class DoubleValue(val value: Double)               : PiaculumElement()
    class PiaculumClassValue(val value: PiaculumClass) : PiaculumElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue        -> this.value
        is PiaculumClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): PiaculumElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> PiaculumClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class PiaculumClass (
    val alada: Long? = null,
    val amphistomous: Long? = null,
    val boysenberry: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val decardinalize: Long? = null,
    val discouragement: Long? = null,
    val disdiapason: String? = null,
    val doitrified: Long? = null,
    val hexaspermous: Long? = null,
    val homocerc: Boolean? = null,
    val insinking: Long? = null,
    val loathfulness: Long? = null,
    val miasmatical: Long? = null,
    val neurofibril: Long? = null,
    val nonbookish: Any? = null,
    val phonendoscope: Long? = null,
    val pilferment: Long? = null,
    val predismissory: Long? = null,
    val preinscription: Long? = null,
    val quotative: Long? = null,
    val sienna: Long? = null,
    val thorax: Long? = null,
    val yachting: Long? = null,

    @get:JsonProperty("Zipper")@field:JsonProperty("Zipper")
    val zipper: Long? = null
)

sealed class Piccadilly {
    class DoubleValue(val value: Double) : Piccadilly()
    class StringValue(val value: String) : Piccadilly()
    class NullValue()                    : Piccadilly()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
        is NullValue   -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Piccadilly = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Piffler {
    class MonaziteClassValue(val value: MonaziteClass) : Piffler()
    class NullArrayValue(val value: List<Any?>)        : Piffler()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is MonaziteClassValue -> this.value
        is NullArrayValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Piffler = when (jn) {
            is ObjectNode -> MonaziteClassValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Pithful {
    class BoolValue(val value: Boolean) : Pithful()
    class IntegerValue(val value: Long) : Pithful()
    class NullValue()                   : Pithful()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is IntegerValue -> this.value
        is NullValue    -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Pithful = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Placuntiti {
    class IntegerMapValue(val value: Map<String, Long>) : Placuntiti()
    class IntegerValue(val value: Long)                 : Placuntiti()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is IntegerValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Placuntiti = when (jn) {
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Plectopterous {
    class DoubleValue(val value: Double)                : Plectopterous()
    class IntegerMapValue(val value: Map<String, Long>) : Plectopterous()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Plectopterous = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class Pneumocele (
    @get:JsonProperty("Carbonarism")@field:JsonProperty("Carbonarism")
    val carbonarism: Any? = null,

    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val cineolic: Any? = null,
    val cobbly: Any? = null,
    val conchyliferous: Any? = null,
    val congregation: Any? = null,
    val disdiapason: String? = null,
    val enterotomy: Any? = null,
    val entophytal: Any? = null,
    val fewtrils: Any? = null,
    val herem: Any? = null,
    val homocerc: Boolean? = null,

    @get:JsonProperty("Koniga")@field:JsonProperty("Koniga")
    val koniga: Any? = null,

    val meticulosity: Any? = null,

    @get:JsonProperty("Micky")@field:JsonProperty("Micky")
    val micky: Any? = null,

    val mismarriage: Any? = null,
    val neurotrophic: Any? = null,
    val nonbookish: Any? = null,
    val persuasively: Any? = null,
    val replaceable: Any? = null,
    val silex: Any? = null,
    val taillight: Any? = null,
    val unjealous: Any? = null,
    val visitorial: Any? = null
)

sealed class Poliorcetic {
    class BoolValue(val value: Boolean)                : Poliorcetic()
    class MonaziteClassValue(val value: MonaziteClass) : Poliorcetic()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue          -> this.value
        is MonaziteClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Poliorcetic = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> MonaziteClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Poormaster {
    class IntegerArrayValue(val value: List<Long>)      : Poormaster()
    class IntegerMapValue(val value: Map<String, Long>) : Poormaster()
    class NullValue()                                   : Poormaster()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Poormaster = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class PotwhiskyElement {
    class IntegerValue(val value: Long)                  : PotwhiskyElement()
    class PotwhiskyClassValue(val value: PotwhiskyClass) : PotwhiskyElement()
    class NullValue()                                    : PotwhiskyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue        -> this.value
        is PotwhiskyClassValue -> this.value
        is NullValue           -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): PotwhiskyElement = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> PotwhiskyClassValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class PotwhiskyClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val arciform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cresolin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disheartener: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disproportionable: Any? = null,

    @get:JsonProperty("Euchorda", required=true)@field:JsonProperty("Euchorda", required=true)
    val euchorda: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ferryway: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val filamentiferous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flemish: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val forgainst: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val grainering: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val irrevoluble: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindredship: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pinguitudinous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val simpletonic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val singsong: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val submergement: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val supraoesophagal: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thrashel: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tyremesis: Any? = null,

    @get:JsonProperty("Yoruba", required=true)@field:JsonProperty("Yoruba", required=true)
    val yoruba: Any? = null
)

sealed class Practicalizer {
    class MonaziteClassValue(val value: MonaziteClass) : Practicalizer()
    class NullArrayValue(val value: List<Any?>)        : Practicalizer()
    class StringValue(val value: String)               : Practicalizer()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is MonaziteClassValue -> this.value
        is NullArrayValue     -> this.value
        is StringValue        -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Practicalizer = when (jn) {
            is ObjectNode -> MonaziteClassValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class PrefreshmanElement {
    class NullArrayValue(val value: List<Any?>)              : PrefreshmanElement()
    class PrefreshmanClassValue(val value: PrefreshmanClass) : PrefreshmanElement()
    class StringValue(val value: String)                     : PrefreshmanElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue        -> this.value
        is PrefreshmanClassValue -> this.value
        is StringValue           -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): PrefreshmanElement = when (jn) {
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode -> PrefreshmanClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class PrefreshmanClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val azorubine: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val choroiditis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coagulatory: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cyclorama: Any? = null,

    @get:JsonProperty("Dolphus", required=true)@field:JsonProperty("Dolphus", required=true)
    val dolphus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val duckhearted: Any? = null,

    @get:JsonProperty("Ficus", required=true)@field:JsonProperty("Ficus", required=true)
    val ficus: Any? = null,

    @get:JsonProperty("Gemaric", required=true)@field:JsonProperty("Gemaric", required=true)
    val gemaric: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jugation: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val myoliposis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonnomination: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val palay: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pentactinal: Any? = null,

    @get:JsonProperty("Phaet", required=true)@field:JsonProperty("Phaet", required=true)
    val phaet: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val piquant: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val registration: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val remancipation: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scutatiform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val theodolite: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val underward: Any? = null
)

sealed class Prehensility {
    class BoolValue(val value: Boolean)                : Prehensility()
    class MonaziteClassValue(val value: MonaziteClass) : Prehensility()
    class NullArrayValue(val value: List<Any?>)        : Prehensility()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue          -> this.value
        is MonaziteClassValue -> this.value
        is NullArrayValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Prehensility = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> MonaziteClassValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Prevoidance {
    class IntegerArrayValue(val value: List<Long>)     : Prevoidance()
    class IntegerValue(val value: Long)                : Prevoidance()
    class MonaziteClassValue(val value: MonaziteClass) : Prevoidance()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue  -> this.value
        is IntegerValue       -> this.value
        is MonaziteClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Prevoidance = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> MonaziteClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Protext {
    class BoolValue(val value: Boolean)                : Protext()
    class IntegerArrayValue(val value: List<Long>)     : Protext()
    class MonaziteClassValue(val value: MonaziteClass) : Protext()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue          -> this.value
        is IntegerArrayValue  -> this.value
        is MonaziteClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Protext = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode  -> MonaziteClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}
