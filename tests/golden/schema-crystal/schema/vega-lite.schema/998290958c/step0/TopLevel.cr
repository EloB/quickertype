require "json"

class TopLevel
  include JSON::Serializable

  # URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
  # have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
  # Setting the `$schema` property allows automatic validation and autocomplete in editors
  # that support JSON schema.
  @[JSON::Field(key: "$schema")]
  property schema : String?

  # Sets how the visualization size should be determined. If a string, should be one of
  # `"pad"`, `"fit"` or `"none"`.
  # Object values can additionally specify parameters for content sizing and automatic
  # resizing.
  # `"fit"` is only supported for single and layered views that don't use `rangeStep`.
  #
  # __Default value__: `pad`
  property autosize : Autosize?

  # CSS color property to use as the background of visualization.
  #
  # __Default value:__ none (transparent)
  property background : String?

  # Vega-Lite configuration object.  This property can only be defined at the top-level of a
  # specification.
  property config : Config?

  # An object describing the data source
  property data : Data?

  # Description of this mark for commenting purpose.
  property description : String?

  # A key-value mapping between encoding channels and definition of fields.
  property encoding : EncodingWithFacet?

  # The height of a visualization.
  #
  # __Default value:__
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
  # [continuous scale](scale.html#continuous), the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the height is [determined by the range step, paddings, and the
  # cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
  # `rangeStep` is `null`, the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
  #
  # __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the height of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property height : Float64?

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  property mark : AnyMark?

  # Name of the visualization for later reference.
  property name : String?

  # The default visualization padding, in pixels, from the edge of the visualization canvas
  # to the data rectangle.  If a number, specifies padding for all sides.
  # If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
  # "bottom": 5}` to specify padding for each side of the visualization.
  #
  # __Default value__: `5`
  property padding : Padding?

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  property projection : Projection?

  # A key-value mapping between selection names and definitions.
  property selection : Hash(String, SelectionDef)?

  # Title for the plot.
  property title : Title?

  # An array of data transformations such as filter and new field calculation.
  property transform : Array(Transform)?

  # The width of a visualization.
  #
  # __Default value:__ This will be determined by the following rules:
  #
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
  # [continuous scale](scale.html#continuous), the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the width is [determined by the range step, paddings, and the
  # cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
  # `rangeStep` is `null`, the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - If no field is mapped to `x` channel, the `width` will be the value of
  # [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
  # the value of `rangeStep` for other marks.
  #
  # __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the width of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property width : Float64?

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  property layer : Array(LayerSpec)?

  # Scale, axis, and legend resolutions for layers.
  #
  # Scale, axis, and legend resolutions for facets.
  #
  # Scale and legend resolutions for repeated charts.
  #
  # Scale, axis, and legend resolutions for vertically concatenated charts.
  #
  # Scale, axis, and legend resolutions for horizontally concatenated charts.
  property resolve : Resolve?

  # An object that describes mappings between `row` and `column` channels and their field
  # definitions.
  property facet : FacetMapping?

  # A specification of the view that gets faceted.
  property spec : SpecElement?

  # An object that describes what fields should be repeated into views that are laid out as a
  # `row` or `column`.
  property repeat : Repeat?

  # A list of views that should be concatenated and put into a column.
  property vconcat : Array(SpecElement)?

  # A list of views that should be concatenated and put into a row.
  property hconcat : Array(SpecElement)?
end

class AutoSizeParams
  include JSON::Serializable

  # Determines how size calculation should be performed, one of `"content"` or `"padding"`.
  # The default setting (`"content"`) interprets the width and height settings as the data
  # rectangle (plotting) dimensions, to which padding is then added. In contrast, the
  # `"padding"` setting includes the padding within the view size calculations, such that the
  # width and height settings indicate the **total** intended size of the view.
  #
  # __Default value__: `"content"`
  property contains : String?

  # A boolean flag indicating if autosize layout should be re-calculated on every view
  # update.
  #
  # __Default value__: `false`
  property resize : Bool?

  # The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
  # type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
  # descriptions of each.
  #
  # __Default value__: `"pad"`
  @[JSON::Field(key: "type")]
  property auto_size_params_type : String?
end

# Vega-Lite configuration object.  This property can only be defined at the top-level of a
# specification.
class Config
  include JSON::Serializable

  # Area-Specific Config
  property area : MarkConfig?

  # Sets how the visualization size should be determined. If a string, should be one of
  # `"pad"`, `"fit"` or `"none"`.
  # Object values can additionally specify parameters for content sizing and automatic
  # resizing.
  # `"fit"` is only supported for single and layered views that don't use `rangeStep`.
  #
  # __Default value__: `pad`
  property autosize : Autosize?

  # Axis configuration, which determines default properties for all `x` and `y`
  # [axes](axis.html). For a full list of axis configuration options, please see the
  # [corresponding section of the axis documentation](axis.html#config).
  property axis : AxisConfig?

  # Specific axis config for axes with "band" scales.
  @[JSON::Field(key: "axisBand")]
  property axis_band : VgAxisConfig?

  # Specific axis config for x-axis along the bottom edge of the chart.
  @[JSON::Field(key: "axisBottom")]
  property axis_bottom : VgAxisConfig?

  # Specific axis config for y-axis along the left edge of the chart.
  @[JSON::Field(key: "axisLeft")]
  property axis_left : VgAxisConfig?

  # Specific axis config for y-axis along the right edge of the chart.
  @[JSON::Field(key: "axisRight")]
  property axis_right : VgAxisConfig?

  # Specific axis config for x-axis along the top edge of the chart.
  @[JSON::Field(key: "axisTop")]
  property axis_top : VgAxisConfig?

  # X-axis specific config.
  @[JSON::Field(key: "axisX")]
  property axis_x : VgAxisConfig?

  # Y-axis specific config.
  @[JSON::Field(key: "axisY")]
  property axis_y : VgAxisConfig?

  # CSS color property to use as the background of visualization.
  #
  # __Default value:__ none (transparent)
  property background : String?

  # Bar-Specific Config
  property bar : BarConfig?

  # Circle-Specific Config
  property circle : MarkConfig?

  # Default axis and legend title for count fields.
  #
  # __Default value:__ `'Number of Records'`.
  @[JSON::Field(key: "countTitle")]
  property count_title : String?

  # Defines how Vega-Lite generates title for fields.  There are three possible styles:
  #
  # - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
  # "Year-month of date", "field (binned)").
  # - `"function"` - displays function using parentheses and capitalized texts (e.g.,
  # "SUM(field)", "YEARMONTH(date)", "BIN(field)").
  # - `"plain"` - displays only the field name without functions (e.g., "field", "date",
  # "field").
  @[JSON::Field(key: "fieldTitle")]
  property field_title : String?

  # Geoshape-Specific Config
  property geoshape : MarkConfig?

  # Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
  # - If set to `"filter"` (default), all data items with null values are filtered.
  # - If `null`, all data items are included. In this case, invalid values will be
  # interpreted as zeroes.
  @[JSON::Field(key: "invalidValues")]
  property invalid_values : String?

  # Legend configuration, which determines default properties for all [legends](legend.html).
  # For a full list of legend configuration options, please see the [corresponding section of
  # in the legend documentation](legend.html#config).
  property legend : LegendConfig?

  # Line-Specific Config
  property line : MarkConfig?

  # Mark Config
  property mark : MarkConfig?

  # D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
  # number format pattern](https://github.com/d3/d3-format#locale_format).
  @[JSON::Field(key: "numberFormat")]
  property number_format : String?

  # The default visualization padding, in pixels, from the edge of the visualization canvas
  # to the data rectangle.  If a number, specifies padding for all sides.
  # If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
  # "bottom": 5}` to specify padding for each side of the visualization.
  #
  # __Default value__: `5`
  property padding : Padding?

  # Point-Specific Config
  property point : MarkConfig?

  # Projection configuration, which determines default properties for all
  # [projections](projection.html). For a full list of projection configuration options,
  # please see the [corresponding section of the projection
  # documentation](projection.html#config).
  property projection : ProjectionConfig?

  # An object hash that defines default range arrays or schemes for using with scales.
  # For a full list of scale range configuration options, please see the [corresponding
  # section of the scale documentation](scale.html#config).
  property range : Hash(String, RangeConfigValue)?

  # Rect-Specific Config
  property rect : MarkConfig?

  # Rule-Specific Config
  property rule : MarkConfig?

  # Scale configuration determines default properties for all [scales](scale.html). For a
  # full list of scale configuration options, please see the [corresponding section of the
  # scale documentation](scale.html#config).
  property scale : ScaleConfig?

  # An object hash for defining default properties for each type of selections.
  property selection : SelectionConfig?

  # Square-Specific Config
  property square : MarkConfig?

  # Default stack offset for stackable mark.
  property stack : String?

  # An object hash that defines key-value mappings to determine default properties for marks
  # with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
  # valid [mark configuration objects](mark.html#config).
  property style : Hash(String, VgMarkConfig)?

  # Text-Specific Config
  property text : TextConfig?

  # Tick-Specific Config
  property tick : TickConfig?

  # Default datetime format for axis and legend labels. The format can be set directly on
  # each axis and legend. Use [D3's time format
  # pattern](https://github.com/d3/d3-time-format#locale_format).
  #
  # __Default value:__ `'%b %d, %Y'`.
  @[JSON::Field(key: "timeFormat")]
  property time_format : String?

  # Title configuration, which determines default properties for all [titles](title.html).
  # For a full list of title configuration options, please see the [corresponding section of
  # the title documentation](title.html#config).
  property title : VgTitleConfig?

  # Default properties for [single view plots](spec.html#single).
  property view : ViewConfig?
end

# Area-Specific Config
#
# Circle-Specific Config
#
# Geoshape-Specific Config
#
# Line-Specific Config
#
# Mark Config
#
# Point-Specific Config
#
# Rect-Specific Config
#
# Rule-Specific Config
#
# Square-Specific Config
class MarkConfig
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property color : String?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property filled : Bool?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?
end

# Axis configuration, which determines default properties for all `x` and `y`
# [axes](axis.html). For a full list of axis configuration options, please see the
# [corresponding section of the axis documentation](axis.html#config).
class AxisConfig
  include JSON::Serializable

  # An interpolation fraction indicating where, for `band` scales, axis ticks should be
  # positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
  # places ticks in the middle of their bands.
  @[JSON::Field(key: "bandPosition")]
  property band_position : Float64?

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  property domain : Bool?

  # Color of axis domain line.
  #
  # __Default value:__  (none, using Vega default).
  @[JSON::Field(key: "domainColor")]
  property domain_color : String?

  # Stroke width of axis domain line
  #
  # __Default value:__  (none, using Vega default).
  @[JSON::Field(key: "domainWidth")]
  property domain_width : Float64?

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  property grid : Bool?

  # Color of gridlines.
  @[JSON::Field(key: "gridColor")]
  property grid_color : String?

  # The offset (in pixels) into which to begin drawing with the grid dash array.
  @[JSON::Field(key: "gridDash")]
  property grid_dash : Array(Float64)?

  # The stroke opacity of grid (value between [0,1])
  #
  # __Default value:__ (`1` by default)
  @[JSON::Field(key: "gridOpacity")]
  property grid_opacity : Float64?

  # The grid width, in pixels.
  @[JSON::Field(key: "gridWidth")]
  property grid_width : Float64?

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  @[JSON::Field(key: "labelAngle")]
  property label_angle : Float64?

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  @[JSON::Field(key: "labelBound")]
  property label_bound : Label?

  # The color of the tick label, can be in hex color code or regular color name.
  @[JSON::Field(key: "labelColor")]
  property label_color : String?

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  @[JSON::Field(key: "labelFlush")]
  property label_flush : Label?

  # The font of the tick label.
  @[JSON::Field(key: "labelFont")]
  property label_font : String?

  # The font size of the label, in pixels.
  @[JSON::Field(key: "labelFontSize")]
  property label_font_size : Float64?

  # Maximum allowed pixel width of axis tick labels.
  @[JSON::Field(key: "labelLimit")]
  property label_limit : Float64?

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  @[JSON::Field(key: "labelOverlap")]
  property label_overlap : LabelOverlapUnion?

  # The padding, in pixels, between axis and text labels.
  @[JSON::Field(key: "labelPadding")]
  property label_padding : Float64?

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  property labels : Bool?

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  @[JSON::Field(key: "maxExtent")]
  property max_extent : Float64?

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  @[JSON::Field(key: "minExtent")]
  property min_extent : Float64?

  # Whether month names and weekday names should be abbreviated.
  #
  # __Default value:__  `false`
  @[JSON::Field(key: "shortTimeLabels")]
  property short_time_labels : Bool?

  # The color of the axis's tick.
  @[JSON::Field(key: "tickColor")]
  property tick_color : String?

  # Boolean flag indicating if pixel position values should be rounded to the nearest integer.
  @[JSON::Field(key: "tickRound")]
  property tick_round : Bool?

  # Boolean value that determines whether the axis should include ticks.
  property ticks : Bool?

  # The size in pixels of axis ticks.
  @[JSON::Field(key: "tickSize")]
  property tick_size : Float64?

  # The width, in pixels, of ticks.
  @[JSON::Field(key: "tickWidth")]
  property tick_width : Float64?

  # Horizontal text alignment of axis titles.
  @[JSON::Field(key: "titleAlign")]
  property title_align : String?

  # Angle in degrees of axis titles.
  @[JSON::Field(key: "titleAngle")]
  property title_angle : Float64?

  # Vertical text baseline for axis titles.
  @[JSON::Field(key: "titleBaseline")]
  property title_baseline : String?

  # Color of the title, can be in hex color code or regular color name.
  @[JSON::Field(key: "titleColor")]
  property title_color : String?

  # Font of the title. (e.g., `"Helvetica Neue"`).
  @[JSON::Field(key: "titleFont")]
  property title_font : String?

  # Font size of the title.
  @[JSON::Field(key: "titleFontSize")]
  property title_font_size : Float64?

  # Font weight of the title. (e.g., `"bold"`).
  @[JSON::Field(key: "titleFontWeight")]
  property title_font_weight : TitleFontWeightUnion?

  # Maximum allowed pixel width of axis titles.
  @[JSON::Field(key: "titleLimit")]
  property title_limit : Float64?

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  @[JSON::Field(key: "titleMaxLength")]
  property title_max_length : Float64?

  # The padding, in pixels, between title and axis.
  @[JSON::Field(key: "titlePadding")]
  property title_padding : Float64?

  # X-coordinate of the axis title relative to the axis group.
  @[JSON::Field(key: "titleX")]
  property title_x : Float64?

  # Y-coordinate of the axis title relative to the axis group.
  @[JSON::Field(key: "titleY")]
  property title_y : Float64?
end

# Specific axis config for axes with "band" scales.
#
# Specific axis config for x-axis along the bottom edge of the chart.
#
# Specific axis config for y-axis along the left edge of the chart.
#
# Specific axis config for y-axis along the right edge of the chart.
#
# Specific axis config for x-axis along the top edge of the chart.
#
# X-axis specific config.
#
# Y-axis specific config.
class VgAxisConfig
  include JSON::Serializable

  # An interpolation fraction indicating where, for `band` scales, axis ticks should be
  # positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
  # places ticks in the middle of their bands.
  @[JSON::Field(key: "bandPosition")]
  property band_position : Float64?

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  property domain : Bool?

  # Color of axis domain line.
  #
  # __Default value:__  (none, using Vega default).
  @[JSON::Field(key: "domainColor")]
  property domain_color : String?

  # Stroke width of axis domain line
  #
  # __Default value:__  (none, using Vega default).
  @[JSON::Field(key: "domainWidth")]
  property domain_width : Float64?

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  property grid : Bool?

  # Color of gridlines.
  @[JSON::Field(key: "gridColor")]
  property grid_color : String?

  # The offset (in pixels) into which to begin drawing with the grid dash array.
  @[JSON::Field(key: "gridDash")]
  property grid_dash : Array(Float64)?

  # The stroke opacity of grid (value between [0,1])
  #
  # __Default value:__ (`1` by default)
  @[JSON::Field(key: "gridOpacity")]
  property grid_opacity : Float64?

  # The grid width, in pixels.
  @[JSON::Field(key: "gridWidth")]
  property grid_width : Float64?

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  @[JSON::Field(key: "labelAngle")]
  property label_angle : Float64?

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  @[JSON::Field(key: "labelBound")]
  property label_bound : Label?

  # The color of the tick label, can be in hex color code or regular color name.
  @[JSON::Field(key: "labelColor")]
  property label_color : String?

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  @[JSON::Field(key: "labelFlush")]
  property label_flush : Label?

  # The font of the tick label.
  @[JSON::Field(key: "labelFont")]
  property label_font : String?

  # The font size of the label, in pixels.
  @[JSON::Field(key: "labelFontSize")]
  property label_font_size : Float64?

  # Maximum allowed pixel width of axis tick labels.
  @[JSON::Field(key: "labelLimit")]
  property label_limit : Float64?

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  @[JSON::Field(key: "labelOverlap")]
  property label_overlap : LabelOverlapUnion?

  # The padding, in pixels, between axis and text labels.
  @[JSON::Field(key: "labelPadding")]
  property label_padding : Float64?

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  property labels : Bool?

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  @[JSON::Field(key: "maxExtent")]
  property max_extent : Float64?

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  @[JSON::Field(key: "minExtent")]
  property min_extent : Float64?

  # The color of the axis's tick.
  @[JSON::Field(key: "tickColor")]
  property tick_color : String?

  # Boolean flag indicating if pixel position values should be rounded to the nearest integer.
  @[JSON::Field(key: "tickRound")]
  property tick_round : Bool?

  # Boolean value that determines whether the axis should include ticks.
  property ticks : Bool?

  # The size in pixels of axis ticks.
  @[JSON::Field(key: "tickSize")]
  property tick_size : Float64?

  # The width, in pixels, of ticks.
  @[JSON::Field(key: "tickWidth")]
  property tick_width : Float64?

  # Horizontal text alignment of axis titles.
  @[JSON::Field(key: "titleAlign")]
  property title_align : String?

  # Angle in degrees of axis titles.
  @[JSON::Field(key: "titleAngle")]
  property title_angle : Float64?

  # Vertical text baseline for axis titles.
  @[JSON::Field(key: "titleBaseline")]
  property title_baseline : String?

  # Color of the title, can be in hex color code or regular color name.
  @[JSON::Field(key: "titleColor")]
  property title_color : String?

  # Font of the title. (e.g., `"Helvetica Neue"`).
  @[JSON::Field(key: "titleFont")]
  property title_font : String?

  # Font size of the title.
  @[JSON::Field(key: "titleFontSize")]
  property title_font_size : Float64?

  # Font weight of the title. (e.g., `"bold"`).
  @[JSON::Field(key: "titleFontWeight")]
  property title_font_weight : TitleFontWeightUnion?

  # Maximum allowed pixel width of axis titles.
  @[JSON::Field(key: "titleLimit")]
  property title_limit : Float64?

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  @[JSON::Field(key: "titleMaxLength")]
  property title_max_length : Float64?

  # The padding, in pixels, between title and axis.
  @[JSON::Field(key: "titlePadding")]
  property title_padding : Float64?

  # X-coordinate of the axis title relative to the axis group.
  @[JSON::Field(key: "titleX")]
  property title_x : Float64?

  # Y-coordinate of the axis title relative to the axis group.
  @[JSON::Field(key: "titleY")]
  property title_y : Float64?
end

# Bar-Specific Config
class BarConfig
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
  # statisticians) or 1 (Vega-Lite Default, D3 example style).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "binSpacing")]
  property bin_spacing : Float64?

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property color : String?

  # The default size of the bars on continuous scales.
  #
  # __Default value:__ `5`
  @[JSON::Field(key: "continuousBandSize")]
  property continuous_band_size : Float64?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The size of the bars.  If unspecified, the default size is  `bandSize-1`,
  # which provides 1 pixel offset between bars.
  @[JSON::Field(key: "discreteBandSize")]
  property discrete_band_size : Float64?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property filled : Bool?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?
end

# Legend configuration, which determines default properties for all [legends](legend.html).
# For a full list of legend configuration options, please see the [corresponding section of
# in the legend documentation](legend.html#config).
class LegendConfig
  include JSON::Serializable

  # Corner radius for the full legend.
  @[JSON::Field(key: "cornerRadius")]
  property corner_radius : Float64?

  # Padding (in pixels) between legend entries in a symbol legend.
  @[JSON::Field(key: "entryPadding")]
  property entry_padding : Float64?

  # Background fill color for the full legend.
  @[JSON::Field(key: "fillColor")]
  property fill_color : String?

  # The height of the gradient, in pixels.
  @[JSON::Field(key: "gradientHeight")]
  property gradient_height : Float64?

  # Text baseline for color ramp gradient labels.
  @[JSON::Field(key: "gradientLabelBaseline")]
  property gradient_label_baseline : String?

  # The maximum allowed length in pixels of color ramp gradient labels.
  @[JSON::Field(key: "gradientLabelLimit")]
  property gradient_label_limit : Float64?

  # Vertical offset in pixels for color ramp gradient labels.
  @[JSON::Field(key: "gradientLabelOffset")]
  property gradient_label_offset : Float64?

  # The color of the gradient stroke, can be in hex color code or regular color name.
  @[JSON::Field(key: "gradientStrokeColor")]
  property gradient_stroke_color : String?

  # The width of the gradient stroke, in pixels.
  @[JSON::Field(key: "gradientStrokeWidth")]
  property gradient_stroke_width : Float64?

  # The width of the gradient, in pixels.
  @[JSON::Field(key: "gradientWidth")]
  property gradient_width : Float64?

  # The alignment of the legend label, can be left, middle or right.
  @[JSON::Field(key: "labelAlign")]
  property label_align : String?

  # The position of the baseline of legend label, can be top, middle or bottom.
  @[JSON::Field(key: "labelBaseline")]
  property label_baseline : String?

  # The color of the legend label, can be in hex color code or regular color name.
  @[JSON::Field(key: "labelColor")]
  property label_color : String?

  # The font of the legend label.
  @[JSON::Field(key: "labelFont")]
  property label_font : String?

  # The font size of legend label.
  #
  # __Default value:__ `10`.
  @[JSON::Field(key: "labelFontSize")]
  property label_font_size : Float64?

  # Maximum allowed pixel width of axis tick labels.
  @[JSON::Field(key: "labelLimit")]
  property label_limit : Float64?

  # The offset of the legend label.
  @[JSON::Field(key: "labelOffset")]
  property label_offset : Float64?

  # The offset, in pixels, by which to displace the legend from the edge of the enclosing
  # group or data rectangle.
  #
  # __Default value:__  `0`
  property offset : Float64?

  # The orientation of the legend, which determines how the legend is positioned within the
  # scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
  # "none".
  #
  # __Default value:__ `"right"`
  property orient : String?

  # The padding, in pixels, between the legend and axis.
  property padding : Float64?

  # Whether month names and weekday names should be abbreviated.
  #
  # __Default value:__  `false`
  @[JSON::Field(key: "shortTimeLabels")]
  property short_time_labels : Bool?

  # Border stroke color for the full legend.
  @[JSON::Field(key: "strokeColor")]
  property stroke_color : String?

  # Border stroke dash pattern for the full legend.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # Border stroke width for the full legend.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # The color of the legend symbol,
  @[JSON::Field(key: "symbolColor")]
  property symbol_color : String?

  # The size of the legend symbol, in pixels.
  @[JSON::Field(key: "symbolSize")]
  property symbol_size : Float64?

  # The width of the symbol's stroke.
  @[JSON::Field(key: "symbolStrokeWidth")]
  property symbol_stroke_width : Float64?

  # Default shape type (such as "circle") for legend symbols.
  @[JSON::Field(key: "symbolType")]
  property symbol_type : String?

  # Horizontal text alignment for legend titles.
  @[JSON::Field(key: "titleAlign")]
  property title_align : String?

  # Vertical text baseline for legend titles.
  @[JSON::Field(key: "titleBaseline")]
  property title_baseline : String?

  # The color of the legend title, can be in hex color code or regular color name.
  @[JSON::Field(key: "titleColor")]
  property title_color : String?

  # The font of the legend title.
  @[JSON::Field(key: "titleFont")]
  property title_font : String?

  # The font size of the legend title.
  @[JSON::Field(key: "titleFontSize")]
  property title_font_size : Float64?

  # The font weight of the legend title.
  @[JSON::Field(key: "titleFontWeight")]
  property title_font_weight : TitleFontWeightUnion?

  # Maximum allowed pixel width of axis titles.
  @[JSON::Field(key: "titleLimit")]
  property title_limit : Float64?

  # The padding, in pixels, between title and legend.
  @[JSON::Field(key: "titlePadding")]
  property title_padding : Float64?
end

class PaddingClass
  include JSON::Serializable

  property bottom : Float64?

  property left : Float64?

  property right : Float64?

  property top : Float64?
end

# Projection configuration, which determines default properties for all
# [projections](projection.html). For a full list of projection configuration options,
# please see the [corresponding section of the projection
# documentation](projection.html#config).
#
# Any property of Projection can be in config
class ProjectionConfig
  include JSON::Serializable

  # Sets the projection’s center to the specified center, a two-element array of longitude
  # and latitude in degrees.
  #
  # __Default value:__ `[0, 0]`
  property center : Array(Float64)?

  # Sets the projection’s clipping circle radius to the specified angle in degrees. If
  # `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
  # than small-circle clipping.
  @[JSON::Field(key: "clipAngle")]
  property clip_angle : Float64?

  # Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
  # bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
  # the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
  # viewport clipping is performed.
  @[JSON::Field(key: "clipExtent")]
  property clip_extent : Array(Array(Float64))?

  property coefficient : Float64?

  property distance : Float64?

  property fraction : Float64?

  property lobes : Float64?

  property parallel : Float64?

  # Sets the threshold for the projection’s [adaptive
  # resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
  # value corresponds to the [Douglas–Peucker
  # distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
  # If precision is not specified, returns the projection’s current resampling precision
  # which defaults to `√0.5 ≅ 0.70710…`.
  property precision : Hash(String, PrecisionValue)?

  property radius : Float64?

  property ratio : Float64?

  # Sets the projection’s three-axis rotation to the specified angles, which must be a two-
  # or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
  # angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
  #
  # __Default value:__ `[0, 0, 0]`
  property rotate : Array(Float64)?

  property spacing : Float64?

  property tilt : Float64?

  # The cartographic projection to use. This value is case-insensitive, for example
  # `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
  # projection types [in the
  # documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
  #
  # __Default value:__ `mercator`
  @[JSON::Field(key: "type")]
  property projection_config_type : String?
end

class VgScheme
  include JSON::Serializable

  property count : Float64?

  property extent : Array(Float64)?

  property scheme : String?

  property step : Float64?
end

# Scale configuration determines default properties for all [scales](scale.html). For a
# full list of scale configuration options, please see the [corresponding section of the
# scale documentation](scale.html#config).
class ScaleConfig
  include JSON::Serializable

  # Default inner padding for `x` and `y` band-ordinal scales.
  #
  # __Default value:__ `0.1`
  @[JSON::Field(key: "bandPaddingInner")]
  property band_padding_inner : Float64?

  # Default outer padding for `x` and `y` band-ordinal scales.
  # If not specified, by default, band scale's paddingOuter is paddingInner/2.
  @[JSON::Field(key: "bandPaddingOuter")]
  property band_padding_outer : Float64?

  # If true, values that exceed the data domain are clamped to either the minimum or maximum
  # range value
  property clamp : Bool?

  # Default padding for continuous scales.
  #
  # __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
  # horizontal bar.; `0` otherwise.
  @[JSON::Field(key: "continuousPadding")]
  property continuous_padding : Float64?

  # The default max value for mapping quantitative fields to bar's size/bandSize.
  #
  # If undefined (default), we will use the scale's `rangeStep` - 1.
  @[JSON::Field(key: "maxBandSize")]
  property max_band_size : Float64?

  # The default max value for mapping quantitative fields to text's size/fontSize.
  #
  # __Default value:__ `40`
  @[JSON::Field(key: "maxFontSize")]
  property max_font_size : Float64?

  # Default max opacity for mapping a field to opacity.
  #
  # __Default value:__ `0.8`
  @[JSON::Field(key: "maxOpacity")]
  property max_opacity : Float64?

  # Default max value for point size scale.
  @[JSON::Field(key: "maxSize")]
  property max_size : Float64?

  # Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
  #
  # __Default value:__ `4`
  @[JSON::Field(key: "maxStrokeWidth")]
  property max_stroke_width : Float64?

  # The default min value for mapping quantitative fields to bar and tick's size/bandSize
  # scale with zero=false.
  #
  # __Default value:__ `2`
  @[JSON::Field(key: "minBandSize")]
  property min_band_size : Float64?

  # The default min value for mapping quantitative fields to tick's size/fontSize scale with
  # zero=false
  #
  # __Default value:__ `8`
  @[JSON::Field(key: "minFontSize")]
  property min_font_size : Float64?

  # Default minimum opacity for mapping a field to opacity.
  #
  # __Default value:__ `0.3`
  @[JSON::Field(key: "minOpacity")]
  property min_opacity : Float64?

  # Default minimum value for point size scale with zero=false.
  #
  # __Default value:__ `9`
  @[JSON::Field(key: "minSize")]
  property min_size : Float64?

  # Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "minStrokeWidth")]
  property min_stroke_width : Float64?

  # Default outer padding for `x` and `y` point-ordinal scales.
  #
  # __Default value:__ `0.5`
  @[JSON::Field(key: "pointPadding")]
  property point_padding : Float64?

  # Default range step for band and point scales of (1) the `y` channel
  # and (2) the `x` channel when the mark is not `text`.
  #
  # __Default value:__ `21`
  @[JSON::Field(key: "rangeStep")]
  property range_step : Float64?

  # If true, rounds numeric output values to integers.
  # This can be helpful for snapping to the pixel grid.
  # (Only available for `x`, `y`, and `size` scales.)
  property round : Bool?

  # Default range step for `x` band and point scales of text marks.
  #
  # __Default value:__ `90`
  @[JSON::Field(key: "textXRangeStep")]
  property text_x_range_step : Float64?

  # Use the source data range before aggregation as scale domain instead of aggregated data
  # for aggregate axis.
  #
  # This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
  # fields by default.
  #
  # This property only works with aggregate functions that produce values within the raw data
  # domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
  # aggregations that produce values outside of the raw data domain (e.g. `"count"`,
  # `"sum"`), this property is ignored.
  #
  # __Default value:__ `false`
  @[JSON::Field(key: "useUnaggregatedDomain")]
  property use_unaggregated_domain : Bool?
end

# An object hash for defining default properties for each type of selections.
class SelectionConfig
  include JSON::Serializable

  # The default definition for an [`interval`](selection.html#type) selection. All properties
  # and transformations
  # for an interval selection definition (except `type`) may be specified here.
  #
  # For instance, setting `interval` to `{"translate": false}` disables the ability to move
  # interval selections by default.
  property interval : IntervalSelectionConfig?

  # The default definition for a [`multi`](selection.html#type) selection. All properties and
  # transformations
  # for a multi selection definition (except `type`) may be specified here.
  #
  # For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
  # multi selections when clicking with the alt-key pressed by default.
  property multi : MultiSelectionConfig?

  # The default definition for a [`single`](selection.html#type) selection. All properties
  # and transformations
  # for a single selection definition (except `type`) may be specified here.
  #
  # For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
  # double-click by default.
  property single : SingleSelectionConfig?
end

# The default definition for an [`interval`](selection.html#type) selection. All properties
# and transformations
# for an interval selection definition (except `type`) may be specified here.
#
# For instance, setting `interval` to `{"translate": false}` disables the ability to move
# interval selections by default.
class IntervalSelectionConfig
  include JSON::Serializable

  # Establishes a two-way binding between the interval selection and the scales
  # used within the same view. This allows a user to interactively pan and
  # zoom the view.
  property bind : String?

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  property empty : String?

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  property encodings : Array(String)?

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  property fields : Array(String)?

  # An interval selection also adds a rectangle mark to depict the
  # extents of the interval. The `mark` property can be used to customize the
  # appearance of the mark.
  property mark : BrushConfig?

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  property on : JSON::Any?

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  property resolve : String?

  # When truthy, allows a user to interactively move an interval selection
  # back-and-forth. Can be `true`, `false` (to disable panning), or a
  # [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
  # which must include a start and end event to trigger continuous panning.
  #
  # __Default value:__ `true`, which corresponds to
  # `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
  # clicks and dragging within an interval selection to reposition it.
  property translate : Translate?

  # When truthy, allows a user to interactively resize an interval selection.
  # Can be `true`, `false` (to disable zooming), or a [Vega event stream
  # definition](https://vega.github.io/vega/docs/event-streams/). Currently,
  # only `wheel` events are supported.
  #
  #
  # __Default value:__ `true`, which corresponds to `wheel!`.
  property zoom : Translate?
end

# An interval selection also adds a rectangle mark to depict the
# extents of the interval. The `mark` property can be used to customize the
# appearance of the mark.
class BrushConfig
  include JSON::Serializable

  # The fill color of the interval mark.
  #
  # __Default value:__ `#333333`
  property fill : String?

  # The fill opacity of the interval mark (a value between 0 and 1).
  #
  # __Default value:__ `0.125`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The stroke color of the interval mark.
  #
  # __Default value:__ `#ffffff`
  property stroke : String?

  # An array of alternating stroke and space lengths,
  # for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) with which to begin drawing the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity of the interval mark (a value between 0 and 1).
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width of the interval mark.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?
end

# The default definition for a [`multi`](selection.html#type) selection. All properties and
# transformations
# for a multi selection definition (except `type`) may be specified here.
#
# For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
# multi selections when clicking with the alt-key pressed by default.
class MultiSelectionConfig
  include JSON::Serializable

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  property empty : String?

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  property encodings : Array(String)?

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  property fields : Array(String)?

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  property nearest : Bool?

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  property on : JSON::Any?

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  property resolve : String?

  # Controls whether data values should be toggled or only ever inserted into
  # multi selections. Can be `true`, `false` (for insertion only), or a
  # [Vega expression](https://vega.github.io/vega/docs/expressions/).
  #
  # __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
  # data values are toggled when a user interacts with the shift-key pressed).
  #
  # See the [toggle transform](toggle.html) documentation for more information.
  property toggle : Translate?
end

# The default definition for a [`single`](selection.html#type) selection. All properties
# and transformations
# for a single selection definition (except `type`) may be specified here.
#
# For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
# double-click by default.
class SingleSelectionConfig
  include JSON::Serializable

  # Establish a two-way binding between a single selection and input elements
  # (also known as dynamic query widgets). A binding takes the form of
  # Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
  # or can be a mapping between projected field/encodings and binding definitions.
  #
  # See the [bind transform](bind.html) documentation for more information.
  property bind : Hash(String, VgBinding)?

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  property empty : String?

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  property encodings : Array(String)?

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  property fields : Array(String)?

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  property nearest : Bool?

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  property on : JSON::Any?

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  property resolve : String?
end

class VgBinding
  include JSON::Serializable

  property element : String?

  property input : String

  property options : Array(String)?

  property max : Float64?

  property min : Float64?

  property step : Float64?
end

class VgMarkConfig
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?
end

# Text-Specific Config
class TextConfig
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property color : String?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property filled : Bool?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # Whether month names and weekday names should be abbreviated.
  @[JSON::Field(key: "shortTimeLabels")]
  property short_time_labels : Bool?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?
end

# Tick-Specific Config
class TickConfig
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The width of the ticks.
  #
  # __Default value:__  2/3 of rangeStep.
  @[JSON::Field(key: "bandSize")]
  property band_size : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property color : String?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property filled : Bool?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?

  # Thickness of the tick mark.
  #
  # __Default value:__  `1`
  property thickness : Float64?
end

# Title configuration, which determines default properties for all [titles](title.html).
# For a full list of title configuration options, please see the [corresponding section of
# the title documentation](title.html#config).
class VgTitleConfig
  include JSON::Serializable

  # The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
  # example, with an orientation of top these anchor positions map to a left-, center-, or
  # right-aligned title.
  #
  # __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
  # `"start"` for other composite views.
  #
  # __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
  # customizable only for [single](spec.html) and [layered](layer.html) views.  For other
  # composite views, `anchor` is always `"start"`.
  property anchor : String?

  # Angle in degrees of title text.
  property angle : Float64?

  # Vertical text baseline for title text.
  property baseline : String?

  # Text color for title text.
  property color : String?

  # Font name for title text.
  property font : String?

  # Font size in pixels for title text.
  #
  # __Default value:__ `10`.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # Font weight for title text.
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # The maximum allowed length in pixels of legend labels.
  property limit : Float64?

  # Offset in pixels of the title from the chart body and axes.
  property offset : Float64?

  # Default title orientation ("top", "bottom", "left", or "right")
  property orient : String?
end

# Default properties for [single view plots](spec.html#single).
class ViewConfig
  include JSON::Serializable

  # Whether the view should be clipped.
  property clip : Bool?

  # The fill color.
  #
  # __Default value:__ (none)
  property fill : String?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ (none)
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The default height of the single plot or each plot in a trellis plot when the
  # visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
  #
  # __Default value:__ `200`
  property height : Float64?

  # The stroke color.
  #
  # __Default value:__ (none)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  #
  # __Default value:__ (none)
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  #
  # __Default value:__ (none)
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ (none)
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  #
  # __Default value:__ (none)
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # The default width of the single plot or each plot in a trellis plot when the
  # visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
  # = `null`.
  #
  # __Default value:__ `200`
  property width : Float64?
end

# An object describing the data source
#
# Secondary data source to lookup in.
class Data
  include JSON::Serializable

  # An object that specifies the format for parsing the data file.
  #
  # An object that specifies the format for parsing the data values.
  #
  # An object that specifies the format for parsing the data.
  property format : DataFormat?

  # An URL from which to load the data set. Use the `format.type` property
  # to ensure the loaded data is correctly parsed.
  property url : String?

  # The full data set, included inline. This can be an array of objects or primitive values
  # or a string.
  # Arrays of primitive values are ingested as objects with a `data` property. Strings are
  # parsed according to the specified format type.
  property values : Values?

  # Provide a placeholder name and bind data at runtime.
  property name : String?
end

# An object that specifies the format for parsing the data file.
#
# An object that specifies the format for parsing the data values.
#
# An object that specifies the format for parsing the data.
class DataFormat
  include JSON::Serializable

  # If set to auto (the default), perform automatic type inference to determine the desired
  # data types.
  # Alternatively, a parsing directive object can be provided for explicit data types. Each
  # property of the object corresponds to a field name, and the value to the desired data
  # type (one of `"number"`, `"boolean"` or `"date"`).
  # For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
  # input record a Date value.
  #
  # For `"date"`, we parse data based using Javascript's
  # [`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
  # For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
  # [d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
  # format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
  # [UTC time](timeunit.html#utc)
  property parse : ParseUnion?

  # Type of input data: `"json"`, `"csv"`, `"tsv"`.
  # The default format type is determined by the extension of the file URL.
  # If no extension is detected, `"json"` will be used by default.
  @[JSON::Field(key: "type")]
  property data_format_type : String?

  # The JSON property containing the desired data.
  # This parameter can be used when the loaded JSON file may have surrounding structure or
  # meta-data.
  # For example `"property": "values.features"` is equivalent to retrieving
  # `json.values.features`
  # from the loaded JSON object.
  property property : String?

  # The name of the TopoJSON object set to convert to a GeoJSON feature collection.
  # For example, in a map of the world, there may be an object set named `"countries"`.
  # Using the feature property, we can extract this set and generate a GeoJSON feature object
  # for each country.
  property feature : String?

  # The name of the TopoJSON object set to convert to mesh.
  # Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
  # Unlike the `feature` option, the corresponding geo data is returned as a single, unified
  # mesh instance, not as individual GeoJSON features.
  # Extracting a mesh is useful for more efficiently drawing borders or other geographic
  # elements that you do not need to associate with specific regions such as individual
  # countries, states or counties.
  property mesh : String?
end

# A key-value mapping between encoding channels and definition of fields.
class EncodingWithFacet
  include JSON::Serializable

  # Color of the marks – either fill or stroke color based on mark type.
  # By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
  # `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
  #
  # __Default value:__ If undefined, the default color depends on [mark
  # config](config.html#mark)'s `color` property.
  #
  # _Note:_ See the scale documentation for more information about customizing [color
  # scheme](scale.html#scheme).
  property color : MarkPropDefWithCondition?

  # Horizontal facets for trellis plots.
  property column : FacetFieldDef?

  # Additional levels of detail for grouping data in aggregate views and
  # in line and area marks without mapping data to a specific visual channel.
  property detail : Detail?

  # A URL to load upon mouse click.
  property href : DefWithCondition?

  # Opacity of the marks – either can be a value or a range.
  #
  # __Default value:__ If undefined, the default opacity depends on [mark
  # config](config.html#mark)'s `opacity` property.
  property opacity : MarkPropDefWithCondition?

  # Stack order for stacked marks or order of data points in line marks for connected scatter
  # plots.
  #
  # __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
  # additional aggregation grouping.
  property order : Order?

  # Vertical facets for trellis plots.
  property row : FacetFieldDef?

  # For `point` marks the supported values are
  # `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
  # or `"triangle-down"`, or else a custom SVG path string.
  # For `geoshape` marks it should be a field definition of the geojson data
  #
  # __Default value:__ If undefined, the default shape depends on [mark
  # config](config.html#point-config)'s `shape` property.
  property shape : MarkPropDefWithCondition?

  # Size of the mark.
  # - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
  # - For `"bar"` and `"tick"` – the bar and tick's size.
  # - For `"text"` – the text's font size.
  # - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
  property size : MarkPropDefWithCondition?

  # Text of the `text` mark.
  property text : TextDefWithCondition?

  # The tooltip text to show upon mouse hover.
  property tooltip : TextDefWithCondition?

  # X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
  property x : XClass?

  # X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  property x2 : X2Class?

  # Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
  property y : XClass?

  # Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  property y2 : X2Class?
end

# Color of the marks – either fill or stroke color based on mark type.
# By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
# `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
#
# __Default value:__ If undefined, the default color depends on [mark
# config](config.html#mark)'s `color` property.
#
# _Note:_ See the scale documentation for more information about customizing [color
# scheme](scale.html#scheme).
#
# Opacity of the marks – either can be a value or a range.
#
# __Default value:__ If undefined, the default opacity depends on [mark
# config](config.html#mark)'s `opacity` property.
#
# For `point` marks the supported values are
# `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
# or `"triangle-down"`, or else a custom SVG path string.
# For `geoshape` marks it should be a field definition of the geojson data
#
# __Default value:__ If undefined, the default shape depends on [mark
# config](config.html#point-config)'s `shape` property.
#
# Size of the mark.
# - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
# - For `"bar"` and `"tick"` – the bar and tick's size.
# - For `"text"` – the text's font size.
# - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
#
# A FieldDef with Condition<ValueDef>
# {
# condition: {value: ...},
# field: ...,
# ...
# }
#
# A ValueDef with Condition<ValueDef | FieldDef>
# {
# condition: {field: ...} | {value: ...},
# value: ...,
# }
class MarkPropDefWithCondition
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  property condition : ColorCondition?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # An object defining properties of the legend.
  # If `null`, the legend for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [legend properties](legend.html) are applied.
  property legend : Legend?

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  property scale : Scale?

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  property sort : SortUnion?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property mark_prop_def_with_condition_type : String?

  # A constant value in visual domain.
  property value : ConditionalPredicateValueDefValue?
end

# Binning properties or boolean flag for determining whether to bin data or not.
class BinParams
  include JSON::Serializable

  # The number base to use for automatic bin determination (default is base 10).
  #
  # __Default value:__ `10`
  property base : Float64?

  # Scale factors indicating allowable subdivisions. The default value is [5, 2], which
  # indicates that for base 10 numbers (the default base), the method may consider dividing
  # bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
  # check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
  # given constraints.
  #
  # __Default value:__ `[5, 2]`
  property divide : Array(Float64)?

  # A two-element (`[min, max]`) array indicating the range of desired bin values.
  property extent : Array(Float64)?

  # Maximum number of bins.
  #
  # __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
  property maxbins : Float64?

  # A minimum allowable step size (particularly useful for integer values).
  property minstep : Float64?

  # If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
  # such as multiples of ten.
  property nice : Bool?

  # An exact step size to use between bins.
  #
  # __Note:__ If provided, options such as maxbins will be ignored.
  property step : Float64?

  # An array of allowable step sizes to choose from.
  property steps : Array(Float64)?
end

class ConditionalValueDef
  include JSON::Serializable

  property test : ConditionalValueDefLogicalOperandPredicate?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalValueDefValue

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  property selection : ConditionalValueDefSelectionOperand?
end

class Selection
  include JSON::Serializable

  property not : ConditionalValueDefSelectionOperand?

  property and : Array(SelectionOperandElement)?

  property or : Array(SelectionOperandElement)?
end

class Predicate
  include JSON::Serializable

  property not : ConditionalValueDefLogicalOperandPredicate?

  property and : Array(LogicalOperandPredicateElement)?

  property or : Array(LogicalOperandPredicateElement)?

  # The value that the field should be equal to.
  property equal : EqualUnion?

  # Field to be filtered.
  #
  # Field to be filtered
  property field : String?

  # Time unit for the field to be filtered.
  #
  # time unit for the field to be filtered.
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # An array of inclusive minimum and maximum values
  # for a field value of a data item to be included in the filtered data.
  property range : Array(RangeElement?)?

  # A set of values that the `field`'s value should be a member of,
  # for a data item included in the filtered data.
  @[JSON::Field(key: "oneOf")]
  property one_of : Array(OneOfElement)?

  # Filter using a selection name.
  property selection : ConditionalValueDefSelectionOperand?
end

# Object for defining datetime in Vega-Lite Filter.
# If both month and quarter are provided, month has higher precedence.
# `day` cannot be combined with other date.
# We accept string for month and day names.
class DateTime
  include JSON::Serializable

  # Integer value representing the date from 1-31.
  property date : Float64?

  # Value representing the day of a week.  This can be one of: (1) integer value -- `1`
  # represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
  # case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
  # DateTime definition object with `day`** should not be combined with `year`, `quarter`,
  # `month`, or `date`.
  property day : Day?

  # Integer value representing the hour of a day from 0-23.
  property hours : Float64?

  # Integer value representing the millisecond segment of time.
  property milliseconds : Float64?

  # Integer value representing the minute segment of time from 0-59.
  property minutes : Float64?

  # One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
  # (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
  # short month name (e.g., `"Jan"`).
  property month : Month?

  # Integer value representing the quarter of the year (from 1-4).
  property quarter : Float64?

  # Integer value representing the second segment (0-59) of a time value
  property seconds : Float64?

  # A boolean flag indicating if date time is in utc time. If false, the date time is in
  # local time
  property utc : Bool?

  # Integer value representing the year.
  property year : Float64?
end

class ConditionalPredicateMarkPropFieldDefClass
  include JSON::Serializable

  property test : ConditionalValueDefLogicalOperandPredicate?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalPredicateValueDefValue?

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  property selection : ConditionalValueDefSelectionOperand?

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # An object defining properties of the legend.
  # If `null`, the legend for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [legend properties](legend.html) are applied.
  property legend : Legend?

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  property scale : Scale?

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  property sort : SortUnion?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property conditional_def_type : String?
end

# Reference to a repeated value.
class RepeatRef
  include JSON::Serializable

  property repeat : String
end

# Properties of a legend or boolean flag for determining whether to show it.
class Legend
  include JSON::Serializable

  # Padding (in pixels) between legend entries in a symbol legend.
  @[JSON::Field(key: "entryPadding")]
  property entry_padding : Float64?

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  property format : String?

  # The offset, in pixels, by which to displace the legend from the edge of the enclosing
  # group or data rectangle.
  #
  # __Default value:__  `0`
  property offset : Float64?

  # The orientation of the legend, which determines how the legend is positioned within the
  # scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
  # "none".
  #
  # __Default value:__ `"right"`
  property orient : String?

  # The padding, in pixels, between the legend and axis.
  property padding : Float64?

  # The desired number of tick values for quantitative legends.
  @[JSON::Field(key: "tickCount")]
  property tick_count : Float64?

  # A title for the field. If `null`, the title will be removed.
  #
  # __Default value:__  derived from the field's name and transformation function
  # (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
  # function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
  # binned or has a time unit applied, the applied function will be denoted in parentheses
  # (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
  # simply the field name.
  #
  # __Note__: You can customize the default field title format by providing the [`fieldTitle`
  # property in the [config](config.html) or [`fieldTitle` function via the `compile`
  # function's options](compile.html#field-title).
  property title : String?

  # The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
  # continuous color gradient.
  #
  # __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
  # `"symbol"` otherwise.
  @[JSON::Field(key: "type")]
  property legend_type : String?

  # Explicitly set the visible legend values.
  property values : Array(LegendValue)?

  # A non-positive integer indicating z-index of the legend.
  # If zindex is 0, legend should be drawn behind all chart elements.
  # To put them in front, use zindex = 1.
  property zindex : Float64?
end

# An object defining properties of the channel's scale, which is the function that
# transforms values in the data domain (numbers, dates, strings, etc) to visual values
# (pixels, colors, sizes) of the encoding channels.
#
# __Default value:__ If undefined, default [scale properties](scale.html) are applied.
class Scale
  include JSON::Serializable

  # The logarithm base of the `log` scale (default `10`).
  property base : Float64?

  # If `true`, values that exceed the data domain are clamped to either the minimum or
  # maximum range value
  #
  # __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
  # (`true` by default).
  property clamp : Bool?

  # Customized domain values.
  #
  # For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
  # and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
  # a `domain` with more than two entries.
  # If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
  # indicating that the domain should include the raw data values prior to the aggregation.
  #
  # For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
  # the form of either timestamps or the [DateTime definition objects](types.html#datetime).
  #
  # For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
  # values.
  #
  # The `selection` property can be used to [interactively
  # determine](selection.html#scale-domains) the scale domain.
  property domain : DomainUnion?

  # The exponent of the `pow` scale.
  property exponent : Float64?

  # The interpolation method for range values. By default, a general interpolator for
  # numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
  # property allows interpolation in alternative color spaces. Legal values include `rgb`,
  # `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
  # variants use longer paths in polar coordinate spaces). If object-valued, this property
  # accepts an object with a string-valued _type_ property and an optional numeric _gamma_
  # property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
  # documentation](https://github.com/d3/d3-interpolate).
  #
  # __Note:__ Sequential scales do not support `interpolate` as they have a fixed
  # interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
  # you have to set the scale `type` to other quantitative scale type such as `"linear"` to
  # customize `interpolate`.
  property interpolate : InterpolateUnion?

  # Extending the domain so that it starts and ends on nice round values. This method
  # typically modifies the scale’s domain, and may only extend the bounds to the nearest
  # round value. Nicing is useful if the domain is computed from data and may be irregular.
  # For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
  # 1.0]_.
  #
  # For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
  # If `nice` is a number, it will represent a desired tick count. This allows greater
  # control over the step size used to extend the bounds, guaranteeing that the returned
  # ticks will exactly cover the domain.
  #
  # For temporal fields with time and utc scales, the `nice` value can be a string indicating
  # the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
  # `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
  # scales can accept an object-valued interval specifier of the form `{"interval": "month",
  # "step": 3}`, which includes a desired number of interval steps. Here, the domain would
  # snap to quarter (Jan, Apr, Jul, Oct) boundaries.
  #
  # __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
  property nice : NiceUnion?

  # For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
  # the specified number of pixels on each of the scale range. The scale range must represent
  # pixels for this parameter to function as intended. Padding adjustment is performed prior
  # to all other adjustments, including the effects of the zero, nice, domainMin, and
  # domainMax properties.
  #
  # For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
  # `paddingOuter` to the same value.
  #
  # For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
  #
  # __Default value:__ For _continuous_ scales, derived from the [scale
  # config](scale.html#config)'s `continuousPadding`.
  # For _band and point_ scales, see `paddingInner` and `paddingOuter`.
  property padding : Float64?

  # The inner padding (spacing) within each band step of band scales, as a fraction of the
  # step size. This value must lie in the range [0,1].
  #
  # For point scale, this property is invalid as point scales do not have internal band
  # widths (only step sizes between bands).
  #
  # __Default value:__ derived from the [scale config](scale.html#config)'s
  # `bandPaddingInner`.
  @[JSON::Field(key: "paddingInner")]
  property padding_inner : Float64?

  # The outer padding (spacing) at the ends of the range of band and point scales,
  # as a fraction of the step size. This value must lie in the range [0,1].
  #
  # __Default value:__ derived from the [scale config](scale.html#config)'s
  # `bandPaddingOuter` for band scales and `pointPadding` for point scales.
  @[JSON::Field(key: "paddingOuter")]
  property padding_outer : Float64?

  # The range of the scale. One of:
  #
  # - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
  # example, `"symbol"`, or `"diverging"`).
  #
  # - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
  # and maximum values, or an array with more than two entries for specifying a [piecewise
  # scale](scale.html#piecewise).
  #
  # - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
  # an array of desired output values.
  #
  # __Notes:__
  #
  # 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
  # discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
  # instead of `range`.
  #
  # 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
  # customized via the view's corresponding [size](size.html) (`width` and `height`) or via
  # [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
  # scales.
  property range : ScaleRange?

  # The distance between the starts of adjacent bands or points in [band](scale.html#band)
  # and [point](scale.html#point) scales.
  #
  # If `rangeStep` is `null` or if the view contains the scale's corresponding
  # [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
  # be automatically determined to fit the size of the view.
  #
  # __Default value:__  derived the [scale config](config.html#scale-config)'s
  # `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
  # default) for x-scales of other marks and y-scales.
  #
  # __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
  # than `width` or `height`, the rangeStep might become less than one pixel and the mark
  # might not appear correctly.
  @[JSON::Field(key: "rangeStep")]
  property range_step : Float64?

  # If `true`, rounds numeric output values to integers. This can be helpful for snapping to
  # the pixel grid.
  #
  # __Default value:__ `false`.
  property round : Bool?

  # A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
  # `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
  #
  # Discrete color schemes may be used with [discrete](scale.html#discrete) or
  # [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
  # use with [sequential](scales.html#sequential) scales.
  #
  # For the full list of supported scheme, please refer to the [Vega
  # Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
  property scheme : Scheme?

  # The type of scale.  Vega-Lite supports the following categories of scale types:
  #
  # 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
  # continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
  # [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
  # [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
  #
  # 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
  # ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
  # [`"point"`](scale.html#point)) output ranges.
  #
  # 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
  # discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
  # [`"bin-ordinal"`](scale.html#bin-ordinal)).
  #
  # __Default value:__ please see the [scale type table](scale.html#type).
  @[JSON::Field(key: "type")]
  property scale_type : String?

  # If `true`, ensures that a zero baseline value is included in the scale domain.
  #
  # __Default value:__ `true` for x and y channels if the quantitative field is not binned
  # and no custom `domain` is provided; `false` otherwise.
  #
  # __Note:__ Log, time, and utc scales do not support `zero`.
  property zero : Bool?
end

class DomainClass
  include JSON::Serializable

  # The field name to extract selected values for, when a selection is
  # [projected](project.html)
  # over multiple fields or encodings.
  property field : String?

  # The name of a selection.
  property selection : String

  # The encoding channel to extract selected values for, when a selection is
  # [projected](project.html)
  # over multiple fields or encodings.
  property encoding : String?
end

class InterpolateParams
  include JSON::Serializable

  property gamma : Float64?

  @[JSON::Field(key: "type")]
  property interpolate_params_type : String
end

class NiceClass
  include JSON::Serializable

  property interval : String

  property step : Float64
end

class SchemeParams
  include JSON::Serializable

  # For sequential and diverging schemes only, determines the extent of the color range to
  # use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
  # range _[0, 0.2)_ are excluded from the scheme.
  property extent : Array(Float64)?

  # A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
  #
  # For the full list of supported scheme, please refer to the [Vega
  # Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
  property name : String
end

class SortField
  include JSON::Serializable

  # The data [field](field.html) to sort by.
  #
  # __Default value:__ If unspecified, defaults to the field specified in the outer data
  # reference.
  property field : Field?

  # An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
  # (e.g., `"count"`, `"mean"` and `"median"`).
  # This property is required in cases where the sort field and the data reference field do
  # not match.
  # The input data objects will be aggregated, grouped by the encoded data field.
  #
  # For a full list of operations, please see the documentation for
  # [aggregate](aggregate.html#ops).
  property op : String

  # The sort order. One of `"ascending"` (default) or `"descending"`.
  property order : String?
end

# Horizontal facets for trellis plots.
#
# Vertical facets for trellis plots.
class FacetFieldDef
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # An object defining properties of a facet's header.
  property header : Header?

  # Sort order for a facet field.
  # This can be `"ascending"`, `"descending"`.
  property sort : String?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property facet_field_def_type : String
end

# An object defining properties of a facet's header.
#
# Headers of row / column channels for faceted plots.
class Header
  include JSON::Serializable

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  property format : String?

  # The rotation angle of the header labels.
  #
  # __Default value:__ `0`.
  @[JSON::Field(key: "labelAngle")]
  property label_angle : Float64?

  # A title for the field. If `null`, the title will be removed.
  #
  # __Default value:__  derived from the field's name and transformation function
  # (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
  # function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
  # binned or has a time unit applied, the applied function will be denoted in parentheses
  # (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
  # simply the field name.
  #
  # __Note__: You can customize the default field title format by providing the [`fieldTitle`
  # property in the [config](config.html) or [`fieldTitle` function via the `compile`
  # function's options](compile.html#field-title).
  property title : String?
end

# Definition object for a data field, its type and transformation of an encoding channel.
class FieldDef
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property field_def_type : String
end

# A URL to load upon mouse click.
#
# A FieldDef with Condition<ValueDef>
# {
# condition: {value: ...},
# field: ...,
# ...
# }
#
# A ValueDef with Condition<ValueDef | FieldDef>
# {
# condition: {field: ...} | {value: ...},
# value: ...,
# }
class DefWithCondition
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  property condition : HrefCondition?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property def_with_condition_type : String?

  # A constant value in visual domain.
  property value : ConditionalPredicateValueDefValue?
end

class ConditionalPredicateFieldDefClass
  include JSON::Serializable

  property test : ConditionalValueDefLogicalOperandPredicate?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalPredicateValueDefValue?

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  property selection : ConditionalValueDefSelectionOperand?

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property conditional_def_type : String?
end

class OrderFieldDef
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # The sort order. One of `"ascending"` (default) or `"descending"`.
  property sort : String?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property order_field_def_type : String
end

# Text of the `text` mark.
#
# The tooltip text to show upon mouse hover.
#
# A FieldDef with Condition<ValueDef>
# {
# condition: {value: ...},
# field: ...,
# ...
# }
#
# A ValueDef with Condition<ValueDef | FieldDef>
# {
# condition: {field: ...} | {value: ...},
# value: ...,
# }
class TextDefWithCondition
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  property condition : TextCondition?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # The [formatting pattern](format.html) for a text field. If not defined, this will be
  # determined automatically.
  property format : String?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property text_def_with_condition_type : String?

  # A constant value in visual domain.
  property value : ConditionalPredicateValueDefValue?
end

class ConditionalPredicateTextFieldDefClass
  include JSON::Serializable

  property test : ConditionalValueDefLogicalOperandPredicate?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalPredicateValueDefValue?

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  property selection : ConditionalValueDefSelectionOperand?

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # The [formatting pattern](format.html) for a text field. If not defined, this will be
  # determined automatically.
  property format : String?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property conditional_def_type : String?
end

# X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
#
# Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
#
# Definition object for a constant value of an encoding channel.
class XClass
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # An object defining properties of axis's gridlines, ticks and labels.
  # If `null`, the axis for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [axis properties](axis.html) are applied.
  property axis : Axis?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  property scale : Scale?

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  property sort : SortUnion?

  # Type of stacking offset if the field should be stacked.
  # `stack` is only applicable for `x` and `y` channels with continuous domains.
  # For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
  #
  # `stack` can be one of the following values:
  #
  # - `"zero"`: stacking with baseline offset at zero value of the scale (for creating
  # typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
  # - `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
  # and area charts](stack.html#normalized). <br/>
  # - `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
  # - `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
  # area chart.
  #
  # __Default value:__ `zero` for plots with all of the following conditions are true:
  #
  # 1. The mark is `bar` or `area`;
  # 2. The stacked measure channel (x or y) has a linear scale;
  # 3. At least one of non-position channels mapped to an unaggregated field that is
  # different from x and y.  Otherwise, `null` by default.
  property stack : String?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property def_type : String?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalPredicateValueDefValue?
end

class Axis
  include JSON::Serializable

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  property domain : Bool?

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  property format : String?

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  property grid : Bool?

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  @[JSON::Field(key: "labelAngle")]
  property label_angle : Float64?

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  @[JSON::Field(key: "labelBound")]
  property label_bound : Label?

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  @[JSON::Field(key: "labelFlush")]
  property label_flush : Label?

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  @[JSON::Field(key: "labelOverlap")]
  property label_overlap : LabelOverlapUnion?

  # The padding, in pixels, between axis and text labels.
  @[JSON::Field(key: "labelPadding")]
  property label_padding : Float64?

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  property labels : Bool?

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  @[JSON::Field(key: "maxExtent")]
  property max_extent : Float64?

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  @[JSON::Field(key: "minExtent")]
  property min_extent : Float64?

  # The offset, in pixels, by which to displace the axis from the edge of the enclosing group
  # or data rectangle.
  #
  # __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
  # `offset` (`0` by default)
  property offset : Float64?

  # The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
  # orientation can be used to further specialize the axis type (e.g., a y axis oriented for
  # the right edge of the chart).
  #
  # __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
  property orient : String?

  # The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
  # this sets the axis group x coordinate. For y-axis with left or right orientation, this
  # sets the axis group y coordinate.
  #
  # __Default value__: `0`
  property position : Float64?

  # A desired number of ticks, for axes visualizing quantitative scales. The resulting number
  # may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
  # underlying scale's range.
  @[JSON::Field(key: "tickCount")]
  property tick_count : Float64?

  # Boolean value that determines whether the axis should include ticks.
  property ticks : Bool?

  # The size in pixels of axis ticks.
  @[JSON::Field(key: "tickSize")]
  property tick_size : Float64?

  # A title for the field. If `null`, the title will be removed.
  #
  # __Default value:__  derived from the field's name and transformation function
  # (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
  # function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
  # binned or has a time unit applied, the applied function will be denoted in parentheses
  # (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
  # simply the field name.
  #
  # __Note__: You can customize the default field title format by providing the [`fieldTitle`
  # property in the [config](config.html) or [`fieldTitle` function via the `compile`
  # function's options](compile.html#field-title).
  property title : String?

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  @[JSON::Field(key: "titleMaxLength")]
  property title_max_length : Float64?

  # The padding, in pixels, between title and axis.
  @[JSON::Field(key: "titlePadding")]
  property title_padding : Float64?

  # Explicitly set the visible axis tick values.
  property values : Array(AxisValue)?

  # A non-positive integer indicating z-index of the axis.
  # If zindex is 0, axes should be drawn behind all chart elements.
  # To put them in front, use `"zindex = 1"`.
  #
  # __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
  # for grids.
  property zindex : Float64?
end

# X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
#
# Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
#
# Definition object for a data field, its type and transformation of an encoding channel.
#
# Definition object for a constant value of an encoding channel.
class X2Class
  include JSON::Serializable

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  property aggregate : String?

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  property bin : Bin?

  # __Required.__ A string defining the name of the field from which to pull a data value
  # or an object defining iterated values from the [`repeat`](repeat.html) operator.
  #
  # __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
  # (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
  # If field names contain dots or brackets but are not nested, you can use `\\` to escape
  # dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
  # See more details about escaping in the [field documentation](field.html).
  #
  # __Note:__ `field` is not required if `aggregate` is `count`.
  property field : Field?

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  @[JSON::Field(key: "type")]
  property def_type : String?

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  property value : ConditionalPredicateValueDefValue?
end

# An object that describes mappings between `row` and `column` channels and their field
# definitions.
class FacetMapping
  include JSON::Serializable

  # Horizontal facets for trellis plots.
  property column : FacetFieldDef?

  # Vertical facets for trellis plots.
  property row : FacetFieldDef?
end

# Unit spec that can have a composite mark.
class SpecElement
  include JSON::Serializable

  # An object describing the data source
  property data : Data?

  # Description of this mark for commenting purpose.
  property description : String?

  # The height of a visualization.
  #
  # __Default value:__
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
  # [continuous scale](scale.html#continuous), the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the height is [determined by the range step, paddings, and the
  # cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
  # `rangeStep` is `null`, the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
  #
  # __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the height of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property height : Float64?

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  property layer : Array(LayerSpec)?

  # Name of the visualization for later reference.
  property name : String?

  # Scale, axis, and legend resolutions for layers.
  #
  # Scale, axis, and legend resolutions for facets.
  #
  # Scale and legend resolutions for repeated charts.
  #
  # Scale, axis, and legend resolutions for vertically concatenated charts.
  #
  # Scale, axis, and legend resolutions for horizontally concatenated charts.
  property resolve : Resolve?

  # Title for the plot.
  property title : Title?

  # An array of data transformations such as filter and new field calculation.
  property transform : Array(Transform)?

  # The width of a visualization.
  #
  # __Default value:__ This will be determined by the following rules:
  #
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
  # [continuous scale](scale.html#continuous), the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the width is [determined by the range step, paddings, and the
  # cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
  # `rangeStep` is `null`, the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - If no field is mapped to `x` channel, the `width` will be the value of
  # [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
  # the value of `rangeStep` for other marks.
  #
  # __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the width of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property width : Float64?

  # A key-value mapping between encoding channels and definition of fields.
  property encoding : Encoding?

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  property mark : AnyMark?

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  property projection : Projection?

  # A key-value mapping between selection names and definitions.
  property selection : Hash(String, SelectionDef)?

  # An object that describes mappings between `row` and `column` channels and their field
  # definitions.
  property facet : FacetMapping?

  # A specification of the view that gets faceted.
  property spec : SpecElement?

  # An object that describes what fields should be repeated into views that are laid out as a
  # `row` or `column`.
  property repeat : Repeat?

  # A list of views that should be concatenated and put into a column.
  property vconcat : Array(SpecElement)?

  # A list of views that should be concatenated and put into a row.
  property hconcat : Array(SpecElement)?
end

# A key-value mapping between encoding channels and definition of fields.
class Encoding
  include JSON::Serializable

  # Color of the marks – either fill or stroke color based on mark type.
  # By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
  # `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
  #
  # __Default value:__ If undefined, the default color depends on [mark
  # config](config.html#mark)'s `color` property.
  #
  # _Note:_ See the scale documentation for more information about customizing [color
  # scheme](scale.html#scheme).
  property color : MarkPropDefWithCondition?

  # Additional levels of detail for grouping data in aggregate views and
  # in line and area marks without mapping data to a specific visual channel.
  property detail : Detail?

  # A URL to load upon mouse click.
  property href : DefWithCondition?

  # Opacity of the marks – either can be a value or a range.
  #
  # __Default value:__ If undefined, the default opacity depends on [mark
  # config](config.html#mark)'s `opacity` property.
  property opacity : MarkPropDefWithCondition?

  # Stack order for stacked marks or order of data points in line marks for connected scatter
  # plots.
  #
  # __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
  # additional aggregation grouping.
  property order : Order?

  # For `point` marks the supported values are
  # `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
  # or `"triangle-down"`, or else a custom SVG path string.
  # For `geoshape` marks it should be a field definition of the geojson data
  #
  # __Default value:__ If undefined, the default shape depends on [mark
  # config](config.html#point-config)'s `shape` property.
  property shape : MarkPropDefWithCondition?

  # Size of the mark.
  # - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
  # - For `"bar"` and `"tick"` – the bar and tick's size.
  # - For `"text"` – the text's font size.
  # - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
  property size : MarkPropDefWithCondition?

  # Text of the `text` mark.
  property text : TextDefWithCondition?

  # The tooltip text to show upon mouse hover.
  property tooltip : TextDefWithCondition?

  # X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
  property x : XClass?

  # X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  property x2 : X2Class?

  # Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
  property y : XClass?

  # Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  property y2 : X2Class?
end

# Unit spec that can have a composite mark.
class LayerSpec
  include JSON::Serializable

  # An object describing the data source
  property data : Data?

  # Description of this mark for commenting purpose.
  property description : String?

  # The height of a visualization.
  #
  # __Default value:__
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
  # [continuous scale](scale.html#continuous), the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the height is [determined by the range step, paddings, and the
  # cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
  # `rangeStep` is `null`, the height will be the value of
  # [`config.view.height`](spec.html#config).
  # - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
  #
  # __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the height of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property height : Float64?

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  property layer : Array(LayerSpec)?

  # Name of the visualization for later reference.
  property name : String?

  # Scale, axis, and legend resolutions for layers.
  property resolve : Resolve?

  # Title for the plot.
  property title : Title?

  # An array of data transformations such as filter and new field calculation.
  property transform : Array(Transform)?

  # The width of a visualization.
  #
  # __Default value:__ This will be determined by the following rules:
  #
  # - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
  # [continuous scale](scale.html#continuous), the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
  # value or unspecified, the width is [determined by the range step, paddings, and the
  # cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
  # `rangeStep` is `null`, the width will be the value of
  # [`config.view.width`](spec.html#config).
  # - If no field is mapped to `x` channel, the `width` will be the value of
  # [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
  # the value of `rangeStep` for other marks.
  #
  # __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
  # represents the width of a single view.
  #
  # __See also:__ The documentation for [width and height](size.html) contains more examples.
  property width : Float64?

  # A key-value mapping between encoding channels and definition of fields.
  property encoding : Encoding?

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  property mark : AnyMark?

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  property projection : Projection?

  # A key-value mapping between selection names and definitions.
  property selection : Hash(String, SelectionDef)?
end

class MarkDef
  include JSON::Serializable

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  property align : String?

  # The rotation angle of the text, in degrees.
  property angle : Float64?

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  property baseline : String?

  # Whether a mark be clipped to the enclosing group’s width and height.
  property clip : Bool?

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property color : String?

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  property cursor : String?

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dx : Float64?

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  property dy : Float64?

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property fill : String?

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  property filled : Bool?

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "fillOpacity")]
  property fill_opacity : Float64?

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  property font : String?

  # The font size, in pixels.
  @[JSON::Field(key: "fontSize")]
  property font_size : Float64?

  # The font style (e.g., `"italic"`).
  @[JSON::Field(key: "fontStyle")]
  property font_style : String?

  # The font weight (e.g., `"bold"`).
  @[JSON::Field(key: "fontWeight")]
  property font_weight : FontWeightUnion?

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  property href : String?

  # The line interpolation method to use for line and area marks. One of the following:
  # - `"linear"`: piecewise linear segments, as in a polyline.
  # - `"linear-closed"`: close the linear segments to form a polygon.
  # - `"step"`: alternate between horizontal and vertical segments, as in a step function.
  # - `"step-before"`: alternate between vertical and horizontal segments, as in a step
  # function.
  # - `"step-after"`: alternate between horizontal and vertical segments, as in a step
  # function.
  # - `"basis"`: a B-spline, with control point duplication on the ends.
  # - `"basis-open"`: an open B-spline; may not intersect the start or end.
  # - `"basis-closed"`: a closed B-spline, as in a loop.
  # - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
  # - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
  # will intersect other control points.
  # - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
  # - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
  # spline.
  # - `"monotone"`: cubic interpolation that preserves monotonicity in y.
  property interpolate : String?

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  property limit : Float64?

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  property opacity : Float64?

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  property orient : String?

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  property radius : Float64?

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  property shape : String?

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  property size : Float64?

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  property stroke : String?

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  @[JSON::Field(key: "strokeDash")]
  property stroke_dash : Array(Float64)?

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  @[JSON::Field(key: "strokeDashOffset")]
  property stroke_dash_offset : Float64?

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  @[JSON::Field(key: "strokeOpacity")]
  property stroke_opacity : Float64?

  # The stroke width, in pixels.
  @[JSON::Field(key: "strokeWidth")]
  property stroke_width : Float64?

  # A string or array of strings indicating the name of custom styles to apply to the mark. A
  # style is a named collection of mark property defaults defined within the [style
  # configuration](mark.html#style-config). If style is an array, later styles will override
  # earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
  # the `encoding` will override a style default.
  #
  # __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
  # default.
  # __Note:__ Any specified style will augment the default style. For example, a bar mark
  # with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
  # specified style `"foo"` has higher precedence).
  property style : Style?

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  property tension : Float64?

  # Placeholder text if the `text` channel is not specified
  property text : String?

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  property theta : Float64?

  # The mark type.
  # One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
  # `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
  @[JSON::Field(key: "type")]
  property mark_def_type : String
end

# An object defining properties of geographic projection.
#
# Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
# more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
class Projection
  include JSON::Serializable

  # Sets the projection’s center to the specified center, a two-element array of longitude
  # and latitude in degrees.
  #
  # __Default value:__ `[0, 0]`
  property center : Array(Float64)?

  # Sets the projection’s clipping circle radius to the specified angle in degrees. If
  # `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
  # than small-circle clipping.
  @[JSON::Field(key: "clipAngle")]
  property clip_angle : Float64?

  # Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
  # bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
  # the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
  # viewport clipping is performed.
  @[JSON::Field(key: "clipExtent")]
  property clip_extent : Array(Array(Float64))?

  property coefficient : Float64?

  property distance : Float64?

  property fraction : Float64?

  property lobes : Float64?

  property parallel : Float64?

  # Sets the threshold for the projection’s [adaptive
  # resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
  # value corresponds to the [Douglas–Peucker
  # distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
  # If precision is not specified, returns the projection’s current resampling precision
  # which defaults to `√0.5 ≅ 0.70710…`.
  property precision : Hash(String, PrecisionValue)?

  property radius : Float64?

  property ratio : Float64?

  # Sets the projection’s three-axis rotation to the specified angles, which must be a two-
  # or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
  # angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
  #
  # __Default value:__ `[0, 0, 0]`
  property rotate : Array(Float64)?

  property spacing : Float64?

  property tilt : Float64?

  # The cartographic projection to use. This value is case-insensitive, for example
  # `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
  # projection types [in the
  # documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
  #
  # __Default value:__ `mercator`
  @[JSON::Field(key: "type")]
  property projection_type : String?
end

# Scale, axis, and legend resolutions for layers.
#
# Defines how scales, axes, and legends from different specs should be combined. Resolve is
# a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
#
# Scale, axis, and legend resolutions for facets.
#
# Scale and legend resolutions for repeated charts.
#
# Scale, axis, and legend resolutions for vertically concatenated charts.
#
# Scale, axis, and legend resolutions for horizontally concatenated charts.
class Resolve
  include JSON::Serializable

  property axis : AxisResolveMap?

  property legend : LegendResolveMap?

  property scale : ScaleResolveMap?
end

class AxisResolveMap
  include JSON::Serializable

  property x : String?

  property y : String?
end

class LegendResolveMap
  include JSON::Serializable

  property color : String?

  property opacity : String?

  property shape : String?

  property size : String?
end

class ScaleResolveMap
  include JSON::Serializable

  property color : String?

  property opacity : String?

  property shape : String?

  property size : String?

  property x : String?

  property y : String?
end

class SelectionDef
  include JSON::Serializable

  # Establish a two-way binding between a single selection and input elements
  # (also known as dynamic query widgets). A binding takes the form of
  # Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
  # or can be a mapping between projected field/encodings and binding definitions.
  #
  # See the [bind transform](bind.html) documentation for more information.
  #
  # Establishes a two-way binding between the interval selection and the scales
  # used within the same view. This allows a user to interactively pan and
  # zoom the view.
  property bind : BindUnion?

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  property empty : String?

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  property encodings : Array(String)?

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  property fields : Array(String)?

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  property nearest : Bool?

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  property on : JSON::Any?

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  property resolve : String?

  @[JSON::Field(key: "type")]
  property selection_def_type : String

  # Controls whether data values should be toggled or only ever inserted into
  # multi selections. Can be `true`, `false` (for insertion only), or a
  # [Vega expression](https://vega.github.io/vega/docs/expressions/).
  #
  # __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
  # data values are toggled when a user interacts with the shift-key pressed).
  #
  # See the [toggle transform](toggle.html) documentation for more information.
  property toggle : Translate?

  # An interval selection also adds a rectangle mark to depict the
  # extents of the interval. The `mark` property can be used to customize the
  # appearance of the mark.
  property mark : BrushConfig?

  # When truthy, allows a user to interactively move an interval selection
  # back-and-forth. Can be `true`, `false` (to disable panning), or a
  # [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
  # which must include a start and end event to trigger continuous panning.
  #
  # __Default value:__ `true`, which corresponds to
  # `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
  # clicks and dragging within an interval selection to reposition it.
  property translate : Translate?

  # When truthy, allows a user to interactively resize an interval selection.
  # Can be `true`, `false` (to disable zooming), or a [Vega event stream
  # definition](https://vega.github.io/vega/docs/event-streams/). Currently,
  # only `wheel` events are supported.
  #
  #
  # __Default value:__ `true`, which corresponds to `wheel!`.
  property zoom : Translate?
end

class TitleParams
  include JSON::Serializable

  # The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
  # example, with an orientation of top these anchor positions map to a left-, center-, or
  # right-aligned title.
  #
  # __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
  # `"start"` for other composite views.
  #
  # __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
  # customizable only for [single](spec.html) and [layered](layer.html) views.  For other
  # composite views, `anchor` is always `"start"`.
  property anchor : String?

  # The orthogonal offset in pixels by which to displace the title from its position along
  # the edge of the chart.
  property offset : Float64?

  # The orientation of the title relative to the chart. One of `"top"` (the default),
  # `"bottom"`, `"left"`, or `"right"`.
  property orient : String?

  # A [mark style property](config.html#style) to apply to the title text mark.
  #
  # __Default value:__ `"group-title"`.
  property style : Style?

  # The title text.
  property text : String
end

class Transform
  include JSON::Serializable

  # The `filter` property must be one of the predicate definitions:
  # (1) an [expression](types.html#expression) string,
  # where `datum` can be used to refer to the current data object;
  # (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
  # [range predicate](filter.html#range-predicate), [one-of
  # predicate](filter.html#one-of-predicate);
  # (3) a [selection predicate](filter.html#selection-predicate);
  # or (4) a logical operand that combines (1), (2), or (3).
  property filter : ConditionalValueDefLogicalOperandPredicate?

  # The field for storing the computed formula value.
  #
  # The field or fields for storing the computed formula value.
  # If `from.fields` is specified, the transform will use the same names for `as`.
  # If `from.fields` is not specified, `as` has to be a string and we put the whole object
  # into the data under the specified name.
  #
  # The output fields at which to write the start and end bin values.
  #
  # The output field to write the timeUnit value.
  @[JSON::Field(key: "as")]
  property transform_as : Style?

  # A [expression](types.html#expression) string. Use the variable `datum` to refer to the
  # current data object.
  property calculate : String?

  # The default value to use if lookup fails.
  #
  # __Default value:__ `null`
  property default : String?

  # Secondary data reference.
  property from : LookupData?

  # Key in primary data source.
  property lookup : String?

  # An object indicating bin properties, or simply `true` for using default bin parameters.
  property bin : Bin?

  # The data field to bin.
  #
  # The data field to apply time unit.
  property field : String?

  # The timeUnit.
  @[JSON::Field(key: "timeUnit")]
  property time_unit : String?

  # Array of objects that define fields to aggregate.
  property aggregate : Array(AggregatedFieldDef)?

  # The data fields to group by. If not specified, a single group containing all data objects
  # will be used.
  property groupby : Array(String)?
end

class AggregatedFieldDef
  include JSON::Serializable

  # The output field names to use for each aggregated field.
  @[JSON::Field(key: "as")]
  property aggregated_field_def_as : String

  # The data field for which to compute aggregate function.
  property field : String

  # The aggregation operations to apply to the fields, such as sum, average or count.
  # See the [full list of supported aggregation
  # operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
  # for more information.
  property op : String
end

# Secondary data reference.
class LookupData
  include JSON::Serializable

  # Secondary data source to lookup in.
  property data : Data

  # Fields in foreign data to lookup.
  # If not specified, the entire object is queried.
  property fields : Array(String)?

  # Key in data to lookup.
  property key : String
end

# An object that describes what fields should be repeated into views that are laid out as a
# `row` or `column`.
class Repeat
  include JSON::Serializable

  # Horizontal repeated views.
  property column : Array(String)?

  # Vertical repeated views.
  property row : Array(String)?
end

# Sets how the visualization size should be determined. If a string, should be one of
# `"pad"`, `"fit"` or `"none"`.
# Object values can additionally specify parameters for content sizing and automatic
# resizing.
# `"fit"` is only supported for single and layered views that don't use `rangeStep`.
#
# __Default value__: `pad`
alias Autosize = AutoSizeParams | String

# The font weight (e.g., `"bold"`).
#
# Font weight for title text.
alias FontWeightUnion = Float64 | String

# Indicates if labels should be hidden if they exceed the axis range. If `false `(the
# default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
# they exceed the axis range by more than 1 pixel. If this property is a number, it
# specifies the pixel tolerance: the maximum amount by which a label bounding box may
# exceed the axis range.
#
# __Default value:__ `false`.
#
# Indicates if the first and last axis labels should be aligned flush with the scale range.
# Flush alignment for a horizontal axis will left-align the first label and right-align the
# last label. For vertical axes, bottom and top text baselines are applied instead. If this
# property is a number, it also indicates the number of pixels by which to offset the first
# and last labels; for example, a value of 2 will flush-align the first and last labels and
# also push them 2 pixels outward from the center of the axis. The additional adjustment
# can sometimes help the labels better visually group with corresponding axis ticks.
#
# __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
alias Label = Float64 | Bool

alias LabelOverlapUnion = Bool | String

# Font weight of the title. (e.g., `"bold"`).
#
# The font weight of the legend title.
alias TitleFontWeightUnion = Float64 | String

# The default visualization padding, in pixels, from the edge of the visualization canvas
# to the data rectangle.  If a number, specifies padding for all sides.
# If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
# "bottom": 5}` to specify padding for each side of the visualization.
#
# __Default value__: `5`
alias Padding = Float64 | PaddingClass

# Font weight of the title. (e.g., `"bold"`).
#
# The font weight of the legend title.
alias PrecisionValue = Float64 | String

alias RangeConfigValue = Array(PrecisionValue) | VgScheme

# When truthy, allows a user to interactively move an interval selection
# back-and-forth. Can be `true`, `false` (to disable panning), or a
# [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
# which must include a start and end event to trigger continuous panning.
#
# __Default value:__ `true`, which corresponds to
# `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
# clicks and dragging within an interval selection to reposition it.
#
# When truthy, allows a user to interactively resize an interval selection.
# Can be `true`, `false` (to disable zooming), or a [Vega event stream
# definition](https://vega.github.io/vega/docs/event-streams/). Currently,
# only `wheel` events are supported.
#
#
# __Default value:__ `true`, which corresponds to `wheel!`.
#
# Controls whether data values should be toggled or only ever inserted into
# multi selections. Can be `true`, `false` (for insertion only), or a
# [Vega expression](https://vega.github.io/vega/docs/expressions/).
#
# __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
# data values are toggled when a user interacts with the shift-key pressed).
#
# See the [toggle transform](toggle.html) documentation for more information.
alias Translate = Bool | String

alias ParseUnion = Hash(String, JSON::Any?) | String

# The full data set, included inline. This can be an array of objects or primitive values
# or a string.
# Arrays of primitive values are ingested as objects with a `data` property. Strings are
# parsed according to the specified format type.
alias Values = Hash(String, JSON::Any?) | String | Array(ValuesValue)

alias ValuesValue = Hash(String, JSON::Any?) | Float64 | Bool | String

alias Bin = BinParams | Bool

alias ColorCondition = ConditionalPredicateMarkPropFieldDefClass | Array(ConditionalValueDef)

# Filter using a selection name.
#
# A [selection name](selection.html), or a series of [composed
# selections](selection.html#compose).
alias SelectionOperandElement = String | Selection

# Filter using a selection name.
#
# A [selection name](selection.html), or a series of [composed
# selections](selection.html#compose).
alias ConditionalValueDefSelectionOperand = String | Selection

# The `filter` property must be one of the predicate definitions:
# (1) an [expression](types.html#expression) string,
# where `datum` can be used to refer to the current data object;
# (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
# [range predicate](filter.html#range-predicate), [one-of
# predicate](filter.html#one-of-predicate);
# (3) a [selection predicate](filter.html#selection-predicate);
# or (4) a logical operand that combines (1), (2), or (3).
alias LogicalOperandPredicateElement = Predicate | String

# The `filter` property must be one of the predicate definitions:
# (1) an [expression](types.html#expression) string,
# where `datum` can be used to refer to the current data object;
# (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
# [range predicate](filter.html#range-predicate), [one-of
# predicate](filter.html#one-of-predicate);
# (3) a [selection predicate](filter.html#selection-predicate);
# or (4) a logical operand that combines (1), (2), or (3).
alias ConditionalValueDefLogicalOperandPredicate = Predicate | String

# The value that the field should be equal to.
alias EqualUnion = DateTime | Float64 | Bool | String

# Value representing the day of a week.  This can be one of: (1) integer value -- `1`
# represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
# case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
# DateTime definition object with `day`** should not be combined with `year`, `quarter`,
# `month`, or `date`.
alias Day = Float64 | String

# One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
# (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
# short month name (e.g., `"Jan"`).
alias Month = Float64 | String

# The value that the field should be equal to.
alias OneOfElement = DateTime | Float64 | Bool | String

alias RangeElement = DateTime | Float64

# A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
# `0` to `1` for opacity).
#
# A constant value in visual domain.
alias ConditionalValueDefValue = Float64 | Bool | String

alias Field = String | RepeatRef

alias LegendValue = DateTime | Float64 | String

# Customized domain values.
#
# For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
# and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
# a `domain` with more than two entries.
# If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
# indicating that the domain should include the raw data values prior to the aggregation.
#
# For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
# the form of either timestamps or the [DateTime definition objects](types.html#datetime).
#
# For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
# values.
#
# The `selection` property can be used to [interactively
# determine](selection.html#scale-domains) the scale domain.
alias DomainUnion = DomainClass | String | Array(OneOfElement)

# The interpolation method for range values. By default, a general interpolator for
# numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
# property allows interpolation in alternative color spaces. Legal values include `rgb`,
# `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
# variants use longer paths in polar coordinate spaces). If object-valued, this property
# accepts an object with a string-valued _type_ property and an optional numeric _gamma_
# property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
# documentation](https://github.com/d3/d3-interpolate).
#
# __Note:__ Sequential scales do not support `interpolate` as they have a fixed
# interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
# you have to set the scale `type` to other quantitative scale type such as `"linear"` to
# customize `interpolate`.
alias InterpolateUnion = InterpolateParams | String

# Extending the domain so that it starts and ends on nice round values. This method
# typically modifies the scale’s domain, and may only extend the bounds to the nearest
# round value. Nicing is useful if the domain is computed from data and may be irregular.
# For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
# 1.0]_.
#
# For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
# If `nice` is a number, it will represent a desired tick count. This allows greater
# control over the step size used to extend the bounds, guaranteeing that the returned
# ticks will exactly cover the domain.
#
# For temporal fields with time and utc scales, the `nice` value can be a string indicating
# the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
# `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
# scales can accept an object-valued interval specifier of the form `{"interval": "month",
# "step": 3}`, which includes a desired number of interval steps. Here, the domain would
# snap to quarter (Jan, Apr, Jul, Oct) boundaries.
#
# __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
alias NiceUnion = Float64 | NiceClass | Bool | String

# The range of the scale. One of:
#
# - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
# example, `"symbol"`, or `"diverging"`).
#
# - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
# and maximum values, or an array with more than two entries for specifying a [piecewise
# scale](scale.html#piecewise).
#
# - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
# an array of desired output values.
#
# __Notes:__
#
# 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
# discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
# instead of `range`.
#
# 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
# customized via the view's corresponding [size](size.html) (`width` and `height`) or via
# [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
# scales.
alias ScaleRange = String | Array(PrecisionValue)

# A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
# `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
#
# Discrete color schemes may be used with [discrete](scale.html#discrete) or
# [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
# use with [sequential](scales.html#sequential) scales.
#
# For the full list of supported scheme, please refer to the [Vega
# Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
alias Scheme = String | SchemeParams

alias SortUnion = String | SortField

# A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
# `0` to `1` for opacity).
#
# A constant value in visual domain.
alias ConditionalPredicateValueDefValue = Float64 | Bool | String

alias Detail = FieldDef | Array(FieldDef)

alias HrefCondition = ConditionalPredicateFieldDefClass | Array(ConditionalValueDef)

alias Order = OrderFieldDef | Array(OrderFieldDef)

alias TextCondition = ConditionalPredicateTextFieldDefClass | Array(ConditionalValueDef)

alias AxisValue = DateTime | Float64

# A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
# `"line"`,
# * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
# object](mark.html#mark-def).
alias AnyMark = MarkDef | String

# A string or array of strings indicating the name of custom styles to apply to the mark. A
# style is a named collection of mark property defaults defined within the [style
# configuration](mark.html#style-config). If style is an array, later styles will override
# earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
# the `encoding` will override a style default.
#
# __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
# default.
# __Note:__ Any specified style will augment the default style. For example, a bar mark
# with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
# specified style `"foo"` has higher precedence).
#
# A [mark style property](config.html#style) to apply to the title text mark.
#
# __Default value:__ `"group-title"`.
alias Style = String | Array(String)

alias BindUnion = String | Hash(String, VgBinding)

alias Title = String | TitleParams
