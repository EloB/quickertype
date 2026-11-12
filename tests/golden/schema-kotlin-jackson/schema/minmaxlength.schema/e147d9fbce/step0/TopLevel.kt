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
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    convert(InUnion::class, { InUnion.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val intersection: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inUnion: InUnion,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maxlength: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minlength: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minMaxIntersection: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minmaxlength: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minMaxUnion: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: String
) {
    init {
        require(intersection.codePointCount(0, intersection.length) >= 4)
        require(intersection.codePointCount(0, intersection.length) <= 5)
        require(maxlength.codePointCount(0, maxlength.length) <= 5)
        require(minlength.codePointCount(0, minlength.length) >= 3)
        require(minMaxIntersection.codePointCount(0, minMaxIntersection.length) >= 3)
        require(minMaxIntersection.codePointCount(0, minMaxIntersection.length) <= 5)
        require(minmaxlength.codePointCount(0, minmaxlength.length) >= 3)
        require(minmaxlength.codePointCount(0, minmaxlength.length) <= 5)
        require(union.codePointCount(0, union.length) >= 3)
        require(union.codePointCount(0, union.length) <= 6)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class InUnion {
    class DoubleValue(val value: Double) : InUnion()
    class StringValue(val value: String) : InUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): InUnion = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}
