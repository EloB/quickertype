// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    /// URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
    /// have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
    /// Setting the `$schema` property allows automatic validation and autocomplete in editors
    /// that support JSON schema.
    #[serde(rename = "$schema")]
    pub schema: Option<String>,

    /// Sets how the visualization size should be determined. If a string, should be one of
    /// `"pad"`, `"fit"` or `"none"`.
    /// Object values can additionally specify parameters for content sizing and automatic
    /// resizing.
    /// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    /// __Default value__: `pad`
    pub autosize: Option<Autosize>,

    /// CSS color property to use as the background of visualization.
    ///
    /// __Default value:__ none (transparent)
    pub background: Option<String>,

    /// Vega-Lite configuration object.  This property can only be defined at the top-level of a
    /// specification.
    pub config: Option<Config>,

    /// An object describing the data source
    pub data: Option<Data>,

    /// Description of this mark for commenting purpose.
    pub description: Option<String>,

    /// A key-value mapping between encoding channels and definition of fields.
    pub encoding: Option<EncodingWithFacet>,

    /// The height of a visualization.
    ///
    /// __Default value:__
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    /// [continuous scale](scale.html#continuous), the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the height is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    /// `rangeStep` is `null`, the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    /// __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the height of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub height: Option<f64>,

    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    pub mark: Option<AnyMark>,

    /// Name of the visualization for later reference.
    pub name: Option<String>,

    /// The default visualization padding, in pixels, from the edge of the visualization canvas
    /// to the data rectangle.  If a number, specifies padding for all sides.
    /// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    /// "bottom": 5}` to specify padding for each side of the visualization.
    ///
    /// __Default value__: `5`
    pub padding: Option<Padding>,

    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    pub projection: Option<Projection>,

    /// A key-value mapping between selection names and definitions.
    pub selection: Option<HashMap<String, SelectionDef>>,

    /// Title for the plot.
    pub title: Option<Title>,

    /// An array of data transformations such as filter and new field calculation.
    pub transform: Option<Vec<Transform>>,

    /// The width of a visualization.
    ///
    /// __Default value:__ This will be determined by the following rules:
    ///
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    /// [continuous scale](scale.html#continuous), the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the width is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    /// `rangeStep` is `null`, the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - If no field is mapped to `x` channel, the `width` will be the value of
    /// [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    /// the value of `rangeStep` for other marks.
    ///
    /// __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the width of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub width: Option<f64>,

    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    pub layer: Option<Vec<LayerSpec>>,

    /// Scale, axis, and legend resolutions for layers.
    ///
    /// Scale, axis, and legend resolutions for facets.
    ///
    /// Scale and legend resolutions for repeated charts.
    ///
    /// Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    /// Scale, axis, and legend resolutions for horizontally concatenated charts.
    pub resolve: Option<Resolve>,

    /// An object that describes mappings between `row` and `column` channels and their field
    /// definitions.
    pub facet: Option<FacetMapping>,

    /// A specification of the view that gets faceted.
    pub spec: Box<Option<Spec>>,

    /// An object that describes what fields should be repeated into views that are laid out as a
    /// `row` or `column`.
    pub repeat: Option<Repeat>,

    /// A list of views that should be concatenated and put into a column.
    pub vconcat: Option<Vec<Spec>>,

    /// A list of views that should be concatenated and put into a row.
    pub hconcat: Option<Vec<Spec>>,
}

/// Sets how the visualization size should be determined. If a string, should be one of
/// `"pad"`, `"fit"` or `"none"`.
/// Object values can additionally specify parameters for content sizing and automatic
/// resizing.
/// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
///
/// __Default value__: `pad`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Autosize {
    AutoSizeParams(AutoSizeParams),

    Enum(AutosizeType),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AutoSizeParams {
    /// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
    /// The default setting (`"content"`) interprets the width and height settings as the data
    /// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
    /// `"padding"` setting includes the padding within the view size calculations, such that the
    /// width and height settings indicate the **total** intended size of the view.
    ///
    /// __Default value__: `"content"`
    pub contains: Option<Contains>,

    /// A boolean flag indicating if autosize layout should be re-calculated on every view
    /// update.
    ///
    /// __Default value__: `false`
    pub resize: Option<bool>,

    /// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
    /// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
    /// descriptions of each.
    ///
    /// __Default value__: `"pad"`
    #[serde(rename = "type")]
    pub auto_size_params_type: Option<AutosizeType>,
}

/// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
/// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
/// descriptions of each.
///
/// __Default value__: `"pad"`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum AutosizeType {
    Pad,

    Fit,

    #[serde(rename = "none")]
    AutosizeTypeNone,
}

/// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
/// The default setting (`"content"`) interprets the width and height settings as the data
/// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
/// `"padding"` setting includes the padding within the view size calculations, such that the
/// width and height settings indicate the **total** intended size of the view.
///
/// __Default value__: `"content"`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Contains {
    Content,

    Padding,
}

/// Vega-Lite configuration object.  This property can only be defined at the top-level of a
/// specification.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Config {
    /// Area-Specific Config
    pub area: Option<MarkConfig>,

    /// Sets how the visualization size should be determined. If a string, should be one of
    /// `"pad"`, `"fit"` or `"none"`.
    /// Object values can additionally specify parameters for content sizing and automatic
    /// resizing.
    /// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    /// __Default value__: `pad`
    pub autosize: Option<Autosize>,

    /// Axis configuration, which determines default properties for all `x` and `y`
    /// [axes](axis.html). For a full list of axis configuration options, please see the
    /// [corresponding section of the axis documentation](axis.html#config).
    pub axis: Option<AxisConfig>,

    /// Specific axis config for axes with "band" scales.
    pub axis_band: Option<VgAxisConfig>,

    /// Specific axis config for x-axis along the bottom edge of the chart.
    pub axis_bottom: Option<VgAxisConfig>,

    /// Specific axis config for y-axis along the left edge of the chart.
    pub axis_left: Option<VgAxisConfig>,

    /// Specific axis config for y-axis along the right edge of the chart.
    pub axis_right: Option<VgAxisConfig>,

    /// Specific axis config for x-axis along the top edge of the chart.
    pub axis_top: Option<VgAxisConfig>,

    /// X-axis specific config.
    pub axis_x: Option<VgAxisConfig>,

    /// Y-axis specific config.
    pub axis_y: Option<VgAxisConfig>,

    /// CSS color property to use as the background of visualization.
    ///
    /// __Default value:__ none (transparent)
    pub background: Option<String>,

    /// Bar-Specific Config
    pub bar: Option<BarConfig>,

    /// Circle-Specific Config
    pub circle: Option<MarkConfig>,

    /// Default axis and legend title for count fields.
    ///
    /// __Default value:__ `'Number of Records'`.
    pub count_title: Option<String>,

    /// Defines how Vega-Lite generates title for fields.  There are three possible styles:
    ///
    /// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
    /// "Year-month of date", "field (binned)").
    /// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
    /// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
    /// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
    /// "field").
    pub field_title: Option<FieldTitle>,

    /// Geoshape-Specific Config
    pub geoshape: Option<MarkConfig>,

    /// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
    /// - If set to `"filter"` (default), all data items with null values are filtered.
    /// - If `null`, all data items are included. In this case, invalid values will be
    /// interpreted as zeroes.
    pub invalid_values: Option<InvalidValues>,

    /// Legend configuration, which determines default properties for all [legends](legend.html).
    /// For a full list of legend configuration options, please see the [corresponding section of
    /// in the legend documentation](legend.html#config).
    pub legend: Option<LegendConfig>,

    /// Line-Specific Config
    pub line: Option<MarkConfig>,

    /// Mark Config
    pub mark: Option<MarkConfig>,

    /// D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
    /// number format pattern](https://github.com/d3/d3-format#locale_format).
    pub number_format: Option<String>,

    /// The default visualization padding, in pixels, from the edge of the visualization canvas
    /// to the data rectangle.  If a number, specifies padding for all sides.
    /// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    /// "bottom": 5}` to specify padding for each side of the visualization.
    ///
    /// __Default value__: `5`
    pub padding: Option<Padding>,

    /// Point-Specific Config
    pub point: Option<MarkConfig>,

    /// Projection configuration, which determines default properties for all
    /// [projections](projection.html). For a full list of projection configuration options,
    /// please see the [corresponding section of the projection
    /// documentation](projection.html#config).
    pub projection: Option<ProjectionConfig>,

    /// An object hash that defines default range arrays or schemes for using with scales.
    /// For a full list of scale range configuration options, please see the [corresponding
    /// section of the scale documentation](scale.html#config).
    pub range: Option<HashMap<String, RangeConfigValue>>,

    /// Rect-Specific Config
    pub rect: Option<MarkConfig>,

    /// Rule-Specific Config
    pub rule: Option<MarkConfig>,

    /// Scale configuration determines default properties for all [scales](scale.html). For a
    /// full list of scale configuration options, please see the [corresponding section of the
    /// scale documentation](scale.html#config).
    pub scale: Option<ScaleConfig>,

    /// An object hash for defining default properties for each type of selections.
    pub selection: Option<SelectionConfig>,

    /// Square-Specific Config
    pub square: Option<MarkConfig>,

    /// Default stack offset for stackable mark.
    pub stack: Option<StackOffset>,

    /// An object hash that defines key-value mappings to determine default properties for marks
    /// with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
    /// valid [mark configuration objects](mark.html#config).
    pub style: Option<HashMap<String, VgMarkConfig>>,

    /// Text-Specific Config
    pub text: Option<TextConfig>,

    /// Tick-Specific Config
    pub tick: Option<TickConfig>,

    /// Default datetime format for axis and legend labels. The format can be set directly on
    /// each axis and legend. Use [D3's time format
    /// pattern](https://github.com/d3/d3-time-format#locale_format).
    ///
    /// __Default value:__ `'%b %d, %Y'`.
    pub time_format: Option<String>,

    /// Title configuration, which determines default properties for all [titles](title.html).
    /// For a full list of title configuration options, please see the [corresponding section of
    /// the title documentation](title.html#config).
    pub title: Option<VgTitleConfig>,

    /// Default properties for [single view plots](spec.html#single).
    pub view: Option<ViewConfig>,
}

/// Area-Specific Config
///
/// Circle-Specific Config
///
/// Geoshape-Specific Config
///
/// Line-Specific Config
///
/// Mark Config
///
/// Point-Specific Config
///
/// Rect-Specific Config
///
/// Rule-Specific Config
///
/// Square-Specific Config
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MarkConfig {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub color: Option<String>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub filled: Option<bool>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,
}

/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum HorizontalAlign {
    Left,

    Right,

    Center,
}

/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
///
/// Vertical text baseline for title text.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum VerticalAlign {
    Top,

    Middle,

    Bottom,
}

/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Cursor {
    Auto,

    Default,

    #[serde(rename = "none")]
    CursorNone,

    #[serde(rename = "context-menu")]
    ContextMenu,

    Help,

    Pointer,

    Progress,

    Wait,

    Cell,

    Crosshair,

    Text,

    #[serde(rename = "vertical-text")]
    VerticalText,

    Alias,

    Copy,

    Move,

    #[serde(rename = "no-drop")]
    NoDrop,

    #[serde(rename = "not-allowed")]
    NotAllowed,

    #[serde(rename = "e-resize")]
    EResize,

    #[serde(rename = "n-resize")]
    NResize,

    #[serde(rename = "ne-resize")]
    NeResize,

    #[serde(rename = "nw-resize")]
    NwResize,

    #[serde(rename = "s-resize")]
    SResize,

    #[serde(rename = "se-resize")]
    SeResize,

    #[serde(rename = "sw-resize")]
    SwResize,

    #[serde(rename = "w-resize")]
    WResize,

    #[serde(rename = "ew-resize")]
    EwResize,

    #[serde(rename = "ns-resize")]
    NsResize,

    #[serde(rename = "nesw-resize")]
    NeswResize,

    #[serde(rename = "nwse-resize")]
    NwseResize,

    #[serde(rename = "col-resize")]
    ColResize,

    #[serde(rename = "row-resize")]
    RowResize,

    #[serde(rename = "all-scroll")]
    AllScroll,

    #[serde(rename = "zoom-in")]
    ZoomIn,

    #[serde(rename = "zoom-out")]
    ZoomOut,

    Grab,

    Grabbing,
}

/// The font style (e.g., `"italic"`).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum FontStyle {
    Normal,

    Italic,
}

/// The font weight (e.g., `"bold"`).
///
/// Font weight for title text.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FontWeightUnion {
    Double(f64),

    Enum(FontWeight),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum FontWeight {
    Normal,

    Bold,
}

/// The line interpolation method to use for line and area marks. One of the following:
/// - `"linear"`: piecewise linear segments, as in a polyline.
/// - `"linear-closed"`: close the linear segments to form a polygon.
/// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
/// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
/// function.
/// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
/// function.
/// - `"basis"`: a B-spline, with control point duplication on the ends.
/// - `"basis-open"`: an open B-spline; may not intersect the start or end.
/// - `"basis-closed"`: a closed B-spline, as in a loop.
/// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
/// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
/// will intersect other control points.
/// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
/// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
/// spline.
/// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Interpolate {
    Linear,

    #[serde(rename = "linear-closed")]
    LinearClosed,

    Step,

    #[serde(rename = "step-before")]
    StepBefore,

    #[serde(rename = "step-after")]
    StepAfter,

    Basis,

    #[serde(rename = "basis-open")]
    BasisOpen,

    #[serde(rename = "basis-closed")]
    BasisClosed,

    Cardinal,

    #[serde(rename = "cardinal-open")]
    CardinalOpen,

    #[serde(rename = "cardinal-closed")]
    CardinalClosed,

    Bundle,

    Monotone,
}

/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Orient {
    Horizontal,

    Vertical,
}

/// Axis configuration, which determines default properties for all `x` and `y`
/// [axes](axis.html). For a full list of axis configuration options, please see the
/// [corresponding section of the axis documentation](axis.html#config).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AxisConfig {
    /// An interpolation fraction indicating where, for `band` scales, axis ticks should be
    /// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    /// places ticks in the middle of their bands.
    pub band_position: Option<f64>,

    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    pub domain: Option<bool>,

    /// Color of axis domain line.
    ///
    /// __Default value:__  (none, using Vega default).
    pub domain_color: Option<String>,

    /// Stroke width of axis domain line
    ///
    /// __Default value:__  (none, using Vega default).
    pub domain_width: Option<f64>,

    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    pub grid: Option<bool>,

    /// Color of gridlines.
    pub grid_color: Option<String>,

    /// The offset (in pixels) into which to begin drawing with the grid dash array.
    pub grid_dash: Option<Vec<f64>>,

    /// The stroke opacity of grid (value between [0,1])
    ///
    /// __Default value:__ (`1` by default)
    pub grid_opacity: Option<f64>,

    /// The grid width, in pixels.
    pub grid_width: Option<f64>,

    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    pub label_angle: Option<f64>,

    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    pub label_bound: Option<Label>,

    /// The color of the tick label, can be in hex color code or regular color name.
    pub label_color: Option<String>,

    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    pub label_flush: Option<Label>,

    /// The font of the tick label.
    pub label_font: Option<String>,

    /// The font size of the label, in pixels.
    pub label_font_size: Option<f64>,

    /// Maximum allowed pixel width of axis tick labels.
    pub label_limit: Option<f64>,

    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    pub label_overlap: Option<LabelOverlapUnion>,

    /// The padding, in pixels, between axis and text labels.
    pub label_padding: Option<f64>,

    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    pub labels: Option<bool>,

    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    pub max_extent: Option<f64>,

    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    pub min_extent: Option<f64>,

    /// Whether month names and weekday names should be abbreviated.
    ///
    /// __Default value:__  `false`
    pub short_time_labels: Option<bool>,

    /// The color of the axis's tick.
    pub tick_color: Option<String>,

    /// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    pub tick_round: Option<bool>,

    /// Boolean value that determines whether the axis should include ticks.
    pub ticks: Option<bool>,

    /// The size in pixels of axis ticks.
    pub tick_size: Option<f64>,

    /// The width, in pixels, of ticks.
    pub tick_width: Option<f64>,

    /// Horizontal text alignment of axis titles.
    pub title_align: Option<String>,

    /// Angle in degrees of axis titles.
    pub title_angle: Option<f64>,

    /// Vertical text baseline for axis titles.
    pub title_baseline: Option<String>,

    /// Color of the title, can be in hex color code or regular color name.
    pub title_color: Option<String>,

    /// Font of the title. (e.g., `"Helvetica Neue"`).
    pub title_font: Option<String>,

    /// Font size of the title.
    pub title_font_size: Option<f64>,

    /// Font weight of the title. (e.g., `"bold"`).
    pub title_font_weight: Option<TitleFontWeightUnion>,

    /// Maximum allowed pixel width of axis titles.
    pub title_limit: Option<f64>,

    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    pub title_max_length: Option<f64>,

    /// The padding, in pixels, between title and axis.
    pub title_padding: Option<f64>,

    /// X-coordinate of the axis title relative to the axis group.
    pub title_x: Option<f64>,

    /// Y-coordinate of the axis title relative to the axis group.
    pub title_y: Option<f64>,
}

/// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
/// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
/// they exceed the axis range by more than 1 pixel. If this property is a number, it
/// specifies the pixel tolerance: the maximum amount by which a label bounding box may
/// exceed the axis range.
///
/// __Default value:__ `false`.
///
/// Indicates if the first and last axis labels should be aligned flush with the scale range.
/// Flush alignment for a horizontal axis will left-align the first label and right-align the
/// last label. For vertical axes, bottom and top text baselines are applied instead. If this
/// property is a number, it also indicates the number of pixels by which to offset the first
/// and last labels; for example, a value of 2 will flush-align the first and last labels and
/// also push them 2 pixels outward from the center of the axis. The additional adjustment
/// can sometimes help the labels better visually group with corresponding axis ticks.
///
/// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Label {
    Bool(bool),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LabelOverlapUnion {
    Bool(bool),

    Enum(LabelOverlapEnum),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum LabelOverlapEnum {
    Parity,

    Greedy,
}

/// Font weight of the title. (e.g., `"bold"`).
///
/// The font weight of the legend title.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TitleFontWeightUnion {
    Double(f64),

    PurpleString(String),
}

/// Specific axis config for axes with "band" scales.
///
/// Specific axis config for x-axis along the bottom edge of the chart.
///
/// Specific axis config for y-axis along the left edge of the chart.
///
/// Specific axis config for y-axis along the right edge of the chart.
///
/// Specific axis config for x-axis along the top edge of the chart.
///
/// X-axis specific config.
///
/// Y-axis specific config.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct VgAxisConfig {
    /// An interpolation fraction indicating where, for `band` scales, axis ticks should be
    /// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    /// places ticks in the middle of their bands.
    pub band_position: Option<f64>,

    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    pub domain: Option<bool>,

    /// Color of axis domain line.
    ///
    /// __Default value:__  (none, using Vega default).
    pub domain_color: Option<String>,

    /// Stroke width of axis domain line
    ///
    /// __Default value:__  (none, using Vega default).
    pub domain_width: Option<f64>,

    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    pub grid: Option<bool>,

    /// Color of gridlines.
    pub grid_color: Option<String>,

    /// The offset (in pixels) into which to begin drawing with the grid dash array.
    pub grid_dash: Option<Vec<f64>>,

    /// The stroke opacity of grid (value between [0,1])
    ///
    /// __Default value:__ (`1` by default)
    pub grid_opacity: Option<f64>,

    /// The grid width, in pixels.
    pub grid_width: Option<f64>,

    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    pub label_angle: Option<f64>,

    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    pub label_bound: Option<Label>,

    /// The color of the tick label, can be in hex color code or regular color name.
    pub label_color: Option<String>,

    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    pub label_flush: Option<Label>,

    /// The font of the tick label.
    pub label_font: Option<String>,

    /// The font size of the label, in pixels.
    pub label_font_size: Option<f64>,

    /// Maximum allowed pixel width of axis tick labels.
    pub label_limit: Option<f64>,

    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    pub label_overlap: Option<LabelOverlapUnion>,

    /// The padding, in pixels, between axis and text labels.
    pub label_padding: Option<f64>,

    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    pub labels: Option<bool>,

    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    pub max_extent: Option<f64>,

    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    pub min_extent: Option<f64>,

    /// The color of the axis's tick.
    pub tick_color: Option<String>,

    /// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    pub tick_round: Option<bool>,

    /// Boolean value that determines whether the axis should include ticks.
    pub ticks: Option<bool>,

    /// The size in pixels of axis ticks.
    pub tick_size: Option<f64>,

    /// The width, in pixels, of ticks.
    pub tick_width: Option<f64>,

    /// Horizontal text alignment of axis titles.
    pub title_align: Option<String>,

    /// Angle in degrees of axis titles.
    pub title_angle: Option<f64>,

    /// Vertical text baseline for axis titles.
    pub title_baseline: Option<String>,

    /// Color of the title, can be in hex color code or regular color name.
    pub title_color: Option<String>,

    /// Font of the title. (e.g., `"Helvetica Neue"`).
    pub title_font: Option<String>,

    /// Font size of the title.
    pub title_font_size: Option<f64>,

    /// Font weight of the title. (e.g., `"bold"`).
    pub title_font_weight: Option<TitleFontWeightUnion>,

    /// Maximum allowed pixel width of axis titles.
    pub title_limit: Option<f64>,

    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    pub title_max_length: Option<f64>,

    /// The padding, in pixels, between title and axis.
    pub title_padding: Option<f64>,

    /// X-coordinate of the axis title relative to the axis group.
    pub title_x: Option<f64>,

    /// Y-coordinate of the axis title relative to the axis group.
    pub title_y: Option<f64>,
}

/// Bar-Specific Config
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BarConfig {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
    /// statisticians) or 1 (Vega-Lite Default, D3 example style).
    ///
    /// __Default value:__ `1`
    pub bin_spacing: Option<f64>,

    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub color: Option<String>,

    /// The default size of the bars on continuous scales.
    ///
    /// __Default value:__ `5`
    pub continuous_band_size: Option<f64>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The size of the bars.  If unspecified, the default size is  `bandSize-1`,
    /// which provides 1 pixel offset between bars.
    pub discrete_band_size: Option<f64>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub filled: Option<bool>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,
}

/// Defines how Vega-Lite generates title for fields.  There are three possible styles:
///
/// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
/// "Year-month of date", "field (binned)").
/// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
/// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
/// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
/// "field").
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum FieldTitle {
    Verbal,

    Functional,

    Plain,
}

/// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
/// - If set to `"filter"` (default), all data items with null values are filtered.
/// - If `null`, all data items are included. In this case, invalid values will be
/// interpreted as zeroes.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum InvalidValues {
    Filter,
}

/// Legend configuration, which determines default properties for all [legends](legend.html).
/// For a full list of legend configuration options, please see the [corresponding section of
/// in the legend documentation](legend.html#config).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct LegendConfig {
    /// Corner radius for the full legend.
    pub corner_radius: Option<f64>,

    /// Padding (in pixels) between legend entries in a symbol legend.
    pub entry_padding: Option<f64>,

    /// Background fill color for the full legend.
    pub fill_color: Option<String>,

    /// The height of the gradient, in pixels.
    pub gradient_height: Option<f64>,

    /// Text baseline for color ramp gradient labels.
    pub gradient_label_baseline: Option<String>,

    /// The maximum allowed length in pixels of color ramp gradient labels.
    pub gradient_label_limit: Option<f64>,

    /// Vertical offset in pixels for color ramp gradient labels.
    pub gradient_label_offset: Option<f64>,

    /// The color of the gradient stroke, can be in hex color code or regular color name.
    pub gradient_stroke_color: Option<String>,

    /// The width of the gradient stroke, in pixels.
    pub gradient_stroke_width: Option<f64>,

    /// The width of the gradient, in pixels.
    pub gradient_width: Option<f64>,

    /// The alignment of the legend label, can be left, middle or right.
    pub label_align: Option<String>,

    /// The position of the baseline of legend label, can be top, middle or bottom.
    pub label_baseline: Option<String>,

    /// The color of the legend label, can be in hex color code or regular color name.
    pub label_color: Option<String>,

    /// The font of the legend label.
    pub label_font: Option<String>,

    /// The font size of legend label.
    ///
    /// __Default value:__ `10`.
    pub label_font_size: Option<f64>,

    /// Maximum allowed pixel width of axis tick labels.
    pub label_limit: Option<f64>,

    /// The offset of the legend label.
    pub label_offset: Option<f64>,

    /// The offset, in pixels, by which to displace the legend from the edge of the enclosing
    /// group or data rectangle.
    ///
    /// __Default value:__  `0`
    pub offset: Option<f64>,

    /// The orientation of the legend, which determines how the legend is positioned within the
    /// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    /// "none".
    ///
    /// __Default value:__ `"right"`
    pub orient: Option<LegendOrient>,

    /// The padding, in pixels, between the legend and axis.
    pub padding: Option<f64>,

    /// Whether month names and weekday names should be abbreviated.
    ///
    /// __Default value:__  `false`
    pub short_time_labels: Option<bool>,

    /// Border stroke color for the full legend.
    pub stroke_color: Option<String>,

    /// Border stroke dash pattern for the full legend.
    pub stroke_dash: Option<Vec<f64>>,

    /// Border stroke width for the full legend.
    pub stroke_width: Option<f64>,

    /// The color of the legend symbol,
    pub symbol_color: Option<String>,

    /// The size of the legend symbol, in pixels.
    pub symbol_size: Option<f64>,

    /// The width of the symbol's stroke.
    pub symbol_stroke_width: Option<f64>,

    /// Default shape type (such as "circle") for legend symbols.
    pub symbol_type: Option<String>,

    /// Horizontal text alignment for legend titles.
    pub title_align: Option<String>,

    /// Vertical text baseline for legend titles.
    pub title_baseline: Option<String>,

    /// The color of the legend title, can be in hex color code or regular color name.
    pub title_color: Option<String>,

    /// The font of the legend title.
    pub title_font: Option<String>,

    /// The font size of the legend title.
    pub title_font_size: Option<f64>,

    /// The font weight of the legend title.
    pub title_font_weight: Option<TitleFontWeightUnion>,

    /// Maximum allowed pixel width of axis titles.
    pub title_limit: Option<f64>,

    /// The padding, in pixels, between title and legend.
    pub title_padding: Option<f64>,
}

/// The orientation of the legend, which determines how the legend is positioned within the
/// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
/// "none".
///
/// __Default value:__ `"right"`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum LegendOrient {
    Left,

    Right,

    #[serde(rename = "top-left")]
    TopLeft,

    #[serde(rename = "top-right")]
    TopRight,

    #[serde(rename = "bottom-left")]
    BottomLeft,

    #[serde(rename = "bottom-right")]
    BottomRight,

    #[serde(rename = "none")]
    LegendOrientNone,
}

/// The default visualization padding, in pixels, from the edge of the visualization canvas
/// to the data rectangle.  If a number, specifies padding for all sides.
/// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
/// "bottom": 5}` to specify padding for each side of the visualization.
///
/// __Default value__: `5`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Padding {
    Double(f64),

    PaddingClass(PaddingClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PaddingClass {
    pub bottom: Option<f64>,

    pub left: Option<f64>,

    pub right: Option<f64>,

    pub top: Option<f64>,
}

/// Projection configuration, which determines default properties for all
/// [projections](projection.html). For a full list of projection configuration options,
/// please see the [corresponding section of the projection
/// documentation](projection.html#config).
///
/// Any property of Projection can be in config
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ProjectionConfig {
    /// Sets the projection’s center to the specified center, a two-element array of longitude
    /// and latitude in degrees.
    ///
    /// __Default value:__ `[0, 0]`
    pub center: Option<Vec<f64>>,

    /// Sets the projection’s clipping circle radius to the specified angle in degrees. If
    /// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    /// than small-circle clipping.
    pub clip_angle: Option<f64>,

    /// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    /// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    /// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    /// viewport clipping is performed.
    pub clip_extent: Option<Vec<Vec<f64>>>,

    pub coefficient: Option<f64>,

    pub distance: Option<f64>,

    pub fraction: Option<f64>,

    pub lobes: Option<f64>,

    pub parallel: Option<f64>,

    /// Sets the threshold for the projection’s [adaptive
    /// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    /// value corresponds to the [Douglas–Peucker
    /// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    /// If precision is not specified, returns the projection’s current resampling precision
    /// which defaults to `√0.5 ≅ 0.70710…`.
    pub precision: Option<HashMap<String, PrecisionValue>>,

    pub radius: Option<f64>,

    pub ratio: Option<f64>,

    /// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    /// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    /// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    /// __Default value:__ `[0, 0, 0]`
    pub rotate: Option<Vec<f64>>,

    pub spacing: Option<f64>,

    pub tilt: Option<f64>,

    /// The cartographic projection to use. This value is case-insensitive, for example
    /// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    /// projection types [in the
    /// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    /// __Default value:__ `mercator`
    #[serde(rename = "type")]
    pub projection_config_type: Option<VgProjectionType>,
}

/// Font weight of the title. (e.g., `"bold"`).
///
/// The font weight of the legend title.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PrecisionValue {
    Double(f64),

    PurpleString(String),
}

/// The cartographic projection to use. This value is case-insensitive, for example
/// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
/// projection types [in the
/// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
/// __Default value:__ `mercator`
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum VgProjectionType {
    Albers,

    #[serde(rename = "albersUsa")]
    AlbersUsa,

    #[serde(rename = "azimuthalEqualArea")]
    AzimuthalEqualArea,

    #[serde(rename = "azimuthalEquidistant")]
    AzimuthalEquidistant,

    #[serde(rename = "conicConformal")]
    ConicConformal,

    #[serde(rename = "conicEqualArea")]
    ConicEqualArea,

    #[serde(rename = "conicEquidistant")]
    ConicEquidistant,

    Equirectangular,

    Gnomonic,

    Mercator,

    Orthographic,

    Stereographic,

    #[serde(rename = "transverseMercator")]
    TransverseMercator,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum RangeConfigValue {
    UnionArray(Vec<PrecisionValue>),

    VgScheme(VgScheme),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VgScheme {
    pub count: Option<f64>,

    pub extent: Option<Vec<f64>>,

    pub scheme: Option<String>,

    pub step: Option<f64>,
}

/// Scale configuration determines default properties for all [scales](scale.html). For a
/// full list of scale configuration options, please see the [corresponding section of the
/// scale documentation](scale.html#config).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ScaleConfig {
    /// Default inner padding for `x` and `y` band-ordinal scales.
    ///
    /// __Default value:__ `0.1`
    pub band_padding_inner: Option<f64>,

    /// Default outer padding for `x` and `y` band-ordinal scales.
    /// If not specified, by default, band scale's paddingOuter is paddingInner/2.
    pub band_padding_outer: Option<f64>,

    /// If true, values that exceed the data domain are clamped to either the minimum or maximum
    /// range value
    pub clamp: Option<bool>,

    /// Default padding for continuous scales.
    ///
    /// __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
    /// horizontal bar.; `0` otherwise.
    pub continuous_padding: Option<f64>,

    /// The default max value for mapping quantitative fields to bar's size/bandSize.
    ///
    /// If undefined (default), we will use the scale's `rangeStep` - 1.
    pub max_band_size: Option<f64>,

    /// The default max value for mapping quantitative fields to text's size/fontSize.
    ///
    /// __Default value:__ `40`
    pub max_font_size: Option<f64>,

    /// Default max opacity for mapping a field to opacity.
    ///
    /// __Default value:__ `0.8`
    pub max_opacity: Option<f64>,

    /// Default max value for point size scale.
    pub max_size: Option<f64>,

    /// Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
    ///
    /// __Default value:__ `4`
    pub max_stroke_width: Option<f64>,

    /// The default min value for mapping quantitative fields to bar and tick's size/bandSize
    /// scale with zero=false.
    ///
    /// __Default value:__ `2`
    pub min_band_size: Option<f64>,

    /// The default min value for mapping quantitative fields to tick's size/fontSize scale with
    /// zero=false
    ///
    /// __Default value:__ `8`
    pub min_font_size: Option<f64>,

    /// Default minimum opacity for mapping a field to opacity.
    ///
    /// __Default value:__ `0.3`
    pub min_opacity: Option<f64>,

    /// Default minimum value for point size scale with zero=false.
    ///
    /// __Default value:__ `9`
    pub min_size: Option<f64>,

    /// Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
    ///
    /// __Default value:__ `1`
    pub min_stroke_width: Option<f64>,

    /// Default outer padding for `x` and `y` point-ordinal scales.
    ///
    /// __Default value:__ `0.5`
    pub point_padding: Option<f64>,

    /// Default range step for band and point scales of (1) the `y` channel
    /// and (2) the `x` channel when the mark is not `text`.
    ///
    /// __Default value:__ `21`
    pub range_step: Option<f64>,

    /// If true, rounds numeric output values to integers.
    /// This can be helpful for snapping to the pixel grid.
    /// (Only available for `x`, `y`, and `size` scales.)
    pub round: Option<bool>,

    /// Default range step for `x` band and point scales of text marks.
    ///
    /// __Default value:__ `90`
    pub text_x_range_step: Option<f64>,

    /// Use the source data range before aggregation as scale domain instead of aggregated data
    /// for aggregate axis.
    ///
    /// This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
    /// fields by default.
    ///
    /// This property only works with aggregate functions that produce values within the raw data
    /// domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
    /// aggregations that produce values outside of the raw data domain (e.g. `"count"`,
    /// `"sum"`), this property is ignored.
    ///
    /// __Default value:__ `false`
    pub use_unaggregated_domain: Option<bool>,
}

/// An object hash for defining default properties for each type of selections.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SelectionConfig {
    /// The default definition for an [`interval`](selection.html#type) selection. All properties
    /// and transformations
    /// for an interval selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `interval` to `{"translate": false}` disables the ability to move
    /// interval selections by default.
    pub interval: Option<IntervalSelectionConfig>,

    /// The default definition for a [`multi`](selection.html#type) selection. All properties and
    /// transformations
    /// for a multi selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
    /// multi selections when clicking with the alt-key pressed by default.
    pub multi: Option<MultiSelectionConfig>,

    /// The default definition for a [`single`](selection.html#type) selection. All properties
    /// and transformations
    /// for a single selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
    /// double-click by default.
    pub single: Option<SingleSelectionConfig>,
}

/// The default definition for an [`interval`](selection.html#type) selection. All properties
/// and transformations
/// for an interval selection definition (except `type`) may be specified here.
///
/// For instance, setting `interval` to `{"translate": false}` disables the ability to move
/// interval selections by default.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IntervalSelectionConfig {
    /// Establishes a two-way binding between the interval selection and the scales
    /// used within the same view. This allows a user to interactively pan and
    /// zoom the view.
    pub bind: Option<BindEnum>,

    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    pub empty: Option<Empty>,

    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    pub encodings: Option<Vec<SingleDefChannel>>,

    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    pub fields: Option<Vec<String>>,

    /// An interval selection also adds a rectangle mark to depict the
    /// extents of the interval. The `mark` property can be used to customize the
    /// appearance of the mark.
    pub mark: Option<BrushConfig>,

    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    pub on: Option<serde_json::Value>,

    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    pub resolve: Option<SelectionResolution>,

    /// When truthy, allows a user to interactively move an interval selection
    /// back-and-forth. Can be `true`, `false` (to disable panning), or a
    /// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    /// which must include a start and end event to trigger continuous panning.
    ///
    /// __Default value:__ `true`, which corresponds to
    /// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    /// clicks and dragging within an interval selection to reposition it.
    pub translate: Option<Translate>,

    /// When truthy, allows a user to interactively resize an interval selection.
    /// Can be `true`, `false` (to disable zooming), or a [Vega event stream
    /// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    /// only `wheel` events are supported.
    ///
    ///
    /// __Default value:__ `true`, which corresponds to `wheel!`.
    pub zoom: Option<Translate>,
}

/// Establishes a two-way binding between the interval selection and the scales
/// used within the same view. This allows a user to interactively pan and
/// zoom the view.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum BindEnum {
    Scales,
}

/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Empty {
    All,

    #[serde(rename = "none")]
    EmptyNone,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SingleDefChannel {
    X,

    Y,

    X2,

    Y2,

    Row,

    Column,

    Size,

    Shape,

    Color,

    Opacity,

    Text,

    Tooltip,

    Href,
}

/// An interval selection also adds a rectangle mark to depict the
/// extents of the interval. The `mark` property can be used to customize the
/// appearance of the mark.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BrushConfig {
    /// The fill color of the interval mark.
    ///
    /// __Default value:__ `#333333`
    pub fill: Option<String>,

    /// The fill opacity of the interval mark (a value between 0 and 1).
    ///
    /// __Default value:__ `0.125`
    pub fill_opacity: Option<f64>,

    /// The stroke color of the interval mark.
    ///
    /// __Default value:__ `#ffffff`
    pub stroke: Option<String>,

    /// An array of alternating stroke and space lengths,
    /// for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) with which to begin drawing the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity of the interval mark (a value between 0 and 1).
    pub stroke_opacity: Option<f64>,

    /// The stroke width of the interval mark.
    pub stroke_width: Option<f64>,
}

/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SelectionResolution {
    Global,

    Union,

    Intersect,
}

/// When truthy, allows a user to interactively move an interval selection
/// back-and-forth. Can be `true`, `false` (to disable panning), or a
/// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
/// which must include a start and end event to trigger continuous panning.
///
/// __Default value:__ `true`, which corresponds to
/// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
/// clicks and dragging within an interval selection to reposition it.
///
/// When truthy, allows a user to interactively resize an interval selection.
/// Can be `true`, `false` (to disable zooming), or a [Vega event stream
/// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
/// only `wheel` events are supported.
///
///
/// __Default value:__ `true`, which corresponds to `wheel!`.
///
/// Controls whether data values should be toggled or only ever inserted into
/// multi selections. Can be `true`, `false` (for insertion only), or a
/// [Vega expression](https://vega.github.io/vega/docs/expressions/).
///
/// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
/// data values are toggled when a user interacts with the shift-key pressed).
///
/// See the [toggle transform](toggle.html) documentation for more information.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Translate {
    Bool(bool),

    PurpleString(String),
}

/// The default definition for a [`multi`](selection.html#type) selection. All properties and
/// transformations
/// for a multi selection definition (except `type`) may be specified here.
///
/// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
/// multi selections when clicking with the alt-key pressed by default.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MultiSelectionConfig {
    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    pub empty: Option<Empty>,

    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    pub encodings: Option<Vec<SingleDefChannel>>,

    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    pub fields: Option<Vec<String>>,

    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    pub nearest: Option<bool>,

    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    pub on: Option<serde_json::Value>,

    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    pub resolve: Option<SelectionResolution>,

    /// Controls whether data values should be toggled or only ever inserted into
    /// multi selections. Can be `true`, `false` (for insertion only), or a
    /// [Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    /// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    /// data values are toggled when a user interacts with the shift-key pressed).
    ///
    /// See the [toggle transform](toggle.html) documentation for more information.
    pub toggle: Option<Translate>,
}

/// The default definition for a [`single`](selection.html#type) selection. All properties
/// and transformations
/// for a single selection definition (except `type`) may be specified here.
///
/// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
/// double-click by default.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SingleSelectionConfig {
    /// Establish a two-way binding between a single selection and input elements
    /// (also known as dynamic query widgets). A binding takes the form of
    /// Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    /// or can be a mapping between projected field/encodings and binding definitions.
    ///
    /// See the [bind transform](bind.html) documentation for more information.
    pub bind: Option<HashMap<String, VgBinding>>,

    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    pub empty: Option<Empty>,

    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    pub encodings: Option<Vec<SingleDefChannel>>,

    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    pub fields: Option<Vec<String>>,

    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    pub nearest: Option<bool>,

    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    pub on: Option<serde_json::Value>,

    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    pub resolve: Option<SelectionResolution>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VgBinding {
    pub element: Option<String>,

    pub input: String,

    pub options: Option<Vec<String>>,

    pub max: Option<f64>,

    pub min: Option<f64>,

    pub step: Option<f64>,
}

/// Default stack offset for stackable mark.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum StackOffset {
    Zero,

    Center,

    Normalize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct VgMarkConfig {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,
}

/// Text-Specific Config
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TextConfig {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub color: Option<String>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub filled: Option<bool>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// Whether month names and weekday names should be abbreviated.
    pub short_time_labels: Option<bool>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,
}

/// Tick-Specific Config
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TickConfig {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The width of the ticks.
    ///
    /// __Default value:__  2/3 of rangeStep.
    pub band_size: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub color: Option<String>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub filled: Option<bool>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,

    /// Thickness of the tick mark.
    ///
    /// __Default value:__  `1`
    pub thickness: Option<f64>,
}

/// Title configuration, which determines default properties for all [titles](title.html).
/// For a full list of title configuration options, please see the [corresponding section of
/// the title documentation](title.html#config).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct VgTitleConfig {
    /// The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    /// example, with an orientation of top these anchor positions map to a left-, center-, or
    /// right-aligned title.
    ///
    /// __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    /// `"start"` for other composite views.
    ///
    /// __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    /// customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    /// composite views, `anchor` is always `"start"`.
    pub anchor: Option<Anchor>,

    /// Angle in degrees of title text.
    pub angle: Option<f64>,

    /// Vertical text baseline for title text.
    pub baseline: Option<VerticalAlign>,

    /// Text color for title text.
    pub color: Option<String>,

    /// Font name for title text.
    pub font: Option<String>,

    /// Font size in pixels for title text.
    ///
    /// __Default value:__ `10`.
    pub font_size: Option<f64>,

    /// Font weight for title text.
    pub font_weight: Option<FontWeightUnion>,

    /// The maximum allowed length in pixels of legend labels.
    pub limit: Option<f64>,

    /// Offset in pixels of the title from the chart body and axes.
    pub offset: Option<f64>,

    /// Default title orientation ("top", "bottom", "left", or "right")
    pub orient: Option<TitleOrient>,
}

/// The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
/// example, with an orientation of top these anchor positions map to a left-, center-, or
/// right-aligned title.
///
/// __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
/// `"start"` for other composite views.
///
/// __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
/// customizable only for [single](spec.html) and [layered](layer.html) views.  For other
/// composite views, `anchor` is always `"start"`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Anchor {
    Start,

    Middle,

    End,
}

/// Default title orientation ("top", "bottom", "left", or "right")
///
/// The orientation of the title relative to the chart. One of `"top"` (the default),
/// `"bottom"`, `"left"`, or `"right"`.
///
/// The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
/// orientation can be used to further specialize the axis type (e.g., a y axis oriented for
/// the right edge of the chart).
///
/// __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum TitleOrient {
    Top,

    Bottom,

    Left,

    Right,
}

/// Default properties for [single view plots](spec.html#single).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ViewConfig {
    /// Whether the view should be clipped.
    pub clip: Option<bool>,

    /// The fill color.
    ///
    /// __Default value:__ (none)
    pub fill: Option<String>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ (none)
    pub fill_opacity: Option<f64>,

    /// The default height of the single plot or each plot in a trellis plot when the
    /// visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
    ///
    /// __Default value:__ `200`
    pub height: Option<f64>,

    /// The stroke color.
    ///
    /// __Default value:__ (none)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    ///
    /// __Default value:__ (none)
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    ///
    /// __Default value:__ (none)
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ (none)
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    ///
    /// __Default value:__ (none)
    pub stroke_width: Option<f64>,

    /// The default width of the single plot or each plot in a trellis plot when the
    /// visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
    /// = `null`.
    ///
    /// __Default value:__ `200`
    pub width: Option<f64>,
}

/// An object describing the data source
///
/// Secondary data source to lookup in.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Data {
    /// An object that specifies the format for parsing the data file.
    ///
    /// An object that specifies the format for parsing the data values.
    ///
    /// An object that specifies the format for parsing the data.
    pub format: Option<DataFormat>,

    /// An URL from which to load the data set. Use the `format.type` property
    /// to ensure the loaded data is correctly parsed.
    pub url: Option<String>,

    /// The full data set, included inline. This can be an array of objects or primitive values
    /// or a string.
    /// Arrays of primitive values are ingested as objects with a `data` property. Strings are
    /// parsed according to the specified format type.
    pub values: Option<Values>,

    /// Provide a placeholder name and bind data at runtime.
    pub name: Option<String>,
}

/// An object that specifies the format for parsing the data file.
///
/// An object that specifies the format for parsing the data values.
///
/// An object that specifies the format for parsing the data.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DataFormat {
    /// If set to auto (the default), perform automatic type inference to determine the desired
    /// data types.
    /// Alternatively, a parsing directive object can be provided for explicit data types. Each
    /// property of the object corresponds to a field name, and the value to the desired data
    /// type (one of `"number"`, `"boolean"` or `"date"`).
    /// For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
    /// input record a Date value.
    ///
    /// For `"date"`, we parse data based using Javascript's
    /// [`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
    /// For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
    /// [d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
    /// format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
    /// [UTC time](timeunit.html#utc)
    pub parse: Option<ParseUnion>,

    /// Type of input data: `"json"`, `"csv"`, `"tsv"`.
    /// The default format type is determined by the extension of the file URL.
    /// If no extension is detected, `"json"` will be used by default.
    #[serde(rename = "type")]
    pub data_format_type: Option<DataFormatType>,

    /// The JSON property containing the desired data.
    /// This parameter can be used when the loaded JSON file may have surrounding structure or
    /// meta-data.
    /// For example `"property": "values.features"` is equivalent to retrieving
    /// `json.values.features`
    /// from the loaded JSON object.
    pub property: Option<String>,

    /// The name of the TopoJSON object set to convert to a GeoJSON feature collection.
    /// For example, in a map of the world, there may be an object set named `"countries"`.
    /// Using the feature property, we can extract this set and generate a GeoJSON feature object
    /// for each country.
    pub feature: Option<String>,

    /// The name of the TopoJSON object set to convert to mesh.
    /// Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
    /// Unlike the `feature` option, the corresponding geo data is returned as a single, unified
    /// mesh instance, not as individual GeoJSON features.
    /// Extracting a mesh is useful for more efficiently drawing borders or other geographic
    /// elements that you do not need to associate with specific regions such as individual
    /// countries, states or counties.
    pub mesh: Option<String>,
}

/// Type of input data: `"json"`, `"csv"`, `"tsv"`.
/// The default format type is determined by the extension of the file URL.
/// If no extension is detected, `"json"` will be used by default.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum DataFormatType {
    Csv,

    Tsv,

    Json,

    Topojson,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ParseUnion {
    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    Enum(ParseEnum),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ParseEnum {
    Auto,
}

/// The full data set, included inline. This can be an array of objects or primitive values
/// or a string.
/// Arrays of primitive values are ingested as objects with a `data` property. Strings are
/// parsed according to the specified format type.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Values {
    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    PurpleString(String),

    UnionArray(Vec<ValuesValue>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ValuesValue {
    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    PurpleString(String),
}

/// A key-value mapping between encoding channels and definition of fields.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EncodingWithFacet {
    /// Color of the marks – either fill or stroke color based on mark type.
    /// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    /// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    /// __Default value:__ If undefined, the default color depends on [mark
    /// config](config.html#mark)'s `color` property.
    ///
    /// _Note:_ See the scale documentation for more information about customizing [color
    /// scheme](scale.html#scheme).
    pub color: Option<MarkPropDefWithCondition>,

    /// Horizontal facets for trellis plots.
    pub column: Option<FacetFieldDef>,

    /// Additional levels of detail for grouping data in aggregate views and
    /// in line and area marks without mapping data to a specific visual channel.
    pub detail: Option<Detail>,

    /// A URL to load upon mouse click.
    pub href: Option<DefWithCondition>,

    /// Opacity of the marks – either can be a value or a range.
    ///
    /// __Default value:__ If undefined, the default opacity depends on [mark
    /// config](config.html#mark)'s `opacity` property.
    pub opacity: Option<MarkPropDefWithCondition>,

    /// Stack order for stacked marks or order of data points in line marks for connected scatter
    /// plots.
    ///
    /// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    /// additional aggregation grouping.
    pub order: Option<Order>,

    /// Vertical facets for trellis plots.
    pub row: Option<FacetFieldDef>,

    /// For `point` marks the supported values are
    /// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    /// or `"triangle-down"`, or else a custom SVG path string.
    /// For `geoshape` marks it should be a field definition of the geojson data
    ///
    /// __Default value:__ If undefined, the default shape depends on [mark
    /// config](config.html#point-config)'s `shape` property.
    pub shape: Option<MarkPropDefWithCondition>,

    /// Size of the mark.
    /// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    /// - For `"bar"` and `"tick"` – the bar and tick's size.
    /// - For `"text"` – the text's font size.
    /// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    pub size: Option<MarkPropDefWithCondition>,

    /// Text of the `text` mark.
    pub text: Option<TextDefWithCondition>,

    /// The tooltip text to show upon mouse hover.
    pub tooltip: Option<TextDefWithCondition>,

    /// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    pub x: Option<XClass>,

    /// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    pub x2: Option<X2Class>,

    /// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    pub y: Option<XClass>,

    /// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    pub y2: Option<X2Class>,
}

/// Color of the marks – either fill or stroke color based on mark type.
/// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
/// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
///
/// __Default value:__ If undefined, the default color depends on [mark
/// config](config.html#mark)'s `color` property.
///
/// _Note:_ See the scale documentation for more information about customizing [color
/// scheme](scale.html#scheme).
///
/// Opacity of the marks – either can be a value or a range.
///
/// __Default value:__ If undefined, the default opacity depends on [mark
/// config](config.html#mark)'s `opacity` property.
///
/// For `point` marks the supported values are
/// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
/// or `"triangle-down"`, or else a custom SVG path string.
/// For `geoshape` marks it should be a field definition of the geojson data
///
/// __Default value:__ If undefined, the default shape depends on [mark
/// config](config.html#point-config)'s `shape` property.
///
/// Size of the mark.
/// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
/// - For `"bar"` and `"tick"` – the bar and tick's size.
/// - For `"text"` – the text's font size.
/// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
///
/// A FieldDef with Condition<ValueDef>
/// {
/// condition: {value: ...},
/// field: ...,
/// ...
/// }
///
/// A ValueDef with Condition<ValueDef | FieldDef>
/// {
/// condition: {field: ...} | {value: ...},
/// value: ...,
/// }
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MarkPropDefWithCondition {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    pub condition: Option<ColorCondition>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// An object defining properties of the legend.
    /// If `null`, the legend for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    pub legend: Option<Legend>,

    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    pub scale: Option<Scale>,

    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    pub sort: Option<SortUnion>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub mark_prop_def_with_condition_type: Option<Type>,

    /// A constant value in visual domain.
    pub value: Option<ConditionalPredicateValueDefValue>,
}

/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
///
/// An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
/// (e.g., `"count"`, `"mean"` and `"median"`).
/// This property is required in cases where the sort field and the data reference field do
/// not match.
/// The input data objects will be aggregated, grouped by the encoded data field.
///
/// For a full list of operations, please see the documentation for
/// [aggregate](aggregate.html#ops).
///
/// The aggregation operations to apply to the fields, such as sum, average or count.
/// See the [full list of supported aggregation
/// operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
/// for more information.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum AggregateOp {
    Argmax,

    Argmin,

    Average,

    Count,

    Distinct,

    Max,

    Mean,

    Median,

    Min,

    Missing,

    Q1,

    Q3,

    Ci0,

    Ci1,

    Stdev,

    Stdevp,

    Sum,

    Valid,

    Values,

    Variance,

    Variancep,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bin {
    BinParams(BinParams),

    Bool(bool),
}

/// Binning properties or boolean flag for determining whether to bin data or not.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BinParams {
    /// The number base to use for automatic bin determination (default is base 10).
    ///
    /// __Default value:__ `10`
    pub base: Option<f64>,

    /// Scale factors indicating allowable subdivisions. The default value is [5, 2], which
    /// indicates that for base 10 numbers (the default base), the method may consider dividing
    /// bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
    /// check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
    /// given constraints.
    ///
    /// __Default value:__ `[5, 2]`
    pub divide: Option<Vec<f64>>,

    /// A two-element (`[min, max]`) array indicating the range of desired bin values.
    pub extent: Option<Vec<f64>>,

    /// Maximum number of bins.
    ///
    /// __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
    pub maxbins: Option<f64>,

    /// A minimum allowable step size (particularly useful for integer values).
    pub minstep: Option<f64>,

    /// If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
    /// such as multiples of ten.
    pub nice: Option<bool>,

    /// An exact step size to use between bins.
    ///
    /// __Note:__ If provided, options such as maxbins will be ignored.
    pub step: Option<f64>,

    /// An array of allowable step sizes to choose from.
    pub steps: Option<Vec<f64>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ColorCondition {
    ConditionalPredicateMarkPropFieldDefClass(ConditionalPredicateMarkPropFieldDefClass),

    ConditionalValueDefArray(Vec<ConditionalValueDef>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConditionalValueDef {
    pub test: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: ConditionalValueDefValue,

    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    pub selection: Option<Box<ConditionalValueDefSelectionOperand>>,
}

/// Filter using a selection name.
///
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SelectionOperandElement {
    PurpleString(String),

    Selection(Selection),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Selection {
    pub not: Option<Box<ConditionalValueDefSelectionOperand>>,

    pub and: Option<Vec<SelectionOperandElement>>,

    pub or: Option<Vec<SelectionOperandElement>>,
}

/// Filter using a selection name.
///
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ConditionalValueDefSelectionOperand {
    PurpleString(String),

    Selection(Selection),
}

/// The `filter` property must be one of the predicate definitions:
/// (1) an [expression](types.html#expression) string,
/// where `datum` can be used to refer to the current data object;
/// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
/// [range predicate](filter.html#range-predicate), [one-of
/// predicate](filter.html#one-of-predicate);
/// (3) a [selection predicate](filter.html#selection-predicate);
/// or (4) a logical operand that combines (1), (2), or (3).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LogicalOperandPredicateElement {
    Predicate(Predicate),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Predicate {
    pub not: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    pub and: Option<Vec<LogicalOperandPredicateElement>>,

    pub or: Option<Vec<LogicalOperandPredicateElement>>,

    /// The value that the field should be equal to.
    pub equal: Option<EqualUnion>,

    /// Field to be filtered.
    ///
    /// Field to be filtered
    pub field: Option<String>,

    /// Time unit for the field to be filtered.
    ///
    /// time unit for the field to be filtered.
    pub time_unit: Option<TimeUnit>,

    /// An array of inclusive minimum and maximum values
    /// for a field value of a data item to be included in the filtered data.
    pub range: Option<Vec<Option<RangeElement>>>,

    /// A set of values that the `field`'s value should be a member of,
    /// for a data item included in the filtered data.
    pub one_of: Option<Vec<OneOfElement>>,

    /// Filter using a selection name.
    pub selection: Option<Box<ConditionalValueDefSelectionOperand>>,
}

/// The `filter` property must be one of the predicate definitions:
/// (1) an [expression](types.html#expression) string,
/// where `datum` can be used to refer to the current data object;
/// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
/// [range predicate](filter.html#range-predicate), [one-of
/// predicate](filter.html#one-of-predicate);
/// (3) a [selection predicate](filter.html#selection-predicate);
/// or (4) a logical operand that combines (1), (2), or (3).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ConditionalValueDefLogicalOperandPredicate {
    Predicate(Predicate),

    PurpleString(String),
}

/// The value that the field should be equal to.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum EqualUnion {
    Bool(bool),

    DateTime(DateTime),

    Double(f64),

    PurpleString(String),
}

/// Object for defining datetime in Vega-Lite Filter.
/// If both month and quarter are provided, month has higher precedence.
/// `day` cannot be combined with other date.
/// We accept string for month and day names.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DateTime {
    /// Integer value representing the date from 1-31.
    pub date: Option<f64>,

    /// Value representing the day of a week.  This can be one of: (1) integer value -- `1`
    /// represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
    /// case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
    /// DateTime definition object with `day`** should not be combined with `year`, `quarter`,
    /// `month`, or `date`.
    pub day: Option<Day>,

    /// Integer value representing the hour of a day from 0-23.
    pub hours: Option<f64>,

    /// Integer value representing the millisecond segment of time.
    pub milliseconds: Option<f64>,

    /// Integer value representing the minute segment of time from 0-59.
    pub minutes: Option<f64>,

    /// One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
    /// (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
    /// short month name (e.g., `"Jan"`).
    pub month: Option<Month>,

    /// Integer value representing the quarter of the year (from 1-4).
    pub quarter: Option<f64>,

    /// Integer value representing the second segment (0-59) of a time value
    pub seconds: Option<f64>,

    /// A boolean flag indicating if date time is in utc time. If false, the date time is in
    /// local time
    pub utc: Option<bool>,

    /// Integer value representing the year.
    pub year: Option<f64>,
}

/// Value representing the day of a week.  This can be one of: (1) integer value -- `1`
/// represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
/// case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
/// DateTime definition object with `day`** should not be combined with `year`, `quarter`,
/// `month`, or `date`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Day {
    Double(f64),

    PurpleString(String),
}

/// One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
/// (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
/// short month name (e.g., `"Jan"`).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Month {
    Double(f64),

    PurpleString(String),
}

/// The value that the field should be equal to.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum OneOfElement {
    Bool(bool),

    DateTime(DateTime),

    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum RangeElement {
    DateTime(DateTime),

    Double(f64),
}

/// Time unit for the field to be filtered.
///
/// time unit for the field to be filtered.
///
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
///
/// The timeUnit.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum TimeUnit {
    Year,

    Quarter,

    Month,

    Day,

    Date,

    Hours,

    Minutes,

    Seconds,

    Milliseconds,

    Utcyear,

    Utcquarter,

    Utcmonth,

    Utcday,

    Utcdate,

    Utchours,

    Utcminutes,

    Utcseconds,

    Utcmilliseconds,

    Yearquarter,

    Yearquartermonth,

    Yearmonth,

    Yearmonthdate,

    Yearmonthdatehours,

    Yearmonthdatehoursminutes,

    Yearmonthdatehoursminutesseconds,

    Quartermonth,

    Monthdate,

    Hoursminutes,

    Hoursminutesseconds,

    Minutesseconds,

    Secondsmilliseconds,

    Utcyearquarter,

    Utcyearquartermonth,

    Utcyearmonth,

    Utcyearmonthdate,

    Utcyearmonthdatehours,

    Utcyearmonthdatehoursminutes,

    Utcyearmonthdatehoursminutesseconds,

    Utcquartermonth,

    Utcmonthdate,

    Utchoursminutes,

    Utchoursminutesseconds,

    Utcminutesseconds,

    Utcsecondsmilliseconds,
}

/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
///
/// A constant value in visual domain.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ConditionalValueDefValue {
    Bool(bool),

    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConditionalPredicateMarkPropFieldDefClass {
    pub test: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: Option<ConditionalPredicateValueDefValue>,

    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    pub selection: Option<Box<ConditionalValueDefSelectionOperand>>,

    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// An object defining properties of the legend.
    /// If `null`, the legend for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    pub legend: Option<Legend>,

    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    pub scale: Option<Scale>,

    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    pub sort: Option<SortUnion>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub conditional_def_type: Option<Type>,
}

/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
///
/// Constants and utilities for data type
/// Data type based on level of measurement
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Type {
    Quantitative,

    Ordinal,

    Temporal,

    Nominal,

    Latitude,

    Longitude,

    Geojson,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Field {
    PurpleString(String),

    RepeatRef(RepeatRef),
}

/// Reference to a repeated value.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RepeatRef {
    pub repeat: RepeatEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum RepeatEnum {
    Row,

    Column,
}

/// Properties of a legend or boolean flag for determining whether to show it.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Legend {
    /// Padding (in pixels) between legend entries in a symbol legend.
    pub entry_padding: Option<f64>,

    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    pub format: Option<String>,

    /// The offset, in pixels, by which to displace the legend from the edge of the enclosing
    /// group or data rectangle.
    ///
    /// __Default value:__  `0`
    pub offset: Option<f64>,

    /// The orientation of the legend, which determines how the legend is positioned within the
    /// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    /// "none".
    ///
    /// __Default value:__ `"right"`
    pub orient: Option<LegendOrient>,

    /// The padding, in pixels, between the legend and axis.
    pub padding: Option<f64>,

    /// The desired number of tick values for quantitative legends.
    pub tick_count: Option<f64>,

    /// A title for the field. If `null`, the title will be removed.
    ///
    /// __Default value:__  derived from the field's name and transformation function
    /// (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    /// function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    /// binned or has a time unit applied, the applied function will be denoted in parentheses
    /// (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    /// simply the field name.
    ///
    /// __Note__: You can customize the default field title format by providing the [`fieldTitle`
    /// property in the [config](config.html) or [`fieldTitle` function via the `compile`
    /// function's options](compile.html#field-title).
    pub title: Option<String>,

    /// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
    /// continuous color gradient.
    ///
    /// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
    /// `"symbol"` otherwise.
    #[serde(rename = "type")]
    pub legend_type: Option<LegendType>,

    /// Explicitly set the visible legend values.
    pub values: Option<Vec<LegendValue>>,

    /// A non-positive integer indicating z-index of the legend.
    /// If zindex is 0, legend should be drawn behind all chart elements.
    /// To put them in front, use zindex = 1.
    pub zindex: Option<f64>,
}

/// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
/// continuous color gradient.
///
/// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
/// `"symbol"` otherwise.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum LegendType {
    Symbol,

    Gradient,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LegendValue {
    DateTime(DateTime),

    Double(f64),

    PurpleString(String),
}

/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Scale {
    /// The logarithm base of the `log` scale (default `10`).
    pub base: Option<f64>,

    /// If `true`, values that exceed the data domain are clamped to either the minimum or
    /// maximum range value
    ///
    /// __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
    /// (`true` by default).
    pub clamp: Option<bool>,

    /// Customized domain values.
    ///
    /// For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
    /// and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
    /// a `domain` with more than two entries.
    /// If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
    /// indicating that the domain should include the raw data values prior to the aggregation.
    ///
    /// For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
    /// the form of either timestamps or the [DateTime definition objects](types.html#datetime).
    ///
    /// For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
    /// values.
    ///
    /// The `selection` property can be used to [interactively
    /// determine](selection.html#scale-domains) the scale domain.
    pub domain: Option<DomainUnion>,

    /// The exponent of the `pow` scale.
    pub exponent: Option<f64>,

    /// The interpolation method for range values. By default, a general interpolator for
    /// numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
    /// property allows interpolation in alternative color spaces. Legal values include `rgb`,
    /// `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
    /// variants use longer paths in polar coordinate spaces). If object-valued, this property
    /// accepts an object with a string-valued _type_ property and an optional numeric _gamma_
    /// property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
    /// documentation](https://github.com/d3/d3-interpolate).
    ///
    /// __Note:__ Sequential scales do not support `interpolate` as they have a fixed
    /// interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
    /// you have to set the scale `type` to other quantitative scale type such as `"linear"` to
    /// customize `interpolate`.
    pub interpolate: Option<InterpolateUnion>,

    /// Extending the domain so that it starts and ends on nice round values. This method
    /// typically modifies the scale’s domain, and may only extend the bounds to the nearest
    /// round value. Nicing is useful if the domain is computed from data and may be irregular.
    /// For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
    /// 1.0]_.
    ///
    /// For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
    /// If `nice` is a number, it will represent a desired tick count. This allows greater
    /// control over the step size used to extend the bounds, guaranteeing that the returned
    /// ticks will exactly cover the domain.
    ///
    /// For temporal fields with time and utc scales, the `nice` value can be a string indicating
    /// the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
    /// `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
    /// scales can accept an object-valued interval specifier of the form `{"interval": "month",
    /// "step": 3}`, which includes a desired number of interval steps. Here, the domain would
    /// snap to quarter (Jan, Apr, Jul, Oct) boundaries.
    ///
    /// __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
    pub nice: Option<NiceUnion>,

    /// For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
    /// the specified number of pixels on each of the scale range. The scale range must represent
    /// pixels for this parameter to function as intended. Padding adjustment is performed prior
    /// to all other adjustments, including the effects of the zero, nice, domainMin, and
    /// domainMax properties.
    ///
    /// For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
    /// `paddingOuter` to the same value.
    ///
    /// For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
    ///
    /// __Default value:__ For _continuous_ scales, derived from the [scale
    /// config](scale.html#config)'s `continuousPadding`.
    /// For _band and point_ scales, see `paddingInner` and `paddingOuter`.
    pub padding: Option<f64>,

    /// The inner padding (spacing) within each band step of band scales, as a fraction of the
    /// step size. This value must lie in the range [0,1].
    ///
    /// For point scale, this property is invalid as point scales do not have internal band
    /// widths (only step sizes between bands).
    ///
    /// __Default value:__ derived from the [scale config](scale.html#config)'s
    /// `bandPaddingInner`.
    pub padding_inner: Option<f64>,

    /// The outer padding (spacing) at the ends of the range of band and point scales,
    /// as a fraction of the step size. This value must lie in the range [0,1].
    ///
    /// __Default value:__ derived from the [scale config](scale.html#config)'s
    /// `bandPaddingOuter` for band scales and `pointPadding` for point scales.
    pub padding_outer: Option<f64>,

    /// The range of the scale. One of:
    ///
    /// - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
    /// example, `"symbol"`, or `"diverging"`).
    ///
    /// - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
    /// and maximum values, or an array with more than two entries for specifying a [piecewise
    /// scale](scale.html#piecewise).
    ///
    /// - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
    /// an array of desired output values.
    ///
    /// __Notes:__
    ///
    /// 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
    /// discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
    /// instead of `range`.
    ///
    /// 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
    /// customized via the view's corresponding [size](size.html) (`width` and `height`) or via
    /// [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
    /// scales.
    pub range: Option<ScaleRange>,

    /// The distance between the starts of adjacent bands or points in [band](scale.html#band)
    /// and [point](scale.html#point) scales.
    ///
    /// If `rangeStep` is `null` or if the view contains the scale's corresponding
    /// [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
    /// be automatically determined to fit the size of the view.
    ///
    /// __Default value:__  derived the [scale config](config.html#scale-config)'s
    /// `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
    /// default) for x-scales of other marks and y-scales.
    ///
    /// __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
    /// than `width` or `height`, the rangeStep might become less than one pixel and the mark
    /// might not appear correctly.
    pub range_step: Option<f64>,

    /// If `true`, rounds numeric output values to integers. This can be helpful for snapping to
    /// the pixel grid.
    ///
    /// __Default value:__ `false`.
    pub round: Option<bool>,

    /// A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
    /// `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
    ///
    /// Discrete color schemes may be used with [discrete](scale.html#discrete) or
    /// [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
    /// use with [sequential](scales.html#sequential) scales.
    ///
    /// For the full list of supported scheme, please refer to the [Vega
    /// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    pub scheme: Option<Scheme>,

    /// The type of scale.  Vega-Lite supports the following categories of scale types:
    ///
    /// 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
    /// continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
    /// [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
    /// [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
    ///
    /// 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
    /// ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
    /// [`"point"`](scale.html#point)) output ranges.
    ///
    /// 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
    /// discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
    /// [`"bin-ordinal"`](scale.html#bin-ordinal)).
    ///
    /// __Default value:__ please see the [scale type table](scale.html#type).
    #[serde(rename = "type")]
    pub scale_type: Option<ScaleType>,

    /// If `true`, ensures that a zero baseline value is included in the scale domain.
    ///
    /// __Default value:__ `true` for x and y channels if the quantitative field is not binned
    /// and no custom `domain` is provided; `false` otherwise.
    ///
    /// __Note:__ Log, time, and utc scales do not support `zero`.
    pub zero: Option<bool>,
}

/// Customized domain values.
///
/// For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
/// and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
/// a `domain` with more than two entries.
/// If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
/// indicating that the domain should include the raw data values prior to the aggregation.
///
/// For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
/// the form of either timestamps or the [DateTime definition objects](types.html#datetime).
///
/// For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
/// values.
///
/// The `selection` property can be used to [interactively
/// determine](selection.html#scale-domains) the scale domain.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum DomainUnion {
    DomainClass(DomainClass),

    Enum(Domain),

    UnionArray(Vec<OneOfElement>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DomainClass {
    /// The field name to extract selected values for, when a selection is
    /// [projected](project.html)
    /// over multiple fields or encodings.
    pub field: Option<String>,

    /// The name of a selection.
    pub selection: String,

    /// The encoding channel to extract selected values for, when a selection is
    /// [projected](project.html)
    /// over multiple fields or encodings.
    pub encoding: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Domain {
    Unaggregated,
}

/// The interpolation method for range values. By default, a general interpolator for
/// numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
/// property allows interpolation in alternative color spaces. Legal values include `rgb`,
/// `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
/// variants use longer paths in polar coordinate spaces). If object-valued, this property
/// accepts an object with a string-valued _type_ property and an optional numeric _gamma_
/// property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
/// documentation](https://github.com/d3/d3-interpolate).
///
/// __Note:__ Sequential scales do not support `interpolate` as they have a fixed
/// interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
/// you have to set the scale `type` to other quantitative scale type such as `"linear"` to
/// customize `interpolate`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum InterpolateUnion {
    Enum(Interpolate),

    InterpolateParams(InterpolateParams),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct InterpolateParams {
    pub gamma: Option<f64>,

    #[serde(rename = "type")]
    pub interpolate_params_type: InterpolateParamsType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum InterpolateParamsType {
    Rgb,

    Cubehelix,

    #[serde(rename = "cubehelix-long")]
    CubehelixLong,
}

/// Extending the domain so that it starts and ends on nice round values. This method
/// typically modifies the scale’s domain, and may only extend the bounds to the nearest
/// round value. Nicing is useful if the domain is computed from data and may be irregular.
/// For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
/// 1.0]_.
///
/// For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
/// If `nice` is a number, it will represent a desired tick count. This allows greater
/// control over the step size used to extend the bounds, guaranteeing that the returned
/// ticks will exactly cover the domain.
///
/// For temporal fields with time and utc scales, the `nice` value can be a string indicating
/// the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
/// `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
/// scales can accept an object-valued interval specifier of the form `{"interval": "month",
/// "step": 3}`, which includes a desired number of interval steps. Here, the domain would
/// snap to quarter (Jan, Apr, Jul, Oct) boundaries.
///
/// __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum NiceUnion {
    Bool(bool),

    Double(f64),

    Enum(NiceTime),

    NiceClass(NiceClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NiceClass {
    pub interval: String,

    pub step: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum NiceTime {
    Second,

    Minute,

    Hour,

    Day,

    Week,

    Month,

    Year,
}

/// The range of the scale. One of:
///
/// - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
/// example, `"symbol"`, or `"diverging"`).
///
/// - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
/// and maximum values, or an array with more than two entries for specifying a [piecewise
/// scale](scale.html#piecewise).
///
/// - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
/// an array of desired output values.
///
/// __Notes:__
///
/// 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
/// discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
/// instead of `range`.
///
/// 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
/// customized via the view's corresponding [size](size.html) (`width` and `height`) or via
/// [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
/// scales.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ScaleRange {
    PurpleString(String),

    UnionArray(Vec<PrecisionValue>),
}

/// The type of scale.  Vega-Lite supports the following categories of scale types:
///
/// 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
/// continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
/// [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
/// [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
///
/// 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
/// ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
/// [`"point"`](scale.html#point)) output ranges.
///
/// 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
/// discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
/// [`"bin-ordinal"`](scale.html#bin-ordinal)).
///
/// __Default value:__ please see the [scale type table](scale.html#type).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum ScaleType {
    Linear,

    #[serde(rename = "bin-linear")]
    BinLinear,

    Log,

    Pow,

    Sqrt,

    Time,

    Utc,

    Sequential,

    Ordinal,

    #[serde(rename = "bin-ordinal")]
    BinOrdinal,

    Point,

    Band,
}

/// A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
/// `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
///
/// Discrete color schemes may be used with [discrete](scale.html#discrete) or
/// [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
/// use with [sequential](scales.html#sequential) scales.
///
/// For the full list of supported scheme, please refer to the [Vega
/// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Scheme {
    PurpleString(String),

    SchemeParams(SchemeParams),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SchemeParams {
    /// For sequential and diverging schemes only, determines the extent of the color range to
    /// use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
    /// range _[0, 0.2)_ are excluded from the scheme.
    pub extent: Option<Vec<f64>>,

    /// A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
    ///
    /// For the full list of supported scheme, please refer to the [Vega
    /// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SortUnion {
    Enum(SortEnum),

    SortField(SortField),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SortField {
    /// The data [field](field.html) to sort by.
    ///
    /// __Default value:__ If unspecified, defaults to the field specified in the outer data
    /// reference.
    pub field: Option<Field>,

    /// An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
    /// (e.g., `"count"`, `"mean"` and `"median"`).
    /// This property is required in cases where the sort field and the data reference field do
    /// not match.
    /// The input data objects will be aggregated, grouped by the encoded data field.
    ///
    /// For a full list of operations, please see the documentation for
    /// [aggregate](aggregate.html#ops).
    pub op: AggregateOp,

    /// The sort order. One of `"ascending"` (default) or `"descending"`.
    pub order: Option<SortEnum>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SortEnum {
    Ascending,

    Descending,
}

/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
///
/// A constant value in visual domain.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ConditionalPredicateValueDefValue {
    Bool(bool),

    Double(f64),

    PurpleString(String),
}

/// Horizontal facets for trellis plots.
///
/// Vertical facets for trellis plots.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FacetFieldDef {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// An object defining properties of a facet's header.
    pub header: Option<Header>,

    /// Sort order for a facet field.
    /// This can be `"ascending"`, `"descending"`.
    pub sort: Option<SortEnum>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub facet_field_def_type: Type,
}

/// An object defining properties of a facet's header.
///
/// Headers of row / column channels for faceted plots.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Header {
    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    pub format: Option<String>,

    /// The rotation angle of the header labels.
    ///
    /// __Default value:__ `0`.
    pub label_angle: Option<f64>,

    /// A title for the field. If `null`, the title will be removed.
    ///
    /// __Default value:__  derived from the field's name and transformation function
    /// (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    /// function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    /// binned or has a time unit applied, the applied function will be denoted in parentheses
    /// (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    /// simply the field name.
    ///
    /// __Note__: You can customize the default field title format by providing the [`fieldTitle`
    /// property in the [config](config.html) or [`fieldTitle` function via the `compile`
    /// function's options](compile.html#field-title).
    pub title: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Detail {
    FieldDef(FieldDef),

    FieldDefArray(Vec<FieldDef>),
}

/// Definition object for a data field, its type and transformation of an encoding channel.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FieldDef {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub field_def_type: Type,
}

/// A URL to load upon mouse click.
///
/// A FieldDef with Condition<ValueDef>
/// {
/// condition: {value: ...},
/// field: ...,
/// ...
/// }
///
/// A ValueDef with Condition<ValueDef | FieldDef>
/// {
/// condition: {field: ...} | {value: ...},
/// value: ...,
/// }
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct DefWithCondition {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    pub condition: Option<HrefCondition>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub def_with_condition_type: Option<Type>,

    /// A constant value in visual domain.
    pub value: Option<ConditionalPredicateValueDefValue>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum HrefCondition {
    ConditionalPredicateFieldDefClass(ConditionalPredicateFieldDefClass),

    ConditionalValueDefArray(Vec<ConditionalValueDef>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConditionalPredicateFieldDefClass {
    pub test: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: Option<ConditionalPredicateValueDefValue>,

    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    pub selection: Option<Box<ConditionalValueDefSelectionOperand>>,

    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub conditional_def_type: Option<Type>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Order {
    OrderFieldDef(OrderFieldDef),

    OrderFieldDefArray(Vec<OrderFieldDef>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct OrderFieldDef {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// The sort order. One of `"ascending"` (default) or `"descending"`.
    pub sort: Option<SortEnum>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub order_field_def_type: Type,
}

/// Text of the `text` mark.
///
/// The tooltip text to show upon mouse hover.
///
/// A FieldDef with Condition<ValueDef>
/// {
/// condition: {value: ...},
/// field: ...,
/// ...
/// }
///
/// A ValueDef with Condition<ValueDef | FieldDef>
/// {
/// condition: {field: ...} | {value: ...},
/// value: ...,
/// }
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TextDefWithCondition {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    pub condition: Option<TextCondition>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// The [formatting pattern](format.html) for a text field. If not defined, this will be
    /// determined automatically.
    pub format: Option<String>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub text_def_with_condition_type: Option<Type>,

    /// A constant value in visual domain.
    pub value: Option<ConditionalPredicateValueDefValue>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TextCondition {
    ConditionalPredicateTextFieldDefClass(ConditionalPredicateTextFieldDefClass),

    ConditionalValueDefArray(Vec<ConditionalValueDef>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConditionalPredicateTextFieldDefClass {
    pub test: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: Option<ConditionalPredicateValueDefValue>,

    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    pub selection: Option<Box<ConditionalValueDefSelectionOperand>>,

    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// The [formatting pattern](format.html) for a text field. If not defined, this will be
    /// determined automatically.
    pub format: Option<String>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub conditional_def_type: Option<Type>,
}

/// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
///
/// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
///
/// Definition object for a constant value of an encoding channel.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct XClass {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// An object defining properties of axis's gridlines, ticks and labels.
    /// If `null`, the axis for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [axis properties](axis.html) are applied.
    pub axis: Option<Axis>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    pub scale: Option<Scale>,

    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    pub sort: Option<SortUnion>,

    /// Type of stacking offset if the field should be stacked.
    /// `stack` is only applicable for `x` and `y` channels with continuous domains.
    /// For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
    ///
    /// `stack` can be one of the following values:
    ///
    /// - `"zero"`: stacking with baseline offset at zero value of the scale (for creating
    /// typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
    /// - `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
    /// and area charts](stack.html#normalized). <br/>
    /// - `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
    /// - `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
    /// area chart.
    ///
    /// __Default value:__ `zero` for plots with all of the following conditions are true:
    ///
    /// 1. The mark is `bar` or `area`;
    /// 2. The stacked measure channel (x or y) has a linear scale;
    /// 3. At least one of non-position channels mapped to an unaggregated field that is
    /// different from x and y.  Otherwise, `null` by default.
    pub stack: Option<StackOffset>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub def_type: Option<Type>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: Option<ConditionalPredicateValueDefValue>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Axis {
    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    pub domain: Option<bool>,

    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    pub format: Option<String>,

    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    pub grid: Option<bool>,

    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    pub label_angle: Option<f64>,

    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    pub label_bound: Option<Label>,

    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    pub label_flush: Option<Label>,

    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    pub label_overlap: Option<LabelOverlapUnion>,

    /// The padding, in pixels, between axis and text labels.
    pub label_padding: Option<f64>,

    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    pub labels: Option<bool>,

    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    pub max_extent: Option<f64>,

    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    pub min_extent: Option<f64>,

    /// The offset, in pixels, by which to displace the axis from the edge of the enclosing group
    /// or data rectangle.
    ///
    /// __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
    /// `offset` (`0` by default)
    pub offset: Option<f64>,

    /// The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
    /// orientation can be used to further specialize the axis type (e.g., a y axis oriented for
    /// the right edge of the chart).
    ///
    /// __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
    pub orient: Option<TitleOrient>,

    /// The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
    /// this sets the axis group x coordinate. For y-axis with left or right orientation, this
    /// sets the axis group y coordinate.
    ///
    /// __Default value__: `0`
    pub position: Option<f64>,

    /// A desired number of ticks, for axes visualizing quantitative scales. The resulting number
    /// may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
    /// underlying scale's range.
    pub tick_count: Option<f64>,

    /// Boolean value that determines whether the axis should include ticks.
    pub ticks: Option<bool>,

    /// The size in pixels of axis ticks.
    pub tick_size: Option<f64>,

    /// A title for the field. If `null`, the title will be removed.
    ///
    /// __Default value:__  derived from the field's name and transformation function
    /// (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    /// function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    /// binned or has a time unit applied, the applied function will be denoted in parentheses
    /// (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    /// simply the field name.
    ///
    /// __Note__: You can customize the default field title format by providing the [`fieldTitle`
    /// property in the [config](config.html) or [`fieldTitle` function via the `compile`
    /// function's options](compile.html#field-title).
    pub title: Option<String>,

    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    pub title_max_length: Option<f64>,

    /// The padding, in pixels, between title and axis.
    pub title_padding: Option<f64>,

    /// Explicitly set the visible axis tick values.
    pub values: Option<Vec<AxisValue>>,

    /// A non-positive integer indicating z-index of the axis.
    /// If zindex is 0, axes should be drawn behind all chart elements.
    /// To put them in front, use `"zindex = 1"`.
    ///
    /// __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
    /// for grids.
    pub zindex: Option<f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AxisValue {
    DateTime(DateTime),

    Double(f64),
}

/// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Definition object for a data field, its type and transformation of an encoding channel.
///
/// Definition object for a constant value of an encoding channel.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct X2Class {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    pub aggregate: Option<AggregateOp>,

    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    pub bin: Option<Bin>,

    /// __Required.__ A string defining the name of the field from which to pull a data value
    /// or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    /// __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    /// (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    /// If field names contain dots or brackets but are not nested, you can use `\\` to escape
    /// dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    /// See more details about escaping in the [field documentation](field.html).
    ///
    /// __Note:__ `field` is not required if `aggregate` is `count`.
    pub field: Option<Field>,

    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    pub time_unit: Option<TimeUnit>,

    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    #[serde(rename = "type")]
    pub def_type: Option<Type>,

    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    pub value: Option<ConditionalPredicateValueDefValue>,
}

/// An object that describes mappings between `row` and `column` channels and their field
/// definitions.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FacetMapping {
    /// Horizontal facets for trellis plots.
    pub column: Option<FacetFieldDef>,

    /// Vertical facets for trellis plots.
    pub row: Option<FacetFieldDef>,
}

/// Unit spec that can have a composite mark.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Spec {
    /// An object describing the data source
    pub data: Option<Data>,

    /// Description of this mark for commenting purpose.
    pub description: Option<String>,

    /// The height of a visualization.
    ///
    /// __Default value:__
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    /// [continuous scale](scale.html#continuous), the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the height is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    /// `rangeStep` is `null`, the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    /// __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the height of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub height: Option<f64>,

    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    pub layer: Option<Vec<LayerSpec>>,

    /// Name of the visualization for later reference.
    pub name: Option<String>,

    /// Scale, axis, and legend resolutions for layers.
    ///
    /// Scale, axis, and legend resolutions for facets.
    ///
    /// Scale and legend resolutions for repeated charts.
    ///
    /// Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    /// Scale, axis, and legend resolutions for horizontally concatenated charts.
    pub resolve: Option<Resolve>,

    /// Title for the plot.
    pub title: Option<Title>,

    /// An array of data transformations such as filter and new field calculation.
    pub transform: Option<Vec<Transform>>,

    /// The width of a visualization.
    ///
    /// __Default value:__ This will be determined by the following rules:
    ///
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    /// [continuous scale](scale.html#continuous), the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the width is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    /// `rangeStep` is `null`, the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - If no field is mapped to `x` channel, the `width` will be the value of
    /// [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    /// the value of `rangeStep` for other marks.
    ///
    /// __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the width of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub width: Option<f64>,

    /// A key-value mapping between encoding channels and definition of fields.
    pub encoding: Option<Encoding>,

    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    pub mark: Option<AnyMark>,

    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    pub projection: Option<Projection>,

    /// A key-value mapping between selection names and definitions.
    pub selection: Option<HashMap<String, SelectionDef>>,

    /// An object that describes mappings between `row` and `column` channels and their field
    /// definitions.
    pub facet: Option<FacetMapping>,

    /// A specification of the view that gets faceted.
    pub spec: Box<Option<Spec>>,

    /// An object that describes what fields should be repeated into views that are laid out as a
    /// `row` or `column`.
    pub repeat: Option<Repeat>,

    /// A list of views that should be concatenated and put into a column.
    pub vconcat: Option<Vec<Spec>>,

    /// A list of views that should be concatenated and put into a row.
    pub hconcat: Option<Vec<Spec>>,
}

/// A key-value mapping between encoding channels and definition of fields.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Encoding {
    /// Color of the marks – either fill or stroke color based on mark type.
    /// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    /// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    /// __Default value:__ If undefined, the default color depends on [mark
    /// config](config.html#mark)'s `color` property.
    ///
    /// _Note:_ See the scale documentation for more information about customizing [color
    /// scheme](scale.html#scheme).
    pub color: Option<MarkPropDefWithCondition>,

    /// Additional levels of detail for grouping data in aggregate views and
    /// in line and area marks without mapping data to a specific visual channel.
    pub detail: Option<Detail>,

    /// A URL to load upon mouse click.
    pub href: Option<DefWithCondition>,

    /// Opacity of the marks – either can be a value or a range.
    ///
    /// __Default value:__ If undefined, the default opacity depends on [mark
    /// config](config.html#mark)'s `opacity` property.
    pub opacity: Option<MarkPropDefWithCondition>,

    /// Stack order for stacked marks or order of data points in line marks for connected scatter
    /// plots.
    ///
    /// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    /// additional aggregation grouping.
    pub order: Option<Order>,

    /// For `point` marks the supported values are
    /// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    /// or `"triangle-down"`, or else a custom SVG path string.
    /// For `geoshape` marks it should be a field definition of the geojson data
    ///
    /// __Default value:__ If undefined, the default shape depends on [mark
    /// config](config.html#point-config)'s `shape` property.
    pub shape: Option<MarkPropDefWithCondition>,

    /// Size of the mark.
    /// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    /// - For `"bar"` and `"tick"` – the bar and tick's size.
    /// - For `"text"` – the text's font size.
    /// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    pub size: Option<MarkPropDefWithCondition>,

    /// Text of the `text` mark.
    pub text: Option<TextDefWithCondition>,

    /// The tooltip text to show upon mouse hover.
    pub tooltip: Option<TextDefWithCondition>,

    /// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    pub x: Option<XClass>,

    /// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    pub x2: Option<X2Class>,

    /// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    pub y: Option<XClass>,

    /// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    pub y2: Option<X2Class>,
}

/// Unit spec that can have a composite mark.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LayerSpec {
    /// An object describing the data source
    pub data: Option<Data>,

    /// Description of this mark for commenting purpose.
    pub description: Option<String>,

    /// The height of a visualization.
    ///
    /// __Default value:__
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    /// [continuous scale](scale.html#continuous), the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the height is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    /// `rangeStep` is `null`, the height will be the value of
    /// [`config.view.height`](spec.html#config).
    /// - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    /// __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the height of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub height: Option<f64>,

    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    pub layer: Option<Vec<LayerSpec>>,

    /// Name of the visualization for later reference.
    pub name: Option<String>,

    /// Scale, axis, and legend resolutions for layers.
    pub resolve: Option<Resolve>,

    /// Title for the plot.
    pub title: Option<Title>,

    /// An array of data transformations such as filter and new field calculation.
    pub transform: Option<Vec<Transform>>,

    /// The width of a visualization.
    ///
    /// __Default value:__ This will be determined by the following rules:
    ///
    /// - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    /// [continuous scale](scale.html#continuous), the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    /// value or unspecified, the width is [determined by the range step, paddings, and the
    /// cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    /// `rangeStep` is `null`, the width will be the value of
    /// [`config.view.width`](spec.html#config).
    /// - If no field is mapped to `x` channel, the `width` will be the value of
    /// [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    /// the value of `rangeStep` for other marks.
    ///
    /// __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    /// represents the width of a single view.
    ///
    /// __See also:__ The documentation for [width and height](size.html) contains more examples.
    pub width: Option<f64>,

    /// A key-value mapping between encoding channels and definition of fields.
    pub encoding: Option<Encoding>,

    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    pub mark: Option<AnyMark>,

    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    pub projection: Option<Projection>,

    /// A key-value mapping between selection names and definitions.
    pub selection: Option<HashMap<String, SelectionDef>>,
}

/// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
/// `"line"`,
/// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
/// object](mark.html#mark-def).
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnyMark {
    Enum(Mark),

    MarkDef(MarkDef),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MarkDef {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    pub align: Option<HorizontalAlign>,

    /// The rotation angle of the text, in degrees.
    pub angle: Option<f64>,

    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    pub baseline: Option<VerticalAlign>,

    /// Whether a mark be clipped to the enclosing group’s width and height.
    pub clip: Option<bool>,

    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub color: Option<String>,

    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    pub cursor: Option<Cursor>,

    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dx: Option<f64>,

    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    pub dy: Option<f64>,

    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub fill: Option<String>,

    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    pub filled: Option<bool>,

    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub fill_opacity: Option<f64>,

    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    pub font: Option<String>,

    /// The font size, in pixels.
    pub font_size: Option<f64>,

    /// The font style (e.g., `"italic"`).
    pub font_style: Option<FontStyle>,

    /// The font weight (e.g., `"bold"`).
    pub font_weight: Option<FontWeightUnion>,

    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    pub href: Option<String>,

    /// The line interpolation method to use for line and area marks. One of the following:
    /// - `"linear"`: piecewise linear segments, as in a polyline.
    /// - `"linear-closed"`: close the linear segments to form a polygon.
    /// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    /// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    /// function.
    /// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    /// function.
    /// - `"basis"`: a B-spline, with control point duplication on the ends.
    /// - `"basis-open"`: an open B-spline; may not intersect the start or end.
    /// - `"basis-closed"`: a closed B-spline, as in a loop.
    /// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    /// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    /// will intersect other control points.
    /// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    /// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    /// spline.
    /// - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    pub interpolate: Option<Interpolate>,

    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    pub limit: Option<f64>,

    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    pub opacity: Option<f64>,

    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    pub orient: Option<Orient>,

    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    pub radius: Option<f64>,

    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    pub shape: Option<String>,

    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    pub size: Option<f64>,

    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    pub stroke: Option<String>,

    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    pub stroke_dash: Option<Vec<f64>>,

    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    pub stroke_dash_offset: Option<f64>,

    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    pub stroke_opacity: Option<f64>,

    /// The stroke width, in pixels.
    pub stroke_width: Option<f64>,

    /// A string or array of strings indicating the name of custom styles to apply to the mark. A
    /// style is a named collection of mark property defaults defined within the [style
    /// configuration](mark.html#style-config). If style is an array, later styles will override
    /// earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
    /// the `encoding` will override a style default.
    ///
    /// __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
    /// default.
    /// __Note:__ Any specified style will augment the default style. For example, a bar mark
    /// with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
    /// specified style `"foo"` has higher precedence).
    pub style: Option<Style>,

    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    pub tension: Option<f64>,

    /// Placeholder text if the `text` channel is not specified
    pub text: Option<String>,

    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    pub theta: Option<f64>,

    /// The mark type.
    /// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
    /// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
    #[serde(rename = "type")]
    pub mark_def_type: Mark,
}

/// All types of primitive marks.
///
/// The mark type.
/// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
/// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Mark {
    Area,

    Bar,

    Line,

    Point,

    Text,

    Tick,

    Rect,

    Rule,

    Circle,

    Square,

    Geoshape,
}

/// A string or array of strings indicating the name of custom styles to apply to the mark. A
/// style is a named collection of mark property defaults defined within the [style
/// configuration](mark.html#style-config). If style is an array, later styles will override
/// earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
/// the `encoding` will override a style default.
///
/// __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
/// default.
/// __Note:__ Any specified style will augment the default style. For example, a bar mark
/// with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
/// specified style `"foo"` has higher precedence).
///
/// A [mark style property](config.html#style) to apply to the title text mark.
///
/// __Default value:__ `"group-title"`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Style {
    PurpleString(String),

    StringArray(Vec<String>),
}

/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Projection {
    /// Sets the projection’s center to the specified center, a two-element array of longitude
    /// and latitude in degrees.
    ///
    /// __Default value:__ `[0, 0]`
    pub center: Option<Vec<f64>>,

    /// Sets the projection’s clipping circle radius to the specified angle in degrees. If
    /// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    /// than small-circle clipping.
    pub clip_angle: Option<f64>,

    /// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    /// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    /// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    /// viewport clipping is performed.
    pub clip_extent: Option<Vec<Vec<f64>>>,

    pub coefficient: Option<f64>,

    pub distance: Option<f64>,

    pub fraction: Option<f64>,

    pub lobes: Option<f64>,

    pub parallel: Option<f64>,

    /// Sets the threshold for the projection’s [adaptive
    /// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    /// value corresponds to the [Douglas–Peucker
    /// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    /// If precision is not specified, returns the projection’s current resampling precision
    /// which defaults to `√0.5 ≅ 0.70710…`.
    pub precision: Option<HashMap<String, PrecisionValue>>,

    pub radius: Option<f64>,

    pub ratio: Option<f64>,

    /// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    /// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    /// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    /// __Default value:__ `[0, 0, 0]`
    pub rotate: Option<Vec<f64>>,

    pub spacing: Option<f64>,

    pub tilt: Option<f64>,

    /// The cartographic projection to use. This value is case-insensitive, for example
    /// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    /// projection types [in the
    /// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    /// __Default value:__ `mercator`
    #[serde(rename = "type")]
    pub projection_type: Option<VgProjectionType>,
}

/// Scale, axis, and legend resolutions for layers.
///
/// Defines how scales, axes, and legends from different specs should be combined. Resolve is
/// a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
///
/// Scale, axis, and legend resolutions for facets.
///
/// Scale and legend resolutions for repeated charts.
///
/// Scale, axis, and legend resolutions for vertically concatenated charts.
///
/// Scale, axis, and legend resolutions for horizontally concatenated charts.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Resolve {
    pub axis: Option<AxisResolveMap>,

    pub legend: Option<LegendResolveMap>,

    pub scale: Option<ScaleResolveMap>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AxisResolveMap {
    pub x: Option<ResolveMode>,

    pub y: Option<ResolveMode>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ResolveMode {
    Independent,

    Shared,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LegendResolveMap {
    pub color: Option<ResolveMode>,

    pub opacity: Option<ResolveMode>,

    pub shape: Option<ResolveMode>,

    pub size: Option<ResolveMode>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ScaleResolveMap {
    pub color: Option<ResolveMode>,

    pub opacity: Option<ResolveMode>,

    pub shape: Option<ResolveMode>,

    pub size: Option<ResolveMode>,

    pub x: Option<ResolveMode>,

    pub y: Option<ResolveMode>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SelectionDef {
    /// Establish a two-way binding between a single selection and input elements
    /// (also known as dynamic query widgets). A binding takes the form of
    /// Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    /// or can be a mapping between projected field/encodings and binding definitions.
    ///
    /// See the [bind transform](bind.html) documentation for more information.
    ///
    /// Establishes a two-way binding between the interval selection and the scales
    /// used within the same view. This allows a user to interactively pan and
    /// zoom the view.
    pub bind: Option<BindUnion>,

    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    pub empty: Option<Empty>,

    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    pub encodings: Option<Vec<SingleDefChannel>>,

    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    pub fields: Option<Vec<String>>,

    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    pub nearest: Option<bool>,

    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    pub on: Option<serde_json::Value>,

    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    pub resolve: Option<SelectionResolution>,

    #[serde(rename = "type")]
    pub selection_def_type: SelectionDefType,

    /// Controls whether data values should be toggled or only ever inserted into
    /// multi selections. Can be `true`, `false` (for insertion only), or a
    /// [Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    /// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    /// data values are toggled when a user interacts with the shift-key pressed).
    ///
    /// See the [toggle transform](toggle.html) documentation for more information.
    pub toggle: Option<Translate>,

    /// An interval selection also adds a rectangle mark to depict the
    /// extents of the interval. The `mark` property can be used to customize the
    /// appearance of the mark.
    pub mark: Option<BrushConfig>,

    /// When truthy, allows a user to interactively move an interval selection
    /// back-and-forth. Can be `true`, `false` (to disable panning), or a
    /// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    /// which must include a start and end event to trigger continuous panning.
    ///
    /// __Default value:__ `true`, which corresponds to
    /// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    /// clicks and dragging within an interval selection to reposition it.
    pub translate: Option<Translate>,

    /// When truthy, allows a user to interactively resize an interval selection.
    /// Can be `true`, `false` (to disable zooming), or a [Vega event stream
    /// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    /// only `wheel` events are supported.
    ///
    ///
    /// __Default value:__ `true`, which corresponds to `wheel!`.
    pub zoom: Option<Translate>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum BindUnion {
    Enum(BindEnum),

    VgBindingMap(HashMap<String, VgBinding>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SelectionDefType {
    Single,

    Multi,

    Interval,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Title {
    PurpleString(String),

    TitleParams(TitleParams),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TitleParams {
    /// The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    /// example, with an orientation of top these anchor positions map to a left-, center-, or
    /// right-aligned title.
    ///
    /// __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    /// `"start"` for other composite views.
    ///
    /// __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    /// customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    /// composite views, `anchor` is always `"start"`.
    pub anchor: Option<Anchor>,

    /// The orthogonal offset in pixels by which to displace the title from its position along
    /// the edge of the chart.
    pub offset: Option<f64>,

    /// The orientation of the title relative to the chart. One of `"top"` (the default),
    /// `"bottom"`, `"left"`, or `"right"`.
    pub orient: Option<TitleOrient>,

    /// A [mark style property](config.html#style) to apply to the title text mark.
    ///
    /// __Default value:__ `"group-title"`.
    pub style: Option<Style>,

    /// The title text.
    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Transform {
    /// The `filter` property must be one of the predicate definitions:
    /// (1) an [expression](types.html#expression) string,
    /// where `datum` can be used to refer to the current data object;
    /// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
    /// [range predicate](filter.html#range-predicate), [one-of
    /// predicate](filter.html#one-of-predicate);
    /// (3) a [selection predicate](filter.html#selection-predicate);
    /// or (4) a logical operand that combines (1), (2), or (3).
    pub filter: Option<Box<ConditionalValueDefLogicalOperandPredicate>>,

    /// The field for storing the computed formula value.
    ///
    /// The field or fields for storing the computed formula value.
    /// If `from.fields` is specified, the transform will use the same names for `as`.
    /// If `from.fields` is not specified, `as` has to be a string and we put the whole object
    /// into the data under the specified name.
    ///
    /// The output fields at which to write the start and end bin values.
    ///
    /// The output field to write the timeUnit value.
    #[serde(rename = "as")]
    pub transform_as: Option<Style>,

    /// A [expression](types.html#expression) string. Use the variable `datum` to refer to the
    /// current data object.
    pub calculate: Option<String>,

    /// The default value to use if lookup fails.
    ///
    /// __Default value:__ `null`
    #[serde(rename = "default")]
    pub transform_default: Option<String>,

    /// Secondary data reference.
    pub from: Option<LookupData>,

    /// Key in primary data source.
    pub lookup: Option<String>,

    /// An object indicating bin properties, or simply `true` for using default bin parameters.
    pub bin: Option<Bin>,

    /// The data field to bin.
    ///
    /// The data field to apply time unit.
    pub field: Option<String>,

    /// The timeUnit.
    pub time_unit: Option<TimeUnit>,

    /// Array of objects that define fields to aggregate.
    pub aggregate: Option<Vec<AggregatedFieldDef>>,

    /// The data fields to group by. If not specified, a single group containing all data objects
    /// will be used.
    pub groupby: Option<Vec<String>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AggregatedFieldDef {
    /// The output field names to use for each aggregated field.
    #[serde(rename = "as")]
    pub aggregated_field_def_as: String,

    /// The data field for which to compute aggregate function.
    pub field: String,

    /// The aggregation operations to apply to the fields, such as sum, average or count.
    /// See the [full list of supported aggregation
    /// operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
    /// for more information.
    pub op: AggregateOp,
}

/// Secondary data reference.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LookupData {
    /// Secondary data source to lookup in.
    pub data: Data,

    /// Fields in foreign data to lookup.
    /// If not specified, the entire object is queried.
    pub fields: Option<Vec<String>>,

    /// Key in data to lookup.
    pub key: String,
}

/// An object that describes what fields should be repeated into views that are laid out as a
/// `row` or `column`.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Repeat {
    /// Horizontal repeated views.
    pub column: Option<Vec<String>>,

    /// Vertical repeated views.
    pub row: Option<Vec<String>>,
}
