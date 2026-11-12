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
    convert(CerographElement::class,        { CerographElement.fromJson(it) },        { it.toJson() }, true)
    convert(ChemotherapeuticElement::class, { ChemotherapeuticElement.fromJson(it) }, { it.toJson() }, true)
    convert(CimeliaElement::class,          { CimeliaElement.fromJson(it) },          { it.toJson() }, true)
    convert(Clinodome::class,               { Clinodome.fromJson(it) },               { it.toJson() }, true)
    convert(CoadjustElement::class,         { CoadjustElement.fromJson(it) },         { it.toJson() }, true)
    convert(Consilience::class,             { Consilience.fromJson(it) },             { it.toJson() }, true)
    convert(Constructor::class,             { Constructor.fromJson(it) },             { it.toJson() }, true)
    convert(Continuative::class,            { Continuative.fromJson(it) },            { it.toJson() }, true)
    convert(CredulityElement::class,        { CredulityElement.fromJson(it) },        { it.toJson() }, true)
    convert(Creviced::class,                { Creviced.fromJson(it) },                { it.toJson() }, true)
    convert(DeruralizeElement::class,       { DeruralizeElement.fromJson(it) },       { it.toJson() }, true)
    convert(DiaereseElement::class,         { DiaereseElement.fromJson(it) },         { it.toJson() }, true)
    convert(Downstroke::class,              { Downstroke.fromJson(it) },              { it.toJson() }, true)
    convert(Eleutheromania::class,          { Eleutheromania.fromJson(it) },          { it.toJson() }, true)
    convert(Entomoid::class,                { Entomoid.fromJson(it) },                { it.toJson() }, true)
    convert(Epipaleolithic::class,          { Epipaleolithic.fromJson(it) },          { it.toJson() }, true)
    convert(Expropriable::class,            { Expropriable.fromJson(it) },            { it.toJson() }, true)
    convert(FagginglyElement::class,        { FagginglyElement.fromJson(it) },        { it.toJson() }, true)
    convert(FenkElement::class,             { FenkElement.fromJson(it) },             { it.toJson() }, true)
    convert(FlagmakingElement::class,       { FlagmakingElement.fromJson(it) },       { it.toJson() }, true)
    convert(Fluorometer::class,             { Fluorometer.fromJson(it) },             { it.toJson() }, true)
    convert(Fuzzy::class,                   { Fuzzy.fromJson(it) },                   { it.toJson() }, true)
    convert(Gardenward::class,              { Gardenward.fromJson(it) },              { it.toJson() }, true)
    convert(Generalissimo::class,           { Generalissimo.fromJson(it) },           { it.toJson() }, true)
    convert(Hemicrystalline::class,         { Hemicrystalline.fromJson(it) },         { it.toJson() }, true)
    convert(HemocoeleElement::class,        { HemocoeleElement.fromJson(it) },        { it.toJson() }, true)
    convert(Hoister::class,                 { Hoister.fromJson(it) },                 { it.toJson() }, true)
    convert(Hyperpiesi::class,              { Hyperpiesi.fromJson(it) },              { it.toJson() }, true)
    convert(Hyppish::class,                 { Hyppish.fromJson(it) },                 { it.toJson() }, true)
    convert(Idealizer::class,               { Idealizer.fromJson(it) },               { it.toJson() }, true)
    convert(Incrustator::class,             { Incrustator.fromJson(it) },             { it.toJson() }, true)
    convert(Intentiveness::class,           { Intentiveness.fromJson(it) },           { it.toJson() }, true)
    convert(Jacutinga::class,               { Jacutinga.fromJson(it) },               { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val centrodesmose: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cerograph: List<CerographElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val chemotherapeutics: List<ChemotherapeuticElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cimelia: List<CimeliaElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val citrated: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clinodome: List<Clinodome>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coadjust: List<CoadjustElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val consilience: List<Consilience>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constructor: List<Constructor>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val continuative: List<Continuative>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val credulity: List<CredulityElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val creviced: List<Creviced>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cubiculum: List<List<Long?>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val deruralize: List<DeruralizeElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val diaereses: List<DiaereseElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dissolution: List<List<Any?>?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downstroke: List<Downstroke>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val electrotautomerism: List<Double?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val eleutheromania: List<Eleutheromania>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val encrust: Encrust,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val entomoid: List<Entomoid>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val epipaleolithic: List<Epipaleolithic>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val expropriable: List<Expropriable>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val faggingly: List<FagginglyElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fenks: List<FenkElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flagmaking: List<FlagmakingElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fluorometer: List<Fluorometer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fulsome: List<Long?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fuzzy: List<Fuzzy>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gardenwards: List<Gardenward>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val generalissimo: List<Generalissimo>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val habeas: List<Map<String, Long>?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hemicrystalline: List<Hemicrystalline>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hemocoele: List<HemocoeleElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hoister: List<Hoister>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hyperpiesis: List<Hyperpiesi>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hyppish: List<Hyppish>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val idealizer: List<Idealizer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val incrustator: List<Incrustator>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val intentiveness: List<Intentiveness>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val interacinar: Interacinar,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val intercorrelation: List<List<Long>?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jacutinga: List<Jacutinga>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class CerographElement {
    class CerographClassValue(val value: CerographClass) : CerographElement()
    class StringValue(val value: String)                 : CerographElement()
    class NullValue()                                    : CerographElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CerographClassValue -> this.value
        is StringValue         -> this.value
        is NullValue           -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): CerographElement = when (jn) {
            is ObjectNode -> CerographClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

data class CerographClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val apotropaion: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val casuary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val creaker: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disqualification: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val imperatorious: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val impermeabilize: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metastoma: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noctidiurnal: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonreserve: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ophthalmotonometry: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pailful: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pigfish: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pongee: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prosodical: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scrofuloderm: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val storekeeping: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val therologist: Any? = null,

    @get:JsonProperty("Tolowa", required=true)@field:JsonProperty("Tolowa", required=true)
    val tolowa: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tradeful: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unriveting: Any? = null
)

sealed class ChemotherapeuticElement {
    class ChemotherapeuticClassValue(val value: ChemotherapeuticClass) : ChemotherapeuticElement()
    class IntegerValue(val value: Long)                                : ChemotherapeuticElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is ChemotherapeuticClassValue -> this.value
        is IntegerValue               -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): ChemotherapeuticElement = when (jn) {
            is ObjectNode           -> ChemotherapeuticClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class ChemotherapeuticClass (
    val angioneurotic: Any? = null,
    val availment: Any? = null,
    val bladelet: Any? = null,
    val catharticalness: Double? = null,
    val caulis: Any? = null,
    val chalcus: Any? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disdiapason: String? = null,
    val enteradenological: Any? = null,
    val homocerc: Boolean? = null,
    val imporosity: Any? = null,
    val insistently: Any? = null,
    val intraparietal: Any? = null,
    val ivied: Any? = null,

    @get:JsonProperty("Maureen")@field:JsonProperty("Maureen")
    val maureen: Any? = null,

    val nonbookish: Any? = null,
    val nostochine: Any? = null,
    val nutcracker: Any? = null,
    val ofttimes: Any? = null,
    val phenocryst: Any? = null,
    val precoincident: Any? = null,
    val ramiferous: Any? = null,
    val stagmometer: Any? = null,
    val tetherball: Any? = null,
    val unshy: Any? = null
)

sealed class CimeliaElement {
    class CimeliaClassValue(val value: CimeliaClass) : CimeliaElement()
    class IntegerArrayValue(val value: List<Long>)   : CimeliaElement()
    class NullValue()                                : CimeliaElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is IntegerArrayValue -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): CimeliaElement = when (jn) {
            is ObjectNode -> CimeliaClassValue(mapper.convertValue(jn))
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

data class CimeliaClass (
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

sealed class Clinodome {
    class DoubleValue(val value: Double) : Clinodome()
    class StringValue(val value: String) : Clinodome()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Clinodome = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class CoadjustElement {
    class CoadjustClassValue(val value: CoadjustClass) : CoadjustElement()
    class DoubleValue(val value: Double)               : CoadjustElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CoadjustClassValue -> this.value
        is DoubleValue        -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): CoadjustElement = when (jn) {
            is ObjectNode                          -> CoadjustClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class CoadjustClass (
    val amidosulphonal: Any? = null,

    @get:JsonProperty("Benny")@field:JsonProperty("Benny")
    val benny: Any? = null,

    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disdiapason: String? = null,
    val ensnare: Any? = null,
    val homocerc: Boolean? = null,
    val hybridizer: Any? = null,
    val leastwise: Any? = null,
    val lof: Any? = null,
    val monkhood: Any? = null,

    @get:JsonProperty("Netherlandish")@field:JsonProperty("Netherlandish")
    val netherlandish: Any? = null,

    val nonbookish: Any? = null,
    val peonism: Any? = null,

    @get:JsonProperty("Phonelescope")@field:JsonProperty("Phonelescope")
    val phonelescope: Any? = null,

    val porphyrogeniture: Any? = null,
    val preindemnify: Any? = null,
    val rosal: Any? = null,
    val scalenous: Any? = null,
    val scopine: Any? = null,

    @get:JsonProperty("Sedaceae")@field:JsonProperty("Sedaceae")
    val sedaceae: Any? = null,

    val suberinize: Any? = null,
    val symbiot: Any? = null,
    val tablefellow: Any? = null,
    val unchargeable: Any? = null
)

sealed class Consilience {
    class DoubleValue(val value: Double)                : Consilience()
    class IntegerMapValue(val value: Map<String, Long>) : Consilience()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Consilience = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Constructor {
    class BoolValue(val value: Boolean)                : Constructor()
    class UnionMapValue(val value: Map<String, Long?>) : Constructor()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue     -> this.value
        is UnionMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Constructor = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> UnionMapValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Continuative {
    class IntegerMapValue(val value: Map<String, Long>) : Continuative()
    class StringValue(val value: String)                : Continuative()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is StringValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Continuative = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class CredulityElement {
    class CredulityClassValue(val value: CredulityClass) : CredulityElement()
    class IntegerValue(val value: Long)                  : CredulityElement()
    class StringValue(val value: String)                 : CredulityElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CredulityClassValue -> this.value
        is IntegerValue        -> this.value
        is StringValue         -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): CredulityElement = when (jn) {
            is ObjectNode           -> CredulityClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class CredulityClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ammonolytic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bushmaster: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val considering: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val consuetudinary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val embarras: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fineness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flaithship: Any? = null,

    @get:JsonProperty("Flavia", required=true)@field:JsonProperty("Flavia", required=true)
    val flavia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gruffly: Any? = null,

    @get:JsonProperty("Hedychium", required=true)@field:JsonProperty("Hedychium", required=true)
    val hedychium: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val leadwort: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val overseriously: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parabola: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pectinatodenticulate: Any? = null,

    @get:JsonProperty("Popean", required=true)@field:JsonProperty("Popean", required=true)
    val popean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pornocrat: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quadrisect: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val seriality: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vamphorn: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val wharp: Any? = null
)

sealed class Creviced {
    class BoolValue(val value: Boolean)                 : Creviced()
    class IntegerMapValue(val value: Map<String, Long>) : Creviced()
    class StringValue(val value: String)                : Creviced()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerMapValue -> this.value
        is StringValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Creviced = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> IntegerMapValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class DeruralizeElement {
    class BoolValue(val value: Boolean)                    : DeruralizeElement()
    class DeruralizeClassValue(val value: DeruralizeClass) : DeruralizeElement()
    class NullArrayValue(val value: List<Any?>)            : DeruralizeElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue            -> this.value
        is DeruralizeClassValue -> this.value
        is NullArrayValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): DeruralizeElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> DeruralizeClassValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class DeruralizeClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bockerel: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val boulder: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val churrus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val counterdigged: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dialogite: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val digenic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dunbird: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ergatogyne: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fiendful: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jackrod: Any? = null,

    @get:JsonProperty("Jehovistic", required=true)@field:JsonProperty("Jehovistic", required=true)
    val jehovistic: Any? = null,

    @get:JsonProperty("Paninean", required=true)@field:JsonProperty("Paninean", required=true)
    val paninean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val panther: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val placentigerous: Any? = null,

    @get:JsonProperty("Romney", required=true)@field:JsonProperty("Romney", required=true)
    val romney: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sparm: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tocsin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unnicked: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unstavable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val windfirm: Any? = null
)

sealed class DiaereseElement {
    class BoolValue(val value: Boolean)                : DiaereseElement()
    class DiaereseClassValue(val value: DiaereseClass) : DiaereseElement()
    class IntegerArrayValue(val value: List<Long>)     : DiaereseElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue          -> this.value
        is DiaereseClassValue -> this.value
        is IntegerArrayValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): DiaereseElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> DiaereseClassValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

data class DiaereseClass (
    @get:JsonProperty("Amoreuxia", required=true)@field:JsonProperty("Amoreuxia", required=true)
    val amoreuxia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ani: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bernicle: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val blackwasher: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val blowhard: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val broma: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val closecross: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val congregationalism: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val grayly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val historically: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hoast: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val irretentive: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parcener: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pedder: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pseudoanatomic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rhizocarpian: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val samel: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val silker: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subdentated: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subobscure: Any? = null
)

sealed class Downstroke {
    class BoolValue(val value: Boolean)         : Downstroke()
    class NullArrayValue(val value: List<Any?>) : Downstroke()
    class StringValue(val value: String)        : Downstroke()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue      -> this.value
        is NullArrayValue -> this.value
        is StringValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Downstroke = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Eleutheromania {
    class DoubleValue(val value: Double)                : Eleutheromania()
    class IntegerMapValue(val value: Map<String, Long>) : Eleutheromania()
    class StringValue(val value: String)                : Eleutheromania()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue     -> this.value
        is IntegerMapValue -> this.value
        is StringValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Eleutheromania = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class Encrust (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comradely: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val diacanthous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val feminineness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gossamered: Any? = null,

    @get:JsonProperty("Hibernia", required=true)@field:JsonProperty("Hibernia", required=true)
    val hibernia: Any? = null,

    @get:JsonProperty("Hibiscus", required=true)@field:JsonProperty("Hibiscus", required=true)
    val hibiscus: Any? = null,

    @get:JsonProperty("Lepidosauria", required=true)@field:JsonProperty("Lepidosauria", required=true)
    val lepidosauria: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lollingly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val manager: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mechanic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val overminuteness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val papelonne: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val plebification: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pugmiller: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val recoveror: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val spermatoblastic: Any? = null,

    @get:JsonProperty("Syllidae", required=true)@field:JsonProperty("Syllidae", required=true)
    val syllidae: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ungyved: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val whirlabout: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val woodenware: Any? = null
)

sealed class Entomoid {
    class CimeliaClassValue(val value: CimeliaClass) : Entomoid()
    class IntegerValue(val value: Long)              : Entomoid()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is IntegerValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Entomoid = when (jn) {
            is ObjectNode           -> CimeliaClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Epipaleolithic {
    class DoubleValue(val value: Double)           : Epipaleolithic()
    class IntegerArrayValue(val value: List<Long>) : Epipaleolithic()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Epipaleolithic = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Expropriable {
    class CimeliaClassValue(val value: CimeliaClass) : Expropriable()
    class DoubleValue(val value: Double)             : Expropriable()
    class NullArrayValue(val value: List<Any?>)      : Expropriable()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is DoubleValue       -> this.value
        is NullArrayValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Expropriable = when (jn) {
            is ObjectNode                          -> CimeliaClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> NullArrayValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class FagginglyElement {
    class DoubleValue(val value: Double)                 : FagginglyElement()
    class FagginglyClassValue(val value: FagginglyClass) : FagginglyElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue         -> this.value
        is FagginglyClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): FagginglyElement = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> FagginglyClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class FagginglyClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val abranchian: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aculeiform: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val adiaphoristic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val adoptionism: Any? = null,

    @get:JsonProperty("Anglic", required=true)@field:JsonProperty("Anglic", required=true)
    val anglic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val antrotomy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coerciveness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decorist: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val duckhood: Any? = null,

    @get:JsonProperty("Heteromeri", required=true)@field:JsonProperty("Heteromeri", required=true)
    val heteromeri: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hypochnose: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lochage: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val melee: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonconformitant: Any? = null,

    @get:JsonProperty("Poinsettia", required=true)@field:JsonProperty("Poinsettia", required=true)
    val poinsettia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val putatively: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val semivolatile: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val soleas: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unfastenable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmillinered: Any? = null
)

sealed class FenkElement {
    class FenkClassValue(val value: FenkClass) : FenkElement()
    class StringValue(val value: String)       : FenkElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is FenkClassValue -> this.value
        is StringValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): FenkElement = when (jn) {
            is ObjectNode -> FenkClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class FenkClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val apoise: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val astronomize: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cockhorse: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val copular: Any? = null,

    @get:JsonProperty("Dagomba", required=true)@field:JsonProperty("Dagomba", required=true)
    val dagomba: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val draffy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foreigner: Any? = null,

    @get:JsonProperty("Guyandot", required=true)@field:JsonProperty("Guyandot", required=true)
    val guyandot: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val neurogliosis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val osmious: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val palpitate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rebukeable: Any? = null,

    @get:JsonProperty("Reinwardtia", required=true)@field:JsonProperty("Reinwardtia", required=true)
    val reinwardtia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reservatory: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scalt: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scripturalize: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tintometer: Any? = null,

    @get:JsonProperty("Tritoness", required=true)@field:JsonProperty("Tritoness", required=true)
    val tritoness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undergrade: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undermountain: Any? = null
)

sealed class FlagmakingElement {
    class BoolValue(val value: Boolean)                    : FlagmakingElement()
    class DoubleValue(val value: Double)                   : FlagmakingElement()
    class FlagmakingClassValue(val value: FlagmakingClass) : FlagmakingElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue            -> this.value
        is DoubleValue          -> this.value
        is FlagmakingClassValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): FlagmakingElement = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ObjectNode                          -> FlagmakingClassValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class FlagmakingClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val albarco: Any? = null,

    @get:JsonProperty("Bunodonta", required=true)@field:JsonProperty("Bunodonta", required=true)
    val bunodonta: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hornify: Any? = null,

    @get:JsonProperty("Hydrocorisae", required=true)@field:JsonProperty("Hydrocorisae", required=true)
    val hydrocorisae: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hypoglossus: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inexpiably: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ingratitude: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ladyfly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val medicament: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monogrammatic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nobbut: Any? = null,

    @get:JsonProperty("Notacanthidae", required=true)@field:JsonProperty("Notacanthidae", required=true)
    val notacanthidae: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val polyplacophore: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val proexercise: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val protoplast: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val puzzling: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val splanchnoskeleton: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unloveliness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unquarantined: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unrenounceable: Any? = null
)

sealed class Fluorometer {
    class IntegerValue(val value: Long)  : Fluorometer()
    class StringValue(val value: String) : Fluorometer()
    class NullValue()                    : Fluorometer()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
        is NullValue    -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Fluorometer = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Fuzzy {
    class IntegerValue(val value: Long)                : Fuzzy()
    class UnionMapValue(val value: Map<String, Long?>) : Fuzzy()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue  -> this.value
        is UnionMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Fuzzy = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> UnionMapValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Gardenward {
    class BoolValue(val value: Boolean)            : Gardenward()
    class IntegerArrayValue(val value: List<Long>) : Gardenward()
    class StringValue(val value: String)           : Gardenward()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is IntegerArrayValue -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Gardenward = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Generalissimo {
    class BoolValue(val value: Boolean)                 : Generalissimo()
    class IntegerMapValue(val value: Map<String, Long>) : Generalissimo()
    class NullValue()                                   : Generalissimo()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerMapValue -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Generalissimo = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> IntegerMapValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Hemicrystalline {
    class CimeliaClassValue(val value: CimeliaClass) : Hemicrystalline()
    class StringValue(val value: String)             : Hemicrystalline()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Hemicrystalline = when (jn) {
            is ObjectNode -> CimeliaClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class HemocoeleElement {
    class HemocoeleClassValue(val value: HemocoeleClass) : HemocoeleElement()
    class IntegerArrayValue(val value: List<Long>)       : HemocoeleElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is HemocoeleClassValue -> this.value
        is IntegerArrayValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): HemocoeleElement = when (jn) {
            is ObjectNode -> HemocoeleClassValue(mapper.convertValue(jn))
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class HemocoeleClass (
    val acrogamy: Any? = null,
    val amelification: Any? = null,
    val autobiographic: Any? = null,
    val berat: Any? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disdiapason: String? = null,
    val disproportionably: Any? = null,
    val erythrite: Any? = null,
    val graphic: Any? = null,
    val hepatological: Any? = null,
    val homocerc: Boolean? = null,
    val incommensurably: Any? = null,
    val misaffirm: Any? = null,
    val nonbookish: Any? = null,
    val pocketbook: Any? = null,
    val sclerometric: Any? = null,
    val stambouline: Any? = null,
    val stickpin: Any? = null,
    val tubulure: Any? = null,
    val undelated: Any? = null,
    val unsalt: Any? = null,
    val untutelar: Any? = null,
    val vagrant: Any? = null,

    @get:JsonProperty("Walt")@field:JsonProperty("Walt")
    val walt: Any? = null
)

sealed class Hoister {
    class CimeliaClassValue(val value: CimeliaClass) : Hoister()
    class StringValue(val value: String)             : Hoister()
    class NullValue()                                : Hoister()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is StringValue       -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Hoister = when (jn) {
            is ObjectNode -> CimeliaClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Hyperpiesi {
    class CimeliaClassValue(val value: CimeliaClass) : Hyperpiesi()
    class NullArrayValue(val value: List<Any?>)      : Hyperpiesi()
    class NullValue()                                : Hyperpiesi()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is NullArrayValue    -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Hyperpiesi = when (jn) {
            is ObjectNode -> CimeliaClassValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Hyppish {
    class BoolValue(val value: Boolean)  : Hyppish()
    class StringValue(val value: String) : Hyppish()
    class NullValue()                    : Hyppish()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is StringValue -> this.value
        is NullValue   -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Hyppish = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Idealizer {
    class CimeliaClassValue(val value: CimeliaClass) : Idealizer()
    class IntegerValue(val value: Long)              : Idealizer()
    class NullArrayValue(val value: List<Any?>)      : Idealizer()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is IntegerValue      -> this.value
        is NullArrayValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Idealizer = when (jn) {
            is ObjectNode           -> CimeliaClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ArrayNode            -> NullArrayValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Incrustator {
    class IntegerArrayValue(val value: List<Long>) : Incrustator()
    class IntegerValue(val value: Long)            : Incrustator()
    class StringValue(val value: String)           : Incrustator()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Incrustator = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Intentiveness {
    class CimeliaClassValue(val value: CimeliaClass) : Intentiveness()
    class DoubleValue(val value: Double)             : Intentiveness()
    class StringValue(val value: String)             : Intentiveness()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is CimeliaClassValue -> this.value
        is DoubleValue       -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Intentiveness = when (jn) {
            is ObjectNode                          -> CimeliaClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class Interacinar (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assapan: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val benefactorship: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val triseriatim: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tubbing: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val untrimmed: Any? = null
)

sealed class Jacutinga {
    class IntegerArrayValue(val value: List<Long>)     : Jacutinga()
    class UnionMapValue(val value: Map<String, Long?>) : Jacutinga()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is UnionMapValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Jacutinga = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> UnionMapValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}
