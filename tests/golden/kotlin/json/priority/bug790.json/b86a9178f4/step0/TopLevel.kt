// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    @Json(name = "children_data")
    val childrenData: List<TopLevel>,

    val id: Long,

    @Json(name = "is_active")
    val isActive: Boolean,

    val level: Long,
    val name: String,

    @Json(name = "parent_id")
    val parentID: Long,

    val position: Long,

    @Json(name = "product_count")
    val productCount: Long
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
