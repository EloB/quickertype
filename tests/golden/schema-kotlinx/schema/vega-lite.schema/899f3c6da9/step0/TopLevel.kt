// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    /**
     * URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
     * have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
     * Setting the `$schema` property allows automatic validation and autocomplete in editors
     * that support JSON schema.
     */
    @SerialName("\$schema")
    val schema: String? = null,

    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    val autosize: JsonElement? = null,

    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    val background: String? = null,

    /**
     * Vega-Lite configuration object.  This property can only be defined at the top-level of a
     * specification.
     */
    val config: Config? = null,

    /**
     * An object describing the data source
     */
    val data: Data? = null,

    /**
     * Description of this mark for commenting purpose.
     */
    val description: String? = null,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding: EncodingWithFacet? = null,

    /**
     * The height of a visualization.
     *
     * __Default value:__
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
     * [continuous scale](scale.html#continuous), the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the height is [determined by the range step, paddings, and the
     * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
     * `rangeStep` is `null`, the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
     *
     * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the height of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val height: Double? = null,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark: JsonElement? = null,

    /**
     * Name of the visualization for later reference.
     */
    val name: String? = null,

    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    val padding: JsonElement? = null,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection: Projection? = null,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection: Map<String, SelectionDef>? = null,

    /**
     * Title for the plot.
     */
    val title: JsonElement? = null,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform: List<Transform>? = null,

    /**
     * The width of a visualization.
     *
     * __Default value:__ This will be determined by the following rules:
     *
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
     * [continuous scale](scale.html#continuous), the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the width is [determined by the range step, paddings, and the
     * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
     * `rangeStep` is `null`, the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - If no field is mapped to `x` channel, the `width` will be the value of
     * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
     * the value of `rangeStep` for other marks.
     *
     * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the width of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val width: Double? = null,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer: List<LayerSpec>? = null,

    /**
     * Scale, axis, and legend resolutions for layers.
     *
     * Scale, axis, and legend resolutions for facets.
     *
     * Scale and legend resolutions for repeated charts.
     *
     * Scale, axis, and legend resolutions for vertically concatenated charts.
     *
     * Scale, axis, and legend resolutions for horizontally concatenated charts.
     */
    val resolve: Resolve? = null,

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    val facet: FacetMapping? = null,

    /**
     * A specification of the view that gets faceted.
     */
    val spec: Spec? = null,

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    val repeat: Repeat? = null,

    /**
     * A list of views that should be concatenated and put into a column.
     */
    val vconcat: List<Spec>? = null,

    /**
     * A list of views that should be concatenated and put into a row.
     */
    val hconcat: List<Spec>? = null
)

typealias Autosize = JsonElement

@Serializable
data class AutoSizeParams (
    /**
     * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
     * The default setting (`"content"`) interprets the width and height settings as the data
     * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
     * `"padding"` setting includes the padding within the view size calculations, such that the
     * width and height settings indicate the **total** intended size of the view.
     *
     * __Default value__: `"content"`
     */
    val contains: Contains? = null,

    /**
     * A boolean flag indicating if autosize layout should be re-calculated on every view
     * update.
     *
     * __Default value__: `false`
     */
    val resize: Boolean? = null,

    /**
     * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
     * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
     * descriptions of each.
     *
     * __Default value__: `"pad"`
     */
    val type: AutosizeType? = null
)

/**
 * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
 * The default setting (`"content"`) interprets the width and height settings as the data
 * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
 * `"padding"` setting includes the padding within the view size calculations, such that the
 * width and height settings indicate the **total** intended size of the view.
 *
 * __Default value__: `"content"`
 */
@Serializable
enum class Contains(val value: String) {
    @SerialName("content") Content("content"),
    @SerialName("padding") Padding("padding");
}

/**
 * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
 * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
 * descriptions of each.
 *
 * __Default value__: `"pad"`
 */
@Serializable
enum class AutosizeType(val value: String) {
    @SerialName("pad") Pad("pad"),
    @SerialName("fit") Fit("fit"),
    @SerialName("none") None("none");
}

/**
 * Vega-Lite configuration object.  This property can only be defined at the top-level of a
 * specification.
 */
@Serializable
data class Config (
    /**
     * Area-Specific Config
     */
    val area: MarkConfig? = null,

    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    val autosize: JsonElement? = null,

    /**
     * Axis configuration, which determines default properties for all `x` and `y`
     * [axes](axis.html). For a full list of axis configuration options, please see the
     * [corresponding section of the axis documentation](axis.html#config).
     */
    val axis: AxisConfig? = null,

    /**
     * Specific axis config for axes with "band" scales.
     */
    val axisBand: VGAxisConfig? = null,

    /**
     * Specific axis config for x-axis along the bottom edge of the chart.
     */
    val axisBottom: VGAxisConfig? = null,

    /**
     * Specific axis config for y-axis along the left edge of the chart.
     */
    val axisLeft: VGAxisConfig? = null,

    /**
     * Specific axis config for y-axis along the right edge of the chart.
     */
    val axisRight: VGAxisConfig? = null,

    /**
     * Specific axis config for x-axis along the top edge of the chart.
     */
    val axisTop: VGAxisConfig? = null,

    /**
     * X-axis specific config.
     */
    val axisX: VGAxisConfig? = null,

    /**
     * Y-axis specific config.
     */
    val axisY: VGAxisConfig? = null,

    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    val background: String? = null,

    /**
     * Bar-Specific Config
     */
    val bar: BarConfig? = null,

    /**
     * Circle-Specific Config
     */
    val circle: MarkConfig? = null,

    /**
     * Default axis and legend title for count fields.
     *
     * __Default value:__ `'Number of Records'`.
     */
    val countTitle: String? = null,

    /**
     * Defines how Vega-Lite generates title for fields.  There are three possible styles:
     *
     * - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
     * "Year-month of date", "field (binned)").
     * - `"function"` - displays function using parentheses and capitalized texts (e.g.,
     * "SUM(field)", "YEARMONTH(date)", "BIN(field)").
     * - `"plain"` - displays only the field name without functions (e.g., "field", "date",
     * "field").
     */
    val fieldTitle: FieldTitle? = null,

    /**
     * Geoshape-Specific Config
     */
    val geoshape: MarkConfig? = null,

    /**
     * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
     * - If set to `"filter"` (default), all data items with null values are filtered.
     * - If `null`, all data items are included. In this case, invalid values will be
     * interpreted as zeroes.
     */
    val invalidValues: InvalidValues? = null,

    /**
     * Legend configuration, which determines default properties for all [legends](legend.html).
     * For a full list of legend configuration options, please see the [corresponding section of
     * in the legend documentation](legend.html#config).
     */
    val legend: LegendConfig? = null,

    /**
     * Line-Specific Config
     */
    val line: MarkConfig? = null,

    /**
     * Mark Config
     */
    val mark: MarkConfig? = null,

    /**
     * D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
     * number format pattern](https://github.com/d3/d3-format#locale_format).
     */
    val numberFormat: String? = null,

    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    val padding: JsonElement? = null,

    /**
     * Point-Specific Config
     */
    val point: MarkConfig? = null,

    /**
     * Projection configuration, which determines default properties for all
     * [projections](projection.html). For a full list of projection configuration options,
     * please see the [corresponding section of the projection
     * documentation](projection.html#config).
     */
    val projection: ProjectionConfig? = null,

    /**
     * An object hash that defines default range arrays or schemes for using with scales.
     * For a full list of scale range configuration options, please see the [corresponding
     * section of the scale documentation](scale.html#config).
     */
    val range: JsonObject? = null,

    /**
     * Rect-Specific Config
     */
    val rect: MarkConfig? = null,

    /**
     * Rule-Specific Config
     */
    val rule: MarkConfig? = null,

    /**
     * Scale configuration determines default properties for all [scales](scale.html). For a
     * full list of scale configuration options, please see the [corresponding section of the
     * scale documentation](scale.html#config).
     */
    val scale: ScaleConfig? = null,

    /**
     * An object hash for defining default properties for each type of selections.
     */
    val selection: SelectionConfig? = null,

    /**
     * Square-Specific Config
     */
    val square: MarkConfig? = null,

    /**
     * Default stack offset for stackable mark.
     */
    val stack: StackOffset? = null,

    /**
     * An object hash that defines key-value mappings to determine default properties for marks
     * with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
     * valid [mark configuration objects](mark.html#config).
     */
    val style: Map<String, VGMarkConfig>? = null,

    /**
     * Text-Specific Config
     */
    val text: TextConfig? = null,

    /**
     * Tick-Specific Config
     */
    val tick: TickConfig? = null,

    /**
     * Default datetime format for axis and legend labels. The format can be set directly on
     * each axis and legend. Use [D3's time format
     * pattern](https://github.com/d3/d3-time-format#locale_format).
     *
     * __Default value:__ `'%b %d, %Y'`.
     */
    val timeFormat: String? = null,

    /**
     * Title configuration, which determines default properties for all [titles](title.html).
     * For a full list of title configuration options, please see the [corresponding section of
     * the title documentation](title.html#config).
     */
    val title: VGTitleConfig? = null,

    /**
     * Default properties for [single view plots](spec.html#single).
     */
    val view: ViewConfig? = null
)

/**
 * Area-Specific Config
 *
 * Circle-Specific Config
 *
 * Geoshape-Specific Config
 *
 * Line-Specific Config
 *
 * Mark Config
 *
 * Point-Specific Config
 *
 * Rect-Specific Config
 *
 * Rule-Specific Config
 *
 * Square-Specific Config
 */
@Serializable
data class MarkConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color: String? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled: Boolean? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null
)

/**
 * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
 */
@Serializable
enum class HorizontalAlign(val value: String) {
    @SerialName("left") Left("left"),
    @SerialName("right") Right("right"),
    @SerialName("center") Center("center");
}

/**
 * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
 *
 * __Default value:__ `"middle"`
 *
 * Vertical text baseline for title text.
 */
@Serializable
enum class VerticalAlign(val value: String) {
    @SerialName("top") Top("top"),
    @SerialName("middle") Middle("middle"),
    @SerialName("bottom") Bottom("bottom");
}

/**
 * The mouse cursor used over the mark. Any valid [CSS cursor
 * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
 */
@Serializable
enum class Cursor(val value: String) {
    @SerialName("auto") Auto("auto"),
    @SerialName("default") Default("default"),
    @SerialName("none") None("none"),
    @SerialName("context-menu") ContextMenu("context-menu"),
    @SerialName("help") Help("help"),
    @SerialName("pointer") Pointer("pointer"),
    @SerialName("progress") Progress("progress"),
    @SerialName("wait") Wait("wait"),
    @SerialName("cell") Cell("cell"),
    @SerialName("crosshair") Crosshair("crosshair"),
    @SerialName("text") Text("text"),
    @SerialName("vertical-text") VerticalText("vertical-text"),
    @SerialName("alias") Alias("alias"),
    @SerialName("copy") Copy("copy"),
    @SerialName("move") Move("move"),
    @SerialName("no-drop") NoDrop("no-drop"),
    @SerialName("not-allowed") NotAllowed("not-allowed"),
    @SerialName("e-resize") EResize("e-resize"),
    @SerialName("n-resize") NResize("n-resize"),
    @SerialName("ne-resize") NeResize("ne-resize"),
    @SerialName("nw-resize") NwResize("nw-resize"),
    @SerialName("s-resize") SResize("s-resize"),
    @SerialName("se-resize") SEResize("se-resize"),
    @SerialName("sw-resize") SwResize("sw-resize"),
    @SerialName("w-resize") WResize("w-resize"),
    @SerialName("ew-resize") EwResize("ew-resize"),
    @SerialName("ns-resize") NSResize("ns-resize"),
    @SerialName("nesw-resize") NeswResize("nesw-resize"),
    @SerialName("nwse-resize") NwseResize("nwse-resize"),
    @SerialName("col-resize") ColResize("col-resize"),
    @SerialName("row-resize") RowResize("row-resize"),
    @SerialName("all-scroll") AllScroll("all-scroll"),
    @SerialName("zoom-in") ZoomIn("zoom-in"),
    @SerialName("zoom-out") ZoomOut("zoom-out"),
    @SerialName("grab") Grab("grab"),
    @SerialName("grabbing") Grabbing("grabbing");
}

/**
 * The font style (e.g., `"italic"`).
 */
@Serializable
enum class FontStyle(val value: String) {
    @SerialName("normal") Normal("normal"),
    @SerialName("italic") Italic("italic");
}

typealias FontWeightUnion = JsonElement

@Serializable
enum class FontWeight(val value: String) {
    @SerialName("normal") Normal("normal"),
    @SerialName("bold") Bold("bold");
}

/**
 * The line interpolation method to use for line and area marks. One of the following:
 * - `"linear"`: piecewise linear segments, as in a polyline.
 * - `"linear-closed"`: close the linear segments to form a polygon.
 * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
 * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
 * function.
 * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
 * function.
 * - `"basis"`: a B-spline, with control point duplication on the ends.
 * - `"basis-open"`: an open B-spline; may not intersect the start or end.
 * - `"basis-closed"`: a closed B-spline, as in a loop.
 * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
 * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
 * will intersect other control points.
 * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
 * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
 * spline.
 * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
 */
@Serializable
enum class Interpolate(val value: String) {
    @SerialName("linear") Linear("linear"),
    @SerialName("linear-closed") LinearClosed("linear-closed"),
    @SerialName("step") Step("step"),
    @SerialName("step-before") StepBefore("step-before"),
    @SerialName("step-after") StepAfter("step-after"),
    @SerialName("basis") Basis("basis"),
    @SerialName("basis-open") BasisOpen("basis-open"),
    @SerialName("basis-closed") BasisClosed("basis-closed"),
    @SerialName("cardinal") Cardinal("cardinal"),
    @SerialName("cardinal-open") CardinalOpen("cardinal-open"),
    @SerialName("cardinal-closed") CardinalClosed("cardinal-closed"),
    @SerialName("bundle") Bundle("bundle"),
    @SerialName("monotone") Monotone("monotone");
}

/**
 * The orientation of a non-stacked bar, tick, area, and line charts.
 * The value is either horizontal (default) or vertical.
 * - For bar, rule and tick, this determines whether the size of the bar and tick
 * should be applied to x or y dimension.
 * - For area, this property determines the orient property of the Vega output.
 * - For line, this property determines the sort order of the points in the line
 * if `config.sortLineBy` is not specified.
 * For stacked charts, this is always determined by the orientation of the stack;
 * therefore explicitly specified value will be ignored.
 */
@Serializable
enum class Orient(val value: String) {
    @SerialName("horizontal") Horizontal("horizontal"),
    @SerialName("vertical") Vertical("vertical");
}

/**
 * Axis configuration, which determines default properties for all `x` and `y`
 * [axes](axis.html). For a full list of axis configuration options, please see the
 * [corresponding section of the axis documentation](axis.html#config).
 */
@Serializable
data class AxisConfig (
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    val bandPosition: Double? = null,

    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain: Boolean? = null,

    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainColor: String? = null,

    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainWidth: Double? = null,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid: Boolean? = null,

    /**
     * Color of gridlines.
     */
    val gridColor: String? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    val gridDash: List<Double>? = null,

    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    val gridOpacity: Double? = null,

    /**
     * The grid width, in pixels.
     */
    val gridWidth: Double? = null,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle: Double? = null,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound: JsonElement? = null,

    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    val labelColor: String? = null,

    /**
     * Indicates if the first and last axis labels should be aligned flush with the scale range.
     * Flush alignment for a horizontal axis will left-align the first label and right-align the
     * last label. For vertical axes, bottom and top text baselines are applied instead. If this
     * property is a number, it also indicates the number of pixels by which to offset the first
     * and last labels; for example, a value of 2 will flush-align the first and last labels and
     * also push them 2 pixels outward from the center of the axis. The additional adjustment
     * can sometimes help the labels better visually group with corresponding axis ticks.
     *
     * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
     */
    val labelFlush: JsonElement? = null,

    /**
     * The font of the tick label.
     */
    val labelFont: String? = null,

    /**
     * The font size of the label, in pixels.
     */
    val labelFontSize: Double? = null,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit: Double? = null,

    /**
     * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
     * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
     * every other label is used (this works well for standard linear axes). If set to
     * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
     * with the last visible label (this often works better for log-scaled axes).
     *
     * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
     * scales; otherwise `false`.
     */
    val labelOverlap: JsonElement? = null,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding: Double? = null,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels: Boolean? = null,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent: Double? = null,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent: Double? = null,

    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    val shortTimeLabels: Boolean? = null,

    /**
     * The color of the axis's tick.
     */
    val tickColor: String? = null,

    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    val tickRound: Boolean? = null,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks: Boolean? = null,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize: Double? = null,

    /**
     * The width, in pixels, of ticks.
     */
    val tickWidth: Double? = null,

    /**
     * Horizontal text alignment of axis titles.
     */
    val titleAlign: String? = null,

    /**
     * Angle in degrees of axis titles.
     */
    val titleAngle: Double? = null,

    /**
     * Vertical text baseline for axis titles.
     */
    val titleBaseline: String? = null,

    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    val titleColor: String? = null,

    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    val titleFont: String? = null,

    /**
     * Font size of the title.
     */
    val titleFontSize: Double? = null,

    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    val titleFontWeight: JsonElement? = null,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit: Double? = null,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength: Double? = null,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding: Double? = null,

    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    val titleX: Double? = null,

    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    val titleY: Double? = null
)

typealias Label = JsonElement

typealias LabelOverlapUnion = JsonElement

@Serializable
enum class LabelOverlapEnum(val value: String) {
    @SerialName("parity") Parity("parity"),
    @SerialName("greedy") Greedy("greedy");
}

typealias TitleFontWeight = JsonElement

/**
 * Specific axis config for axes with "band" scales.
 *
 * Specific axis config for x-axis along the bottom edge of the chart.
 *
 * Specific axis config for y-axis along the left edge of the chart.
 *
 * Specific axis config for y-axis along the right edge of the chart.
 *
 * Specific axis config for x-axis along the top edge of the chart.
 *
 * X-axis specific config.
 *
 * Y-axis specific config.
 */
@Serializable
data class VGAxisConfig (
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    val bandPosition: Double? = null,

    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain: Boolean? = null,

    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainColor: String? = null,

    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainWidth: Double? = null,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid: Boolean? = null,

    /**
     * Color of gridlines.
     */
    val gridColor: String? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    val gridDash: List<Double>? = null,

    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    val gridOpacity: Double? = null,

    /**
     * The grid width, in pixels.
     */
    val gridWidth: Double? = null,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle: Double? = null,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound: JsonElement? = null,

    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    val labelColor: String? = null,

    /**
     * Indicates if the first and last axis labels should be aligned flush with the scale range.
     * Flush alignment for a horizontal axis will left-align the first label and right-align the
     * last label. For vertical axes, bottom and top text baselines are applied instead. If this
     * property is a number, it also indicates the number of pixels by which to offset the first
     * and last labels; for example, a value of 2 will flush-align the first and last labels and
     * also push them 2 pixels outward from the center of the axis. The additional adjustment
     * can sometimes help the labels better visually group with corresponding axis ticks.
     *
     * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
     */
    val labelFlush: JsonElement? = null,

    /**
     * The font of the tick label.
     */
    val labelFont: String? = null,

    /**
     * The font size of the label, in pixels.
     */
    val labelFontSize: Double? = null,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit: Double? = null,

    /**
     * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
     * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
     * every other label is used (this works well for standard linear axes). If set to
     * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
     * with the last visible label (this often works better for log-scaled axes).
     *
     * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
     * scales; otherwise `false`.
     */
    val labelOverlap: JsonElement? = null,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding: Double? = null,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels: Boolean? = null,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent: Double? = null,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent: Double? = null,

    /**
     * The color of the axis's tick.
     */
    val tickColor: String? = null,

    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    val tickRound: Boolean? = null,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks: Boolean? = null,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize: Double? = null,

    /**
     * The width, in pixels, of ticks.
     */
    val tickWidth: Double? = null,

    /**
     * Horizontal text alignment of axis titles.
     */
    val titleAlign: String? = null,

    /**
     * Angle in degrees of axis titles.
     */
    val titleAngle: Double? = null,

    /**
     * Vertical text baseline for axis titles.
     */
    val titleBaseline: String? = null,

    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    val titleColor: String? = null,

    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    val titleFont: String? = null,

    /**
     * Font size of the title.
     */
    val titleFontSize: Double? = null,

    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    val titleFontWeight: JsonElement? = null,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit: Double? = null,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength: Double? = null,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding: Double? = null,

    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    val titleX: Double? = null,

    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    val titleY: Double? = null
)

/**
 * Bar-Specific Config
 */
@Serializable
data class BarConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
     * statisticians) or 1 (Vega-Lite Default, D3 example style).
     *
     * __Default value:__ `1`
     */
    val binSpacing: Double? = null,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color: String? = null,

    /**
     * The default size of the bars on continuous scales.
     *
     * __Default value:__ `5`
     */
    val continuousBandSize: Double? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The size of the bars.  If unspecified, the default size is  `bandSize-1`,
     * which provides 1 pixel offset between bars.
     */
    val discreteBandSize: Double? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled: Boolean? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null
)

/**
 * Defines how Vega-Lite generates title for fields.  There are three possible styles:
 *
 * - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
 * "Year-month of date", "field (binned)").
 * - `"function"` - displays function using parentheses and capitalized texts (e.g.,
 * "SUM(field)", "YEARMONTH(date)", "BIN(field)").
 * - `"plain"` - displays only the field name without functions (e.g., "field", "date",
 * "field").
 */
@Serializable
enum class FieldTitle(val value: String) {
    @SerialName("verbal") Verbal("verbal"),
    @SerialName("functional") Functional("functional"),
    @SerialName("plain") Plain("plain");
}

/**
 * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
 * - If set to `"filter"` (default), all data items with null values are filtered.
 * - If `null`, all data items are included. In this case, invalid values will be
 * interpreted as zeroes.
 */
@Serializable
enum class InvalidValues(val value: String) {
    @SerialName("filter") Filter("filter");
}

/**
 * Legend configuration, which determines default properties for all [legends](legend.html).
 * For a full list of legend configuration options, please see the [corresponding section of
 * in the legend documentation](legend.html#config).
 */
@Serializable
data class LegendConfig (
    /**
     * Corner radius for the full legend.
     */
    val cornerRadius: Double? = null,

    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    val entryPadding: Double? = null,

    /**
     * Background fill color for the full legend.
     */
    val fillColor: String? = null,

    /**
     * The height of the gradient, in pixels.
     */
    val gradientHeight: Double? = null,

    /**
     * Text baseline for color ramp gradient labels.
     */
    val gradientLabelBaseline: String? = null,

    /**
     * The maximum allowed length in pixels of color ramp gradient labels.
     */
    val gradientLabelLimit: Double? = null,

    /**
     * Vertical offset in pixels for color ramp gradient labels.
     */
    val gradientLabelOffset: Double? = null,

    /**
     * The color of the gradient stroke, can be in hex color code or regular color name.
     */
    val gradientStrokeColor: String? = null,

    /**
     * The width of the gradient stroke, in pixels.
     */
    val gradientStrokeWidth: Double? = null,

    /**
     * The width of the gradient, in pixels.
     */
    val gradientWidth: Double? = null,

    /**
     * The alignment of the legend label, can be left, middle or right.
     */
    val labelAlign: String? = null,

    /**
     * The position of the baseline of legend label, can be top, middle or bottom.
     */
    val labelBaseline: String? = null,

    /**
     * The color of the legend label, can be in hex color code or regular color name.
     */
    val labelColor: String? = null,

    /**
     * The font of the legend label.
     */
    val labelFont: String? = null,

    /**
     * The font size of legend label.
     *
     * __Default value:__ `10`.
     */
    val labelFontSize: Double? = null,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit: Double? = null,

    /**
     * The offset of the legend label.
     */
    val labelOffset: Double? = null,

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    val offset: Double? = null,

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    val orient: LegendOrient? = null,

    /**
     * The padding, in pixels, between the legend and axis.
     */
    val padding: Double? = null,

    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    val shortTimeLabels: Boolean? = null,

    /**
     * Border stroke color for the full legend.
     */
    val strokeColor: String? = null,

    /**
     * Border stroke dash pattern for the full legend.
     */
    val strokeDash: List<Double>? = null,

    /**
     * Border stroke width for the full legend.
     */
    val strokeWidth: Double? = null,

    /**
     * The color of the legend symbol,
     */
    val symbolColor: String? = null,

    /**
     * The size of the legend symbol, in pixels.
     */
    val symbolSize: Double? = null,

    /**
     * The width of the symbol's stroke.
     */
    val symbolStrokeWidth: Double? = null,

    /**
     * Default shape type (such as "circle") for legend symbols.
     */
    val symbolType: String? = null,

    /**
     * Horizontal text alignment for legend titles.
     */
    val titleAlign: String? = null,

    /**
     * Vertical text baseline for legend titles.
     */
    val titleBaseline: String? = null,

    /**
     * The color of the legend title, can be in hex color code or regular color name.
     */
    val titleColor: String? = null,

    /**
     * The font of the legend title.
     */
    val titleFont: String? = null,

    /**
     * The font size of the legend title.
     */
    val titleFontSize: Double? = null,

    /**
     * The font weight of the legend title.
     */
    val titleFontWeight: JsonElement? = null,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit: Double? = null,

    /**
     * The padding, in pixels, between title and legend.
     */
    val titlePadding: Double? = null
)

/**
 * The orientation of the legend, which determines how the legend is positioned within the
 * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
 * "none".
 *
 * __Default value:__ `"right"`
 */
@Serializable
enum class LegendOrient(val value: String) {
    @SerialName("left") Left("left"),
    @SerialName("right") Right("right"),
    @SerialName("top-left") TopLeft("top-left"),
    @SerialName("top-right") TopRight("top-right"),
    @SerialName("bottom-left") BottomLeft("bottom-left"),
    @SerialName("bottom-right") BottomRight("bottom-right"),
    @SerialName("none") None("none");
}

typealias Padding = JsonElement

@Serializable
data class PaddingClass (
    val bottom: Double? = null,
    val left: Double? = null,
    val right: Double? = null,
    val top: Double? = null
)

/**
 * Projection configuration, which determines default properties for all
 * [projections](projection.html). For a full list of projection configuration options,
 * please see the [corresponding section of the projection
 * documentation](projection.html#config).
 *
 * Any property of Projection can be in config
 */
@Serializable
data class ProjectionConfig (
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    val center: List<Double>? = null,

    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    val clipAngle: Double? = null,

    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    val clipExtent: List<List<Double>>? = null,

    val coefficient: Double? = null,
    val distance: Double? = null,
    val fraction: Double? = null,
    val lobes: Double? = null,
    val parallel: Double? = null,

    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    val precision: JsonObject? = null,

    val radius: Double? = null,
    val ratio: Double? = null,

    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    val rotate: List<Double>? = null,

    val spacing: Double? = null,
    val tilt: Double? = null,

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    val type: VGProjectionType? = null
)

/**
 * The cartographic projection to use. This value is case-insensitive, for example
 * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
 * projection types [in the
 * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
 *
 * __Default value:__ `mercator`
 */
@Serializable
enum class VGProjectionType(val value: String) {
    @SerialName("albers") Albers("albers"),
    @SerialName("albersUsa") AlbersUsa("albersUsa"),
    @SerialName("azimuthalEqualArea") AzimuthalEqualArea("azimuthalEqualArea"),
    @SerialName("azimuthalEquidistant") AzimuthalEquidistant("azimuthalEquidistant"),
    @SerialName("conicConformal") ConicConformal("conicConformal"),
    @SerialName("conicEqualArea") ConicEqualArea("conicEqualArea"),
    @SerialName("conicEquidistant") ConicEquidistant("conicEquidistant"),
    @SerialName("equirectangular") Equirectangular("equirectangular"),
    @SerialName("gnomonic") Gnomonic("gnomonic"),
    @SerialName("mercator") Mercator("mercator"),
    @SerialName("orthographic") Orthographic("orthographic"),
    @SerialName("stereographic") Stereographic("stereographic"),
    @SerialName("transverseMercator") TransverseMercator("transverseMercator");
}

typealias RangeConfigValue = JsonElement

@Serializable
data class VGScheme (
    val count: Double? = null,
    val extent: List<Double>? = null,
    val scheme: String? = null,
    val step: Double? = null
)

/**
 * Scale configuration determines default properties for all [scales](scale.html). For a
 * full list of scale configuration options, please see the [corresponding section of the
 * scale documentation](scale.html#config).
 */
@Serializable
data class ScaleConfig (
    /**
     * Default inner padding for `x` and `y` band-ordinal scales.
     *
     * __Default value:__ `0.1`
     */
    val bandPaddingInner: Double? = null,

    /**
     * Default outer padding for `x` and `y` band-ordinal scales.
     * If not specified, by default, band scale's paddingOuter is paddingInner/2.
     */
    val bandPaddingOuter: Double? = null,

    /**
     * If true, values that exceed the data domain are clamped to either the minimum or maximum
     * range value
     */
    val clamp: Boolean? = null,

    /**
     * Default padding for continuous scales.
     *
     * __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
     * horizontal bar.; `0` otherwise.
     */
    val continuousPadding: Double? = null,

    /**
     * The default max value for mapping quantitative fields to bar's size/bandSize.
     *
     * If undefined (default), we will use the scale's `rangeStep` - 1.
     */
    val maxBandSize: Double? = null,

    /**
     * The default max value for mapping quantitative fields to text's size/fontSize.
     *
     * __Default value:__ `40`
     */
    val maxFontSize: Double? = null,

    /**
     * Default max opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.8`
     */
    val maxOpacity: Double? = null,

    /**
     * Default max value for point size scale.
     */
    val maxSize: Double? = null,

    /**
     * Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
     *
     * __Default value:__ `4`
     */
    val maxStrokeWidth: Double? = null,

    /**
     * The default min value for mapping quantitative fields to bar and tick's size/bandSize
     * scale with zero=false.
     *
     * __Default value:__ `2`
     */
    val minBandSize: Double? = null,

    /**
     * The default min value for mapping quantitative fields to tick's size/fontSize scale with
     * zero=false
     *
     * __Default value:__ `8`
     */
    val minFontSize: Double? = null,

    /**
     * Default minimum opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.3`
     */
    val minOpacity: Double? = null,

    /**
     * Default minimum value for point size scale with zero=false.
     *
     * __Default value:__ `9`
     */
    val minSize: Double? = null,

    /**
     * Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
     *
     * __Default value:__ `1`
     */
    val minStrokeWidth: Double? = null,

    /**
     * Default outer padding for `x` and `y` point-ordinal scales.
     *
     * __Default value:__ `0.5`
     */
    val pointPadding: Double? = null,

    /**
     * Default range step for band and point scales of (1) the `y` channel
     * and (2) the `x` channel when the mark is not `text`.
     *
     * __Default value:__ `21`
     */
    val rangeStep: Double? = null,

    /**
     * If true, rounds numeric output values to integers.
     * This can be helpful for snapping to the pixel grid.
     * (Only available for `x`, `y`, and `size` scales.)
     */
    val round: Boolean? = null,

    /**
     * Default range step for `x` band and point scales of text marks.
     *
     * __Default value:__ `90`
     */
    val textXRangeStep: Double? = null,

    /**
     * Use the source data range before aggregation as scale domain instead of aggregated data
     * for aggregate axis.
     *
     * This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
     * fields by default.
     *
     * This property only works with aggregate functions that produce values within the raw data
     * domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
     * aggregations that produce values outside of the raw data domain (e.g. `"count"`,
     * `"sum"`), this property is ignored.
     *
     * __Default value:__ `false`
     */
    val useUnaggregatedDomain: Boolean? = null
)

/**
 * An object hash for defining default properties for each type of selections.
 */
@Serializable
data class SelectionConfig (
    /**
     * The default definition for an [`interval`](selection.html#type) selection. All properties
     * and transformations
     * for an interval selection definition (except `type`) may be specified here.
     *
     * For instance, setting `interval` to `{"translate": false}` disables the ability to move
     * interval selections by default.
     */
    val interval: IntervalSelectionConfig? = null,

    /**
     * The default definition for a [`multi`](selection.html#type) selection. All properties and
     * transformations
     * for a multi selection definition (except `type`) may be specified here.
     *
     * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
     * multi selections when clicking with the alt-key pressed by default.
     */
    val multi: MultiSelectionConfig? = null,

    /**
     * The default definition for a [`single`](selection.html#type) selection. All properties
     * and transformations
     * for a single selection definition (except `type`) may be specified here.
     *
     * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
     * double-click by default.
     */
    val single: SingleSelectionConfig? = null
)

/**
 * The default definition for an [`interval`](selection.html#type) selection. All properties
 * and transformations
 * for an interval selection definition (except `type`) may be specified here.
 *
 * For instance, setting `interval` to `{"translate": false}` disables the ability to move
 * interval selections by default.
 */
@Serializable
data class IntervalSelectionConfig (
    /**
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    val bind: BindEnum? = null,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty: Empty? = null,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings: List<SingleDefChannel>? = null,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields: List<String>? = null,

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    val mark: BrushConfig? = null,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on: JsonElement? = null,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve: SelectionResolution? = null,

    /**
     * When truthy, allows a user to interactively move an interval selection
     * back-and-forth. Can be `true`, `false` (to disable panning), or a
     * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
     * which must include a start and end event to trigger continuous panning.
     *
     * __Default value:__ `true`, which corresponds to
     * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
     * clicks and dragging within an interval selection to reposition it.
     */
    val translate: JsonElement? = null,

    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    val zoom: JsonElement? = null
)

/**
 * Establishes a two-way binding between the interval selection and the scales
 * used within the same view. This allows a user to interactively pan and
 * zoom the view.
 */
@Serializable
enum class BindEnum(val value: String) {
    @SerialName("scales") Scales("scales");
}

/**
 * By default, all data values are considered to lie within an empty selection.
 * When set to `none`, empty selections contain no data values.
 */
@Serializable
enum class Empty(val value: String) {
    @SerialName("all") All("all"),
    @SerialName("none") None("none");
}

@Serializable
enum class SingleDefChannel(val value: String) {
    @SerialName("x") X("x"),
    @SerialName("y") Y("y"),
    @SerialName("x2") X2("x2"),
    @SerialName("y2") Y2("y2"),
    @SerialName("row") Row("row"),
    @SerialName("column") Column("column"),
    @SerialName("size") Size("size"),
    @SerialName("shape") Shape("shape"),
    @SerialName("color") Color("color"),
    @SerialName("opacity") Opacity("opacity"),
    @SerialName("text") Text("text"),
    @SerialName("tooltip") Tooltip("tooltip"),
    @SerialName("href") Href("href");
}

/**
 * An interval selection also adds a rectangle mark to depict the
 * extents of the interval. The `mark` property can be used to customize the
 * appearance of the mark.
 */
@Serializable
data class BrushConfig (
    /**
     * The fill color of the interval mark.
     *
     * __Default value:__ `#333333`
     */
    val fill: String? = null,

    /**
     * The fill opacity of the interval mark (a value between 0 and 1).
     *
     * __Default value:__ `0.125`
     */
    val fillOpacity: Double? = null,

    /**
     * The stroke color of the interval mark.
     *
     * __Default value:__ `#ffffff`
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke and space lengths,
     * for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) with which to begin drawing the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity of the interval mark (a value between 0 and 1).
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width of the interval mark.
     */
    val strokeWidth: Double? = null
)

/**
 * With layered and multi-view displays, a strategy that determines how
 * selections' data queries are resolved when applied in a filter transform,
 * conditional encoding rule, or scale domain.
 */
@Serializable
enum class SelectionResolution(val value: String) {
    @SerialName("global") Global("global"),
    @SerialName("union") Union("union"),
    @SerialName("intersect") Intersect("intersect");
}

typealias Translate = JsonElement

/**
 * The default definition for a [`multi`](selection.html#type) selection. All properties and
 * transformations
 * for a multi selection definition (except `type`) may be specified here.
 *
 * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
 * multi selections when clicking with the alt-key pressed by default.
 */
@Serializable
data class MultiSelectionConfig (
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty: Empty? = null,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings: List<SingleDefChannel>? = null,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields: List<String>? = null,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest: Boolean? = null,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on: JsonElement? = null,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve: SelectionResolution? = null,

    /**
     * Controls whether data values should be toggled or only ever inserted into
     * multi selections. Can be `true`, `false` (for insertion only), or a
     * [Vega expression](https://vega.github.io/vega/docs/expressions/).
     *
     * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
     * data values are toggled when a user interacts with the shift-key pressed).
     *
     * See the [toggle transform](toggle.html) documentation for more information.
     */
    val toggle: JsonElement? = null
)

/**
 * The default definition for a [`single`](selection.html#type) selection. All properties
 * and transformations
 * for a single selection definition (except `type`) may be specified here.
 *
 * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
 * double-click by default.
 */
@Serializable
data class SingleSelectionConfig (
    /**
     * Establish a two-way binding between a single selection and input elements
     * (also known as dynamic query widgets). A binding takes the form of
     * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
     * or can be a mapping between projected field/encodings and binding definitions.
     *
     * See the [bind transform](bind.html) documentation for more information.
     */
    val bind: Map<String, VGBinding>? = null,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty: Empty? = null,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings: List<SingleDefChannel>? = null,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields: List<String>? = null,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest: Boolean? = null,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on: JsonElement? = null,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve: SelectionResolution? = null
)

@Serializable
data class VGBinding (
    val element: String? = null,
    val input: String,
    val options: List<String>? = null,
    val max: Double? = null,
    val min: Double? = null,
    val step: Double? = null
)

/**
 * Default stack offset for stackable mark.
 */
@Serializable
enum class StackOffset(val value: String) {
    @SerialName("zero") Zero("zero"),
    @SerialName("center") Center("center"),
    @SerialName("normalize") Normalize("normalize");
}

@Serializable
data class VGMarkConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null
)

/**
 * Text-Specific Config
 */
@Serializable
data class TextConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color: String? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled: Boolean? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * Whether month names and weekday names should be abbreviated.
     */
    val shortTimeLabels: Boolean? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null
)

/**
 * Tick-Specific Config
 */
@Serializable
data class TickConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The width of the ticks.
     *
     * __Default value:__  2/3 of rangeStep.
     */
    val bandSize: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color: String? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled: Boolean? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null,

    /**
     * Thickness of the tick mark.
     *
     * __Default value:__  `1`
     */
    val thickness: Double? = null
)

/**
 * Title configuration, which determines default properties for all [titles](title.html).
 * For a full list of title configuration options, please see the [corresponding section of
 * the title documentation](title.html#config).
 */
@Serializable
data class VGTitleConfig (
    /**
     * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
     * example, with an orientation of top these anchor positions map to a left-, center-, or
     * right-aligned title.
     *
     * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
     * `"start"` for other composite views.
     *
     * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
     * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
     * composite views, `anchor` is always `"start"`.
     */
    val anchor: Anchor? = null,

    /**
     * Angle in degrees of title text.
     */
    val angle: Double? = null,

    /**
     * Vertical text baseline for title text.
     */
    val baseline: VerticalAlign? = null,

    /**
     * Text color for title text.
     */
    val color: String? = null,

    /**
     * Font name for title text.
     */
    val font: String? = null,

    /**
     * Font size in pixels for title text.
     *
     * __Default value:__ `10`.
     */
    val fontSize: Double? = null,

    /**
     * Font weight for title text.
     */
    val fontWeight: JsonElement? = null,

    /**
     * The maximum allowed length in pixels of legend labels.
     */
    val limit: Double? = null,

    /**
     * Offset in pixels of the title from the chart body and axes.
     */
    val offset: Double? = null,

    /**
     * Default title orientation ("top", "bottom", "left", or "right")
     */
    val orient: TitleOrient? = null
)

/**
 * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
 * example, with an orientation of top these anchor positions map to a left-, center-, or
 * right-aligned title.
 *
 * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
 * `"start"` for other composite views.
 *
 * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
 * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
 * composite views, `anchor` is always `"start"`.
 */
@Serializable
enum class Anchor(val value: String) {
    @SerialName("start") Start("start"),
    @SerialName("middle") Middle("middle"),
    @SerialName("end") End("end");
}

/**
 * Default title orientation ("top", "bottom", "left", or "right")
 *
 * The orientation of the title relative to the chart. One of `"top"` (the default),
 * `"bottom"`, `"left"`, or `"right"`.
 *
 * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
 * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
 * the right edge of the chart).
 *
 * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
 */
@Serializable
enum class TitleOrient(val value: String) {
    @SerialName("top") Top("top"),
    @SerialName("bottom") Bottom("bottom"),
    @SerialName("left") Left("left"),
    @SerialName("right") Right("right");
}

/**
 * Default properties for [single view plots](spec.html#single).
 */
@Serializable
data class ViewConfig (
    /**
     * Whether the view should be clipped.
     */
    val clip: Boolean? = null,

    /**
     * The fill color.
     *
     * __Default value:__ (none)
     */
    val fill: String? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    val fillOpacity: Double? = null,

    /**
     * The default height of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
     *
     * __Default value:__ `200`
     */
    val height: Double? = null,

    /**
     * The stroke color.
     *
     * __Default value:__ (none)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     *
     * __Default value:__ (none)
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     *
     * __Default value:__ (none)
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     *
     * __Default value:__ (none)
     */
    val strokeWidth: Double? = null,

    /**
     * The default width of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
     * = `null`.
     *
     * __Default value:__ `200`
     */
    val width: Double? = null
)

/**
 * An object describing the data source
 *
 * Secondary data source to lookup in.
 */
@Serializable
data class Data (
    /**
     * An object that specifies the format for parsing the data file.
     *
     * An object that specifies the format for parsing the data values.
     *
     * An object that specifies the format for parsing the data.
     */
    val format: DataFormat? = null,

    /**
     * An URL from which to load the data set. Use the `format.type` property
     * to ensure the loaded data is correctly parsed.
     */
    val url: String? = null,

    /**
     * The full data set, included inline. This can be an array of objects or primitive values
     * or a string.
     * Arrays of primitive values are ingested as objects with a `data` property. Strings are
     * parsed according to the specified format type.
     */
    val values: JsonElement? = null,

    /**
     * Provide a placeholder name and bind data at runtime.
     */
    val name: String? = null
)

/**
 * An object that specifies the format for parsing the data file.
 *
 * An object that specifies the format for parsing the data values.
 *
 * An object that specifies the format for parsing the data.
 */
@Serializable
data class DataFormat (
    /**
     * If set to auto (the default), perform automatic type inference to determine the desired
     * data types.
     * Alternatively, a parsing directive object can be provided for explicit data types. Each
     * property of the object corresponds to a field name, and the value to the desired data
     * type (one of `"number"`, `"boolean"` or `"date"`).
     * For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
     * input record a Date value.
     *
     * For `"date"`, we parse data based using Javascript's
     * [`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
     * For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
     * [d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
     * format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
     * [UTC time](timeunit.html#utc)
     */
    val parse: JsonElement? = null,

    /**
     * Type of input data: `"json"`, `"csv"`, `"tsv"`.
     * The default format type is determined by the extension of the file URL.
     * If no extension is detected, `"json"` will be used by default.
     */
    val type: DataFormatType? = null,

    /**
     * The JSON property containing the desired data.
     * This parameter can be used when the loaded JSON file may have surrounding structure or
     * meta-data.
     * For example `"property": "values.features"` is equivalent to retrieving
     * `json.values.features`
     * from the loaded JSON object.
     */
    val property: String? = null,

    /**
     * The name of the TopoJSON object set to convert to a GeoJSON feature collection.
     * For example, in a map of the world, there may be an object set named `"countries"`.
     * Using the feature property, we can extract this set and generate a GeoJSON feature object
     * for each country.
     */
    val feature: String? = null,

    /**
     * The name of the TopoJSON object set to convert to mesh.
     * Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
     * Unlike the `feature` option, the corresponding geo data is returned as a single, unified
     * mesh instance, not as individual GeoJSON features.
     * Extracting a mesh is useful for more efficiently drawing borders or other geographic
     * elements that you do not need to associate with specific regions such as individual
     * countries, states or counties.
     */
    val mesh: String? = null
)

typealias ParseUnion = JsonElement

@Serializable
enum class ParseEnum(val value: String) {
    @SerialName("auto") Auto("auto");
}

/**
 * Type of input data: `"json"`, `"csv"`, `"tsv"`.
 * The default format type is determined by the extension of the file URL.
 * If no extension is detected, `"json"` will be used by default.
 */
@Serializable
enum class DataFormatType(val value: String) {
    @SerialName("csv") CSV("csv"),
    @SerialName("tsv") Tsv("tsv"),
    @SerialName("json") JSON("json"),
    @SerialName("topojson") Topojson("topojson");
}

typealias Values = JsonElement

typealias ValuesValue = JsonElement

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
@Serializable
data class EncodingWithFacet (
    /**
     * Color of the marks – either fill or stroke color based on mark type.
     * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
     * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
     *
     * __Default value:__ If undefined, the default color depends on [mark
     * config](config.html#mark)'s `color` property.
     *
     * _Note:_ See the scale documentation for more information about customizing [color
     * scheme](scale.html#scheme).
     */
    val color: MarkPropDefWithCondition? = null,

    /**
     * Horizontal facets for trellis plots.
     */
    val column: FacetFieldDef? = null,

    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    val detail: JsonElement? = null,

    /**
     * A URL to load upon mouse click.
     */
    val href: DefWithCondition? = null,

    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    val opacity: MarkPropDefWithCondition? = null,

    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    val order: JsonElement? = null,

    /**
     * Vertical facets for trellis plots.
     */
    val row: FacetFieldDef? = null,

    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    val shape: MarkPropDefWithCondition? = null,

    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    val size: MarkPropDefWithCondition? = null,

    /**
     * Text of the `text` mark.
     */
    val text: TextDefWithCondition? = null,

    /**
     * The tooltip text to show upon mouse hover.
     */
    val tooltip: TextDefWithCondition? = null,

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    val x: XClass? = null,

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val x2: X2Class? = null,

    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    val y: XClass? = null,

    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val y2: X2Class? = null
)

/**
 * Color of the marks – either fill or stroke color based on mark type.
 * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
 * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
 *
 * __Default value:__ If undefined, the default color depends on [mark
 * config](config.html#mark)'s `color` property.
 *
 * _Note:_ See the scale documentation for more information about customizing [color
 * scheme](scale.html#scheme).
 *
 * Opacity of the marks – either can be a value or a range.
 *
 * __Default value:__ If undefined, the default opacity depends on [mark
 * config](config.html#mark)'s `opacity` property.
 *
 * For `point` marks the supported values are
 * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
 * or `"triangle-down"`, or else a custom SVG path string.
 * For `geoshape` marks it should be a field definition of the geojson data
 *
 * __Default value:__ If undefined, the default shape depends on [mark
 * config](config.html#point-config)'s `shape` property.
 *
 * Size of the mark.
 * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
 * - For `"bar"` and `"tick"` – the bar and tick's size.
 * - For `"text"` – the text's font size.
 * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
 *
 * A FieldDef with Condition<ValueDef>
 * {
 * condition: {value: ...},
 * field: ...,
 * ...
 * }
 *
 * A ValueDef with Condition<ValueDef | FieldDef>
 * {
 * condition: {field: ...} | {value: ...},
 * value: ...,
 * }
 */
@Serializable
data class MarkPropDefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    val legend: Legend? = null,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale: Scale? = null,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null,

    /**
     * A constant value in visual domain.
     */
    val value: JsonElement? = null
)

/**
 * Aggregation function for the field
 * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
 *
 * __Default value:__ `undefined` (None)
 *
 * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
 * (e.g., `"count"`, `"mean"` and `"median"`).
 * This property is required in cases where the sort field and the data reference field do
 * not match.
 * The input data objects will be aggregated, grouped by the encoded data field.
 *
 * For a full list of operations, please see the documentation for
 * [aggregate](aggregate.html#ops).
 *
 * The aggregation operations to apply to the fields, such as sum, average or count.
 * See the [full list of supported aggregation
 * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
 * for more information.
 */
@Serializable
enum class AggregateOp(val value: String) {
    @SerialName("argmax") Argmax("argmax"),
    @SerialName("argmin") Argmin("argmin"),
    @SerialName("average") Average("average"),
    @SerialName("count") Count("count"),
    @SerialName("distinct") Distinct("distinct"),
    @SerialName("max") Max("max"),
    @SerialName("mean") Mean("mean"),
    @SerialName("median") Median("median"),
    @SerialName("min") Min("min"),
    @SerialName("missing") Missing("missing"),
    @SerialName("q1") Q1("q1"),
    @SerialName("q3") Q3("q3"),
    @SerialName("ci0") Ci0("ci0"),
    @SerialName("ci1") Ci1("ci1"),
    @SerialName("stdev") Stdev("stdev"),
    @SerialName("stdevp") Stdevp("stdevp"),
    @SerialName("sum") Sum("sum"),
    @SerialName("valid") Valid("valid"),
    @SerialName("values") Values("values"),
    @SerialName("variance") Variance("variance"),
    @SerialName("variancep") Variancep("variancep");
}

typealias Bin = JsonElement

/**
 * Binning properties or boolean flag for determining whether to bin data or not.
 */
@Serializable
data class BinParams (
    /**
     * The number base to use for automatic bin determination (default is base 10).
     *
     * __Default value:__ `10`
     */
    val base: Double? = null,

    /**
     * Scale factors indicating allowable subdivisions. The default value is [5, 2], which
     * indicates that for base 10 numbers (the default base), the method may consider dividing
     * bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
     * check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
     * given constraints.
     *
     * __Default value:__ `[5, 2]`
     */
    val divide: List<Double>? = null,

    /**
     * A two-element (`[min, max]`) array indicating the range of desired bin values.
     */
    val extent: List<Double>? = null,

    /**
     * Maximum number of bins.
     *
     * __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
     */
    val maxbins: Double? = null,

    /**
     * A minimum allowable step size (particularly useful for integer values).
     */
    val minstep: Double? = null,

    /**
     * If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
     * such as multiples of ten.
     */
    val nice: Boolean? = null,

    /**
     * An exact step size to use between bins.
     *
     * __Note:__ If provided, options such as maxbins will be ignored.
     */
    val step: Double? = null,

    /**
     * An array of allowable step sizes to choose from.
     */
    val steps: List<Double>? = null
)

typealias ColorCondition = JsonElement

@Serializable
data class ConditionalValueDef (
    val test: JsonElement? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection: JsonElement? = null
)

@Serializable
data class Selection (
    val not: JsonElement? = null,
    val and: JsonArray? = null,
    val or: JsonArray? = null
)

typealias SelectionOperand = JsonElement

@Serializable
data class Predicate (
    val not: JsonElement? = null,
    val and: JsonArray? = null,
    val or: JsonArray? = null,

    /**
     * The value that the field should be equal to.
     */
    val equal: JsonElement? = null,

    /**
     * Field to be filtered.
     *
     * Field to be filtered
     */
    val field: String? = null,

    /**
     * Time unit for the field to be filtered.
     *
     * time unit for the field to be filtered.
     */
    val timeUnit: TimeUnit? = null,

    /**
     * An array of inclusive minimum and maximum values
     * for a field value of a data item to be included in the filtered data.
     */
    val range: JsonArray? = null,

    /**
     * A set of values that the `field`'s value should be a member of,
     * for a data item included in the filtered data.
     */
    val oneOf: JsonArray? = null,

    /**
     * Filter using a selection name.
     */
    val selection: JsonElement? = null
)

typealias LogicalOperandPredicate = JsonElement

typealias Equal = JsonElement

/**
 * Object for defining datetime in Vega-Lite Filter.
 * If both month and quarter are provided, month has higher precedence.
 * `day` cannot be combined with other date.
 * We accept string for month and day names.
 */
@Serializable
data class DateTime (
    /**
     * Integer value representing the date from 1-31.
     */
    val date: Double? = null,

    /**
     * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
     * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
     * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
     * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
     * `month`, or `date`.
     */
    val day: JsonElement? = null,

    /**
     * Integer value representing the hour of a day from 0-23.
     */
    val hours: Double? = null,

    /**
     * Integer value representing the millisecond segment of time.
     */
    val milliseconds: Double? = null,

    /**
     * Integer value representing the minute segment of time from 0-59.
     */
    val minutes: Double? = null,

    /**
     * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
     * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
     * short month name (e.g., `"Jan"`).
     */
    val month: JsonElement? = null,

    /**
     * Integer value representing the quarter of the year (from 1-4).
     */
    val quarter: Double? = null,

    /**
     * Integer value representing the second segment (0-59) of a time value
     */
    val seconds: Double? = null,

    /**
     * A boolean flag indicating if date time is in utc time. If false, the date time is in
     * local time
     */
    val utc: Boolean? = null,

    /**
     * Integer value representing the year.
     */
    val year: Double? = null
)

typealias Day = JsonElement

typealias Month = JsonElement

typealias RangeElement = JsonElement

/**
 * Time unit for the field to be filtered.
 *
 * time unit for the field to be filtered.
 *
 * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
 * or [a temporal field that gets casted as ordinal](type.html#cast).
 *
 * __Default value:__ `undefined` (None)
 *
 * The timeUnit.
 */
@Serializable
enum class TimeUnit(val value: String) {
    @SerialName("year") Year("year"),
    @SerialName("quarter") Quarter("quarter"),
    @SerialName("month") Month("month"),
    @SerialName("day") Day("day"),
    @SerialName("date") Date("date"),
    @SerialName("hours") Hours("hours"),
    @SerialName("minutes") Minutes("minutes"),
    @SerialName("seconds") Seconds("seconds"),
    @SerialName("milliseconds") Milliseconds("milliseconds"),
    @SerialName("utcyear") Utcyear("utcyear"),
    @SerialName("utcquarter") Utcquarter("utcquarter"),
    @SerialName("utcmonth") Utcmonth("utcmonth"),
    @SerialName("utcday") Utcday("utcday"),
    @SerialName("utcdate") Utcdate("utcdate"),
    @SerialName("utchours") Utchours("utchours"),
    @SerialName("utcminutes") Utcminutes("utcminutes"),
    @SerialName("utcseconds") Utcseconds("utcseconds"),
    @SerialName("utcmilliseconds") Utcmilliseconds("utcmilliseconds"),
    @SerialName("yearquarter") Yearquarter("yearquarter"),
    @SerialName("yearquartermonth") Yearquartermonth("yearquartermonth"),
    @SerialName("yearmonth") Yearmonth("yearmonth"),
    @SerialName("yearmonthdate") Yearmonthdate("yearmonthdate"),
    @SerialName("yearmonthdatehours") Yearmonthdatehours("yearmonthdatehours"),
    @SerialName("yearmonthdatehoursminutes") Yearmonthdatehoursminutes("yearmonthdatehoursminutes"),
    @SerialName("yearmonthdatehoursminutesseconds") Yearmonthdatehoursminutesseconds("yearmonthdatehoursminutesseconds"),
    @SerialName("quartermonth") Quartermonth("quartermonth"),
    @SerialName("monthdate") Monthdate("monthdate"),
    @SerialName("hoursminutes") Hoursminutes("hoursminutes"),
    @SerialName("hoursminutesseconds") Hoursminutesseconds("hoursminutesseconds"),
    @SerialName("minutesseconds") Minutesseconds("minutesseconds"),
    @SerialName("secondsmilliseconds") Secondsmilliseconds("secondsmilliseconds"),
    @SerialName("utcyearquarter") Utcyearquarter("utcyearquarter"),
    @SerialName("utcyearquartermonth") Utcyearquartermonth("utcyearquartermonth"),
    @SerialName("utcyearmonth") Utcyearmonth("utcyearmonth"),
    @SerialName("utcyearmonthdate") Utcyearmonthdate("utcyearmonthdate"),
    @SerialName("utcyearmonthdatehours") Utcyearmonthdatehours("utcyearmonthdatehours"),
    @SerialName("utcyearmonthdatehoursminutes") Utcyearmonthdatehoursminutes("utcyearmonthdatehoursminutes"),
    @SerialName("utcyearmonthdatehoursminutesseconds") Utcyearmonthdatehoursminutesseconds("utcyearmonthdatehoursminutesseconds"),
    @SerialName("utcquartermonth") Utcquartermonth("utcquartermonth"),
    @SerialName("utcmonthdate") Utcmonthdate("utcmonthdate"),
    @SerialName("utchoursminutes") Utchoursminutes("utchoursminutes"),
    @SerialName("utchoursminutesseconds") Utchoursminutesseconds("utchoursminutesseconds"),
    @SerialName("utcminutesseconds") Utcminutesseconds("utcminutesseconds"),
    @SerialName("utcsecondsmilliseconds") Utcsecondsmilliseconds("utcsecondsmilliseconds");
}

typealias ConditionalValueDefValue = JsonElement

@Serializable
data class ConditionalPredicateMarkPropFieldDefClass (
    val test: JsonElement? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement? = null,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection: JsonElement? = null,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    val legend: Legend? = null,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale: Scale? = null,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null
)

typealias Field = JsonElement

/**
 * Reference to a repeated value.
 */
@Serializable
data class RepeatRef (
    val repeat: RepeatEnum
)

@Serializable
enum class RepeatEnum(val value: String) {
    @SerialName("row") Row("row"),
    @SerialName("column") Column("column");
}

/**
 * Properties of a legend or boolean flag for determining whether to show it.
 */
@Serializable
data class Legend (
    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    val entryPadding: Double? = null,

    /**
     * The formatting pattern for labels. This is D3's [number format
     * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
     * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
     * field.
     *
     * See the [format documentation](format.html) for more information.
     *
     * __Default value:__  derived from [numberFormat](config.html#format) config for
     * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
     */
    val format: String? = null,

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    val offset: Double? = null,

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    val orient: LegendOrient? = null,

    /**
     * The padding, in pixels, between the legend and axis.
     */
    val padding: Double? = null,

    /**
     * The desired number of tick values for quantitative legends.
     */
    val tickCount: Double? = null,

    /**
     * A title for the field. If `null`, the title will be removed.
     *
     * __Default value:__  derived from the field's name and transformation function
     * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
     * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
     * binned or has a time unit applied, the applied function will be denoted in parentheses
     * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
     * simply the field name.
     *
     * __Note__: You can customize the default field title format by providing the [`fieldTitle`
     * property in the [config](config.html) or [`fieldTitle` function via the `compile`
     * function's options](compile.html#field-title).
     */
    val title: String? = null,

    /**
     * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
     * continuous color gradient.
     *
     * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
     * `"symbol"` otherwise.
     */
    val type: LegendType? = null,

    /**
     * Explicitly set the visible legend values.
     */
    val values: JsonArray? = null,

    /**
     * A non-positive integer indicating z-index of the legend.
     * If zindex is 0, legend should be drawn behind all chart elements.
     * To put them in front, use zindex = 1.
     */
    val zindex: Double? = null
)

/**
 * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
 * continuous color gradient.
 *
 * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
 * `"symbol"` otherwise.
 */
@Serializable
enum class LegendType(val value: String) {
    @SerialName("symbol") Symbol("symbol"),
    @SerialName("gradient") Gradient("gradient");
}

typealias LegendValue = JsonElement

/**
 * An object defining properties of the channel's scale, which is the function that
 * transforms values in the data domain (numbers, dates, strings, etc) to visual values
 * (pixels, colors, sizes) of the encoding channels.
 *
 * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
 */
@Serializable
data class Scale (
    /**
     * The logarithm base of the `log` scale (default `10`).
     */
    val base: Double? = null,

    /**
     * If `true`, values that exceed the data domain are clamped to either the minimum or
     * maximum range value
     *
     * __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
     * (`true` by default).
     */
    val clamp: Boolean? = null,

    /**
     * Customized domain values.
     *
     * For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
     * and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
     * a `domain` with more than two entries.
     * If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
     * indicating that the domain should include the raw data values prior to the aggregation.
     *
     * For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
     * the form of either timestamps or the [DateTime definition objects](types.html#datetime).
     *
     * For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
     * values.
     *
     * The `selection` property can be used to [interactively
     * determine](selection.html#scale-domains) the scale domain.
     */
    val domain: JsonElement? = null,

    /**
     * The exponent of the `pow` scale.
     */
    val exponent: Double? = null,

    /**
     * The interpolation method for range values. By default, a general interpolator for
     * numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
     * property allows interpolation in alternative color spaces. Legal values include `rgb`,
     * `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
     * variants use longer paths in polar coordinate spaces). If object-valued, this property
     * accepts an object with a string-valued _type_ property and an optional numeric _gamma_
     * property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
     * documentation](https://github.com/d3/d3-interpolate).
     *
     * __Note:__ Sequential scales do not support `interpolate` as they have a fixed
     * interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
     * you have to set the scale `type` to other quantitative scale type such as `"linear"` to
     * customize `interpolate`.
     */
    val interpolate: JsonElement? = null,

    /**
     * Extending the domain so that it starts and ends on nice round values. This method
     * typically modifies the scale’s domain, and may only extend the bounds to the nearest
     * round value. Nicing is useful if the domain is computed from data and may be irregular.
     * For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
     * 1.0]_.
     *
     * For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
     * If `nice` is a number, it will represent a desired tick count. This allows greater
     * control over the step size used to extend the bounds, guaranteeing that the returned
     * ticks will exactly cover the domain.
     *
     * For temporal fields with time and utc scales, the `nice` value can be a string indicating
     * the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
     * `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
     * scales can accept an object-valued interval specifier of the form `{"interval": "month",
     * "step": 3}`, which includes a desired number of interval steps. Here, the domain would
     * snap to quarter (Jan, Apr, Jul, Oct) boundaries.
     *
     * __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
     */
    val nice: JsonElement? = null,

    /**
     * For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
     * the specified number of pixels on each of the scale range. The scale range must represent
     * pixels for this parameter to function as intended. Padding adjustment is performed prior
     * to all other adjustments, including the effects of the zero, nice, domainMin, and
     * domainMax properties.
     *
     * For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
     * `paddingOuter` to the same value.
     *
     * For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
     *
     * __Default value:__ For _continuous_ scales, derived from the [scale
     * config](scale.html#config)'s `continuousPadding`.
     * For _band and point_ scales, see `paddingInner` and `paddingOuter`.
     */
    val padding: Double? = null,

    /**
     * The inner padding (spacing) within each band step of band scales, as a fraction of the
     * step size. This value must lie in the range [0,1].
     *
     * For point scale, this property is invalid as point scales do not have internal band
     * widths (only step sizes between bands).
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingInner`.
     */
    val paddingInner: Double? = null,

    /**
     * The outer padding (spacing) at the ends of the range of band and point scales,
     * as a fraction of the step size. This value must lie in the range [0,1].
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingOuter` for band scales and `pointPadding` for point scales.
     */
    val paddingOuter: Double? = null,

    /**
     * The range of the scale. One of:
     *
     * - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
     * example, `"symbol"`, or `"diverging"`).
     *
     * - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
     * and maximum values, or an array with more than two entries for specifying a [piecewise
     * scale](scale.html#piecewise).
     *
     * - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
     * an array of desired output values.
     *
     * __Notes:__
     *
     * 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
     * discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
     * instead of `range`.
     *
     * 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
     * customized via the view's corresponding [size](size.html) (`width` and `height`) or via
     * [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
     * scales.
     */
    val range: JsonElement? = null,

    /**
     * The distance between the starts of adjacent bands or points in [band](scale.html#band)
     * and [point](scale.html#point) scales.
     *
     * If `rangeStep` is `null` or if the view contains the scale's corresponding
     * [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
     * be automatically determined to fit the size of the view.
     *
     * __Default value:__  derived the [scale config](config.html#scale-config)'s
     * `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
     * default) for x-scales of other marks and y-scales.
     *
     * __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
     * than `width` or `height`, the rangeStep might become less than one pixel and the mark
     * might not appear correctly.
     */
    val rangeStep: Double? = null,

    /**
     * If `true`, rounds numeric output values to integers. This can be helpful for snapping to
     * the pixel grid.
     *
     * __Default value:__ `false`.
     */
    val round: Boolean? = null,

    /**
     * A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
     * `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
     *
     * Discrete color schemes may be used with [discrete](scale.html#discrete) or
     * [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
     * use with [sequential](scales.html#sequential) scales.
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    val scheme: JsonElement? = null,

    /**
     * The type of scale.  Vega-Lite supports the following categories of scale types:
     *
     * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
     * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
     * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
     * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
     *
     * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
     * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
     * [`"point"`](scale.html#point)) output ranges.
     *
     * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
     * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
     * [`"bin-ordinal"`](scale.html#bin-ordinal)).
     *
     * __Default value:__ please see the [scale type table](scale.html#type).
     */
    val type: ScaleType? = null,

    /**
     * If `true`, ensures that a zero baseline value is included in the scale domain.
     *
     * __Default value:__ `true` for x and y channels if the quantitative field is not binned
     * and no custom `domain` is provided; `false` otherwise.
     *
     * __Note:__ Log, time, and utc scales do not support `zero`.
     */
    val zero: Boolean? = null
)

typealias DomainUnion = JsonElement

@Serializable
data class DomainClass (
    /**
     * The field name to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    val field: String? = null,

    /**
     * The name of a selection.
     */
    val selection: String,

    /**
     * The encoding channel to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    val encoding: String? = null
)

@Serializable
enum class Domain(val value: String) {
    @SerialName("unaggregated") Unaggregated("unaggregated");
}

typealias InterpolateUnion = JsonElement

@Serializable
data class InterpolateParams (
    val gamma: Double? = null,
    val type: InterpolateParamsType
)

@Serializable
enum class InterpolateParamsType(val value: String) {
    @SerialName("rgb") RGB("rgb"),
    @SerialName("cubehelix") Cubehelix("cubehelix"),
    @SerialName("cubehelix-long") CubehelixLong("cubehelix-long");
}

typealias NiceUnion = JsonElement

@Serializable
data class NiceClass (
    val interval: String,
    val step: Double
)

@Serializable
enum class NiceTime(val value: String) {
    @SerialName("second") Second("second"),
    @SerialName("minute") Minute("minute"),
    @SerialName("hour") Hour("hour"),
    @SerialName("day") Day("day"),
    @SerialName("week") Week("week"),
    @SerialName("month") Month("month"),
    @SerialName("year") Year("year");
}

typealias ScaleRange = JsonElement

typealias Scheme = JsonElement

@Serializable
data class SchemeParams (
    /**
     * For sequential and diverging schemes only, determines the extent of the color range to
     * use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
     * range _[0, 0.2)_ are excluded from the scheme.
     */
    val extent: List<Double>? = null,

    /**
     * A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    val name: String
)

/**
 * The type of scale.  Vega-Lite supports the following categories of scale types:
 *
 * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
 * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
 * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
 * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
 *
 * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
 * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
 * [`"point"`](scale.html#point)) output ranges.
 *
 * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
 * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
 * [`"bin-ordinal"`](scale.html#bin-ordinal)).
 *
 * __Default value:__ please see the [scale type table](scale.html#type).
 */
@Serializable
enum class ScaleType(val value: String) {
    @SerialName("linear") Linear("linear"),
    @SerialName("bin-linear") BinLinear("bin-linear"),
    @SerialName("log") Log("log"),
    @SerialName("pow") Pow("pow"),
    @SerialName("sqrt") Sqrt("sqrt"),
    @SerialName("time") Time("time"),
    @SerialName("utc") UTC("utc"),
    @SerialName("sequential") Sequential("sequential"),
    @SerialName("ordinal") Ordinal("ordinal"),
    @SerialName("bin-ordinal") BinOrdinal("bin-ordinal"),
    @SerialName("point") Point("point"),
    @SerialName("band") Band("band");
}

typealias SortUnion = JsonElement

@Serializable
data class SortField (
    /**
     * The data [field](field.html) to sort by.
     *
     * __Default value:__ If unspecified, defaults to the field specified in the outer data
     * reference.
     */
    val field: JsonElement? = null,

    /**
     * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
     * (e.g., `"count"`, `"mean"` and `"median"`).
     * This property is required in cases where the sort field and the data reference field do
     * not match.
     * The input data objects will be aggregated, grouped by the encoded data field.
     *
     * For a full list of operations, please see the documentation for
     * [aggregate](aggregate.html#ops).
     */
    val op: AggregateOp,

    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    val order: SortEnum? = null
)

@Serializable
enum class SortEnum(val value: String) {
    @SerialName("ascending") Ascending("ascending"),
    @SerialName("descending") Descending("descending");
}

/**
 * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
 * `"nominal"`).
 * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
 * [geographic projection](projection.html) is applied.
 *
 * Constants and utilities for data type
 * Data type based on level of measurement
 */
@Serializable
enum class Type(val value: String) {
    @SerialName("quantitative") Quantitative("quantitative"),
    @SerialName("ordinal") Ordinal("ordinal"),
    @SerialName("temporal") Temporal("temporal"),
    @SerialName("nominal") Nominal("nominal"),
    @SerialName("latitude") Latitude("latitude"),
    @SerialName("longitude") Longitude("longitude"),
    @SerialName("geojson") Geojson("geojson");
}

/**
 * Horizontal facets for trellis plots.
 *
 * Vertical facets for trellis plots.
 */
@Serializable
data class FacetFieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * An object defining properties of a facet's header.
     */
    val header: Header? = null,

    /**
     * Sort order for a facet field.
     * This can be `"ascending"`, `"descending"`.
     */
    val sort: SortEnum? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type
)

/**
 * An object defining properties of a facet's header.
 *
 * Headers of row / column channels for faceted plots.
 */
@Serializable
data class Header (
    /**
     * The formatting pattern for labels. This is D3's [number format
     * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
     * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
     * field.
     *
     * See the [format documentation](format.html) for more information.
     *
     * __Default value:__  derived from [numberFormat](config.html#format) config for
     * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
     */
    val format: String? = null,

    /**
     * The rotation angle of the header labels.
     *
     * __Default value:__ `0`.
     */
    val labelAngle: Double? = null,

    /**
     * A title for the field. If `null`, the title will be removed.
     *
     * __Default value:__  derived from the field's name and transformation function
     * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
     * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
     * binned or has a time unit applied, the applied function will be denoted in parentheses
     * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
     * simply the field name.
     *
     * __Note__: You can customize the default field title format by providing the [`fieldTitle`
     * property in the [config](config.html) or [`fieldTitle` function via the `compile`
     * function's options](compile.html#field-title).
     */
    val title: String? = null
)

typealias Detail = JsonElement

/**
 * Definition object for a data field, its type and transformation of an encoding channel.
 */
@Serializable
data class FieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type
)

/**
 * A URL to load upon mouse click.
 *
 * A FieldDef with Condition<ValueDef>
 * {
 * condition: {value: ...},
 * field: ...,
 * ...
 * }
 *
 * A ValueDef with Condition<ValueDef | FieldDef>
 * {
 * condition: {field: ...} | {value: ...},
 * value: ...,
 * }
 */
@Serializable
data class DefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null,

    /**
     * A constant value in visual domain.
     */
    val value: JsonElement? = null
)

typealias HrefCondition = JsonElement

@Serializable
data class ConditionalPredicateFieldDefClass (
    val test: JsonElement? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement? = null,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection: JsonElement? = null,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null
)

typealias Order = JsonElement

@Serializable
data class OrderFieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    val sort: SortEnum? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type
)

/**
 * Text of the `text` mark.
 *
 * The tooltip text to show upon mouse hover.
 *
 * A FieldDef with Condition<ValueDef>
 * {
 * condition: {value: ...},
 * field: ...,
 * ...
 * }
 *
 * A ValueDef with Condition<ValueDef | FieldDef>
 * {
 * condition: {field: ...} | {value: ...},
 * value: ...,
 * }
 */
@Serializable
data class TextDefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    val format: String? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null,

    /**
     * A constant value in visual domain.
     */
    val value: JsonElement? = null
)

typealias TextCondition = JsonElement

@Serializable
data class ConditionalPredicateTextFieldDefClass (
    val test: JsonElement? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement? = null,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection: JsonElement? = null,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    val format: String? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null
)

/**
 * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
 *
 * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
 *
 * Definition object for a constant value of an encoding channel.
 */
@Serializable
data class XClass (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * An object defining properties of axis's gridlines, ticks and labels.
     * If `null`, the axis for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [axis properties](axis.html) are applied.
     */
    val axis: Axis? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale: Scale? = null,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort: JsonElement? = null,

    /**
     * Type of stacking offset if the field should be stacked.
     * `stack` is only applicable for `x` and `y` channels with continuous domains.
     * For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
     *
     * `stack` can be one of the following values:
     *
     * - `"zero"`: stacking with baseline offset at zero value of the scale (for creating
     * typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
     * - `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
     * and area charts](stack.html#normalized). <br/>
     * - `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
     * - `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
     * area chart.
     *
     * __Default value:__ `zero` for plots with all of the following conditions are true:
     *
     * 1. The mark is `bar` or `area`;
     * 2. The stacked measure channel (x or y) has a linear scale;
     * 3. At least one of non-position channels mapped to an unaggregated field that is
     * different from x and y.  Otherwise, `null` by default.
     */
    val stack: StackOffset? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement? = null
)

@Serializable
data class Axis (
    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain: Boolean? = null,

    /**
     * The formatting pattern for labels. This is D3's [number format
     * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
     * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
     * field.
     *
     * See the [format documentation](format.html) for more information.
     *
     * __Default value:__  derived from [numberFormat](config.html#format) config for
     * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
     */
    val format: String? = null,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid: Boolean? = null,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle: Double? = null,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound: JsonElement? = null,

    /**
     * Indicates if the first and last axis labels should be aligned flush with the scale range.
     * Flush alignment for a horizontal axis will left-align the first label and right-align the
     * last label. For vertical axes, bottom and top text baselines are applied instead. If this
     * property is a number, it also indicates the number of pixels by which to offset the first
     * and last labels; for example, a value of 2 will flush-align the first and last labels and
     * also push them 2 pixels outward from the center of the axis. The additional adjustment
     * can sometimes help the labels better visually group with corresponding axis ticks.
     *
     * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
     */
    val labelFlush: JsonElement? = null,

    /**
     * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
     * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
     * every other label is used (this works well for standard linear axes). If set to
     * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
     * with the last visible label (this often works better for log-scaled axes).
     *
     * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
     * scales; otherwise `false`.
     */
    val labelOverlap: JsonElement? = null,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding: Double? = null,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels: Boolean? = null,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent: Double? = null,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent: Double? = null,

    /**
     * The offset, in pixels, by which to displace the axis from the edge of the enclosing group
     * or data rectangle.
     *
     * __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
     * `offset` (`0` by default)
     */
    val offset: Double? = null,

    /**
     * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
     * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
     * the right edge of the chart).
     *
     * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
     */
    val orient: TitleOrient? = null,

    /**
     * The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
     * this sets the axis group x coordinate. For y-axis with left or right orientation, this
     * sets the axis group y coordinate.
     *
     * __Default value__: `0`
     */
    val position: Double? = null,

    /**
     * A desired number of ticks, for axes visualizing quantitative scales. The resulting number
     * may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
     * underlying scale's range.
     */
    val tickCount: Double? = null,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks: Boolean? = null,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize: Double? = null,

    /**
     * A title for the field. If `null`, the title will be removed.
     *
     * __Default value:__  derived from the field's name and transformation function
     * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
     * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
     * binned or has a time unit applied, the applied function will be denoted in parentheses
     * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
     * simply the field name.
     *
     * __Note__: You can customize the default field title format by providing the [`fieldTitle`
     * property in the [config](config.html) or [`fieldTitle` function via the `compile`
     * function's options](compile.html#field-title).
     */
    val title: String? = null,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength: Double? = null,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding: Double? = null,

    /**
     * Explicitly set the visible axis tick values.
     */
    val values: JsonArray? = null,

    /**
     * A non-positive integer indicating z-index of the axis.
     * If zindex is 0, axes should be drawn behind all chart elements.
     * To put them in front, use `"zindex = 1"`.
     *
     * __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
     * for grids.
     */
    val zindex: Double? = null
)

typealias AxisValue = JsonElement

/**
 * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Definition object for a data field, its type and transformation of an encoding channel.
 *
 * Definition object for a constant value of an encoding channel.
 */
@Serializable
data class X2Class (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate: AggregateOp? = null,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin: JsonElement? = null,

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    val field: JsonElement? = null,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit: TimeUnit? = null,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val type: Type? = null,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value: JsonElement? = null
)

/**
 * An object that describes mappings between `row` and `column` channels and their field
 * definitions.
 */
@Serializable
data class FacetMapping (
    /**
     * Horizontal facets for trellis plots.
     */
    val column: FacetFieldDef? = null,

    /**
     * Vertical facets for trellis plots.
     */
    val row: FacetFieldDef? = null
)

/**
 * Unit spec that can have a composite mark.
 */
@Serializable
data class Spec (
    /**
     * An object describing the data source
     */
    val data: Data? = null,

    /**
     * Description of this mark for commenting purpose.
     */
    val description: String? = null,

    /**
     * The height of a visualization.
     *
     * __Default value:__
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
     * [continuous scale](scale.html#continuous), the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the height is [determined by the range step, paddings, and the
     * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
     * `rangeStep` is `null`, the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
     *
     * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the height of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val height: Double? = null,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer: List<LayerSpec>? = null,

    /**
     * Name of the visualization for later reference.
     */
    val name: String? = null,

    /**
     * Scale, axis, and legend resolutions for layers.
     *
     * Scale, axis, and legend resolutions for facets.
     *
     * Scale and legend resolutions for repeated charts.
     *
     * Scale, axis, and legend resolutions for vertically concatenated charts.
     *
     * Scale, axis, and legend resolutions for horizontally concatenated charts.
     */
    val resolve: Resolve? = null,

    /**
     * Title for the plot.
     */
    val title: JsonElement? = null,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform: List<Transform>? = null,

    /**
     * The width of a visualization.
     *
     * __Default value:__ This will be determined by the following rules:
     *
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
     * [continuous scale](scale.html#continuous), the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the width is [determined by the range step, paddings, and the
     * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
     * `rangeStep` is `null`, the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - If no field is mapped to `x` channel, the `width` will be the value of
     * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
     * the value of `rangeStep` for other marks.
     *
     * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the width of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val width: Double? = null,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding: Encoding? = null,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark: JsonElement? = null,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection: Projection? = null,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection: Map<String, SelectionDef>? = null,

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    val facet: FacetMapping? = null,

    /**
     * A specification of the view that gets faceted.
     */
    val spec: Spec? = null,

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    val repeat: Repeat? = null,

    /**
     * A list of views that should be concatenated and put into a column.
     */
    val vconcat: List<Spec>? = null,

    /**
     * A list of views that should be concatenated and put into a row.
     */
    val hconcat: List<Spec>? = null
)

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
@Serializable
data class Encoding (
    /**
     * Color of the marks – either fill or stroke color based on mark type.
     * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
     * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
     *
     * __Default value:__ If undefined, the default color depends on [mark
     * config](config.html#mark)'s `color` property.
     *
     * _Note:_ See the scale documentation for more information about customizing [color
     * scheme](scale.html#scheme).
     */
    val color: MarkPropDefWithCondition? = null,

    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    val detail: JsonElement? = null,

    /**
     * A URL to load upon mouse click.
     */
    val href: DefWithCondition? = null,

    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    val opacity: MarkPropDefWithCondition? = null,

    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    val order: JsonElement? = null,

    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    val shape: MarkPropDefWithCondition? = null,

    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    val size: MarkPropDefWithCondition? = null,

    /**
     * Text of the `text` mark.
     */
    val text: TextDefWithCondition? = null,

    /**
     * The tooltip text to show upon mouse hover.
     */
    val tooltip: TextDefWithCondition? = null,

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    val x: XClass? = null,

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val x2: X2Class? = null,

    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    val y: XClass? = null,

    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val y2: X2Class? = null
)

/**
 * Unit spec that can have a composite mark.
 */
@Serializable
data class LayerSpec (
    /**
     * An object describing the data source
     */
    val data: Data? = null,

    /**
     * Description of this mark for commenting purpose.
     */
    val description: String? = null,

    /**
     * The height of a visualization.
     *
     * __Default value:__
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
     * [continuous scale](scale.html#continuous), the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the height is [determined by the range step, paddings, and the
     * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
     * `rangeStep` is `null`, the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
     *
     * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the height of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val height: Double? = null,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer: List<LayerSpec>? = null,

    /**
     * Name of the visualization for later reference.
     */
    val name: String? = null,

    /**
     * Scale, axis, and legend resolutions for layers.
     */
    val resolve: Resolve? = null,

    /**
     * Title for the plot.
     */
    val title: JsonElement? = null,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform: List<Transform>? = null,

    /**
     * The width of a visualization.
     *
     * __Default value:__ This will be determined by the following rules:
     *
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
     * [continuous scale](scale.html#continuous), the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the width is [determined by the range step, paddings, and the
     * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
     * `rangeStep` is `null`, the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - If no field is mapped to `x` channel, the `width` will be the value of
     * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
     * the value of `rangeStep` for other marks.
     *
     * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the width of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    val width: Double? = null,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding: Encoding? = null,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark: JsonElement? = null,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection: Projection? = null,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection: Map<String, SelectionDef>? = null
)

typealias AnyMark = JsonElement

@Serializable
data class MarkDef (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align: HorizontalAlign? = null,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle: Double? = null,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline: VerticalAlign? = null,

    /**
     * Whether a mark be clipped to the enclosing group’s width and height.
     */
    val clip: Boolean? = null,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color: String? = null,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor: Cursor? = null,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx: Double? = null,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy: Double? = null,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill: String? = null,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled: Boolean? = null,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity: Double? = null,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font: String? = null,

    /**
     * The font size, in pixels.
     */
    val fontSize: Double? = null,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle: FontStyle? = null,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight: JsonElement? = null,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href: String? = null,

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    val interpolate: Interpolate? = null,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit: Double? = null,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity: Double? = null,

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    val orient: Orient? = null,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius: Double? = null,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape: String? = null,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size: Double? = null,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke: String? = null,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash: List<Double>? = null,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset: Double? = null,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity: Double? = null,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth: Double? = null,

    /**
     * A string or array of strings indicating the name of custom styles to apply to the mark. A
     * style is a named collection of mark property defaults defined within the [style
     * configuration](mark.html#style-config). If style is an array, later styles will override
     * earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
     * the `encoding` will override a style default.
     *
     * __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
     * default.
     * __Note:__ Any specified style will augment the default style. For example, a bar mark
     * with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
     * specified style `"foo"` has higher precedence).
     */
    val style: JsonElement? = null,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension: Double? = null,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text: String? = null,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta: Double? = null,

    /**
     * The mark type.
     * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
     * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
     */
    val type: Mark
)

typealias Style = JsonElement

/**
 * All types of primitive marks.
 *
 * The mark type.
 * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
 * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
 */
@Serializable
enum class Mark(val value: String) {
    @SerialName("area") Area("area"),
    @SerialName("bar") Bar("bar"),
    @SerialName("line") Line("line"),
    @SerialName("point") Point("point"),
    @SerialName("text") Text("text"),
    @SerialName("tick") Tick("tick"),
    @SerialName("rect") Rect("rect"),
    @SerialName("rule") Rule("rule"),
    @SerialName("circle") Circle("circle"),
    @SerialName("square") Square("square"),
    @SerialName("geoshape") Geoshape("geoshape");
}

/**
 * An object defining properties of geographic projection.
 *
 * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
 * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
 */
@Serializable
data class Projection (
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    val center: List<Double>? = null,

    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    val clipAngle: Double? = null,

    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    val clipExtent: List<List<Double>>? = null,

    val coefficient: Double? = null,
    val distance: Double? = null,
    val fraction: Double? = null,
    val lobes: Double? = null,
    val parallel: Double? = null,

    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    val precision: JsonObject? = null,

    val radius: Double? = null,
    val ratio: Double? = null,

    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    val rotate: List<Double>? = null,

    val spacing: Double? = null,
    val tilt: Double? = null,

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    val type: VGProjectionType? = null
)

/**
 * Scale, axis, and legend resolutions for layers.
 *
 * Defines how scales, axes, and legends from different specs should be combined. Resolve is
 * a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
 *
 * Scale, axis, and legend resolutions for facets.
 *
 * Scale and legend resolutions for repeated charts.
 *
 * Scale, axis, and legend resolutions for vertically concatenated charts.
 *
 * Scale, axis, and legend resolutions for horizontally concatenated charts.
 */
@Serializable
data class Resolve (
    val axis: AxisResolveMap? = null,
    val legend: LegendResolveMap? = null,
    val scale: ScaleResolveMap? = null
)

@Serializable
data class AxisResolveMap (
    val x: ResolveMode? = null,
    val y: ResolveMode? = null
)

@Serializable
enum class ResolveMode(val value: String) {
    @SerialName("independent") Independent("independent"),
    @SerialName("shared") Shared("shared");
}

@Serializable
data class LegendResolveMap (
    val color: ResolveMode? = null,
    val opacity: ResolveMode? = null,
    val shape: ResolveMode? = null,
    val size: ResolveMode? = null
)

@Serializable
data class ScaleResolveMap (
    val color: ResolveMode? = null,
    val opacity: ResolveMode? = null,
    val shape: ResolveMode? = null,
    val size: ResolveMode? = null,
    val x: ResolveMode? = null,
    val y: ResolveMode? = null
)

@Serializable
data class SelectionDef (
    /**
     * Establish a two-way binding between a single selection and input elements
     * (also known as dynamic query widgets). A binding takes the form of
     * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
     * or can be a mapping between projected field/encodings and binding definitions.
     *
     * See the [bind transform](bind.html) documentation for more information.
     *
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    val bind: JsonElement? = null,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty: Empty? = null,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings: List<SingleDefChannel>? = null,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields: List<String>? = null,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest: Boolean? = null,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on: JsonElement? = null,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve: SelectionResolution? = null,

    val type: SelectionDefType,

    /**
     * Controls whether data values should be toggled or only ever inserted into
     * multi selections. Can be `true`, `false` (for insertion only), or a
     * [Vega expression](https://vega.github.io/vega/docs/expressions/).
     *
     * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
     * data values are toggled when a user interacts with the shift-key pressed).
     *
     * See the [toggle transform](toggle.html) documentation for more information.
     */
    val toggle: JsonElement? = null,

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    val mark: BrushConfig? = null,

    /**
     * When truthy, allows a user to interactively move an interval selection
     * back-and-forth. Can be `true`, `false` (to disable panning), or a
     * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
     * which must include a start and end event to trigger continuous panning.
     *
     * __Default value:__ `true`, which corresponds to
     * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
     * clicks and dragging within an interval selection to reposition it.
     */
    val translate: JsonElement? = null,

    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    val zoom: JsonElement? = null
)

typealias BindUnion = JsonElement

@Serializable
enum class SelectionDefType(val value: String) {
    @SerialName("single") Single("single"),
    @SerialName("multi") Multi("multi"),
    @SerialName("interval") Interval("interval");
}

typealias Title = JsonElement

@Serializable
data class TitleParams (
    /**
     * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
     * example, with an orientation of top these anchor positions map to a left-, center-, or
     * right-aligned title.
     *
     * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
     * `"start"` for other composite views.
     *
     * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
     * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
     * composite views, `anchor` is always `"start"`.
     */
    val anchor: Anchor? = null,

    /**
     * The orthogonal offset in pixels by which to displace the title from its position along
     * the edge of the chart.
     */
    val offset: Double? = null,

    /**
     * The orientation of the title relative to the chart. One of `"top"` (the default),
     * `"bottom"`, `"left"`, or `"right"`.
     */
    val orient: TitleOrient? = null,

    /**
     * A [mark style property](config.html#style) to apply to the title text mark.
     *
     * __Default value:__ `"group-title"`.
     */
    val style: JsonElement? = null,

    /**
     * The title text.
     */
    val text: String
)

@Serializable
data class Transform (
    /**
     * The `filter` property must be one of the predicate definitions:
     * (1) an [expression](types.html#expression) string,
     * where `datum` can be used to refer to the current data object;
     * (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
     * [range predicate](filter.html#range-predicate), [one-of
     * predicate](filter.html#one-of-predicate);
     * (3) a [selection predicate](filter.html#selection-predicate);
     * or (4) a logical operand that combines (1), (2), or (3).
     */
    val filter: JsonElement? = null,

    /**
     * The field for storing the computed formula value.
     *
     * The field or fields for storing the computed formula value.
     * If `from.fields` is specified, the transform will use the same names for `as`.
     * If `from.fields` is not specified, `as` has to be a string and we put the whole object
     * into the data under the specified name.
     *
     * The output fields at which to write the start and end bin values.
     *
     * The output field to write the timeUnit value.
     */
    @SerialName("as")
    val transformAs: JsonElement? = null,

    /**
     * A [expression](types.html#expression) string. Use the variable `datum` to refer to the
     * current data object.
     */
    val calculate: String? = null,

    /**
     * The default value to use if lookup fails.
     *
     * __Default value:__ `null`
     */
    val default: String? = null,

    /**
     * Secondary data reference.
     */
    val from: LookupData? = null,

    /**
     * Key in primary data source.
     */
    val lookup: String? = null,

    /**
     * An object indicating bin properties, or simply `true` for using default bin parameters.
     */
    val bin: JsonElement? = null,

    /**
     * The data field to bin.
     *
     * The data field to apply time unit.
     */
    val field: String? = null,

    /**
     * The timeUnit.
     */
    val timeUnit: TimeUnit? = null,

    /**
     * Array of objects that define fields to aggregate.
     */
    val aggregate: List<AggregatedFieldDef>? = null,

    /**
     * The data fields to group by. If not specified, a single group containing all data objects
     * will be used.
     */
    val groupby: List<String>? = null
)

@Serializable
data class AggregatedFieldDef (
    /**
     * The output field names to use for each aggregated field.
     */
    @SerialName("as")
    val aggregatedFieldDefAs: String,

    /**
     * The data field for which to compute aggregate function.
     */
    val field: String,

    /**
     * The aggregation operations to apply to the fields, such as sum, average or count.
     * See the [full list of supported aggregation
     * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
     * for more information.
     */
    val op: AggregateOp
)

/**
 * Secondary data reference.
 */
@Serializable
data class LookupData (
    /**
     * Secondary data source to lookup in.
     */
    val data: Data,

    /**
     * Fields in foreign data to lookup.
     * If not specified, the entire object is queried.
     */
    val fields: List<String>? = null,

    /**
     * Key in data to lookup.
     */
    val key: String
)

/**
 * An object that describes what fields should be repeated into views that are laid out as a
 * `row` or `column`.
 */
@Serializable
data class Repeat (
    /**
     * Horizontal repeated views.
     */
    val column: List<String>? = null,

    /**
     * Vertical repeated views.
     */
    val row: List<String>? = null
)
