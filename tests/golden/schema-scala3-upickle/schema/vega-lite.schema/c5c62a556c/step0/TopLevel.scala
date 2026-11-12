package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    /**
     * URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
     * have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
     * Setting the `$schema` property allows automatic validation and autocomplete in editors
     * that support JSON schema.
     */
    val `$schema` : Option[String] = None,

    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    val autosize : Option[Autosize] = None,

    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    val background : Option[String] = None,

    /**
     * Vega-Lite configuration object.  This property can only be defined at the top-level of a
     * specification.
     */
    val config : Option[Config] = None,

    /**
     * An object describing the data source
     */
    val data : Option[Data] = None,

    /**
     * Description of this mark for commenting purpose.
     */
    val description : Option[String] = None,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding : Option[EncodingWithFacet] = None,

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
    val height : Option[Double] = None,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark : Option[AnyMark] = None,

    /**
     * Name of the visualization for later reference.
     */
    val name : Option[String] = None,

    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    val padding : Option[Padding] = None,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection : Option[Projection] = None,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection : Option[Map[String, SelectionDef]] = None,

    /**
     * Title for the plot.
     */
    val title : Option[Title] = None,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform : Option[Seq[Transform]] = None,

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
    val width : Option[Double] = None,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer : Option[Seq[LayerSpec]] = None,

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
    val resolve : Option[Resolve] = None,

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    val facet : Option[FacetMapping] = None,

    /**
     * A specification of the view that gets faceted.
     */
    val spec : Option[Spec] = None,

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    val repeat : Option[Repeat] = None,

    /**
     * A list of views that should be concatenated and put into a column.
     */
    val vconcat : Option[Seq[Spec]] = None,

    /**
     * A list of views that should be concatenated and put into a row.
     */
    val hconcat : Option[Seq[Spec]] = None
) derives OptionPickler.ReadWriter

/**
 * Sets how the visualization size should be determined. If a string, should be one of
 * `"pad"`, `"fit"` or `"none"`.
 * Object values can additionally specify parameters for content sizing and automatic
 * resizing.
 * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
 *
 * __Default value__: `pad`
 */
type Autosize = AutoSizeParams | AutosizeType
given unionReaderAutosize: OptionPickler.Reader[Autosize] = JsonExt.badMerge[Autosize](
    summon[OptionPickler.Reader[AutosizeType]],
    summon[OptionPickler.Reader[AutoSizeParams]],
    )

given unionWriterAutosize: OptionPickler.Writer[Autosize] = OptionPickler.writer[ujson.Value].comap[Autosize]{ _v =>
    (_v: @unchecked) match 
        case v: AutosizeType => OptionPickler.writeJs[AutosizeType](v)
        case v: AutoSizeParams => OptionPickler.writeJs[AutoSizeParams](v)
}

case class AutoSizeParams (
    /**
     * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
     * The default setting (`"content"`) interprets the width and height settings as the data
     * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
     * `"padding"` setting includes the padding within the view size calculations, such that the
     * width and height settings indicate the **total** intended size of the view.
     *
     * __Default value__: `"content"`
     */
    val contains : Option[Contains] = None,

    /**
     * A boolean flag indicating if autosize layout should be re-calculated on every view
     * update.
     *
     * __Default value__: `false`
     */
    val resize : Option[Boolean] = None,

    /**
     * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
     * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
     * descriptions of each.
     *
     * __Default value__: `"pad"`
     */
    val `type` : Option[AutosizeType] = None
) derives OptionPickler.ReadWriter

/**
 * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
 * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
 * descriptions of each.
 *
 * __Default value__: `"pad"`
 */

enum AutosizeType : 
    case Pad
    case Fit
    case None

given OptionPickler.ReadWriter[AutosizeType] = OptionPickler.readwriter[String].bimap[AutosizeType](
    {
        case AutosizeType.Pad => "pad"
        case AutosizeType.Fit => "fit"
        case AutosizeType.None => "none"
    },
    {
        case "pad" => AutosizeType.Pad
        case "fit" => AutosizeType.Fit
        case "none" => AutosizeType.None
        case other => throw new upickle.core.Abort("invalid AutosizeType: " + other)
    }
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

enum Contains : 
    case Content
    case Padding

given OptionPickler.ReadWriter[Contains] = OptionPickler.readwriter[String].bimap[Contains](
    {
        case Contains.Content => "content"
        case Contains.Padding => "padding"
    },
    {
        case "content" => Contains.Content
        case "padding" => Contains.Padding
        case other => throw new upickle.core.Abort("invalid Contains: " + other)
    }
)

/**
 * Vega-Lite configuration object.  This property can only be defined at the top-level of a
 * specification.
 */
case class Config (
    /**
     * Area-Specific Config
     */
    val area : Option[MarkConfig] = None,

    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    val autosize : Option[Autosize] = None,

    /**
     * Axis configuration, which determines default properties for all `x` and `y`
     * [axes](axis.html). For a full list of axis configuration options, please see the
     * [corresponding section of the axis documentation](axis.html#config).
     */
    val axis : Option[AxisConfig] = None,

    /**
     * Specific axis config for axes with "band" scales.
     */
    val axisBand : Option[VGAxisConfig] = None,

    /**
     * Specific axis config for x-axis along the bottom edge of the chart.
     */
    val axisBottom : Option[VGAxisConfig] = None,

    /**
     * Specific axis config for y-axis along the left edge of the chart.
     */
    val axisLeft : Option[VGAxisConfig] = None,

    /**
     * Specific axis config for y-axis along the right edge of the chart.
     */
    val axisRight : Option[VGAxisConfig] = None,

    /**
     * Specific axis config for x-axis along the top edge of the chart.
     */
    val axisTop : Option[VGAxisConfig] = None,

    /**
     * X-axis specific config.
     */
    val axisX : Option[VGAxisConfig] = None,

    /**
     * Y-axis specific config.
     */
    val axisY : Option[VGAxisConfig] = None,

    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    val background : Option[String] = None,

    /**
     * Bar-Specific Config
     */
    val bar : Option[BarConfig] = None,

    /**
     * Circle-Specific Config
     */
    val circle : Option[MarkConfig] = None,

    /**
     * Default axis and legend title for count fields.
     *
     * __Default value:__ `'Number of Records'`.
     */
    val countTitle : Option[String] = None,

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
    val fieldTitle : Option[FieldTitle] = None,

    /**
     * Geoshape-Specific Config
     */
    val geoshape : Option[MarkConfig] = None,

    /**
     * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
     * - If set to `"filter"` (default), all data items with null values are filtered.
     * - If `null`, all data items are included. In this case, invalid values will be
     * interpreted as zeroes.
     */
    val invalidValues : Option[InvalidValues] = None,

    /**
     * Legend configuration, which determines default properties for all [legends](legend.html).
     * For a full list of legend configuration options, please see the [corresponding section of
     * in the legend documentation](legend.html#config).
     */
    val legend : Option[LegendConfig] = None,

    /**
     * Line-Specific Config
     */
    val line : Option[MarkConfig] = None,

    /**
     * Mark Config
     */
    val mark : Option[MarkConfig] = None,

    /**
     * D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
     * number format pattern](https://github.com/d3/d3-format#locale_format).
     */
    val numberFormat : Option[String] = None,

    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    val padding : Option[Padding] = None,

    /**
     * Point-Specific Config
     */
    val point : Option[MarkConfig] = None,

    /**
     * Projection configuration, which determines default properties for all
     * [projections](projection.html). For a full list of projection configuration options,
     * please see the [corresponding section of the projection
     * documentation](projection.html#config).
     */
    val projection : Option[ProjectionConfig] = None,

    /**
     * An object hash that defines default range arrays or schemes for using with scales.
     * For a full list of scale range configuration options, please see the [corresponding
     * section of the scale documentation](scale.html#config).
     */
    val range : Option[Map[String, RangeConfigValue]] = None,

    /**
     * Rect-Specific Config
     */
    val rect : Option[MarkConfig] = None,

    /**
     * Rule-Specific Config
     */
    val rule : Option[MarkConfig] = None,

    /**
     * Scale configuration determines default properties for all [scales](scale.html). For a
     * full list of scale configuration options, please see the [corresponding section of the
     * scale documentation](scale.html#config).
     */
    val scale : Option[ScaleConfig] = None,

    /**
     * An object hash for defining default properties for each type of selections.
     */
    val selection : Option[SelectionConfig] = None,

    /**
     * Square-Specific Config
     */
    val square : Option[MarkConfig] = None,

    /**
     * Default stack offset for stackable mark.
     */
    val stack : Option[StackOffset] = None,

    /**
     * An object hash that defines key-value mappings to determine default properties for marks
     * with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
     * valid [mark configuration objects](mark.html#config).
     */
    val style : Option[Map[String, VGMarkConfig]] = None,

    /**
     * Text-Specific Config
     */
    val text : Option[TextConfig] = None,

    /**
     * Tick-Specific Config
     */
    val tick : Option[TickConfig] = None,

    /**
     * Default datetime format for axis and legend labels. The format can be set directly on
     * each axis and legend. Use [D3's time format
     * pattern](https://github.com/d3/d3-time-format#locale_format).
     *
     * __Default value:__ `'%b %d, %Y'`.
     */
    val timeFormat : Option[String] = None,

    /**
     * Title configuration, which determines default properties for all [titles](title.html).
     * For a full list of title configuration options, please see the [corresponding section of
     * the title documentation](title.html#config).
     */
    val title : Option[VGTitleConfig] = None,

    /**
     * Default properties for [single view plots](spec.html#single).
     */
    val view : Option[ViewConfig] = None
) derives OptionPickler.ReadWriter

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
case class MarkConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color : Option[String] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled : Option[Boolean] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
 */

enum HorizontalAlign : 
    case Left
    case Right
    case Center

given OptionPickler.ReadWriter[HorizontalAlign] = OptionPickler.readwriter[String].bimap[HorizontalAlign](
    {
        case HorizontalAlign.Left => "left"
        case HorizontalAlign.Right => "right"
        case HorizontalAlign.Center => "center"
    },
    {
        case "left" => HorizontalAlign.Left
        case "right" => HorizontalAlign.Right
        case "center" => HorizontalAlign.Center
        case other => throw new upickle.core.Abort("invalid HorizontalAlign: " + other)
    }
)

/**
 * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
 *
 * __Default value:__ `"middle"`
 *
 * Vertical text baseline for title text.
 */

enum VerticalAlign : 
    case Top
    case Middle
    case Bottom

given OptionPickler.ReadWriter[VerticalAlign] = OptionPickler.readwriter[String].bimap[VerticalAlign](
    {
        case VerticalAlign.Top => "top"
        case VerticalAlign.Middle => "middle"
        case VerticalAlign.Bottom => "bottom"
    },
    {
        case "top" => VerticalAlign.Top
        case "middle" => VerticalAlign.Middle
        case "bottom" => VerticalAlign.Bottom
        case other => throw new upickle.core.Abort("invalid VerticalAlign: " + other)
    }
)

/**
 * The mouse cursor used over the mark. Any valid [CSS cursor
 * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
 */

enum Cursor : 
    case Auto
    case Default
    case None
    case ContextMenu
    case Help
    case Pointer
    case Progress
    case Wait
    case Cell
    case Crosshair
    case Text
    case VerticalText
    case Alias
    case Copy
    case Move
    case NoDrop
    case NotAllowed
    case EResize
    case NResize
    case NeResize
    case NwResize
    case SResize
    case SEResize
    case SwResize
    case WResize
    case EwResize
    case NSResize
    case NeswResize
    case NwseResize
    case ColResize
    case RowResize
    case AllScroll
    case ZoomIn
    case ZoomOut
    case Grab
    case Grabbing

given OptionPickler.ReadWriter[Cursor] = OptionPickler.readwriter[String].bimap[Cursor](
    {
        case Cursor.Auto => "auto"
        case Cursor.Default => "default"
        case Cursor.None => "none"
        case Cursor.ContextMenu => "context-menu"
        case Cursor.Help => "help"
        case Cursor.Pointer => "pointer"
        case Cursor.Progress => "progress"
        case Cursor.Wait => "wait"
        case Cursor.Cell => "cell"
        case Cursor.Crosshair => "crosshair"
        case Cursor.Text => "text"
        case Cursor.VerticalText => "vertical-text"
        case Cursor.Alias => "alias"
        case Cursor.Copy => "copy"
        case Cursor.Move => "move"
        case Cursor.NoDrop => "no-drop"
        case Cursor.NotAllowed => "not-allowed"
        case Cursor.EResize => "e-resize"
        case Cursor.NResize => "n-resize"
        case Cursor.NeResize => "ne-resize"
        case Cursor.NwResize => "nw-resize"
        case Cursor.SResize => "s-resize"
        case Cursor.SEResize => "se-resize"
        case Cursor.SwResize => "sw-resize"
        case Cursor.WResize => "w-resize"
        case Cursor.EwResize => "ew-resize"
        case Cursor.NSResize => "ns-resize"
        case Cursor.NeswResize => "nesw-resize"
        case Cursor.NwseResize => "nwse-resize"
        case Cursor.ColResize => "col-resize"
        case Cursor.RowResize => "row-resize"
        case Cursor.AllScroll => "all-scroll"
        case Cursor.ZoomIn => "zoom-in"
        case Cursor.ZoomOut => "zoom-out"
        case Cursor.Grab => "grab"
        case Cursor.Grabbing => "grabbing"
    },
    {
        case "auto" => Cursor.Auto
        case "default" => Cursor.Default
        case "none" => Cursor.None
        case "context-menu" => Cursor.ContextMenu
        case "help" => Cursor.Help
        case "pointer" => Cursor.Pointer
        case "progress" => Cursor.Progress
        case "wait" => Cursor.Wait
        case "cell" => Cursor.Cell
        case "crosshair" => Cursor.Crosshair
        case "text" => Cursor.Text
        case "vertical-text" => Cursor.VerticalText
        case "alias" => Cursor.Alias
        case "copy" => Cursor.Copy
        case "move" => Cursor.Move
        case "no-drop" => Cursor.NoDrop
        case "not-allowed" => Cursor.NotAllowed
        case "e-resize" => Cursor.EResize
        case "n-resize" => Cursor.NResize
        case "ne-resize" => Cursor.NeResize
        case "nw-resize" => Cursor.NwResize
        case "s-resize" => Cursor.SResize
        case "se-resize" => Cursor.SEResize
        case "sw-resize" => Cursor.SwResize
        case "w-resize" => Cursor.WResize
        case "ew-resize" => Cursor.EwResize
        case "ns-resize" => Cursor.NSResize
        case "nesw-resize" => Cursor.NeswResize
        case "nwse-resize" => Cursor.NwseResize
        case "col-resize" => Cursor.ColResize
        case "row-resize" => Cursor.RowResize
        case "all-scroll" => Cursor.AllScroll
        case "zoom-in" => Cursor.ZoomIn
        case "zoom-out" => Cursor.ZoomOut
        case "grab" => Cursor.Grab
        case "grabbing" => Cursor.Grabbing
        case other => throw new upickle.core.Abort("invalid Cursor: " + other)
    }
)

/**
 * The font style (e.g., `"italic"`).
 */

enum FontStyle : 
    case Normal
    case Italic

given OptionPickler.ReadWriter[FontStyle] = OptionPickler.readwriter[String].bimap[FontStyle](
    {
        case FontStyle.Normal => "normal"
        case FontStyle.Italic => "italic"
    },
    {
        case "normal" => FontStyle.Normal
        case "italic" => FontStyle.Italic
        case other => throw new upickle.core.Abort("invalid FontStyle: " + other)
    }
)

/**
 * The font weight (e.g., `"bold"`).
 *
 * Font weight for title text.
 */
type FontWeightUnion = Double | FontWeight
given unionReaderFontWeightUnion: OptionPickler.Reader[FontWeightUnion] = JsonExt.badMerge[FontWeightUnion](
    summon[OptionPickler.Reader[FontWeight]],
    JsonExt.strictDouble,
    )

given unionWriterFontWeightUnion: OptionPickler.Writer[FontWeightUnion] = OptionPickler.writer[ujson.Value].comap[FontWeightUnion]{ _v =>
    (_v: @unchecked) match 
        case v: FontWeight => OptionPickler.writeJs[FontWeight](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

enum FontWeight : 
    case Normal
    case Bold

given OptionPickler.ReadWriter[FontWeight] = OptionPickler.readwriter[String].bimap[FontWeight](
    {
        case FontWeight.Normal => "normal"
        case FontWeight.Bold => "bold"
    },
    {
        case "normal" => FontWeight.Normal
        case "bold" => FontWeight.Bold
        case other => throw new upickle.core.Abort("invalid FontWeight: " + other)
    }
)

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

enum Interpolate : 
    case Linear
    case LinearClosed
    case Step
    case StepBefore
    case StepAfter
    case Basis
    case BasisOpen
    case BasisClosed
    case Cardinal
    case CardinalOpen
    case CardinalClosed
    case Bundle
    case Monotone

given OptionPickler.ReadWriter[Interpolate] = OptionPickler.readwriter[String].bimap[Interpolate](
    {
        case Interpolate.Linear => "linear"
        case Interpolate.LinearClosed => "linear-closed"
        case Interpolate.Step => "step"
        case Interpolate.StepBefore => "step-before"
        case Interpolate.StepAfter => "step-after"
        case Interpolate.Basis => "basis"
        case Interpolate.BasisOpen => "basis-open"
        case Interpolate.BasisClosed => "basis-closed"
        case Interpolate.Cardinal => "cardinal"
        case Interpolate.CardinalOpen => "cardinal-open"
        case Interpolate.CardinalClosed => "cardinal-closed"
        case Interpolate.Bundle => "bundle"
        case Interpolate.Monotone => "monotone"
    },
    {
        case "linear" => Interpolate.Linear
        case "linear-closed" => Interpolate.LinearClosed
        case "step" => Interpolate.Step
        case "step-before" => Interpolate.StepBefore
        case "step-after" => Interpolate.StepAfter
        case "basis" => Interpolate.Basis
        case "basis-open" => Interpolate.BasisOpen
        case "basis-closed" => Interpolate.BasisClosed
        case "cardinal" => Interpolate.Cardinal
        case "cardinal-open" => Interpolate.CardinalOpen
        case "cardinal-closed" => Interpolate.CardinalClosed
        case "bundle" => Interpolate.Bundle
        case "monotone" => Interpolate.Monotone
        case other => throw new upickle.core.Abort("invalid Interpolate: " + other)
    }
)

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

enum Orient : 
    case Horizontal
    case Vertical

given OptionPickler.ReadWriter[Orient] = OptionPickler.readwriter[String].bimap[Orient](
    {
        case Orient.Horizontal => "horizontal"
        case Orient.Vertical => "vertical"
    },
    {
        case "horizontal" => Orient.Horizontal
        case "vertical" => Orient.Vertical
        case other => throw new upickle.core.Abort("invalid Orient: " + other)
    }
)

/**
 * Axis configuration, which determines default properties for all `x` and `y`
 * [axes](axis.html). For a full list of axis configuration options, please see the
 * [corresponding section of the axis documentation](axis.html#config).
 */
case class AxisConfig (
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    val bandPosition : Option[Double] = None,

    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain : Option[Boolean] = None,

    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainColor : Option[String] = None,

    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainWidth : Option[Double] = None,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid : Option[Boolean] = None,

    /**
     * Color of gridlines.
     */
    val gridColor : Option[String] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    val gridDash : Option[Seq[Double]] = None,

    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    val gridOpacity : Option[Double] = None,

    /**
     * The grid width, in pixels.
     */
    val gridWidth : Option[Double] = None,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle : Option[Double] = None,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound : Option[Label] = None,

    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    val labelColor : Option[String] = None,

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
    val labelFlush : Option[Label] = None,

    /**
     * The font of the tick label.
     */
    val labelFont : Option[String] = None,

    /**
     * The font size of the label, in pixels.
     */
    val labelFontSize : Option[Double] = None,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit : Option[Double] = None,

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
    val labelOverlap : Option[LabelOverlapUnion] = None,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding : Option[Double] = None,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels : Option[Boolean] = None,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent : Option[Double] = None,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent : Option[Double] = None,

    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    val shortTimeLabels : Option[Boolean] = None,

    /**
     * The color of the axis's tick.
     */
    val tickColor : Option[String] = None,

    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    val tickRound : Option[Boolean] = None,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks : Option[Boolean] = None,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize : Option[Double] = None,

    /**
     * The width, in pixels, of ticks.
     */
    val tickWidth : Option[Double] = None,

    /**
     * Horizontal text alignment of axis titles.
     */
    val titleAlign : Option[String] = None,

    /**
     * Angle in degrees of axis titles.
     */
    val titleAngle : Option[Double] = None,

    /**
     * Vertical text baseline for axis titles.
     */
    val titleBaseline : Option[String] = None,

    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    val titleColor : Option[String] = None,

    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    val titleFont : Option[String] = None,

    /**
     * Font size of the title.
     */
    val titleFontSize : Option[Double] = None,

    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    val titleFontWeight : Option[TitleFontWeight] = None,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit : Option[Double] = None,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength : Option[Double] = None,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding : Option[Double] = None,

    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    val titleX : Option[Double] = None,

    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    val titleY : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
 * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
 * they exceed the axis range by more than 1 pixel. If this property is a number, it
 * specifies the pixel tolerance: the maximum amount by which a label bounding box may
 * exceed the axis range.
 *
 * __Default value:__ `false`.
 *
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
type Label = Boolean | Double
given unionReaderLabel: OptionPickler.Reader[Label] = JsonExt.badMerge[Label](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    )

given unionWriterLabel: OptionPickler.Writer[Label] = OptionPickler.writer[ujson.Value].comap[Label]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type LabelOverlapUnion = Boolean | LabelOverlapEnum
given unionReaderLabelOverlapUnion: OptionPickler.Reader[LabelOverlapUnion] = JsonExt.badMerge[LabelOverlapUnion](
    summon[OptionPickler.Reader[LabelOverlapEnum]],
    JsonExt.strictBoolean,
    )

given unionWriterLabelOverlapUnion: OptionPickler.Writer[LabelOverlapUnion] = OptionPickler.writer[ujson.Value].comap[LabelOverlapUnion]{ _v =>
    (_v: @unchecked) match 
        case v: LabelOverlapEnum => OptionPickler.writeJs[LabelOverlapEnum](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
}

enum LabelOverlapEnum : 
    case Parity
    case Greedy

given OptionPickler.ReadWriter[LabelOverlapEnum] = OptionPickler.readwriter[String].bimap[LabelOverlapEnum](
    {
        case LabelOverlapEnum.Parity => "parity"
        case LabelOverlapEnum.Greedy => "greedy"
    },
    {
        case "parity" => LabelOverlapEnum.Parity
        case "greedy" => LabelOverlapEnum.Greedy
        case other => throw new upickle.core.Abort("invalid LabelOverlapEnum: " + other)
    }
)

/**
 * Font weight of the title. (e.g., `"bold"`).
 *
 * The font weight of the legend title.
 */
type TitleFontWeight = Double | String
given unionReaderTitleFontWeight: OptionPickler.Reader[TitleFontWeight] = JsonExt.badMerge[TitleFontWeight](
    JsonExt.strictString,
    JsonExt.strictDouble,
    )

given unionWriterTitleFontWeight: OptionPickler.Writer[TitleFontWeight] = OptionPickler.writer[ujson.Value].comap[TitleFontWeight]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

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
case class VGAxisConfig (
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    val bandPosition : Option[Double] = None,

    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain : Option[Boolean] = None,

    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainColor : Option[String] = None,

    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    val domainWidth : Option[Double] = None,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid : Option[Boolean] = None,

    /**
     * Color of gridlines.
     */
    val gridColor : Option[String] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    val gridDash : Option[Seq[Double]] = None,

    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    val gridOpacity : Option[Double] = None,

    /**
     * The grid width, in pixels.
     */
    val gridWidth : Option[Double] = None,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle : Option[Double] = None,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound : Option[Label] = None,

    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    val labelColor : Option[String] = None,

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
    val labelFlush : Option[Label] = None,

    /**
     * The font of the tick label.
     */
    val labelFont : Option[String] = None,

    /**
     * The font size of the label, in pixels.
     */
    val labelFontSize : Option[Double] = None,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit : Option[Double] = None,

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
    val labelOverlap : Option[LabelOverlapUnion] = None,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding : Option[Double] = None,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels : Option[Boolean] = None,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent : Option[Double] = None,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent : Option[Double] = None,

    /**
     * The color of the axis's tick.
     */
    val tickColor : Option[String] = None,

    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    val tickRound : Option[Boolean] = None,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks : Option[Boolean] = None,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize : Option[Double] = None,

    /**
     * The width, in pixels, of ticks.
     */
    val tickWidth : Option[Double] = None,

    /**
     * Horizontal text alignment of axis titles.
     */
    val titleAlign : Option[String] = None,

    /**
     * Angle in degrees of axis titles.
     */
    val titleAngle : Option[Double] = None,

    /**
     * Vertical text baseline for axis titles.
     */
    val titleBaseline : Option[String] = None,

    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    val titleColor : Option[String] = None,

    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    val titleFont : Option[String] = None,

    /**
     * Font size of the title.
     */
    val titleFontSize : Option[Double] = None,

    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    val titleFontWeight : Option[TitleFontWeight] = None,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit : Option[Double] = None,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength : Option[Double] = None,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding : Option[Double] = None,

    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    val titleX : Option[Double] = None,

    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    val titleY : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Bar-Specific Config
 */
case class BarConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
     * statisticians) or 1 (Vega-Lite Default, D3 example style).
     *
     * __Default value:__ `1`
     */
    val binSpacing : Option[Double] = None,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color : Option[String] = None,

    /**
     * The default size of the bars on continuous scales.
     *
     * __Default value:__ `5`
     */
    val continuousBandSize : Option[Double] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The size of the bars.  If unspecified, the default size is  `bandSize-1`,
     * which provides 1 pixel offset between bars.
     */
    val discreteBandSize : Option[Double] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled : Option[Boolean] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None
) derives OptionPickler.ReadWriter

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

enum FieldTitle : 
    case Verbal
    case Functional
    case Plain

given OptionPickler.ReadWriter[FieldTitle] = OptionPickler.readwriter[String].bimap[FieldTitle](
    {
        case FieldTitle.Verbal => "verbal"
        case FieldTitle.Functional => "functional"
        case FieldTitle.Plain => "plain"
    },
    {
        case "verbal" => FieldTitle.Verbal
        case "functional" => FieldTitle.Functional
        case "plain" => FieldTitle.Plain
        case other => throw new upickle.core.Abort("invalid FieldTitle: " + other)
    }
)

/**
 * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
 * - If set to `"filter"` (default), all data items with null values are filtered.
 * - If `null`, all data items are included. In this case, invalid values will be
 * interpreted as zeroes.
 */

enum InvalidValues : 
    case Filter

given OptionPickler.ReadWriter[InvalidValues] = OptionPickler.readwriter[String].bimap[InvalidValues](
    {
        case InvalidValues.Filter => "filter"
    },
    {
        case "filter" => InvalidValues.Filter
        case other => throw new upickle.core.Abort("invalid InvalidValues: " + other)
    }
)

/**
 * Legend configuration, which determines default properties for all [legends](legend.html).
 * For a full list of legend configuration options, please see the [corresponding section of
 * in the legend documentation](legend.html#config).
 */
case class LegendConfig (
    /**
     * Corner radius for the full legend.
     */
    val cornerRadius : Option[Double] = None,

    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    val entryPadding : Option[Double] = None,

    /**
     * Background fill color for the full legend.
     */
    val fillColor : Option[String] = None,

    /**
     * The height of the gradient, in pixels.
     */
    val gradientHeight : Option[Double] = None,

    /**
     * Text baseline for color ramp gradient labels.
     */
    val gradientLabelBaseline : Option[String] = None,

    /**
     * The maximum allowed length in pixels of color ramp gradient labels.
     */
    val gradientLabelLimit : Option[Double] = None,

    /**
     * Vertical offset in pixels for color ramp gradient labels.
     */
    val gradientLabelOffset : Option[Double] = None,

    /**
     * The color of the gradient stroke, can be in hex color code or regular color name.
     */
    val gradientStrokeColor : Option[String] = None,

    /**
     * The width of the gradient stroke, in pixels.
     */
    val gradientStrokeWidth : Option[Double] = None,

    /**
     * The width of the gradient, in pixels.
     */
    val gradientWidth : Option[Double] = None,

    /**
     * The alignment of the legend label, can be left, middle or right.
     */
    val labelAlign : Option[String] = None,

    /**
     * The position of the baseline of legend label, can be top, middle or bottom.
     */
    val labelBaseline : Option[String] = None,

    /**
     * The color of the legend label, can be in hex color code or regular color name.
     */
    val labelColor : Option[String] = None,

    /**
     * The font of the legend label.
     */
    val labelFont : Option[String] = None,

    /**
     * The font size of legend label.
     *
     * __Default value:__ `10`.
     */
    val labelFontSize : Option[Double] = None,

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    val labelLimit : Option[Double] = None,

    /**
     * The offset of the legend label.
     */
    val labelOffset : Option[Double] = None,

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    val offset : Option[Double] = None,

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    val orient : Option[LegendOrient] = None,

    /**
     * The padding, in pixels, between the legend and axis.
     */
    val padding : Option[Double] = None,

    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    val shortTimeLabels : Option[Boolean] = None,

    /**
     * Border stroke color for the full legend.
     */
    val strokeColor : Option[String] = None,

    /**
     * Border stroke dash pattern for the full legend.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * Border stroke width for the full legend.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * The color of the legend symbol,
     */
    val symbolColor : Option[String] = None,

    /**
     * The size of the legend symbol, in pixels.
     */
    val symbolSize : Option[Double] = None,

    /**
     * The width of the symbol's stroke.
     */
    val symbolStrokeWidth : Option[Double] = None,

    /**
     * Default shape type (such as "circle") for legend symbols.
     */
    val symbolType : Option[String] = None,

    /**
     * Horizontal text alignment for legend titles.
     */
    val titleAlign : Option[String] = None,

    /**
     * Vertical text baseline for legend titles.
     */
    val titleBaseline : Option[String] = None,

    /**
     * The color of the legend title, can be in hex color code or regular color name.
     */
    val titleColor : Option[String] = None,

    /**
     * The font of the legend title.
     */
    val titleFont : Option[String] = None,

    /**
     * The font size of the legend title.
     */
    val titleFontSize : Option[Double] = None,

    /**
     * The font weight of the legend title.
     */
    val titleFontWeight : Option[TitleFontWeight] = None,

    /**
     * Maximum allowed pixel width of axis titles.
     */
    val titleLimit : Option[Double] = None,

    /**
     * The padding, in pixels, between title and legend.
     */
    val titlePadding : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * The orientation of the legend, which determines how the legend is positioned within the
 * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
 * "none".
 *
 * __Default value:__ `"right"`
 */

enum LegendOrient : 
    case Left
    case Right
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight
    case None

given OptionPickler.ReadWriter[LegendOrient] = OptionPickler.readwriter[String].bimap[LegendOrient](
    {
        case LegendOrient.Left => "left"
        case LegendOrient.Right => "right"
        case LegendOrient.TopLeft => "top-left"
        case LegendOrient.TopRight => "top-right"
        case LegendOrient.BottomLeft => "bottom-left"
        case LegendOrient.BottomRight => "bottom-right"
        case LegendOrient.None => "none"
    },
    {
        case "left" => LegendOrient.Left
        case "right" => LegendOrient.Right
        case "top-left" => LegendOrient.TopLeft
        case "top-right" => LegendOrient.TopRight
        case "bottom-left" => LegendOrient.BottomLeft
        case "bottom-right" => LegendOrient.BottomRight
        case "none" => LegendOrient.None
        case other => throw new upickle.core.Abort("invalid LegendOrient: " + other)
    }
)

/**
 * The default visualization padding, in pixels, from the edge of the visualization canvas
 * to the data rectangle.  If a number, specifies padding for all sides.
 * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
 * "bottom": 5}` to specify padding for each side of the visualization.
 *
 * __Default value__: `5`
 */
type Padding = Double | PaddingClass
given unionReaderPadding: OptionPickler.Reader[Padding] = JsonExt.badMerge[Padding](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[PaddingClass]],
    )

given unionWriterPadding: OptionPickler.Writer[Padding] = OptionPickler.writer[ujson.Value].comap[Padding]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: PaddingClass => OptionPickler.writeJs[PaddingClass](v)
}

case class PaddingClass (
    val bottom : Option[Double] = None,
    val left : Option[Double] = None,
    val right : Option[Double] = None,
    val top : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Projection configuration, which determines default properties for all
 * [projections](projection.html). For a full list of projection configuration options,
 * please see the [corresponding section of the projection
 * documentation](projection.html#config).
 *
 * Any property of Projection can be in config
 */
case class ProjectionConfig (
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    val center : Option[Seq[Double]] = None,

    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    val clipAngle : Option[Double] = None,

    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    val clipExtent : Option[Seq[Seq[Double]]] = None,

    val coefficient : Option[Double] = None,
    val distance : Option[Double] = None,
    val fraction : Option[Double] = None,
    val lobes : Option[Double] = None,
    val parallel : Option[Double] = None,

    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    val precision : Option[Map[String, TitleFontWeight]] = None,

    val radius : Option[Double] = None,
    val ratio : Option[Double] = None,

    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    val rotate : Option[Seq[Double]] = None,

    val spacing : Option[Double] = None,
    val tilt : Option[Double] = None,

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    val `type` : Option[VGProjectionType] = None
) derives OptionPickler.ReadWriter

/**
 * The cartographic projection to use. This value is case-insensitive, for example
 * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
 * projection types [in the
 * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
 *
 * __Default value:__ `mercator`
 */

enum VGProjectionType : 
    case Albers
    case AlbersUsa
    case AzimuthalEqualArea
    case AzimuthalEquidistant
    case ConicConformal
    case ConicEqualArea
    case ConicEquidistant
    case Equirectangular
    case Gnomonic
    case Mercator
    case Orthographic
    case Stereographic
    case TransverseMercator

given OptionPickler.ReadWriter[VGProjectionType] = OptionPickler.readwriter[String].bimap[VGProjectionType](
    {
        case VGProjectionType.Albers => "albers"
        case VGProjectionType.AlbersUsa => "albersUsa"
        case VGProjectionType.AzimuthalEqualArea => "azimuthalEqualArea"
        case VGProjectionType.AzimuthalEquidistant => "azimuthalEquidistant"
        case VGProjectionType.ConicConformal => "conicConformal"
        case VGProjectionType.ConicEqualArea => "conicEqualArea"
        case VGProjectionType.ConicEquidistant => "conicEquidistant"
        case VGProjectionType.Equirectangular => "equirectangular"
        case VGProjectionType.Gnomonic => "gnomonic"
        case VGProjectionType.Mercator => "mercator"
        case VGProjectionType.Orthographic => "orthographic"
        case VGProjectionType.Stereographic => "stereographic"
        case VGProjectionType.TransverseMercator => "transverseMercator"
    },
    {
        case "albers" => VGProjectionType.Albers
        case "albersUsa" => VGProjectionType.AlbersUsa
        case "azimuthalEqualArea" => VGProjectionType.AzimuthalEqualArea
        case "azimuthalEquidistant" => VGProjectionType.AzimuthalEquidistant
        case "conicConformal" => VGProjectionType.ConicConformal
        case "conicEqualArea" => VGProjectionType.ConicEqualArea
        case "conicEquidistant" => VGProjectionType.ConicEquidistant
        case "equirectangular" => VGProjectionType.Equirectangular
        case "gnomonic" => VGProjectionType.Gnomonic
        case "mercator" => VGProjectionType.Mercator
        case "orthographic" => VGProjectionType.Orthographic
        case "stereographic" => VGProjectionType.Stereographic
        case "transverseMercator" => VGProjectionType.TransverseMercator
        case other => throw new upickle.core.Abort("invalid VGProjectionType: " + other)
    }
)

type RangeConfigValue = Seq[TitleFontWeight] | VGScheme
given unionReaderRangeConfigValue: OptionPickler.Reader[RangeConfigValue] = JsonExt.badMerge[RangeConfigValue](
    summon[OptionPickler.Reader[Seq[TitleFontWeight]]],
    summon[OptionPickler.Reader[VGScheme]],
    )

given unionWriterRangeConfigValue: OptionPickler.Writer[RangeConfigValue] = OptionPickler.writer[ujson.Value].comap[RangeConfigValue]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[TitleFontWeight] => OptionPickler.writeJs[Seq[TitleFontWeight]](v)
        case v: VGScheme => OptionPickler.writeJs[VGScheme](v)
}

case class VGScheme (
    val count : Option[Double] = None,
    val extent : Option[Seq[Double]] = None,
    val scheme : Option[String] = None,
    val step : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Scale configuration determines default properties for all [scales](scale.html). For a
 * full list of scale configuration options, please see the [corresponding section of the
 * scale documentation](scale.html#config).
 */
case class ScaleConfig (
    /**
     * Default inner padding for `x` and `y` band-ordinal scales.
     *
     * __Default value:__ `0.1`
     */
    val bandPaddingInner : Option[Double] = None,

    /**
     * Default outer padding for `x` and `y` band-ordinal scales.
     * If not specified, by default, band scale's paddingOuter is paddingInner/2.
     */
    val bandPaddingOuter : Option[Double] = None,

    /**
     * If true, values that exceed the data domain are clamped to either the minimum or maximum
     * range value
     */
    val clamp : Option[Boolean] = None,

    /**
     * Default padding for continuous scales.
     *
     * __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
     * horizontal bar.; `0` otherwise.
     */
    val continuousPadding : Option[Double] = None,

    /**
     * The default max value for mapping quantitative fields to bar's size/bandSize.
     *
     * If undefined (default), we will use the scale's `rangeStep` - 1.
     */
    val maxBandSize : Option[Double] = None,

    /**
     * The default max value for mapping quantitative fields to text's size/fontSize.
     *
     * __Default value:__ `40`
     */
    val maxFontSize : Option[Double] = None,

    /**
     * Default max opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.8`
     */
    val maxOpacity : Option[Double] = None,

    /**
     * Default max value for point size scale.
     */
    val maxSize : Option[Double] = None,

    /**
     * Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
     *
     * __Default value:__ `4`
     */
    val maxStrokeWidth : Option[Double] = None,

    /**
     * The default min value for mapping quantitative fields to bar and tick's size/bandSize
     * scale with zero=false.
     *
     * __Default value:__ `2`
     */
    val minBandSize : Option[Double] = None,

    /**
     * The default min value for mapping quantitative fields to tick's size/fontSize scale with
     * zero=false
     *
     * __Default value:__ `8`
     */
    val minFontSize : Option[Double] = None,

    /**
     * Default minimum opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.3`
     */
    val minOpacity : Option[Double] = None,

    /**
     * Default minimum value for point size scale with zero=false.
     *
     * __Default value:__ `9`
     */
    val minSize : Option[Double] = None,

    /**
     * Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
     *
     * __Default value:__ `1`
     */
    val minStrokeWidth : Option[Double] = None,

    /**
     * Default outer padding for `x` and `y` point-ordinal scales.
     *
     * __Default value:__ `0.5`
     */
    val pointPadding : Option[Double] = None,

    /**
     * Default range step for band and point scales of (1) the `y` channel
     * and (2) the `x` channel when the mark is not `text`.
     *
     * __Default value:__ `21`
     */
    val rangeStep : Option[Double] = None,

    /**
     * If true, rounds numeric output values to integers.
     * This can be helpful for snapping to the pixel grid.
     * (Only available for `x`, `y`, and `size` scales.)
     */
    val round : Option[Boolean] = None,

    /**
     * Default range step for `x` band and point scales of text marks.
     *
     * __Default value:__ `90`
     */
    val textXRangeStep : Option[Double] = None,

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
    val useUnaggregatedDomain : Option[Boolean] = None
) derives OptionPickler.ReadWriter

/**
 * An object hash for defining default properties for each type of selections.
 */
case class SelectionConfig (
    /**
     * The default definition for an [`interval`](selection.html#type) selection. All properties
     * and transformations
     * for an interval selection definition (except `type`) may be specified here.
     *
     * For instance, setting `interval` to `{"translate": false}` disables the ability to move
     * interval selections by default.
     */
    val interval : Option[IntervalSelectionConfig] = None,

    /**
     * The default definition for a [`multi`](selection.html#type) selection. All properties and
     * transformations
     * for a multi selection definition (except `type`) may be specified here.
     *
     * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
     * multi selections when clicking with the alt-key pressed by default.
     */
    val multi : Option[MultiSelectionConfig] = None,

    /**
     * The default definition for a [`single`](selection.html#type) selection. All properties
     * and transformations
     * for a single selection definition (except `type`) may be specified here.
     *
     * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
     * double-click by default.
     */
    val single : Option[SingleSelectionConfig] = None
) derives OptionPickler.ReadWriter

/**
 * The default definition for an [`interval`](selection.html#type) selection. All properties
 * and transformations
 * for an interval selection definition (except `type`) may be specified here.
 *
 * For instance, setting `interval` to `{"translate": false}` disables the ability to move
 * interval selections by default.
 */
case class IntervalSelectionConfig (
    /**
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    val bind : Option[BindEnum] = None,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty : Option[Empty] = None,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings : Option[Seq[SingleDefChannel]] = None,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields : Option[Seq[String]] = None,

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    val mark : Option[BrushConfig] = None,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on : Option[ujson.Value] = None,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve : Option[SelectionResolution] = None,

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
    val translate : Option[Translate] = None,

    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    val zoom : Option[Translate] = None
) derives OptionPickler.ReadWriter

/**
 * Establishes a two-way binding between the interval selection and the scales
 * used within the same view. This allows a user to interactively pan and
 * zoom the view.
 */

enum BindEnum : 
    case Scales

given OptionPickler.ReadWriter[BindEnum] = OptionPickler.readwriter[String].bimap[BindEnum](
    {
        case BindEnum.Scales => "scales"
    },
    {
        case "scales" => BindEnum.Scales
        case other => throw new upickle.core.Abort("invalid BindEnum: " + other)
    }
)

/**
 * By default, all data values are considered to lie within an empty selection.
 * When set to `none`, empty selections contain no data values.
 */

enum Empty : 
    case All
    case None

given OptionPickler.ReadWriter[Empty] = OptionPickler.readwriter[String].bimap[Empty](
    {
        case Empty.All => "all"
        case Empty.None => "none"
    },
    {
        case "all" => Empty.All
        case "none" => Empty.None
        case other => throw new upickle.core.Abort("invalid Empty: " + other)
    }
)

enum SingleDefChannel : 
    case X
    case Y
    case X2
    case Y2
    case Row
    case Column
    case Size
    case Shape
    case Color
    case Opacity
    case Text
    case Tooltip
    case Href

given OptionPickler.ReadWriter[SingleDefChannel] = OptionPickler.readwriter[String].bimap[SingleDefChannel](
    {
        case SingleDefChannel.X => "x"
        case SingleDefChannel.Y => "y"
        case SingleDefChannel.X2 => "x2"
        case SingleDefChannel.Y2 => "y2"
        case SingleDefChannel.Row => "row"
        case SingleDefChannel.Column => "column"
        case SingleDefChannel.Size => "size"
        case SingleDefChannel.Shape => "shape"
        case SingleDefChannel.Color => "color"
        case SingleDefChannel.Opacity => "opacity"
        case SingleDefChannel.Text => "text"
        case SingleDefChannel.Tooltip => "tooltip"
        case SingleDefChannel.Href => "href"
    },
    {
        case "x" => SingleDefChannel.X
        case "y" => SingleDefChannel.Y
        case "x2" => SingleDefChannel.X2
        case "y2" => SingleDefChannel.Y2
        case "row" => SingleDefChannel.Row
        case "column" => SingleDefChannel.Column
        case "size" => SingleDefChannel.Size
        case "shape" => SingleDefChannel.Shape
        case "color" => SingleDefChannel.Color
        case "opacity" => SingleDefChannel.Opacity
        case "text" => SingleDefChannel.Text
        case "tooltip" => SingleDefChannel.Tooltip
        case "href" => SingleDefChannel.Href
        case other => throw new upickle.core.Abort("invalid SingleDefChannel: " + other)
    }
)

/**
 * An interval selection also adds a rectangle mark to depict the
 * extents of the interval. The `mark` property can be used to customize the
 * appearance of the mark.
 */
case class BrushConfig (
    /**
     * The fill color of the interval mark.
     *
     * __Default value:__ `#333333`
     */
    val fill : Option[String] = None,

    /**
     * The fill opacity of the interval mark (a value between 0 and 1).
     *
     * __Default value:__ `0.125`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The stroke color of the interval mark.
     *
     * __Default value:__ `#ffffff`
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke and space lengths,
     * for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) with which to begin drawing the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity of the interval mark (a value between 0 and 1).
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width of the interval mark.
     */
    val strokeWidth : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * With layered and multi-view displays, a strategy that determines how
 * selections' data queries are resolved when applied in a filter transform,
 * conditional encoding rule, or scale domain.
 */

enum SelectionResolution : 
    case Global
    case Union
    case Intersect

given OptionPickler.ReadWriter[SelectionResolution] = OptionPickler.readwriter[String].bimap[SelectionResolution](
    {
        case SelectionResolution.Global => "global"
        case SelectionResolution.Union => "union"
        case SelectionResolution.Intersect => "intersect"
    },
    {
        case "global" => SelectionResolution.Global
        case "union" => SelectionResolution.Union
        case "intersect" => SelectionResolution.Intersect
        case other => throw new upickle.core.Abort("invalid SelectionResolution: " + other)
    }
)

/**
 * When truthy, allows a user to interactively move an interval selection
 * back-and-forth. Can be `true`, `false` (to disable panning), or a
 * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
 * which must include a start and end event to trigger continuous panning.
 *
 * __Default value:__ `true`, which corresponds to
 * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
 * clicks and dragging within an interval selection to reposition it.
 *
 * When truthy, allows a user to interactively resize an interval selection.
 * Can be `true`, `false` (to disable zooming), or a [Vega event stream
 * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
 * only `wheel` events are supported.
 *
 *
 * __Default value:__ `true`, which corresponds to `wheel!`.
 *
 * Controls whether data values should be toggled or only ever inserted into
 * multi selections. Can be `true`, `false` (for insertion only), or a
 * [Vega expression](https://vega.github.io/vega/docs/expressions/).
 *
 * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
 * data values are toggled when a user interacts with the shift-key pressed).
 *
 * See the [toggle transform](toggle.html) documentation for more information.
 */
type Translate = Boolean | String
given unionReaderTranslate: OptionPickler.Reader[Translate] = JsonExt.badMerge[Translate](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    )

given unionWriterTranslate: OptionPickler.Writer[Translate] = OptionPickler.writer[ujson.Value].comap[Translate]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
}

/**
 * The default definition for a [`multi`](selection.html#type) selection. All properties and
 * transformations
 * for a multi selection definition (except `type`) may be specified here.
 *
 * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
 * multi selections when clicking with the alt-key pressed by default.
 */
case class MultiSelectionConfig (
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty : Option[Empty] = None,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings : Option[Seq[SingleDefChannel]] = None,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields : Option[Seq[String]] = None,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest : Option[Boolean] = None,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on : Option[ujson.Value] = None,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve : Option[SelectionResolution] = None,

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
    val toggle : Option[Translate] = None
) derives OptionPickler.ReadWriter

/**
 * The default definition for a [`single`](selection.html#type) selection. All properties
 * and transformations
 * for a single selection definition (except `type`) may be specified here.
 *
 * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
 * double-click by default.
 */
case class SingleSelectionConfig (
    /**
     * Establish a two-way binding between a single selection and input elements
     * (also known as dynamic query widgets). A binding takes the form of
     * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
     * or can be a mapping between projected field/encodings and binding definitions.
     *
     * See the [bind transform](bind.html) documentation for more information.
     */
    val bind : Option[Map[String, VGBinding]] = None,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty : Option[Empty] = None,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings : Option[Seq[SingleDefChannel]] = None,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields : Option[Seq[String]] = None,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest : Option[Boolean] = None,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on : Option[ujson.Value] = None,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve : Option[SelectionResolution] = None
) derives OptionPickler.ReadWriter

case class VGBinding (
    val element : Option[String] = None,
    val input : String,
    val options : Option[Seq[String]] = None,
    val max : Option[Double] = None,
    val min : Option[Double] = None,
    val step : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Default stack offset for stackable mark.
 */

enum StackOffset : 
    case Zero
    case Center
    case Normalize

given OptionPickler.ReadWriter[StackOffset] = OptionPickler.readwriter[String].bimap[StackOffset](
    {
        case StackOffset.Zero => "zero"
        case StackOffset.Center => "center"
        case StackOffset.Normalize => "normalize"
    },
    {
        case "zero" => StackOffset.Zero
        case "center" => StackOffset.Center
        case "normalize" => StackOffset.Normalize
        case other => throw new upickle.core.Abort("invalid StackOffset: " + other)
    }
)

case class VGMarkConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Text-Specific Config
 */
case class TextConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color : Option[String] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled : Option[Boolean] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * Whether month names and weekday names should be abbreviated.
     */
    val shortTimeLabels : Option[Boolean] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Tick-Specific Config
 */
case class TickConfig (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The width of the ticks.
     *
     * __Default value:__  2/3 of rangeStep.
     */
    val bandSize : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color : Option[String] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled : Option[Boolean] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None,

    /**
     * Thickness of the tick mark.
     *
     * __Default value:__  `1`
     */
    val thickness : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Title configuration, which determines default properties for all [titles](title.html).
 * For a full list of title configuration options, please see the [corresponding section of
 * the title documentation](title.html#config).
 */
case class VGTitleConfig (
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
    val anchor : Option[Anchor] = None,

    /**
     * Angle in degrees of title text.
     */
    val angle : Option[Double] = None,

    /**
     * Vertical text baseline for title text.
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Text color for title text.
     */
    val color : Option[String] = None,

    /**
     * Font name for title text.
     */
    val font : Option[String] = None,

    /**
     * Font size in pixels for title text.
     *
     * __Default value:__ `10`.
     */
    val fontSize : Option[Double] = None,

    /**
     * Font weight for title text.
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * The maximum allowed length in pixels of legend labels.
     */
    val limit : Option[Double] = None,

    /**
     * Offset in pixels of the title from the chart body and axes.
     */
    val offset : Option[Double] = None,

    /**
     * Default title orientation ("top", "bottom", "left", or "right")
     */
    val orient : Option[TitleOrient] = None
) derives OptionPickler.ReadWriter

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

enum Anchor : 
    case Start
    case Middle
    case End

given OptionPickler.ReadWriter[Anchor] = OptionPickler.readwriter[String].bimap[Anchor](
    {
        case Anchor.Start => "start"
        case Anchor.Middle => "middle"
        case Anchor.End => "end"
    },
    {
        case "start" => Anchor.Start
        case "middle" => Anchor.Middle
        case "end" => Anchor.End
        case other => throw new upickle.core.Abort("invalid Anchor: " + other)
    }
)

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

enum TitleOrient : 
    case Top
    case Bottom
    case Left
    case Right

given OptionPickler.ReadWriter[TitleOrient] = OptionPickler.readwriter[String].bimap[TitleOrient](
    {
        case TitleOrient.Top => "top"
        case TitleOrient.Bottom => "bottom"
        case TitleOrient.Left => "left"
        case TitleOrient.Right => "right"
    },
    {
        case "top" => TitleOrient.Top
        case "bottom" => TitleOrient.Bottom
        case "left" => TitleOrient.Left
        case "right" => TitleOrient.Right
        case other => throw new upickle.core.Abort("invalid TitleOrient: " + other)
    }
)

/**
 * Default properties for [single view plots](spec.html#single).
 */
case class ViewConfig (
    /**
     * Whether the view should be clipped.
     */
    val clip : Option[Boolean] = None,

    /**
     * The fill color.
     *
     * __Default value:__ (none)
     */
    val fill : Option[String] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The default height of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
     *
     * __Default value:__ `200`
     */
    val height : Option[Double] = None,

    /**
     * The stroke color.
     *
     * __Default value:__ (none)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     *
     * __Default value:__ (none)
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     *
     * __Default value:__ (none)
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     *
     * __Default value:__ (none)
     */
    val strokeWidth : Option[Double] = None,

    /**
     * The default width of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
     * = `null`.
     *
     * __Default value:__ `200`
     */
    val width : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * An object describing the data source
 *
 * Secondary data source to lookup in.
 */
case class Data (
    /**
     * An object that specifies the format for parsing the data file.
     *
     * An object that specifies the format for parsing the data values.
     *
     * An object that specifies the format for parsing the data.
     */
    val format : Option[DataFormat] = None,

    /**
     * An URL from which to load the data set. Use the `format.type` property
     * to ensure the loaded data is correctly parsed.
     */
    val url : Option[String] = None,

    /**
     * The full data set, included inline. This can be an array of objects or primitive values
     * or a string.
     * Arrays of primitive values are ingested as objects with a `data` property. Strings are
     * parsed according to the specified format type.
     */
    val values : Option[Values] = None,

    /**
     * Provide a placeholder name and bind data at runtime.
     */
    val name : Option[String] = None
) derives OptionPickler.ReadWriter

/**
 * An object that specifies the format for parsing the data file.
 *
 * An object that specifies the format for parsing the data values.
 *
 * An object that specifies the format for parsing the data.
 */
case class DataFormat (
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
    val parse : Option[ParseUnion] = None,

    /**
     * Type of input data: `"json"`, `"csv"`, `"tsv"`.
     * The default format type is determined by the extension of the file URL.
     * If no extension is detected, `"json"` will be used by default.
     */
    val `type` : Option[DataFormatType] = None,

    /**
     * The JSON property containing the desired data.
     * This parameter can be used when the loaded JSON file may have surrounding structure or
     * meta-data.
     * For example `"property": "values.features"` is equivalent to retrieving
     * `json.values.features`
     * from the loaded JSON object.
     */
    val property : Option[String] = None,

    /**
     * The name of the TopoJSON object set to convert to a GeoJSON feature collection.
     * For example, in a map of the world, there may be an object set named `"countries"`.
     * Using the feature property, we can extract this set and generate a GeoJSON feature object
     * for each country.
     */
    val feature : Option[String] = None,

    /**
     * The name of the TopoJSON object set to convert to mesh.
     * Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
     * Unlike the `feature` option, the corresponding geo data is returned as a single, unified
     * mesh instance, not as individual GeoJSON features.
     * Extracting a mesh is useful for more efficiently drawing borders or other geographic
     * elements that you do not need to associate with specific regions such as individual
     * countries, states or counties.
     */
    val mesh : Option[String] = None
) derives OptionPickler.ReadWriter

/**
 * Type of input data: `"json"`, `"csv"`, `"tsv"`.
 * The default format type is determined by the extension of the file URL.
 * If no extension is detected, `"json"` will be used by default.
 */

enum DataFormatType : 
    case CSV
    case Tsv
    case JSON
    case Topojson

given OptionPickler.ReadWriter[DataFormatType] = OptionPickler.readwriter[String].bimap[DataFormatType](
    {
        case DataFormatType.CSV => "csv"
        case DataFormatType.Tsv => "tsv"
        case DataFormatType.JSON => "json"
        case DataFormatType.Topojson => "topojson"
    },
    {
        case "csv" => DataFormatType.CSV
        case "tsv" => DataFormatType.Tsv
        case "json" => DataFormatType.JSON
        case "topojson" => DataFormatType.Topojson
        case other => throw new upickle.core.Abort("invalid DataFormatType: " + other)
    }
)

type ParseUnion = Map[String, Option[ujson.Value]] | ParseEnum
given unionReaderParseUnion: OptionPickler.Reader[ParseUnion] = JsonExt.badMerge[ParseUnion](
    summon[OptionPickler.Reader[ParseEnum]],
    summon[OptionPickler.Reader[Map[String, Option[ujson.Value]]]],
    )

given unionWriterParseUnion: OptionPickler.Writer[ParseUnion] = OptionPickler.writer[ujson.Value].comap[ParseUnion]{ _v =>
    (_v: @unchecked) match 
        case v: ParseEnum => OptionPickler.writeJs[ParseEnum](v)
        case v: Map[String, Option[ujson.Value]] => OptionPickler.writeJs[Map[String, Option[ujson.Value]]](v)
}

enum ParseEnum : 
    case Auto

given OptionPickler.ReadWriter[ParseEnum] = OptionPickler.readwriter[String].bimap[ParseEnum](
    {
        case ParseEnum.Auto => "auto"
    },
    {
        case "auto" => ParseEnum.Auto
        case other => throw new upickle.core.Abort("invalid ParseEnum: " + other)
    }
)

/**
 * The full data set, included inline. This can be an array of objects or primitive values
 * or a string.
 * Arrays of primitive values are ingested as objects with a `data` property. Strings are
 * parsed according to the specified format type.
 */
type Values = Map[String, Option[ujson.Value]] | String | Seq[ValuesValue]
given unionReaderValues: OptionPickler.Reader[Values] = JsonExt.badMerge[Values](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[ValuesValue]]],
    summon[OptionPickler.Reader[Map[String, Option[ujson.Value]]]],
    )

given unionWriterValues: OptionPickler.Writer[Values] = OptionPickler.writer[ujson.Value].comap[Values]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[ValuesValue] => OptionPickler.writeJs[Seq[ValuesValue]](v)
        case v: Map[String, Option[ujson.Value]] => OptionPickler.writeJs[Map[String, Option[ujson.Value]]](v)
}

type ValuesValue = Map[String, Option[ujson.Value]] | Boolean | Double | String
given unionReaderValuesValue: OptionPickler.Reader[ValuesValue] = JsonExt.badMerge[ValuesValue](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Option[ujson.Value]]]],
    )

given unionWriterValuesValue: OptionPickler.Writer[ValuesValue] = OptionPickler.writer[ujson.Value].comap[ValuesValue]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Option[ujson.Value]] => OptionPickler.writeJs[Map[String, Option[ujson.Value]]](v)
}

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
case class EncodingWithFacet (
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
    val color : Option[MarkPropDefWithCondition] = None,

    /**
     * Horizontal facets for trellis plots.
     */
    val column : Option[FacetFieldDef] = None,

    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    val detail : Option[Detail] = None,

    /**
     * A URL to load upon mouse click.
     */
    val href : Option[DefWithCondition] = None,

    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    val opacity : Option[MarkPropDefWithCondition] = None,

    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    val order : Option[Order] = None,

    /**
     * Vertical facets for trellis plots.
     */
    val row : Option[FacetFieldDef] = None,

    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    val shape : Option[MarkPropDefWithCondition] = None,

    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    val size : Option[MarkPropDefWithCondition] = None,

    /**
     * Text of the `text` mark.
     */
    val text : Option[TextDefWithCondition] = None,

    /**
     * The tooltip text to show upon mouse hover.
     */
    val tooltip : Option[TextDefWithCondition] = None,

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    val x : Option[XClass] = None,

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val x2 : Option[X2Class] = None,

    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    val y : Option[XClass] = None,

    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val y2 : Option[X2Class] = None
) derives OptionPickler.ReadWriter

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
case class MarkPropDefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition : Option[ColorCondition] = None,

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
    val field : Option[Field] = None,

    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    val legend : Option[Legend] = None,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale : Option[Scale] = None,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort : Option[SortUnion] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None,

    /**
     * A constant value in visual domain.
     */
    val value : Option[ConditionalValueDefValue] = None
) derives OptionPickler.ReadWriter

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

enum AggregateOp : 
    case Argmax
    case Argmin
    case Average
    case Count
    case Distinct
    case Max
    case Mean
    case Median
    case Min
    case Missing
    case Q1
    case Q3
    case Ci0
    case Ci1
    case Stdev
    case Stdevp
    case Sum
    case Valid
    case Values
    case Variance
    case Variancep

given OptionPickler.ReadWriter[AggregateOp] = OptionPickler.readwriter[String].bimap[AggregateOp](
    {
        case AggregateOp.Argmax => "argmax"
        case AggregateOp.Argmin => "argmin"
        case AggregateOp.Average => "average"
        case AggregateOp.Count => "count"
        case AggregateOp.Distinct => "distinct"
        case AggregateOp.Max => "max"
        case AggregateOp.Mean => "mean"
        case AggregateOp.Median => "median"
        case AggregateOp.Min => "min"
        case AggregateOp.Missing => "missing"
        case AggregateOp.Q1 => "q1"
        case AggregateOp.Q3 => "q3"
        case AggregateOp.Ci0 => "ci0"
        case AggregateOp.Ci1 => "ci1"
        case AggregateOp.Stdev => "stdev"
        case AggregateOp.Stdevp => "stdevp"
        case AggregateOp.Sum => "sum"
        case AggregateOp.Valid => "valid"
        case AggregateOp.Values => "values"
        case AggregateOp.Variance => "variance"
        case AggregateOp.Variancep => "variancep"
    },
    {
        case "argmax" => AggregateOp.Argmax
        case "argmin" => AggregateOp.Argmin
        case "average" => AggregateOp.Average
        case "count" => AggregateOp.Count
        case "distinct" => AggregateOp.Distinct
        case "max" => AggregateOp.Max
        case "mean" => AggregateOp.Mean
        case "median" => AggregateOp.Median
        case "min" => AggregateOp.Min
        case "missing" => AggregateOp.Missing
        case "q1" => AggregateOp.Q1
        case "q3" => AggregateOp.Q3
        case "ci0" => AggregateOp.Ci0
        case "ci1" => AggregateOp.Ci1
        case "stdev" => AggregateOp.Stdev
        case "stdevp" => AggregateOp.Stdevp
        case "sum" => AggregateOp.Sum
        case "valid" => AggregateOp.Valid
        case "values" => AggregateOp.Values
        case "variance" => AggregateOp.Variance
        case "variancep" => AggregateOp.Variancep
        case other => throw new upickle.core.Abort("invalid AggregateOp: " + other)
    }
)

type Bin = BinParams | Boolean
given unionReaderBin: OptionPickler.Reader[Bin] = JsonExt.badMerge[Bin](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[BinParams]],
    )

given unionWriterBin: OptionPickler.Writer[Bin] = OptionPickler.writer[ujson.Value].comap[Bin]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: BinParams => OptionPickler.writeJs[BinParams](v)
}

/**
 * Binning properties or boolean flag for determining whether to bin data or not.
 */
case class BinParams (
    /**
     * The number base to use for automatic bin determination (default is base 10).
     *
     * __Default value:__ `10`
     */
    val base : Option[Double] = None,

    /**
     * Scale factors indicating allowable subdivisions. The default value is [5, 2], which
     * indicates that for base 10 numbers (the default base), the method may consider dividing
     * bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
     * check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
     * given constraints.
     *
     * __Default value:__ `[5, 2]`
     */
    val divide : Option[Seq[Double]] = None,

    /**
     * A two-element (`[min, max]`) array indicating the range of desired bin values.
     */
    val extent : Option[Seq[Double]] = None,

    /**
     * Maximum number of bins.
     *
     * __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
     */
    val maxbins : Option[Double] = None,

    /**
     * A minimum allowable step size (particularly useful for integer values).
     */
    val minstep : Option[Double] = None,

    /**
     * If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
     * such as multiples of ten.
     */
    val nice : Option[Boolean] = None,

    /**
     * An exact step size to use between bins.
     *
     * __Note:__ If provided, options such as maxbins will be ignored.
     */
    val step : Option[Double] = None,

    /**
     * An array of allowable step sizes to choose from.
     */
    val steps : Option[Seq[Double]] = None
) derives OptionPickler.ReadWriter

type ColorCondition = ConditionalPredicateMarkPropFieldDefClass | Seq[ConditionalValueDef]
given unionReaderColorCondition: OptionPickler.Reader[ColorCondition] = JsonExt.badMerge[ColorCondition](
    summon[OptionPickler.Reader[Seq[ConditionalValueDef]]],
    summon[OptionPickler.Reader[ConditionalPredicateMarkPropFieldDefClass]],
    )

given unionWriterColorCondition: OptionPickler.Writer[ColorCondition] = OptionPickler.writer[ujson.Value].comap[ColorCondition]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[ConditionalValueDef] => OptionPickler.writeJs[Seq[ConditionalValueDef]](v)
        case v: ConditionalPredicateMarkPropFieldDefClass => OptionPickler.writeJs[ConditionalPredicateMarkPropFieldDefClass](v)
}

case class ConditionalValueDef (
    val test : Option[LogicalOperandPredicate] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : ConditionalValueDefValue,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection : Option[SelectionOperand] = None
) derives OptionPickler.ReadWriter

case class Selection (
    val not : Option[SelectionOperand] = None,
    val and : Option[Seq[SelectionOperand]] = None,
    val or : Option[Seq[SelectionOperand]] = None
) derives OptionPickler.ReadWriter

/**
 * Filter using a selection name.
 *
 * A [selection name](selection.html), or a series of [composed
 * selections](selection.html#compose).
 */
type SelectionOperand = Selection | String
given unionReaderSelectionOperand: OptionPickler.Reader[SelectionOperand] = JsonExt.badMerge[SelectionOperand](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Selection]],
    )

given unionWriterSelectionOperand: OptionPickler.Writer[SelectionOperand] = OptionPickler.writer[ujson.Value].comap[SelectionOperand]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Selection => OptionPickler.writeJs[Selection](v)
}

case class Predicate (
    val not : Option[LogicalOperandPredicate] = None,
    val and : Option[Seq[LogicalOperandPredicate]] = None,
    val or : Option[Seq[LogicalOperandPredicate]] = None,

    /**
     * The value that the field should be equal to.
     */
    val equal : Option[Equal] = None,

    /**
     * Field to be filtered.
     *
     * Field to be filtered
     */
    val field : Option[String] = None,

    /**
     * Time unit for the field to be filtered.
     *
     * time unit for the field to be filtered.
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * An array of inclusive minimum and maximum values
     * for a field value of a data item to be included in the filtered data.
     */
    val range : Option[Seq[RangeElement]] = None,

    /**
     * A set of values that the `field`'s value should be a member of,
     * for a data item included in the filtered data.
     */
    val oneOf : Option[Seq[Equal]] = None,

    /**
     * Filter using a selection name.
     */
    val selection : Option[SelectionOperand] = None
) derives OptionPickler.ReadWriter

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
type LogicalOperandPredicate = Predicate | String
given unionReaderLogicalOperandPredicate: OptionPickler.Reader[LogicalOperandPredicate] = JsonExt.badMerge[LogicalOperandPredicate](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Predicate]],
    )

given unionWriterLogicalOperandPredicate: OptionPickler.Writer[LogicalOperandPredicate] = OptionPickler.writer[ujson.Value].comap[LogicalOperandPredicate]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Predicate => OptionPickler.writeJs[Predicate](v)
}

/**
 * The value that the field should be equal to.
 */
type Equal = Boolean | DateTime | Double | String
given unionReaderEqual: OptionPickler.Reader[Equal] = JsonExt.badMerge[Equal](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[DateTime]],
    )

given unionWriterEqual: OptionPickler.Writer[Equal] = OptionPickler.writer[ujson.Value].comap[Equal]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: DateTime => OptionPickler.writeJs[DateTime](v)
}

/**
 * Object for defining datetime in Vega-Lite Filter.
 * If both month and quarter are provided, month has higher precedence.
 * `day` cannot be combined with other date.
 * We accept string for month and day names.
 */
case class DateTime (
    /**
     * Integer value representing the date from 1-31.
     */
    val date : Option[Double] = None,

    /**
     * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
     * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
     * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
     * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
     * `month`, or `date`.
     */
    val day : Option[Day] = None,

    /**
     * Integer value representing the hour of a day from 0-23.
     */
    val hours : Option[Double] = None,

    /**
     * Integer value representing the millisecond segment of time.
     */
    val milliseconds : Option[Double] = None,

    /**
     * Integer value representing the minute segment of time from 0-59.
     */
    val minutes : Option[Double] = None,

    /**
     * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
     * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
     * short month name (e.g., `"Jan"`).
     */
    val month : Option[Month] = None,

    /**
     * Integer value representing the quarter of the year (from 1-4).
     */
    val quarter : Option[Double] = None,

    /**
     * Integer value representing the second segment (0-59) of a time value
     */
    val seconds : Option[Double] = None,

    /**
     * A boolean flag indicating if date time is in utc time. If false, the date time is in
     * local time
     */
    val utc : Option[Boolean] = None,

    /**
     * Integer value representing the year.
     */
    val year : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
 * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
 * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
 * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
 * `month`, or `date`.
 */
type Day = Double | String
/**
 * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
 * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
 * short month name (e.g., `"Jan"`).
 */
type Month = Double | String
type RangeElement = DateTime | Double | NullValue
given unionReaderRangeElement: OptionPickler.Reader[RangeElement] = JsonExt.badMerge[RangeElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[DateTime]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterRangeElement: OptionPickler.Writer[RangeElement] = OptionPickler.writer[ujson.Value].comap[RangeElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: DateTime => OptionPickler.writeJs[DateTime](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

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

enum TimeUnit : 
    case Year
    case Quarter
    case Month
    case Day
    case Date
    case Hours
    case Minutes
    case Seconds
    case Milliseconds
    case Utcyear
    case Utcquarter
    case Utcmonth
    case Utcday
    case Utcdate
    case Utchours
    case Utcminutes
    case Utcseconds
    case Utcmilliseconds
    case Yearquarter
    case Yearquartermonth
    case Yearmonth
    case Yearmonthdate
    case Yearmonthdatehours
    case Yearmonthdatehoursminutes
    case Yearmonthdatehoursminutesseconds
    case Quartermonth
    case Monthdate
    case Hoursminutes
    case Hoursminutesseconds
    case Minutesseconds
    case Secondsmilliseconds
    case Utcyearquarter
    case Utcyearquartermonth
    case Utcyearmonth
    case Utcyearmonthdate
    case Utcyearmonthdatehours
    case Utcyearmonthdatehoursminutes
    case Utcyearmonthdatehoursminutesseconds
    case Utcquartermonth
    case Utcmonthdate
    case Utchoursminutes
    case Utchoursminutesseconds
    case Utcminutesseconds
    case Utcsecondsmilliseconds

given OptionPickler.ReadWriter[TimeUnit] = OptionPickler.readwriter[String].bimap[TimeUnit](
    {
        case TimeUnit.Year => "year"
        case TimeUnit.Quarter => "quarter"
        case TimeUnit.Month => "month"
        case TimeUnit.Day => "day"
        case TimeUnit.Date => "date"
        case TimeUnit.Hours => "hours"
        case TimeUnit.Minutes => "minutes"
        case TimeUnit.Seconds => "seconds"
        case TimeUnit.Milliseconds => "milliseconds"
        case TimeUnit.Utcyear => "utcyear"
        case TimeUnit.Utcquarter => "utcquarter"
        case TimeUnit.Utcmonth => "utcmonth"
        case TimeUnit.Utcday => "utcday"
        case TimeUnit.Utcdate => "utcdate"
        case TimeUnit.Utchours => "utchours"
        case TimeUnit.Utcminutes => "utcminutes"
        case TimeUnit.Utcseconds => "utcseconds"
        case TimeUnit.Utcmilliseconds => "utcmilliseconds"
        case TimeUnit.Yearquarter => "yearquarter"
        case TimeUnit.Yearquartermonth => "yearquartermonth"
        case TimeUnit.Yearmonth => "yearmonth"
        case TimeUnit.Yearmonthdate => "yearmonthdate"
        case TimeUnit.Yearmonthdatehours => "yearmonthdatehours"
        case TimeUnit.Yearmonthdatehoursminutes => "yearmonthdatehoursminutes"
        case TimeUnit.Yearmonthdatehoursminutesseconds => "yearmonthdatehoursminutesseconds"
        case TimeUnit.Quartermonth => "quartermonth"
        case TimeUnit.Monthdate => "monthdate"
        case TimeUnit.Hoursminutes => "hoursminutes"
        case TimeUnit.Hoursminutesseconds => "hoursminutesseconds"
        case TimeUnit.Minutesseconds => "minutesseconds"
        case TimeUnit.Secondsmilliseconds => "secondsmilliseconds"
        case TimeUnit.Utcyearquarter => "utcyearquarter"
        case TimeUnit.Utcyearquartermonth => "utcyearquartermonth"
        case TimeUnit.Utcyearmonth => "utcyearmonth"
        case TimeUnit.Utcyearmonthdate => "utcyearmonthdate"
        case TimeUnit.Utcyearmonthdatehours => "utcyearmonthdatehours"
        case TimeUnit.Utcyearmonthdatehoursminutes => "utcyearmonthdatehoursminutes"
        case TimeUnit.Utcyearmonthdatehoursminutesseconds => "utcyearmonthdatehoursminutesseconds"
        case TimeUnit.Utcquartermonth => "utcquartermonth"
        case TimeUnit.Utcmonthdate => "utcmonthdate"
        case TimeUnit.Utchoursminutes => "utchoursminutes"
        case TimeUnit.Utchoursminutesseconds => "utchoursminutesseconds"
        case TimeUnit.Utcminutesseconds => "utcminutesseconds"
        case TimeUnit.Utcsecondsmilliseconds => "utcsecondsmilliseconds"
    },
    {
        case "year" => TimeUnit.Year
        case "quarter" => TimeUnit.Quarter
        case "month" => TimeUnit.Month
        case "day" => TimeUnit.Day
        case "date" => TimeUnit.Date
        case "hours" => TimeUnit.Hours
        case "minutes" => TimeUnit.Minutes
        case "seconds" => TimeUnit.Seconds
        case "milliseconds" => TimeUnit.Milliseconds
        case "utcyear" => TimeUnit.Utcyear
        case "utcquarter" => TimeUnit.Utcquarter
        case "utcmonth" => TimeUnit.Utcmonth
        case "utcday" => TimeUnit.Utcday
        case "utcdate" => TimeUnit.Utcdate
        case "utchours" => TimeUnit.Utchours
        case "utcminutes" => TimeUnit.Utcminutes
        case "utcseconds" => TimeUnit.Utcseconds
        case "utcmilliseconds" => TimeUnit.Utcmilliseconds
        case "yearquarter" => TimeUnit.Yearquarter
        case "yearquartermonth" => TimeUnit.Yearquartermonth
        case "yearmonth" => TimeUnit.Yearmonth
        case "yearmonthdate" => TimeUnit.Yearmonthdate
        case "yearmonthdatehours" => TimeUnit.Yearmonthdatehours
        case "yearmonthdatehoursminutes" => TimeUnit.Yearmonthdatehoursminutes
        case "yearmonthdatehoursminutesseconds" => TimeUnit.Yearmonthdatehoursminutesseconds
        case "quartermonth" => TimeUnit.Quartermonth
        case "monthdate" => TimeUnit.Monthdate
        case "hoursminutes" => TimeUnit.Hoursminutes
        case "hoursminutesseconds" => TimeUnit.Hoursminutesseconds
        case "minutesseconds" => TimeUnit.Minutesseconds
        case "secondsmilliseconds" => TimeUnit.Secondsmilliseconds
        case "utcyearquarter" => TimeUnit.Utcyearquarter
        case "utcyearquartermonth" => TimeUnit.Utcyearquartermonth
        case "utcyearmonth" => TimeUnit.Utcyearmonth
        case "utcyearmonthdate" => TimeUnit.Utcyearmonthdate
        case "utcyearmonthdatehours" => TimeUnit.Utcyearmonthdatehours
        case "utcyearmonthdatehoursminutes" => TimeUnit.Utcyearmonthdatehoursminutes
        case "utcyearmonthdatehoursminutesseconds" => TimeUnit.Utcyearmonthdatehoursminutesseconds
        case "utcquartermonth" => TimeUnit.Utcquartermonth
        case "utcmonthdate" => TimeUnit.Utcmonthdate
        case "utchoursminutes" => TimeUnit.Utchoursminutes
        case "utchoursminutesseconds" => TimeUnit.Utchoursminutesseconds
        case "utcminutesseconds" => TimeUnit.Utcminutesseconds
        case "utcsecondsmilliseconds" => TimeUnit.Utcsecondsmilliseconds
        case other => throw new upickle.core.Abort("invalid TimeUnit: " + other)
    }
)

/**
 * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
 * `0` to `1` for opacity).
 *
 * A constant value in visual domain.
 */
type ConditionalValueDefValue = Boolean | Double | String
given unionReaderConditionalValueDefValue: OptionPickler.Reader[ConditionalValueDefValue] = JsonExt.badMerge[ConditionalValueDefValue](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    )

given unionWriterConditionalValueDefValue: OptionPickler.Writer[ConditionalValueDefValue] = OptionPickler.writer[ujson.Value].comap[ConditionalValueDefValue]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

case class ConditionalPredicateMarkPropFieldDefClass (
    val test : Option[LogicalOperandPredicate] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : Option[ConditionalValueDefValue] = None,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection : Option[SelectionOperand] = None,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    val legend : Option[Legend] = None,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale : Option[Scale] = None,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort : Option[SortUnion] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None
) derives OptionPickler.ReadWriter

/**
 * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
 * `"nominal"`).
 * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
 * [geographic projection](projection.html) is applied.
 *
 * Constants and utilities for data type
 * Data type based on level of measurement
 */

enum Type : 
    case Quantitative
    case Ordinal
    case Temporal
    case Nominal
    case Latitude
    case Longitude
    case Geojson

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.Quantitative => "quantitative"
        case Type.Ordinal => "ordinal"
        case Type.Temporal => "temporal"
        case Type.Nominal => "nominal"
        case Type.Latitude => "latitude"
        case Type.Longitude => "longitude"
        case Type.Geojson => "geojson"
    },
    {
        case "quantitative" => Type.Quantitative
        case "ordinal" => Type.Ordinal
        case "temporal" => Type.Temporal
        case "nominal" => Type.Nominal
        case "latitude" => Type.Latitude
        case "longitude" => Type.Longitude
        case "geojson" => Type.Geojson
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)

type Field = RepeatRef | String
given unionReaderField: OptionPickler.Reader[Field] = JsonExt.badMerge[Field](
    JsonExt.strictString,
    summon[OptionPickler.Reader[RepeatRef]],
    )

given unionWriterField: OptionPickler.Writer[Field] = OptionPickler.writer[ujson.Value].comap[Field]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: RepeatRef => OptionPickler.writeJs[RepeatRef](v)
}

/**
 * Reference to a repeated value.
 */
case class RepeatRef (
    val repeat : RepeatEnum
) derives OptionPickler.ReadWriter

enum RepeatEnum : 
    case Row
    case Column

given OptionPickler.ReadWriter[RepeatEnum] = OptionPickler.readwriter[String].bimap[RepeatEnum](
    {
        case RepeatEnum.Row => "row"
        case RepeatEnum.Column => "column"
    },
    {
        case "row" => RepeatEnum.Row
        case "column" => RepeatEnum.Column
        case other => throw new upickle.core.Abort("invalid RepeatEnum: " + other)
    }
)

/**
 * Properties of a legend or boolean flag for determining whether to show it.
 */
case class Legend (
    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    val entryPadding : Option[Double] = None,

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
    val format : Option[String] = None,

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    val offset : Option[Double] = None,

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    val orient : Option[LegendOrient] = None,

    /**
     * The padding, in pixels, between the legend and axis.
     */
    val padding : Option[Double] = None,

    /**
     * The desired number of tick values for quantitative legends.
     */
    val tickCount : Option[Double] = None,

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
    val title : Option[String] = None,

    /**
     * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
     * continuous color gradient.
     *
     * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
     * `"symbol"` otherwise.
     */
    val `type` : Option[LegendType] = None,

    /**
     * Explicitly set the visible legend values.
     */
    val values : Option[Seq[LegendValue]] = None,

    /**
     * A non-positive integer indicating z-index of the legend.
     * If zindex is 0, legend should be drawn behind all chart elements.
     * To put them in front, use zindex = 1.
     */
    val zindex : Option[Double] = None
) derives OptionPickler.ReadWriter

/**
 * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
 * continuous color gradient.
 *
 * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
 * `"symbol"` otherwise.
 */

enum LegendType : 
    case Symbol
    case Gradient

given OptionPickler.ReadWriter[LegendType] = OptionPickler.readwriter[String].bimap[LegendType](
    {
        case LegendType.Symbol => "symbol"
        case LegendType.Gradient => "gradient"
    },
    {
        case "symbol" => LegendType.Symbol
        case "gradient" => LegendType.Gradient
        case other => throw new upickle.core.Abort("invalid LegendType: " + other)
    }
)

type LegendValue = DateTime | Double | String
given unionReaderLegendValue: OptionPickler.Reader[LegendValue] = JsonExt.badMerge[LegendValue](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[DateTime]],
    )

given unionWriterLegendValue: OptionPickler.Writer[LegendValue] = OptionPickler.writer[ujson.Value].comap[LegendValue]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: DateTime => OptionPickler.writeJs[DateTime](v)
}

/**
 * An object defining properties of the channel's scale, which is the function that
 * transforms values in the data domain (numbers, dates, strings, etc) to visual values
 * (pixels, colors, sizes) of the encoding channels.
 *
 * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
 */
case class Scale (
    /**
     * The logarithm base of the `log` scale (default `10`).
     */
    val base : Option[Double] = None,

    /**
     * If `true`, values that exceed the data domain are clamped to either the minimum or
     * maximum range value
     *
     * __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
     * (`true` by default).
     */
    val clamp : Option[Boolean] = None,

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
    val domain : Option[DomainUnion] = None,

    /**
     * The exponent of the `pow` scale.
     */
    val exponent : Option[Double] = None,

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
    val interpolate : Option[InterpolateUnion] = None,

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
    val nice : Option[NiceUnion] = None,

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
    val padding : Option[Double] = None,

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
    val paddingInner : Option[Double] = None,

    /**
     * The outer padding (spacing) at the ends of the range of band and point scales,
     * as a fraction of the step size. This value must lie in the range [0,1].
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingOuter` for band scales and `pointPadding` for point scales.
     */
    val paddingOuter : Option[Double] = None,

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
    val range : Option[ScaleRange] = None,

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
    val rangeStep : Option[Double] = None,

    /**
     * If `true`, rounds numeric output values to integers. This can be helpful for snapping to
     * the pixel grid.
     *
     * __Default value:__ `false`.
     */
    val round : Option[Boolean] = None,

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
    val scheme : Option[Scheme] = None,

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
    val `type` : Option[ScaleType] = None,

    /**
     * If `true`, ensures that a zero baseline value is included in the scale domain.
     *
     * __Default value:__ `true` for x and y channels if the quantitative field is not binned
     * and no custom `domain` is provided; `false` otherwise.
     *
     * __Note:__ Log, time, and utc scales do not support `zero`.
     */
    val zero : Option[Boolean] = None
) derives OptionPickler.ReadWriter

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
type DomainUnion = DomainClass | Domain | Seq[Equal]
given unionReaderDomainUnion: OptionPickler.Reader[DomainUnion] = JsonExt.badMerge[DomainUnion](
    summon[OptionPickler.Reader[Domain]],
    summon[OptionPickler.Reader[Seq[Equal]]],
    summon[OptionPickler.Reader[DomainClass]],
    )

given unionWriterDomainUnion: OptionPickler.Writer[DomainUnion] = OptionPickler.writer[ujson.Value].comap[DomainUnion]{ _v =>
    (_v: @unchecked) match 
        case v: Domain => OptionPickler.writeJs[Domain](v)
        case v: Seq[Equal] => OptionPickler.writeJs[Seq[Equal]](v)
        case v: DomainClass => OptionPickler.writeJs[DomainClass](v)
}

case class DomainClass (
    /**
     * The field name to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    val field : Option[String] = None,

    /**
     * The name of a selection.
     */
    val selection : String,

    /**
     * The encoding channel to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    val encoding : Option[String] = None
) derives OptionPickler.ReadWriter

enum Domain : 
    case Unaggregated

given OptionPickler.ReadWriter[Domain] = OptionPickler.readwriter[String].bimap[Domain](
    {
        case Domain.Unaggregated => "unaggregated"
    },
    {
        case "unaggregated" => Domain.Unaggregated
        case other => throw new upickle.core.Abort("invalid Domain: " + other)
    }
)

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
type InterpolateUnion = Interpolate | InterpolateParams
given unionReaderInterpolateUnion: OptionPickler.Reader[InterpolateUnion] = JsonExt.badMerge[InterpolateUnion](
    summon[OptionPickler.Reader[Interpolate]],
    summon[OptionPickler.Reader[InterpolateParams]],
    )

given unionWriterInterpolateUnion: OptionPickler.Writer[InterpolateUnion] = OptionPickler.writer[ujson.Value].comap[InterpolateUnion]{ _v =>
    (_v: @unchecked) match 
        case v: Interpolate => OptionPickler.writeJs[Interpolate](v)
        case v: InterpolateParams => OptionPickler.writeJs[InterpolateParams](v)
}

case class InterpolateParams (
    val gamma : Option[Double] = None,
    val `type` : InterpolateParamsType
) derives OptionPickler.ReadWriter

enum InterpolateParamsType : 
    case RGB
    case Cubehelix
    case CubehelixLong

given OptionPickler.ReadWriter[InterpolateParamsType] = OptionPickler.readwriter[String].bimap[InterpolateParamsType](
    {
        case InterpolateParamsType.RGB => "rgb"
        case InterpolateParamsType.Cubehelix => "cubehelix"
        case InterpolateParamsType.CubehelixLong => "cubehelix-long"
    },
    {
        case "rgb" => InterpolateParamsType.RGB
        case "cubehelix" => InterpolateParamsType.Cubehelix
        case "cubehelix-long" => InterpolateParamsType.CubehelixLong
        case other => throw new upickle.core.Abort("invalid InterpolateParamsType: " + other)
    }
)

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
type NiceUnion = Boolean | Double | NiceTime | NiceClass
given unionReaderNiceUnion: OptionPickler.Reader[NiceUnion] = JsonExt.badMerge[NiceUnion](
    summon[OptionPickler.Reader[NiceTime]],
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[NiceClass]],
    )

given unionWriterNiceUnion: OptionPickler.Writer[NiceUnion] = OptionPickler.writer[ujson.Value].comap[NiceUnion]{ _v =>
    (_v: @unchecked) match 
        case v: NiceTime => OptionPickler.writeJs[NiceTime](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: NiceClass => OptionPickler.writeJs[NiceClass](v)
}

case class NiceClass (
    val interval : String,
    val step : Double
) derives OptionPickler.ReadWriter

enum NiceTime : 
    case Second
    case Minute
    case Hour
    case Day
    case Week
    case Month
    case Year

given OptionPickler.ReadWriter[NiceTime] = OptionPickler.readwriter[String].bimap[NiceTime](
    {
        case NiceTime.Second => "second"
        case NiceTime.Minute => "minute"
        case NiceTime.Hour => "hour"
        case NiceTime.Day => "day"
        case NiceTime.Week => "week"
        case NiceTime.Month => "month"
        case NiceTime.Year => "year"
    },
    {
        case "second" => NiceTime.Second
        case "minute" => NiceTime.Minute
        case "hour" => NiceTime.Hour
        case "day" => NiceTime.Day
        case "week" => NiceTime.Week
        case "month" => NiceTime.Month
        case "year" => NiceTime.Year
        case other => throw new upickle.core.Abort("invalid NiceTime: " + other)
    }
)

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
type ScaleRange = String | Seq[TitleFontWeight]
given unionReaderScaleRange: OptionPickler.Reader[ScaleRange] = JsonExt.badMerge[ScaleRange](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[TitleFontWeight]]],
    )

given unionWriterScaleRange: OptionPickler.Writer[ScaleRange] = OptionPickler.writer[ujson.Value].comap[ScaleRange]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[TitleFontWeight] => OptionPickler.writeJs[Seq[TitleFontWeight]](v)
}

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

enum ScaleType : 
    case Linear
    case BinLinear
    case Log
    case Pow
    case Sqrt
    case Time
    case UTC
    case Sequential
    case Ordinal
    case BinOrdinal
    case Point
    case Band

given OptionPickler.ReadWriter[ScaleType] = OptionPickler.readwriter[String].bimap[ScaleType](
    {
        case ScaleType.Linear => "linear"
        case ScaleType.BinLinear => "bin-linear"
        case ScaleType.Log => "log"
        case ScaleType.Pow => "pow"
        case ScaleType.Sqrt => "sqrt"
        case ScaleType.Time => "time"
        case ScaleType.UTC => "utc"
        case ScaleType.Sequential => "sequential"
        case ScaleType.Ordinal => "ordinal"
        case ScaleType.BinOrdinal => "bin-ordinal"
        case ScaleType.Point => "point"
        case ScaleType.Band => "band"
    },
    {
        case "linear" => ScaleType.Linear
        case "bin-linear" => ScaleType.BinLinear
        case "log" => ScaleType.Log
        case "pow" => ScaleType.Pow
        case "sqrt" => ScaleType.Sqrt
        case "time" => ScaleType.Time
        case "utc" => ScaleType.UTC
        case "sequential" => ScaleType.Sequential
        case "ordinal" => ScaleType.Ordinal
        case "bin-ordinal" => ScaleType.BinOrdinal
        case "point" => ScaleType.Point
        case "band" => ScaleType.Band
        case other => throw new upickle.core.Abort("invalid ScaleType: " + other)
    }
)

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
type Scheme = SchemeParams | String
given unionReaderScheme: OptionPickler.Reader[Scheme] = JsonExt.badMerge[Scheme](
    JsonExt.strictString,
    summon[OptionPickler.Reader[SchemeParams]],
    )

given unionWriterScheme: OptionPickler.Writer[Scheme] = OptionPickler.writer[ujson.Value].comap[Scheme]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: SchemeParams => OptionPickler.writeJs[SchemeParams](v)
}

case class SchemeParams (
    /**
     * For sequential and diverging schemes only, determines the extent of the color range to
     * use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
     * range _[0, 0.2)_ are excluded from the scheme.
     */
    val extent : Option[Seq[Double]] = None,

    /**
     * A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    val name : String
) derives OptionPickler.ReadWriter

type SortUnion = SortEnum | SortField | NullValue
given unionReaderSortUnion: OptionPickler.Reader[SortUnion] = JsonExt.badMerge[SortUnion](
    summon[OptionPickler.Reader[SortEnum]],
    summon[OptionPickler.Reader[SortField]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterSortUnion: OptionPickler.Writer[SortUnion] = OptionPickler.writer[ujson.Value].comap[SortUnion]{ _v =>
    (_v: @unchecked) match 
        case v: SortEnum => OptionPickler.writeJs[SortEnum](v)
        case v: SortField => OptionPickler.writeJs[SortField](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class SortField (
    /**
     * The data [field](field.html) to sort by.
     *
     * __Default value:__ If unspecified, defaults to the field specified in the outer data
     * reference.
     */
    val field : Option[Field] = None,

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
    val op : AggregateOp,

    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    val order : Option[SortEnum] = None
) derives OptionPickler.ReadWriter

enum SortEnum : 
    case Ascending
    case Descending

given OptionPickler.ReadWriter[SortEnum] = OptionPickler.readwriter[String].bimap[SortEnum](
    {
        case SortEnum.Ascending => "ascending"
        case SortEnum.Descending => "descending"
    },
    {
        case "ascending" => SortEnum.Ascending
        case "descending" => SortEnum.Descending
        case other => throw new upickle.core.Abort("invalid SortEnum: " + other)
    }
)

/**
 * Horizontal facets for trellis plots.
 *
 * Vertical facets for trellis plots.
 */
case class FacetFieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * An object defining properties of a facet's header.
     */
    val header : Option[Header] = None,

    /**
     * Sort order for a facet field.
     * This can be `"ascending"`, `"descending"`.
     */
    val sort : Option[SortEnum] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Type
) derives OptionPickler.ReadWriter

/**
 * An object defining properties of a facet's header.
 *
 * Headers of row / column channels for faceted plots.
 */
case class Header (
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
    val format : Option[String] = None,

    /**
     * The rotation angle of the header labels.
     *
     * __Default value:__ `0`.
     */
    val labelAngle : Option[Double] = None,

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
    val title : Option[String] = None
) derives OptionPickler.ReadWriter

type Detail = Seq[FieldDef] | FieldDef
given unionReaderDetail: OptionPickler.Reader[Detail] = JsonExt.badMerge[Detail](
    summon[OptionPickler.Reader[Seq[FieldDef]]],
    summon[OptionPickler.Reader[FieldDef]],
    )

given unionWriterDetail: OptionPickler.Writer[Detail] = OptionPickler.writer[ujson.Value].comap[Detail]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[FieldDef] => OptionPickler.writeJs[Seq[FieldDef]](v)
        case v: FieldDef => OptionPickler.writeJs[FieldDef](v)
}

/**
 * Definition object for a data field, its type and transformation of an encoding channel.
 */
case class FieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Type
) derives OptionPickler.ReadWriter

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
case class DefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition : Option[HrefCondition] = None,

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
    val field : Option[Field] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None,

    /**
     * A constant value in visual domain.
     */
    val value : Option[ConditionalValueDefValue] = None
) derives OptionPickler.ReadWriter

type HrefCondition = ConditionalPredicateFieldDefClass | Seq[ConditionalValueDef]
given unionReaderHrefCondition: OptionPickler.Reader[HrefCondition] = JsonExt.badMerge[HrefCondition](
    summon[OptionPickler.Reader[Seq[ConditionalValueDef]]],
    summon[OptionPickler.Reader[ConditionalPredicateFieldDefClass]],
    )

given unionWriterHrefCondition: OptionPickler.Writer[HrefCondition] = OptionPickler.writer[ujson.Value].comap[HrefCondition]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[ConditionalValueDef] => OptionPickler.writeJs[Seq[ConditionalValueDef]](v)
        case v: ConditionalPredicateFieldDefClass => OptionPickler.writeJs[ConditionalPredicateFieldDefClass](v)
}

case class ConditionalPredicateFieldDefClass (
    val test : Option[LogicalOperandPredicate] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : Option[ConditionalValueDefValue] = None,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection : Option[SelectionOperand] = None,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None
) derives OptionPickler.ReadWriter

type Order = Seq[OrderFieldDef] | OrderFieldDef
given unionReaderOrder: OptionPickler.Reader[Order] = JsonExt.badMerge[Order](
    summon[OptionPickler.Reader[Seq[OrderFieldDef]]],
    summon[OptionPickler.Reader[OrderFieldDef]],
    )

given unionWriterOrder: OptionPickler.Writer[Order] = OptionPickler.writer[ujson.Value].comap[Order]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[OrderFieldDef] => OptionPickler.writeJs[Seq[OrderFieldDef]](v)
        case v: OrderFieldDef => OptionPickler.writeJs[OrderFieldDef](v)
}

case class OrderFieldDef (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    val sort : Option[SortEnum] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Type
) derives OptionPickler.ReadWriter

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
case class TextDefWithCondition (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    val condition : Option[TextCondition] = None,

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
    val field : Option[Field] = None,

    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    val format : Option[String] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None,

    /**
     * A constant value in visual domain.
     */
    val value : Option[ConditionalValueDefValue] = None
) derives OptionPickler.ReadWriter

type TextCondition = ConditionalPredicateTextFieldDefClass | Seq[ConditionalValueDef]
given unionReaderTextCondition: OptionPickler.Reader[TextCondition] = JsonExt.badMerge[TextCondition](
    summon[OptionPickler.Reader[Seq[ConditionalValueDef]]],
    summon[OptionPickler.Reader[ConditionalPredicateTextFieldDefClass]],
    )

given unionWriterTextCondition: OptionPickler.Writer[TextCondition] = OptionPickler.writer[ujson.Value].comap[TextCondition]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[ConditionalValueDef] => OptionPickler.writeJs[Seq[ConditionalValueDef]](v)
        case v: ConditionalPredicateTextFieldDefClass => OptionPickler.writeJs[ConditionalPredicateTextFieldDefClass](v)
}

case class ConditionalPredicateTextFieldDefClass (
    val test : Option[LogicalOperandPredicate] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : Option[ConditionalValueDefValue] = None,

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    val selection : Option[SelectionOperand] = None,

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    val format : Option[String] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None
) derives OptionPickler.ReadWriter

/**
 * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
 *
 * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
 *
 * Definition object for a constant value of an encoding channel.
 */
case class XClass (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * An object defining properties of axis's gridlines, ticks and labels.
     * If `null`, the axis for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [axis properties](axis.html) are applied.
     */
    val axis : Option[Axis] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    val scale : Option[Scale] = None,

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    val sort : Option[SortUnion] = None,

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
    val stack : Option[StackOffset] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : Option[ConditionalValueDefValue] = None
) derives OptionPickler.ReadWriter

case class Axis (
    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    val domain : Option[Boolean] = None,

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
    val format : Option[String] = None,

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    val grid : Option[Boolean] = None,

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    val labelAngle : Option[Double] = None,

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    val labelBound : Option[Label] = None,

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
    val labelFlush : Option[Label] = None,

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
    val labelOverlap : Option[LabelOverlapUnion] = None,

    /**
     * The padding, in pixels, between axis and text labels.
     */
    val labelPadding : Option[Double] = None,

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    val labels : Option[Boolean] = None,

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    val maxExtent : Option[Double] = None,

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    val minExtent : Option[Double] = None,

    /**
     * The offset, in pixels, by which to displace the axis from the edge of the enclosing group
     * or data rectangle.
     *
     * __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
     * `offset` (`0` by default)
     */
    val offset : Option[Double] = None,

    /**
     * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
     * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
     * the right edge of the chart).
     *
     * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
     */
    val orient : Option[TitleOrient] = None,

    /**
     * The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
     * this sets the axis group x coordinate. For y-axis with left or right orientation, this
     * sets the axis group y coordinate.
     *
     * __Default value__: `0`
     */
    val position : Option[Double] = None,

    /**
     * A desired number of ticks, for axes visualizing quantitative scales. The resulting number
     * may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
     * underlying scale's range.
     */
    val tickCount : Option[Double] = None,

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    val ticks : Option[Boolean] = None,

    /**
     * The size in pixels of axis ticks.
     */
    val tickSize : Option[Double] = None,

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
    val title : Option[String] = None,

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    val titleMaxLength : Option[Double] = None,

    /**
     * The padding, in pixels, between title and axis.
     */
    val titlePadding : Option[Double] = None,

    /**
     * Explicitly set the visible axis tick values.
     */
    val values : Option[Seq[AxisValue]] = None,

    /**
     * A non-positive integer indicating z-index of the axis.
     * If zindex is 0, axes should be drawn behind all chart elements.
     * To put them in front, use `"zindex = 1"`.
     *
     * __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
     * for grids.
     */
    val zindex : Option[Double] = None
) derives OptionPickler.ReadWriter

type AxisValue = DateTime | Double
given unionReaderAxisValue: OptionPickler.Reader[AxisValue] = JsonExt.badMerge[AxisValue](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[DateTime]],
    )

given unionWriterAxisValue: OptionPickler.Writer[AxisValue] = OptionPickler.writer[ujson.Value].comap[AxisValue]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: DateTime => OptionPickler.writeJs[DateTime](v)
}

/**
 * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Definition object for a data field, its type and transformation of an encoding channel.
 *
 * Definition object for a constant value of an encoding channel.
 */
case class X2Class (
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    val aggregate : Option[AggregateOp] = None,

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    val bin : Option[Bin] = None,

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
    val field : Option[Field] = None,

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    val `type` : Option[Type] = None,

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    val value : Option[ConditionalValueDefValue] = None
) derives OptionPickler.ReadWriter

/**
 * An object that describes mappings between `row` and `column` channels and their field
 * definitions.
 */
case class FacetMapping (
    /**
     * Horizontal facets for trellis plots.
     */
    val column : Option[FacetFieldDef] = None,

    /**
     * Vertical facets for trellis plots.
     */
    val row : Option[FacetFieldDef] = None
) derives OptionPickler.ReadWriter

/**
 * Unit spec that can have a composite mark.
 */
case class Spec (
    /**
     * An object describing the data source
     */
    val data : Option[Data] = None,

    /**
     * Description of this mark for commenting purpose.
     */
    val description : Option[String] = None,

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
    val height : Option[Double] = None,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer : Option[Seq[LayerSpec]] = None,

    /**
     * Name of the visualization for later reference.
     */
    val name : Option[String] = None,

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
    val resolve : Option[Resolve] = None,

    /**
     * Title for the plot.
     */
    val title : Option[Title] = None,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform : Option[Seq[Transform]] = None,

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
    val width : Option[Double] = None,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding : Option[Encoding] = None,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark : Option[AnyMark] = None,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection : Option[Projection] = None,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection : Option[Map[String, SelectionDef]] = None,

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    val facet : Option[FacetMapping] = None,

    /**
     * A specification of the view that gets faceted.
     */
    val spec : Option[Spec] = None,

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    val repeat : Option[Repeat] = None,

    /**
     * A list of views that should be concatenated and put into a column.
     */
    val vconcat : Option[Seq[Spec]] = None,

    /**
     * A list of views that should be concatenated and put into a row.
     */
    val hconcat : Option[Seq[Spec]] = None
) derives OptionPickler.ReadWriter

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
case class Encoding (
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
    val color : Option[MarkPropDefWithCondition] = None,

    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    val detail : Option[Detail] = None,

    /**
     * A URL to load upon mouse click.
     */
    val href : Option[DefWithCondition] = None,

    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    val opacity : Option[MarkPropDefWithCondition] = None,

    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    val order : Option[Order] = None,

    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    val shape : Option[MarkPropDefWithCondition] = None,

    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    val size : Option[MarkPropDefWithCondition] = None,

    /**
     * Text of the `text` mark.
     */
    val text : Option[TextDefWithCondition] = None,

    /**
     * The tooltip text to show upon mouse hover.
     */
    val tooltip : Option[TextDefWithCondition] = None,

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    val x : Option[XClass] = None,

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val x2 : Option[X2Class] = None,

    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    val y : Option[XClass] = None,

    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    val y2 : Option[X2Class] = None
) derives OptionPickler.ReadWriter

/**
 * Unit spec that can have a composite mark.
 */
case class LayerSpec (
    /**
     * An object describing the data source
     */
    val data : Option[Data] = None,

    /**
     * Description of this mark for commenting purpose.
     */
    val description : Option[String] = None,

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
    val height : Option[Double] = None,

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    val layer : Option[Seq[LayerSpec]] = None,

    /**
     * Name of the visualization for later reference.
     */
    val name : Option[String] = None,

    /**
     * Scale, axis, and legend resolutions for layers.
     */
    val resolve : Option[Resolve] = None,

    /**
     * Title for the plot.
     */
    val title : Option[Title] = None,

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    val transform : Option[Seq[Transform]] = None,

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
    val width : Option[Double] = None,

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    val encoding : Option[Encoding] = None,

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    val mark : Option[AnyMark] = None,

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    val projection : Option[Projection] = None,

    /**
     * A key-value mapping between selection names and definitions.
     */
    val selection : Option[Map[String, SelectionDef]] = None
) derives OptionPickler.ReadWriter

/**
 * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
 * `"line"`,
 * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
 * object](mark.html#mark-def).
 */
type AnyMark = Mark | MarkDef
given unionReaderAnyMark: OptionPickler.Reader[AnyMark] = JsonExt.badMerge[AnyMark](
    summon[OptionPickler.Reader[Mark]],
    summon[OptionPickler.Reader[MarkDef]],
    )

given unionWriterAnyMark: OptionPickler.Writer[AnyMark] = OptionPickler.writer[ujson.Value].comap[AnyMark]{ _v =>
    (_v: @unchecked) match 
        case v: Mark => OptionPickler.writeJs[Mark](v)
        case v: MarkDef => OptionPickler.writeJs[MarkDef](v)
}

case class MarkDef (
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    val align : Option[HorizontalAlign] = None,

    /**
     * The rotation angle of the text, in degrees.
     */
    val angle : Option[Double] = None,

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    val baseline : Option[VerticalAlign] = None,

    /**
     * Whether a mark be clipped to the enclosing group’s width and height.
     */
    val clip : Option[Boolean] = None,

    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val color : Option[String] = None,

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    val cursor : Option[Cursor] = None,

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dx : Option[Double] = None,

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    val dy : Option[Double] = None,

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val fill : Option[String] = None,

    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    val filled : Option[Boolean] = None,

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val fillOpacity : Option[Double] = None,

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    val font : Option[String] = None,

    /**
     * The font size, in pixels.
     */
    val fontSize : Option[Double] = None,

    /**
     * The font style (e.g., `"italic"`).
     */
    val fontStyle : Option[FontStyle] = None,

    /**
     * The font weight (e.g., `"bold"`).
     */
    val fontWeight : Option[FontWeightUnion] = None,

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    val href : Option[String] = None,

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
    val interpolate : Option[Interpolate] = None,

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    val limit : Option[Double] = None,

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    val opacity : Option[Double] = None,

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
    val orient : Option[Orient] = None,

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    val radius : Option[Double] = None,

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    val shape : Option[String] = None,

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    val size : Option[Double] = None,

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    val stroke : Option[String] = None,

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    val strokeDash : Option[Seq[Double]] = None,

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    val strokeDashOffset : Option[Double] = None,

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    val strokeOpacity : Option[Double] = None,

    /**
     * The stroke width, in pixels.
     */
    val strokeWidth : Option[Double] = None,

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
    val style : Option[Style] = None,

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    val tension : Option[Double] = None,

    /**
     * Placeholder text if the `text` channel is not specified
     */
    val text : Option[String] = None,

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    val theta : Option[Double] = None,

    /**
     * The mark type.
     * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
     * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
     */
    val `type` : Mark
) derives OptionPickler.ReadWriter

/**
 * All types of primitive marks.
 *
 * The mark type.
 * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
 * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
 */

enum Mark : 
    case Area
    case Bar
    case Line
    case Point
    case Text
    case Tick
    case Rect
    case Rule
    case Circle
    case Square
    case Geoshape

given OptionPickler.ReadWriter[Mark] = OptionPickler.readwriter[String].bimap[Mark](
    {
        case Mark.Area => "area"
        case Mark.Bar => "bar"
        case Mark.Line => "line"
        case Mark.Point => "point"
        case Mark.Text => "text"
        case Mark.Tick => "tick"
        case Mark.Rect => "rect"
        case Mark.Rule => "rule"
        case Mark.Circle => "circle"
        case Mark.Square => "square"
        case Mark.Geoshape => "geoshape"
    },
    {
        case "area" => Mark.Area
        case "bar" => Mark.Bar
        case "line" => Mark.Line
        case "point" => Mark.Point
        case "text" => Mark.Text
        case "tick" => Mark.Tick
        case "rect" => Mark.Rect
        case "rule" => Mark.Rule
        case "circle" => Mark.Circle
        case "square" => Mark.Square
        case "geoshape" => Mark.Geoshape
        case other => throw new upickle.core.Abort("invalid Mark: " + other)
    }
)

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
 *
 * A [mark style property](config.html#style) to apply to the title text mark.
 *
 * __Default value:__ `"group-title"`.
 */
type Style = Seq[String] | String
given unionReaderStyle: OptionPickler.Reader[Style] = JsonExt.badMerge[Style](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[String]]],
    )

given unionWriterStyle: OptionPickler.Writer[Style] = OptionPickler.writer[ujson.Value].comap[Style]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[String] => OptionPickler.writeJs[Seq[String]](v)
}

/**
 * An object defining properties of geographic projection.
 *
 * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
 * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
 */
case class Projection (
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    val center : Option[Seq[Double]] = None,

    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    val clipAngle : Option[Double] = None,

    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    val clipExtent : Option[Seq[Seq[Double]]] = None,

    val coefficient : Option[Double] = None,
    val distance : Option[Double] = None,
    val fraction : Option[Double] = None,
    val lobes : Option[Double] = None,
    val parallel : Option[Double] = None,

    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    val precision : Option[Map[String, TitleFontWeight]] = None,

    val radius : Option[Double] = None,
    val ratio : Option[Double] = None,

    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    val rotate : Option[Seq[Double]] = None,

    val spacing : Option[Double] = None,
    val tilt : Option[Double] = None,

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    val `type` : Option[VGProjectionType] = None
) derives OptionPickler.ReadWriter

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
case class Resolve (
    val axis : Option[AxisResolveMap] = None,
    val legend : Option[LegendResolveMap] = None,
    val scale : Option[ScaleResolveMap] = None
) derives OptionPickler.ReadWriter

case class AxisResolveMap (
    val x : Option[ResolveMode] = None,
    val y : Option[ResolveMode] = None
) derives OptionPickler.ReadWriter

enum ResolveMode : 
    case Independent
    case Shared

given OptionPickler.ReadWriter[ResolveMode] = OptionPickler.readwriter[String].bimap[ResolveMode](
    {
        case ResolveMode.Independent => "independent"
        case ResolveMode.Shared => "shared"
    },
    {
        case "independent" => ResolveMode.Independent
        case "shared" => ResolveMode.Shared
        case other => throw new upickle.core.Abort("invalid ResolveMode: " + other)
    }
)

case class LegendResolveMap (
    val color : Option[ResolveMode] = None,
    val opacity : Option[ResolveMode] = None,
    val shape : Option[ResolveMode] = None,
    val size : Option[ResolveMode] = None
) derives OptionPickler.ReadWriter

case class ScaleResolveMap (
    val color : Option[ResolveMode] = None,
    val opacity : Option[ResolveMode] = None,
    val shape : Option[ResolveMode] = None,
    val size : Option[ResolveMode] = None,
    val x : Option[ResolveMode] = None,
    val y : Option[ResolveMode] = None
) derives OptionPickler.ReadWriter

case class SelectionDef (
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
    val bind : Option[BindUnion] = None,

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    val empty : Option[Empty] = None,

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    val encodings : Option[Seq[SingleDefChannel]] = None,

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    val fields : Option[Seq[String]] = None,

    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    val nearest : Option[Boolean] = None,

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    val on : Option[ujson.Value] = None,

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    val resolve : Option[SelectionResolution] = None,

    val `type` : SelectionDefType,

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
    val toggle : Option[Translate] = None,

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    val mark : Option[BrushConfig] = None,

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
    val translate : Option[Translate] = None,

    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    val zoom : Option[Translate] = None
) derives OptionPickler.ReadWriter

type BindUnion = BindEnum | Map[String, VGBinding]
given unionReaderBindUnion: OptionPickler.Reader[BindUnion] = JsonExt.badMerge[BindUnion](
    summon[OptionPickler.Reader[BindEnum]],
    summon[OptionPickler.Reader[Map[String, VGBinding]]],
    )

given unionWriterBindUnion: OptionPickler.Writer[BindUnion] = OptionPickler.writer[ujson.Value].comap[BindUnion]{ _v =>
    (_v: @unchecked) match 
        case v: BindEnum => OptionPickler.writeJs[BindEnum](v)
        case v: Map[String, VGBinding] => OptionPickler.writeJs[Map[String, VGBinding]](v)
}

enum SelectionDefType : 
    case Single
    case Multi
    case Interval

given OptionPickler.ReadWriter[SelectionDefType] = OptionPickler.readwriter[String].bimap[SelectionDefType](
    {
        case SelectionDefType.Single => "single"
        case SelectionDefType.Multi => "multi"
        case SelectionDefType.Interval => "interval"
    },
    {
        case "single" => SelectionDefType.Single
        case "multi" => SelectionDefType.Multi
        case "interval" => SelectionDefType.Interval
        case other => throw new upickle.core.Abort("invalid SelectionDefType: " + other)
    }
)

type Title = String | TitleParams
given unionReaderTitle: OptionPickler.Reader[Title] = JsonExt.badMerge[Title](
    JsonExt.strictString,
    summon[OptionPickler.Reader[TitleParams]],
    )

given unionWriterTitle: OptionPickler.Writer[Title] = OptionPickler.writer[ujson.Value].comap[Title]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: TitleParams => OptionPickler.writeJs[TitleParams](v)
}

case class TitleParams (
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
    val anchor : Option[Anchor] = None,

    /**
     * The orthogonal offset in pixels by which to displace the title from its position along
     * the edge of the chart.
     */
    val offset : Option[Double] = None,

    /**
     * The orientation of the title relative to the chart. One of `"top"` (the default),
     * `"bottom"`, `"left"`, or `"right"`.
     */
    val orient : Option[TitleOrient] = None,

    /**
     * A [mark style property](config.html#style) to apply to the title text mark.
     *
     * __Default value:__ `"group-title"`.
     */
    val style : Option[Style] = None,

    /**
     * The title text.
     */
    val text : String
) derives OptionPickler.ReadWriter

case class Transform (
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
    val filter : Option[LogicalOperandPredicate] = None,

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
    val as : Option[Style] = None,

    /**
     * A [expression](types.html#expression) string. Use the variable `datum` to refer to the
     * current data object.
     */
    val calculate : Option[String] = None,

    /**
     * The default value to use if lookup fails.
     *
     * __Default value:__ `null`
     */
    val default : Option[String] = None,

    /**
     * Secondary data reference.
     */
    val from : Option[LookupData] = None,

    /**
     * Key in primary data source.
     */
    val lookup : Option[String] = None,

    /**
     * An object indicating bin properties, or simply `true` for using default bin parameters.
     */
    val bin : Option[Bin] = None,

    /**
     * The data field to bin.
     *
     * The data field to apply time unit.
     */
    val field : Option[String] = None,

    /**
     * The timeUnit.
     */
    val timeUnit : Option[TimeUnit] = None,

    /**
     * Array of objects that define fields to aggregate.
     */
    val aggregate : Option[Seq[AggregatedFieldDef]] = None,

    /**
     * The data fields to group by. If not specified, a single group containing all data objects
     * will be used.
     */
    val groupby : Option[Seq[String]] = None
) derives OptionPickler.ReadWriter

case class AggregatedFieldDef (
    /**
     * The output field names to use for each aggregated field.
     */
    val as : String,

    /**
     * The data field for which to compute aggregate function.
     */
    val field : String,

    /**
     * The aggregation operations to apply to the fields, such as sum, average or count.
     * See the [full list of supported aggregation
     * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
     * for more information.
     */
    val op : AggregateOp
) derives OptionPickler.ReadWriter

/**
 * Secondary data reference.
 */
case class LookupData (
    /**
     * Secondary data source to lookup in.
     */
    val data : Data,

    /**
     * Fields in foreign data to lookup.
     * If not specified, the entire object is queried.
     */
    val fields : Option[Seq[String]] = None,

    /**
     * Key in data to lookup.
     */
    val key : String
) derives OptionPickler.ReadWriter

/**
 * An object that describes what fields should be repeated into views that are laid out as a
 * `row` or `column`.
 */
case class Repeat (
    /**
     * Horizontal repeated views.
     */
    val column : Option[Seq[String]] = None,

    /**
     * Vertical repeated views.
     */
    val row : Option[Seq[String]] = None
) derives OptionPickler.ReadWriter
