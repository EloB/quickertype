# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.hconcat&.first.hconcat&.first.hconcat&.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil                   = Strict::Nil
  Bool                  = Strict::Bool
  Hash                  = Strict::Hash
  String                = Strict::String
  Double                = Strict::Float | Strict::Integer
  AutosizeType          = Strict::String.enum("pad", "fit", "none")
  Contains              = Strict::String.enum("content", "padding")
  HorizontalAlign       = Strict::String.enum("left", "right", "center")
  VerticalAlign         = Strict::String.enum("top", "middle", "bottom")
  Cursor                = Strict::String.enum("auto", "default", "none", "context-menu", "help", "pointer", "progress", "wait", "cell", "crosshair", "text", "vertical-text", "alias", "copy", "move", "no-drop", "not-allowed", "e-resize", "n-resize", "ne-resize", "nw-resize", "s-resize", "se-resize", "sw-resize", "w-resize", "ew-resize", "ns-resize", "nesw-resize", "nwse-resize", "col-resize", "row-resize", "all-scroll", "zoom-in", "zoom-out", "grab", "grabbing")
  FontStyle             = Strict::String.enum("normal", "italic")
  FontWeight            = Strict::String.enum("normal", "bold")
  Interpolate           = Strict::String.enum("linear", "linear-closed", "step", "step-before", "step-after", "basis", "basis-open", "basis-closed", "cardinal", "cardinal-open", "cardinal-closed", "bundle", "monotone")
  Orient                = Strict::String.enum("horizontal", "vertical")
  LabelOverlapEnum      = Strict::String.enum("parity", "greedy")
  FieldTitle            = Strict::String.enum("verbal", "functional", "plain")
  InvalidValues         = Strict::String.enum("filter")
  LegendOrient          = Strict::String.enum("left", "right", "top-left", "top-right", "bottom-left", "bottom-right", "none")
  VGProjectionType      = Strict::String.enum("albers", "albersUsa", "azimuthalEqualArea", "azimuthalEquidistant", "conicConformal", "conicEqualArea", "conicEquidistant", "equirectangular", "gnomonic", "mercator", "orthographic", "stereographic", "transverseMercator")
  BindEnum              = Strict::String.enum("scales")
  Empty                 = Strict::String.enum("all", "none")
  SingleDefChannel      = Strict::String.enum("x", "y", "x2", "y2", "row", "column", "size", "shape", "color", "opacity", "text", "tooltip", "href")
  SelectionResolution   = Strict::String.enum("global", "union", "intersect")
  StackOffset           = Strict::String.enum("zero", "center", "normalize")
  Anchor                = Strict::String.enum("start", "middle", "end")
  TitleOrient           = Strict::String.enum("top", "bottom", "left", "right")
  DataFormatType        = Strict::String.enum("csv", "tsv", "json", "topojson")
  ParseEnum             = Strict::String.enum("auto")
  AggregateOp           = Strict::String.enum("argmax", "argmin", "average", "count", "distinct", "max", "mean", "median", "min", "missing", "q1", "q3", "ci0", "ci1", "stdev", "stdevp", "sum", "valid", "values", "variance", "variancep")
  TimeUnit              = Strict::String.enum("year", "quarter", "month", "day", "date", "hours", "minutes", "seconds", "milliseconds", "utcyear", "utcquarter", "utcmonth", "utcday", "utcdate", "utchours", "utcminutes", "utcseconds", "utcmilliseconds", "yearquarter", "yearquartermonth", "yearmonth", "yearmonthdate", "yearmonthdatehours", "yearmonthdatehoursminutes", "yearmonthdatehoursminutesseconds", "quartermonth", "monthdate", "hoursminutes", "hoursminutesseconds", "minutesseconds", "secondsmilliseconds", "utcyearquarter", "utcyearquartermonth", "utcyearmonth", "utcyearmonthdate", "utcyearmonthdatehours", "utcyearmonthdatehoursminutes", "utcyearmonthdatehoursminutesseconds", "utcquartermonth", "utcmonthdate", "utchoursminutes", "utchoursminutesseconds", "utcminutesseconds", "utcsecondsmilliseconds")
  Type                  = Strict::String.enum("quantitative", "ordinal", "temporal", "nominal", "latitude", "longitude", "geojson")
  RepeatEnum            = Strict::String.enum("row", "column")
  LegendType            = Strict::String.enum("symbol", "gradient")
  Domain                = Strict::String.enum("unaggregated")
  InterpolateParamsType = Strict::String.enum("rgb", "cubehelix", "cubehelix-long")
  NiceTime              = Strict::String.enum("second", "minute", "hour", "day", "week", "month", "year")
  ScaleType             = Strict::String.enum("linear", "bin-linear", "log", "pow", "sqrt", "time", "utc", "sequential", "ordinal", "bin-ordinal", "point", "band")
  SortEnum              = Strict::String.enum("ascending", "descending")
  Mark                  = Strict::String.enum("area", "bar", "line", "point", "text", "tick", "rect", "rule", "circle", "square", "geoshape")
  ResolveMode           = Strict::String.enum("independent", "shared")
  SelectionDefType      = Strict::String.enum("single", "multi", "interval")
end

# (forward declaration)
class Selection < Dry::Struct; end

# (forward declaration)
class Predicate < Dry::Struct; end

# The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
# type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
# descriptions of each.
#
# __Default value__: `"pad"`
module AutosizeType
  Pad  = "pad"
  Fit  = "fit"
  None = "none"
end

# Determines how size calculation should be performed, one of `"content"` or `"padding"`.
# The default setting (`"content"`) interprets the width and height settings as the data
# rectangle (plotting) dimensions, to which padding is then added. In contrast, the
# `"padding"` setting includes the padding within the view size calculations, such that the
# width and height settings indicate the **total** intended size of the view.
#
# __Default value__: `"content"`
module Contains
  Content = "content"
  Padding = "padding"
end

class AutoSizeParams < Dry::Struct

  # Determines how size calculation should be performed, one of `"content"` or `"padding"`.
  # The default setting (`"content"`) interprets the width and height settings as the data
  # rectangle (plotting) dimensions, to which padding is then added. In contrast, the
  # `"padding"` setting includes the padding within the view size calculations, such that the
  # width and height settings indicate the **total** intended size of the view.
  #
  # __Default value__: `"content"`
  attribute :contains, Types::Contains.optional

  # A boolean flag indicating if autosize layout should be re-calculated on every view
  # update.
  #
  # __Default value__: `false`
  attribute :resize, Types::Bool.optional

  # The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
  # type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
  # descriptions of each.
  #
  # __Default value__: `"pad"`
  attribute :auto_size_params_type, Types::AutosizeType.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      contains:              d.key?("contains") ? Types::Contains[d["contains"]] : nil,
      resize:                d.key?("resize") ? Types::Bool[d["resize"]] : nil,
      auto_size_params_type: d.key?("type") ? Types::AutosizeType[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "contains" => contains,
      "resize"   => resize,
      "type"     => auto_size_params_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Sets how the visualization size should be determined. If a string, should be one of
# `"pad"`, `"fit"` or `"none"`.
# Object values can additionally specify parameters for content sizing and automatic
# resizing.
# `"fit"` is only supported for single and layered views that don't use `rangeStep`.
#
# __Default value__: `pad`
class Autosize < Dry::Struct
  attribute :auto_size_params, AutoSizeParams.optional
  attribute :enum_1,           Types::AutosizeType.optional

  def self.from_dynamic!(d)
    begin
      value = AutoSizeParams.from_dynamic!(d)
      if schema.key(:auto_size_params).type.right.valid? value
        return new(auto_size_params: value, enum_1: nil)
      end
    rescue
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, auto_size_params: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if auto_size_params != nil
      auto_size_params.to_dynamic
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
module HorizontalAlign
  Left   = "left"
  Right  = "right"
  Center = "center"
end

# The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
#
# __Default value:__ `"middle"`
#
# Vertical text baseline for title text.
module VerticalAlign
  Top    = "top"
  Middle = "middle"
  Bottom = "bottom"
end

# The mouse cursor used over the mark. Any valid [CSS cursor
# type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
module Cursor
  Auto         = "auto"
  Default      = "default"
  None         = "none"
  ContextMenu  = "context-menu"
  Help         = "help"
  Pointer      = "pointer"
  Progress     = "progress"
  Wait         = "wait"
  Cell         = "cell"
  Crosshair    = "crosshair"
  Text         = "text"
  VerticalText = "vertical-text"
  Alias        = "alias"
  Copy         = "copy"
  Move         = "move"
  NoDrop       = "no-drop"
  NotAllowed   = "not-allowed"
  EResize      = "e-resize"
  NResize      = "n-resize"
  NeResize     = "ne-resize"
  NwResize     = "nw-resize"
  SResize      = "s-resize"
  SEResize     = "se-resize"
  SwResize     = "sw-resize"
  WResize      = "w-resize"
  EwResize     = "ew-resize"
  NSResize     = "ns-resize"
  NeswResize   = "nesw-resize"
  NwseResize   = "nwse-resize"
  ColResize    = "col-resize"
  RowResize    = "row-resize"
  AllScroll    = "all-scroll"
  ZoomIn       = "zoom-in"
  ZoomOut      = "zoom-out"
  Grab         = "grab"
  Grabbing     = "grabbing"
end

# The font style (e.g., `"italic"`).
module FontStyle
  Normal = "normal"
  Italic = "italic"
end

module FontWeight
  Normal = "normal"
  Bold   = "bold"
end

# The font weight (e.g., `"bold"`).
#
# Font weight for title text.
class FontWeightUnion < Dry::Struct
  attribute :double, Types::Double.constrained(gteq: 100, lteq: 900).optional
  attribute :enum_1, Types::FontWeight.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, enum_1: nil)
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
module Interpolate
  Linear         = "linear"
  LinearClosed   = "linear-closed"
  Step           = "step"
  StepBefore     = "step-before"
  StepAfter      = "step-after"
  Basis          = "basis"
  BasisOpen      = "basis-open"
  BasisClosed    = "basis-closed"
  Cardinal       = "cardinal"
  CardinalOpen   = "cardinal-open"
  CardinalClosed = "cardinal-closed"
  Bundle         = "bundle"
  Monotone       = "monotone"
end

# The orientation of a non-stacked bar, tick, area, and line charts.
# The value is either horizontal (default) or vertical.
# - For bar, rule and tick, this determines whether the size of the bar and tick
# should be applied to x or y dimension.
# - For area, this property determines the orient property of the Vega output.
# - For line, this property determines the sort order of the points in the line
# if `config.sortLineBy` is not specified.
# For stacked charts, this is always determined by the orientation of the stack;
# therefore explicitly specified value will be ignored.
module Orient
  Horizontal = "horizontal"
  Vertical   = "vertical"
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
class MarkConfig < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :color, Types::String.optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :filled, Types::Bool.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:              d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:              d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      baseline:           d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      color:              d.key?("color") ? Types::String[d["color"]] : nil,
      cursor:             d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      dx:                 d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                 d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      filled:             d.key?("filled") ? Types::Bool[d["filled"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:               d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:          d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:         d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:        d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:               d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:        d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:              d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:            d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:             d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:             d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:              d.key?("shape") ? Types::String[d["shape"]] : nil,
      size:               d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      tension:            d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:               d.key?("text") ? Types::String[d["text"]] : nil,
      theta:              d.key?("theta") ? Types::Double[d["theta"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"            => align,
      "angle"            => angle,
      "baseline"         => baseline,
      "color"            => color,
      "cursor"           => cursor,
      "dx"               => dx,
      "dy"               => dy,
      "fill"             => fill,
      "filled"           => filled,
      "fillOpacity"      => fill_opacity,
      "font"             => font,
      "fontSize"         => font_size,
      "fontStyle"        => font_style,
      "fontWeight"       => font_weight&.to_dynamic,
      "href"             => href,
      "interpolate"      => interpolate,
      "limit"            => limit,
      "opacity"          => opacity,
      "orient"           => orient,
      "radius"           => radius,
      "shape"            => shape,
      "size"             => size,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "tension"          => tension,
      "text"             => text,
      "theta"            => theta,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
class Label < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module LabelOverlapEnum
  Parity = "parity"
  Greedy = "greedy"
end

class LabelOverlapUnion < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :enum_1, Types::LabelOverlapEnum.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, enum_1: nil)
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Font weight of the title. (e.g., `"bold"`).
#
# The font weight of the legend title.
class TitleFontWeight < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Axis configuration, which determines default properties for all `x` and `y`
# [axes](axis.html). For a full list of axis configuration options, please see the
# [corresponding section of the axis documentation](axis.html#config).
class AxisConfig < Dry::Struct

  # An interpolation fraction indicating where, for `band` scales, axis ticks should be
  # positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
  # places ticks in the middle of their bands.
  attribute :band_position, Types::Double.optional

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  attribute :domain, Types::Bool.optional

  # Color of axis domain line.
  #
  # __Default value:__  (none, using Vega default).
  attribute :domain_color, Types::String.optional

  # Stroke width of axis domain line
  #
  # __Default value:__  (none, using Vega default).
  attribute :domain_width, Types::Double.optional

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  attribute :grid, Types::Bool.optional

  # Color of gridlines.
  attribute :grid_color, Types::String.optional

  # The offset (in pixels) into which to begin drawing with the grid dash array.
  attribute :grid_dash, Types.Array(Types::Double).optional

  # The stroke opacity of grid (value between [0,1])
  #
  # __Default value:__ (`1` by default)
  attribute :grid_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The grid width, in pixels.
  attribute :grid_width, Types::Double.constrained(gteq: 0).optional

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  attribute :label_angle, Types::Double.constrained(gteq: -360, lteq: 360).optional

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  attribute :label_bound, Types.Instance(Label).optional

  # The color of the tick label, can be in hex color code or regular color name.
  attribute :label_color, Types::String.optional

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  attribute :label_flush, Types.Instance(Label).optional

  # The font of the tick label.
  attribute :label_font, Types::String.optional

  # The font size of the label, in pixels.
  attribute :label_font_size, Types::Double.constrained(gteq: 0).optional

  # Maximum allowed pixel width of axis tick labels.
  attribute :label_limit, Types::Double.optional

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  attribute :label_overlap, Types.Instance(LabelOverlapUnion).optional

  # The padding, in pixels, between axis and text labels.
  attribute :label_padding, Types::Double.optional

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  attribute :labels, Types::Bool.optional

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  attribute :max_extent, Types::Double.optional

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  attribute :min_extent, Types::Double.optional

  # Whether month names and weekday names should be abbreviated.
  #
  # __Default value:__  `false`
  attribute :short_time_labels, Types::Bool.optional

  # The color of the axis's tick.
  attribute :tick_color, Types::String.optional

  # Boolean flag indicating if pixel position values should be rounded to the nearest integer.
  attribute :tick_round, Types::Bool.optional

  # Boolean value that determines whether the axis should include ticks.
  attribute :ticks, Types::Bool.optional

  # The size in pixels of axis ticks.
  attribute :tick_size, Types::Double.constrained(gteq: 0).optional

  # The width, in pixels, of ticks.
  attribute :tick_width, Types::Double.constrained(gteq: 0).optional

  # Horizontal text alignment of axis titles.
  attribute :title_align, Types::String.optional

  # Angle in degrees of axis titles.
  attribute :title_angle, Types::Double.optional

  # Vertical text baseline for axis titles.
  attribute :title_baseline, Types::String.optional

  # Color of the title, can be in hex color code or regular color name.
  attribute :title_color, Types::String.optional

  # Font of the title. (e.g., `"Helvetica Neue"`).
  attribute :title_font, Types::String.optional

  # Font size of the title.
  attribute :title_font_size, Types::Double.constrained(gteq: 0).optional

  # Font weight of the title. (e.g., `"bold"`).
  attribute :title_font_weight, Types.Instance(TitleFontWeight).optional

  # Maximum allowed pixel width of axis titles.
  attribute :title_limit, Types::Double.optional

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  attribute :title_max_length, Types::Double.optional

  # The padding, in pixels, between title and axis.
  attribute :title_padding, Types::Double.optional

  # X-coordinate of the axis title relative to the axis group.
  attribute :title_x, Types::Double.optional

  # Y-coordinate of the axis title relative to the axis group.
  attribute :title_y, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      band_position:     d.key?("bandPosition") ? Types::Double[d["bandPosition"]] : nil,
      domain:            d.key?("domain") ? Types::Bool[d["domain"]] : nil,
      domain_color:      d.key?("domainColor") ? Types::String[d["domainColor"]] : nil,
      domain_width:      d.key?("domainWidth") ? Types::Double[d["domainWidth"]] : nil,
      grid:              d.key?("grid") ? Types::Bool[d["grid"]] : nil,
      grid_color:        d.key?("gridColor") ? Types::String[d["gridColor"]] : nil,
      grid_dash:         d.key?("gridDash") ? d["gridDash"].map { |x| Types::Double[x] } : nil,
      grid_opacity:      d.key?("gridOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["gridOpacity"]] : nil,
      grid_width:        d.key?("gridWidth") ? Types::Double.constrained(gteq: 0)[d["gridWidth"]] : nil,
      label_angle:       d.key?("labelAngle") ? Types::Double.constrained(gteq: -360, lteq: 360)[d["labelAngle"]] : nil,
      label_bound:       d.key?("labelBound") ? Label.from_dynamic!(d["labelBound"]) : nil,
      label_color:       d.key?("labelColor") ? Types::String[d["labelColor"]] : nil,
      label_flush:       d.key?("labelFlush") ? Label.from_dynamic!(d["labelFlush"]) : nil,
      label_font:        d.key?("labelFont") ? Types::String[d["labelFont"]] : nil,
      label_font_size:   d.key?("labelFontSize") ? Types::Double.constrained(gteq: 0)[d["labelFontSize"]] : nil,
      label_limit:       d.key?("labelLimit") ? Types::Double[d["labelLimit"]] : nil,
      label_overlap:     d.key?("labelOverlap") ? LabelOverlapUnion.from_dynamic!(d["labelOverlap"]) : nil,
      label_padding:     d.key?("labelPadding") ? Types::Double[d["labelPadding"]] : nil,
      labels:            d.key?("labels") ? Types::Bool[d["labels"]] : nil,
      max_extent:        d.key?("maxExtent") ? Types::Double[d["maxExtent"]] : nil,
      min_extent:        d.key?("minExtent") ? Types::Double[d["minExtent"]] : nil,
      short_time_labels: d.key?("shortTimeLabels") ? Types::Bool[d["shortTimeLabels"]] : nil,
      tick_color:        d.key?("tickColor") ? Types::String[d["tickColor"]] : nil,
      tick_round:        d.key?("tickRound") ? Types::Bool[d["tickRound"]] : nil,
      ticks:             d.key?("ticks") ? Types::Bool[d["ticks"]] : nil,
      tick_size:         d.key?("tickSize") ? Types::Double.constrained(gteq: 0)[d["tickSize"]] : nil,
      tick_width:        d.key?("tickWidth") ? Types::Double.constrained(gteq: 0)[d["tickWidth"]] : nil,
      title_align:       d.key?("titleAlign") ? Types::String[d["titleAlign"]] : nil,
      title_angle:       d.key?("titleAngle") ? Types::Double[d["titleAngle"]] : nil,
      title_baseline:    d.key?("titleBaseline") ? Types::String[d["titleBaseline"]] : nil,
      title_color:       d.key?("titleColor") ? Types::String[d["titleColor"]] : nil,
      title_font:        d.key?("titleFont") ? Types::String[d["titleFont"]] : nil,
      title_font_size:   d.key?("titleFontSize") ? Types::Double.constrained(gteq: 0)[d["titleFontSize"]] : nil,
      title_font_weight: d.key?("titleFontWeight") ? TitleFontWeight.from_dynamic!(d["titleFontWeight"]) : nil,
      title_limit:       d.key?("titleLimit") ? Types::Double[d["titleLimit"]] : nil,
      title_max_length:  d.key?("titleMaxLength") ? Types::Double[d["titleMaxLength"]] : nil,
      title_padding:     d.key?("titlePadding") ? Types::Double[d["titlePadding"]] : nil,
      title_x:           d.key?("titleX") ? Types::Double[d["titleX"]] : nil,
      title_y:           d.key?("titleY") ? Types::Double[d["titleY"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bandPosition"    => band_position,
      "domain"          => domain,
      "domainColor"     => domain_color,
      "domainWidth"     => domain_width,
      "grid"            => grid,
      "gridColor"       => grid_color,
      "gridDash"        => grid_dash,
      "gridOpacity"     => grid_opacity,
      "gridWidth"       => grid_width,
      "labelAngle"      => label_angle,
      "labelBound"      => label_bound&.to_dynamic,
      "labelColor"      => label_color,
      "labelFlush"      => label_flush&.to_dynamic,
      "labelFont"       => label_font,
      "labelFontSize"   => label_font_size,
      "labelLimit"      => label_limit,
      "labelOverlap"    => label_overlap&.to_dynamic,
      "labelPadding"    => label_padding,
      "labels"          => labels,
      "maxExtent"       => max_extent,
      "minExtent"       => min_extent,
      "shortTimeLabels" => short_time_labels,
      "tickColor"       => tick_color,
      "tickRound"       => tick_round,
      "ticks"           => ticks,
      "tickSize"        => tick_size,
      "tickWidth"       => tick_width,
      "titleAlign"      => title_align,
      "titleAngle"      => title_angle,
      "titleBaseline"   => title_baseline,
      "titleColor"      => title_color,
      "titleFont"       => title_font,
      "titleFontSize"   => title_font_size,
      "titleFontWeight" => title_font_weight&.to_dynamic,
      "titleLimit"      => title_limit,
      "titleMaxLength"  => title_max_length,
      "titlePadding"    => title_padding,
      "titleX"          => title_x,
      "titleY"          => title_y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
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
class VGAxisConfig < Dry::Struct

  # An interpolation fraction indicating where, for `band` scales, axis ticks should be
  # positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
  # places ticks in the middle of their bands.
  attribute :band_position, Types::Double.optional

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  attribute :domain, Types::Bool.optional

  # Color of axis domain line.
  #
  # __Default value:__  (none, using Vega default).
  attribute :domain_color, Types::String.optional

  # Stroke width of axis domain line
  #
  # __Default value:__  (none, using Vega default).
  attribute :domain_width, Types::Double.optional

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  attribute :grid, Types::Bool.optional

  # Color of gridlines.
  attribute :grid_color, Types::String.optional

  # The offset (in pixels) into which to begin drawing with the grid dash array.
  attribute :grid_dash, Types.Array(Types::Double).optional

  # The stroke opacity of grid (value between [0,1])
  #
  # __Default value:__ (`1` by default)
  attribute :grid_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The grid width, in pixels.
  attribute :grid_width, Types::Double.constrained(gteq: 0).optional

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  attribute :label_angle, Types::Double.constrained(gteq: -360, lteq: 360).optional

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  attribute :label_bound, Types.Instance(Label).optional

  # The color of the tick label, can be in hex color code or regular color name.
  attribute :label_color, Types::String.optional

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  attribute :label_flush, Types.Instance(Label).optional

  # The font of the tick label.
  attribute :label_font, Types::String.optional

  # The font size of the label, in pixels.
  attribute :label_font_size, Types::Double.constrained(gteq: 0).optional

  # Maximum allowed pixel width of axis tick labels.
  attribute :label_limit, Types::Double.optional

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  attribute :label_overlap, Types.Instance(LabelOverlapUnion).optional

  # The padding, in pixels, between axis and text labels.
  attribute :label_padding, Types::Double.optional

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  attribute :labels, Types::Bool.optional

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  attribute :max_extent, Types::Double.optional

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  attribute :min_extent, Types::Double.optional

  # The color of the axis's tick.
  attribute :tick_color, Types::String.optional

  # Boolean flag indicating if pixel position values should be rounded to the nearest integer.
  attribute :tick_round, Types::Bool.optional

  # Boolean value that determines whether the axis should include ticks.
  attribute :ticks, Types::Bool.optional

  # The size in pixels of axis ticks.
  attribute :tick_size, Types::Double.constrained(gteq: 0).optional

  # The width, in pixels, of ticks.
  attribute :tick_width, Types::Double.constrained(gteq: 0).optional

  # Horizontal text alignment of axis titles.
  attribute :title_align, Types::String.optional

  # Angle in degrees of axis titles.
  attribute :title_angle, Types::Double.optional

  # Vertical text baseline for axis titles.
  attribute :title_baseline, Types::String.optional

  # Color of the title, can be in hex color code or regular color name.
  attribute :title_color, Types::String.optional

  # Font of the title. (e.g., `"Helvetica Neue"`).
  attribute :title_font, Types::String.optional

  # Font size of the title.
  attribute :title_font_size, Types::Double.constrained(gteq: 0).optional

  # Font weight of the title. (e.g., `"bold"`).
  attribute :title_font_weight, Types.Instance(TitleFontWeight).optional

  # Maximum allowed pixel width of axis titles.
  attribute :title_limit, Types::Double.optional

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  attribute :title_max_length, Types::Double.optional

  # The padding, in pixels, between title and axis.
  attribute :title_padding, Types::Double.optional

  # X-coordinate of the axis title relative to the axis group.
  attribute :title_x, Types::Double.optional

  # Y-coordinate of the axis title relative to the axis group.
  attribute :title_y, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      band_position:     d.key?("bandPosition") ? Types::Double[d["bandPosition"]] : nil,
      domain:            d.key?("domain") ? Types::Bool[d["domain"]] : nil,
      domain_color:      d.key?("domainColor") ? Types::String[d["domainColor"]] : nil,
      domain_width:      d.key?("domainWidth") ? Types::Double[d["domainWidth"]] : nil,
      grid:              d.key?("grid") ? Types::Bool[d["grid"]] : nil,
      grid_color:        d.key?("gridColor") ? Types::String[d["gridColor"]] : nil,
      grid_dash:         d.key?("gridDash") ? d["gridDash"].map { |x| Types::Double[x] } : nil,
      grid_opacity:      d.key?("gridOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["gridOpacity"]] : nil,
      grid_width:        d.key?("gridWidth") ? Types::Double.constrained(gteq: 0)[d["gridWidth"]] : nil,
      label_angle:       d.key?("labelAngle") ? Types::Double.constrained(gteq: -360, lteq: 360)[d["labelAngle"]] : nil,
      label_bound:       d.key?("labelBound") ? Label.from_dynamic!(d["labelBound"]) : nil,
      label_color:       d.key?("labelColor") ? Types::String[d["labelColor"]] : nil,
      label_flush:       d.key?("labelFlush") ? Label.from_dynamic!(d["labelFlush"]) : nil,
      label_font:        d.key?("labelFont") ? Types::String[d["labelFont"]] : nil,
      label_font_size:   d.key?("labelFontSize") ? Types::Double.constrained(gteq: 0)[d["labelFontSize"]] : nil,
      label_limit:       d.key?("labelLimit") ? Types::Double[d["labelLimit"]] : nil,
      label_overlap:     d.key?("labelOverlap") ? LabelOverlapUnion.from_dynamic!(d["labelOverlap"]) : nil,
      label_padding:     d.key?("labelPadding") ? Types::Double[d["labelPadding"]] : nil,
      labels:            d.key?("labels") ? Types::Bool[d["labels"]] : nil,
      max_extent:        d.key?("maxExtent") ? Types::Double[d["maxExtent"]] : nil,
      min_extent:        d.key?("minExtent") ? Types::Double[d["minExtent"]] : nil,
      tick_color:        d.key?("tickColor") ? Types::String[d["tickColor"]] : nil,
      tick_round:        d.key?("tickRound") ? Types::Bool[d["tickRound"]] : nil,
      ticks:             d.key?("ticks") ? Types::Bool[d["ticks"]] : nil,
      tick_size:         d.key?("tickSize") ? Types::Double.constrained(gteq: 0)[d["tickSize"]] : nil,
      tick_width:        d.key?("tickWidth") ? Types::Double.constrained(gteq: 0)[d["tickWidth"]] : nil,
      title_align:       d.key?("titleAlign") ? Types::String[d["titleAlign"]] : nil,
      title_angle:       d.key?("titleAngle") ? Types::Double[d["titleAngle"]] : nil,
      title_baseline:    d.key?("titleBaseline") ? Types::String[d["titleBaseline"]] : nil,
      title_color:       d.key?("titleColor") ? Types::String[d["titleColor"]] : nil,
      title_font:        d.key?("titleFont") ? Types::String[d["titleFont"]] : nil,
      title_font_size:   d.key?("titleFontSize") ? Types::Double.constrained(gteq: 0)[d["titleFontSize"]] : nil,
      title_font_weight: d.key?("titleFontWeight") ? TitleFontWeight.from_dynamic!(d["titleFontWeight"]) : nil,
      title_limit:       d.key?("titleLimit") ? Types::Double[d["titleLimit"]] : nil,
      title_max_length:  d.key?("titleMaxLength") ? Types::Double[d["titleMaxLength"]] : nil,
      title_padding:     d.key?("titlePadding") ? Types::Double[d["titlePadding"]] : nil,
      title_x:           d.key?("titleX") ? Types::Double[d["titleX"]] : nil,
      title_y:           d.key?("titleY") ? Types::Double[d["titleY"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bandPosition"    => band_position,
      "domain"          => domain,
      "domainColor"     => domain_color,
      "domainWidth"     => domain_width,
      "grid"            => grid,
      "gridColor"       => grid_color,
      "gridDash"        => grid_dash,
      "gridOpacity"     => grid_opacity,
      "gridWidth"       => grid_width,
      "labelAngle"      => label_angle,
      "labelBound"      => label_bound&.to_dynamic,
      "labelColor"      => label_color,
      "labelFlush"      => label_flush&.to_dynamic,
      "labelFont"       => label_font,
      "labelFontSize"   => label_font_size,
      "labelLimit"      => label_limit,
      "labelOverlap"    => label_overlap&.to_dynamic,
      "labelPadding"    => label_padding,
      "labels"          => labels,
      "maxExtent"       => max_extent,
      "minExtent"       => min_extent,
      "tickColor"       => tick_color,
      "tickRound"       => tick_round,
      "ticks"           => ticks,
      "tickSize"        => tick_size,
      "tickWidth"       => tick_width,
      "titleAlign"      => title_align,
      "titleAngle"      => title_angle,
      "titleBaseline"   => title_baseline,
      "titleColor"      => title_color,
      "titleFont"       => title_font,
      "titleFontSize"   => title_font_size,
      "titleFontWeight" => title_font_weight&.to_dynamic,
      "titleLimit"      => title_limit,
      "titleMaxLength"  => title_max_length,
      "titlePadding"    => title_padding,
      "titleX"          => title_x,
      "titleY"          => title_y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Bar-Specific Config
class BarConfig < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
  # statisticians) or 1 (Vega-Lite Default, D3 example style).
  #
  # __Default value:__ `1`
  attribute :bin_spacing, Types::Double.constrained(gteq: 0).optional

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :color, Types::String.optional

  # The default size of the bars on continuous scales.
  #
  # __Default value:__ `5`
  attribute :continuous_band_size, Types::Double.constrained(gteq: 0).optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The size of the bars.  If unspecified, the default size is  `bandSize-1`,
  # which provides 1 pixel offset between bars.
  attribute :discrete_band_size, Types::Double.constrained(gteq: 0).optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :filled, Types::Bool.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:                d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:                d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      baseline:             d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      bin_spacing:          d.key?("binSpacing") ? Types::Double.constrained(gteq: 0)[d["binSpacing"]] : nil,
      color:                d.key?("color") ? Types::String[d["color"]] : nil,
      continuous_band_size: d.key?("continuousBandSize") ? Types::Double.constrained(gteq: 0)[d["continuousBandSize"]] : nil,
      cursor:               d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      discrete_band_size:   d.key?("discreteBandSize") ? Types::Double.constrained(gteq: 0)[d["discreteBandSize"]] : nil,
      dx:                   d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                   d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:                 d.key?("fill") ? Types::String[d["fill"]] : nil,
      filled:               d.key?("filled") ? Types::Bool[d["filled"]] : nil,
      fill_opacity:         d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:                 d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:            d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:           d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:          d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:                 d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:          d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:                d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:              d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:               d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:               d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:                d.key?("shape") ? Types::String[d["shape"]] : nil,
      size:                 d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:               d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:          d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset:   d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:       d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:         d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      tension:              d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:                 d.key?("text") ? Types::String[d["text"]] : nil,
      theta:                d.key?("theta") ? Types::Double[d["theta"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"              => align,
      "angle"              => angle,
      "baseline"           => baseline,
      "binSpacing"         => bin_spacing,
      "color"              => color,
      "continuousBandSize" => continuous_band_size,
      "cursor"             => cursor,
      "discreteBandSize"   => discrete_band_size,
      "dx"                 => dx,
      "dy"                 => dy,
      "fill"               => fill,
      "filled"             => filled,
      "fillOpacity"        => fill_opacity,
      "font"               => font,
      "fontSize"           => font_size,
      "fontStyle"          => font_style,
      "fontWeight"         => font_weight&.to_dynamic,
      "href"               => href,
      "interpolate"        => interpolate,
      "limit"              => limit,
      "opacity"            => opacity,
      "orient"             => orient,
      "radius"             => radius,
      "shape"              => shape,
      "size"               => size,
      "stroke"             => stroke,
      "strokeDash"         => stroke_dash,
      "strokeDashOffset"   => stroke_dash_offset,
      "strokeOpacity"      => stroke_opacity,
      "strokeWidth"        => stroke_width,
      "tension"            => tension,
      "text"               => text,
      "theta"              => theta,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Defines how Vega-Lite generates title for fields.  There are three possible styles:
#
# - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
# "Year-month of date", "field (binned)").
# - `"function"` - displays function using parentheses and capitalized texts (e.g.,
# "SUM(field)", "YEARMONTH(date)", "BIN(field)").
# - `"plain"` - displays only the field name without functions (e.g., "field", "date",
# "field").
module FieldTitle
  Verbal     = "verbal"
  Functional = "functional"
  Plain      = "plain"
end

# Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
# - If set to `"filter"` (default), all data items with null values are filtered.
# - If `null`, all data items are included. In this case, invalid values will be
# interpreted as zeroes.
module InvalidValues
  Filter = "filter"
end

# The orientation of the legend, which determines how the legend is positioned within the
# scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
# "none".
#
# __Default value:__ `"right"`
module LegendOrient
  Left        = "left"
  Right       = "right"
  TopLeft     = "top-left"
  TopRight    = "top-right"
  BottomLeft  = "bottom-left"
  BottomRight = "bottom-right"
  None        = "none"
end

# Legend configuration, which determines default properties for all [legends](legend.html).
# For a full list of legend configuration options, please see the [corresponding section of
# in the legend documentation](legend.html#config).
class LegendConfig < Dry::Struct

  # Corner radius for the full legend.
  attribute :corner_radius, Types::Double.optional

  # Padding (in pixels) between legend entries in a symbol legend.
  attribute :entry_padding, Types::Double.optional

  # Background fill color for the full legend.
  attribute :fill_color, Types::String.optional

  # The height of the gradient, in pixels.
  attribute :gradient_height, Types::Double.constrained(gteq: 0).optional

  # Text baseline for color ramp gradient labels.
  attribute :gradient_label_baseline, Types::String.optional

  # The maximum allowed length in pixels of color ramp gradient labels.
  attribute :gradient_label_limit, Types::Double.optional

  # Vertical offset in pixels for color ramp gradient labels.
  attribute :gradient_label_offset, Types::Double.optional

  # The color of the gradient stroke, can be in hex color code or regular color name.
  attribute :gradient_stroke_color, Types::String.optional

  # The width of the gradient stroke, in pixels.
  attribute :gradient_stroke_width, Types::Double.constrained(gteq: 0).optional

  # The width of the gradient, in pixels.
  attribute :gradient_width, Types::Double.constrained(gteq: 0).optional

  # The alignment of the legend label, can be left, middle or right.
  attribute :label_align, Types::String.optional

  # The position of the baseline of legend label, can be top, middle or bottom.
  attribute :label_baseline, Types::String.optional

  # The color of the legend label, can be in hex color code or regular color name.
  attribute :label_color, Types::String.optional

  # The font of the legend label.
  attribute :label_font, Types::String.optional

  # The font size of legend label.
  #
  # __Default value:__ `10`.
  attribute :label_font_size, Types::Double.constrained(gteq: 0).optional

  # Maximum allowed pixel width of axis tick labels.
  attribute :label_limit, Types::Double.optional

  # The offset of the legend label.
  attribute :label_offset, Types::Double.constrained(gteq: 0).optional

  # The offset, in pixels, by which to displace the legend from the edge of the enclosing
  # group or data rectangle.
  #
  # __Default value:__  `0`
  attribute :offset, Types::Double.optional

  # The orientation of the legend, which determines how the legend is positioned within the
  # scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
  # "none".
  #
  # __Default value:__ `"right"`
  attribute :orient, Types::LegendOrient.optional

  # The padding, in pixels, between the legend and axis.
  attribute :padding, Types::Double.optional

  # Whether month names and weekday names should be abbreviated.
  #
  # __Default value:__  `false`
  attribute :short_time_labels, Types::Bool.optional

  # Border stroke color for the full legend.
  attribute :stroke_color, Types::String.optional

  # Border stroke dash pattern for the full legend.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # Border stroke width for the full legend.
  attribute :stroke_width, Types::Double.optional

  # The color of the legend symbol,
  attribute :symbol_color, Types::String.optional

  # The size of the legend symbol, in pixels.
  attribute :symbol_size, Types::Double.constrained(gteq: 0).optional

  # The width of the symbol's stroke.
  attribute :symbol_stroke_width, Types::Double.constrained(gteq: 0).optional

  # Default shape type (such as "circle") for legend symbols.
  attribute :symbol_type, Types::String.optional

  # Horizontal text alignment for legend titles.
  attribute :title_align, Types::String.optional

  # Vertical text baseline for legend titles.
  attribute :title_baseline, Types::String.optional

  # The color of the legend title, can be in hex color code or regular color name.
  attribute :title_color, Types::String.optional

  # The font of the legend title.
  attribute :title_font, Types::String.optional

  # The font size of the legend title.
  attribute :title_font_size, Types::Double.optional

  # The font weight of the legend title.
  attribute :title_font_weight, Types.Instance(TitleFontWeight).optional

  # Maximum allowed pixel width of axis titles.
  attribute :title_limit, Types::Double.optional

  # The padding, in pixels, between title and legend.
  attribute :title_padding, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      corner_radius:           d.key?("cornerRadius") ? Types::Double[d["cornerRadius"]] : nil,
      entry_padding:           d.key?("entryPadding") ? Types::Double[d["entryPadding"]] : nil,
      fill_color:              d.key?("fillColor") ? Types::String[d["fillColor"]] : nil,
      gradient_height:         d.key?("gradientHeight") ? Types::Double.constrained(gteq: 0)[d["gradientHeight"]] : nil,
      gradient_label_baseline: d.key?("gradientLabelBaseline") ? Types::String[d["gradientLabelBaseline"]] : nil,
      gradient_label_limit:    d.key?("gradientLabelLimit") ? Types::Double[d["gradientLabelLimit"]] : nil,
      gradient_label_offset:   d.key?("gradientLabelOffset") ? Types::Double[d["gradientLabelOffset"]] : nil,
      gradient_stroke_color:   d.key?("gradientStrokeColor") ? Types::String[d["gradientStrokeColor"]] : nil,
      gradient_stroke_width:   d.key?("gradientStrokeWidth") ? Types::Double.constrained(gteq: 0)[d["gradientStrokeWidth"]] : nil,
      gradient_width:          d.key?("gradientWidth") ? Types::Double.constrained(gteq: 0)[d["gradientWidth"]] : nil,
      label_align:             d.key?("labelAlign") ? Types::String[d["labelAlign"]] : nil,
      label_baseline:          d.key?("labelBaseline") ? Types::String[d["labelBaseline"]] : nil,
      label_color:             d.key?("labelColor") ? Types::String[d["labelColor"]] : nil,
      label_font:              d.key?("labelFont") ? Types::String[d["labelFont"]] : nil,
      label_font_size:         d.key?("labelFontSize") ? Types::Double.constrained(gteq: 0)[d["labelFontSize"]] : nil,
      label_limit:             d.key?("labelLimit") ? Types::Double[d["labelLimit"]] : nil,
      label_offset:            d.key?("labelOffset") ? Types::Double.constrained(gteq: 0)[d["labelOffset"]] : nil,
      offset:                  d.key?("offset") ? Types::Double[d["offset"]] : nil,
      orient:                  d.key?("orient") ? Types::LegendOrient[d["orient"]] : nil,
      padding:                 d.key?("padding") ? Types::Double[d["padding"]] : nil,
      short_time_labels:       d.key?("shortTimeLabels") ? Types::Bool[d["shortTimeLabels"]] : nil,
      stroke_color:            d.key?("strokeColor") ? Types::String[d["strokeColor"]] : nil,
      stroke_dash:             d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_width:            d.key?("strokeWidth") ? Types::Double[d["strokeWidth"]] : nil,
      symbol_color:            d.key?("symbolColor") ? Types::String[d["symbolColor"]] : nil,
      symbol_size:             d.key?("symbolSize") ? Types::Double.constrained(gteq: 0)[d["symbolSize"]] : nil,
      symbol_stroke_width:     d.key?("symbolStrokeWidth") ? Types::Double.constrained(gteq: 0)[d["symbolStrokeWidth"]] : nil,
      symbol_type:             d.key?("symbolType") ? Types::String[d["symbolType"]] : nil,
      title_align:             d.key?("titleAlign") ? Types::String[d["titleAlign"]] : nil,
      title_baseline:          d.key?("titleBaseline") ? Types::String[d["titleBaseline"]] : nil,
      title_color:             d.key?("titleColor") ? Types::String[d["titleColor"]] : nil,
      title_font:              d.key?("titleFont") ? Types::String[d["titleFont"]] : nil,
      title_font_size:         d.key?("titleFontSize") ? Types::Double[d["titleFontSize"]] : nil,
      title_font_weight:       d.key?("titleFontWeight") ? TitleFontWeight.from_dynamic!(d["titleFontWeight"]) : nil,
      title_limit:             d.key?("titleLimit") ? Types::Double[d["titleLimit"]] : nil,
      title_padding:           d.key?("titlePadding") ? Types::Double[d["titlePadding"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "cornerRadius"          => corner_radius,
      "entryPadding"          => entry_padding,
      "fillColor"             => fill_color,
      "gradientHeight"        => gradient_height,
      "gradientLabelBaseline" => gradient_label_baseline,
      "gradientLabelLimit"    => gradient_label_limit,
      "gradientLabelOffset"   => gradient_label_offset,
      "gradientStrokeColor"   => gradient_stroke_color,
      "gradientStrokeWidth"   => gradient_stroke_width,
      "gradientWidth"         => gradient_width,
      "labelAlign"            => label_align,
      "labelBaseline"         => label_baseline,
      "labelColor"            => label_color,
      "labelFont"             => label_font,
      "labelFontSize"         => label_font_size,
      "labelLimit"            => label_limit,
      "labelOffset"           => label_offset,
      "offset"                => offset,
      "orient"                => orient,
      "padding"               => padding,
      "shortTimeLabels"       => short_time_labels,
      "strokeColor"           => stroke_color,
      "strokeDash"            => stroke_dash,
      "strokeWidth"           => stroke_width,
      "symbolColor"           => symbol_color,
      "symbolSize"            => symbol_size,
      "symbolStrokeWidth"     => symbol_stroke_width,
      "symbolType"            => symbol_type,
      "titleAlign"            => title_align,
      "titleBaseline"         => title_baseline,
      "titleColor"            => title_color,
      "titleFont"             => title_font,
      "titleFontSize"         => title_font_size,
      "titleFontWeight"       => title_font_weight&.to_dynamic,
      "titleLimit"            => title_limit,
      "titlePadding"          => title_padding,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PaddingClass < Dry::Struct
  attribute :bottom, Types::Double.optional
  attribute :left,   Types::Double.optional
  attribute :right,  Types::Double.optional
  attribute :top,    Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bottom: d.key?("bottom") ? Types::Double[d["bottom"]] : nil,
      left:   d.key?("left") ? Types::Double[d["left"]] : nil,
      right:  d.key?("right") ? Types::Double[d["right"]] : nil,
      top:    d.key?("top") ? Types::Double[d["top"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bottom" => bottom,
      "left"   => left,
      "right"  => right,
      "top"    => top,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The default visualization padding, in pixels, from the edge of the visualization canvas
# to the data rectangle.  If a number, specifies padding for all sides.
# If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
# "bottom": 5}` to specify padding for each side of the visualization.
#
# __Default value__: `5`
class Padding < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :padding_class, PaddingClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, padding_class: nil)
    end
    begin
      value = PaddingClass.from_dynamic!(d)
      if schema.key(:padding_class).type.right.valid? value
        return new(padding_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif padding_class != nil
      padding_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The cartographic projection to use. This value is case-insensitive, for example
# `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
# projection types [in the
# documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
#
# __Default value:__ `mercator`
module VGProjectionType
  Albers               = "albers"
  AlbersUsa            = "albersUsa"
  AzimuthalEqualArea   = "azimuthalEqualArea"
  AzimuthalEquidistant = "azimuthalEquidistant"
  ConicConformal       = "conicConformal"
  ConicEqualArea       = "conicEqualArea"
  ConicEquidistant     = "conicEquidistant"
  Equirectangular      = "equirectangular"
  Gnomonic             = "gnomonic"
  Mercator             = "mercator"
  Orthographic         = "orthographic"
  Stereographic        = "stereographic"
  TransverseMercator   = "transverseMercator"
end

# Projection configuration, which determines default properties for all
# [projections](projection.html). For a full list of projection configuration options,
# please see the [corresponding section of the projection
# documentation](projection.html#config).
#
# Any property of Projection can be in config
class ProjectionConfig < Dry::Struct

  # Sets the projection’s center to the specified center, a two-element array of longitude
  # and latitude in degrees.
  #
  # __Default value:__ `[0, 0]`
  attribute :center, Types.Array(Types::Double).optional

  # Sets the projection’s clipping circle radius to the specified angle in degrees. If
  # `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
  # than small-circle clipping.
  attribute :clip_angle, Types::Double.optional

  # Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
  # bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
  # the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
  # viewport clipping is performed.
  attribute :clip_extent, Types.Array(Types.Array(Types::Double)).optional

  attribute :coefficient, Types::Double.optional
  attribute :distance,    Types::Double.optional
  attribute :fraction,    Types::Double.optional
  attribute :lobes,       Types::Double.optional
  attribute :parallel,    Types::Double.optional

  # Sets the threshold for the projection’s [adaptive
  # resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
  # value corresponds to the [Douglas–Peucker
  # distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
  # If precision is not specified, returns the projection’s current resampling precision
  # which defaults to `√0.5 ≅ 0.70710…`.
  attribute :precision, Types::Hash.meta(of: Types.Instance(TitleFontWeight)).optional

  attribute :radius, Types::Double.optional
  attribute :ratio,  Types::Double.optional

  # Sets the projection’s three-axis rotation to the specified angles, which must be a two-
  # or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
  # angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
  #
  # __Default value:__ `[0, 0, 0]`
  attribute :rotate, Types.Array(Types::Double).optional

  attribute :spacing, Types::Double.optional
  attribute :tilt,    Types::Double.optional

  # The cartographic projection to use. This value is case-insensitive, for example
  # `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
  # projection types [in the
  # documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
  #
  # __Default value:__ `mercator`
  attribute :projection_config_type, Types::VGProjectionType.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      center:                 d.key?("center") ? d["center"].map { |x| Types::Double[x] } : nil,
      clip_angle:             d.key?("clipAngle") ? Types::Double[d["clipAngle"]] : nil,
      clip_extent:            d.key?("clipExtent") ? d["clipExtent"].map { |x| x.map { |x| Types::Double[x] } } : nil,
      coefficient:            d.key?("coefficient") ? Types::Double[d["coefficient"]] : nil,
      distance:               d.key?("distance") ? Types::Double[d["distance"]] : nil,
      fraction:               d.key?("fraction") ? Types::Double[d["fraction"]] : nil,
      lobes:                  d.key?("lobes") ? Types::Double[d["lobes"]] : nil,
      parallel:               d.key?("parallel") ? Types::Double[d["parallel"]] : nil,
      precision:              d.key?("precision") ? Types::Hash[d["precision"]].map { |k, v| [k, TitleFontWeight.from_dynamic!(v)] }.to_h : nil,
      radius:                 d.key?("radius") ? Types::Double[d["radius"]] : nil,
      ratio:                  d.key?("ratio") ? Types::Double[d["ratio"]] : nil,
      rotate:                 d.key?("rotate") ? d["rotate"].map { |x| Types::Double[x] } : nil,
      spacing:                d.key?("spacing") ? Types::Double[d["spacing"]] : nil,
      tilt:                   d.key?("tilt") ? Types::Double[d["tilt"]] : nil,
      projection_config_type: d.key?("type") ? Types::VGProjectionType[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "center"      => center,
      "clipAngle"   => clip_angle,
      "clipExtent"  => clip_extent,
      "coefficient" => coefficient,
      "distance"    => distance,
      "fraction"    => fraction,
      "lobes"       => lobes,
      "parallel"    => parallel,
      "precision"   => precision&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "radius"      => radius,
      "ratio"       => ratio,
      "rotate"      => rotate,
      "spacing"     => spacing,
      "tilt"        => tilt,
      "type"        => projection_config_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class VGScheme < Dry::Struct
  attribute :count,  Types::Double.optional
  attribute :extent, Types.Array(Types::Double).optional
  attribute :scheme, Types::String.optional
  attribute :step,   Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:  d.key?("count") ? Types::Double[d["count"]] : nil,
      extent: d.key?("extent") ? d["extent"].map { |x| Types::Double[x] } : nil,
      scheme: d.key?("scheme") ? Types::String[d["scheme"]] : nil,
      step:   d.key?("step") ? Types::Double[d["step"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"  => count,
      "extent" => extent,
      "scheme" => scheme,
      "step"   => step,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RangeConfigValue < Dry::Struct
  attribute :union_array, Types.Array(Types.Instance(TitleFontWeight)).optional
  attribute :vg_scheme,   VGScheme.optional

  def self.from_dynamic!(d)
    begin
      value = d.map { |x| TitleFontWeight.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, vg_scheme: nil)
      end
    rescue
    end
    begin
      value = VGScheme.from_dynamic!(d)
      if schema.key(:vg_scheme).type.right.valid? value
        return new(vg_scheme: value, union_array: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if union_array != nil
      union_array.map { |x| x.to_dynamic }
    elsif vg_scheme != nil
      vg_scheme.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Scale configuration determines default properties for all [scales](scale.html). For a
# full list of scale configuration options, please see the [corresponding section of the
# scale documentation](scale.html#config).
class ScaleConfig < Dry::Struct

  # Default inner padding for `x` and `y` band-ordinal scales.
  #
  # __Default value:__ `0.1`
  attribute :band_padding_inner, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Default outer padding for `x` and `y` band-ordinal scales.
  # If not specified, by default, band scale's paddingOuter is paddingInner/2.
  attribute :band_padding_outer, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # If true, values that exceed the data domain are clamped to either the minimum or maximum
  # range value
  attribute :clamp, Types::Bool.optional

  # Default padding for continuous scales.
  #
  # __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
  # horizontal bar.; `0` otherwise.
  attribute :continuous_padding, Types::Double.constrained(gteq: 0).optional

  # The default max value for mapping quantitative fields to bar's size/bandSize.
  #
  # If undefined (default), we will use the scale's `rangeStep` - 1.
  attribute :max_band_size, Types::Double.constrained(gteq: 0).optional

  # The default max value for mapping quantitative fields to text's size/fontSize.
  #
  # __Default value:__ `40`
  attribute :max_font_size, Types::Double.constrained(gteq: 0).optional

  # Default max opacity for mapping a field to opacity.
  #
  # __Default value:__ `0.8`
  attribute :max_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Default max value for point size scale.
  attribute :max_size, Types::Double.constrained(gteq: 0).optional

  # Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
  #
  # __Default value:__ `4`
  attribute :max_stroke_width, Types::Double.constrained(gteq: 0).optional

  # The default min value for mapping quantitative fields to bar and tick's size/bandSize
  # scale with zero=false.
  #
  # __Default value:__ `2`
  attribute :min_band_size, Types::Double.constrained(gteq: 0).optional

  # The default min value for mapping quantitative fields to tick's size/fontSize scale with
  # zero=false
  #
  # __Default value:__ `8`
  attribute :min_font_size, Types::Double.constrained(gteq: 0).optional

  # Default minimum opacity for mapping a field to opacity.
  #
  # __Default value:__ `0.3`
  attribute :min_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Default minimum value for point size scale with zero=false.
  #
  # __Default value:__ `9`
  attribute :min_size, Types::Double.constrained(gteq: 0).optional

  # Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
  #
  # __Default value:__ `1`
  attribute :min_stroke_width, Types::Double.constrained(gteq: 0).optional

  # Default outer padding for `x` and `y` point-ordinal scales.
  #
  # __Default value:__ `0.5`
  attribute :point_padding, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Default range step for band and point scales of (1) the `y` channel
  # and (2) the `x` channel when the mark is not `text`.
  #
  # __Default value:__ `21`
  attribute :range_step, Types::Double.constrained(gteq: 0).optional.optional

  # If true, rounds numeric output values to integers.
  # This can be helpful for snapping to the pixel grid.
  # (Only available for `x`, `y`, and `size` scales.)
  attribute :round, Types::Bool.optional

  # Default range step for `x` band and point scales of text marks.
  #
  # __Default value:__ `90`
  attribute :text_x_range_step, Types::Double.constrained(gteq: 0).optional

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
  attribute :use_unaggregated_domain, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      band_padding_inner:      d.key?("bandPaddingInner") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["bandPaddingInner"]] : nil,
      band_padding_outer:      d.key?("bandPaddingOuter") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["bandPaddingOuter"]] : nil,
      clamp:                   d.key?("clamp") ? Types::Bool[d["clamp"]] : nil,
      continuous_padding:      d.key?("continuousPadding") ? Types::Double.constrained(gteq: 0)[d["continuousPadding"]] : nil,
      max_band_size:           d.key?("maxBandSize") ? Types::Double.constrained(gteq: 0)[d["maxBandSize"]] : nil,
      max_font_size:           d.key?("maxFontSize") ? Types::Double.constrained(gteq: 0)[d["maxFontSize"]] : nil,
      max_opacity:             d.key?("maxOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["maxOpacity"]] : nil,
      max_size:                d.key?("maxSize") ? Types::Double.constrained(gteq: 0)[d["maxSize"]] : nil,
      max_stroke_width:        d.key?("maxStrokeWidth") ? Types::Double.constrained(gteq: 0)[d["maxStrokeWidth"]] : nil,
      min_band_size:           d.key?("minBandSize") ? Types::Double.constrained(gteq: 0)[d["minBandSize"]] : nil,
      min_font_size:           d.key?("minFontSize") ? Types::Double.constrained(gteq: 0)[d["minFontSize"]] : nil,
      min_opacity:             d.key?("minOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["minOpacity"]] : nil,
      min_size:                d.key?("minSize") ? Types::Double.constrained(gteq: 0)[d["minSize"]] : nil,
      min_stroke_width:        d.key?("minStrokeWidth") ? Types::Double.constrained(gteq: 0)[d["minStrokeWidth"]] : nil,
      point_padding:           d.key?("pointPadding") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["pointPadding"]] : nil,
      range_step:              d["rangeStep"],
      round:                   d.key?("round") ? Types::Bool[d["round"]] : nil,
      text_x_range_step:       d.key?("textXRangeStep") ? Types::Double.constrained(gteq: 0)[d["textXRangeStep"]] : nil,
      use_unaggregated_domain: d.key?("useUnaggregatedDomain") ? Types::Bool[d["useUnaggregatedDomain"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bandPaddingInner"      => band_padding_inner,
      "bandPaddingOuter"      => band_padding_outer,
      "clamp"                 => clamp,
      "continuousPadding"     => continuous_padding,
      "maxBandSize"           => max_band_size,
      "maxFontSize"           => max_font_size,
      "maxOpacity"            => max_opacity,
      "maxSize"               => max_size,
      "maxStrokeWidth"        => max_stroke_width,
      "minBandSize"           => min_band_size,
      "minFontSize"           => min_font_size,
      "minOpacity"            => min_opacity,
      "minSize"               => min_size,
      "minStrokeWidth"        => min_stroke_width,
      "pointPadding"          => point_padding,
      "rangeStep"             => range_step,
      "round"                 => round,
      "textXRangeStep"        => text_x_range_step,
      "useUnaggregatedDomain" => use_unaggregated_domain,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Establishes a two-way binding between the interval selection and the scales
# used within the same view. This allows a user to interactively pan and
# zoom the view.
module BindEnum
  Scales = "scales"
end

# By default, all data values are considered to lie within an empty selection.
# When set to `none`, empty selections contain no data values.
module Empty
  All  = "all"
  None = "none"
end

module SingleDefChannel
  X       = "x"
  Y       = "y"
  X2      = "x2"
  Y2      = "y2"
  Row     = "row"
  Column  = "column"
  Size    = "size"
  Shape   = "shape"
  Color   = "color"
  Opacity = "opacity"
  Text    = "text"
  Tooltip = "tooltip"
  Href    = "href"
end

# An interval selection also adds a rectangle mark to depict the
# extents of the interval. The `mark` property can be used to customize the
# appearance of the mark.
class BrushConfig < Dry::Struct

  # The fill color of the interval mark.
  #
  # __Default value:__ `#333333`
  attribute :fill, Types::String.optional

  # The fill opacity of the interval mark (a value between 0 and 1).
  #
  # __Default value:__ `0.125`
  attribute :fill_opacity, Types::Double.optional

  # The stroke color of the interval mark.
  #
  # __Default value:__ `#ffffff`
  attribute :stroke, Types::String.optional

  # An array of alternating stroke and space lengths,
  # for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) with which to begin drawing the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity of the interval mark (a value between 0 and 1).
  attribute :stroke_opacity, Types::Double.optional

  # The stroke width of the interval mark.
  attribute :stroke_width, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double[d["fillOpacity"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double[d["strokeWidth"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fill"             => fill,
      "fillOpacity"      => fill_opacity,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# With layered and multi-view displays, a strategy that determines how
# selections' data queries are resolved when applied in a filter transform,
# conditional encoding rule, or scale domain.
module SelectionResolution
  Global    = "global"
  Union     = "union"
  Intersect = "intersect"
end

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
class Translate < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The default definition for an [`interval`](selection.html#type) selection. All properties
# and transformations
# for an interval selection definition (except `type`) may be specified here.
#
# For instance, setting `interval` to `{"translate": false}` disables the ability to move
# interval selections by default.
class IntervalSelectionConfig < Dry::Struct

  # Establishes a two-way binding between the interval selection and the scales
  # used within the same view. This allows a user to interactively pan and
  # zoom the view.
  attribute :bind, Types::BindEnum.optional

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  attribute :empty, Types::Empty.optional

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  attribute :encodings, Types.Array(Types::SingleDefChannel).optional

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  attribute :fields, Types.Array(Types::String).optional

  # An interval selection also adds a rectangle mark to depict the
  # extents of the interval. The `mark` property can be used to customize the
  # appearance of the mark.
  attribute :mark, BrushConfig.optional

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  attribute :on, Types::Any.optional

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  attribute :resolve, Types::SelectionResolution.optional

  # When truthy, allows a user to interactively move an interval selection
  # back-and-forth. Can be `true`, `false` (to disable panning), or a
  # [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
  # which must include a start and end event to trigger continuous panning.
  #
  # __Default value:__ `true`, which corresponds to
  # `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
  # clicks and dragging within an interval selection to reposition it.
  attribute :translate, Types.Instance(Translate).optional

  # When truthy, allows a user to interactively resize an interval selection.
  # Can be `true`, `false` (to disable zooming), or a [Vega event stream
  # definition](https://vega.github.io/vega/docs/event-streams/). Currently,
  # only `wheel` events are supported.
  #
  #
  # __Default value:__ `true`, which corresponds to `wheel!`.
  attribute :zoom, Types.Instance(Translate).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bind:      d.key?("bind") ? Types::BindEnum[d["bind"]] : nil,
      empty:     d.key?("empty") ? Types::Empty[d["empty"]] : nil,
      encodings: d.key?("encodings") ? d["encodings"].map { |x| Types::SingleDefChannel[x] } : nil,
      fields:    d.key?("fields") ? d["fields"].map { |x| Types::String[x] } : nil,
      mark:      d.key?("mark") ? BrushConfig.from_dynamic!(d["mark"]) : nil,
      on:        d["on"],
      resolve:   d.key?("resolve") ? Types::SelectionResolution[d["resolve"]] : nil,
      translate: d.key?("translate") ? Translate.from_dynamic!(d["translate"]) : nil,
      zoom:      d.key?("zoom") ? Translate.from_dynamic!(d["zoom"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bind"      => bind,
      "empty"     => empty,
      "encodings" => encodings,
      "fields"    => fields,
      "mark"      => mark&.to_dynamic,
      "on"        => on,
      "resolve"   => resolve,
      "translate" => translate&.to_dynamic,
      "zoom"      => zoom&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The default definition for a [`multi`](selection.html#type) selection. All properties and
# transformations
# for a multi selection definition (except `type`) may be specified here.
#
# For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
# multi selections when clicking with the alt-key pressed by default.
class MultiSelectionConfig < Dry::Struct

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  attribute :empty, Types::Empty.optional

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  attribute :encodings, Types.Array(Types::SingleDefChannel).optional

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  attribute :fields, Types.Array(Types::String).optional

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  attribute :nearest, Types::Bool.optional

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  attribute :on, Types::Any.optional

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  attribute :resolve, Types::SelectionResolution.optional

  # Controls whether data values should be toggled or only ever inserted into
  # multi selections. Can be `true`, `false` (for insertion only), or a
  # [Vega expression](https://vega.github.io/vega/docs/expressions/).
  #
  # __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
  # data values are toggled when a user interacts with the shift-key pressed).
  #
  # See the [toggle transform](toggle.html) documentation for more information.
  attribute :toggle, Types.Instance(Translate).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      empty:     d.key?("empty") ? Types::Empty[d["empty"]] : nil,
      encodings: d.key?("encodings") ? d["encodings"].map { |x| Types::SingleDefChannel[x] } : nil,
      fields:    d.key?("fields") ? d["fields"].map { |x| Types::String[x] } : nil,
      nearest:   d.key?("nearest") ? Types::Bool[d["nearest"]] : nil,
      on:        d["on"],
      resolve:   d.key?("resolve") ? Types::SelectionResolution[d["resolve"]] : nil,
      toggle:    d.key?("toggle") ? Translate.from_dynamic!(d["toggle"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "empty"     => empty,
      "encodings" => encodings,
      "fields"    => fields,
      "nearest"   => nearest,
      "on"        => on,
      "resolve"   => resolve,
      "toggle"    => toggle&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class VGBinding < Dry::Struct
  attribute :element,            Types::String.optional
  attribute :input,              Types::String
  attribute :vg_binding_options, Types.Array(Types::String).optional
  attribute :max,                Types::Double.optional
  attribute :min,                Types::Double.optional
  attribute :step,               Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      element:            d.key?("element") ? Types::String[d["element"]] : nil,
      input:              d.fetch("input"),
      vg_binding_options: d.key?("options") ? d["options"].map { |x| Types::String[x] } : nil,
      max:                d.key?("max") ? Types::Double[d["max"]] : nil,
      min:                d.key?("min") ? Types::Double[d["min"]] : nil,
      step:               d.key?("step") ? Types::Double[d["step"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "element" => element,
      "input"   => input,
      "options" => vg_binding_options,
      "max"     => max,
      "min"     => min,
      "step"    => step,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The default definition for a [`single`](selection.html#type) selection. All properties
# and transformations
# for a single selection definition (except `type`) may be specified here.
#
# For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
# double-click by default.
class SingleSelectionConfig < Dry::Struct

  # Establish a two-way binding between a single selection and input elements
  # (also known as dynamic query widgets). A binding takes the form of
  # Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
  # or can be a mapping between projected field/encodings and binding definitions.
  #
  # See the [bind transform](bind.html) documentation for more information.
  attribute :bind, Types::Hash.meta(of: VGBinding).optional

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  attribute :empty, Types::Empty.optional

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  attribute :encodings, Types.Array(Types::SingleDefChannel).optional

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  attribute :fields, Types.Array(Types::String).optional

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  attribute :nearest, Types::Bool.optional

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  attribute :on, Types::Any.optional

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  attribute :resolve, Types::SelectionResolution.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bind:      d.key?("bind") ? Types::Hash[d["bind"]].map { |k, v| [k, VGBinding.from_dynamic!(v)] }.to_h : nil,
      empty:     d.key?("empty") ? Types::Empty[d["empty"]] : nil,
      encodings: d.key?("encodings") ? d["encodings"].map { |x| Types::SingleDefChannel[x] } : nil,
      fields:    d.key?("fields") ? d["fields"].map { |x| Types::String[x] } : nil,
      nearest:   d.key?("nearest") ? Types::Bool[d["nearest"]] : nil,
      on:        d["on"],
      resolve:   d.key?("resolve") ? Types::SelectionResolution[d["resolve"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bind"      => bind&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "empty"     => empty,
      "encodings" => encodings,
      "fields"    => fields,
      "nearest"   => nearest,
      "on"        => on,
      "resolve"   => resolve,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object hash for defining default properties for each type of selections.
class SelectionConfig < Dry::Struct

  # The default definition for an [`interval`](selection.html#type) selection. All properties
  # and transformations
  # for an interval selection definition (except `type`) may be specified here.
  #
  # For instance, setting `interval` to `{"translate": false}` disables the ability to move
  # interval selections by default.
  attribute :interval, IntervalSelectionConfig.optional

  # The default definition for a [`multi`](selection.html#type) selection. All properties and
  # transformations
  # for a multi selection definition (except `type`) may be specified here.
  #
  # For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
  # multi selections when clicking with the alt-key pressed by default.
  attribute :multi, MultiSelectionConfig.optional

  # The default definition for a [`single`](selection.html#type) selection. All properties
  # and transformations
  # for a single selection definition (except `type`) may be specified here.
  #
  # For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
  # double-click by default.
  attribute :single, SingleSelectionConfig.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      interval: d.key?("interval") ? IntervalSelectionConfig.from_dynamic!(d["interval"]) : nil,
      multi:    d.key?("multi") ? MultiSelectionConfig.from_dynamic!(d["multi"]) : nil,
      single:   d.key?("single") ? SingleSelectionConfig.from_dynamic!(d["single"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "interval" => interval&.to_dynamic,
      "multi"    => multi&.to_dynamic,
      "single"   => single&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Default stack offset for stackable mark.
module StackOffset
  Zero      = "zero"
  Center    = "center"
  Normalize = "normalize"
end

class VGMarkConfig < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:              d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:              d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      baseline:           d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      cursor:             d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      dx:                 d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                 d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:               d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:          d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:         d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:        d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:               d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:        d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:              d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:            d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:             d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:             d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:              d.key?("shape") ? Types::String[d["shape"]] : nil,
      size:               d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      tension:            d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:               d.key?("text") ? Types::String[d["text"]] : nil,
      theta:              d.key?("theta") ? Types::Double[d["theta"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"            => align,
      "angle"            => angle,
      "baseline"         => baseline,
      "cursor"           => cursor,
      "dx"               => dx,
      "dy"               => dy,
      "fill"             => fill,
      "fillOpacity"      => fill_opacity,
      "font"             => font,
      "fontSize"         => font_size,
      "fontStyle"        => font_style,
      "fontWeight"       => font_weight&.to_dynamic,
      "href"             => href,
      "interpolate"      => interpolate,
      "limit"            => limit,
      "opacity"          => opacity,
      "orient"           => orient,
      "radius"           => radius,
      "shape"            => shape,
      "size"             => size,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "tension"          => tension,
      "text"             => text,
      "theta"            => theta,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Text-Specific Config
class TextConfig < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :color, Types::String.optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :filled, Types::Bool.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # Whether month names and weekday names should be abbreviated.
  attribute :short_time_labels, Types::Bool.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:              d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:              d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      baseline:           d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      color:              d.key?("color") ? Types::String[d["color"]] : nil,
      cursor:             d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      dx:                 d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                 d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      filled:             d.key?("filled") ? Types::Bool[d["filled"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:               d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:          d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:         d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:        d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:               d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:        d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:              d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:            d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:             d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:             d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:              d.key?("shape") ? Types::String[d["shape"]] : nil,
      short_time_labels:  d.key?("shortTimeLabels") ? Types::Bool[d["shortTimeLabels"]] : nil,
      size:               d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      tension:            d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:               d.key?("text") ? Types::String[d["text"]] : nil,
      theta:              d.key?("theta") ? Types::Double[d["theta"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"            => align,
      "angle"            => angle,
      "baseline"         => baseline,
      "color"            => color,
      "cursor"           => cursor,
      "dx"               => dx,
      "dy"               => dy,
      "fill"             => fill,
      "filled"           => filled,
      "fillOpacity"      => fill_opacity,
      "font"             => font,
      "fontSize"         => font_size,
      "fontStyle"        => font_style,
      "fontWeight"       => font_weight&.to_dynamic,
      "href"             => href,
      "interpolate"      => interpolate,
      "limit"            => limit,
      "opacity"          => opacity,
      "orient"           => orient,
      "radius"           => radius,
      "shape"            => shape,
      "shortTimeLabels"  => short_time_labels,
      "size"             => size,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "tension"          => tension,
      "text"             => text,
      "theta"            => theta,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Tick-Specific Config
class TickConfig < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The width of the ticks.
  #
  # __Default value:__  2/3 of rangeStep.
  attribute :band_size, Types::Double.constrained(gteq: 0).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :color, Types::String.optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :filled, Types::Bool.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  # Thickness of the tick mark.
  #
  # __Default value:__  `1`
  attribute :thickness, Types::Double.constrained(gteq: 0).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:              d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:              d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      band_size:          d.key?("bandSize") ? Types::Double.constrained(gteq: 0)[d["bandSize"]] : nil,
      baseline:           d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      color:              d.key?("color") ? Types::String[d["color"]] : nil,
      cursor:             d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      dx:                 d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                 d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      filled:             d.key?("filled") ? Types::Bool[d["filled"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:               d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:          d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:         d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:        d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:               d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:        d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:              d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:            d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:             d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:             d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:              d.key?("shape") ? Types::String[d["shape"]] : nil,
      size:               d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      tension:            d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:               d.key?("text") ? Types::String[d["text"]] : nil,
      theta:              d.key?("theta") ? Types::Double[d["theta"]] : nil,
      thickness:          d.key?("thickness") ? Types::Double.constrained(gteq: 0)[d["thickness"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"            => align,
      "angle"            => angle,
      "bandSize"         => band_size,
      "baseline"         => baseline,
      "color"            => color,
      "cursor"           => cursor,
      "dx"               => dx,
      "dy"               => dy,
      "fill"             => fill,
      "filled"           => filled,
      "fillOpacity"      => fill_opacity,
      "font"             => font,
      "fontSize"         => font_size,
      "fontStyle"        => font_style,
      "fontWeight"       => font_weight&.to_dynamic,
      "href"             => href,
      "interpolate"      => interpolate,
      "limit"            => limit,
      "opacity"          => opacity,
      "orient"           => orient,
      "radius"           => radius,
      "shape"            => shape,
      "size"             => size,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "tension"          => tension,
      "text"             => text,
      "theta"            => theta,
      "thickness"        => thickness,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
module Anchor
  Start  = "start"
  Middle = "middle"
  End    = "end"
end

# Default title orientation ("top", "bottom", "left", or "right")
#
# The orientation of the title relative to the chart. One of `"top"` (the default),
# `"bottom"`, `"left"`, or `"right"`.
#
# The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
# orientation can be used to further specialize the axis type (e.g., a y axis oriented for
# the right edge of the chart).
#
# __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
module TitleOrient
  Top    = "top"
  Bottom = "bottom"
  Left   = "left"
  Right  = "right"
end

# Title configuration, which determines default properties for all [titles](title.html).
# For a full list of title configuration options, please see the [corresponding section of
# the title documentation](title.html#config).
class VGTitleConfig < Dry::Struct

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
  attribute :anchor, Types::Anchor.optional

  # Angle in degrees of title text.
  attribute :angle, Types::Double.optional

  # Vertical text baseline for title text.
  attribute :baseline, Types::VerticalAlign.optional

  # Text color for title text.
  attribute :color, Types::String.optional

  # Font name for title text.
  attribute :font, Types::String.optional

  # Font size in pixels for title text.
  #
  # __Default value:__ `10`.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # Font weight for title text.
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # The maximum allowed length in pixels of legend labels.
  attribute :limit, Types::Double.constrained(gteq: 0).optional

  # Offset in pixels of the title from the chart body and axes.
  attribute :offset, Types::Double.optional

  # Default title orientation ("top", "bottom", "left", or "right")
  attribute :orient, Types::TitleOrient.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      anchor:      d.key?("anchor") ? Types::Anchor[d["anchor"]] : nil,
      angle:       d.key?("angle") ? Types::Double[d["angle"]] : nil,
      baseline:    d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      color:       d.key?("color") ? Types::String[d["color"]] : nil,
      font:        d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:   d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_weight: d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      limit:       d.key?("limit") ? Types::Double.constrained(gteq: 0)[d["limit"]] : nil,
      offset:      d.key?("offset") ? Types::Double[d["offset"]] : nil,
      orient:      d.key?("orient") ? Types::TitleOrient[d["orient"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "anchor"     => anchor,
      "angle"      => angle,
      "baseline"   => baseline,
      "color"      => color,
      "font"       => font,
      "fontSize"   => font_size,
      "fontWeight" => font_weight&.to_dynamic,
      "limit"      => limit,
      "offset"     => offset,
      "orient"     => orient,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Default properties for [single view plots](spec.html#single).
class ViewConfig < Dry::Struct

  # Whether the view should be clipped.
  attribute :clip, Types::Bool.optional

  # The fill color.
  #
  # __Default value:__ (none)
  attribute :fill, Types::String.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ (none)
  attribute :fill_opacity, Types::Double.optional

  # The default height of the single plot or each plot in a trellis plot when the
  # visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
  #
  # __Default value:__ `200`
  attribute :height, Types::Double.optional

  # The stroke color.
  #
  # __Default value:__ (none)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  #
  # __Default value:__ (none)
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  #
  # __Default value:__ (none)
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ (none)
  attribute :stroke_opacity, Types::Double.optional

  # The stroke width, in pixels.
  #
  # __Default value:__ (none)
  attribute :stroke_width, Types::Double.optional

  # The default width of the single plot or each plot in a trellis plot when the
  # visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
  # = `null`.
  #
  # __Default value:__ `200`
  attribute :width, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      clip:               d.key?("clip") ? Types::Bool[d["clip"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double[d["fillOpacity"]] : nil,
      height:             d.key?("height") ? Types::Double[d["height"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double[d["strokeWidth"]] : nil,
      width:              d.key?("width") ? Types::Double[d["width"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "clip"             => clip,
      "fill"             => fill,
      "fillOpacity"      => fill_opacity,
      "height"           => height,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "width"            => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Vega-Lite configuration object.  This property can only be defined at the top-level of a
# specification.
class Config < Dry::Struct

  # Area-Specific Config
  attribute :area, MarkConfig.optional

  # Sets how the visualization size should be determined. If a string, should be one of
  # `"pad"`, `"fit"` or `"none"`.
  # Object values can additionally specify parameters for content sizing and automatic
  # resizing.
  # `"fit"` is only supported for single and layered views that don't use `rangeStep`.
  #
  # __Default value__: `pad`
  attribute :autosize, Types.Instance(Autosize).optional

  # Axis configuration, which determines default properties for all `x` and `y`
  # [axes](axis.html). For a full list of axis configuration options, please see the
  # [corresponding section of the axis documentation](axis.html#config).
  attribute :axis, AxisConfig.optional

  # Specific axis config for axes with "band" scales.
  attribute :axis_band, VGAxisConfig.optional

  # Specific axis config for x-axis along the bottom edge of the chart.
  attribute :axis_bottom, VGAxisConfig.optional

  # Specific axis config for y-axis along the left edge of the chart.
  attribute :axis_left, VGAxisConfig.optional

  # Specific axis config for y-axis along the right edge of the chart.
  attribute :axis_right, VGAxisConfig.optional

  # Specific axis config for x-axis along the top edge of the chart.
  attribute :axis_top, VGAxisConfig.optional

  # X-axis specific config.
  attribute :axis_x, VGAxisConfig.optional

  # Y-axis specific config.
  attribute :axis_y, VGAxisConfig.optional

  # CSS color property to use as the background of visualization.
  #
  # __Default value:__ none (transparent)
  attribute :background, Types::String.optional

  # Bar-Specific Config
  attribute :bar, BarConfig.optional

  # Circle-Specific Config
  attribute :circle, MarkConfig.optional

  # Default axis and legend title for count fields.
  #
  # __Default value:__ `'Number of Records'`.
  attribute :count_title, Types::String.optional

  # Defines how Vega-Lite generates title for fields.  There are three possible styles:
  #
  # - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
  # "Year-month of date", "field (binned)").
  # - `"function"` - displays function using parentheses and capitalized texts (e.g.,
  # "SUM(field)", "YEARMONTH(date)", "BIN(field)").
  # - `"plain"` - displays only the field name without functions (e.g., "field", "date",
  # "field").
  attribute :field_title, Types::FieldTitle.optional

  # Geoshape-Specific Config
  attribute :geoshape, MarkConfig.optional

  # Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
  # - If set to `"filter"` (default), all data items with null values are filtered.
  # - If `null`, all data items are included. In this case, invalid values will be
  # interpreted as zeroes.
  attribute :invalid_values, Types::InvalidValues.optional

  # Legend configuration, which determines default properties for all [legends](legend.html).
  # For a full list of legend configuration options, please see the [corresponding section of
  # in the legend documentation](legend.html#config).
  attribute :legend, LegendConfig.optional

  # Line-Specific Config
  attribute :line, MarkConfig.optional

  # Mark Config
  attribute :mark, MarkConfig.optional

  # D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
  # number format pattern](https://github.com/d3/d3-format#locale_format).
  attribute :number_format, Types::String.optional

  # The default visualization padding, in pixels, from the edge of the visualization canvas
  # to the data rectangle.  If a number, specifies padding for all sides.
  # If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
  # "bottom": 5}` to specify padding for each side of the visualization.
  #
  # __Default value__: `5`
  attribute :padding, Types.Instance(Padding).optional

  # Point-Specific Config
  attribute :point, MarkConfig.optional

  # Projection configuration, which determines default properties for all
  # [projections](projection.html). For a full list of projection configuration options,
  # please see the [corresponding section of the projection
  # documentation](projection.html#config).
  attribute :projection, ProjectionConfig.optional

  # An object hash that defines default range arrays or schemes for using with scales.
  # For a full list of scale range configuration options, please see the [corresponding
  # section of the scale documentation](scale.html#config).
  attribute :range, Types::Hash.meta(of: Types.Instance(RangeConfigValue)).optional

  # Rect-Specific Config
  attribute :rect, MarkConfig.optional

  # Rule-Specific Config
  attribute :config_rule, MarkConfig.optional

  # Scale configuration determines default properties for all [scales](scale.html). For a
  # full list of scale configuration options, please see the [corresponding section of the
  # scale documentation](scale.html#config).
  attribute :scale, ScaleConfig.optional

  # An object hash for defining default properties for each type of selections.
  attribute :selection, SelectionConfig.optional

  # Square-Specific Config
  attribute :square, MarkConfig.optional

  # Default stack offset for stackable mark.
  attribute :stack, Types::StackOffset.optional

  # An object hash that defines key-value mappings to determine default properties for marks
  # with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
  # valid [mark configuration objects](mark.html#config).
  attribute :style, Types::Hash.meta(of: VGMarkConfig).optional

  # Text-Specific Config
  attribute :text, TextConfig.optional

  # Tick-Specific Config
  attribute :tick, TickConfig.optional

  # Default datetime format for axis and legend labels. The format can be set directly on
  # each axis and legend. Use [D3's time format
  # pattern](https://github.com/d3/d3-time-format#locale_format).
  #
  # __Default value:__ `'%b %d, %Y'`.
  attribute :time_format, Types::String.optional

  # Title configuration, which determines default properties for all [titles](title.html).
  # For a full list of title configuration options, please see the [corresponding section of
  # the title documentation](title.html#config).
  attribute :title, VGTitleConfig.optional

  # Default properties for [single view plots](spec.html#single).
  attribute :view, ViewConfig.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      area:           d.key?("area") ? MarkConfig.from_dynamic!(d["area"]) : nil,
      autosize:       d.key?("autosize") ? Autosize.from_dynamic!(d["autosize"]) : nil,
      axis:           d.key?("axis") ? AxisConfig.from_dynamic!(d["axis"]) : nil,
      axis_band:      d.key?("axisBand") ? VGAxisConfig.from_dynamic!(d["axisBand"]) : nil,
      axis_bottom:    d.key?("axisBottom") ? VGAxisConfig.from_dynamic!(d["axisBottom"]) : nil,
      axis_left:      d.key?("axisLeft") ? VGAxisConfig.from_dynamic!(d["axisLeft"]) : nil,
      axis_right:     d.key?("axisRight") ? VGAxisConfig.from_dynamic!(d["axisRight"]) : nil,
      axis_top:       d.key?("axisTop") ? VGAxisConfig.from_dynamic!(d["axisTop"]) : nil,
      axis_x:         d.key?("axisX") ? VGAxisConfig.from_dynamic!(d["axisX"]) : nil,
      axis_y:         d.key?("axisY") ? VGAxisConfig.from_dynamic!(d["axisY"]) : nil,
      background:     d.key?("background") ? Types::String[d["background"]] : nil,
      bar:            d.key?("bar") ? BarConfig.from_dynamic!(d["bar"]) : nil,
      circle:         d.key?("circle") ? MarkConfig.from_dynamic!(d["circle"]) : nil,
      count_title:    d.key?("countTitle") ? Types::String[d["countTitle"]] : nil,
      field_title:    d.key?("fieldTitle") ? Types::FieldTitle[d["fieldTitle"]] : nil,
      geoshape:       d.key?("geoshape") ? MarkConfig.from_dynamic!(d["geoshape"]) : nil,
      invalid_values: d.key?("invalidValues") ? Types::InvalidValues[d["invalidValues"]] : nil,
      legend:         d.key?("legend") ? LegendConfig.from_dynamic!(d["legend"]) : nil,
      line:           d.key?("line") ? MarkConfig.from_dynamic!(d["line"]) : nil,
      mark:           d.key?("mark") ? MarkConfig.from_dynamic!(d["mark"]) : nil,
      number_format:  d.key?("numberFormat") ? Types::String[d["numberFormat"]] : nil,
      padding:        d.key?("padding") ? Padding.from_dynamic!(d["padding"]) : nil,
      point:          d.key?("point") ? MarkConfig.from_dynamic!(d["point"]) : nil,
      projection:     d.key?("projection") ? ProjectionConfig.from_dynamic!(d["projection"]) : nil,
      range:          d.key?("range") ? Types::Hash[d["range"]].map { |k, v| [k, RangeConfigValue.from_dynamic!(v)] }.to_h : nil,
      rect:           d.key?("rect") ? MarkConfig.from_dynamic!(d["rect"]) : nil,
      config_rule:    d.key?("rule") ? MarkConfig.from_dynamic!(d["rule"]) : nil,
      scale:          d.key?("scale") ? ScaleConfig.from_dynamic!(d["scale"]) : nil,
      selection:      d.key?("selection") ? SelectionConfig.from_dynamic!(d["selection"]) : nil,
      square:         d.key?("square") ? MarkConfig.from_dynamic!(d["square"]) : nil,
      stack:          d.key?("stack") ? Types::StackOffset[d["stack"]] : nil,
      style:          d.key?("style") ? Types::Hash[d["style"]].map { |k, v| [k, VGMarkConfig.from_dynamic!(v)] }.to_h : nil,
      text:           d.key?("text") ? TextConfig.from_dynamic!(d["text"]) : nil,
      tick:           d.key?("tick") ? TickConfig.from_dynamic!(d["tick"]) : nil,
      time_format:    d.key?("timeFormat") ? Types::String[d["timeFormat"]] : nil,
      title:          d.key?("title") ? VGTitleConfig.from_dynamic!(d["title"]) : nil,
      view:           d.key?("view") ? ViewConfig.from_dynamic!(d["view"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "area"          => area&.to_dynamic,
      "autosize"      => autosize&.to_dynamic,
      "axis"          => axis&.to_dynamic,
      "axisBand"      => axis_band&.to_dynamic,
      "axisBottom"    => axis_bottom&.to_dynamic,
      "axisLeft"      => axis_left&.to_dynamic,
      "axisRight"     => axis_right&.to_dynamic,
      "axisTop"       => axis_top&.to_dynamic,
      "axisX"         => axis_x&.to_dynamic,
      "axisY"         => axis_y&.to_dynamic,
      "background"    => background,
      "bar"           => bar&.to_dynamic,
      "circle"        => circle&.to_dynamic,
      "countTitle"    => count_title,
      "fieldTitle"    => field_title,
      "geoshape"      => geoshape&.to_dynamic,
      "invalidValues" => invalid_values,
      "legend"        => legend&.to_dynamic,
      "line"          => line&.to_dynamic,
      "mark"          => mark&.to_dynamic,
      "numberFormat"  => number_format,
      "padding"       => padding&.to_dynamic,
      "point"         => point&.to_dynamic,
      "projection"    => projection&.to_dynamic,
      "range"         => range&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "rect"          => rect&.to_dynamic,
      "rule"          => config_rule&.to_dynamic,
      "scale"         => scale&.to_dynamic,
      "selection"     => selection&.to_dynamic,
      "square"        => square&.to_dynamic,
      "stack"         => stack,
      "style"         => style&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "text"          => text&.to_dynamic,
      "tick"          => tick&.to_dynamic,
      "timeFormat"    => time_format,
      "title"         => title&.to_dynamic,
      "view"          => view&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Type of input data: `"json"`, `"csv"`, `"tsv"`.
# The default format type is determined by the extension of the file URL.
# If no extension is detected, `"json"` will be used by default.
module DataFormatType
  CSV      = "csv"
  Tsv      = "tsv"
  JSON     = "json"
  Topojson = "topojson"
end

module ParseEnum
  Auto = "auto"
end

class ParseUnion < Dry::Struct
  attribute :anything_map, Types::Hash.meta(of: Types::Any).optional
  attribute :enum_1,       Types::ParseEnum.optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, enum_1: nil)
      end
    rescue
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, anything_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_map != nil
      anything_map
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object that specifies the format for parsing the data file.
#
# An object that specifies the format for parsing the data values.
#
# An object that specifies the format for parsing the data.
class DataFormat < Dry::Struct

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
  attribute :parse, Types.Instance(ParseUnion).optional

  # Type of input data: `"json"`, `"csv"`, `"tsv"`.
  # The default format type is determined by the extension of the file URL.
  # If no extension is detected, `"json"` will be used by default.
  attribute :data_format_type, Types::DataFormatType.optional

  # The JSON property containing the desired data.
  # This parameter can be used when the loaded JSON file may have surrounding structure or
  # meta-data.
  # For example `"property": "values.features"` is equivalent to retrieving
  # `json.values.features`
  # from the loaded JSON object.
  attribute :property, Types::String.optional

  # The name of the TopoJSON object set to convert to a GeoJSON feature collection.
  # For example, in a map of the world, there may be an object set named `"countries"`.
  # Using the feature property, we can extract this set and generate a GeoJSON feature object
  # for each country.
  attribute :feature, Types::String.optional

  # The name of the TopoJSON object set to convert to mesh.
  # Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
  # Unlike the `feature` option, the corresponding geo data is returned as a single, unified
  # mesh instance, not as individual GeoJSON features.
  # Extracting a mesh is useful for more efficiently drawing borders or other geographic
  # elements that you do not need to associate with specific regions such as individual
  # countries, states or counties.
  attribute :mesh, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      parse:            d.key?("parse") ? ParseUnion.from_dynamic!(d["parse"]) : nil,
      data_format_type: d.key?("type") ? Types::DataFormatType[d["type"]] : nil,
      property:         d.key?("property") ? Types::String[d["property"]] : nil,
      feature:          d.key?("feature") ? Types::String[d["feature"]] : nil,
      mesh:             d.key?("mesh") ? Types::String[d["mesh"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "parse"    => parse&.to_dynamic,
      "type"     => data_format_type,
      "property" => property,
      "feature"  => feature,
      "mesh"     => mesh,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ValuesValue < Dry::Struct
  attribute :anything_map, Types::Hash.meta(of: Types::Any).optional
  attribute :bool,         Types::Bool.optional
  attribute :double,       Types::Double.optional
  attribute :string,       Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, bool: nil, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, anything_map: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, anything_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, double: nil, anything_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_map != nil
      anything_map
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The full data set, included inline. This can be an array of objects or primitive values
# or a string.
# Arrays of primitive values are ingested as objects with a `data` property. Strings are
# parsed according to the specified format type.
class Values < Dry::Struct
  attribute :anything_map, Types::Hash.meta(of: Types::Any).optional
  attribute :string,       Types::String.optional
  attribute :union_array,  Types.Array(Types.Instance(ValuesValue)).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, union_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_array: nil, anything_map: nil)
    end
    begin
      value = d.map { |x| ValuesValue.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, anything_map: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_map != nil
      anything_map
    elsif string != nil
      string
    elsif union_array != nil
      union_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object describing the data source
#
# Secondary data source to lookup in.
class DataClass < Dry::Struct

  # An object that specifies the format for parsing the data file.
  #
  # An object that specifies the format for parsing the data values.
  #
  # An object that specifies the format for parsing the data.
  attribute :data_format, DataFormat.optional

  # An URL from which to load the data set. Use the `format.type` property
  # to ensure the loaded data is correctly parsed.
  attribute :url, Types::String.optional

  # The full data set, included inline. This can be an array of objects or primitive values
  # or a string.
  # Arrays of primitive values are ingested as objects with a `data` property. Strings are
  # parsed according to the specified format type.
  attribute :values, Types.Instance(Values).optional

  # Provide a placeholder name and bind data at runtime.
  attribute :data_name, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data_format: d.key?("format") ? DataFormat.from_dynamic!(d["format"]) : nil,
      url:         d.key?("url") ? Types::String[d["url"]] : nil,
      values:      d.key?("values") ? Values.from_dynamic!(d["values"]) : nil,
      data_name:   d.key?("name") ? Types::String[d["name"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "format" => data_format&.to_dynamic,
      "url"    => url,
      "values" => values&.to_dynamic,
      "name"   => data_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Aggregation function for the field
# (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
#
# __Default value:__ `undefined` (None)
#
# An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
# (e.g., `"count"`, `"mean"` and `"median"`).
# This property is required in cases where the sort field and the data reference field do
# not match.
# The input data objects will be aggregated, grouped by the encoded data field.
#
# For a full list of operations, please see the documentation for
# [aggregate](aggregate.html#ops).
#
# The aggregation operations to apply to the fields, such as sum, average or count.
# See the [full list of supported aggregation
# operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
# for more information.
module AggregateOp
  Argmax    = "argmax"
  Argmin    = "argmin"
  Average   = "average"
  Count     = "count"
  Distinct  = "distinct"
  Max       = "max"
  Mean      = "mean"
  Median    = "median"
  Min       = "min"
  Missing   = "missing"
  Q1        = "q1"
  Q3        = "q3"
  Ci0       = "ci0"
  Ci1       = "ci1"
  Stdev     = "stdev"
  Stdevp    = "stdevp"
  Sum       = "sum"
  Valid     = "valid"
  Values    = "values"
  Variance  = "variance"
  Variancep = "variancep"
end

# Binning properties or boolean flag for determining whether to bin data or not.
class BinParams < Dry::Struct

  # The number base to use for automatic bin determination (default is base 10).
  #
  # __Default value:__ `10`
  attribute :base, Types::Double.optional

  # Scale factors indicating allowable subdivisions. The default value is [5, 2], which
  # indicates that for base 10 numbers (the default base), the method may consider dividing
  # bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
  # check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
  # given constraints.
  #
  # __Default value:__ `[5, 2]`
  attribute :divide, Types.Array(Types::Double).constrained(min_size: 1).optional

  # A two-element (`[min, max]`) array indicating the range of desired bin values.
  attribute :extent, Types.Array(Types::Double).constrained(min_size: 2, max_size: 2).optional

  # Maximum number of bins.
  #
  # __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
  attribute :maxbins, Types::Double.constrained(gteq: 2).optional

  # A minimum allowable step size (particularly useful for integer values).
  attribute :minstep, Types::Double.optional

  # If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
  # such as multiples of ten.
  attribute :nice, Types::Bool.optional

  # An exact step size to use between bins.
  #
  # __Note:__ If provided, options such as maxbins will be ignored.
  attribute :step, Types::Double.optional

  # An array of allowable step sizes to choose from.
  attribute :steps, Types.Array(Types::Double).constrained(min_size: 1).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      base:    d.key?("base") ? Types::Double[d["base"]] : nil,
      divide:  d.key?("divide") ? d["divide"].map { |x| Types::Double[x] } : nil,
      extent:  d.key?("extent") ? d["extent"].map { |x| Types::Double[x] } : nil,
      maxbins: d.key?("maxbins") ? Types::Double.constrained(gteq: 2)[d["maxbins"]] : nil,
      minstep: d.key?("minstep") ? Types::Double[d["minstep"]] : nil,
      nice:    d.key?("nice") ? Types::Bool[d["nice"]] : nil,
      step:    d.key?("step") ? Types::Double[d["step"]] : nil,
      steps:   d.key?("steps") ? d["steps"].map { |x| Types::Double[x] } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "base"    => base,
      "divide"  => divide,
      "extent"  => extent,
      "maxbins" => maxbins,
      "minstep" => minstep,
      "nice"    => nice,
      "step"    => step,
      "steps"   => steps,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bin < Dry::Struct
  attribute :bin_params, BinParams.optional
  attribute :bool,       Types::Bool.optional

  def self.from_dynamic!(d)
    begin
      value = BinParams.from_dynamic!(d)
      if schema.key(:bin_params).type.right.valid? value
        return new(bin_params: value, bool: nil)
      end
    rescue
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, bin_params: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bin_params != nil
      bin_params.to_dynamic
    elsif bool != nil
      bool
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Value representing the day of a week.  This can be one of: (1) integer value -- `1`
# represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
# case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
# DateTime definition object with `day`** should not be combined with `year`, `quarter`,
# `month`, or `date`.
class Day < Dry::Struct
  attribute :double, Types::Double.constrained(gteq: 1, lteq: 7).optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
# (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
# short month name (e.g., `"Jan"`).
class Month < Dry::Struct
  attribute :double, Types::Double.constrained(gteq: 1, lteq: 12).optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Object for defining datetime in Vega-Lite Filter.
# If both month and quarter are provided, month has higher precedence.
# `day` cannot be combined with other date.
# We accept string for month and day names.
class DateTimeClass < Dry::Struct

  # Integer value representing the date from 1-31.
  attribute :date, Types::Double.constrained(gteq: 1, lteq: 31).optional

  # Value representing the day of a week.  This can be one of: (1) integer value -- `1`
  # represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
  # case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
  # DateTime definition object with `day`** should not be combined with `year`, `quarter`,
  # `month`, or `date`.
  attribute :day, Types.Instance(Day).optional

  # Integer value representing the hour of a day from 0-23.
  attribute :hours, Types::Double.constrained(gteq: 0, lteq: 23).optional

  # Integer value representing the millisecond segment of time.
  attribute :milliseconds, Types::Double.constrained(gteq: 0, lteq: 999).optional

  # Integer value representing the minute segment of time from 0-59.
  attribute :minutes, Types::Double.constrained(gteq: 0, lteq: 59).optional

  # One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
  # (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
  # short month name (e.g., `"Jan"`).
  attribute :month, Types.Instance(Month).optional

  # Integer value representing the quarter of the year (from 1-4).
  attribute :quarter, Types::Double.constrained(gteq: 1, lteq: 4).optional

  # Integer value representing the second segment (0-59) of a time value
  attribute :seconds, Types::Double.constrained(gteq: 0, lteq: 59).optional

  # A boolean flag indicating if date time is in utc time. If false, the date time is in
  # local time
  attribute :utc, Types::Bool.optional

  # Integer value representing the year.
  attribute :year, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date:         d.key?("date") ? Types::Double.constrained(gteq: 1, lteq: 31)[d["date"]] : nil,
      day:          d.key?("day") ? Day.from_dynamic!(d["day"]) : nil,
      hours:        d.key?("hours") ? Types::Double.constrained(gteq: 0, lteq: 23)[d["hours"]] : nil,
      milliseconds: d.key?("milliseconds") ? Types::Double.constrained(gteq: 0, lteq: 999)[d["milliseconds"]] : nil,
      minutes:      d.key?("minutes") ? Types::Double.constrained(gteq: 0, lteq: 59)[d["minutes"]] : nil,
      month:        d.key?("month") ? Month.from_dynamic!(d["month"]) : nil,
      quarter:      d.key?("quarter") ? Types::Double.constrained(gteq: 1, lteq: 4)[d["quarter"]] : nil,
      seconds:      d.key?("seconds") ? Types::Double.constrained(gteq: 0, lteq: 59)[d["seconds"]] : nil,
      utc:          d.key?("utc") ? Types::Bool[d["utc"]] : nil,
      year:         d.key?("year") ? Types::Double[d["year"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date"         => date,
      "day"          => day&.to_dynamic,
      "hours"        => hours,
      "milliseconds" => milliseconds,
      "minutes"      => minutes,
      "month"        => month&.to_dynamic,
      "quarter"      => quarter,
      "seconds"      => seconds,
      "utc"          => utc,
      "year"         => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The value that the field should be equal to.
class Equal < Dry::Struct
  attribute :bool,            Types::Bool.optional
  attribute :date_time_class, DateTimeClass.optional
  attribute :double,          Types::Double.optional
  attribute :string,          Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, date_time_class: nil, double: nil, string: nil)
    end
    begin
      value = DateTimeClass.from_dynamic!(d)
      if schema.key(:date_time_class).type.right.valid? value
        return new(date_time_class: value, bool: nil, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, date_time_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, date_time_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif date_time_class != nil
      date_time_class.to_dynamic
    elsif double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RangeElement < Dry::Struct
  attribute :date_time_class, DateTimeClass.optional
  attribute :double,          Types::Double.optional
  attribute :null,            Types::Nil.optional

  def self.from_dynamic!(d)
    begin
      value = DateTimeClass.from_dynamic!(d)
      if schema.key(:date_time_class).type.right.valid? value
        return new(date_time_class: value, double: nil, null: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_time_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, date_time_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time_class != nil
      date_time_class.to_dynamic
    elsif double != nil
      double
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Filter using a selection name.
#
# A [selection name](selection.html), or a series of [composed
# selections](selection.html#compose).
class SelectionOperand < Dry::Struct
  attribute :selection, Selection.optional
  attribute :string,    Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Selection.from_dynamic!(d)
      if schema.key(:selection).type.right.valid? value
        return new(selection: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, selection: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if selection != nil
      selection.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Selection < Dry::Struct
  attribute :selection_not, Types.Instance(SelectionOperand).optional
  attribute :selection_and, Types.Array(Types.Instance(SelectionOperand)).optional
  attribute :selection_or,  Types.Array(Types.Instance(SelectionOperand)).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      selection_not: d.key?("not") ? SelectionOperand.from_dynamic!(d["not"]) : nil,
      selection_and: d.key?("and") ? d["and"].map { |x| SelectionOperand.from_dynamic!(x) } : nil,
      selection_or:  d.key?("or") ? d["or"].map { |x| SelectionOperand.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "not" => selection_not&.to_dynamic,
      "and" => selection_and&.map { |x| x.to_dynamic },
      "or"  => selection_or&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Time unit for the field to be filtered.
#
# time unit for the field to be filtered.
#
# Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
# or [a temporal field that gets casted as ordinal](type.html#cast).
#
# __Default value:__ `undefined` (None)
#
# The timeUnit.
module TimeUnit
  Year                                = "year"
  Quarter                             = "quarter"
  Month                               = "month"
  Day                                 = "day"
  Date                                = "date"
  Hours                               = "hours"
  Minutes                             = "minutes"
  Seconds                             = "seconds"
  Milliseconds                        = "milliseconds"
  Utcyear                             = "utcyear"
  Utcquarter                          = "utcquarter"
  Utcmonth                            = "utcmonth"
  Utcday                              = "utcday"
  Utcdate                             = "utcdate"
  Utchours                            = "utchours"
  Utcminutes                          = "utcminutes"
  Utcseconds                          = "utcseconds"
  Utcmilliseconds                     = "utcmilliseconds"
  Yearquarter                         = "yearquarter"
  Yearquartermonth                    = "yearquartermonth"
  Yearmonth                           = "yearmonth"
  Yearmonthdate                       = "yearmonthdate"
  Yearmonthdatehours                  = "yearmonthdatehours"
  Yearmonthdatehoursminutes           = "yearmonthdatehoursminutes"
  Yearmonthdatehoursminutesseconds    = "yearmonthdatehoursminutesseconds"
  Quartermonth                        = "quartermonth"
  Monthdate                           = "monthdate"
  Hoursminutes                        = "hoursminutes"
  Hoursminutesseconds                 = "hoursminutesseconds"
  Minutesseconds                      = "minutesseconds"
  Secondsmilliseconds                 = "secondsmilliseconds"
  Utcyearquarter                      = "utcyearquarter"
  Utcyearquartermonth                 = "utcyearquartermonth"
  Utcyearmonth                        = "utcyearmonth"
  Utcyearmonthdate                    = "utcyearmonthdate"
  Utcyearmonthdatehours               = "utcyearmonthdatehours"
  Utcyearmonthdatehoursminutes        = "utcyearmonthdatehoursminutes"
  Utcyearmonthdatehoursminutesseconds = "utcyearmonthdatehoursminutesseconds"
  Utcquartermonth                     = "utcquartermonth"
  Utcmonthdate                        = "utcmonthdate"
  Utchoursminutes                     = "utchoursminutes"
  Utchoursminutesseconds              = "utchoursminutesseconds"
  Utcminutesseconds                   = "utcminutesseconds"
  Utcsecondsmilliseconds              = "utcsecondsmilliseconds"
end

# The `filter` property must be one of the predicate definitions:
# (1) an [expression](types.html#expression) string,
# where `datum` can be used to refer to the current data object;
# (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
# [range predicate](filter.html#range-predicate), [one-of
# predicate](filter.html#one-of-predicate);
# (3) a [selection predicate](filter.html#selection-predicate);
# or (4) a logical operand that combines (1), (2), or (3).
class LogicalOperandPredicate < Dry::Struct
  attribute :predicate, Predicate.optional
  attribute :string,    Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Predicate.from_dynamic!(d)
      if schema.key(:predicate).type.right.valid? value
        return new(predicate: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, predicate: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if predicate != nil
      predicate.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Predicate < Dry::Struct
  attribute :predicate_not, Types.Instance(LogicalOperandPredicate).optional
  attribute :predicate_and, Types.Array(Types.Instance(LogicalOperandPredicate)).optional
  attribute :predicate_or,  Types.Array(Types.Instance(LogicalOperandPredicate)).optional

  # The value that the field should be equal to.
  attribute :equal, Types.Instance(Equal).optional

  # Field to be filtered.
  #
  # Field to be filtered
  attribute :field, Types::String.optional

  # Time unit for the field to be filtered.
  #
  # time unit for the field to be filtered.
  attribute :time_unit, Types::TimeUnit.optional

  # An array of inclusive minimum and maximum values
  # for a field value of a data item to be included in the filtered data.
  attribute :range, Types.Array(Types.Instance(RangeElement)).constrained(min_size: 2, max_size: 2).optional

  # A set of values that the `field`'s value should be a member of,
  # for a data item included in the filtered data.
  attribute :one_of, Types.Array(Types.Instance(Equal)).optional

  # Filter using a selection name.
  attribute :selection, Types.Instance(SelectionOperand).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      predicate_not: d.key?("not") ? LogicalOperandPredicate.from_dynamic!(d["not"]) : nil,
      predicate_and: d.key?("and") ? d["and"].map { |x| LogicalOperandPredicate.from_dynamic!(x) } : nil,
      predicate_or:  d.key?("or") ? d["or"].map { |x| LogicalOperandPredicate.from_dynamic!(x) } : nil,
      equal:         d.key?("equal") ? Equal.from_dynamic!(d["equal"]) : nil,
      field:         d.key?("field") ? Types::String[d["field"]] : nil,
      time_unit:     d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      range:         d.key?("range") ? d["range"].map { |x| RangeElement.from_dynamic!(x) } : nil,
      one_of:        d.key?("oneOf") ? d["oneOf"].map { |x| Equal.from_dynamic!(x) } : nil,
      selection:     d.key?("selection") ? SelectionOperand.from_dynamic!(d["selection"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "not"       => predicate_not&.to_dynamic,
      "and"       => predicate_and&.map { |x| x.to_dynamic },
      "or"        => predicate_or&.map { |x| x.to_dynamic },
      "equal"     => equal&.to_dynamic,
      "field"     => field,
      "timeUnit"  => time_unit,
      "range"     => range&.map { |x| x.to_dynamic },
      "oneOf"     => one_of&.map { |x| x.to_dynamic },
      "selection" => selection&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
# `0` to `1` for opacity).
#
# A constant value in visual domain.
class ConditionalValueDefValue < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConditionalValueDef < Dry::Struct
  attribute :conditional_value_def_test, Types.Instance(LogicalOperandPredicate).optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue)

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  attribute :selection, Types.Instance(SelectionOperand).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      conditional_value_def_test: d.key?("test") ? LogicalOperandPredicate.from_dynamic!(d["test"]) : nil,
      value:                      ConditionalValueDefValue.from_dynamic!(d.fetch("value")),
      selection:                  d.key?("selection") ? SelectionOperand.from_dynamic!(d["selection"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "test"      => conditional_value_def_test&.to_dynamic,
      "value"     => value.to_dynamic,
      "selection" => selection&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
# `"nominal"`).
# It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
# [geographic projection](projection.html) is applied.
#
# Constants and utilities for data type
# Data type based on level of measurement
module Type
  Quantitative = "quantitative"
  Ordinal      = "ordinal"
  Temporal     = "temporal"
  Nominal      = "nominal"
  Latitude     = "latitude"
  Longitude    = "longitude"
  Geojson      = "geojson"
end

module RepeatEnum
  Row    = "row"
  Column = "column"
end

# Reference to a repeated value.
class RepeatRef < Dry::Struct
  attribute :repeat, Types::RepeatEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      repeat: d.fetch("repeat"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "repeat" => repeat,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Field < Dry::Struct
  attribute :repeat_ref, RepeatRef.optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = RepeatRef.from_dynamic!(d)
      if schema.key(:repeat_ref).type.right.valid? value
        return new(repeat_ref: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, repeat_ref: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if repeat_ref != nil
      repeat_ref.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
# continuous color gradient.
#
# __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
# `"symbol"` otherwise.
module LegendType
  Symbol   = "symbol"
  Gradient = "gradient"
end

class LegendValue < Dry::Struct
  attribute :date_time_class, DateTimeClass.optional
  attribute :double,          Types::Double.optional
  attribute :string,          Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = DateTimeClass.from_dynamic!(d)
      if schema.key(:date_time_class).type.right.valid? value
        return new(date_time_class: value, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_time_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, date_time_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time_class != nil
      date_time_class.to_dynamic
    elsif double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Properties of a legend or boolean flag for determining whether to show it.
class Legend < Dry::Struct

  # Padding (in pixels) between legend entries in a symbol legend.
  attribute :entry_padding, Types::Double.optional

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  attribute :legend_format, Types::String.optional

  # The offset, in pixels, by which to displace the legend from the edge of the enclosing
  # group or data rectangle.
  #
  # __Default value:__  `0`
  attribute :offset, Types::Double.optional

  # The orientation of the legend, which determines how the legend is positioned within the
  # scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
  # "none".
  #
  # __Default value:__ `"right"`
  attribute :orient, Types::LegendOrient.optional

  # The padding, in pixels, between the legend and axis.
  attribute :padding, Types::Double.optional

  # The desired number of tick values for quantitative legends.
  attribute :tick_count, Types::Double.optional

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
  attribute :title, Types::String.optional.optional

  # The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
  # continuous color gradient.
  #
  # __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
  # `"symbol"` otherwise.
  attribute :legend_type, Types::LegendType.optional

  # Explicitly set the visible legend values.
  attribute :values, Types.Array(Types.Instance(LegendValue)).optional

  # A non-positive integer indicating z-index of the legend.
  # If zindex is 0, legend should be drawn behind all chart elements.
  # To put them in front, use zindex = 1.
  attribute :zindex, Types::Double.constrained(gteq: 0).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      entry_padding: d.key?("entryPadding") ? Types::Double[d["entryPadding"]] : nil,
      legend_format: d.key?("format") ? Types::String[d["format"]] : nil,
      offset:        d.key?("offset") ? Types::Double[d["offset"]] : nil,
      orient:        d.key?("orient") ? Types::LegendOrient[d["orient"]] : nil,
      padding:       d.key?("padding") ? Types::Double[d["padding"]] : nil,
      tick_count:    d.key?("tickCount") ? Types::Double[d["tickCount"]] : nil,
      title:         d["title"],
      legend_type:   d.key?("type") ? Types::LegendType[d["type"]] : nil,
      values:        d.key?("values") ? d["values"].map { |x| LegendValue.from_dynamic!(x) } : nil,
      zindex:        d.key?("zindex") ? Types::Double.constrained(gteq: 0)[d["zindex"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "entryPadding" => entry_padding,
      "format"       => legend_format,
      "offset"       => offset,
      "orient"       => orient,
      "padding"      => padding,
      "tickCount"    => tick_count,
      "title"        => title,
      "type"         => legend_type,
      "values"       => values&.map { |x| x.to_dynamic },
      "zindex"       => zindex,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DomainClass < Dry::Struct

  # The field name to extract selected values for, when a selection is
  # [projected](project.html)
  # over multiple fields or encodings.
  attribute :field, Types::String.optional

  # The name of a selection.
  attribute :selection, Types::String

  # The encoding channel to extract selected values for, when a selection is
  # [projected](project.html)
  # over multiple fields or encodings.
  attribute :encoding, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      field:     d.key?("field") ? Types::String[d["field"]] : nil,
      selection: d.fetch("selection"),
      encoding:  d.key?("encoding") ? Types::String[d["encoding"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "field"     => field,
      "selection" => selection,
      "encoding"  => encoding,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Domain
  Unaggregated = "unaggregated"
end

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
class DomainUnion < Dry::Struct
  attribute :domain_class, DomainClass.optional
  attribute :enum_1,       Types::Domain.optional
  attribute :union_array,  Types.Array(Types.Instance(Equal)).optional

  def self.from_dynamic!(d)
    begin
      value = DomainClass.from_dynamic!(d)
      if schema.key(:domain_class).type.right.valid? value
        return new(domain_class: value, union_array: nil, enum_1: nil)
      end
    rescue
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, union_array: nil, domain_class: nil)
    end
    begin
      value = d.map { |x| Equal.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, domain_class: nil, enum_1: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if domain_class != nil
      domain_class.to_dynamic
    elsif enum_1 != nil
      enum_1
    elsif union_array != nil
      union_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module InterpolateParamsType
  RGB           = "rgb"
  Cubehelix     = "cubehelix"
  CubehelixLong = "cubehelix-long"
end

class InterpolateParams < Dry::Struct
  attribute :gamma,                   Types::Double.optional
  attribute :interpolate_params_type, Types::InterpolateParamsType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      gamma:                   d.key?("gamma") ? Types::Double[d["gamma"]] : nil,
      interpolate_params_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "gamma" => gamma,
      "type"  => interpolate_params_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
class InterpolateUnion < Dry::Struct
  attribute :enum_1,             Types::Interpolate.optional
  attribute :interpolate_params, InterpolateParams.optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, interpolate_params: nil)
    end
    begin
      value = InterpolateParams.from_dynamic!(d)
      if schema.key(:interpolate_params).type.right.valid? value
        return new(interpolate_params: value, enum_1: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif interpolate_params != nil
      interpolate_params.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NiceClass < Dry::Struct
  attribute :interval, Types::String
  attribute :step,     Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      interval: d.fetch("interval"),
      step:     d.fetch("step"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "interval" => interval,
      "step"     => step,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module NiceTime
  Second = "second"
  Minute = "minute"
  Hour   = "hour"
  Day    = "day"
  Week   = "week"
  Month  = "month"
  Year   = "year"
end

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
class NiceUnion < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :double,     Types::Double.optional
  attribute :enum_1,     Types::NiceTime.optional
  attribute :nice_class, NiceClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, nice_class: nil, double: nil, enum_1: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, nice_class: nil, enum_1: nil)
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, bool: nil, nice_class: nil, double: nil)
    end
    begin
      value = NiceClass.from_dynamic!(d)
      if schema.key(:nice_class).type.right.valid? value
        return new(nice_class: value, bool: nil, double: nil, enum_1: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    elsif enum_1 != nil
      enum_1
    elsif nice_class != nil
      nice_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
class ScaleRange < Dry::Struct
  attribute :string,      Types::String.optional
  attribute :union_array, Types.Array(Types.Instance(TitleFontWeight)).optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_array: nil)
    end
    begin
      value = d.map { |x| TitleFontWeight.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif union_array != nil
      union_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

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
module ScaleType
  Linear     = "linear"
  BinLinear  = "bin-linear"
  Log        = "log"
  Pow        = "pow"
  Sqrt       = "sqrt"
  Time       = "time"
  UTC        = "utc"
  Sequential = "sequential"
  Ordinal    = "ordinal"
  BinOrdinal = "bin-ordinal"
  Point      = "point"
  Band       = "band"
end

class SchemeParams < Dry::Struct

  # For sequential and diverging schemes only, determines the extent of the color range to
  # use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
  # range _[0, 0.2)_ are excluded from the scheme.
  attribute :extent, Types.Array(Types::Double).optional

  # A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
  #
  # For the full list of supported scheme, please refer to the [Vega
  # Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
  attribute :scheme_params_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      extent:             d.key?("extent") ? d["extent"].map { |x| Types::Double[x] } : nil,
      scheme_params_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "extent" => extent,
      "name"   => scheme_params_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
# `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
#
# Discrete color schemes may be used with [discrete](scale.html#discrete) or
# [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
# use with [sequential](scales.html#sequential) scales.
#
# For the full list of supported scheme, please refer to the [Vega
# Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
class Scheme < Dry::Struct
  attribute :scheme_params, SchemeParams.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = SchemeParams.from_dynamic!(d)
      if schema.key(:scheme_params).type.right.valid? value
        return new(scheme_params: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, scheme_params: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if scheme_params != nil
      scheme_params.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object defining properties of the channel's scale, which is the function that
# transforms values in the data domain (numbers, dates, strings, etc) to visual values
# (pixels, colors, sizes) of the encoding channels.
#
# __Default value:__ If undefined, default [scale properties](scale.html) are applied.
class Scale < Dry::Struct

  # The logarithm base of the `log` scale (default `10`).
  attribute :base, Types::Double.optional

  # If `true`, values that exceed the data domain are clamped to either the minimum or
  # maximum range value
  #
  # __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
  # (`true` by default).
  attribute :clamp, Types::Bool.optional

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
  attribute :domain, Types.Instance(DomainUnion).optional

  # The exponent of the `pow` scale.
  attribute :exponent, Types::Double.optional

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
  attribute :interpolate, Types.Instance(InterpolateUnion).optional

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
  attribute :nice, Types.Instance(NiceUnion).optional

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
  attribute :padding, Types::Double.constrained(gteq: 0).optional

  # The inner padding (spacing) within each band step of band scales, as a fraction of the
  # step size. This value must lie in the range [0,1].
  #
  # For point scale, this property is invalid as point scales do not have internal band
  # widths (only step sizes between bands).
  #
  # __Default value:__ derived from the [scale config](scale.html#config)'s
  # `bandPaddingInner`.
  attribute :padding_inner, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The outer padding (spacing) at the ends of the range of band and point scales,
  # as a fraction of the step size. This value must lie in the range [0,1].
  #
  # __Default value:__ derived from the [scale config](scale.html#config)'s
  # `bandPaddingOuter` for band scales and `pointPadding` for point scales.
  attribute :padding_outer, Types::Double.constrained(gteq: 0, lteq: 1).optional

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
  attribute :range, Types.Instance(ScaleRange).optional

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
  attribute :range_step, Types::Double.constrained(gteq: 0).optional.optional

  # If `true`, rounds numeric output values to integers. This can be helpful for snapping to
  # the pixel grid.
  #
  # __Default value:__ `false`.
  attribute :round, Types::Bool.optional

  # A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
  # `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
  #
  # Discrete color schemes may be used with [discrete](scale.html#discrete) or
  # [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
  # use with [sequential](scales.html#sequential) scales.
  #
  # For the full list of supported scheme, please refer to the [Vega
  # Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
  attribute :scheme, Types.Instance(Scheme).optional

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
  attribute :scale_type, Types::ScaleType.optional

  # If `true`, ensures that a zero baseline value is included in the scale domain.
  #
  # __Default value:__ `true` for x and y channels if the quantitative field is not binned
  # and no custom `domain` is provided; `false` otherwise.
  #
  # __Note:__ Log, time, and utc scales do not support `zero`.
  attribute :zero, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      base:          d.key?("base") ? Types::Double[d["base"]] : nil,
      clamp:         d.key?("clamp") ? Types::Bool[d["clamp"]] : nil,
      domain:        d.key?("domain") ? DomainUnion.from_dynamic!(d["domain"]) : nil,
      exponent:      d.key?("exponent") ? Types::Double[d["exponent"]] : nil,
      interpolate:   d.key?("interpolate") ? InterpolateUnion.from_dynamic!(d["interpolate"]) : nil,
      nice:          d.key?("nice") ? NiceUnion.from_dynamic!(d["nice"]) : nil,
      padding:       d.key?("padding") ? Types::Double.constrained(gteq: 0)[d["padding"]] : nil,
      padding_inner: d.key?("paddingInner") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["paddingInner"]] : nil,
      padding_outer: d.key?("paddingOuter") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["paddingOuter"]] : nil,
      range:         d.key?("range") ? ScaleRange.from_dynamic!(d["range"]) : nil,
      range_step:    d["rangeStep"],
      round:         d.key?("round") ? Types::Bool[d["round"]] : nil,
      scheme:        d.key?("scheme") ? Scheme.from_dynamic!(d["scheme"]) : nil,
      scale_type:    d.key?("type") ? Types::ScaleType[d["type"]] : nil,
      zero:          d.key?("zero") ? Types::Bool[d["zero"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "base"         => base,
      "clamp"        => clamp,
      "domain"       => domain&.to_dynamic,
      "exponent"     => exponent,
      "interpolate"  => interpolate&.to_dynamic,
      "nice"         => nice&.to_dynamic,
      "padding"      => padding,
      "paddingInner" => padding_inner,
      "paddingOuter" => padding_outer,
      "range"        => range&.to_dynamic,
      "rangeStep"    => range_step,
      "round"        => round,
      "scheme"       => scheme&.to_dynamic,
      "type"         => scale_type,
      "zero"         => zero,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module SortEnum
  Ascending  = "ascending"
  Descending = "descending"
end

class SortField < Dry::Struct

  # The data [field](field.html) to sort by.
  #
  # __Default value:__ If unspecified, defaults to the field specified in the outer data
  # reference.
  attribute :field, Types.Instance(Field).optional

  # An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
  # (e.g., `"count"`, `"mean"` and `"median"`).
  # This property is required in cases where the sort field and the data reference field do
  # not match.
  # The input data objects will be aggregated, grouped by the encoded data field.
  #
  # For a full list of operations, please see the documentation for
  # [aggregate](aggregate.html#ops).
  attribute :op, Types::AggregateOp

  # The sort order. One of `"ascending"` (default) or `"descending"`.
  attribute :order, Types::SortEnum.optional.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      field: d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      op:    d.fetch("op"),
      order: d["order"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "field" => field&.to_dynamic,
      "op"    => op,
      "order" => order,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SortUnion < Dry::Struct
  attribute :enum_1,     Types::SortEnum.optional
  attribute :null,       Types::Nil.optional
  attribute :sort_field, SortField.optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, sort_field: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, sort_field: nil, enum_1: nil)
    end
    begin
      value = SortField.from_dynamic!(d)
      if schema.key(:sort_field).type.right.valid? value
        return new(sort_field: value, enum_1: nil, null: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif sort_field != nil
      sort_field.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConditionalPredicateMarkPropFieldDefClass < Dry::Struct
  attribute :conditional_def_test, Types.Instance(LogicalOperandPredicate).optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  attribute :selection, Types.Instance(SelectionOperand).optional

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # An object defining properties of the legend.
  # If `null`, the legend for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [legend properties](legend.html) are applied.
  attribute :legend, Legend.optional.optional

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  attribute :scale, Scale.optional

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  attribute :sort, Types.Instance(SortUnion).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :conditional_def_type, Types::Type.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      conditional_def_test: d.key?("test") ? LogicalOperandPredicate.from_dynamic!(d["test"]) : nil,
      value:                d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
      selection:            d.key?("selection") ? SelectionOperand.from_dynamic!(d["selection"]) : nil,
      aggregate:            d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                  d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:                d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      legend:               d["legend"] ? Legend.from_dynamic!(d["legend"]) : nil,
      scale:                d.key?("scale") ? Scale.from_dynamic!(d["scale"]) : nil,
      sort:                 d["sort"] ? SortUnion.from_dynamic!(d["sort"]) : nil,
      time_unit:            d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      conditional_def_type: d.key?("type") ? Types::Type[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "test"      => conditional_def_test&.to_dynamic,
      "value"     => value&.to_dynamic,
      "selection" => selection&.to_dynamic,
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "legend"    => legend&.to_dynamic,
      "scale"     => scale&.to_dynamic,
      "sort"      => sort&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => conditional_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ColorCondition < Dry::Struct
  attribute :conditional_predicate_mark_prop_field_def_class, ConditionalPredicateMarkPropFieldDefClass.optional
  attribute :conditional_value_def_array,                     Types.Array(ConditionalValueDef).optional

  def self.from_dynamic!(d)
    begin
      value = ConditionalPredicateMarkPropFieldDefClass.from_dynamic!(d)
      if schema.key(:conditional_predicate_mark_prop_field_def_class).type.right.valid? value
        return new(conditional_predicate_mark_prop_field_def_class: value, conditional_value_def_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| ConditionalValueDef.from_dynamic!(x) }
      if schema.key(:conditional_value_def_array).type.right.valid? value
        return new(conditional_value_def_array: value, conditional_predicate_mark_prop_field_def_class: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if conditional_predicate_mark_prop_field_def_class != nil
      conditional_predicate_mark_prop_field_def_class.to_dynamic
    elsif conditional_value_def_array != nil
      conditional_value_def_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
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
class MarkPropDefWithCondition < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  attribute :condition, Types.Instance(ColorCondition).optional

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
  attribute :field, Types.Instance(Field).optional

  # An object defining properties of the legend.
  # If `null`, the legend for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [legend properties](legend.html) are applied.
  attribute :legend, Legend.optional.optional

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  attribute :scale, Scale.optional

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  attribute :sort, Types.Instance(SortUnion).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :mark_prop_def_with_condition_type, Types::Type.optional

  # A constant value in visual domain.
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:                         d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                               d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      condition:                         d.key?("condition") ? ColorCondition.from_dynamic!(d["condition"]) : nil,
      field:                             d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      legend:                            d["legend"] ? Legend.from_dynamic!(d["legend"]) : nil,
      scale:                             d.key?("scale") ? Scale.from_dynamic!(d["scale"]) : nil,
      sort:                              d["sort"] ? SortUnion.from_dynamic!(d["sort"]) : nil,
      time_unit:                         d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      mark_prop_def_with_condition_type: d.key?("type") ? Types::Type[d["type"]] : nil,
      value:                             d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "condition" => condition&.to_dynamic,
      "field"     => field&.to_dynamic,
      "legend"    => legend&.to_dynamic,
      "scale"     => scale&.to_dynamic,
      "sort"      => sort&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => mark_prop_def_with_condition_type,
      "value"     => value&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object defining properties of a facet's header.
#
# Headers of row / column channels for faceted plots.
class Header < Dry::Struct

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  attribute :header_format, Types::String.optional

  # The rotation angle of the header labels.
  #
  # __Default value:__ `0`.
  attribute :label_angle, Types::Double.constrained(gteq: -360, lteq: 360).optional

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
  attribute :title, Types::String.optional.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      header_format: d.key?("format") ? Types::String[d["format"]] : nil,
      label_angle:   d.key?("labelAngle") ? Types::Double.constrained(gteq: -360, lteq: 360)[d["labelAngle"]] : nil,
      title:         d["title"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "format"     => header_format,
      "labelAngle" => label_angle,
      "title"      => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Horizontal facets for trellis plots.
#
# Vertical facets for trellis plots.
class FacetFieldDef < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # An object defining properties of a facet's header.
  attribute :header, Header.optional

  # Sort order for a facet field.
  # This can be `"ascending"`, `"descending"`.
  attribute :sort, Types::SortEnum.optional.optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :facet_field_def_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:            d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                  d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:                d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      header:               d.key?("header") ? Header.from_dynamic!(d["header"]) : nil,
      sort:                 d["sort"],
      time_unit:            d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      facet_field_def_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "header"    => header&.to_dynamic,
      "sort"      => sort,
      "timeUnit"  => time_unit,
      "type"      => facet_field_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Definition object for a data field, its type and transformation of an encoding channel.
class FieldDef < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :field_def_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:      d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:            d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:          d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      time_unit:      d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      field_def_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => field_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Detail < Dry::Struct
  attribute :field_def,       FieldDef.optional
  attribute :field_def_array, Types.Array(FieldDef).optional

  def self.from_dynamic!(d)
    begin
      value = FieldDef.from_dynamic!(d)
      if schema.key(:field_def).type.right.valid? value
        return new(field_def: value, field_def_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| FieldDef.from_dynamic!(x) }
      if schema.key(:field_def_array).type.right.valid? value
        return new(field_def_array: value, field_def: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if field_def != nil
      field_def.to_dynamic
    elsif field_def_array != nil
      field_def_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConditionalPredicateFieldDefClass < Dry::Struct
  attribute :conditional_def_test, Types.Instance(LogicalOperandPredicate).optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  attribute :selection, Types.Instance(SelectionOperand).optional

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :conditional_def_type, Types::Type.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      conditional_def_test: d.key?("test") ? LogicalOperandPredicate.from_dynamic!(d["test"]) : nil,
      value:                d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
      selection:            d.key?("selection") ? SelectionOperand.from_dynamic!(d["selection"]) : nil,
      aggregate:            d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                  d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:                d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      time_unit:            d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      conditional_def_type: d.key?("type") ? Types::Type[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "test"      => conditional_def_test&.to_dynamic,
      "value"     => value&.to_dynamic,
      "selection" => selection&.to_dynamic,
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => conditional_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HrefCondition < Dry::Struct
  attribute :conditional_predicate_field_def_class, ConditionalPredicateFieldDefClass.optional
  attribute :conditional_value_def_array,           Types.Array(ConditionalValueDef).optional

  def self.from_dynamic!(d)
    begin
      value = ConditionalPredicateFieldDefClass.from_dynamic!(d)
      if schema.key(:conditional_predicate_field_def_class).type.right.valid? value
        return new(conditional_predicate_field_def_class: value, conditional_value_def_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| ConditionalValueDef.from_dynamic!(x) }
      if schema.key(:conditional_value_def_array).type.right.valid? value
        return new(conditional_value_def_array: value, conditional_predicate_field_def_class: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if conditional_predicate_field_def_class != nil
      conditional_predicate_field_def_class.to_dynamic
    elsif conditional_value_def_array != nil
      conditional_value_def_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
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
class DefWithCondition < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  attribute :condition, Types.Instance(HrefCondition).optional

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
  attribute :field, Types.Instance(Field).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :def_with_condition_type, Types::Type.optional

  # A constant value in visual domain.
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:               d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                     d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      condition:               d.key?("condition") ? HrefCondition.from_dynamic!(d["condition"]) : nil,
      field:                   d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      time_unit:               d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      def_with_condition_type: d.key?("type") ? Types::Type[d["type"]] : nil,
      value:                   d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "condition" => condition&.to_dynamic,
      "field"     => field&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => def_with_condition_type,
      "value"     => value&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OrderFieldDef < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # The sort order. One of `"ascending"` (default) or `"descending"`.
  attribute :sort, Types::SortEnum.optional.optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :order_field_def_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:            d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                  d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:                d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      sort:                 d["sort"],
      time_unit:            d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      order_field_def_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "sort"      => sort,
      "timeUnit"  => time_unit,
      "type"      => order_field_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Order < Dry::Struct
  attribute :order_field_def,       OrderFieldDef.optional
  attribute :order_field_def_array, Types.Array(OrderFieldDef).optional

  def self.from_dynamic!(d)
    begin
      value = OrderFieldDef.from_dynamic!(d)
      if schema.key(:order_field_def).type.right.valid? value
        return new(order_field_def: value, order_field_def_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| OrderFieldDef.from_dynamic!(x) }
      if schema.key(:order_field_def_array).type.right.valid? value
        return new(order_field_def_array: value, order_field_def: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if order_field_def != nil
      order_field_def.to_dynamic
    elsif order_field_def_array != nil
      order_field_def_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConditionalPredicateTextFieldDefClass < Dry::Struct
  attribute :conditional_def_test, Types.Instance(LogicalOperandPredicate).optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  # A [selection name](selection.html), or a series of [composed
  # selections](selection.html#compose).
  attribute :selection, Types.Instance(SelectionOperand).optional

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # The [formatting pattern](format.html) for a text field. If not defined, this will be
  # determined automatically.
  attribute :conditional_def_format, Types::String.optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :conditional_def_type, Types::Type.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      conditional_def_test:   d.key?("test") ? LogicalOperandPredicate.from_dynamic!(d["test"]) : nil,
      value:                  d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
      selection:              d.key?("selection") ? SelectionOperand.from_dynamic!(d["selection"]) : nil,
      aggregate:              d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                    d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:                  d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      conditional_def_format: d.key?("format") ? Types::String[d["format"]] : nil,
      time_unit:              d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      conditional_def_type:   d.key?("type") ? Types::Type[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "test"      => conditional_def_test&.to_dynamic,
      "value"     => value&.to_dynamic,
      "selection" => selection&.to_dynamic,
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "format"    => conditional_def_format,
      "timeUnit"  => time_unit,
      "type"      => conditional_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TextCondition < Dry::Struct
  attribute :conditional_predicate_text_field_def_class, ConditionalPredicateTextFieldDefClass.optional
  attribute :conditional_value_def_array,                Types.Array(ConditionalValueDef).optional

  def self.from_dynamic!(d)
    begin
      value = ConditionalPredicateTextFieldDefClass.from_dynamic!(d)
      if schema.key(:conditional_predicate_text_field_def_class).type.right.valid? value
        return new(conditional_predicate_text_field_def_class: value, conditional_value_def_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| ConditionalValueDef.from_dynamic!(x) }
      if schema.key(:conditional_value_def_array).type.right.valid? value
        return new(conditional_value_def_array: value, conditional_predicate_text_field_def_class: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if conditional_predicate_text_field_def_class != nil
      conditional_predicate_text_field_def_class.to_dynamic
    elsif conditional_value_def_array != nil
      conditional_value_def_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
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
class TextDefWithCondition < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

  # One or more value definition(s) with a selection predicate.
  #
  # __Note:__ A field definition's `condition` property can only contain [value
  # definitions](encoding.html#value-def)
  # since Vega-Lite only allows at most one encoded field per encoding channel.
  #
  # A field definition or one or more value definition(s) with a selection predicate.
  attribute :condition, Types.Instance(TextCondition).optional

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
  attribute :field, Types.Instance(Field).optional

  # The [formatting pattern](format.html) for a text field. If not defined, this will be
  # determined automatically.
  attribute :text_def_with_condition_format, Types::String.optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :text_def_with_condition_type, Types::Type.optional

  # A constant value in visual domain.
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:                      d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:                            d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      condition:                      d.key?("condition") ? TextCondition.from_dynamic!(d["condition"]) : nil,
      field:                          d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      text_def_with_condition_format: d.key?("format") ? Types::String[d["format"]] : nil,
      time_unit:                      d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      text_def_with_condition_type:   d.key?("type") ? Types::Type[d["type"]] : nil,
      value:                          d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "condition" => condition&.to_dynamic,
      "field"     => field&.to_dynamic,
      "format"    => text_def_with_condition_format,
      "timeUnit"  => time_unit,
      "type"      => text_def_with_condition_type,
      "value"     => value&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AxisValue < Dry::Struct
  attribute :date_time_class, DateTimeClass.optional
  attribute :double,          Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = DateTimeClass.from_dynamic!(d)
      if schema.key(:date_time_class).type.right.valid? value
        return new(date_time_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, date_time_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time_class != nil
      date_time_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Axis < Dry::Struct

  # A boolean flag indicating if the domain (the axis baseline) should be included as part of
  # the axis.
  #
  # __Default value:__ `true`
  attribute :domain, Types::Bool.optional

  # The formatting pattern for labels. This is D3's [number format
  # pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
  # [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
  # field.
  #
  # See the [format documentation](format.html) for more information.
  #
  # __Default value:__  derived from [numberFormat](config.html#format) config for
  # quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
  attribute :axis_format, Types::String.optional

  # A boolean flag indicating if grid lines should be included as part of the axis
  #
  # __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
  # binned; otherwise, `false`.
  attribute :grid, Types::Bool.optional

  # The rotation angle of the axis labels.
  #
  # __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
  attribute :label_angle, Types::Double.constrained(gteq: -360, lteq: 360).optional

  # Indicates if labels should be hidden if they exceed the axis range. If `false `(the
  # default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
  # they exceed the axis range by more than 1 pixel. If this property is a number, it
  # specifies the pixel tolerance: the maximum amount by which a label bounding box may
  # exceed the axis range.
  #
  # __Default value:__ `false`.
  attribute :label_bound, Types.Instance(Label).optional

  # Indicates if the first and last axis labels should be aligned flush with the scale range.
  # Flush alignment for a horizontal axis will left-align the first label and right-align the
  # last label. For vertical axes, bottom and top text baselines are applied instead. If this
  # property is a number, it also indicates the number of pixels by which to offset the first
  # and last labels; for example, a value of 2 will flush-align the first and last labels and
  # also push them 2 pixels outward from the center of the axis. The additional adjustment
  # can sometimes help the labels better visually group with corresponding axis ticks.
  #
  # __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
  attribute :label_flush, Types.Instance(Label).optional

  # The strategy to use for resolving overlap of axis labels. If `false` (the default), no
  # overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
  # every other label is used (this works well for standard linear axes). If set to
  # `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
  # with the last visible label (this often works better for log-scaled axes).
  #
  # __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
  # scales; otherwise `false`.
  attribute :label_overlap, Types.Instance(LabelOverlapUnion).optional

  # The padding, in pixels, between axis and text labels.
  attribute :label_padding, Types::Double.optional

  # A boolean flag indicating if labels should be included as part of the axis.
  #
  # __Default value:__  `true`.
  attribute :labels, Types::Bool.optional

  # The maximum extent in pixels that axis ticks and labels should use. This determines a
  # maximum offset value for axis titles.
  #
  # __Default value:__ `undefined`.
  attribute :max_extent, Types::Double.optional

  # The minimum extent in pixels that axis ticks and labels should use. This determines a
  # minimum offset value for axis titles.
  #
  # __Default value:__ `30` for y-axis; `undefined` for x-axis.
  attribute :min_extent, Types::Double.optional

  # The offset, in pixels, by which to displace the axis from the edge of the enclosing group
  # or data rectangle.
  #
  # __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
  # `offset` (`0` by default)
  attribute :offset, Types::Double.optional

  # The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
  # orientation can be used to further specialize the axis type (e.g., a y axis oriented for
  # the right edge of the chart).
  #
  # __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
  attribute :orient, Types::TitleOrient.optional

  # The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
  # this sets the axis group x coordinate. For y-axis with left or right orientation, this
  # sets the axis group y coordinate.
  #
  # __Default value__: `0`
  attribute :position, Types::Double.optional

  # A desired number of ticks, for axes visualizing quantitative scales. The resulting number
  # may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
  # underlying scale's range.
  attribute :tick_count, Types::Double.optional

  # Boolean value that determines whether the axis should include ticks.
  attribute :ticks, Types::Bool.optional

  # The size in pixels of axis ticks.
  attribute :tick_size, Types::Double.constrained(gteq: 0).optional

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
  attribute :title, Types::String.optional.optional

  # Max length for axis title if the title is automatically generated from the field's
  # description.
  attribute :title_max_length, Types::Double.optional

  # The padding, in pixels, between title and axis.
  attribute :title_padding, Types::Double.optional

  # Explicitly set the visible axis tick values.
  attribute :values, Types.Array(Types.Instance(AxisValue)).optional

  # A non-positive integer indicating z-index of the axis.
  # If zindex is 0, axes should be drawn behind all chart elements.
  # To put them in front, use `"zindex = 1"`.
  #
  # __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
  # for grids.
  attribute :zindex, Types::Double.constrained(gteq: 0).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      domain:           d.key?("domain") ? Types::Bool[d["domain"]] : nil,
      axis_format:      d.key?("format") ? Types::String[d["format"]] : nil,
      grid:             d.key?("grid") ? Types::Bool[d["grid"]] : nil,
      label_angle:      d.key?("labelAngle") ? Types::Double.constrained(gteq: -360, lteq: 360)[d["labelAngle"]] : nil,
      label_bound:      d.key?("labelBound") ? Label.from_dynamic!(d["labelBound"]) : nil,
      label_flush:      d.key?("labelFlush") ? Label.from_dynamic!(d["labelFlush"]) : nil,
      label_overlap:    d.key?("labelOverlap") ? LabelOverlapUnion.from_dynamic!(d["labelOverlap"]) : nil,
      label_padding:    d.key?("labelPadding") ? Types::Double[d["labelPadding"]] : nil,
      labels:           d.key?("labels") ? Types::Bool[d["labels"]] : nil,
      max_extent:       d.key?("maxExtent") ? Types::Double[d["maxExtent"]] : nil,
      min_extent:       d.key?("minExtent") ? Types::Double[d["minExtent"]] : nil,
      offset:           d.key?("offset") ? Types::Double[d["offset"]] : nil,
      orient:           d.key?("orient") ? Types::TitleOrient[d["orient"]] : nil,
      position:         d.key?("position") ? Types::Double[d["position"]] : nil,
      tick_count:       d.key?("tickCount") ? Types::Double[d["tickCount"]] : nil,
      ticks:            d.key?("ticks") ? Types::Bool[d["ticks"]] : nil,
      tick_size:        d.key?("tickSize") ? Types::Double.constrained(gteq: 0)[d["tickSize"]] : nil,
      title:            d["title"],
      title_max_length: d.key?("titleMaxLength") ? Types::Double[d["titleMaxLength"]] : nil,
      title_padding:    d.key?("titlePadding") ? Types::Double[d["titlePadding"]] : nil,
      values:           d.key?("values") ? d["values"].map { |x| AxisValue.from_dynamic!(x) } : nil,
      zindex:           d.key?("zindex") ? Types::Double.constrained(gteq: 0)[d["zindex"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "domain"         => domain,
      "format"         => axis_format,
      "grid"           => grid,
      "labelAngle"     => label_angle,
      "labelBound"     => label_bound&.to_dynamic,
      "labelFlush"     => label_flush&.to_dynamic,
      "labelOverlap"   => label_overlap&.to_dynamic,
      "labelPadding"   => label_padding,
      "labels"         => labels,
      "maxExtent"      => max_extent,
      "minExtent"      => min_extent,
      "offset"         => offset,
      "orient"         => orient,
      "position"       => position,
      "tickCount"      => tick_count,
      "ticks"          => ticks,
      "tickSize"       => tick_size,
      "title"          => title,
      "titleMaxLength" => title_max_length,
      "titlePadding"   => title_padding,
      "values"         => values&.map { |x| x.to_dynamic },
      "zindex"         => zindex,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
#
# Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
#
# Definition object for a constant value of an encoding channel.
class XClass < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # An object defining properties of axis's gridlines, ticks and labels.
  # If `null`, the axis for the encoding channel will be removed.
  #
  # __Default value:__ If undefined, default [axis properties](axis.html) are applied.
  attribute :axis, Axis.optional.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # An object defining properties of the channel's scale, which is the function that
  # transforms values in the data domain (numbers, dates, strings, etc) to visual values
  # (pixels, colors, sizes) of the encoding channels.
  #
  # __Default value:__ If undefined, default [scale properties](scale.html) are applied.
  attribute :scale, Scale.optional

  # Sort order for the encoded field.
  # Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
  # For fields with discrete domains, `sort` can also be a [sort field definition
  # object](sort.html#sort-field).
  #
  # __Default value:__ `"ascending"`
  attribute :sort, Types.Instance(SortUnion).optional

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
  attribute :stack, Types::StackOffset.optional.optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :def_type, Types::Type.optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate: d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      axis:      d["axis"] ? Axis.from_dynamic!(d["axis"]) : nil,
      bin:       d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:     d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      scale:     d.key?("scale") ? Scale.from_dynamic!(d["scale"]) : nil,
      sort:      d["sort"] ? SortUnion.from_dynamic!(d["sort"]) : nil,
      stack:     d["stack"],
      time_unit: d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      def_type:  d.key?("type") ? Types::Type[d["type"]] : nil,
      value:     d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "axis"      => axis&.to_dynamic,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "scale"     => scale&.to_dynamic,
      "sort"      => sort&.to_dynamic,
      "stack"     => stack,
      "timeUnit"  => time_unit,
      "type"      => def_type,
      "value"     => value&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
#
# Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
#
# Definition object for a data field, its type and transformation of an encoding channel.
#
# Definition object for a constant value of an encoding channel.
class X2Class < Dry::Struct

  # Aggregation function for the field
  # (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
  #
  # __Default value:__ `undefined` (None)
  attribute :aggregate, Types::AggregateOp.optional

  # A flag for binning a `quantitative` field, or [an object defining binning
  # parameters](bin.html#params).
  # If `true`, default [binning parameters](bin.html) will be applied.
  #
  # __Default value:__ `false`
  attribute :bin, Types.Instance(Bin).optional

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
  attribute :field, Types.Instance(Field).optional

  # Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
  # or [a temporal field that gets casted as ordinal](type.html#cast).
  #
  # __Default value:__ `undefined` (None)
  attribute :time_unit, Types::TimeUnit.optional

  # The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
  # `"nominal"`).
  # It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
  # [geographic projection](projection.html) is applied.
  attribute :def_type, Types::Type.optional

  # A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
  # `0` to `1` for opacity).
  attribute :value, Types.Instance(ConditionalValueDefValue).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate: d.key?("aggregate") ? Types::AggregateOp[d["aggregate"]] : nil,
      bin:       d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:     d.key?("field") ? Field.from_dynamic!(d["field"]) : nil,
      time_unit: d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      def_type:  d.key?("type") ? Types::Type[d["type"]] : nil,
      value:     d.key?("value") ? ConditionalValueDefValue.from_dynamic!(d["value"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate" => aggregate,
      "bin"       => bin&.to_dynamic,
      "field"     => field&.to_dynamic,
      "timeUnit"  => time_unit,
      "type"      => def_type,
      "value"     => value&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# A key-value mapping between encoding channels and definition of fields.
class EncodingWithFacet < Dry::Struct

  # Color of the marks – either fill or stroke color based on mark type.
  # By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
  # `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
  #
  # __Default value:__ If undefined, the default color depends on [mark
  # config](config.html#mark)'s `color` property.
  #
  # _Note:_ See the scale documentation for more information about customizing [color
  # scheme](scale.html#scheme).
  attribute :color, MarkPropDefWithCondition.optional

  # Horizontal facets for trellis plots.
  attribute :column, FacetFieldDef.optional

  # Additional levels of detail for grouping data in aggregate views and
  # in line and area marks without mapping data to a specific visual channel.
  attribute :detail, Types.Instance(Detail).optional

  # A URL to load upon mouse click.
  attribute :href, DefWithCondition.optional

  # Opacity of the marks – either can be a value or a range.
  #
  # __Default value:__ If undefined, the default opacity depends on [mark
  # config](config.html#mark)'s `opacity` property.
  attribute :opacity, MarkPropDefWithCondition.optional

  # Stack order for stacked marks or order of data points in line marks for connected scatter
  # plots.
  #
  # __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
  # additional aggregation grouping.
  attribute :order, Types.Instance(Order).optional

  # Vertical facets for trellis plots.
  attribute :row, FacetFieldDef.optional

  # For `point` marks the supported values are
  # `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
  # or `"triangle-down"`, or else a custom SVG path string.
  # For `geoshape` marks it should be a field definition of the geojson data
  #
  # __Default value:__ If undefined, the default shape depends on [mark
  # config](config.html#point-config)'s `shape` property.
  attribute :shape, MarkPropDefWithCondition.optional

  # Size of the mark.
  # - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
  # - For `"bar"` and `"tick"` – the bar and tick's size.
  # - For `"text"` – the text's font size.
  # - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
  attribute :size, MarkPropDefWithCondition.optional

  # Text of the `text` mark.
  attribute :text, TextDefWithCondition.optional

  # The tooltip text to show upon mouse hover.
  attribute :tooltip, TextDefWithCondition.optional

  # X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
  attribute :x, XClass.optional

  # X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  attribute :x2, X2Class.optional

  # Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
  attribute :y, XClass.optional

  # Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  attribute :y2, X2Class.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      color:   d.key?("color") ? MarkPropDefWithCondition.from_dynamic!(d["color"]) : nil,
      column:  d.key?("column") ? FacetFieldDef.from_dynamic!(d["column"]) : nil,
      detail:  d.key?("detail") ? Detail.from_dynamic!(d["detail"]) : nil,
      href:    d.key?("href") ? DefWithCondition.from_dynamic!(d["href"]) : nil,
      opacity: d.key?("opacity") ? MarkPropDefWithCondition.from_dynamic!(d["opacity"]) : nil,
      order:   d.key?("order") ? Order.from_dynamic!(d["order"]) : nil,
      row:     d.key?("row") ? FacetFieldDef.from_dynamic!(d["row"]) : nil,
      shape:   d.key?("shape") ? MarkPropDefWithCondition.from_dynamic!(d["shape"]) : nil,
      size:    d.key?("size") ? MarkPropDefWithCondition.from_dynamic!(d["size"]) : nil,
      text:    d.key?("text") ? TextDefWithCondition.from_dynamic!(d["text"]) : nil,
      tooltip: d.key?("tooltip") ? TextDefWithCondition.from_dynamic!(d["tooltip"]) : nil,
      x:       d.key?("x") ? XClass.from_dynamic!(d["x"]) : nil,
      x2:      d.key?("x2") ? X2Class.from_dynamic!(d["x2"]) : nil,
      y:       d.key?("y") ? XClass.from_dynamic!(d["y"]) : nil,
      y2:      d.key?("y2") ? X2Class.from_dynamic!(d["y2"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "color"   => color&.to_dynamic,
      "column"  => column&.to_dynamic,
      "detail"  => detail&.to_dynamic,
      "href"    => href&.to_dynamic,
      "opacity" => opacity&.to_dynamic,
      "order"   => order&.to_dynamic,
      "row"     => row&.to_dynamic,
      "shape"   => shape&.to_dynamic,
      "size"    => size&.to_dynamic,
      "text"    => text&.to_dynamic,
      "tooltip" => tooltip&.to_dynamic,
      "x"       => x&.to_dynamic,
      "x2"      => x2&.to_dynamic,
      "y"       => y&.to_dynamic,
      "y2"      => y2&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object that describes mappings between `row` and `column` channels and their field
# definitions.
class FacetMapping < Dry::Struct

  # Horizontal facets for trellis plots.
  attribute :column, FacetFieldDef.optional

  # Vertical facets for trellis plots.
  attribute :row, FacetFieldDef.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      column: d.key?("column") ? FacetFieldDef.from_dynamic!(d["column"]) : nil,
      row:    d.key?("row") ? FacetFieldDef.from_dynamic!(d["row"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "column" => column&.to_dynamic,
      "row"    => row&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# A key-value mapping between encoding channels and definition of fields.
class EncodingClass < Dry::Struct

  # Color of the marks – either fill or stroke color based on mark type.
  # By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
  # `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
  #
  # __Default value:__ If undefined, the default color depends on [mark
  # config](config.html#mark)'s `color` property.
  #
  # _Note:_ See the scale documentation for more information about customizing [color
  # scheme](scale.html#scheme).
  attribute :color, MarkPropDefWithCondition.optional

  # Additional levels of detail for grouping data in aggregate views and
  # in line and area marks without mapping data to a specific visual channel.
  attribute :detail, Types.Instance(Detail).optional

  # A URL to load upon mouse click.
  attribute :href, DefWithCondition.optional

  # Opacity of the marks – either can be a value or a range.
  #
  # __Default value:__ If undefined, the default opacity depends on [mark
  # config](config.html#mark)'s `opacity` property.
  attribute :opacity, MarkPropDefWithCondition.optional

  # Stack order for stacked marks or order of data points in line marks for connected scatter
  # plots.
  #
  # __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
  # additional aggregation grouping.
  attribute :order, Types.Instance(Order).optional

  # For `point` marks the supported values are
  # `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
  # or `"triangle-down"`, or else a custom SVG path string.
  # For `geoshape` marks it should be a field definition of the geojson data
  #
  # __Default value:__ If undefined, the default shape depends on [mark
  # config](config.html#point-config)'s `shape` property.
  attribute :shape, MarkPropDefWithCondition.optional

  # Size of the mark.
  # - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
  # - For `"bar"` and `"tick"` – the bar and tick's size.
  # - For `"text"` – the text's font size.
  # - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
  attribute :size, MarkPropDefWithCondition.optional

  # Text of the `text` mark.
  attribute :text, TextDefWithCondition.optional

  # The tooltip text to show upon mouse hover.
  attribute :tooltip, TextDefWithCondition.optional

  # X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
  attribute :x, XClass.optional

  # X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  attribute :x2, X2Class.optional

  # Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
  attribute :y, XClass.optional

  # Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
  attribute :y2, X2Class.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      color:   d.key?("color") ? MarkPropDefWithCondition.from_dynamic!(d["color"]) : nil,
      detail:  d.key?("detail") ? Detail.from_dynamic!(d["detail"]) : nil,
      href:    d.key?("href") ? DefWithCondition.from_dynamic!(d["href"]) : nil,
      opacity: d.key?("opacity") ? MarkPropDefWithCondition.from_dynamic!(d["opacity"]) : nil,
      order:   d.key?("order") ? Order.from_dynamic!(d["order"]) : nil,
      shape:   d.key?("shape") ? MarkPropDefWithCondition.from_dynamic!(d["shape"]) : nil,
      size:    d.key?("size") ? MarkPropDefWithCondition.from_dynamic!(d["size"]) : nil,
      text:    d.key?("text") ? TextDefWithCondition.from_dynamic!(d["text"]) : nil,
      tooltip: d.key?("tooltip") ? TextDefWithCondition.from_dynamic!(d["tooltip"]) : nil,
      x:       d.key?("x") ? XClass.from_dynamic!(d["x"]) : nil,
      x2:      d.key?("x2") ? X2Class.from_dynamic!(d["x2"]) : nil,
      y:       d.key?("y") ? XClass.from_dynamic!(d["y"]) : nil,
      y2:      d.key?("y2") ? X2Class.from_dynamic!(d["y2"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "color"   => color&.to_dynamic,
      "detail"  => detail&.to_dynamic,
      "href"    => href&.to_dynamic,
      "opacity" => opacity&.to_dynamic,
      "order"   => order&.to_dynamic,
      "shape"   => shape&.to_dynamic,
      "size"    => size&.to_dynamic,
      "text"    => text&.to_dynamic,
      "tooltip" => tooltip&.to_dynamic,
      "x"       => x&.to_dynamic,
      "x2"      => x2&.to_dynamic,
      "y"       => y&.to_dynamic,
      "y2"      => y2&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# All types of primitive marks.
#
# The mark type.
# One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
# `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
module Mark
  Area     = "area"
  Bar      = "bar"
  Line     = "line"
  Point    = "point"
  Text     = "text"
  Tick     = "tick"
  Rect     = "rect"
  Rule     = "rule"
  Circle   = "circle"
  Square   = "square"
  Geoshape = "geoshape"
end

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
class Style < Dry::Struct
  attribute :string,       Types::String.optional
  attribute :string_array, Types.Array(Types::String).optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, string_array: nil)
    end
    if schema.key(:string_array).type.right.valid? d
      return new(string_array: d, string: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif string_array != nil
      string_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MarkDef < Dry::Struct

  # The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
  attribute :align, Types::HorizontalAlign.optional

  # The rotation angle of the text, in degrees.
  attribute :angle, Types::Double.constrained(gteq: 0, lteq: 360).optional

  # The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
  #
  # __Default value:__ `"middle"`
  attribute :baseline, Types::VerticalAlign.optional

  # Whether a mark be clipped to the enclosing group’s width and height.
  attribute :clip, Types::Bool.optional

  # Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
  # will override `color`.
  #
  # __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :color, Types::String.optional

  # The mouse cursor used over the mark. Any valid [CSS cursor
  # type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
  attribute :cursor, Types::Cursor.optional

  # The horizontal offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dx, Types::Double.optional

  # The vertical offset, in pixels, between the text label and its anchor point. The offset
  # is applied after rotation by the _angle_ property.
  attribute :dy, Types::Double.optional

  # Default Fill Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :fill, Types::String.optional

  # Whether the mark's color should be used as fill color instead of stroke color.
  #
  # __Default value:__ `true` for all marks except `point` and `false` for `point`.
  #
  # __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
  #
  # __Note:__ This property cannot be used in a [style config](mark.html#style-config).
  attribute :filled, Types::Bool.optional

  # The fill opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :fill_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The typeface to set the text in (e.g., `"Helvetica Neue"`).
  attribute :font, Types::String.optional

  # The font size, in pixels.
  attribute :font_size, Types::Double.constrained(gteq: 0).optional

  # The font style (e.g., `"italic"`).
  attribute :font_style, Types::FontStyle.optional

  # The font weight (e.g., `"bold"`).
  attribute :font_weight, Types.Instance(FontWeightUnion).optional

  # A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
  attribute :href, Types::String.optional

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
  attribute :interpolate, Types::Interpolate.optional

  # The maximum length of the text mark in pixels (default 0, indicating no limit). The text
  # value will be automatically truncated if the rendered size exceeds the limit.
  attribute :limit, Types::Double.optional

  # The overall opacity (value between [0,1]).
  #
  # __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
  # `square` marks or layered `bar` charts and `1` otherwise.
  attribute :opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The orientation of a non-stacked bar, tick, area, and line charts.
  # The value is either horizontal (default) or vertical.
  # - For bar, rule and tick, this determines whether the size of the bar and tick
  # should be applied to x or y dimension.
  # - For area, this property determines the orient property of the Vega output.
  # - For line, this property determines the sort order of the points in the line
  # if `config.sortLineBy` is not specified.
  # For stacked charts, this is always determined by the orientation of the stack;
  # therefore explicitly specified value will be ignored.
  attribute :orient, Types::Orient.optional

  # Polar coordinate radial offset, in pixels, of the text label from the origin determined
  # by the `x` and `y` properties.
  attribute :radius, Types::Double.constrained(gteq: 0).optional

  # The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
  # `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
  #
  # __Default value:__ `"circle"`
  attribute :shape, Types::String.optional

  # The pixel area each the point/circle/square.
  # For example: in the case of circles, the radius is determined in part by the square root
  # of the size value.
  #
  # __Default value:__ `30`
  attribute :size, Types::Double.constrained(gteq: 0).optional

  # Default Stroke Color.  This has higher precedence than config.color
  #
  # __Default value:__ (None)
  attribute :stroke, Types::String.optional

  # An array of alternating stroke, space lengths for creating dashed or dotted lines.
  attribute :stroke_dash, Types.Array(Types::Double).optional

  # The offset (in pixels) into which to begin drawing with the stroke dash array.
  attribute :stroke_dash_offset, Types::Double.optional

  # The stroke opacity (value between [0,1]).
  #
  # __Default value:__ `1`
  attribute :stroke_opacity, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # The stroke width, in pixels.
  attribute :stroke_width, Types::Double.constrained(gteq: 0).optional

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
  attribute :style, Types.Instance(Style).optional

  # Depending on the interpolation type, sets the tension parameter (for line and area marks).
  attribute :tension, Types::Double.constrained(gteq: 0, lteq: 1).optional

  # Placeholder text if the `text` channel is not specified
  attribute :text, Types::String.optional

  # Polar coordinate angle, in radians, of the text label from the origin determined by the
  # `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
  # `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
  # indicating "north".
  attribute :theta, Types::Double.optional

  # The mark type.
  # One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
  # `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
  attribute :mark_def_type, Types::Mark

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:              d.key?("align") ? Types::HorizontalAlign[d["align"]] : nil,
      angle:              d.key?("angle") ? Types::Double.constrained(gteq: 0, lteq: 360)[d["angle"]] : nil,
      baseline:           d.key?("baseline") ? Types::VerticalAlign[d["baseline"]] : nil,
      clip:               d.key?("clip") ? Types::Bool[d["clip"]] : nil,
      color:              d.key?("color") ? Types::String[d["color"]] : nil,
      cursor:             d.key?("cursor") ? Types::Cursor[d["cursor"]] : nil,
      dx:                 d.key?("dx") ? Types::Double[d["dx"]] : nil,
      dy:                 d.key?("dy") ? Types::Double[d["dy"]] : nil,
      fill:               d.key?("fill") ? Types::String[d["fill"]] : nil,
      filled:             d.key?("filled") ? Types::Bool[d["filled"]] : nil,
      fill_opacity:       d.key?("fillOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["fillOpacity"]] : nil,
      font:               d.key?("font") ? Types::String[d["font"]] : nil,
      font_size:          d.key?("fontSize") ? Types::Double.constrained(gteq: 0)[d["fontSize"]] : nil,
      font_style:         d.key?("fontStyle") ? Types::FontStyle[d["fontStyle"]] : nil,
      font_weight:        d.key?("fontWeight") ? FontWeightUnion.from_dynamic!(d["fontWeight"]) : nil,
      href:               d.key?("href") ? Types::String[d["href"]] : nil,
      interpolate:        d.key?("interpolate") ? Types::Interpolate[d["interpolate"]] : nil,
      limit:              d.key?("limit") ? Types::Double[d["limit"]] : nil,
      opacity:            d.key?("opacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["opacity"]] : nil,
      orient:             d.key?("orient") ? Types::Orient[d["orient"]] : nil,
      radius:             d.key?("radius") ? Types::Double.constrained(gteq: 0)[d["radius"]] : nil,
      shape:              d.key?("shape") ? Types::String[d["shape"]] : nil,
      size:               d.key?("size") ? Types::Double.constrained(gteq: 0)[d["size"]] : nil,
      stroke:             d.key?("stroke") ? Types::String[d["stroke"]] : nil,
      stroke_dash:        d.key?("strokeDash") ? d["strokeDash"].map { |x| Types::Double[x] } : nil,
      stroke_dash_offset: d.key?("strokeDashOffset") ? Types::Double[d["strokeDashOffset"]] : nil,
      stroke_opacity:     d.key?("strokeOpacity") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["strokeOpacity"]] : nil,
      stroke_width:       d.key?("strokeWidth") ? Types::Double.constrained(gteq: 0)[d["strokeWidth"]] : nil,
      style:              d.key?("style") ? Style.from_dynamic!(d["style"]) : nil,
      tension:            d.key?("tension") ? Types::Double.constrained(gteq: 0, lteq: 1)[d["tension"]] : nil,
      text:               d.key?("text") ? Types::String[d["text"]] : nil,
      theta:              d.key?("theta") ? Types::Double[d["theta"]] : nil,
      mark_def_type:      d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"            => align,
      "angle"            => angle,
      "baseline"         => baseline,
      "clip"             => clip,
      "color"            => color,
      "cursor"           => cursor,
      "dx"               => dx,
      "dy"               => dy,
      "fill"             => fill,
      "filled"           => filled,
      "fillOpacity"      => fill_opacity,
      "font"             => font,
      "fontSize"         => font_size,
      "fontStyle"        => font_style,
      "fontWeight"       => font_weight&.to_dynamic,
      "href"             => href,
      "interpolate"      => interpolate,
      "limit"            => limit,
      "opacity"          => opacity,
      "orient"           => orient,
      "radius"           => radius,
      "shape"            => shape,
      "size"             => size,
      "stroke"           => stroke,
      "strokeDash"       => stroke_dash,
      "strokeDashOffset" => stroke_dash_offset,
      "strokeOpacity"    => stroke_opacity,
      "strokeWidth"      => stroke_width,
      "style"            => style&.to_dynamic,
      "tension"          => tension,
      "text"             => text,
      "theta"            => theta,
      "type"             => mark_def_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
# `"line"`,
# * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
# object](mark.html#mark-def).
class AnyMark < Dry::Struct
  attribute :enum_1,   Types::Mark.optional
  attribute :mark_def, MarkDef.optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, mark_def: nil)
    end
    begin
      value = MarkDef.from_dynamic!(d)
      if schema.key(:mark_def).type.right.valid? value
        return new(mark_def: value, enum_1: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif mark_def != nil
      mark_def.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object defining properties of geographic projection.
#
# Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
# more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
class Projection < Dry::Struct

  # Sets the projection’s center to the specified center, a two-element array of longitude
  # and latitude in degrees.
  #
  # __Default value:__ `[0, 0]`
  attribute :center, Types.Array(Types::Double).optional

  # Sets the projection’s clipping circle radius to the specified angle in degrees. If
  # `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
  # than small-circle clipping.
  attribute :clip_angle, Types::Double.optional

  # Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
  # bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
  # the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
  # viewport clipping is performed.
  attribute :clip_extent, Types.Array(Types.Array(Types::Double)).optional

  attribute :coefficient, Types::Double.optional
  attribute :distance,    Types::Double.optional
  attribute :fraction,    Types::Double.optional
  attribute :lobes,       Types::Double.optional
  attribute :parallel,    Types::Double.optional

  # Sets the threshold for the projection’s [adaptive
  # resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
  # value corresponds to the [Douglas–Peucker
  # distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
  # If precision is not specified, returns the projection’s current resampling precision
  # which defaults to `√0.5 ≅ 0.70710…`.
  attribute :precision, Types::Hash.meta(of: Types.Instance(TitleFontWeight)).optional

  attribute :radius, Types::Double.optional
  attribute :ratio,  Types::Double.optional

  # Sets the projection’s three-axis rotation to the specified angles, which must be a two-
  # or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
  # angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
  #
  # __Default value:__ `[0, 0, 0]`
  attribute :rotate, Types.Array(Types::Double).optional

  attribute :spacing, Types::Double.optional
  attribute :tilt,    Types::Double.optional

  # The cartographic projection to use. This value is case-insensitive, for example
  # `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
  # projection types [in the
  # documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
  #
  # __Default value:__ `mercator`
  attribute :projection_type, Types::VGProjectionType.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      center:          d.key?("center") ? d["center"].map { |x| Types::Double[x] } : nil,
      clip_angle:      d.key?("clipAngle") ? Types::Double[d["clipAngle"]] : nil,
      clip_extent:     d.key?("clipExtent") ? d["clipExtent"].map { |x| x.map { |x| Types::Double[x] } } : nil,
      coefficient:     d.key?("coefficient") ? Types::Double[d["coefficient"]] : nil,
      distance:        d.key?("distance") ? Types::Double[d["distance"]] : nil,
      fraction:        d.key?("fraction") ? Types::Double[d["fraction"]] : nil,
      lobes:           d.key?("lobes") ? Types::Double[d["lobes"]] : nil,
      parallel:        d.key?("parallel") ? Types::Double[d["parallel"]] : nil,
      precision:       d.key?("precision") ? Types::Hash[d["precision"]].map { |k, v| [k, TitleFontWeight.from_dynamic!(v)] }.to_h : nil,
      radius:          d.key?("radius") ? Types::Double[d["radius"]] : nil,
      ratio:           d.key?("ratio") ? Types::Double[d["ratio"]] : nil,
      rotate:          d.key?("rotate") ? d["rotate"].map { |x| Types::Double[x] } : nil,
      spacing:         d.key?("spacing") ? Types::Double[d["spacing"]] : nil,
      tilt:            d.key?("tilt") ? Types::Double[d["tilt"]] : nil,
      projection_type: d.key?("type") ? Types::VGProjectionType[d["type"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "center"      => center,
      "clipAngle"   => clip_angle,
      "clipExtent"  => clip_extent,
      "coefficient" => coefficient,
      "distance"    => distance,
      "fraction"    => fraction,
      "lobes"       => lobes,
      "parallel"    => parallel,
      "precision"   => precision&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "radius"      => radius,
      "ratio"       => ratio,
      "rotate"      => rotate,
      "spacing"     => spacing,
      "tilt"        => tilt,
      "type"        => projection_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ResolveMode
  Independent = "independent"
  Shared      = "shared"
end

class AxisResolveMap < Dry::Struct
  attribute :x, Types::ResolveMode.optional
  attribute :y, Types::ResolveMode.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      x: d.key?("x") ? Types::ResolveMode[d["x"]] : nil,
      y: d.key?("y") ? Types::ResolveMode[d["y"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "x" => x,
      "y" => y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LegendResolveMap < Dry::Struct
  attribute :color,   Types::ResolveMode.optional
  attribute :opacity, Types::ResolveMode.optional
  attribute :shape,   Types::ResolveMode.optional
  attribute :size,    Types::ResolveMode.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      color:   d.key?("color") ? Types::ResolveMode[d["color"]] : nil,
      opacity: d.key?("opacity") ? Types::ResolveMode[d["opacity"]] : nil,
      shape:   d.key?("shape") ? Types::ResolveMode[d["shape"]] : nil,
      size:    d.key?("size") ? Types::ResolveMode[d["size"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "color"   => color,
      "opacity" => opacity,
      "shape"   => shape,
      "size"    => size,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ScaleResolveMap < Dry::Struct
  attribute :color,   Types::ResolveMode.optional
  attribute :opacity, Types::ResolveMode.optional
  attribute :shape,   Types::ResolveMode.optional
  attribute :size,    Types::ResolveMode.optional
  attribute :x,       Types::ResolveMode.optional
  attribute :y,       Types::ResolveMode.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      color:   d.key?("color") ? Types::ResolveMode[d["color"]] : nil,
      opacity: d.key?("opacity") ? Types::ResolveMode[d["opacity"]] : nil,
      shape:   d.key?("shape") ? Types::ResolveMode[d["shape"]] : nil,
      size:    d.key?("size") ? Types::ResolveMode[d["size"]] : nil,
      x:       d.key?("x") ? Types::ResolveMode[d["x"]] : nil,
      y:       d.key?("y") ? Types::ResolveMode[d["y"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "color"   => color,
      "opacity" => opacity,
      "shape"   => shape,
      "size"    => size,
      "x"       => x,
      "y"       => y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
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
class Resolve < Dry::Struct
  attribute :axis,   AxisResolveMap.optional
  attribute :legend, LegendResolveMap.optional
  attribute :scale,  ScaleResolveMap.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      axis:   d.key?("axis") ? AxisResolveMap.from_dynamic!(d["axis"]) : nil,
      legend: d.key?("legend") ? LegendResolveMap.from_dynamic!(d["legend"]) : nil,
      scale:  d.key?("scale") ? ScaleResolveMap.from_dynamic!(d["scale"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "axis"   => axis&.to_dynamic,
      "legend" => legend&.to_dynamic,
      "scale"  => scale&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BindUnion < Dry::Struct
  attribute :enum_1,         Types::BindEnum.optional
  attribute :vg_binding_map, Types::Hash.meta(of: VGBinding).optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, vg_binding_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, VGBinding.from_dynamic!(v)] }.to_h
      if schema.key(:vg_binding_map).type.right.valid? value
        return new(vg_binding_map: value, enum_1: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif vg_binding_map != nil
      vg_binding_map.map { |k, v| [k, v.to_dynamic] }.to_h
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module SelectionDefType
  Single   = "single"
  Multi    = "multi"
  Interval = "interval"
end

class SelectionDef < Dry::Struct

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
  attribute :bind, Types.Instance(BindUnion).optional

  # By default, all data values are considered to lie within an empty selection.
  # When set to `none`, empty selections contain no data values.
  attribute :empty, Types::Empty.optional

  # An array of encoding channels. The corresponding data field values
  # must match for a data tuple to fall within the selection.
  attribute :encodings, Types.Array(Types::SingleDefChannel).optional

  # An array of field names whose values must match for a data tuple to
  # fall within the selection.
  attribute :fields, Types.Array(Types::String).optional

  # When true, an invisible voronoi diagram is computed to accelerate discrete
  # selection. The data value _nearest_ the mouse cursor is added to the selection.
  #
  # See the [nearest transform](nearest.html) documentation for more information.
  attribute :nearest, Types::Bool.optional

  # A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
  # selector) that triggers the selection.
  # For interval selections, the event stream must specify a [start and
  # end](https://vega.github.io/vega/docs/event-streams/#between-filters).
  attribute :on, Types::Any.optional

  # With layered and multi-view displays, a strategy that determines how
  # selections' data queries are resolved when applied in a filter transform,
  # conditional encoding rule, or scale domain.
  attribute :resolve, Types::SelectionResolution.optional

  attribute :selection_def_type, Types::SelectionDefType

  # Controls whether data values should be toggled or only ever inserted into
  # multi selections. Can be `true`, `false` (for insertion only), or a
  # [Vega expression](https://vega.github.io/vega/docs/expressions/).
  #
  # __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
  # data values are toggled when a user interacts with the shift-key pressed).
  #
  # See the [toggle transform](toggle.html) documentation for more information.
  attribute :toggle, Types.Instance(Translate).optional

  # An interval selection also adds a rectangle mark to depict the
  # extents of the interval. The `mark` property can be used to customize the
  # appearance of the mark.
  attribute :mark, BrushConfig.optional

  # When truthy, allows a user to interactively move an interval selection
  # back-and-forth. Can be `true`, `false` (to disable panning), or a
  # [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
  # which must include a start and end event to trigger continuous panning.
  #
  # __Default value:__ `true`, which corresponds to
  # `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
  # clicks and dragging within an interval selection to reposition it.
  attribute :translate, Types.Instance(Translate).optional

  # When truthy, allows a user to interactively resize an interval selection.
  # Can be `true`, `false` (to disable zooming), or a [Vega event stream
  # definition](https://vega.github.io/vega/docs/event-streams/). Currently,
  # only `wheel` events are supported.
  #
  #
  # __Default value:__ `true`, which corresponds to `wheel!`.
  attribute :zoom, Types.Instance(Translate).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bind:               d.key?("bind") ? BindUnion.from_dynamic!(d["bind"]) : nil,
      empty:              d.key?("empty") ? Types::Empty[d["empty"]] : nil,
      encodings:          d.key?("encodings") ? d["encodings"].map { |x| Types::SingleDefChannel[x] } : nil,
      fields:             d.key?("fields") ? d["fields"].map { |x| Types::String[x] } : nil,
      nearest:            d.key?("nearest") ? Types::Bool[d["nearest"]] : nil,
      on:                 d["on"],
      resolve:            d.key?("resolve") ? Types::SelectionResolution[d["resolve"]] : nil,
      selection_def_type: d.fetch("type"),
      toggle:             d.key?("toggle") ? Translate.from_dynamic!(d["toggle"]) : nil,
      mark:               d.key?("mark") ? BrushConfig.from_dynamic!(d["mark"]) : nil,
      translate:          d.key?("translate") ? Translate.from_dynamic!(d["translate"]) : nil,
      zoom:               d.key?("zoom") ? Translate.from_dynamic!(d["zoom"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bind"      => bind&.to_dynamic,
      "empty"     => empty,
      "encodings" => encodings,
      "fields"    => fields,
      "nearest"   => nearest,
      "on"        => on,
      "resolve"   => resolve,
      "type"      => selection_def_type,
      "toggle"    => toggle&.to_dynamic,
      "mark"      => mark&.to_dynamic,
      "translate" => translate&.to_dynamic,
      "zoom"      => zoom&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TitleParams < Dry::Struct

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
  attribute :anchor, Types::Anchor.optional

  # The orthogonal offset in pixels by which to displace the title from its position along
  # the edge of the chart.
  attribute :offset, Types::Double.optional

  # The orientation of the title relative to the chart. One of `"top"` (the default),
  # `"bottom"`, `"left"`, or `"right"`.
  attribute :orient, Types::TitleOrient.optional

  # A [mark style property](config.html#style) to apply to the title text mark.
  #
  # __Default value:__ `"group-title"`.
  attribute :style, Types.Instance(Style).optional

  # The title text.
  attribute :text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      anchor: d.key?("anchor") ? Types::Anchor[d["anchor"]] : nil,
      offset: d.key?("offset") ? Types::Double[d["offset"]] : nil,
      orient: d.key?("orient") ? Types::TitleOrient[d["orient"]] : nil,
      style:  d.key?("style") ? Style.from_dynamic!(d["style"]) : nil,
      text:   d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "anchor" => anchor,
      "offset" => offset,
      "orient" => orient,
      "style"  => style&.to_dynamic,
      "text"   => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Title < Dry::Struct
  attribute :string,       Types::String.optional
  attribute :title_params, TitleParams.optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, title_params: nil)
    end
    begin
      value = TitleParams.from_dynamic!(d)
      if schema.key(:title_params).type.right.valid? value
        return new(title_params: value, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif title_params != nil
      title_params.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AggregatedFieldDef < Dry::Struct

  # The output field names to use for each aggregated field.
  attribute :as, Types::String

  # The data field for which to compute aggregate function.
  attribute :field, Types::String

  # The aggregation operations to apply to the fields, such as sum, average or count.
  # See the [full list of supported aggregation
  # operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
  # for more information.
  attribute :op, Types::AggregateOp

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      as:    d.fetch("as"),
      field: d.fetch("field"),
      op:    d.fetch("op"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "as"    => as,
      "field" => field,
      "op"    => op,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Secondary data reference.
class LookupData < Dry::Struct

  # Secondary data source to lookup in.
  attribute :data, DataClass

  # Fields in foreign data to lookup.
  # If not specified, the entire object is queried.
  attribute :fields, Types.Array(Types::String).optional

  # Key in data to lookup.
  attribute :key, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:   DataClass.from_dynamic!(d.fetch("data")),
      fields: d.key?("fields") ? d["fields"].map { |x| Types::String[x] } : nil,
      key:    d.fetch("key"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"   => data.to_dynamic,
      "fields" => fields,
      "key"    => key,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Transform < Dry::Struct

  # The `filter` property must be one of the predicate definitions:
  # (1) an [expression](types.html#expression) string,
  # where `datum` can be used to refer to the current data object;
  # (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
  # [range predicate](filter.html#range-predicate), [one-of
  # predicate](filter.html#one-of-predicate);
  # (3) a [selection predicate](filter.html#selection-predicate);
  # or (4) a logical operand that combines (1), (2), or (3).
  attribute :filter, Types.Instance(LogicalOperandPredicate).optional

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
  attribute :as, Types.Instance(Style).optional

  # A [expression](types.html#expression) string. Use the variable `datum` to refer to the
  # current data object.
  attribute :calculate, Types::String.optional

  # The default value to use if lookup fails.
  #
  # __Default value:__ `null`
  attribute :transform_default, Types::String.optional

  # Secondary data reference.
  attribute :from, LookupData.optional

  # Key in primary data source.
  attribute :lookup, Types::String.optional

  # An object indicating bin properties, or simply `true` for using default bin parameters.
  attribute :bin, Types.Instance(Bin).optional

  # The data field to bin.
  #
  # The data field to apply time unit.
  attribute :field, Types::String.optional

  # The timeUnit.
  attribute :time_unit, Types::TimeUnit.optional

  # Array of objects that define fields to aggregate.
  attribute :aggregate, Types.Array(AggregatedFieldDef).optional

  # The data fields to group by. If not specified, a single group containing all data objects
  # will be used.
  attribute :groupby, Types.Array(Types::String).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      filter:            d.key?("filter") ? LogicalOperandPredicate.from_dynamic!(d["filter"]) : nil,
      as:                d.key?("as") ? Style.from_dynamic!(d["as"]) : nil,
      calculate:         d.key?("calculate") ? Types::String[d["calculate"]] : nil,
      transform_default: d.key?("default") ? Types::String[d["default"]] : nil,
      from:              d.key?("from") ? LookupData.from_dynamic!(d["from"]) : nil,
      lookup:            d.key?("lookup") ? Types::String[d["lookup"]] : nil,
      bin:               d.key?("bin") ? Bin.from_dynamic!(d["bin"]) : nil,
      field:             d.key?("field") ? Types::String[d["field"]] : nil,
      time_unit:         d.key?("timeUnit") ? Types::TimeUnit[d["timeUnit"]] : nil,
      aggregate:         d.key?("aggregate") ? d["aggregate"].map { |x| AggregatedFieldDef.from_dynamic!(x) } : nil,
      groupby:           d.key?("groupby") ? d["groupby"].map { |x| Types::String[x] } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "filter"    => filter&.to_dynamic,
      "as"        => as&.to_dynamic,
      "calculate" => calculate,
      "default"   => transform_default,
      "from"      => from&.to_dynamic,
      "lookup"    => lookup,
      "bin"       => bin&.to_dynamic,
      "field"     => field,
      "timeUnit"  => time_unit,
      "aggregate" => aggregate&.map { |x| x.to_dynamic },
      "groupby"   => groupby,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Unit spec that can have a composite mark.
class LayerSpec < Dry::Struct

  # An object describing the data source
  attribute :data, DataClass.optional

  # Description of this mark for commenting purpose.
  attribute :description, Types::String.optional

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
  attribute :height, Types::Double.optional

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  attribute :layer, Types.Array(LayerSpec).optional

  # Name of the visualization for later reference.
  attribute :layer_spec_name, Types::String.optional

  # Scale, axis, and legend resolutions for layers.
  attribute :resolve, Resolve.optional

  # Title for the plot.
  attribute :title, Types.Instance(Title).optional

  # An array of data transformations such as filter and new field calculation.
  attribute :transform, Types.Array(Transform).optional

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
  attribute :width, Types::Double.optional

  # A key-value mapping between encoding channels and definition of fields.
  attribute :encoding, EncodingClass.optional

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  attribute :mark, Types.Instance(AnyMark).optional

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  attribute :projection, Projection.optional

  # A key-value mapping between selection names and definitions.
  attribute :selection, Types::Hash.meta(of: SelectionDef).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:            d.key?("data") ? DataClass.from_dynamic!(d["data"]) : nil,
      description:     d.key?("description") ? Types::String[d["description"]] : nil,
      height:          d.key?("height") ? Types::Double[d["height"]] : nil,
      layer:           d.key?("layer") ? d["layer"].map { |x| LayerSpec.from_dynamic!(x) } : nil,
      layer_spec_name: d.key?("name") ? Types::String[d["name"]] : nil,
      resolve:         d.key?("resolve") ? Resolve.from_dynamic!(d["resolve"]) : nil,
      title:           d.key?("title") ? Title.from_dynamic!(d["title"]) : nil,
      transform:       d.key?("transform") ? d["transform"].map { |x| Transform.from_dynamic!(x) } : nil,
      width:           d.key?("width") ? Types::Double[d["width"]] : nil,
      encoding:        d.key?("encoding") ? EncodingClass.from_dynamic!(d["encoding"]) : nil,
      mark:            d.key?("mark") ? AnyMark.from_dynamic!(d["mark"]) : nil,
      projection:      d.key?("projection") ? Projection.from_dynamic!(d["projection"]) : nil,
      selection:       d.key?("selection") ? Types::Hash[d["selection"]].map { |k, v| [k, SelectionDef.from_dynamic!(v)] }.to_h : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"        => data&.to_dynamic,
      "description" => description,
      "height"      => height,
      "layer"       => layer&.map { |x| x.to_dynamic },
      "name"        => layer_spec_name,
      "resolve"     => resolve&.to_dynamic,
      "title"       => title&.to_dynamic,
      "transform"   => transform&.map { |x| x.to_dynamic },
      "width"       => width,
      "encoding"    => encoding&.to_dynamic,
      "mark"        => mark&.to_dynamic,
      "projection"  => projection&.to_dynamic,
      "selection"   => selection&.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An object that describes what fields should be repeated into views that are laid out as a
# `row` or `column`.
class Repeat < Dry::Struct

  # Horizontal repeated views.
  attribute :column, Types.Array(Types::String).optional

  # Vertical repeated views.
  attribute :row, Types.Array(Types::String).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      column: d.key?("column") ? d["column"].map { |x| Types::String[x] } : nil,
      row:    d.key?("row") ? d["row"].map { |x| Types::String[x] } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "column" => column,
      "row"    => row,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# Unit spec that can have a composite mark.
class Spec < Dry::Struct

  # An object describing the data source
  attribute :data, DataClass.optional

  # Description of this mark for commenting purpose.
  attribute :description, Types::String.optional

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
  attribute :height, Types::Double.optional

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  attribute :layer, Types.Array(LayerSpec).optional

  # Name of the visualization for later reference.
  attribute :spec_name, Types::String.optional

  # Scale, axis, and legend resolutions for layers.
  #
  # Scale, axis, and legend resolutions for facets.
  #
  # Scale and legend resolutions for repeated charts.
  #
  # Scale, axis, and legend resolutions for vertically concatenated charts.
  #
  # Scale, axis, and legend resolutions for horizontally concatenated charts.
  attribute :resolve, Resolve.optional

  # Title for the plot.
  attribute :title, Types.Instance(Title).optional

  # An array of data transformations such as filter and new field calculation.
  attribute :transform, Types.Array(Transform).optional

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
  attribute :width, Types::Double.optional

  # A key-value mapping between encoding channels and definition of fields.
  attribute :encoding, EncodingClass.optional

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  attribute :mark, Types.Instance(AnyMark).optional

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  attribute :projection, Projection.optional

  # A key-value mapping between selection names and definitions.
  attribute :selection, Types::Hash.meta(of: SelectionDef).optional

  # An object that describes mappings between `row` and `column` channels and their field
  # definitions.
  attribute :facet, FacetMapping.optional

  # A specification of the view that gets faceted.
  attribute :spec, Spec.optional

  # An object that describes what fields should be repeated into views that are laid out as a
  # `row` or `column`.
  attribute :repeat, Repeat.optional

  # A list of views that should be concatenated and put into a column.
  attribute :vconcat, Types.Array(Spec).optional

  # A list of views that should be concatenated and put into a row.
  attribute :hconcat, Types.Array(Spec).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:        d.key?("data") ? DataClass.from_dynamic!(d["data"]) : nil,
      description: d.key?("description") ? Types::String[d["description"]] : nil,
      height:      d.key?("height") ? Types::Double[d["height"]] : nil,
      layer:       d.key?("layer") ? d["layer"].map { |x| LayerSpec.from_dynamic!(x) } : nil,
      spec_name:   d.key?("name") ? Types::String[d["name"]] : nil,
      resolve:     d.key?("resolve") ? Resolve.from_dynamic!(d["resolve"]) : nil,
      title:       d.key?("title") ? Title.from_dynamic!(d["title"]) : nil,
      transform:   d.key?("transform") ? d["transform"].map { |x| Transform.from_dynamic!(x) } : nil,
      width:       d.key?("width") ? Types::Double[d["width"]] : nil,
      encoding:    d.key?("encoding") ? EncodingClass.from_dynamic!(d["encoding"]) : nil,
      mark:        d.key?("mark") ? AnyMark.from_dynamic!(d["mark"]) : nil,
      projection:  d.key?("projection") ? Projection.from_dynamic!(d["projection"]) : nil,
      selection:   d.key?("selection") ? Types::Hash[d["selection"]].map { |k, v| [k, SelectionDef.from_dynamic!(v)] }.to_h : nil,
      facet:       d.key?("facet") ? FacetMapping.from_dynamic!(d["facet"]) : nil,
      spec:        d.key?("spec") ? Spec.from_dynamic!(d["spec"]) : nil,
      repeat:      d.key?("repeat") ? Repeat.from_dynamic!(d["repeat"]) : nil,
      vconcat:     d.key?("vconcat") ? d["vconcat"].map { |x| Spec.from_dynamic!(x) } : nil,
      hconcat:     d.key?("hconcat") ? d["hconcat"].map { |x| Spec.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"        => data&.to_dynamic,
      "description" => description,
      "height"      => height,
      "layer"       => layer&.map { |x| x.to_dynamic },
      "name"        => spec_name,
      "resolve"     => resolve&.to_dynamic,
      "title"       => title&.to_dynamic,
      "transform"   => transform&.map { |x| x.to_dynamic },
      "width"       => width,
      "encoding"    => encoding&.to_dynamic,
      "mark"        => mark&.to_dynamic,
      "projection"  => projection&.to_dynamic,
      "selection"   => selection&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "facet"       => facet&.to_dynamic,
      "spec"        => spec&.to_dynamic,
      "repeat"      => repeat&.to_dynamic,
      "vconcat"     => vconcat&.map { |x| x.to_dynamic },
      "hconcat"     => hconcat&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct

  # URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
  # have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
  # Setting the `$schema` property allows automatic validation and autocomplete in editors
  # that support JSON schema.
  attribute :schema, Types::String.optional

  # Sets how the visualization size should be determined. If a string, should be one of
  # `"pad"`, `"fit"` or `"none"`.
  # Object values can additionally specify parameters for content sizing and automatic
  # resizing.
  # `"fit"` is only supported for single and layered views that don't use `rangeStep`.
  #
  # __Default value__: `pad`
  attribute :autosize, Types.Instance(Autosize).optional

  # CSS color property to use as the background of visualization.
  #
  # __Default value:__ none (transparent)
  attribute :background, Types::String.optional

  # Vega-Lite configuration object.  This property can only be defined at the top-level of a
  # specification.
  attribute :config, Config.optional

  # An object describing the data source
  attribute :data, DataClass.optional

  # Description of this mark for commenting purpose.
  attribute :description, Types::String.optional

  # A key-value mapping between encoding channels and definition of fields.
  attribute :encoding, EncodingWithFacet.optional

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
  attribute :height, Types::Double.optional

  # A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
  # `"line"`,
  # * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
  # object](mark.html#mark-def).
  attribute :mark, Types.Instance(AnyMark).optional

  # Name of the visualization for later reference.
  attribute :top_level_name, Types::String.optional

  # The default visualization padding, in pixels, from the edge of the visualization canvas
  # to the data rectangle.  If a number, specifies padding for all sides.
  # If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
  # "bottom": 5}` to specify padding for each side of the visualization.
  #
  # __Default value__: `5`
  attribute :padding, Types.Instance(Padding).optional

  # An object defining properties of geographic projection.
  #
  # Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
  # more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
  attribute :projection, Projection.optional

  # A key-value mapping between selection names and definitions.
  attribute :selection, Types::Hash.meta(of: SelectionDef).optional

  # Title for the plot.
  attribute :title, Types.Instance(Title).optional

  # An array of data transformations such as filter and new field calculation.
  attribute :transform, Types.Array(Transform).optional

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
  attribute :width, Types::Double.optional

  # Layer or single view specifications to be layered.
  #
  # __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
  # layering facet specifications is not allowed.
  attribute :layer, Types.Array(LayerSpec).optional

  # Scale, axis, and legend resolutions for layers.
  #
  # Scale, axis, and legend resolutions for facets.
  #
  # Scale and legend resolutions for repeated charts.
  #
  # Scale, axis, and legend resolutions for vertically concatenated charts.
  #
  # Scale, axis, and legend resolutions for horizontally concatenated charts.
  attribute :resolve, Resolve.optional

  # An object that describes mappings between `row` and `column` channels and their field
  # definitions.
  attribute :facet, FacetMapping.optional

  # A specification of the view that gets faceted.
  attribute :spec, Spec.optional

  # An object that describes what fields should be repeated into views that are laid out as a
  # `row` or `column`.
  attribute :repeat, Repeat.optional

  # A list of views that should be concatenated and put into a column.
  attribute :vconcat, Types.Array(Spec).optional

  # A list of views that should be concatenated and put into a row.
  attribute :hconcat, Types.Array(Spec).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      schema:         d.key?("$schema") ? Types::String[d["$schema"]] : nil,
      autosize:       d.key?("autosize") ? Autosize.from_dynamic!(d["autosize"]) : nil,
      background:     d.key?("background") ? Types::String[d["background"]] : nil,
      config:         d.key?("config") ? Config.from_dynamic!(d["config"]) : nil,
      data:           d.key?("data") ? DataClass.from_dynamic!(d["data"]) : nil,
      description:    d.key?("description") ? Types::String[d["description"]] : nil,
      encoding:       d.key?("encoding") ? EncodingWithFacet.from_dynamic!(d["encoding"]) : nil,
      height:         d.key?("height") ? Types::Double[d["height"]] : nil,
      mark:           d.key?("mark") ? AnyMark.from_dynamic!(d["mark"]) : nil,
      top_level_name: d.key?("name") ? Types::String[d["name"]] : nil,
      padding:        d.key?("padding") ? Padding.from_dynamic!(d["padding"]) : nil,
      projection:     d.key?("projection") ? Projection.from_dynamic!(d["projection"]) : nil,
      selection:      d.key?("selection") ? Types::Hash[d["selection"]].map { |k, v| [k, SelectionDef.from_dynamic!(v)] }.to_h : nil,
      title:          d.key?("title") ? Title.from_dynamic!(d["title"]) : nil,
      transform:      d.key?("transform") ? d["transform"].map { |x| Transform.from_dynamic!(x) } : nil,
      width:          d.key?("width") ? Types::Double[d["width"]] : nil,
      layer:          d.key?("layer") ? d["layer"].map { |x| LayerSpec.from_dynamic!(x) } : nil,
      resolve:        d.key?("resolve") ? Resolve.from_dynamic!(d["resolve"]) : nil,
      facet:          d.key?("facet") ? FacetMapping.from_dynamic!(d["facet"]) : nil,
      spec:           d.key?("spec") ? Spec.from_dynamic!(d["spec"]) : nil,
      repeat:         d.key?("repeat") ? Repeat.from_dynamic!(d["repeat"]) : nil,
      vconcat:        d.key?("vconcat") ? d["vconcat"].map { |x| Spec.from_dynamic!(x) } : nil,
      hconcat:        d.key?("hconcat") ? d["hconcat"].map { |x| Spec.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "$schema"     => schema,
      "autosize"    => autosize&.to_dynamic,
      "background"  => background,
      "config"      => config&.to_dynamic,
      "data"        => data&.to_dynamic,
      "description" => description,
      "encoding"    => encoding&.to_dynamic,
      "height"      => height,
      "mark"        => mark&.to_dynamic,
      "name"        => top_level_name,
      "padding"     => padding&.to_dynamic,
      "projection"  => projection&.to_dynamic,
      "selection"   => selection&.map { |k, v| [k, v.to_dynamic] }.to_h,
      "title"       => title&.to_dynamic,
      "transform"   => transform&.map { |x| x.to_dynamic },
      "width"       => width,
      "layer"       => layer&.map { |x| x.to_dynamic },
      "resolve"     => resolve&.to_dynamic,
      "facet"       => facet&.to_dynamic,
      "spec"        => spec&.to_dynamic,
      "repeat"      => repeat&.to_dynamic,
      "vconcat"     => vconcat&.map { |x| x.to_dynamic },
      "hconcat"     => hconcat&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
