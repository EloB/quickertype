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

/**
 * Comment delimiters:
 * * /
 * / *
 * {-
 * -}
 * """
 * </summary> & <br>
 * }
 * }
 * }
 * }
 * }
 */
data class TopLevel (
    /**
     * Ends with a backslash \
     */
    val trailingBackslash: String? = null,

    /**
     * Ends with a quote "
     */
    val trailingQuote: String? = null,

    /**
     * Ends with a triple quote """
     */
    val trailingTripleQuote: String? = null,

    /**
     * Property delimiters:
     * * /
     * / *
     * {-
     * -}
     * """
     * </summary> & <br>
     * }
     * }
     * }
     * }
     * }
     */
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
