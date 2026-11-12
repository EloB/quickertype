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
    convert(Protrusive::class,           { Protrusive.fromJson(it) },           { it.toJson() }, true)
    convert(PulpitismElement::class,     { PulpitismElement.fromJson(it) },     { it.toJson() }, true)
    convert(PyodermiaElement::class,     { PyodermiaElement.fromJson(it) },     { it.toJson() }, true)
    convert(QuebrachineElement::class,   { QuebrachineElement.fromJson(it) },   { it.toJson() }, true)
    convert(Querier::class,              { Querier.fromJson(it) },              { it.toJson() }, true)
    convert(Rebarbative::class,          { Rebarbative.fromJson(it) },          { it.toJson() }, true)
    convert(Retrocervical::class,        { Retrocervical.fromJson(it) },        { it.toJson() }, true)
    convert(Revert::class,               { Revert.fromJson(it) },               { it.toJson() }, true)
    convert(RewriteElement::class,       { RewriteElement.fromJson(it) },       { it.toJson() }, true)
    convert(Saccoderm::class,            { Saccoderm.fromJson(it) },            { it.toJson() }, true)
    convert(SantirElement::class,        { SantirElement.fromJson(it) },        { it.toJson() }, true)
    convert(Saprophilous::class,         { Saprophilous.fromJson(it) },         { it.toJson() }, true)
    convert(SaxtenElement::class,        { SaxtenElement.fromJson(it) },        { it.toJson() }, true)
    convert(Scoffer::class,              { Scoffer.fromJson(it) },              { it.toJson() }, true)
    convert(Scrampum::class,             { Scrampum.fromJson(it) },             { it.toJson() }, true)
    convert(Serpentinic::class,          { Serpentinic.fromJson(it) },          { it.toJson() }, true)
    convert(Shadowable::class,           { Shadowable.fromJson(it) },           { it.toJson() }, true)
    convert(SisteringElement::class,     { SisteringElement.fromJson(it) },     { it.toJson() }, true)
    convert(Stagmometer::class,          { Stagmometer.fromJson(it) },          { it.toJson() }, true)
    convert(Stimulability::class,        { Stimulability.fromJson(it) },        { it.toJson() }, true)
    convert(Strangleable::class,         { Strangleable.fromJson(it) },         { it.toJson() }, true)
    convert(StrenuosityElement::class,   { StrenuosityElement.fromJson(it) },   { it.toJson() }, true)
    convert(Tabaxir::class,              { Tabaxir.fromJson(it) },              { it.toJson() }, true)
    convert(Talpiform::class,            { Talpiform.fromJson(it) },            { it.toJson() }, true)
    convert(Thwack::class,               { Thwack.fromJson(it) },               { it.toJson() }, true)
    convert(Tortricine::class,           { Tortricine.fromJson(it) },           { it.toJson() }, true)
    convert(TruantcyElement::class,      { TruantcyElement.fromJson(it) },      { it.toJson() }, true)
    convert(Unbeginning::class,          { Unbeginning.fromJson(it) },          { it.toJson() }, true)
    convert(Undesirability::class,       { Undesirability.fromJson(it) },       { it.toJson() }, true)
    convert(Unerasing::class,            { Unerasing.fromJson(it) },            { it.toJson() }, true)
    convert(Unguentarium::class,         { Unguentarium.fromJson(it) },         { it.toJson() }, true)
    convert(UnimpeachablyElement::class, { UnimpeachablyElement.fromJson(it) }, { it.toJson() }, true)
    convert(Unmortgaged::class,          { Unmortgaged.fromJson(it) },          { it.toJson() }, true)
    convert(Unobstructed::class,         { Unobstructed.fromJson(it) },         { it.toJson() }, true)
    convert(Unreceptivity::class,        { Unreceptivity.fromJson(it) },        { it.toJson() }, true)
    convert(Unsatisfactoriness::class,   { Unsatisfactoriness.fromJson(it) },   { it.toJson() }, true)
    convert(UnstressedElement::class,    { UnstressedElement.fromJson(it) },    { it.toJson() }, true)
    convert(Untasked::class,             { Untasked.fromJson(it) },             { it.toJson() }, true)
    convert(Unvarying::class,            { Unvarying.fromJson(it) },            { it.toJson() }, true)
    convert(Vehemently::class,           { Vehemently.fromJson(it) },           { it.toJson() }, true)
    convert(Whitepot::class,             { Whitepot.fromJson(it) },             { it.toJson() }, true)
    convert(WrothyElement::class,        { WrothyElement.fromJson(it) },        { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protrusive: List<Protrusive>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pulpitism: List<PulpitismElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pyodermia: List<PyodermiaElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quebrachine: List<QuebrachineElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val querier: List<Querier>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rebarbative: List<Rebarbative>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reimagine: List<Reimagine>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ressaut: Ressaut,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val retrocervical: List<Retrocervical>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val revert: List<Revert>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rewrite: List<RewriteElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saccoderm: List<Saccoderm>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val santir: List<SantirElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saprophilous: List<Saprophilous>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saxten: List<SaxtenElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scatty: List<Scatty?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scoffer: List<Scoffer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scrampum: List<Scrampum>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val semantic: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val serpentinic: List<Serpentinic>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shadowable: List<Shadowable>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sistering: List<SisteringElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val staghunting: List<Staghunting>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stagmometer: List<Stagmometer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stimulability: List<Stimulability>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val strangleable: List<Strangleable>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val strenuosity: List<StrenuosityElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tabaxir: List<Tabaxir>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val talpiform: List<Talpiform>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thwack: List<Thwack>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val to: List<Double?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tortricine: List<Tortricine>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val truantcy: List<TruantcyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val turgesce: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unbeginning: List<Unbeginning>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val underdunged: List<Double>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undesirability: List<Undesirability>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unerasing: List<Unerasing>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unguentarium: List<Unguentarium>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unimpeachably: List<UnimpeachablyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmortgaged: List<Unmortgaged>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unobstructed: List<Unobstructed>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unreceptivity: List<Unreceptivity>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsatisfactoriness: List<Unsatisfactoriness>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsecurity: List<Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unstressed: List<UnstressedElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val untasked: List<Untasked>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unvarying: List<Unvarying>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vehemently: List<Vehemently>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val warriorship: Map<String, Boolean>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val whitepot: List<Whitepot>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val wrothy: List<WrothyElement>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class Protrusive {
    class DoubleValue(val value: Double)          : Protrusive()
    class UnionArrayValue(val value: List<Long?>) : Protrusive()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is UnionArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Protrusive = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> UnionArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class PulpitismElement {
    class DoubleValue(val value: Double)                 : PulpitismElement()
    class IntegerArrayValue(val value: List<Long>)       : PulpitismElement()
    class PulpitismClassValue(val value: PulpitismClass) : PulpitismElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue         -> this.value
        is IntegerArrayValue   -> this.value
        is PulpitismClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): PulpitismElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode                          -> PulpitismClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class PulpitismClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val abnet: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val buckhorn: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val calciform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val chelophore: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cogitation: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decreeable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val despicable: Any? = null,

    @get:JsonProperty("isodiazo", required=true)@field:JsonProperty("isodiazo", required=true)
    val isodiazo: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jadedly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val leptochlorite: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nursling: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val palamedean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val photoheliograph: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pipewood: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val roberd: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val statable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val superassume: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val syllabe: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val toughhead: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val underburn: Any? = null
)

sealed class PyodermiaElement {
    class IntegerValue(val value: Long)                  : PyodermiaElement()
    class PyodermiaClassValue(val value: PyodermiaClass) : PyodermiaElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue        -> this.value
        is PyodermiaClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): PyodermiaElement = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> PyodermiaClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class PyodermiaClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aphoristically: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val apophyllous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cognize: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dermonosology: Any? = null,

    @get:JsonProperty("Gyppo", required=true)@field:JsonProperty("Gyppo", required=true)
    val gyppo: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ither: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val juglandaceous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val litho: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val macropterous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val photographer: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val romancing: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rumness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val somniloquist: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stressfully: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tactically: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tracheophony: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unappositely: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unclothedly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unimplied: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsyncopated: Any? = null
)

sealed class QuebrachineElement {
    class BoolValue(val value: Boolean)                      : QuebrachineElement()
    class QuebrachineClassValue(val value: QuebrachineClass) : QuebrachineElement()
    class NullValue()                                        : QuebrachineElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue             -> this.value
        is QuebrachineClassValue -> this.value
        is NullValue             -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): QuebrachineElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> QuebrachineClassValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

data class QuebrachineClass (
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

sealed class Querier {
    class BoolValue(val value: Boolean)                 : Querier()
    class IntegerMapValue(val value: Map<String, Long>) : Querier()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Querier = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> IntegerMapValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Rebarbative {
    class BoolValue(val value: Boolean)            : Rebarbative()
    class DoubleValue(val value: Double)           : Rebarbative()
    class IntegerArrayValue(val value: List<Long>) : Rebarbative()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Rebarbative = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class Reimagine (
    val adducible: Any? = null,
    val anabolin: Any? = null,
    val brainy: Any? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val chrysamine: Any? = null,
    val disdiapason: String? = null,
    val fluxweed: Any? = null,
    val glaucine: Any? = null,
    val grobianism: Any? = null,

    @get:JsonProperty("Hermo")@field:JsonProperty("Hermo")
    val hermo: Any? = null,

    val hieroglyphist: Any? = null,
    val homocerc: Boolean? = null,
    val icteroid: Any? = null,
    val immortal: Any? = null,
    val impetulant: Any? = null,
    val irrigate: Any? = null,
    val myxedema: Any? = null,
    val nonbookish: Any? = null,
    val onyx: Any? = null,
    val repasser: Any? = null,
    val septomarginal: Any? = null,
    val subdie: Any? = null,
    val tibiometatarsal: Any? = null,
    val waltzlike: Any? = null
)

data class Ressaut (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val apperceptive: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cuttoo: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val douser: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val drinkproof: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val forementioned: String,

    @get:JsonProperty("Freesia", required=true)@field:JsonProperty("Freesia", required=true)
    val freesia: String,

    @get:JsonProperty("Genevieve", required=true)@field:JsonProperty("Genevieve", required=true)
    val genevieve: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hyperdiabolical: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hypocone: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val irreverentially: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jumart: String,

    @get:JsonProperty("Mimosaceae", required=true)@field:JsonProperty("Mimosaceae", required=true)
    val mimosaceae: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mollicrush: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nedder: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val retinasphalt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sough: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val steading: String,

    @get:JsonProperty("Theopaschitism", required=true)@field:JsonProperty("Theopaschitism", required=true)
    val theopaschitism: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undurableness: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmingleable: String
)

sealed class Retrocervical {
    class IntegerValue(val value: Long)           : Retrocervical()
    class UnionArrayValue(val value: List<Long?>) : Retrocervical()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue    -> this.value
        is UnionArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Retrocervical = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> UnionArrayValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Revert {
    class BoolValue(val value: Boolean)  : Revert()
    class StringValue(val value: String) : Revert()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Revert = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class RewriteElement {
    class DoubleValue(val value: Double)             : RewriteElement()
    class NullArrayValue(val value: List<Any?>)      : RewriteElement()
    class RewriteClassValue(val value: RewriteClass) : RewriteElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is NullArrayValue    -> this.value
        is RewriteClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): RewriteElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode                          -> RewriteClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class RewriteClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val accountancy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cacotrophic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val contest: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val couthily: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val falculate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foreseize: Any? = null,

    @get:JsonProperty("Hyades", required=true)@field:JsonProperty("Hyades", required=true)
    val hyades: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lemnad: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monotheistically: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonflying: Any? = null,

    @get:JsonProperty("Ptenoglossa", required=true)@field:JsonProperty("Ptenoglossa", required=true)
    val ptenoglossa: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val repatch: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rodman: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val strung: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val titmal: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val twalpennyworth: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unblamable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vertical: Any? = null,

    @get:JsonProperty("Whiggification", required=true)@field:JsonProperty("Whiggification", required=true)
    val whiggification: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val yardman: Any? = null
)

sealed class Saccoderm {
    class IntegerArrayValue(val value: List<Long>) : Saccoderm()
    class StringValue(val value: String)           : Saccoderm()
    class NullValue()                              : Saccoderm()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is StringValue       -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Saccoderm = when (jn) {
            is ArrayNode -> IntegerArrayValue(mapper.convertValue(jn))
            is TextNode  -> StringValue(mapper.convertValue(jn))
            is NullNode  -> NullValue()
            else         -> throw IllegalArgumentException()
        }
    }
}

sealed class SantirElement {
    class DoubleValue(val value: Double)           : SantirElement()
    class SantirClassValue(val value: SantirClass) : SantirElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue      -> this.value
        is SantirClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): SantirElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> SantirClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class SantirClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val admiredly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val demicaponier: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val epitympanic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val investitor: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lupiform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monoflagellate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val paleoethnic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prediscountable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rhetoricals: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val roomth: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saccharose: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val septonasal: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val serpenticide: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val setarious: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val spaework: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stylite: Any? = null,

    @get:JsonProperty("Suessiones", required=true)@field:JsonProperty("Suessiones", required=true)
    val suessiones: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val timelily: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unprofaned: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vorticular: Any? = null
)

sealed class Saprophilous {
    class IntegerMapValue(val value: Map<String, Long>) : Saprophilous()
    class StringValue(val value: String)                : Saprophilous()
    class NullValue()                                   : Saprophilous()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is StringValue     -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Saprophilous = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class SaxtenElement {
    class SaxtenClassValue(val value: SaxtenClass) : SaxtenElement()
    class StringValue(val value: String)           : SaxtenElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is SaxtenClassValue -> this.value
        is StringValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): SaxtenElement = when (jn) {
            is ObjectNode -> SaxtenClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class SaxtenClass (
    val algarrobilla: Any? = null,
    val bowgrace: Any? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Centaurid")@field:JsonProperty("Centaurid")
    val centaurid: Any? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disdiapason: String? = null,
    val flix: Any? = null,
    val germanely: Any? = null,
    val homocerc: Boolean? = null,
    val inhume: Any? = null,
    val lepidote: Any? = null,
    val megalochirous: Any? = null,
    val ninepenny: Any? = null,
    val nonbookish: Any? = null,
    val nondeist: Any? = null,
    val nymphaeaceous: Any? = null,
    val parietofrontal: Any? = null,
    val sancyite: Any? = null,
    val subjectivist: Any? = null,
    val tibiad: Any? = null,
    val transonic: Any? = null,
    val tripetalous: Any? = null,
    val trunchman: Any? = null,
    val urger: Any? = null,
    val withdrawnness: Any? = null
)

data class Scatty (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aeriferous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val antical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val antighostism: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val arcanum: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val autotrophy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val baronial: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val caffeine: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gorgoniacean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val heroical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hydropical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mechanology: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val musicopoetic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val officiality: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val oftentimes: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ophthalmotonometer: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reflectively: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val springer: Any? = null,

    @get:JsonProperty("Tabasco", required=true)@field:JsonProperty("Tabasco", required=true)
    val tabasco: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teleianthous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uncombated: Any? = null
)

sealed class Scoffer {
    class IntegerMapValue(val value: Map<String, Long>) : Scoffer()
    class NullArrayValue(val value: List<Any?>)         : Scoffer()
    class NullValue()                                   : Scoffer()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is NullArrayValue  -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Scoffer = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Scrampum {
    class BoolValue(val value: Boolean)            : Scrampum()
    class IntegerArrayValue(val value: List<Long>) : Scrampum()
    class NullValue()                              : Scrampum()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is IntegerArrayValue -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Scrampum = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Serpentinic {
    class DoubleValue(val value: Double)           : Serpentinic()
    class IntegerArrayValue(val value: List<Long>) : Serpentinic()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Serpentinic = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Shadowable {
    class BoolValue(val value: Boolean)           : Shadowable()
    class UnionArrayValue(val value: List<Long?>) : Shadowable()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is UnionArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Shadowable = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> UnionArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class SisteringElement {
    class IntegerValue(val value: Long)                  : SisteringElement()
    class NullArrayValue(val value: List<Any?>)          : SisteringElement()
    class SisteringClassValue(val value: SisteringClass) : SisteringElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue        -> this.value
        is NullArrayValue      -> this.value
        is SisteringClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): SisteringElement = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode           -> SisteringClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class SisteringClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amphicarpic: Any? = null,

    @get:JsonProperty("Chianti", required=true)@field:JsonProperty("Chianti", required=true)
    val chianti: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val frigorific: Any? = null,

    @get:JsonProperty("Haplomi", required=true)@field:JsonProperty("Haplomi", required=true)
    val haplomi: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hyperkinesis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val laudable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val madwoman: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maimedly: Any? = null,

    @get:JsonProperty("Micropterygidae", required=true)@field:JsonProperty("Micropterygidae", required=true)
    val micropterygidae: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val microrhabdus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nondense: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val phlebemphraxis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val redsear: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schismatical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tartryl: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unabhorred: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undeliberateness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmixable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val untruckling: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vineal: Any? = null
)

data class Staghunting (
    val calorimetric: Long? = null,
    val canid: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disdiapason: String? = null,
    val ditriglyphic: Long? = null,
    val floriferousness: Long? = null,
    val gamelike: Long? = null,
    val grig: Long? = null,
    val homocerc: Boolean? = null,
    val interloan: Long? = null,
    val lithotomy: Long? = null,
    val loric: Long? = null,
    val membranocoriaceous: Long? = null,
    val membranogenic: Long? = null,
    val nonbookish: Any? = null,
    val overtrump: Long? = null,
    val scotino: Long? = null,
    val seasonable: Long? = null,
    val sephen: Long? = null,
    val stigmarioid: Long? = null,
    val tired: Long? = null,
    val trifid: Long? = null,
    val undefeatedly: Long? = null,
    val ungirlish: Long? = null
)

sealed class Stagmometer {
    class StringValue(val value: String)          : Stagmometer()
    class UnionArrayValue(val value: List<Long?>) : Stagmometer()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is StringValue     -> this.value
        is UnionArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Stagmometer = when (jn) {
            is TextNode  -> StringValue(mapper.convertValue(jn))
            is ArrayNode -> UnionArrayValue(mapper.convertValue(jn))
            else         -> throw IllegalArgumentException()
        }
    }
}

sealed class Stimulability {
    class BoolValue(val value: Boolean)                 : Stimulability()
    class IntegerMapValue(val value: Map<String, Long>) : Stimulability()
    class IntegerValue(val value: Long)                 : Stimulability()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerMapValue -> this.value
        is IntegerValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Stimulability = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Strangleable {
    class DoubleValue(val value: Double)        : Strangleable()
    class NullArrayValue(val value: List<Any?>) : Strangleable()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue    -> this.value
        is NullArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Strangleable = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class StrenuosityElement {
    class NullArrayValue(val value: List<Any?>)              : StrenuosityElement()
    class StrenuosityClassValue(val value: StrenuosityClass) : StrenuosityElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue        -> this.value
        is StrenuosityClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): StrenuosityElement = when (jn) {
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode -> StrenuosityClassValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class StrenuosityClass (
    val bliss: Long? = null,
    val buccate: Long? = null,
    val bulletproof: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val crumblingness: Long? = null,
    val disdiapason: String? = null,
    val engagedly: Long? = null,
    val fightable: Long? = null,
    val hoariness: Long? = null,
    val homocerc: Boolean? = null,
    val hypopodium: Long? = null,
    val luxurist: Long? = null,
    val mechanician: Long? = null,
    val nonbookish: Any? = null,

    @get:JsonProperty("Onopordon")@field:JsonProperty("Onopordon")
    val onopordon: Long? = null,

    val podgily: Long? = null,
    val reformableness: Long? = null,
    val scatterbrains: Long? = null,
    val seminuria: Long? = null,

    @get:JsonProperty("Sodomite")@field:JsonProperty("Sodomite")
    val sodomite: Long? = null,

    val tramp: Long? = null,
    val undueness: Long? = null,
    val worthily: Long? = null,

    @get:JsonProperty("Yankeeist")@field:JsonProperty("Yankeeist")
    val yankeeist: Long? = null
)

sealed class Tabaxir {
    class BoolValue(val value: Boolean)  : Tabaxir()
    class DoubleValue(val value: Double) : Tabaxir()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is DoubleValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Tabaxir = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Talpiform {
    class DoubleValue(val value: Double)                     : Talpiform()
    class QuebrachineClassValue(val value: QuebrachineClass) : Talpiform()
    class NullValue()                                        : Talpiform()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue           -> this.value
        is QuebrachineClassValue -> this.value
        is NullValue             -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Talpiform = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> QuebrachineClassValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Thwack {
    class BoolValue(val value: Boolean)                      : Thwack()
    class DoubleValue(val value: Double)                     : Thwack()
    class QuebrachineClassValue(val value: QuebrachineClass) : Thwack()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue             -> this.value
        is DoubleValue           -> this.value
        is QuebrachineClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Thwack = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> QuebrachineClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Tortricine {
    class QuebrachineClassValue(val value: QuebrachineClass) : Tortricine()
    class UnionArrayValue(val value: List<Long?>)            : Tortricine()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is QuebrachineClassValue -> this.value
        is UnionArrayValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Tortricine = when (jn) {
            is ObjectNode -> QuebrachineClassValue(mapper.convertValue(jn))
            is ArrayNode  -> UnionArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class TruantcyElement {
    class BoolValue(val value: Boolean)                : TruantcyElement()
    class TruantcyClassValue(val value: TruantcyClass) : TruantcyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue          -> this.value
        is TruantcyClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): TruantcyElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> TruantcyClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class TruantcyClass (
    val alfiona: Any? = null,
    val ascaridiasis: Any? = null,
    val bungey: Any? = null,
    val catharticalness: Double? = null,
    val ceroxyle: Any? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val chorology: Any? = null,
    val disdiapason: String? = null,
    val enmarble: Any? = null,

    @get:JsonProperty("Epeira")@field:JsonProperty("Epeira")
    val epeira: Any? = null,

    @get:JsonProperty("Eurylaimi")@field:JsonProperty("Eurylaimi")
    val eurylaimi: Any? = null,

    val germination: Any? = null,
    val hallelujah: Any? = null,
    val homocerc: Boolean? = null,
    val lev: Any? = null,
    val mouthing: Any? = null,
    val nonbookish: Any? = null,
    val philliloo: Any? = null,
    val planetal: Any? = null,
    val poney: Any? = null,
    val punctualist: Any? = null,
    val returnlessly: Any? = null,
    val skelder: Any? = null,
    val windwaywardly: Any? = null,

    @get:JsonProperty("Yuman")@field:JsonProperty("Yuman")
    val yuman: Any? = null
)

sealed class Unbeginning {
    class IntegerMapValue(val value: Map<String, Long>) : Unbeginning()
    class NullArrayValue(val value: List<Any?>)         : Unbeginning()
    class StringValue(val value: String)                : Unbeginning()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is NullArrayValue  -> this.value
        is StringValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Unbeginning = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Undesirability {
    class IntegerArrayValue(val value: List<Long>)      : Undesirability()
    class IntegerMapValue(val value: Map<String, Long>) : Undesirability()
    class StringValue(val value: String)                : Undesirability()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Undesirability = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Unerasing {
    class IntegerMapValue(val value: Map<String, Long>) : Unerasing()
    class IntegerValue(val value: Long)                 : Unerasing()
    class NullArrayValue(val value: List<Any?>)         : Unerasing()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is IntegerValue    -> this.value
        is NullArrayValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Unerasing = when (jn) {
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Unguentarium {
    class IntegerValue(val value: Long)         : Unguentarium()
    class NullArrayValue(val value: List<Any?>) : Unguentarium()
    class NullValue()                           : Unguentarium()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue   -> this.value
        is NullArrayValue -> this.value
        is NullValue      -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Unguentarium = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class UnimpeachablyElement {
    class BoolValue(val value: Boolean)                          : UnimpeachablyElement()
    class UnimpeachablyClassValue(val value: UnimpeachablyClass) : UnimpeachablyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue               -> this.value
        is UnimpeachablyClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): UnimpeachablyElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> UnimpeachablyClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class UnimpeachablyClass (
    val acerin: Long? = null,

    @get:JsonProperty("Bobadil")@field:JsonProperty("Bobadil")
    val bobadil: Long? = null,

    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val chlorophylligenous: Long? = null,
    val conversational: Long? = null,
    val demiowl: Long? = null,
    val disdiapason: String? = null,
    val ectorhinal: Long? = null,
    val gamblesomeness: Long? = null,
    val homocerc: Boolean? = null,
    val irrorate: Long? = null,
    val kindergartening: Long? = null,
    val lateritic: Long? = null,
    val mespil: Long? = null,
    val misconfiguration: Long? = null,
    val nonbookish: Any? = null,
    val planometry: Long? = null,

    @get:JsonProperty("Quiina")@field:JsonProperty("Quiina")
    val quiina: Long? = null,

    @get:JsonProperty("Robert")@field:JsonProperty("Robert")
    val robert: Long? = null,

    val rot: Long? = null,
    val subcinctorium: Long? = null,
    val tussocker: Long? = null,
    val ultraproud: Long? = null,
    val unsuggestedness: Long? = null
)

sealed class Unmortgaged {
    class DoubleValue(val value: Double)                : Unmortgaged()
    class IntegerMapValue(val value: Map<String, Long>) : Unmortgaged()
    class NullValue()                                   : Unmortgaged()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Unmortgaged = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Unobstructed {
    class IntegerValue(val value: Long)                      : Unobstructed()
    class QuebrachineClassValue(val value: QuebrachineClass) : Unobstructed()
    class NullValue()                                        : Unobstructed()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue          -> this.value
        is QuebrachineClassValue -> this.value
        is NullValue             -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Unobstructed = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> QuebrachineClassValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Unreceptivity {
    class IntegerValue(val value: Long)         : Unreceptivity()
    class NullArrayValue(val value: List<Any?>) : Unreceptivity()
    class StringValue(val value: String)        : Unreceptivity()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue   -> this.value
        is NullArrayValue -> this.value
        is StringValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Unreceptivity = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Unsatisfactoriness {
    class BoolValue(val value: Boolean)            : Unsatisfactoriness()
    class IntegerArrayValue(val value: List<Long>) : Unsatisfactoriness()
    class IntegerValue(val value: Long)            : Unsatisfactoriness()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Unsatisfactoriness = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class UnstressedElement {
    class BoolValue(val value: Boolean)                    : UnstressedElement()
    class StringValue(val value: String)                   : UnstressedElement()
    class UnstressedClassValue(val value: UnstressedClass) : UnstressedElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue            -> this.value
        is StringValue          -> this.value
        is UnstressedClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): UnstressedElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            is ObjectNode  -> UnstressedClassValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class UnstressedClass (
    @get:JsonProperty("Alain", required=true)@field:JsonProperty("Alain", required=true)
    val alain: Any? = null,

    @get:JsonProperty("Amphirhina", required=true)@field:JsonProperty("Amphirhina", required=true)
    val amphirhina: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val antimachinery: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coldish: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val crantara: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val distinguishing: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val elytroposis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gentianwort: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val heliosis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val instrumental: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val introinflection: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kala: Any? = null,

    @get:JsonProperty("Lincolnian", required=true)@field:JsonProperty("Lincolnian", required=true)
    val lincolnian: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metad: Any? = null,

    @get:JsonProperty("Sarcophilus", required=true)@field:JsonProperty("Sarcophilus", required=true)
    val sarcophilus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val swingingly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unconformity: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undecreed: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val venerable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vowellessness: Any? = null
)

sealed class Untasked {
    class DoubleValue(val value: Double)                : Untasked()
    class IntegerMapValue(val value: Map<String, Long>) : Untasked()
    class NullArrayValue(val value: List<Any?>)         : Untasked()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
        is NullArrayValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Untasked = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Unvarying {
    class BoolValue(val value: Boolean)                 : Unvarying()
    class DoubleValue(val value: Double)                : Unvarying()
    class IntegerMapValue(val value: Map<String, Long>) : Unvarying()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Unvarying = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Vehemently {
    class BoolValue(val value: Boolean)         : Vehemently()
    class NullArrayValue(val value: List<Any?>) : Vehemently()
    class NullValue()                           : Vehemently()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue      -> this.value
        is NullArrayValue -> this.value
        is NullValue      -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Vehemently = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Whitepot {
    class DoubleValue(val value: Double)                     : Whitepot()
    class QuebrachineClassValue(val value: QuebrachineClass) : Whitepot()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue           -> this.value
        is QuebrachineClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Whitepot = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> QuebrachineClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class WrothyElement {
    class NullArrayValue(val value: List<Any?>)    : WrothyElement()
    class WrothyClassValue(val value: WrothyClass) : WrothyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue   -> this.value
        is WrothyClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): WrothyElement = when (jn) {
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode -> WrothyClassValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class WrothyClass (
    @get:JsonProperty("Aeschynanthus", required=true)@field:JsonProperty("Aeschynanthus", required=true)
    val aeschynanthus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aquiferous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cheapener: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enumeration: Any? = null,

    @get:JsonProperty("Ephesine", required=true)@field:JsonProperty("Ephesine", required=true)
    val ephesine: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val escadrille: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val estrous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val interestedly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val katakinetomer: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mortification: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val morula: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val orthosymmetrical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val overbark: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val politist: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val qualified: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sphenomalar: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val throatful: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val transhumance: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val triandrian: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unbooked: Any? = null
)
