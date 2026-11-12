// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(Category::class, { Category.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val prizes: List<Prize>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Prize (
    val category: Category,
    val laureates: List<Laureate>,
    val overallMotivation: String? = null,
    val year: String
)

enum class Category(val value: String) {
    Physics("physics"),
    Chemistry("chemistry"),
    Medicine("medicine"),
    Literature("literature"),
    Peace("peace"),
    Economics("economics");

    companion object {
        public fun fromValue(value: String): Category = when (value) {
            "physics"    -> Physics
            "chemistry"  -> Chemistry
            "medicine"   -> Medicine
            "literature" -> Literature
            "peace"      -> Peace
            "economics"  -> Economics
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Laureate (
    val firstname: String,
    val id: String,
    val motivation: String? = null,
    val share: String,
    val surname: String
)
