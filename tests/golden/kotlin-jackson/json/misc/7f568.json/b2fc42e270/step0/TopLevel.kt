// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

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
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(Language::class,       { Language.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,           { Type.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comments: Long,

    @get:JsonProperty("comments_url", required=true)@field:JsonProperty("comments_url", required=true)
    val commentsURL: String,

    @get:JsonProperty("commits_url", required=true)@field:JsonProperty("commits_url", required=true)
    val commitsURL: String,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val files: Map<String, File>,

    @get:JsonProperty("forks_url", required=true)@field:JsonProperty("forks_url", required=true)
    val forksURL: String,

    @get:JsonProperty("git_pull_url", required=true)@field:JsonProperty("git_pull_url", required=true)
    val gitPullURL: String,

    @get:JsonProperty("git_push_url", required=true)@field:JsonProperty("git_push_url", required=true)
    val gitPushURL: String,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val public: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val truncated: Boolean,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val user: Any? = null
)

data class File (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val filename: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: Language?,

    @get:JsonProperty("raw_url", required=true)@field:JsonProperty("raw_url", required=true)
    val rawURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val size: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type
)

enum class Language(val value: String) {
    Markdown("Markdown");

    companion object {
        fun fromValue(value: String): Language = when (value) {
            "Markdown" -> Markdown
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    TextPlain("text/plain");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "text/plain" -> TextPlain
            else         -> throw IllegalArgumentException()
        }
    }
}
