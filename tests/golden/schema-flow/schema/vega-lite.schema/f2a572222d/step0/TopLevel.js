// @flow

// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = {
    /**
     * URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
     * have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
     * Setting the `$schema` property allows automatic validation and autocomplete in editors
     * that support JSON schema.
     */
    $schema?: string;
    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    autosize?: Autosize;
    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    background?: string;
    /**
     * Vega-Lite configuration object.  This property can only be defined at the top-level of a
     * specification.
     */
    config?: Config;
    /**
     * An object describing the data source
     */
    data?: Data;
    /**
     * Description of this mark for commenting purpose.
     */
    description?: string;
    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    encoding?: EncodingWithFacet;
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
    height?: number;
    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    mark?: AnyMark;
    /**
     * Name of the visualization for later reference.
     */
    name?: string;
    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    padding?: Padding;
    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    projection?: Projection;
    /**
     * A key-value mapping between selection names and definitions.
     */
    selection?: { [key: string]: SelectionDef };
    /**
     * Title for the plot.
     */
    title?: Title;
    /**
     * An array of data transformations such as filter and new field calculation.
     */
    transform?: Transform[];
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
    width?: number;
    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    layer?: LayerSpec[];
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
    resolve?: Resolve;
    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    facet?: FacetMapping;
    /**
     * A specification of the view that gets faceted.
     */
    spec?: Spec;
    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    repeat?: Repeat;
    /**
     * A list of views that should be concatenated and put into a column.
     */
    vconcat?: Spec[];
    /**
     * A list of views that should be concatenated and put into a row.
     */
    hconcat?: Spec[];
};

/**
 * Sets how the visualization size should be determined. If a string, should be one of
 * `"pad"`, `"fit"` or `"none"`.
 * Object values can additionally specify parameters for content sizing and automatic
 * resizing.
 * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
 *
 * __Default value__: `pad`
 */
export type Autosize = AutoSizeParams | AutosizeType;

export type AutoSizeParams = {
    /**
     * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
     * The default setting (`"content"`) interprets the width and height settings as the data
     * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
     * `"padding"` setting includes the padding within the view size calculations, such that the
     * width and height settings indicate the **total** intended size of the view.
     *
     * __Default value__: `"content"`
     */
    contains?: Contains;
    /**
     * A boolean flag indicating if autosize layout should be re-calculated on every view
     * update.
     *
     * __Default value__: `false`
     */
    resize?: boolean;
    /**
     * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
     * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
     * descriptions of each.
     *
     * __Default value__: `"pad"`
     */
    type?: AutosizeType;
};

/**
 * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
 * The default setting (`"content"`) interprets the width and height settings as the data
 * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
 * `"padding"` setting includes the padding within the view size calculations, such that the
 * width and height settings indicate the **total** intended size of the view.
 *
 * __Default value__: `"content"`
 */
export type Contains =
      "content"
    | "padding";

/**
 * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
 * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
 * descriptions of each.
 *
 * __Default value__: `"pad"`
 */
export type AutosizeType =
      "pad"
    | "fit"
    | "none";

/**
 * Vega-Lite configuration object.  This property can only be defined at the top-level of a
 * specification.
 */
export type Config = {
    /**
     * Area-Specific Config
     */
    area?: MarkConfig;
    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    autosize?: Autosize;
    /**
     * Axis configuration, which determines default properties for all `x` and `y`
     * [axes](axis.html). For a full list of axis configuration options, please see the
     * [corresponding section of the axis documentation](axis.html#config).
     */
    axis?: AxisConfig;
    /**
     * Specific axis config for axes with "band" scales.
     */
    axisBand?: VGAxisConfig;
    /**
     * Specific axis config for x-axis along the bottom edge of the chart.
     */
    axisBottom?: VGAxisConfig;
    /**
     * Specific axis config for y-axis along the left edge of the chart.
     */
    axisLeft?: VGAxisConfig;
    /**
     * Specific axis config for y-axis along the right edge of the chart.
     */
    axisRight?: VGAxisConfig;
    /**
     * Specific axis config for x-axis along the top edge of the chart.
     */
    axisTop?: VGAxisConfig;
    /**
     * X-axis specific config.
     */
    axisX?: VGAxisConfig;
    /**
     * Y-axis specific config.
     */
    axisY?: VGAxisConfig;
    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    background?: string;
    /**
     * Bar-Specific Config
     */
    bar?: BarConfig;
    /**
     * Circle-Specific Config
     */
    circle?: MarkConfig;
    /**
     * Default axis and legend title for count fields.
     *
     * __Default value:__ `'Number of Records'`.
     */
    countTitle?: string;
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
    fieldTitle?: FieldTitle;
    /**
     * Geoshape-Specific Config
     */
    geoshape?: MarkConfig;
    /**
     * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
     * - If set to `"filter"` (default), all data items with null values are filtered.
     * - If `null`, all data items are included. In this case, invalid values will be
     * interpreted as zeroes.
     */
    invalidValues?: InvalidValues;
    /**
     * Legend configuration, which determines default properties for all [legends](legend.html).
     * For a full list of legend configuration options, please see the [corresponding section of
     * in the legend documentation](legend.html#config).
     */
    legend?: LegendConfig;
    /**
     * Line-Specific Config
     */
    line?: MarkConfig;
    /**
     * Mark Config
     */
    mark?: MarkConfig;
    /**
     * D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
     * number format pattern](https://github.com/d3/d3-format#locale_format).
     */
    numberFormat?: string;
    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    padding?: Padding;
    /**
     * Point-Specific Config
     */
    point?: MarkConfig;
    /**
     * Projection configuration, which determines default properties for all
     * [projections](projection.html). For a full list of projection configuration options,
     * please see the [corresponding section of the projection
     * documentation](projection.html#config).
     */
    projection?: ProjectionConfig;
    /**
     * An object hash that defines default range arrays or schemes for using with scales.
     * For a full list of scale range configuration options, please see the [corresponding
     * section of the scale documentation](scale.html#config).
     */
    range?: RangeConfig;
    /**
     * Rect-Specific Config
     */
    rect?: MarkConfig;
    /**
     * Rule-Specific Config
     */
    rule?: MarkConfig;
    /**
     * Scale configuration determines default properties for all [scales](scale.html). For a
     * full list of scale configuration options, please see the [corresponding section of the
     * scale documentation](scale.html#config).
     */
    scale?: ScaleConfig;
    /**
     * An object hash for defining default properties for each type of selections.
     */
    selection?: SelectionConfig;
    /**
     * Square-Specific Config
     */
    square?: MarkConfig;
    /**
     * Default stack offset for stackable mark.
     */
    stack?: StackOffset;
    /**
     * An object hash that defines key-value mappings to determine default properties for marks
     * with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
     * valid [mark configuration objects](mark.html#config).
     */
    style?: { [key: string]: VGMarkConfig };
    /**
     * Text-Specific Config
     */
    text?: TextConfig;
    /**
     * Tick-Specific Config
     */
    tick?: TickConfig;
    /**
     * Default datetime format for axis and legend labels. The format can be set directly on
     * each axis and legend. Use [D3's time format
     * pattern](https://github.com/d3/d3-time-format#locale_format).
     *
     * __Default value:__ `'%b %d, %Y'`.
     */
    timeFormat?: string;
    /**
     * Title configuration, which determines default properties for all [titles](title.html).
     * For a full list of title configuration options, please see the [corresponding section of
     * the title documentation](title.html#config).
     */
    title?: VGTitleConfig;
    /**
     * Default properties for [single view plots](spec.html#single).
     */
    view?: ViewConfig;
};

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
export type MarkConfig = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    color?: string;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    filled?: boolean;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
};

/**
 * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
 */
export type HorizontalAlign =
      "left"
    | "right"
    | "center";

/**
 * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
 *
 * __Default value:__ `"middle"`
 *
 * Vertical text baseline for title text.
 */
export type VerticalAlign =
      "top"
    | "middle"
    | "bottom";

/**
 * The mouse cursor used over the mark. Any valid [CSS cursor
 * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
 */
export type Cursor =
      "auto"
    | "default"
    | "none"
    | "context-menu"
    | "help"
    | "pointer"
    | "progress"
    | "wait"
    | "cell"
    | "crosshair"
    | "text"
    | "vertical-text"
    | "alias"
    | "copy"
    | "move"
    | "no-drop"
    | "not-allowed"
    | "e-resize"
    | "n-resize"
    | "ne-resize"
    | "nw-resize"
    | "s-resize"
    | "se-resize"
    | "sw-resize"
    | "w-resize"
    | "ew-resize"
    | "ns-resize"
    | "nesw-resize"
    | "nwse-resize"
    | "col-resize"
    | "row-resize"
    | "all-scroll"
    | "zoom-in"
    | "zoom-out"
    | "grab"
    | "grabbing";

/**
 * The font style (e.g., `"italic"`).
 */
export type FontStyle =
      "normal"
    | "italic";

/**
 * The font weight (e.g., `"bold"`).
 *
 * Font weight for title text.
 */
export type FontWeightUnion = number | FontWeight;

export type FontWeight =
      "normal"
    | "bold";

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
export type Interpolate =
      "linear"
    | "linear-closed"
    | "step"
    | "step-before"
    | "step-after"
    | "basis"
    | "basis-open"
    | "basis-closed"
    | "cardinal"
    | "cardinal-open"
    | "cardinal-closed"
    | "bundle"
    | "monotone";

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
export type Orient =
      "horizontal"
    | "vertical";

/**
 * Axis configuration, which determines default properties for all `x` and `y`
 * [axes](axis.html). For a full list of axis configuration options, please see the
 * [corresponding section of the axis documentation](axis.html#config).
 */
export type AxisConfig = {
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    bandPosition?: number;
    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    domain?: boolean;
    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    domainColor?: string;
    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    domainWidth?: number;
    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    grid?: boolean;
    /**
     * Color of gridlines.
     */
    gridColor?: string;
    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    gridDash?: number[];
    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    gridOpacity?: number;
    /**
     * The grid width, in pixels.
     */
    gridWidth?: number;
    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    labelAngle?: number;
    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    labelBound?: Label;
    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    labelColor?: string;
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
    labelFlush?: Label;
    /**
     * The font of the tick label.
     */
    labelFont?: string;
    /**
     * The font size of the label, in pixels.
     */
    labelFontSize?: number;
    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    labelLimit?: number;
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
    labelOverlap?: LabelOverlapUnion;
    /**
     * The padding, in pixels, between axis and text labels.
     */
    labelPadding?: number;
    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    labels?: boolean;
    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    maxExtent?: number;
    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    minExtent?: number;
    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    shortTimeLabels?: boolean;
    /**
     * The color of the axis's tick.
     */
    tickColor?: string;
    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    tickRound?: boolean;
    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    ticks?: boolean;
    /**
     * The size in pixels of axis ticks.
     */
    tickSize?: number;
    /**
     * The width, in pixels, of ticks.
     */
    tickWidth?: number;
    /**
     * Horizontal text alignment of axis titles.
     */
    titleAlign?: string;
    /**
     * Angle in degrees of axis titles.
     */
    titleAngle?: number;
    /**
     * Vertical text baseline for axis titles.
     */
    titleBaseline?: string;
    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    titleColor?: string;
    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    titleFont?: string;
    /**
     * Font size of the title.
     */
    titleFontSize?: number;
    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    titleFontWeight?: TitleFontWeight;
    /**
     * Maximum allowed pixel width of axis titles.
     */
    titleLimit?: number;
    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    titleMaxLength?: number;
    /**
     * The padding, in pixels, between title and axis.
     */
    titlePadding?: number;
    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    titleX?: number;
    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    titleY?: number;
};

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
export type Label = boolean | number;

export type LabelOverlapUnion = boolean | LabelOverlapEnum;

export type LabelOverlapEnum =
      "parity"
    | "greedy";

/**
 * Font weight of the title. (e.g., `"bold"`).
 *
 * The font weight of the legend title.
 */
export type TitleFontWeight = number | string;

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
export type VGAxisConfig = {
    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    bandPosition?: number;
    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    domain?: boolean;
    /**
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    domainColor?: string;
    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    domainWidth?: number;
    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    grid?: boolean;
    /**
     * Color of gridlines.
     */
    gridColor?: string;
    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    gridDash?: number[];
    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    gridOpacity?: number;
    /**
     * The grid width, in pixels.
     */
    gridWidth?: number;
    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    labelAngle?: number;
    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    labelBound?: Label;
    /**
     * The color of the tick label, can be in hex color code or regular color name.
     */
    labelColor?: string;
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
    labelFlush?: Label;
    /**
     * The font of the tick label.
     */
    labelFont?: string;
    /**
     * The font size of the label, in pixels.
     */
    labelFontSize?: number;
    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    labelLimit?: number;
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
    labelOverlap?: LabelOverlapUnion;
    /**
     * The padding, in pixels, between axis and text labels.
     */
    labelPadding?: number;
    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    labels?: boolean;
    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    maxExtent?: number;
    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    minExtent?: number;
    /**
     * The color of the axis's tick.
     */
    tickColor?: string;
    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    tickRound?: boolean;
    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    ticks?: boolean;
    /**
     * The size in pixels of axis ticks.
     */
    tickSize?: number;
    /**
     * The width, in pixels, of ticks.
     */
    tickWidth?: number;
    /**
     * Horizontal text alignment of axis titles.
     */
    titleAlign?: string;
    /**
     * Angle in degrees of axis titles.
     */
    titleAngle?: number;
    /**
     * Vertical text baseline for axis titles.
     */
    titleBaseline?: string;
    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    titleColor?: string;
    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    titleFont?: string;
    /**
     * Font size of the title.
     */
    titleFontSize?: number;
    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    titleFontWeight?: TitleFontWeight;
    /**
     * Maximum allowed pixel width of axis titles.
     */
    titleLimit?: number;
    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    titleMaxLength?: number;
    /**
     * The padding, in pixels, between title and axis.
     */
    titlePadding?: number;
    /**
     * X-coordinate of the axis title relative to the axis group.
     */
    titleX?: number;
    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    titleY?: number;
};

/**
 * Bar-Specific Config
 */
export type BarConfig = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
     * statisticians) or 1 (Vega-Lite Default, D3 example style).
     *
     * __Default value:__ `1`
     */
    binSpacing?: number;
    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    color?: string;
    /**
     * The default size of the bars on continuous scales.
     *
     * __Default value:__ `5`
     */
    continuousBandSize?: number;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The size of the bars.  If unspecified, the default size is  `bandSize-1`,
     * which provides 1 pixel offset between bars.
     */
    discreteBandSize?: number;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    filled?: boolean;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
};

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
export type FieldTitle =
      "verbal"
    | "functional"
    | "plain";

/**
 * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
 * - If set to `"filter"` (default), all data items with null values are filtered.
 * - If `null`, all data items are included. In this case, invalid values will be
 * interpreted as zeroes.
 */
export type InvalidValues =
      "filter";

/**
 * Legend configuration, which determines default properties for all [legends](legend.html).
 * For a full list of legend configuration options, please see the [corresponding section of
 * in the legend documentation](legend.html#config).
 */
export type LegendConfig = {
    /**
     * Corner radius for the full legend.
     */
    cornerRadius?: number;
    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    entryPadding?: number;
    /**
     * Background fill color for the full legend.
     */
    fillColor?: string;
    /**
     * The height of the gradient, in pixels.
     */
    gradientHeight?: number;
    /**
     * Text baseline for color ramp gradient labels.
     */
    gradientLabelBaseline?: string;
    /**
     * The maximum allowed length in pixels of color ramp gradient labels.
     */
    gradientLabelLimit?: number;
    /**
     * Vertical offset in pixels for color ramp gradient labels.
     */
    gradientLabelOffset?: number;
    /**
     * The color of the gradient stroke, can be in hex color code or regular color name.
     */
    gradientStrokeColor?: string;
    /**
     * The width of the gradient stroke, in pixels.
     */
    gradientStrokeWidth?: number;
    /**
     * The width of the gradient, in pixels.
     */
    gradientWidth?: number;
    /**
     * The alignment of the legend label, can be left, middle or right.
     */
    labelAlign?: string;
    /**
     * The position of the baseline of legend label, can be top, middle or bottom.
     */
    labelBaseline?: string;
    /**
     * The color of the legend label, can be in hex color code or regular color name.
     */
    labelColor?: string;
    /**
     * The font of the legend label.
     */
    labelFont?: string;
    /**
     * The font size of legend label.
     *
     * __Default value:__ `10`.
     */
    labelFontSize?: number;
    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    labelLimit?: number;
    /**
     * The offset of the legend label.
     */
    labelOffset?: number;
    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    offset?: number;
    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    orient?: LegendOrient;
    /**
     * The padding, in pixels, between the legend and axis.
     */
    padding?: number;
    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    shortTimeLabels?: boolean;
    /**
     * Border stroke color for the full legend.
     */
    strokeColor?: string;
    /**
     * Border stroke dash pattern for the full legend.
     */
    strokeDash?: number[];
    /**
     * Border stroke width for the full legend.
     */
    strokeWidth?: number;
    /**
     * The color of the legend symbol,
     */
    symbolColor?: string;
    /**
     * The size of the legend symbol, in pixels.
     */
    symbolSize?: number;
    /**
     * The width of the symbol's stroke.
     */
    symbolStrokeWidth?: number;
    /**
     * Default shape type (such as "circle") for legend symbols.
     */
    symbolType?: string;
    /**
     * Horizontal text alignment for legend titles.
     */
    titleAlign?: string;
    /**
     * Vertical text baseline for legend titles.
     */
    titleBaseline?: string;
    /**
     * The color of the legend title, can be in hex color code or regular color name.
     */
    titleColor?: string;
    /**
     * The font of the legend title.
     */
    titleFont?: string;
    /**
     * The font size of the legend title.
     */
    titleFontSize?: number;
    /**
     * The font weight of the legend title.
     */
    titleFontWeight?: TitleFontWeight;
    /**
     * Maximum allowed pixel width of axis titles.
     */
    titleLimit?: number;
    /**
     * The padding, in pixels, between title and legend.
     */
    titlePadding?: number;
};

/**
 * The orientation of the legend, which determines how the legend is positioned within the
 * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
 * "none".
 *
 * __Default value:__ `"right"`
 */
export type LegendOrient =
      "left"
    | "right"
    | "top-left"
    | "top-right"
    | "bottom-left"
    | "bottom-right"
    | "none";

/**
 * The default visualization padding, in pixels, from the edge of the visualization canvas
 * to the data rectangle.  If a number, specifies padding for all sides.
 * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
 * "bottom": 5}` to specify padding for each side of the visualization.
 *
 * __Default value__: `5`
 */
export type Padding = PaddingClass | number;

export type PaddingClass = {
    bottom?: number;
    left?:   number;
    right?:  number;
    top?:    number;
};

/**
 * Projection configuration, which determines default properties for all
 * [projections](projection.html). For a full list of projection configuration options,
 * please see the [corresponding section of the projection
 * documentation](projection.html#config).
 *
 * Any property of Projection can be in config
 */
export type ProjectionConfig = {
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    center?: number[];
    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    clipAngle?: number;
    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    clipExtent?:  Array<number[]>;
    coefficient?: number;
    distance?:    number;
    fraction?:    number;
    lobes?:       number;
    parallel?:    number;
    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    precision?: PurplePrecision;
    radius?:    number;
    ratio?:     number;
    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    rotate?:  number[];
    spacing?: number;
    tilt?:    number;
    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    type?: VGProjectionType;
};

/**
 * Sets the threshold for the projection’s [adaptive
 * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
 * value corresponds to the [Douglas–Peucker
 * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
 * If precision is not specified, returns the projection’s current resampling precision
 * which defaults to `√0.5 ≅ 0.70710…`.
 */
export type PurplePrecision = {
    /**
     * Returns the length of a String object.
     */
    length: number;
    [property: string]: string | number;
};

/**
 * The cartographic projection to use. This value is case-insensitive, for example
 * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
 * projection types [in the
 * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
 *
 * __Default value:__ `mercator`
 */
export type VGProjectionType =
      "albers"
    | "albersUsa"
    | "azimuthalEqualArea"
    | "azimuthalEquidistant"
    | "conicConformal"
    | "conicEqualArea"
    | "conicEquidistant"
    | "equirectangular"
    | "gnomonic"
    | "mercator"
    | "orthographic"
    | "stereographic"
    | "transverseMercator";

/**
 * An object hash that defines default range arrays or schemes for using with scales.
 * For a full list of scale range configuration options, please see the [corresponding
 * section of the scale documentation](scale.html#config).
 */
export type RangeConfig = {
    /**
     * Default range for _nominal_ (categorical) fields.
     */
    category?: Category;
    /**
     * Default range for diverging _quantitative_ fields.
     */
    diverging?: Category;
    /**
     * Default range for _quantitative_ heatmaps.
     */
    heatmap?: Category;
    /**
     * Default range for _ordinal_ fields.
     */
    ordinal?: Category;
    /**
     * Default range for _quantitative_ and _temporal_ fields.
     */
    ramp?: Category;
    /**
     * Default range palette for the `shape` channel.
     */
    symbol?: string[];
    [property: string]: RangeConfigValue | Category | string[] | void;
};

/**
 * Default range for _nominal_ (categorical) fields.
 *
 * Default range for diverging _quantitative_ fields.
 *
 * Default range for _quantitative_ heatmaps.
 *
 * Default range for _ordinal_ fields.
 *
 * Default range for _quantitative_ and _temporal_ fields.
 */
export type Category = string[] | CategoryVGScheme;

export type CategoryVGScheme = {
    count?:  number;
    extent?: number[];
    scheme:  string;
};

export type RangeConfigValue = TitleFontWeight[] | RangeConfigValueVGScheme;

export type RangeConfigValueVGScheme = {
    count?:  number;
    extent?: number[];
    scheme?: string;
    step?:   number;
};

/**
 * Scale configuration determines default properties for all [scales](scale.html). For a
 * full list of scale configuration options, please see the [corresponding section of the
 * scale documentation](scale.html#config).
 */
export type ScaleConfig = {
    /**
     * Default inner padding for `x` and `y` band-ordinal scales.
     *
     * __Default value:__ `0.1`
     */
    bandPaddingInner?: number;
    /**
     * Default outer padding for `x` and `y` band-ordinal scales.
     * If not specified, by default, band scale's paddingOuter is paddingInner/2.
     */
    bandPaddingOuter?: number;
    /**
     * If true, values that exceed the data domain are clamped to either the minimum or maximum
     * range value
     */
    clamp?: boolean;
    /**
     * Default padding for continuous scales.
     *
     * __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
     * horizontal bar.; `0` otherwise.
     */
    continuousPadding?: number;
    /**
     * The default max value for mapping quantitative fields to bar's size/bandSize.
     *
     * If undefined (default), we will use the scale's `rangeStep` - 1.
     */
    maxBandSize?: number;
    /**
     * The default max value for mapping quantitative fields to text's size/fontSize.
     *
     * __Default value:__ `40`
     */
    maxFontSize?: number;
    /**
     * Default max opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.8`
     */
    maxOpacity?: number;
    /**
     * Default max value for point size scale.
     */
    maxSize?: number;
    /**
     * Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
     *
     * __Default value:__ `4`
     */
    maxStrokeWidth?: number;
    /**
     * The default min value for mapping quantitative fields to bar and tick's size/bandSize
     * scale with zero=false.
     *
     * __Default value:__ `2`
     */
    minBandSize?: number;
    /**
     * The default min value for mapping quantitative fields to tick's size/fontSize scale with
     * zero=false
     *
     * __Default value:__ `8`
     */
    minFontSize?: number;
    /**
     * Default minimum opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.3`
     */
    minOpacity?: number;
    /**
     * Default minimum value for point size scale with zero=false.
     *
     * __Default value:__ `9`
     */
    minSize?: number;
    /**
     * Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
     *
     * __Default value:__ `1`
     */
    minStrokeWidth?: number;
    /**
     * Default outer padding for `x` and `y` point-ordinal scales.
     *
     * __Default value:__ `0.5`
     */
    pointPadding?: number;
    /**
     * Default range step for band and point scales of (1) the `y` channel
     * and (2) the `x` channel when the mark is not `text`.
     *
     * __Default value:__ `21`
     */
    rangeStep?: number | null;
    /**
     * If true, rounds numeric output values to integers.
     * This can be helpful for snapping to the pixel grid.
     * (Only available for `x`, `y`, and `size` scales.)
     */
    round?: boolean;
    /**
     * Default range step for `x` band and point scales of text marks.
     *
     * __Default value:__ `90`
     */
    textXRangeStep?: number;
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
    useUnaggregatedDomain?: boolean;
};

/**
 * An object hash for defining default properties for each type of selections.
 */
export type SelectionConfig = {
    /**
     * The default definition for an [`interval`](selection.html#type) selection. All properties
     * and transformations
     * for an interval selection definition (except `type`) may be specified here.
     *
     * For instance, setting `interval` to `{"translate": false}` disables the ability to move
     * interval selections by default.
     */
    interval?: IntervalSelectionConfig;
    /**
     * The default definition for a [`multi`](selection.html#type) selection. All properties and
     * transformations
     * for a multi selection definition (except `type`) may be specified here.
     *
     * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
     * multi selections when clicking with the alt-key pressed by default.
     */
    multi?: MultiSelectionConfig;
    /**
     * The default definition for a [`single`](selection.html#type) selection. All properties
     * and transformations
     * for a single selection definition (except `type`) may be specified here.
     *
     * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
     * double-click by default.
     */
    single?: SingleSelectionConfig;
};

/**
 * The default definition for an [`interval`](selection.html#type) selection. All properties
 * and transformations
 * for an interval selection definition (except `type`) may be specified here.
 *
 * For instance, setting `interval` to `{"translate": false}` disables the ability to move
 * interval selections by default.
 */
export type IntervalSelectionConfig = {
    /**
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    bind?: BindEnum;
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    empty?: Empty;
    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    encodings?: SingleDefChannel[];
    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    fields?: string[];
    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    mark?: BrushConfig;
    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    on?: mixed;
    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    resolve?: SelectionResolution;
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
    translate?: Translate;
    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    zoom?: Translate;
};

/**
 * Establishes a two-way binding between the interval selection and the scales
 * used within the same view. This allows a user to interactively pan and
 * zoom the view.
 */
export type BindEnum =
      "scales";

/**
 * By default, all data values are considered to lie within an empty selection.
 * When set to `none`, empty selections contain no data values.
 */
export type Empty =
      "all"
    | "none";

export type SingleDefChannel =
      "x"
    | "y"
    | "x2"
    | "y2"
    | "row"
    | "column"
    | "size"
    | "shape"
    | "color"
    | "opacity"
    | "text"
    | "tooltip"
    | "href";

/**
 * An interval selection also adds a rectangle mark to depict the
 * extents of the interval. The `mark` property can be used to customize the
 * appearance of the mark.
 */
export type BrushConfig = {
    /**
     * The fill color of the interval mark.
     *
     * __Default value:__ `#333333`
     */
    fill?: string;
    /**
     * The fill opacity of the interval mark (a value between 0 and 1).
     *
     * __Default value:__ `0.125`
     */
    fillOpacity?: number;
    /**
     * The stroke color of the interval mark.
     *
     * __Default value:__ `#ffffff`
     */
    stroke?: string;
    /**
     * An array of alternating stroke and space lengths,
     * for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) with which to begin drawing the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity of the interval mark (a value between 0 and 1).
     */
    strokeOpacity?: number;
    /**
     * The stroke width of the interval mark.
     */
    strokeWidth?: number;
};

/**
 * With layered and multi-view displays, a strategy that determines how
 * selections' data queries are resolved when applied in a filter transform,
 * conditional encoding rule, or scale domain.
 */
export type SelectionResolution =
      "global"
    | "union"
    | "intersect";

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
export type Translate = boolean | string;

/**
 * The default definition for a [`multi`](selection.html#type) selection. All properties and
 * transformations
 * for a multi selection definition (except `type`) may be specified here.
 *
 * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
 * multi selections when clicking with the alt-key pressed by default.
 */
export type MultiSelectionConfig = {
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    empty?: Empty;
    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    encodings?: SingleDefChannel[];
    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    fields?: string[];
    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    nearest?: boolean;
    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    on?: mixed;
    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    resolve?: SelectionResolution;
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
    toggle?: Translate;
};

/**
 * The default definition for a [`single`](selection.html#type) selection. All properties
 * and transformations
 * for a single selection definition (except `type`) may be specified here.
 *
 * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
 * double-click by default.
 */
export type SingleSelectionConfig = {
    /**
     * Establish a two-way binding between a single selection and input elements
     * (also known as dynamic query widgets). A binding takes the form of
     * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
     * or can be a mapping between projected field/encodings and binding definitions.
     *
     * See the [bind transform](bind.html) documentation for more information.
     */
    bind?: { [key: string]: VGBinding };
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    empty?: Empty;
    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    encodings?: SingleDefChannel[];
    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    fields?: string[];
    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    nearest?: boolean;
    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    on?: mixed;
    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    resolve?: SelectionResolution;
};

export type VGBinding = {
    element?: string;
    input:    string;
    options?: string[];
    max?:     number;
    min?:     number;
    step?:    number;
};

/**
 * Default stack offset for stackable mark.
 */
export type StackOffset =
      "zero"
    | "center"
    | "normalize";

export type VGMarkConfig = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
};

/**
 * Text-Specific Config
 */
export type TextConfig = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    color?: string;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    filled?: boolean;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * Whether month names and weekday names should be abbreviated.
     */
    shortTimeLabels?: boolean;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
};

/**
 * Tick-Specific Config
 */
export type TickConfig = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The width of the ticks.
     *
     * __Default value:__  2/3 of rangeStep.
     */
    bandSize?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    color?: string;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    filled?: boolean;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
    /**
     * Thickness of the tick mark.
     *
     * __Default value:__  `1`
     */
    thickness?: number;
};

/**
 * Title configuration, which determines default properties for all [titles](title.html).
 * For a full list of title configuration options, please see the [corresponding section of
 * the title documentation](title.html#config).
 */
export type VGTitleConfig = {
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
    anchor?: Anchor;
    /**
     * Angle in degrees of title text.
     */
    angle?: number;
    /**
     * Vertical text baseline for title text.
     */
    baseline?: VerticalAlign;
    /**
     * Text color for title text.
     */
    color?: string;
    /**
     * Font name for title text.
     */
    font?: string;
    /**
     * Font size in pixels for title text.
     *
     * __Default value:__ `10`.
     */
    fontSize?: number;
    /**
     * Font weight for title text.
     */
    fontWeight?: FontWeightUnion;
    /**
     * The maximum allowed length in pixels of legend labels.
     */
    limit?: number;
    /**
     * Offset in pixels of the title from the chart body and axes.
     */
    offset?: number;
    /**
     * Default title orientation ("top", "bottom", "left", or "right")
     */
    orient?: TitleOrient;
};

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
export type Anchor =
      "start"
    | "middle"
    | "end";

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
export type TitleOrient =
      "top"
    | "bottom"
    | "left"
    | "right";

/**
 * Default properties for [single view plots](spec.html#single).
 */
export type ViewConfig = {
    /**
     * Whether the view should be clipped.
     */
    clip?: boolean;
    /**
     * The fill color.
     *
     * __Default value:__ (none)
     */
    fill?: string;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    fillOpacity?: number;
    /**
     * The default height of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
     *
     * __Default value:__ `200`
     */
    height?: number;
    /**
     * The stroke color.
     *
     * __Default value:__ (none)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     *
     * __Default value:__ (none)
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     *
     * __Default value:__ (none)
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     *
     * __Default value:__ (none)
     */
    strokeWidth?: number;
    /**
     * The default width of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
     * = `null`.
     *
     * __Default value:__ `200`
     */
    width?: number;
};

/**
 * An object describing the data source
 *
 * Secondary data source to lookup in.
 */
export type Data = {
    /**
     * An object that specifies the format for parsing the data file.
     *
     * An object that specifies the format for parsing the data values.
     *
     * An object that specifies the format for parsing the data.
     */
    format?: DataFormat;
    /**
     * An URL from which to load the data set. Use the `format.type` property
     * to ensure the loaded data is correctly parsed.
     */
    url?: string;
    /**
     * The full data set, included inline. This can be an array of objects or primitive values
     * or a string.
     * Arrays of primitive values are ingested as objects with a `data` property. Strings are
     * parsed according to the specified format type.
     */
    values?: Values;
    /**
     * Provide a placeholder name and bind data at runtime.
     */
    name?: string;
};

/**
 * An object that specifies the format for parsing the data file.
 *
 * An object that specifies the format for parsing the data values.
 *
 * An object that specifies the format for parsing the data.
 */
export type DataFormat = {
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
    parse?: ParseUnion;
    /**
     * Type of input data: `"json"`, `"csv"`, `"tsv"`.
     * The default format type is determined by the extension of the file URL.
     * If no extension is detected, `"json"` will be used by default.
     */
    type?: DataFormatType;
    /**
     * The JSON property containing the desired data.
     * This parameter can be used when the loaded JSON file may have surrounding structure or
     * meta-data.
     * For example `"property": "values.features"` is equivalent to retrieving
     * `json.values.features`
     * from the loaded JSON object.
     */
    property?: string;
    /**
     * The name of the TopoJSON object set to convert to a GeoJSON feature collection.
     * For example, in a map of the world, there may be an object set named `"countries"`.
     * Using the feature property, we can extract this set and generate a GeoJSON feature object
     * for each country.
     */
    feature?: string;
    /**
     * The name of the TopoJSON object set to convert to mesh.
     * Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
     * Unlike the `feature` option, the corresponding geo data is returned as a single, unified
     * mesh instance, not as individual GeoJSON features.
     * Extracting a mesh is useful for more efficiently drawing borders or other geographic
     * elements that you do not need to associate with specific regions such as individual
     * countries, states or counties.
     */
    mesh?: string;
};

export type ParseUnion = ParseEnum | { [key: string]: mixed };

export type ParseEnum =
      "auto";

/**
 * Type of input data: `"json"`, `"csv"`, `"tsv"`.
 * The default format type is determined by the extension of the file URL.
 * If no extension is detected, `"json"` will be used by default.
 */
export type DataFormatType =
      "csv"
    | "tsv"
    | "json"
    | "topojson";

/**
 * The full data set, included inline. This can be an array of objects or primitive values
 * or a string.
 * Arrays of primitive values are ingested as objects with a `data` property. Strings are
 * parsed according to the specified format type.
 */
export type Values = ValuesValue[] | { [key: string]: mixed } | string;

export type ValuesValue = boolean | number | { [key: string]: mixed } | string;

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
export type EncodingWithFacet = {
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
    color?: MarkPropDefWithCondition;
    /**
     * Horizontal facets for trellis plots.
     */
    column?: FacetFieldDef;
    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    detail?: Detail;
    /**
     * A URL to load upon mouse click.
     */
    href?: DefWithCondition;
    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    opacity?: MarkPropDefWithCondition;
    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    order?: Order;
    /**
     * Vertical facets for trellis plots.
     */
    row?: FacetFieldDef;
    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    shape?: MarkPropDefWithCondition;
    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    size?: MarkPropDefWithCondition;
    /**
     * Text of the `text` mark.
     */
    text?: TextDefWithCondition;
    /**
     * The tooltip text to show upon mouse hover.
     */
    tooltip?: TextDefWithCondition;
    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    x?: XClass;
    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    x2?: X2Class;
    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    y?: XClass;
    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    y2?: X2Class;
};

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
export type MarkPropDefWithCondition = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    condition?: ColorCondition;
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
    field?: Field;
    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    legend?: Legend | null;
    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    scale?: Scale;
    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    sort?: SortUnion;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
    /**
     * A constant value in visual domain.
     */
    value?: ConditionalValueDefValue;
};

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
export type AggregateOp =
      "argmax"
    | "argmin"
    | "average"
    | "count"
    | "distinct"
    | "max"
    | "mean"
    | "median"
    | "min"
    | "missing"
    | "q1"
    | "q3"
    | "ci0"
    | "ci1"
    | "stdev"
    | "stdevp"
    | "sum"
    | "valid"
    | "values"
    | "variance"
    | "variancep";

export type Bin = boolean | BinParams;

/**
 * Binning properties or boolean flag for determining whether to bin data or not.
 */
export type BinParams = {
    /**
     * The number base to use for automatic bin determination (default is base 10).
     *
     * __Default value:__ `10`
     */
    base?: number;
    /**
     * Scale factors indicating allowable subdivisions. The default value is [5, 2], which
     * indicates that for base 10 numbers (the default base), the method may consider dividing
     * bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
     * check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
     * given constraints.
     *
     * __Default value:__ `[5, 2]`
     */
    divide?: number[];
    /**
     * A two-element (`[min, max]`) array indicating the range of desired bin values.
     */
    extent?: number[];
    /**
     * Maximum number of bins.
     *
     * __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
     */
    maxbins?: number;
    /**
     * A minimum allowable step size (particularly useful for integer values).
     */
    minstep?: number;
    /**
     * If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
     * such as multiples of ten.
     */
    nice?: boolean;
    /**
     * An exact step size to use between bins.
     *
     * __Note:__ If provided, options such as maxbins will be ignored.
     */
    step?: number;
    /**
     * An array of allowable step sizes to choose from.
     */
    steps?: number[];
};

export type ColorCondition = ConditionalValueDef[] | ConditionalPredicateMarkPropFieldDefClass;

export type ConditionalValueDef = {
    test?: LogicalOperandPredicate;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value: ConditionalValueDefValue;
    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    selection?: SelectionOperand;
};

export type Selection = {
    not?: SelectionOperand;
    and?: SelectionOperand[];
    or?:  SelectionOperand[];
};

/**
 * Filter using a selection name.
 *
 * A [selection name](selection.html), or a series of [composed
 * selections](selection.html#compose).
 */
export type SelectionOperand = Selection | string;

export type Predicate = {
    not?: LogicalOperandPredicate;
    and?: LogicalOperandPredicate[];
    or?:  LogicalOperandPredicate[];
    /**
     * The value that the field should be equal to.
     */
    equal?: Equal;
    /**
     * Field to be filtered.
     *
     * Field to be filtered
     */
    field?: string;
    /**
     * Time unit for the field to be filtered.
     *
     * time unit for the field to be filtered.
     */
    timeUnit?: TimeUnit;
    /**
     * An array of inclusive minimum and maximum values
     * for a field value of a data item to be included in the filtered data.
     */
    range?: RangeElement[];
    /**
     * A set of values that the `field`'s value should be a member of,
     * for a data item included in the filtered data.
     */
    oneOf?: Equal[];
    /**
     * Filter using a selection name.
     */
    selection?: SelectionOperand;
};

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
export type LogicalOperandPredicate = Predicate | string;

/**
 * The value that the field should be equal to.
 */
export type Equal = boolean | DateTime | number | string;

/**
 * Object for defining datetime in Vega-Lite Filter.
 * If both month and quarter are provided, month has higher precedence.
 * `day` cannot be combined with other date.
 * We accept string for month and day names.
 */
export type DateTime = {
    /**
     * Integer value representing the date from 1-31.
     */
    date?: number;
    /**
     * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
     * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
     * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
     * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
     * `month`, or `date`.
     */
    day?: Day;
    /**
     * Integer value representing the hour of a day from 0-23.
     */
    hours?: number;
    /**
     * Integer value representing the millisecond segment of time.
     */
    milliseconds?: number;
    /**
     * Integer value representing the minute segment of time from 0-59.
     */
    minutes?: number;
    /**
     * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
     * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
     * short month name (e.g., `"Jan"`).
     */
    month?: Month;
    /**
     * Integer value representing the quarter of the year (from 1-4).
     */
    quarter?: number;
    /**
     * Integer value representing the second segment (0-59) of a time value
     */
    seconds?: number;
    /**
     * A boolean flag indicating if date time is in utc time. If false, the date time is in
     * local time
     */
    utc?: boolean;
    /**
     * Integer value representing the year.
     */
    year?: number;
};

/**
 * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
 * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
 * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
 * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
 * `month`, or `date`.
 */
export type Day = number | string;

/**
 * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
 * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
 * short month name (e.g., `"Jan"`).
 */
export type Month = number | string;

export type RangeElement = DateTime | number | null;

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
export type TimeUnit =
      "year"
    | "quarter"
    | "month"
    | "day"
    | "date"
    | "hours"
    | "minutes"
    | "seconds"
    | "milliseconds"
    | "utcyear"
    | "utcquarter"
    | "utcmonth"
    | "utcday"
    | "utcdate"
    | "utchours"
    | "utcminutes"
    | "utcseconds"
    | "utcmilliseconds"
    | "yearquarter"
    | "yearquartermonth"
    | "yearmonth"
    | "yearmonthdate"
    | "yearmonthdatehours"
    | "yearmonthdatehoursminutes"
    | "yearmonthdatehoursminutesseconds"
    | "quartermonth"
    | "monthdate"
    | "hoursminutes"
    | "hoursminutesseconds"
    | "minutesseconds"
    | "secondsmilliseconds"
    | "utcyearquarter"
    | "utcyearquartermonth"
    | "utcyearmonth"
    | "utcyearmonthdate"
    | "utcyearmonthdatehours"
    | "utcyearmonthdatehoursminutes"
    | "utcyearmonthdatehoursminutesseconds"
    | "utcquartermonth"
    | "utcmonthdate"
    | "utchoursminutes"
    | "utchoursminutesseconds"
    | "utcminutesseconds"
    | "utcsecondsmilliseconds";

/**
 * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
 * `0` to `1` for opacity).
 *
 * A constant value in visual domain.
 */
export type ConditionalValueDefValue = boolean | number | string;

export type ConditionalPredicateMarkPropFieldDefClass = {
    test?: LogicalOperandPredicate;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value?: ConditionalValueDefValue;
    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    selection?: SelectionOperand;
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    legend?: Legend | null;
    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    scale?: Scale;
    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    sort?: SortUnion;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
};

export type Field = RepeatRef | string;

/**
 * Reference to a repeated value.
 */
export type RepeatRef = {
    repeat: RepeatEnum;
};

export type RepeatEnum =
      "row"
    | "column";

/**
 * Properties of a legend or boolean flag for determining whether to show it.
 */
export type Legend = {
    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    entryPadding?: number;
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
    format?: string;
    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    offset?: number;
    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    orient?: LegendOrient;
    /**
     * The padding, in pixels, between the legend and axis.
     */
    padding?: number;
    /**
     * The desired number of tick values for quantitative legends.
     */
    tickCount?: number;
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
    title?: null | string;
    /**
     * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
     * continuous color gradient.
     *
     * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
     * `"symbol"` otherwise.
     */
    type?: LegendType;
    /**
     * Explicitly set the visible legend values.
     */
    values?: LegendValue[];
    /**
     * A non-positive integer indicating z-index of the legend.
     * If zindex is 0, legend should be drawn behind all chart elements.
     * To put them in front, use zindex = 1.
     */
    zindex?: number;
};

/**
 * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
 * continuous color gradient.
 *
 * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
 * `"symbol"` otherwise.
 */
export type LegendType =
      "symbol"
    | "gradient";

export type LegendValue = DateTime | number | string;

/**
 * An object defining properties of the channel's scale, which is the function that
 * transforms values in the data domain (numbers, dates, strings, etc) to visual values
 * (pixels, colors, sizes) of the encoding channels.
 *
 * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
 */
export type Scale = {
    /**
     * The logarithm base of the `log` scale (default `10`).
     */
    base?: number;
    /**
     * If `true`, values that exceed the data domain are clamped to either the minimum or
     * maximum range value
     *
     * __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
     * (`true` by default).
     */
    clamp?: boolean;
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
    domain?: DomainUnion;
    /**
     * The exponent of the `pow` scale.
     */
    exponent?: number;
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
    interpolate?: InterpolateUnion;
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
    nice?: NiceUnion;
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
    padding?: number;
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
    paddingInner?: number;
    /**
     * The outer padding (spacing) at the ends of the range of band and point scales,
     * as a fraction of the step size. This value must lie in the range [0,1].
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingOuter` for band scales and `pointPadding` for point scales.
     */
    paddingOuter?: number;
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
    range?: ScaleRange;
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
    rangeStep?: number | null;
    /**
     * If `true`, rounds numeric output values to integers. This can be helpful for snapping to
     * the pixel grid.
     *
     * __Default value:__ `false`.
     */
    round?: boolean;
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
    scheme?: Scheme;
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
    type?: ScaleType;
    /**
     * If `true`, ensures that a zero baseline value is included in the scale domain.
     *
     * __Default value:__ `true` for x and y channels if the quantitative field is not binned
     * and no custom `domain` is provided; `false` otherwise.
     *
     * __Note:__ Log, time, and utc scales do not support `zero`.
     */
    zero?: boolean;
};

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
export type DomainUnion = Equal[] | DomainClass | Domain;

export type DomainClass = {
    /**
     * The field name to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    field?: string;
    /**
     * The name of a selection.
     */
    selection: string;
    /**
     * The encoding channel to extract selected values for, when a selection is
     * [projected](project.html)
     * over multiple fields or encodings.
     */
    encoding?: string;
};

export type Domain =
      "unaggregated";

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
export type InterpolateUnion = InterpolateParams | Interpolate;

export type InterpolateParams = {
    gamma?: number;
    type:   InterpolateParamsType;
};

export type InterpolateParamsType =
      "rgb"
    | "cubehelix"
    | "cubehelix-long";

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
export type NiceUnion = boolean | NiceClass | number | NiceTime;

export type NiceClass = {
    interval: string;
    step:     number;
};

export type NiceTime =
      "second"
    | "minute"
    | "hour"
    | "day"
    | "week"
    | "month"
    | "year";

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
export type ScaleRange = TitleFontWeight[] | string;

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
export type Scheme = SchemeParams | string;

export type SchemeParams = {
    /**
     * For sequential and diverging schemes only, determines the extent of the color range to
     * use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
     * range _[0, 0.2)_ are excluded from the scheme.
     */
    extent?: number[];
    /**
     * A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    name: string;
};

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
export type ScaleType =
      "linear"
    | "bin-linear"
    | "log"
    | "pow"
    | "sqrt"
    | "time"
    | "utc"
    | "sequential"
    | "ordinal"
    | "bin-ordinal"
    | "point"
    | "band";

export type SortUnion = SortField | SortEnum | null;

export type SortField = {
    /**
     * The data [field](field.html) to sort by.
     *
     * __Default value:__ If unspecified, defaults to the field specified in the outer data
     * reference.
     */
    field?: Field;
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
    op: AggregateOp;
    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    order?: SortEnum | null;
};

export type SortEnum =
      "ascending"
    | "descending";

/**
 * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
 * `"nominal"`).
 * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
 * [geographic projection](projection.html) is applied.
 *
 * Constants and utilities for data type
 * Data type based on level of measurement
 */
export type Type =
      "quantitative"
    | "ordinal"
    | "temporal"
    | "nominal"
    | "latitude"
    | "longitude"
    | "geojson";

/**
 * Horizontal facets for trellis plots.
 *
 * Vertical facets for trellis plots.
 */
export type FacetFieldDef = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * An object defining properties of a facet's header.
     */
    header?: Header;
    /**
     * Sort order for a facet field.
     * This can be `"ascending"`, `"descending"`.
     */
    sort?: SortEnum | null;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type: Type;
};

/**
 * An object defining properties of a facet's header.
 *
 * Headers of row / column channels for faceted plots.
 */
export type Header = {
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
    format?: string;
    /**
     * The rotation angle of the header labels.
     *
     * __Default value:__ `0`.
     */
    labelAngle?: number;
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
    title?: null | string;
};

export type Detail = FieldDef[] | FieldDef;

/**
 * Definition object for a data field, its type and transformation of an encoding channel.
 */
export type FieldDef = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type: Type;
};

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
export type DefWithCondition = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    condition?: HrefCondition;
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
    field?: Field;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
    /**
     * A constant value in visual domain.
     */
    value?: ConditionalValueDefValue;
};

export type HrefCondition = ConditionalValueDef[] | ConditionalPredicateFieldDefClass;

export type ConditionalPredicateFieldDefClass = {
    test?: LogicalOperandPredicate;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value?: ConditionalValueDefValue;
    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    selection?: SelectionOperand;
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
};

export type Order = OrderFieldDef[] | OrderFieldDef;

export type OrderFieldDef = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    sort?: SortEnum | null;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type: Type;
};

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
export type TextDefWithCondition = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
    /**
     * One or more value definition(s) with a selection predicate.
     *
     * __Note:__ A field definition's `condition` property can only contain [value
     * definitions](encoding.html#value-def)
     * since Vega-Lite only allows at most one encoded field per encoding channel.
     *
     * A field definition or one or more value definition(s) with a selection predicate.
     */
    condition?: TextCondition;
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
    field?: Field;
    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    format?: string;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
    /**
     * A constant value in visual domain.
     */
    value?: ConditionalValueDefValue;
};

export type TextCondition = ConditionalValueDef[] | ConditionalPredicateTextFieldDefClass;

export type ConditionalPredicateTextFieldDefClass = {
    test?: LogicalOperandPredicate;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value?: ConditionalValueDefValue;
    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    selection?: SelectionOperand;
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    format?: string;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
};

/**
 * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
 *
 * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
 *
 * Definition object for a constant value of an encoding channel.
 */
export type XClass = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * An object defining properties of axis's gridlines, ticks and labels.
     * If `null`, the axis for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [axis properties](axis.html) are applied.
     */
    axis?: Axis | null;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    scale?: Scale;
    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    sort?: SortUnion;
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
    stack?: StackOffset | null;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value?: ConditionalValueDefValue;
};

export type Axis = {
    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    domain?: boolean;
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
    format?: string;
    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    grid?: boolean;
    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    labelAngle?: number;
    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    labelBound?: Label;
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
    labelFlush?: Label;
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
    labelOverlap?: LabelOverlapUnion;
    /**
     * The padding, in pixels, between axis and text labels.
     */
    labelPadding?: number;
    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    labels?: boolean;
    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    maxExtent?: number;
    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    minExtent?: number;
    /**
     * The offset, in pixels, by which to displace the axis from the edge of the enclosing group
     * or data rectangle.
     *
     * __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
     * `offset` (`0` by default)
     */
    offset?: number;
    /**
     * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
     * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
     * the right edge of the chart).
     *
     * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
     */
    orient?: TitleOrient;
    /**
     * The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
     * this sets the axis group x coordinate. For y-axis with left or right orientation, this
     * sets the axis group y coordinate.
     *
     * __Default value__: `0`
     */
    position?: number;
    /**
     * A desired number of ticks, for axes visualizing quantitative scales. The resulting number
     * may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
     * underlying scale's range.
     */
    tickCount?: number;
    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    ticks?: boolean;
    /**
     * The size in pixels of axis ticks.
     */
    tickSize?: number;
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
    title?: null | string;
    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    titleMaxLength?: number;
    /**
     * The padding, in pixels, between title and axis.
     */
    titlePadding?: number;
    /**
     * Explicitly set the visible axis tick values.
     */
    values?: AxisValue[];
    /**
     * A non-positive integer indicating z-index of the axis.
     * If zindex is 0, axes should be drawn behind all chart elements.
     * To put them in front, use `"zindex = 1"`.
     *
     * __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
     * for grids.
     */
    zindex?: number;
};

export type AxisValue = DateTime | number;

/**
 * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
 *
 * Definition object for a data field, its type and transformation of an encoding channel.
 *
 * Definition object for a constant value of an encoding channel.
 */
export type X2Class = {
    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    aggregate?: AggregateOp;
    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    bin?: Bin;
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
    field?: Field;
    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    timeUnit?: TimeUnit;
    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    type?: Type;
    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    value?: ConditionalValueDefValue;
};

/**
 * An object that describes mappings between `row` and `column` channels and their field
 * definitions.
 */
export type FacetMapping = {
    /**
     * Horizontal facets for trellis plots.
     */
    column?: FacetFieldDef;
    /**
     * Vertical facets for trellis plots.
     */
    row?: FacetFieldDef;
};

/**
 * Unit spec that can have a composite mark.
 */
export type Spec = {
    /**
     * An object describing the data source
     */
    data?: Data;
    /**
     * Description of this mark for commenting purpose.
     */
    description?: string;
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
    height?: number;
    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    layer?: LayerSpec[];
    /**
     * Name of the visualization for later reference.
     */
    name?: string;
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
    resolve?: Resolve;
    /**
     * Title for the plot.
     */
    title?: Title;
    /**
     * An array of data transformations such as filter and new field calculation.
     */
    transform?: Transform[];
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
    width?: number;
    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    encoding?: Encoding;
    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    mark?: AnyMark;
    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    projection?: Projection;
    /**
     * A key-value mapping between selection names and definitions.
     */
    selection?: { [key: string]: SelectionDef };
    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    facet?: FacetMapping;
    /**
     * A specification of the view that gets faceted.
     */
    spec?: Spec;
    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    repeat?: Repeat;
    /**
     * A list of views that should be concatenated and put into a column.
     */
    vconcat?: Spec[];
    /**
     * A list of views that should be concatenated and put into a row.
     */
    hconcat?: Spec[];
};

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
export type Encoding = {
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
    color?: MarkPropDefWithCondition;
    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    detail?: Detail;
    /**
     * A URL to load upon mouse click.
     */
    href?: DefWithCondition;
    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    opacity?: MarkPropDefWithCondition;
    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    order?: Order;
    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    shape?: MarkPropDefWithCondition;
    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    size?: MarkPropDefWithCondition;
    /**
     * Text of the `text` mark.
     */
    text?: TextDefWithCondition;
    /**
     * The tooltip text to show upon mouse hover.
     */
    tooltip?: TextDefWithCondition;
    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    x?: XClass;
    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    x2?: X2Class;
    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    y?: XClass;
    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    y2?: X2Class;
};

/**
 * Unit spec that can have a composite mark.
 */
export type LayerSpec = {
    /**
     * An object describing the data source
     */
    data?: Data;
    /**
     * Description of this mark for commenting purpose.
     */
    description?: string;
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
    height?: number;
    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    layer?: LayerSpec[];
    /**
     * Name of the visualization for later reference.
     */
    name?: string;
    /**
     * Scale, axis, and legend resolutions for layers.
     */
    resolve?: Resolve;
    /**
     * Title for the plot.
     */
    title?: Title;
    /**
     * An array of data transformations such as filter and new field calculation.
     */
    transform?: Transform[];
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
    width?: number;
    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    encoding?: Encoding;
    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    mark?: AnyMark;
    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    projection?: Projection;
    /**
     * A key-value mapping between selection names and definitions.
     */
    selection?: { [key: string]: SelectionDef };
};

/**
 * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
 * `"line"`,
 * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
 * object](mark.html#mark-def).
 */
export type AnyMark = MarkDef | Mark;

export type MarkDef = {
    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    align?: HorizontalAlign;
    /**
     * The rotation angle of the text, in degrees.
     */
    angle?: number;
    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    baseline?: VerticalAlign;
    /**
     * Whether a mark be clipped to the enclosing group’s width and height.
     */
    clip?: boolean;
    /**
     * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
     * will override `color`.
     *
     * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    color?: string;
    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    cursor?: Cursor;
    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dx?: number;
    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    dy?: number;
    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    fill?: string;
    /**
     * Whether the mark's color should be used as fill color instead of stroke color.
     *
     * __Default value:__ `true` for all marks except `point` and `false` for `point`.
     *
     * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
     *
     * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
     */
    filled?: boolean;
    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    fillOpacity?: number;
    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    font?: string;
    /**
     * The font size, in pixels.
     */
    fontSize?: number;
    /**
     * The font style (e.g., `"italic"`).
     */
    fontStyle?: FontStyle;
    /**
     * The font weight (e.g., `"bold"`).
     */
    fontWeight?: FontWeightUnion;
    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    href?: string;
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
    interpolate?: Interpolate;
    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    limit?: number;
    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    opacity?: number;
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
    orient?: Orient;
    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    radius?: number;
    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    shape?: string;
    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    size?: number;
    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    stroke?: string;
    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    strokeDash?: number[];
    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    strokeDashOffset?: number;
    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    strokeOpacity?: number;
    /**
     * The stroke width, in pixels.
     */
    strokeWidth?: number;
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
    style?: Style;
    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    tension?: number;
    /**
     * Placeholder text if the `text` channel is not specified
     */
    text?: string;
    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    theta?: number;
    /**
     * The mark type.
     * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
     * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
     */
    type: Mark;
};

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
export type Style = string[] | string;

/**
 * All types of primitive marks.
 *
 * The mark type.
 * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
 * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
 */
export type Mark =
      "area"
    | "bar"
    | "line"
    | "point"
    | "text"
    | "tick"
    | "rect"
    | "rule"
    | "circle"
    | "square"
    | "geoshape";

/**
 * An object defining properties of geographic projection.
 *
 * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
 * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
 */
export type Projection = {
    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    center?: number[];
    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    clipAngle?: number;
    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    clipExtent?:  Array<number[]>;
    coefficient?: number;
    distance?:    number;
    fraction?:    number;
    lobes?:       number;
    parallel?:    number;
    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    precision?: FluffyPrecision;
    radius?:    number;
    ratio?:     number;
    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    rotate?:  number[];
    spacing?: number;
    tilt?:    number;
    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    type?: VGProjectionType;
};

/**
 * Sets the threshold for the projection’s [adaptive
 * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
 * value corresponds to the [Douglas–Peucker
 * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
 * If precision is not specified, returns the projection’s current resampling precision
 * which defaults to `√0.5 ≅ 0.70710…`.
 */
export type FluffyPrecision = {
    /**
     * Returns the length of a String object.
     */
    length: number;
    [property: string]: string | number;
};

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
export type Resolve = {
    axis?:   AxisResolveMap;
    legend?: LegendResolveMap;
    scale?:  ScaleResolveMap;
};

export type AxisResolveMap = {
    x?: ResolveMode;
    y?: ResolveMode;
};

export type ResolveMode =
      "independent"
    | "shared";

export type LegendResolveMap = {
    color?:   ResolveMode;
    opacity?: ResolveMode;
    shape?:   ResolveMode;
    size?:    ResolveMode;
};

export type ScaleResolveMap = {
    color?:   ResolveMode;
    opacity?: ResolveMode;
    shape?:   ResolveMode;
    size?:    ResolveMode;
    x?:       ResolveMode;
    y?:       ResolveMode;
};

export type SelectionDef = {
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
    bind?: BindUnion;
    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    empty?: Empty;
    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    encodings?: SingleDefChannel[];
    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    fields?: string[];
    /**
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    nearest?: boolean;
    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    on?: mixed;
    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    resolve?: SelectionResolution;
    type:     SelectionDefType;
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
    toggle?: Translate;
    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    mark?: BrushConfig;
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
    translate?: Translate;
    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    zoom?: Translate;
};

export type BindUnion = BindEnum | { [key: string]: VGBinding };

export type SelectionDefType =
      "single"
    | "multi"
    | "interval";

export type Title = TitleParams | string;

export type TitleParams = {
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
    anchor?: Anchor;
    /**
     * The orthogonal offset in pixels by which to displace the title from its position along
     * the edge of the chart.
     */
    offset?: number;
    /**
     * The orientation of the title relative to the chart. One of `"top"` (the default),
     * `"bottom"`, `"left"`, or `"right"`.
     */
    orient?: TitleOrient;
    /**
     * A [mark style property](config.html#style) to apply to the title text mark.
     *
     * __Default value:__ `"group-title"`.
     */
    style?: Style;
    /**
     * The title text.
     */
    text: string;
};

export type Transform = {
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
    filter?: LogicalOperandPredicate;
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
    as?: Style;
    /**
     * A [expression](types.html#expression) string. Use the variable `datum` to refer to the
     * current data object.
     */
    calculate?: string;
    /**
     * The default value to use if lookup fails.
     *
     * __Default value:__ `null`
     */
    default?: string;
    /**
     * Secondary data reference.
     */
    from?: LookupData;
    /**
     * Key in primary data source.
     */
    lookup?: string;
    /**
     * An object indicating bin properties, or simply `true` for using default bin parameters.
     */
    bin?: Bin;
    /**
     * The data field to bin.
     *
     * The data field to apply time unit.
     */
    field?: string;
    /**
     * The timeUnit.
     */
    timeUnit?: TimeUnit;
    /**
     * Array of objects that define fields to aggregate.
     */
    aggregate?: AggregatedFieldDef[];
    /**
     * The data fields to group by. If not specified, a single group containing all data objects
     * will be used.
     */
    groupby?: string[];
};

export type AggregatedFieldDef = {
    /**
     * The output field names to use for each aggregated field.
     */
    as: string;
    /**
     * The data field for which to compute aggregate function.
     */
    field: string;
    /**
     * The aggregation operations to apply to the fields, such as sum, average or count.
     * See the [full list of supported aggregation
     * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
     * for more information.
     */
    op: AggregateOp;
};

/**
 * Secondary data reference.
 */
export type LookupData = {
    /**
     * Secondary data source to lookup in.
     */
    data: Data;
    /**
     * Fields in foreign data to lookup.
     * If not specified, the entire object is queried.
     */
    fields?: string[];
    /**
     * Key in data to lookup.
     */
    key: string;
};

/**
 * An object that describes what fields should be repeated into views that are laid out as a
 * `row` or `column`.
 */
export type Repeat = {
    /**
     * Horizontal repeated views.
     */
    column?: string[];
    /**
     * Vertical repeated views.
     */
    row?: string[];
};

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json: string): TopLevel {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value: TopLevel): string {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ: any, val: any, key: any, parent: any = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ: any): string {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ: any): any {
    if (typ.jsonToJS === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
    if (typ.jsToJSON === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val: any, typ: any, getProps: any, key: any = '', parent: any = ''): any {
    function transformPrimitive(typ: string, val: any): any {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs: any[], val: any): any {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases: string[], val: any): any {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ: any, val: any): any {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);
        if ((typ.min !== undefined && val.length < typ.min) || (typ.max !== undefined && val.length > typ.max)) return invalidValue(l("array"), val, key, parent);
        return val.map(el => transform(el, typ.arrayItems, getProps));
    }

    function transformDate(val: any): any {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result: any = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref: any = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
    return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
    return transform(val, typ, jsToJSONProps);
}

function l(typ: any) {
    return { literal: typ };
}

function a(typ: any, min: any = undefined, max: any = undefined) {
    return { arrayItems: typ, min, max };
}

function i(typ: any) {
    return { integer: typ };
}

function p(pattern: any) {
    return { pattern };
}

function s(typ: any, min: any, max: any) {
    return { string: typ, min, max };
}

function n(typ: any, min: any, max: any) {
    return { number: typ, min, max };
}

function u(...typs: any[]) {
    return { unionMembers: typs };
}

function o(props: any[], additional: any) {
    return { props, additional };
}

function m(additional: any) {
    const props: any[] = [];
    return { props, additional };
}

function r(name: string) {
    return { ref: name };
}

const typeMap: any = {
    "TopLevel": o([
        { json: "$schema", js: "$schema", typ: u(undefined, "") },
        { json: "autosize", js: "autosize", typ: u(undefined, u(r("AutoSizeParams"), r("AutosizeType"))) },
        { json: "background", js: "background", typ: u(undefined, "") },
        { json: "config", js: "config", typ: u(undefined, r("Config")) },
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "encoding", js: "encoding", typ: u(undefined, r("EncodingWithFacet")) },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "padding", js: "padding", typ: u(undefined, u(r("PaddingClass"), 3.14)) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "facet", js: "facet", typ: u(undefined, r("FacetMapping")) },
        { json: "spec", js: "spec", typ: u(undefined, r("Spec")) },
        { json: "repeat", js: "repeat", typ: u(undefined, r("Repeat")) },
        { json: "vconcat", js: "vconcat", typ: u(undefined, a(r("Spec"))) },
        { json: "hconcat", js: "hconcat", typ: u(undefined, a(r("Spec"))) },
    ], false),
    "AutoSizeParams": o([
        { json: "contains", js: "contains", typ: u(undefined, r("Contains")) },
        { json: "resize", js: "resize", typ: u(undefined, true) },
        { json: "type", js: "type", typ: u(undefined, r("AutosizeType")) },
    ], false),
    "Config": o([
        { json: "area", js: "area", typ: u(undefined, r("MarkConfig")) },
        { json: "autosize", js: "autosize", typ: u(undefined, u(r("AutoSizeParams"), r("AutosizeType"))) },
        { json: "axis", js: "axis", typ: u(undefined, r("AxisConfig")) },
        { json: "axisBand", js: "axisBand", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisBottom", js: "axisBottom", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisLeft", js: "axisLeft", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisRight", js: "axisRight", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisTop", js: "axisTop", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisX", js: "axisX", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisY", js: "axisY", typ: u(undefined, r("VGAxisConfig")) },
        { json: "background", js: "background", typ: u(undefined, "") },
        { json: "bar", js: "bar", typ: u(undefined, r("BarConfig")) },
        { json: "circle", js: "circle", typ: u(undefined, r("MarkConfig")) },
        { json: "countTitle", js: "countTitle", typ: u(undefined, "") },
        { json: "fieldTitle", js: "fieldTitle", typ: u(undefined, r("FieldTitle")) },
        { json: "geoshape", js: "geoshape", typ: u(undefined, r("MarkConfig")) },
        { json: "invalidValues", js: "invalidValues", typ: u(undefined, r("InvalidValues")) },
        { json: "legend", js: "legend", typ: u(undefined, r("LegendConfig")) },
        { json: "line", js: "line", typ: u(undefined, r("MarkConfig")) },
        { json: "mark", js: "mark", typ: u(undefined, r("MarkConfig")) },
        { json: "numberFormat", js: "numberFormat", typ: u(undefined, "") },
        { json: "padding", js: "padding", typ: u(undefined, u(r("PaddingClass"), 3.14)) },
        { json: "point", js: "point", typ: u(undefined, r("MarkConfig")) },
        { json: "projection", js: "projection", typ: u(undefined, r("ProjectionConfig")) },
        { json: "range", js: "range", typ: u(undefined, r("RangeConfig")) },
        { json: "rect", js: "rect", typ: u(undefined, r("MarkConfig")) },
        { json: "rule", js: "rule", typ: u(undefined, r("MarkConfig")) },
        { json: "scale", js: "scale", typ: u(undefined, r("ScaleConfig")) },
        { json: "selection", js: "selection", typ: u(undefined, r("SelectionConfig")) },
        { json: "square", js: "square", typ: u(undefined, r("MarkConfig")) },
        { json: "stack", js: "stack", typ: u(undefined, r("StackOffset")) },
        { json: "style", js: "style", typ: u(undefined, m(r("VGMarkConfig"))) },
        { json: "text", js: "text", typ: u(undefined, r("TextConfig")) },
        { json: "tick", js: "tick", typ: u(undefined, r("TickConfig")) },
        { json: "timeFormat", js: "timeFormat", typ: u(undefined, "") },
        { json: "title", js: "title", typ: u(undefined, r("VGTitleConfig")) },
        { json: "view", js: "view", typ: u(undefined, r("ViewConfig")) },
    ], false),
    "MarkConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "AxisConfig": o([
        { json: "bandPosition", js: "bandPosition", typ: u(undefined, 3.14) },
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "domainColor", js: "domainColor", typ: u(undefined, "") },
        { json: "domainWidth", js: "domainWidth", typ: u(undefined, 3.14) },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "gridColor", js: "gridColor", typ: u(undefined, "") },
        { json: "gridDash", js: "gridDash", typ: u(undefined, a(3.14)) },
        { json: "gridOpacity", js: "gridOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "gridWidth", js: "gridWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "tickColor", js: "tickColor", typ: u(undefined, "") },
        { json: "tickRound", js: "tickRound", typ: u(undefined, true) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tickWidth", js: "tickWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleAngle", js: "titleAngle", typ: u(undefined, 3.14) },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "titleX", js: "titleX", typ: u(undefined, 3.14) },
        { json: "titleY", js: "titleY", typ: u(undefined, 3.14) },
    ], false),
    "VGAxisConfig": o([
        { json: "bandPosition", js: "bandPosition", typ: u(undefined, 3.14) },
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "domainColor", js: "domainColor", typ: u(undefined, "") },
        { json: "domainWidth", js: "domainWidth", typ: u(undefined, 3.14) },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "gridColor", js: "gridColor", typ: u(undefined, "") },
        { json: "gridDash", js: "gridDash", typ: u(undefined, a(3.14)) },
        { json: "gridOpacity", js: "gridOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "gridWidth", js: "gridWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "tickColor", js: "tickColor", typ: u(undefined, "") },
        { json: "tickRound", js: "tickRound", typ: u(undefined, true) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tickWidth", js: "tickWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleAngle", js: "titleAngle", typ: u(undefined, 3.14) },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "titleX", js: "titleX", typ: u(undefined, 3.14) },
        { json: "titleY", js: "titleY", typ: u(undefined, 3.14) },
    ], false),
    "BarConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "binSpacing", js: "binSpacing", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "continuousBandSize", js: "continuousBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "discreteBandSize", js: "discreteBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "LegendConfig": o([
        { json: "cornerRadius", js: "cornerRadius", typ: u(undefined, 3.14) },
        { json: "entryPadding", js: "entryPadding", typ: u(undefined, 3.14) },
        { json: "fillColor", js: "fillColor", typ: u(undefined, "") },
        { json: "gradientHeight", js: "gradientHeight", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "gradientLabelBaseline", js: "gradientLabelBaseline", typ: u(undefined, "") },
        { json: "gradientLabelLimit", js: "gradientLabelLimit", typ: u(undefined, 3.14) },
        { json: "gradientLabelOffset", js: "gradientLabelOffset", typ: u(undefined, 3.14) },
        { json: "gradientStrokeColor", js: "gradientStrokeColor", typ: u(undefined, "") },
        { json: "gradientStrokeWidth", js: "gradientStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "gradientWidth", js: "gradientWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAlign", js: "labelAlign", typ: u(undefined, "") },
        { json: "labelBaseline", js: "labelBaseline", typ: u(undefined, "") },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOffset", js: "labelOffset", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("LegendOrient")) },
        { json: "padding", js: "padding", typ: u(undefined, 3.14) },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "strokeColor", js: "strokeColor", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
        { json: "symbolColor", js: "symbolColor", typ: u(undefined, "") },
        { json: "symbolSize", js: "symbolSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "symbolStrokeWidth", js: "symbolStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "symbolType", js: "symbolType", typ: u(undefined, "") },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, 3.14) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
    ], false),
    "PaddingClass": o([
        { json: "bottom", js: "bottom", typ: u(undefined, 3.14) },
        { json: "left", js: "left", typ: u(undefined, 3.14) },
        { json: "right", js: "right", typ: u(undefined, 3.14) },
        { json: "top", js: "top", typ: u(undefined, 3.14) },
    ], false),
    "ProjectionConfig": o([
        { json: "center", js: "center", typ: u(undefined, a(3.14)) },
        { json: "clipAngle", js: "clipAngle", typ: u(undefined, 3.14) },
        { json: "clipExtent", js: "clipExtent", typ: u(undefined, a(a(3.14))) },
        { json: "coefficient", js: "coefficient", typ: u(undefined, 3.14) },
        { json: "distance", js: "distance", typ: u(undefined, 3.14) },
        { json: "fraction", js: "fraction", typ: u(undefined, 3.14) },
        { json: "lobes", js: "lobes", typ: u(undefined, 3.14) },
        { json: "parallel", js: "parallel", typ: u(undefined, 3.14) },
        { json: "precision", js: "precision", typ: u(undefined, r("PurplePrecision")) },
        { json: "radius", js: "radius", typ: u(undefined, 3.14) },
        { json: "ratio", js: "ratio", typ: u(undefined, 3.14) },
        { json: "rotate", js: "rotate", typ: u(undefined, a(3.14)) },
        { json: "spacing", js: "spacing", typ: u(undefined, 3.14) },
        { json: "tilt", js: "tilt", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: u(undefined, r("VGProjectionType")) },
    ], false),
    "PurplePrecision": o([
        { json: "length", js: "length", typ: 3.14 },
    ], ""),
    "RangeConfig": o([
        { json: "category", js: "category", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "diverging", js: "diverging", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "heatmap", js: "heatmap", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "ordinal", js: "ordinal", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "ramp", js: "ramp", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "symbol", js: "symbol", typ: u(undefined, a("")) },
    ], u(a(u(3.14, "")), r("RangeConfigValueVGScheme"))),
    "CategoryVGScheme": o([
        { json: "count", js: "count", typ: u(undefined, 3.14) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "scheme", js: "scheme", typ: "" },
    ], false),
    "RangeConfigValueVGScheme": o([
        { json: "count", js: "count", typ: u(undefined, 3.14) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "scheme", js: "scheme", typ: u(undefined, "") },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
    ], false),
    "ScaleConfig": o([
        { json: "bandPaddingInner", js: "bandPaddingInner", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "bandPaddingOuter", js: "bandPaddingOuter", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "clamp", js: "clamp", typ: u(undefined, true) },
        { json: "continuousPadding", js: "continuousPadding", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxBandSize", js: "maxBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxFontSize", js: "maxFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxOpacity", js: "maxOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "maxSize", js: "maxSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxStrokeWidth", js: "maxStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minBandSize", js: "minBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minFontSize", js: "minFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minOpacity", js: "minOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "minSize", js: "minSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minStrokeWidth", js: "minStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "pointPadding", js: "pointPadding", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "rangeStep", js: "rangeStep", typ: u(undefined, u(n(3.14, 0, undefined), null)) },
        { json: "round", js: "round", typ: u(undefined, true) },
        { json: "textXRangeStep", js: "textXRangeStep", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "useUnaggregatedDomain", js: "useUnaggregatedDomain", typ: u(undefined, true) },
    ], false),
    "SelectionConfig": o([
        { json: "interval", js: "interval", typ: u(undefined, r("IntervalSelectionConfig")) },
        { json: "multi", js: "multi", typ: u(undefined, r("MultiSelectionConfig")) },
        { json: "single", js: "single", typ: u(undefined, r("SingleSelectionConfig")) },
    ], false),
    "IntervalSelectionConfig": o([
        { json: "bind", js: "bind", typ: u(undefined, r("BindEnum")) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "mark", js: "mark", typ: u(undefined, r("BrushConfig")) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "translate", js: "translate", typ: u(undefined, u(true, "")) },
        { json: "zoom", js: "zoom", typ: u(undefined, u(true, "")) },
    ], false),
    "BrushConfig": o([
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, 3.14) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, 3.14) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
    ], false),
    "MultiSelectionConfig": o([
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "toggle", js: "toggle", typ: u(undefined, u(true, "")) },
    ], false),
    "SingleSelectionConfig": o([
        { json: "bind", js: "bind", typ: u(undefined, m(r("VGBinding"))) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
    ], false),
    "VGBinding": o([
        { json: "element", js: "element", typ: u(undefined, "") },
        { json: "input", js: "input", typ: "" },
        { json: "options", js: "options", typ: u(undefined, a("")) },
        { json: "max", js: "max", typ: u(undefined, 3.14) },
        { json: "min", js: "min", typ: u(undefined, 3.14) },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
    ], false),
    "VGMarkConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "TextConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "TickConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "bandSize", js: "bandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
        { json: "thickness", js: "thickness", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "VGTitleConfig": o([
        { json: "anchor", js: "anchor", typ: u(undefined, r("Anchor")) },
        { json: "angle", js: "angle", typ: u(undefined, 3.14) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "limit", js: "limit", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
    ], false),
    "ViewConfig": o([
        { json: "clip", js: "clip", typ: u(undefined, true) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, 3.14) },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, 3.14) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
    ], false),
    "Data": o([
        { json: "format", js: "format", typ: u(undefined, r("DataFormat")) },
        { json: "url", js: "url", typ: u(undefined, "") },
        { json: "values", js: "values", typ: u(undefined, u(a(u(true, 3.14, m("any"), "")), m("any"), "")) },
        { json: "name", js: "name", typ: u(undefined, "") },
    ], false),
    "DataFormat": o([
        { json: "parse", js: "parse", typ: u(undefined, u(r("ParseEnum"), m("any"))) },
        { json: "type", js: "type", typ: u(undefined, r("DataFormatType")) },
        { json: "property", js: "property", typ: u(undefined, "") },
        { json: "feature", js: "feature", typ: u(undefined, "") },
        { json: "mesh", js: "mesh", typ: u(undefined, "") },
    ], false),
    "EncodingWithFacet": o([
        { json: "color", js: "color", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "column", js: "column", typ: u(undefined, r("FacetFieldDef")) },
        { json: "detail", js: "detail", typ: u(undefined, u(a(r("FieldDef")), r("FieldDef"))) },
        { json: "href", js: "href", typ: u(undefined, r("DefWithCondition")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "order", js: "order", typ: u(undefined, u(a(r("OrderFieldDef")), r("OrderFieldDef"))) },
        { json: "row", js: "row", typ: u(undefined, r("FacetFieldDef")) },
        { json: "shape", js: "shape", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "size", js: "size", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "text", js: "text", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "tooltip", js: "tooltip", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "x", js: "x", typ: u(undefined, r("XClass")) },
        { json: "x2", js: "x2", typ: u(undefined, r("X2Class")) },
        { json: "y", js: "y", typ: u(undefined, r("XClass")) },
        { json: "y2", js: "y2", typ: u(undefined, r("X2Class")) },
    ], false),
    "MarkPropDefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateMarkPropFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "legend", js: "legend", typ: u(undefined, u(r("Legend"), null)) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "BinParams": o([
        { json: "base", js: "base", typ: u(undefined, 3.14) },
        { json: "divide", js: "divide", typ: u(undefined, a(3.14, 1, undefined)) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14, 2, 2)) },
        { json: "maxbins", js: "maxbins", typ: u(undefined, n(3.14, 2, undefined)) },
        { json: "minstep", js: "minstep", typ: u(undefined, 3.14) },
        { json: "nice", js: "nice", typ: u(undefined, true) },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
        { json: "steps", js: "steps", typ: u(undefined, a(3.14, 1, undefined)) },
    ], false),
    "ConditionalValueDef": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(true, 3.14, "") },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
    ], false),
    "Selection": o([
        { json: "not", js: "not", typ: u(undefined, u(r("Selection"), "")) },
        { json: "and", js: "and", typ: u(undefined, a(u(r("Selection"), ""))) },
        { json: "or", js: "or", typ: u(undefined, a(u(r("Selection"), ""))) },
    ], false),
    "Predicate": o([
        { json: "not", js: "not", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "and", js: "and", typ: u(undefined, a(u(r("Predicate"), ""))) },
        { json: "or", js: "or", typ: u(undefined, a(u(r("Predicate"), ""))) },
        { json: "equal", js: "equal", typ: u(undefined, u(true, r("DateTime"), 3.14, "")) },
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "range", js: "range", typ: u(undefined, a(u(r("DateTime"), 3.14, null), 2, 2)) },
        { json: "oneOf", js: "oneOf", typ: u(undefined, a(u(true, r("DateTime"), 3.14, ""))) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
    ], false),
    "DateTime": o([
        { json: "date", js: "date", typ: u(undefined, n(3.14, 1, 31)) },
        { json: "day", js: "day", typ: u(undefined, u(n(3.14, 1, 7), "")) },
        { json: "hours", js: "hours", typ: u(undefined, n(3.14, 0, 23)) },
        { json: "milliseconds", js: "milliseconds", typ: u(undefined, n(3.14, 0, 999)) },
        { json: "minutes", js: "minutes", typ: u(undefined, n(3.14, 0, 59)) },
        { json: "month", js: "month", typ: u(undefined, u(n(3.14, 1, 12), "")) },
        { json: "quarter", js: "quarter", typ: u(undefined, n(3.14, 1, 4)) },
        { json: "seconds", js: "seconds", typ: u(undefined, n(3.14, 0, 59)) },
        { json: "utc", js: "utc", typ: u(undefined, true) },
        { json: "year", js: "year", typ: u(undefined, 3.14) },
    ], false),
    "ConditionalPredicateMarkPropFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "legend", js: "legend", typ: u(undefined, u(r("Legend"), null)) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "RepeatRef": o([
        { json: "repeat", js: "repeat", typ: r("RepeatEnum") },
    ], false),
    "Legend": o([
        { json: "entryPadding", js: "entryPadding", typ: u(undefined, 3.14) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("LegendOrient")) },
        { json: "padding", js: "padding", typ: u(undefined, 3.14) },
        { json: "tickCount", js: "tickCount", typ: u(undefined, 3.14) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
        { json: "type", js: "type", typ: u(undefined, r("LegendType")) },
        { json: "values", js: "values", typ: u(undefined, a(u(r("DateTime"), 3.14, ""))) },
        { json: "zindex", js: "zindex", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "Scale": o([
        { json: "base", js: "base", typ: u(undefined, 3.14) },
        { json: "clamp", js: "clamp", typ: u(undefined, true) },
        { json: "domain", js: "domain", typ: u(undefined, u(a(u(true, r("DateTime"), 3.14, "")), r("DomainClass"), r("Domain"))) },
        { json: "exponent", js: "exponent", typ: u(undefined, 3.14) },
        { json: "interpolate", js: "interpolate", typ: u(undefined, u(r("InterpolateParams"), r("Interpolate"))) },
        { json: "nice", js: "nice", typ: u(undefined, u(true, r("NiceClass"), 3.14, r("NiceTime"))) },
        { json: "padding", js: "padding", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "paddingInner", js: "paddingInner", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "paddingOuter", js: "paddingOuter", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "range", js: "range", typ: u(undefined, u(a(u(3.14, "")), "")) },
        { json: "rangeStep", js: "rangeStep", typ: u(undefined, u(n(3.14, 0, undefined), null)) },
        { json: "round", js: "round", typ: u(undefined, true) },
        { json: "scheme", js: "scheme", typ: u(undefined, u(r("SchemeParams"), "")) },
        { json: "type", js: "type", typ: u(undefined, r("ScaleType")) },
        { json: "zero", js: "zero", typ: u(undefined, true) },
    ], false),
    "DomainClass": o([
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "selection", js: "selection", typ: "" },
        { json: "encoding", js: "encoding", typ: u(undefined, "") },
    ], false),
    "InterpolateParams": o([
        { json: "gamma", js: "gamma", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: r("InterpolateParamsType") },
    ], false),
    "NiceClass": o([
        { json: "interval", js: "interval", typ: "" },
        { json: "step", js: "step", typ: 3.14 },
    ], false),
    "SchemeParams": o([
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "name", js: "name", typ: "" },
    ], false),
    "SortField": o([
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "op", js: "op", typ: r("AggregateOp") },
        { json: "order", js: "order", typ: u(undefined, u(r("SortEnum"), null)) },
    ], false),
    "FacetFieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "header", js: "header", typ: u(undefined, r("Header")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "Header": o([
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
    ], false),
    "FieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "DefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "ConditionalPredicateFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "OrderFieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "TextDefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateTextFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "ConditionalPredicateTextFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "XClass": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "axis", js: "axis", typ: u(undefined, u(r("Axis"), null)) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "stack", js: "stack", typ: u(undefined, u(r("StackOffset"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "Axis": o([
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
        { json: "position", js: "position", typ: u(undefined, 3.14) },
        { json: "tickCount", js: "tickCount", typ: u(undefined, 3.14) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "values", js: "values", typ: u(undefined, a(u(r("DateTime"), 3.14))) },
        { json: "zindex", js: "zindex", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "X2Class": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "FacetMapping": o([
        { json: "column", js: "column", typ: u(undefined, r("FacetFieldDef")) },
        { json: "row", js: "row", typ: u(undefined, r("FacetFieldDef")) },
    ], false),
    "Spec": o([
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "encoding", js: "encoding", typ: u(undefined, r("Encoding")) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
        { json: "facet", js: "facet", typ: u(undefined, r("FacetMapping")) },
        { json: "spec", js: "spec", typ: u(undefined, r("Spec")) },
        { json: "repeat", js: "repeat", typ: u(undefined, r("Repeat")) },
        { json: "vconcat", js: "vconcat", typ: u(undefined, a(r("Spec"))) },
        { json: "hconcat", js: "hconcat", typ: u(undefined, a(r("Spec"))) },
    ], false),
    "Encoding": o([
        { json: "color", js: "color", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "detail", js: "detail", typ: u(undefined, u(a(r("FieldDef")), r("FieldDef"))) },
        { json: "href", js: "href", typ: u(undefined, r("DefWithCondition")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "order", js: "order", typ: u(undefined, u(a(r("OrderFieldDef")), r("OrderFieldDef"))) },
        { json: "shape", js: "shape", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "size", js: "size", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "text", js: "text", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "tooltip", js: "tooltip", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "x", js: "x", typ: u(undefined, r("XClass")) },
        { json: "x2", js: "x2", typ: u(undefined, r("X2Class")) },
        { json: "y", js: "y", typ: u(undefined, r("XClass")) },
        { json: "y2", js: "y2", typ: u(undefined, r("X2Class")) },
    ], false),
    "LayerSpec": o([
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "encoding", js: "encoding", typ: u(undefined, r("Encoding")) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
    ], false),
    "MarkDef": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "clip", js: "clip", typ: u(undefined, true) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "style", js: "style", typ: u(undefined, u(a(""), "")) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: r("Mark") },
    ], false),
    "Projection": o([
        { json: "center", js: "center", typ: u(undefined, a(3.14)) },
        { json: "clipAngle", js: "clipAngle", typ: u(undefined, 3.14) },
        { json: "clipExtent", js: "clipExtent", typ: u(undefined, a(a(3.14))) },
        { json: "coefficient", js: "coefficient", typ: u(undefined, 3.14) },
        { json: "distance", js: "distance", typ: u(undefined, 3.14) },
        { json: "fraction", js: "fraction", typ: u(undefined, 3.14) },
        { json: "lobes", js: "lobes", typ: u(undefined, 3.14) },
        { json: "parallel", js: "parallel", typ: u(undefined, 3.14) },
        { json: "precision", js: "precision", typ: u(undefined, r("FluffyPrecision")) },
        { json: "radius", js: "radius", typ: u(undefined, 3.14) },
        { json: "ratio", js: "ratio", typ: u(undefined, 3.14) },
        { json: "rotate", js: "rotate", typ: u(undefined, a(3.14)) },
        { json: "spacing", js: "spacing", typ: u(undefined, 3.14) },
        { json: "tilt", js: "tilt", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: u(undefined, r("VGProjectionType")) },
    ], false),
    "FluffyPrecision": o([
        { json: "length", js: "length", typ: 3.14 },
    ], ""),
    "Resolve": o([
        { json: "axis", js: "axis", typ: u(undefined, r("AxisResolveMap")) },
        { json: "legend", js: "legend", typ: u(undefined, r("LegendResolveMap")) },
        { json: "scale", js: "scale", typ: u(undefined, r("ScaleResolveMap")) },
    ], false),
    "AxisResolveMap": o([
        { json: "x", js: "x", typ: u(undefined, r("ResolveMode")) },
        { json: "y", js: "y", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "LegendResolveMap": o([
        { json: "color", js: "color", typ: u(undefined, r("ResolveMode")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("ResolveMode")) },
        { json: "shape", js: "shape", typ: u(undefined, r("ResolveMode")) },
        { json: "size", js: "size", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "ScaleResolveMap": o([
        { json: "color", js: "color", typ: u(undefined, r("ResolveMode")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("ResolveMode")) },
        { json: "shape", js: "shape", typ: u(undefined, r("ResolveMode")) },
        { json: "size", js: "size", typ: u(undefined, r("ResolveMode")) },
        { json: "x", js: "x", typ: u(undefined, r("ResolveMode")) },
        { json: "y", js: "y", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "SelectionDef": o([
        { json: "bind", js: "bind", typ: u(undefined, u(r("BindEnum"), m(r("VGBinding")))) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "type", js: "type", typ: r("SelectionDefType") },
        { json: "toggle", js: "toggle", typ: u(undefined, u(true, "")) },
        { json: "mark", js: "mark", typ: u(undefined, r("BrushConfig")) },
        { json: "translate", js: "translate", typ: u(undefined, u(true, "")) },
        { json: "zoom", js: "zoom", typ: u(undefined, u(true, "")) },
    ], false),
    "TitleParams": o([
        { json: "anchor", js: "anchor", typ: u(undefined, r("Anchor")) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
        { json: "style", js: "style", typ: u(undefined, u(a(""), "")) },
        { json: "text", js: "text", typ: "" },
    ], false),
    "Transform": o([
        { json: "filter", js: "filter", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "as", js: "as", typ: u(undefined, u(a(""), "")) },
        { json: "calculate", js: "calculate", typ: u(undefined, "") },
        { json: "default", js: "default", typ: u(undefined, "") },
        { json: "from", js: "from", typ: u(undefined, r("LookupData")) },
        { json: "lookup", js: "lookup", typ: u(undefined, "") },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, a(r("AggregatedFieldDef"))) },
        { json: "groupby", js: "groupby", typ: u(undefined, a("")) },
    ], false),
    "AggregatedFieldDef": o([
        { json: "as", js: "as", typ: "" },
        { json: "field", js: "field", typ: "" },
        { json: "op", js: "op", typ: r("AggregateOp") },
    ], false),
    "LookupData": o([
        { json: "data", js: "data", typ: r("Data") },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "key", js: "key", typ: "" },
    ], false),
    "Repeat": o([
        { json: "column", js: "column", typ: u(undefined, a("")) },
        { json: "row", js: "row", typ: u(undefined, a("")) },
    ], false),
    "Contains": [
        "content",
        "padding",
    ],
    "AutosizeType": [
        "pad",
        "fit",
        "none",
    ],
    "HorizontalAlign": [
        "left",
        "right",
        "center",
    ],
    "VerticalAlign": [
        "top",
        "middle",
        "bottom",
    ],
    "Cursor": [
        "auto",
        "default",
        "none",
        "context-menu",
        "help",
        "pointer",
        "progress",
        "wait",
        "cell",
        "crosshair",
        "text",
        "vertical-text",
        "alias",
        "copy",
        "move",
        "no-drop",
        "not-allowed",
        "e-resize",
        "n-resize",
        "ne-resize",
        "nw-resize",
        "s-resize",
        "se-resize",
        "sw-resize",
        "w-resize",
        "ew-resize",
        "ns-resize",
        "nesw-resize",
        "nwse-resize",
        "col-resize",
        "row-resize",
        "all-scroll",
        "zoom-in",
        "zoom-out",
        "grab",
        "grabbing",
    ],
    "FontStyle": [
        "normal",
        "italic",
    ],
    "FontWeight": [
        "normal",
        "bold",
    ],
    "Interpolate": [
        "linear",
        "linear-closed",
        "step",
        "step-before",
        "step-after",
        "basis",
        "basis-open",
        "basis-closed",
        "cardinal",
        "cardinal-open",
        "cardinal-closed",
        "bundle",
        "monotone",
    ],
    "Orient": [
        "horizontal",
        "vertical",
    ],
    "LabelOverlapEnum": [
        "parity",
        "greedy",
    ],
    "FieldTitle": [
        "verbal",
        "functional",
        "plain",
    ],
    "InvalidValues": [
        "filter",
    ],
    "LegendOrient": [
        "left",
        "right",
        "top-left",
        "top-right",
        "bottom-left",
        "bottom-right",
        "none",
    ],
    "VGProjectionType": [
        "albers",
        "albersUsa",
        "azimuthalEqualArea",
        "azimuthalEquidistant",
        "conicConformal",
        "conicEqualArea",
        "conicEquidistant",
        "equirectangular",
        "gnomonic",
        "mercator",
        "orthographic",
        "stereographic",
        "transverseMercator",
    ],
    "BindEnum": [
        "scales",
    ],
    "Empty": [
        "all",
        "none",
    ],
    "SingleDefChannel": [
        "x",
        "y",
        "x2",
        "y2",
        "row",
        "column",
        "size",
        "shape",
        "color",
        "opacity",
        "text",
        "tooltip",
        "href",
    ],
    "SelectionResolution": [
        "global",
        "union",
        "intersect",
    ],
    "StackOffset": [
        "zero",
        "center",
        "normalize",
    ],
    "Anchor": [
        "start",
        "middle",
        "end",
    ],
    "TitleOrient": [
        "top",
        "bottom",
        "left",
        "right",
    ],
    "ParseEnum": [
        "auto",
    ],
    "DataFormatType": [
        "csv",
        "tsv",
        "json",
        "topojson",
    ],
    "AggregateOp": [
        "argmax",
        "argmin",
        "average",
        "count",
        "distinct",
        "max",
        "mean",
        "median",
        "min",
        "missing",
        "q1",
        "q3",
        "ci0",
        "ci1",
        "stdev",
        "stdevp",
        "sum",
        "valid",
        "values",
        "variance",
        "variancep",
    ],
    "TimeUnit": [
        "year",
        "quarter",
        "month",
        "day",
        "date",
        "hours",
        "minutes",
        "seconds",
        "milliseconds",
        "utcyear",
        "utcquarter",
        "utcmonth",
        "utcday",
        "utcdate",
        "utchours",
        "utcminutes",
        "utcseconds",
        "utcmilliseconds",
        "yearquarter",
        "yearquartermonth",
        "yearmonth",
        "yearmonthdate",
        "yearmonthdatehours",
        "yearmonthdatehoursminutes",
        "yearmonthdatehoursminutesseconds",
        "quartermonth",
        "monthdate",
        "hoursminutes",
        "hoursminutesseconds",
        "minutesseconds",
        "secondsmilliseconds",
        "utcyearquarter",
        "utcyearquartermonth",
        "utcyearmonth",
        "utcyearmonthdate",
        "utcyearmonthdatehours",
        "utcyearmonthdatehoursminutes",
        "utcyearmonthdatehoursminutesseconds",
        "utcquartermonth",
        "utcmonthdate",
        "utchoursminutes",
        "utchoursminutesseconds",
        "utcminutesseconds",
        "utcsecondsmilliseconds",
    ],
    "RepeatEnum": [
        "row",
        "column",
    ],
    "LegendType": [
        "symbol",
        "gradient",
    ],
    "Domain": [
        "unaggregated",
    ],
    "InterpolateParamsType": [
        "rgb",
        "cubehelix",
        "cubehelix-long",
    ],
    "NiceTime": [
        "second",
        "minute",
        "hour",
        "day",
        "week",
        "month",
        "year",
    ],
    "ScaleType": [
        "linear",
        "bin-linear",
        "log",
        "pow",
        "sqrt",
        "time",
        "utc",
        "sequential",
        "ordinal",
        "bin-ordinal",
        "point",
        "band",
    ],
    "SortEnum": [
        "ascending",
        "descending",
    ],
    "Type": [
        "quantitative",
        "ordinal",
        "temporal",
        "nominal",
        "latitude",
        "longitude",
        "geojson",
    ],
    "Mark": [
        "area",
        "bar",
        "line",
        "point",
        "text",
        "tick",
        "rect",
        "rule",
        "circle",
        "square",
        "geoshape",
    ],
    "ResolveMode": [
        "independent",
        "shared",
    ],
    "SelectionDefType": [
        "single",
        "multi",
        "interval",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
