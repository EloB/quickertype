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
    convert(Abranchiata::class,          { Abranchiata.fromJson(it) },          { it.toJson() }, true)
    convert(Academe::class,              { Academe.fromJson(it) },              { it.toJson() }, true)
    convert(Acquirable::class,           { Acquirable.fromJson(it) },           { it.toJson() }, true)
    convert(Aerometry::class,            { Aerometry.fromJson(it) },            { it.toJson() }, true)
    convert(Alexin::class,               { Alexin.fromJson(it) },               { it.toJson() }, true)
    convert(AlleviateElement::class,     { AlleviateElement.fromJson(it) },     { it.toJson() }, true)
    convert(Amaa::class,                 { Amaa.fromJson(it) },                 { it.toJson() }, true)
    convert(Ambassage::class,            { Ambassage.fromJson(it) },            { it.toJson() }, true)
    convert(AnkeeElement::class,         { AnkeeElement.fromJson(it) },         { it.toJson() }, true)
    convert(AnsarieElement::class,       { AnsarieElement.fromJson(it) },       { it.toJson() }, true)
    convert(Aphasia::class,              { Aphasia.fromJson(it) },              { it.toJson() }, true)
    convert(Asprawl::class,              { Asprawl.fromJson(it) },              { it.toJson() }, true)
    convert(Bedesman::class,             { Bedesman.fromJson(it) },             { it.toJson() }, true)
    convert(Belard::class,               { Belard.fromJson(it) },               { it.toJson() }, true)
    convert(Bocking::class,              { Bocking.fromJson(it) },              { it.toJson() }, true)
    convert(Brawlingly::class,           { Brawlingly.fromJson(it) },           { it.toJson() }, true)
    convert(Brookie::class,              { Brookie.fromJson(it) },              { it.toJson() }, true)
    convert(Bumboatman::class,           { Bumboatman.fromJson(it) },           { it.toJson() }, true)
    convert(Calaverite::class,           { Calaverite.fromJson(it) },           { it.toJson() }, true)
    convert(Catallactic::class,          { Catallactic.fromJson(it) },          { it.toJson() }, true)
    convert(Cemental::class,             { Cemental.fromJson(it) },             { it.toJson() }, true)
    convert(ChytridiaceaeElement::class, { ChytridiaceaeElement.fromJson(it) }, { it.toJson() }, true)
    convert(DiscordiaElement::class,     { DiscordiaElement.fromJson(it) },     { it.toJson() }, true)
    convert(Endomyce::class,             { Endomyce.fromJson(it) },             { it.toJson() }, true)
    convert(Epinephelidae::class,        { Epinephelidae.fromJson(it) },        { it.toJson() }, true)
    convert(Eupatorium::class,           { Eupatorium.fromJson(it) },           { it.toJson() }, true)
    convert(GryphosaurusElement::class,  { GryphosaurusElement.fromJson(it) },  { it.toJson() }, true)
    convert(Koryak::class,               { Koryak.fromJson(it) },               { it.toJson() }, true)
    convert(LaviniaElement::class,       { LaviniaElement.fromJson(it) },       { it.toJson() }, true)
    convert(OskarElement::class,         { OskarElement.fromJson(it) },         { it.toJson() }, true)
    convert(RebeccaElement::class,       { RebeccaElement.fromJson(it) },       { it.toJson() }, true)
    convert(Rhomboganoidei::class,       { Rhomboganoidei.fromJson(it) },       { it.toJson() }, true)
    convert(Ruellia::class,              { Ruellia.fromJson(it) },              { it.toJson() }, true)
    convert(School::class,               { School.fromJson(it) },               { it.toJson() }, true)
    convert(Shakespearolater::class,     { Shakespearolater.fromJson(it) },     { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty("Abranchiata", required=true)@field:JsonProperty("Abranchiata", required=true)
    val abranchiata: List<Abranchiata>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val academe: List<Academe>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val acquirable: List<Acquirable>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aerometry: List<Aerometry>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alexin: List<Alexin>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alleviate: List<AlleviateElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amaas: List<Amaa>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ambassage: List<Ambassage>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amphithyron: List<Amphithyron?>,

    @get:JsonProperty("Andriana", required=true)@field:JsonProperty("Andriana", required=true)
    val andriana: List<String?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ankee: List<AnkeeElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val annihilator: List<Map<String, Long?>?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val annulose: Any? = null,

    @get:JsonProperty("Ansarie", required=true)@field:JsonProperty("Ansarie", required=true)
    val ansarie: List<AnsarieElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val aphasia: List<Aphasia>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asprawl: List<Asprawl>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attractive: List<Boolean?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val barksome: Map<String, Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bedesman: List<Bedesman>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val belard: List<Belard>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bocking: List<Bocking>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brawlingly: List<Brawlingly>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brookie: List<Brookie>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bumboatman: List<Bumboatman>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bystreet: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val calaverite: List<Calaverite>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val catallactic: List<Catallactic>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cemental: List<Cemental>,

    @get:JsonProperty("Chytridiaceae", required=true)@field:JsonProperty("Chytridiaceae", required=true)
    val chytridiaceae: List<ChytridiaceaeElement>,

    @get:JsonProperty("Discordia", required=true)@field:JsonProperty("Discordia", required=true)
    val discordia: List<DiscordiaElement>,

    @get:JsonProperty("Endomyces", required=true)@field:JsonProperty("Endomyces", required=true)
    val endomyces: List<Endomyce>,

    @get:JsonProperty("Epinephelidae", required=true)@field:JsonProperty("Epinephelidae", required=true)
    val epinephelidae: List<Epinephelidae>,

    @get:JsonProperty("Eupatorium", required=true)@field:JsonProperty("Eupatorium", required=true)
    val eupatorium: List<Eupatorium>,

    @get:JsonProperty("Gryphosaurus", required=true)@field:JsonProperty("Gryphosaurus", required=true)
    val gryphosaurus: List<GryphosaurusElement>,

    @get:JsonProperty("Koryak", required=true)@field:JsonProperty("Koryak", required=true)
    val koryak: List<Koryak>,

    @get:JsonProperty("Lavinia", required=true)@field:JsonProperty("Lavinia", required=true)
    val lavinia: List<LaviniaElement>,

    @get:JsonProperty("Oskar", required=true)@field:JsonProperty("Oskar", required=true)
    val oskar: List<OskarElement>,

    @get:JsonProperty("Rebecca", required=true)@field:JsonProperty("Rebecca", required=true)
    val rebecca: List<RebeccaElement>,

    @get:JsonProperty("Rhomboganoidei", required=true)@field:JsonProperty("Rhomboganoidei", required=true)
    val rhomboganoidei: List<Rhomboganoidei>,

    @get:JsonProperty("Rigsmal", required=true)@field:JsonProperty("Rigsmal", required=true)
    val rigsmal: Boolean,

    @get:JsonProperty("Ruellia", required=true)@field:JsonProperty("Ruellia", required=true)
    val ruellia: List<Ruellia>,

    @get:JsonProperty("School", required=true)@field:JsonProperty("School", required=true)
    val school: List<School>,

    @get:JsonProperty("Shakespearolater", required=true)@field:JsonProperty("Shakespearolater", required=true)
    val shakespearolater: List<Shakespearolater>,

    @get:JsonProperty("Svan", required=true)@field:JsonProperty("Svan", required=true)
    val svan: List<Double>,

    @get:JsonProperty("Wayao", required=true)@field:JsonProperty("Wayao", required=true)
    val wayao: Map<String, Double>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class Abranchiata {
    class IntegerArrayValue(val value: List<Long>) : Abranchiata()
    class IntegerValue(val value: Long)            : Abranchiata()
    class NullValue()                              : Abranchiata()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Abranchiata = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Academe {
    class IntegerArrayValue(val value: List<Long>)      : Academe()
    class IntegerMapValue(val value: Map<String, Long>) : Academe()
    class IntegerValue(val value: Long)                 : Academe()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
        is IntegerValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Academe = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Acquirable {
    class IntegerMapValue(val value: Map<String, Long>) : Acquirable()
    class UnionArrayValue(val value: List<Long?>)       : Acquirable()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is UnionArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Acquirable = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode  -> UnionArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Aerometry {
    class BoolValue(val value: Boolean)  : Aerometry()
    class DoubleValue(val value: Double) : Aerometry()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is DoubleValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Aerometry = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Alexin {
    class BoolValue(val value: Boolean)            : Alexin()
    class IntegerArrayValue(val value: List<Long>) : Alexin()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is IntegerArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Alexin = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class AlleviateElement {
    class AlleviateClassValue(val value: AlleviateClass) : AlleviateElement()
    class UnionArrayValue(val value: List<Long?>)        : AlleviateElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AlleviateClassValue -> this.value
        is UnionArrayValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): AlleviateElement = when (jn) {
            is ObjectNode -> AlleviateClassValue(mapper.convertValue(jn))
            is ArrayNode  -> UnionArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class AlleviateClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val apriori: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val beggarer: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brokenheartedly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val debilitation: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val frike: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gastrolith: Any? = null,

    @get:JsonProperty("Hulsean", required=true)@field:JsonProperty("Hulsean", required=true)
    val hulsean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val orthocentric: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val petaly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val probudgeting: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reacquire: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scow: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shutoff: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subcontiguous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val suffumigate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val transformable: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uncoroneted: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unparking: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unvarnishedness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val wherewithal: Any? = null
)

sealed class Amaa {
    class BoolValue(val value: Boolean)    : Amaa()
    class IntegerValue(val value: Long)    : Amaa()
    class RebeccaValue(val value: Rebecca) : Amaa()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is IntegerValue -> this.value
        is RebeccaValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Amaa = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> RebeccaValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class Rebecca (
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

sealed class Ambassage {
    class NullArrayValue(val value: List<Any?>) : Ambassage()
    class StringValue(val value: String)        : Ambassage()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue -> this.value
        is StringValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Ambassage = when (jn) {
            is ArrayNode -> NullArrayValue(mapper.convertValue(jn))
            is TextNode  -> StringValue(mapper.convertValue(jn))
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Amphithyron (
    val akroasis: Long? = null,
    val antiphonical: Long? = null,
    val basebred: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val conductometric: Long? = null,
    val disdiapason: String? = null,
    val ensilation: Long? = null,
    val eyebolt: Long? = null,
    val fistulated: Long? = null,
    val heteropod: Long? = null,
    val homocerc: Boolean? = null,

    @get:JsonProperty("Juniperus")@field:JsonProperty("Juniperus")
    val juniperus: Long? = null,

    val labyrinthically: Long? = null,
    val martyrization: Long? = null,
    val mispolicy: Long? = null,
    val multipara: Long? = null,

    @get:JsonProperty("Nazirite")@field:JsonProperty("Nazirite")
    val nazirite: Long? = null,

    val nonbookish: Any? = null,
    val possessorial: Long? = null,
    val shamed: Long? = null,
    val shelfworn: Long? = null,
    val stagnum: Long? = null,

    @get:JsonProperty("Those")@field:JsonProperty("Those")
    val those: Long? = null,

    val undecimal: Long? = null
)

sealed class AnkeeElement {
    class AnkeeClassValue(val value: AnkeeClass)   : AnkeeElement()
    class IntegerArrayValue(val value: List<Long>) : AnkeeElement()
    class IntegerValue(val value: Long)            : AnkeeElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnkeeClassValue   -> this.value
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): AnkeeElement = when (jn) {
            is ObjectNode           -> AnkeeClassValue(mapper.convertValue(jn))
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class AnkeeClass (
    @get:JsonProperty("Anomoean", required=true)@field:JsonProperty("Anomoean", required=true)
    val anomoean: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val barleyhood: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val befriender: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val brutishness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cephalalgy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cirurgian: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val conventionally: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jackshay: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val milammeter: Any? = null,

    @get:JsonProperty("Naja", required=true)@field:JsonProperty("Naja", required=true)
    val naja: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ombrological: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val phonasthenia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val retrievableness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val snakily: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val swot: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tartlet: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thiofuran: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tracheophone: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tuglike: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unscratchingly: Any? = null
)

sealed class AnsarieElement {
    class AnsarieClassValue(val value: AnsarieClass) : AnsarieElement()
    class IntegerArrayValue(val value: List<Long>)   : AnsarieElement()
    class NullValue()                                : AnsarieElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnsarieClassValue -> this.value
        is IntegerArrayValue -> this.value
        is NullValue         -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): AnsarieElement = when (jn) {
            is ObjectNode -> AnsarieClassValue(mapper.convertValue(jn))
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is NullNode   -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}

data class AnsarieClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val accension: Any? = null,

    @get:JsonProperty("Alida", required=true)@field:JsonProperty("Alida", required=true)
    val alida: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val asteria: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val beriberic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val edgebone: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gastrodialysis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val geographic: Any? = null,

    @get:JsonProperty("Ictonyx", required=true)@field:JsonProperty("Ictonyx", required=true)
    val ictonyx: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metrocele: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val misgraft: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val monteith: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val notcher: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prorestriction: Any? = null,

    @get:JsonProperty("Ramist", required=true)@field:JsonProperty("Ramist", required=true)
    val ramist: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val throatlet: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unfair: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unsynonymous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val water: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val zestfully: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val zincic: Any? = null
)

sealed class Aphasia {
    class IntegerArrayValue(val value: List<Long>) : Aphasia()
    class IntegerValue(val value: Long)            : Aphasia()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Aphasia = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Asprawl {
    class DoubleValue(val value: Double) : Asprawl()
    class StringValue(val value: String) : Asprawl()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Asprawl = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Bedesman {
    class BoolValue(val value: Boolean)  : Bedesman()
    class DoubleValue(val value: Double) : Bedesman()
    class StringValue(val value: String) : Bedesman()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Bedesman = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Belard {
    class DoubleValue(val value: Double)           : Belard()
    class IntegerArrayValue(val value: List<Long>) : Belard()
    class RebeccaValue(val value: Rebecca)         : Belard()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
        is RebeccaValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Belard = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode                          -> RebeccaValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class Bocking {
    class BoolValue(val value: Boolean)                 : Bocking()
    class IntegerArrayValue(val value: List<Long>)      : Bocking()
    class IntegerMapValue(val value: Map<String, Long>) : Bocking()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue         -> this.value
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Bocking = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ArrayNode   -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode  -> IntegerMapValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Brawlingly {
    class NullArrayValue(val value: List<Any?>)        : Brawlingly()
    class UnionMapValue(val value: Map<String, Long?>) : Brawlingly()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue -> this.value
        is UnionMapValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Brawlingly = when (jn) {
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            is ObjectNode -> UnionMapValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Brookie {
    class IntegerArrayValue(val value: List<Long>) : Brookie()
    class RebeccaValue(val value: Rebecca)         : Brookie()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is RebeccaValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Brookie = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> RebeccaValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Bumboatman {
    class NullArrayValue(val value: List<Any?>) : Bumboatman()
    class StringValue(val value: String)        : Bumboatman()
    class NullValue()                           : Bumboatman()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is NullArrayValue -> this.value
        is StringValue    -> this.value
        is NullValue      -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Bumboatman = when (jn) {
            is ArrayNode -> NullArrayValue(mapper.convertValue(jn))
            is TextNode  -> StringValue(mapper.convertValue(jn))
            is NullNode  -> NullValue()
            else         -> throw IllegalArgumentException()
        }
    }
}

sealed class Calaverite {
    class IntegerArrayValue(val value: List<Long>) : Calaverite()
    class StringValue(val value: String)           : Calaverite()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Calaverite = when (jn) {
            is ArrayNode -> IntegerArrayValue(mapper.convertValue(jn))
            is TextNode  -> StringValue(mapper.convertValue(jn))
            else         -> throw IllegalArgumentException()
        }
    }
}

sealed class Catallactic {
    class BoolValue(val value: Boolean)                 : Catallactic()
    class IntegerMapValue(val value: Map<String, Long>) : Catallactic()
    class NullArrayValue(val value: List<Any?>)         : Catallactic()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerMapValue -> this.value
        is NullArrayValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Catallactic = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode   -> NullArrayValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class Cemental {
    class DoubleValue(val value: Double)                : Cemental()
    class IntegerArrayValue(val value: List<Long>)      : Cemental()
    class IntegerMapValue(val value: Map<String, Long>) : Cemental()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
        is IntegerMapValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Cemental = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode                          -> IntegerMapValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class ChytridiaceaeElement {
    class BoolValue(val value: Boolean)                          : ChytridiaceaeElement()
    class ChytridiaceaeClassValue(val value: ChytridiaceaeClass) : ChytridiaceaeElement()
    class NullValue()                                            : ChytridiaceaeElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue               -> this.value
        is ChytridiaceaeClassValue -> this.value
        is NullValue               -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): ChytridiaceaeElement = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> ChytridiaceaeClassValue(mapper.convertValue(jn))
            is NullNode    -> NullValue()
            else           -> throw IllegalArgumentException()
        }
    }
}

data class ChytridiaceaeClass (
    @get:JsonProperty("Batidaceae", required=true)@field:JsonProperty("Batidaceae", required=true)
    val batidaceae: Any? = null,

    @get:JsonProperty("Brechites", required=true)@field:JsonProperty("Brechites", required=true)
    val brechites: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val codespairer: Any? = null,

    @get:JsonProperty("Emery", required=true)@field:JsonProperty("Emery", required=true)
    val emery: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enervative: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val excriminate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val goshenite: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val grime: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gritten: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hectorly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val intermediation: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val meeterly: Any? = null,

    @get:JsonProperty("Narraganset", required=true)@field:JsonProperty("Narraganset", required=true)
    val narraganset: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val onymatic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val paddlecock: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thana: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thornily: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uckia: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmettle: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vorticellid: Any? = null
)

sealed class DiscordiaElement {
    class DiscordiaClassValue(val value: DiscordiaClass) : DiscordiaElement()
    class IntegerArrayValue(val value: List<Long>)       : DiscordiaElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DiscordiaClassValue -> this.value
        is IntegerArrayValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): DiscordiaElement = when (jn) {
            is ObjectNode -> DiscordiaClassValue(mapper.convertValue(jn))
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class DiscordiaClass (
    @get:JsonProperty("Altaic")@field:JsonProperty("Altaic")
    val altaic: Long? = null,

    val amoristic: Long? = null,
    val blennophthalmia: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val disciplinability: Long? = null,
    val disdiapason: String? = null,
    val goofer: Long? = null,
    val homocerc: Boolean? = null,
    val laryngograph: Long? = null,
    val leucitis: Long? = null,
    val lymphocyst: Long? = null,
    val microcosmology: Long? = null,
    val nauseation: Long? = null,
    val nonbookish: Any? = null,

    @get:JsonProperty("Patarin")@field:JsonProperty("Patarin")
    val patarin: Long? = null,

    val preliberal: Long? = null,
    val prettifier: Long? = null,
    val rangework: Long? = null,
    val redient: Long? = null,
    val subfusiform: Long? = null,
    val suicidical: Long? = null,
    val swow: Long? = null,
    val wastrel: Long? = null,
    val wingle: Long? = null
)

sealed class Endomyce {
    class IntegerValue(val value: Long)  : Endomyce()
    class StringValue(val value: String) : Endomyce()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Endomyce = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Epinephelidae {
    class BoolValue(val value: Boolean)  : Epinephelidae()
    class IntegerValue(val value: Long)  : Epinephelidae()
    class StringValue(val value: String) : Epinephelidae()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Epinephelidae = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Eupatorium {
    class IntegerMapValue(val value: Map<String, Long>) : Eupatorium()
    class NullArrayValue(val value: List<Any?>)         : Eupatorium()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is NullArrayValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Eupatorium = when (jn) {
            is ObjectNode -> IntegerMapValue(mapper.convertValue(jn))
            is ArrayNode  -> NullArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class GryphosaurusElement {
    class GryphosaurusClassValue(val value: GryphosaurusClass) : GryphosaurusElement()
    class IntegerArrayValue(val value: List<Long>)             : GryphosaurusElement()
    class StringValue(val value: String)                       : GryphosaurusElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is GryphosaurusClassValue -> this.value
        is IntegerArrayValue      -> this.value
        is StringValue            -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): GryphosaurusElement = when (jn) {
            is ObjectNode -> GryphosaurusClassValue(mapper.convertValue(jn))
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class GryphosaurusClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amissibility: Any? = null,

    @get:JsonProperty("Burushaski", required=true)@field:JsonProperty("Burushaski", required=true)
    val burushaski: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val citronin: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coplaintiff: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disquisitionary: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enoplan: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val faintness: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hebetomy: Any? = null,

    @get:JsonProperty("islandry", required=true)@field:JsonProperty("islandry", required=true)
    val islandry: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lameduck: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val overbattle: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val overinterested: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val phrenologic: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rainband: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shiningly: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stamineous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subscapularis: Any? = null,

    @get:JsonProperty("Tahami", required=true)@field:JsonProperty("Tahami", required=true)
    val tahami: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undaubed: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val underntime: Any? = null
)

sealed class Koryak {
    class StringValue(val value: String)               : Koryak()
    class UnionMapValue(val value: Map<String, Long?>) : Koryak()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is StringValue   -> this.value
        is UnionMapValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Koryak = when (jn) {
            is TextNode   -> StringValue(mapper.convertValue(jn))
            is ObjectNode -> UnionMapValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class LaviniaElement {
    class LaviniaClassValue(val value: LaviniaClass) : LaviniaElement()
    class StringValue(val value: String)             : LaviniaElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is LaviniaClassValue -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): LaviniaElement = when (jn) {
            is ObjectNode -> LaviniaClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class LaviniaClass (
    val agitable: Long? = null,
    val asininity: Long? = null,
    val benefiter: Long? = null,
    val bronzelike: Long? = null,
    val catharticalness: Double? = null,

    @get:JsonProperty("Chirotherium")@field:JsonProperty("Chirotherium")
    val chirotherium: Long? = null,

    val cholesteatomatous: Long? = null,
    val deprivement: Long? = null,
    val disdiapason: String? = null,
    val flippantness: Long? = null,
    val fogproof: Long? = null,
    val homocerc: Boolean? = null,
    val merrymeeting: Long? = null,
    val nonbookish: Any? = null,
    val overcareful: Long? = null,
    val panaris: Long? = null,
    val preacceptance: Long? = null,
    val quinoxaline: Long? = null,
    val sig: Long? = null,
    val superconfusion: Long? = null,

    @get:JsonProperty("Tacana")@field:JsonProperty("Tacana")
    val tacana: Long? = null,

    val tillotter: Long? = null,
    val tranquillize: Long? = null,
    val unquestionable: Long? = null,
    val uproute: Long? = null
)

sealed class OskarElement {
    class IntegerArrayValue(val value: List<Long>) : OskarElement()
    class OskarClassValue(val value: OskarClass)   : OskarElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is OskarClassValue   -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): OskarElement = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> OskarClassValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class OskarClass (
    @get:JsonProperty("Acrobates", required=true)@field:JsonProperty("Acrobates", required=true)
    val acrobates: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val beanshooter: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bearhound: Any? = null,

    @get:JsonProperty("Cayuga", required=true)@field:JsonProperty("Cayuga", required=true)
    val cayuga: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val guarneri: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hypochondriacism: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indication: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jaculative: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nagana: Any? = null,

    @get:JsonProperty("Netherlandish", required=true)@field:JsonProperty("Netherlandish", required=true)
    val netherlandish: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val noctivagous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nonphysiological: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val praxis: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val provision: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subterhuman: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sunlit: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val syncraniate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teachment: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unmutinous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unstoppable: Any? = null
)

sealed class RebeccaElement {
    class IntegerValue(val value: Long)    : RebeccaElement()
    class RebeccaValue(val value: Rebecca) : RebeccaElement()
    class StringValue(val value: String)   : RebeccaElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is RebeccaValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): RebeccaElement = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> RebeccaValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Rhomboganoidei {
    class IntegerArrayValue(val value: List<Long>) : Rhomboganoidei()
    class RebeccaValue(val value: Rebecca)         : Rhomboganoidei()
    class StringValue(val value: String)           : Rhomboganoidei()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is RebeccaValue      -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Rhomboganoidei = when (jn) {
            is ArrayNode  -> IntegerArrayValue(mapper.convertValue(jn))
            is ObjectNode -> RebeccaValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

sealed class Ruellia {
    class BoolValue(val value: Boolean)    : Ruellia()
    class RebeccaValue(val value: Rebecca) : Ruellia()
    class StringValue(val value: String)   : Ruellia()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is RebeccaValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Ruellia = when (jn) {
            is BooleanNode -> BoolValue(mapper.convertValue(jn))
            is ObjectNode  -> RebeccaValue(mapper.convertValue(jn))
            is TextNode    -> StringValue(mapper.convertValue(jn))
            else           -> throw IllegalArgumentException()
        }
    }
}

sealed class School {
    class IntegerMapValue(val value: Map<String, Long>) : School()
    class IntegerValue(val value: Long)                 : School()
    class NullValue()                                   : School()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerMapValue -> this.value
        is IntegerValue    -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): School = when (jn) {
            is ObjectNode           -> IntegerMapValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class Shakespearolater {
    class DoubleValue(val value: Double)           : Shakespearolater()
    class IntegerArrayValue(val value: List<Long>) : Shakespearolater()
    class StringValue(val value: String)           : Shakespearolater()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue       -> this.value
        is IntegerArrayValue -> this.value
        is StringValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Shakespearolater = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is ArrayNode                           -> IntegerArrayValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}
