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
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(UnionItem::class, { UnionItem.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maxOnly: List<Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minAndMax: List<Double>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minOnly: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val plain: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unionItems: List<UnionItem>
) {
    init {
        require(maxOnly.size <= 3)
        require(minAndMax.size >= 1)
        require(minAndMax.size <= 4)
        require(minOnly.size >= 2)
        require(unionItems.size >= 2)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class UnionItem {
    class IntegerValue(val value: Long)  : UnionItem()
    class StringValue(val value: String) : UnionItem()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): UnionItem = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}
