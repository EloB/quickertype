import * as S from "effect/Schema";

// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
// The default setting (`"content"`) interprets the width and height settings as the data
// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
// `"padding"` setting includes the padding within the view size calculations, such that the
// width and height settings indicate the **total** intended size of the view.
//
// __Default value__: `"content"`

export const Contains = S.Literal(
    "content",
    "padding",
);
export type Contains = S.Schema.Type<typeof Contains>;

// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
// descriptions of each.
//
// __Default value__: `"pad"`

export const AutosizeType = S.Literal(
    "pad",
    "fit",
    "none",
);
export type AutosizeType = S.Schema.Type<typeof AutosizeType>;

// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

export const HorizontalAlign = S.Literal(
    "left",
    "right",
    "center",
);
export type HorizontalAlign = S.Schema.Type<typeof HorizontalAlign>;

// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
//
// __Default value:__ `"middle"`
//
// Vertical text baseline for title text.

export const VerticalAlign = S.Literal(
    "top",
    "middle",
    "bottom",
);
export type VerticalAlign = S.Schema.Type<typeof VerticalAlign>;

// The mouse cursor used over the mark. Any valid [CSS cursor
// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

export const Cursor = S.Literal(
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
);
export type Cursor = S.Schema.Type<typeof Cursor>;

// The font style (e.g., `"italic"`).

export const FontStyle = S.Literal(
    "normal",
    "italic",
);
export type FontStyle = S.Schema.Type<typeof FontStyle>;


export const FontWeight = S.Literal(
    "normal",
    "bold",
);
export type FontWeight = S.Schema.Type<typeof FontWeight>;

// The line interpolation method to use for line and area marks. One of the following:
// - `"linear"`: piecewise linear segments, as in a polyline.
// - `"linear-closed"`: close the linear segments to form a polygon.
// - `"step"`: alternate between horizontal and vertical segments, as in a step function.
// - `"step-before"`: alternate between vertical and horizontal segments, as in a step
// function.
// - `"step-after"`: alternate between horizontal and vertical segments, as in a step
// function.
// - `"basis"`: a B-spline, with control point duplication on the ends.
// - `"basis-open"`: an open B-spline; may not intersect the start or end.
// - `"basis-closed"`: a closed B-spline, as in a loop.
// - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
// - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
// will intersect other control points.
// - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
// - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
// spline.
// - `"monotone"`: cubic interpolation that preserves monotonicity in y.

export const Interpolate = S.Literal(
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
);
export type Interpolate = S.Schema.Type<typeof Interpolate>;

// The orientation of a non-stacked bar, tick, area, and line charts.
// The value is either horizontal (default) or vertical.
// - For bar, rule and tick, this determines whether the size of the bar and tick
// should be applied to x or y dimension.
// - For area, this property determines the orient property of the Vega output.
// - For line, this property determines the sort order of the points in the line
// if `config.sortLineBy` is not specified.
// For stacked charts, this is always determined by the orientation of the stack;
// therefore explicitly specified value will be ignored.

export const Orient = S.Literal(
    "horizontal",
    "vertical",
);
export type Orient = S.Schema.Type<typeof Orient>;


export const LabelOverlapEnum = S.Literal(
    "parity",
    "greedy",
);
export type LabelOverlapEnum = S.Schema.Type<typeof LabelOverlapEnum>;

// Defines how Vega-Lite generates title for fields.  There are three possible styles:
//
// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
// "Year-month of date", "field (binned)").
// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
// "field").

export const FieldTitle = S.Literal(
    "verbal",
    "functional",
    "plain",
);
export type FieldTitle = S.Schema.Type<typeof FieldTitle>;

// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
// - If set to `"filter"` (default), all data items with null values are filtered.
// - If `null`, all data items are included. In this case, invalid values will be
// interpreted as zeroes.

export const InvalidValues = S.Literal(
    "filter",
);
export type InvalidValues = S.Schema.Type<typeof InvalidValues>;

// The orientation of the legend, which determines how the legend is positioned within the
// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
// "none".
//
// __Default value:__ `"right"`

export const LegendOrient = S.Literal(
    "left",
    "right",
    "top-left",
    "top-right",
    "bottom-left",
    "bottom-right",
    "none",
);
export type LegendOrient = S.Schema.Type<typeof LegendOrient>;

// The cartographic projection to use. This value is case-insensitive, for example
// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
// projection types [in the
// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
//
// __Default value:__ `mercator`

export const VgProjectionType = S.Literal(
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
);
export type VgProjectionType = S.Schema.Type<typeof VgProjectionType>;

// Establishes a two-way binding between the interval selection and the scales
// used within the same view. This allows a user to interactively pan and
// zoom the view.

export const BindEnum = S.Literal(
    "scales",
);
export type BindEnum = S.Schema.Type<typeof BindEnum>;

// By default, all data values are considered to lie within an empty selection.
// When set to `none`, empty selections contain no data values.

export const Empty = S.Literal(
    "all",
    "none",
);
export type Empty = S.Schema.Type<typeof Empty>;


export const SingleDefChannel = S.Literal(
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
);
export type SingleDefChannel = S.Schema.Type<typeof SingleDefChannel>;

// With layered and multi-view displays, a strategy that determines how
// selections' data queries are resolved when applied in a filter transform,
// conditional encoding rule, or scale domain.

export const SelectionResolution = S.Literal(
    "global",
    "union",
    "intersect",
);
export type SelectionResolution = S.Schema.Type<typeof SelectionResolution>;

// Default stack offset for stackable mark.

export const StackOffset = S.Literal(
    "zero",
    "center",
    "normalize",
);
export type StackOffset = S.Schema.Type<typeof StackOffset>;

// The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
// example, with an orientation of top these anchor positions map to a left-, center-, or
// right-aligned title.
//
// __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
// `"start"` for other composite views.
//
// __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
// customizable only for [single](spec.html) and [layered](layer.html) views.  For other
// composite views, `anchor` is always `"start"`.

export const Anchor = S.Literal(
    "start",
    "middle",
    "end",
);
export type Anchor = S.Schema.Type<typeof Anchor>;

// Default title orientation ("top", "bottom", "left", or "right")
//
// The orientation of the title relative to the chart. One of `"top"` (the default),
// `"bottom"`, `"left"`, or `"right"`.
//
// The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
// orientation can be used to further specialize the axis type (e.g., a y axis oriented for
// the right edge of the chart).
//
// __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.

export const TitleOrient = S.Literal(
    "top",
    "bottom",
    "left",
    "right",
);
export type TitleOrient = S.Schema.Type<typeof TitleOrient>;


export const ParseEnum = S.Literal(
    "auto",
);
export type ParseEnum = S.Schema.Type<typeof ParseEnum>;

// Type of input data: `"json"`, `"csv"`, `"tsv"`.
// The default format type is determined by the extension of the file URL.
// If no extension is detected, `"json"` will be used by default.

export const DataFormatType = S.Literal(
    "csv",
    "tsv",
    "json",
    "topojson",
);
export type DataFormatType = S.Schema.Type<typeof DataFormatType>;

// Aggregation function for the field
// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
//
// __Default value:__ `undefined` (None)
//
// An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
// (e.g., `"count"`, `"mean"` and `"median"`).
// This property is required in cases where the sort field and the data reference field do
// not match.
// The input data objects will be aggregated, grouped by the encoded data field.
//
// For a full list of operations, please see the documentation for
// [aggregate](aggregate.html#ops).
//
// The aggregation operations to apply to the fields, such as sum, average or count.
// See the [full list of supported aggregation
// operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
// for more information.

export const AggregateOp = S.Literal(
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
);
export type AggregateOp = S.Schema.Type<typeof AggregateOp>;

// Time unit for the field to be filtered.
//
// time unit for the field to be filtered.
//
// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
// or [a temporal field that gets casted as ordinal](type.html#cast).
//
// __Default value:__ `undefined` (None)
//
// The timeUnit.

export const TimeUnit = S.Literal(
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
);
export type TimeUnit = S.Schema.Type<typeof TimeUnit>;


export const RepeatEnum = S.Literal(
    "row",
    "column",
);
export type RepeatEnum = S.Schema.Type<typeof RepeatEnum>;

// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
// continuous color gradient.
//
// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
// `"symbol"` otherwise.

export const LegendType = S.Literal(
    "symbol",
    "gradient",
);
export type LegendType = S.Schema.Type<typeof LegendType>;


export const Domain = S.Literal(
    "unaggregated",
);
export type Domain = S.Schema.Type<typeof Domain>;


export const InterpolateParamsType = S.Literal(
    "rgb",
    "cubehelix",
    "cubehelix-long",
);
export type InterpolateParamsType = S.Schema.Type<typeof InterpolateParamsType>;


export const NiceTime = S.Literal(
    "second",
    "minute",
    "hour",
    "day",
    "week",
    "month",
    "year",
);
export type NiceTime = S.Schema.Type<typeof NiceTime>;

// The type of scale.  Vega-Lite supports the following categories of scale types:
//
// 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
// continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
// [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
// [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
//
// 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
// ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
// [`"point"`](scale.html#point)) output ranges.
//
// 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
// discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
// [`"bin-ordinal"`](scale.html#bin-ordinal)).
//
// __Default value:__ please see the [scale type table](scale.html#type).

export const ScaleType = S.Literal(
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
);
export type ScaleType = S.Schema.Type<typeof ScaleType>;


export const SortEnum = S.Literal(
    "ascending",
    "descending",
);
export type SortEnum = S.Schema.Type<typeof SortEnum>;

// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
// `"nominal"`).
// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
// [geographic projection](projection.html) is applied.
//
// Constants and utilities for data type
// Data type based on level of measurement

export const Type = S.Literal(
    "quantitative",
    "ordinal",
    "temporal",
    "nominal",
    "latitude",
    "longitude",
    "geojson",
);
export type Type = S.Schema.Type<typeof Type>;

// All types of primitive marks.
//
// The mark type.
// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.

export const Mark = S.Literal(
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
);
export type Mark = S.Schema.Type<typeof Mark>;


export const ResolveMode = S.Literal(
    "independent",
    "shared",
);
export type ResolveMode = S.Schema.Type<typeof ResolveMode>;


export const SelectionDefType = S.Literal(
    "single",
    "multi",
    "interval",
);
export type SelectionDefType = S.Schema.Type<typeof SelectionDefType>;

export class Repeat extends S.Class<Repeat>("Repeat")({
    "column": S.optional(S.Array(S.String)),
    "row": S.optional(S.Array(S.String)),
}) {}

export class AggregatedFieldDef extends S.Class<AggregatedFieldDef>("AggregatedFieldDef")({
    "as": S.String,
    "field": S.String,
    "op": AggregateOp,
}) {}

export class TitleParams extends S.Class<TitleParams>("TitleParams")({
    "anchor": S.optional(Anchor),
    "offset": S.optional(S.Number),
    "orient": S.optional(TitleOrient),
    "style": S.optional(S.Union(S.Array(S.String), S.String)),
    "text": S.String,
}) {}

export class ScaleResolveMap extends S.Class<ScaleResolveMap>("ScaleResolveMap")({
    "color": S.optional(ResolveMode),
    "opacity": S.optional(ResolveMode),
    "shape": S.optional(ResolveMode),
    "size": S.optional(ResolveMode),
    "x": S.optional(ResolveMode),
    "y": S.optional(ResolveMode),
}) {}

export class LegendResolveMap extends S.Class<LegendResolveMap>("LegendResolveMap")({
    "color": S.optional(ResolveMode),
    "opacity": S.optional(ResolveMode),
    "shape": S.optional(ResolveMode),
    "size": S.optional(ResolveMode),
}) {}

export class AxisResolveMap extends S.Class<AxisResolveMap>("AxisResolveMap")({
    "x": S.optional(ResolveMode),
    "y": S.optional(ResolveMode),
}) {}

export class Resolve extends S.Class<Resolve>("Resolve")({
    "axis": S.optional(AxisResolveMap),
    "legend": S.optional(LegendResolveMap),
    "scale": S.optional(ScaleResolveMap),
}) {}

export class Projection extends S.Class<Projection>("Projection")({
    "center": S.optional(S.Array(S.Number)),
    "clipAngle": S.optional(S.Number),
    "clipExtent": S.optional(S.Array(S.Array(S.Number))),
    "coefficient": S.optional(S.Number),
    "distance": S.optional(S.Number),
    "fraction": S.optional(S.Number),
    "lobes": S.optional(S.Number),
    "parallel": S.optional(S.Number),
    "precision": S.optional(S.Record({ key: S.String, value: S.Union(S.Number, S.String)})),
    "radius": S.optional(S.Number),
    "ratio": S.optional(S.Number),
    "rotate": S.optional(S.Array(S.Number)),
    "spacing": S.optional(S.Number),
    "tilt": S.optional(S.Number),
    "type": S.optional(VgProjectionType),
}) {}

export class MarkDef extends S.Class<MarkDef>("MarkDef")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "baseline": S.optional(VerticalAlign),
    "clip": S.optional(S.Boolean),
    "color": S.optional(S.String),
    "cursor": S.optional(Cursor),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "filled": S.optional(S.Boolean),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "style": S.optional(S.Union(S.Array(S.String), S.String)),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
    "type": Mark,
}) {}

export class X2Class extends S.Class<X2Class>("X2Class")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
}) {}

export class Axis extends S.Class<Axis>("Axis")({
    "domain": S.optional(S.Boolean),
    "format": S.optional(S.String),
    "grid": S.optional(S.Boolean),
    "labelAngle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(-360)).pipe(S.lessThanOrEqualTo(360))),
    "labelBound": S.optional(S.Union(S.Boolean, S.Number)),
    "labelFlush": S.optional(S.Union(S.Boolean, S.Number)),
    "labelOverlap": S.optional(S.Union(S.Boolean, LabelOverlapEnum)),
    "labelPadding": S.optional(S.Number),
    "labels": S.optional(S.Boolean),
    "maxExtent": S.optional(S.Number),
    "minExtent": S.optional(S.Number),
    "offset": S.optional(S.Number),
    "orient": S.optional(TitleOrient),
    "position": S.optional(S.Number),
    "tickCount": S.optional(S.Number),
    "ticks": S.optional(S.Boolean),
    "tickSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "title": S.optional(S.NullOr(S.String)),
    "titleMaxLength": S.optional(S.Number),
    "titlePadding": S.optional(S.Number),
    "values": S.optional(S.Array(S.Union(S.Number, S.suspend(() => DateTime)))),
    "zindex": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
}) {}

export class ConditionalPredicateTextFieldDefClass extends S.Class<ConditionalPredicateTextFieldDefClass>("ConditionalPredicateTextFieldDefClass")({
    "test": S.optional(S.Union(S.String, S.suspend(() => Predicate))),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
    "selection": S.optional(S.Union(S.String, S.suspend(() => Selection))),
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "format": S.optional(S.String),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
}) {}

export class TextDefWithCondition extends S.Class<TextDefWithCondition>("TextDefWithCondition")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "condition": S.optional(S.Union(S.Array(S.suspend(() => ConditionalValueDef)), ConditionalPredicateTextFieldDefClass)),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "format": S.optional(S.String),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
}) {}

export class OrderFieldDef extends S.Class<OrderFieldDef>("OrderFieldDef")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "sort": S.optional(S.NullOr(SortEnum)),
    "timeUnit": S.optional(TimeUnit),
    "type": Type,
}) {}

export class ConditionalPredicateFieldDefClass extends S.Class<ConditionalPredicateFieldDefClass>("ConditionalPredicateFieldDefClass")({
    "test": S.optional(S.Union(S.String, S.suspend(() => Predicate))),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
    "selection": S.optional(S.Union(S.String, S.suspend(() => Selection))),
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
}) {}

export class DefWithCondition extends S.Class<DefWithCondition>("DefWithCondition")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "condition": S.optional(S.Union(S.Array(S.suspend(() => ConditionalValueDef)), ConditionalPredicateFieldDefClass)),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
}) {}

export class FieldDef extends S.Class<FieldDef>("FieldDef")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "timeUnit": S.optional(TimeUnit),
    "type": Type,
}) {}

export class Header extends S.Class<Header>("Header")({
    "format": S.optional(S.String),
    "labelAngle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(-360)).pipe(S.lessThanOrEqualTo(360))),
    "title": S.optional(S.NullOr(S.String)),
}) {}

export class SelectionDef extends S.Class<SelectionDef>("SelectionDef")({
    "bind": S.optional(S.Union(BindEnum, S.Record({ key: S.String, value: S.suspend(() => VgBinding)}))),
    "empty": S.optional(Empty),
    "encodings": S.optional(S.Array(SingleDefChannel)),
    "fields": S.optional(S.Array(S.String)),
    "nearest": S.optional(S.Boolean),
    "on": S.optional(S.Any),
    "resolve": S.optional(SelectionResolution),
    "type": SelectionDefType,
    "toggle": S.optional(S.Union(S.Boolean, S.String)),
    "mark": S.optional(S.suspend(() => BrushConfig)),
    "translate": S.optional(S.Union(S.Boolean, S.String)),
    "zoom": S.optional(S.Union(S.Boolean, S.String)),
}) {}

export class FacetFieldDef extends S.Class<FacetFieldDef>("FacetFieldDef")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "header": S.optional(Header),
    "sort": S.optional(S.NullOr(SortEnum)),
    "timeUnit": S.optional(TimeUnit),
    "type": Type,
}) {}

export class SortField extends S.Class<SortField>("SortField")({
    "field": S.optional(S.Union(S.String, S.suspend(() => RepeatRef))),
    "op": AggregateOp,
    "order": S.optional(S.NullOr(SortEnum)),
}) {}

export class SchemeParams extends S.Class<SchemeParams>("SchemeParams")({
    "extent": S.optional(S.Array(S.Number)),
    "name": S.String,
}) {}

export class NiceClass extends S.Class<NiceClass>("NiceClass")({
    "interval": S.String,
    "step": S.Number,
}) {}

export class InterpolateParams extends S.Class<InterpolateParams>("InterpolateParams")({
    "gamma": S.optional(S.Number),
    "type": InterpolateParamsType,
}) {}

export class DomainClass extends S.Class<DomainClass>("DomainClass")({
    "field": S.optional(S.String),
    "selection": S.String,
    "encoding": S.optional(S.String),
}) {}

export class Scale extends S.Class<Scale>("Scale")({
    "base": S.optional(S.Number),
    "clamp": S.optional(S.Boolean),
    "domain": S.optional(S.Union(S.Array(S.Union(S.Boolean, S.Number, S.String, S.suspend(() => DateTime))), Domain, DomainClass)),
    "exponent": S.optional(S.Number),
    "interpolate": S.optional(S.Union(Interpolate, InterpolateParams)),
    "nice": S.optional(S.Union(S.Boolean, S.Number, NiceTime, NiceClass)),
    "padding": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "paddingInner": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "paddingOuter": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "range": S.optional(S.Union(S.Array(S.Union(S.Number, S.String)), S.String)),
    "rangeStep": S.optional(S.NullOr(S.Number.pipe(S.greaterThanOrEqualTo(0)))),
    "round": S.optional(S.Boolean),
    "scheme": S.optional(S.Union(S.String, SchemeParams)),
    "type": S.optional(ScaleType),
    "zero": S.optional(S.Boolean),
}) {}

export class LookupData extends S.Class<LookupData>("LookupData")({
    "data": S.suspend(() => Data),
    "fields": S.optional(S.Array(S.String)),
    "key": S.String,
}) {}

export class Legend extends S.Class<Legend>("Legend")({
    "entryPadding": S.optional(S.Number),
    "format": S.optional(S.String),
    "offset": S.optional(S.Number),
    "orient": S.optional(LegendOrient),
    "padding": S.optional(S.Number),
    "tickCount": S.optional(S.Number),
    "title": S.optional(S.NullOr(S.String)),
    "type": S.optional(LegendType),
    "values": S.optional(S.Array(S.Union(S.Number, S.String, S.suspend(() => DateTime)))),
    "zindex": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
}) {}

export class Transform extends S.Class<Transform>("Transform")({
    "filter": S.optional(S.Union(S.String, S.suspend(() => Predicate))),
    "as": S.optional(S.Union(S.Array(S.String), S.String)),
    "calculate": S.optional(S.String),
    "default": S.optional(S.String),
    "from": S.optional(LookupData),
    "lookup": S.optional(S.String),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.String),
    "timeUnit": S.optional(TimeUnit),
    "aggregate": S.optional(S.Array(AggregatedFieldDef)),
    "groupby": S.optional(S.Array(S.String)),
}) {}

export class RepeatRef extends S.Class<RepeatRef>("RepeatRef")({
    "repeat": RepeatEnum,
}) {}

export class ConditionalPredicateMarkPropFieldDefClass extends S.Class<ConditionalPredicateMarkPropFieldDefClass>("ConditionalPredicateMarkPropFieldDefClass")({
    "test": S.optional(S.Union(S.String, S.suspend(() => Predicate))),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
    "selection": S.optional(S.Union(S.String, S.suspend(() => Selection))),
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, S.suspend(() => BinParams))),
    "field": S.optional(S.Union(S.String, RepeatRef)),
    "legend": S.optional(S.NullOr(Legend)),
    "scale": S.optional(Scale),
    "sort": S.optional(S.Union(SortEnum, SortField, S.Null)),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
}) {}

export class DateTime extends S.Class<DateTime>("DateTime")({
    "date": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(31))),
    "day": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(7)), S.String)),
    "hours": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(23))),
    "milliseconds": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(999))),
    "minutes": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(59))),
    "month": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(12)), S.String)),
    "quarter": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(4))),
    "seconds": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(59))),
    "utc": S.optional(S.Boolean),
    "year": S.optional(S.Number),
}) {}

export class Predicate extends S.Class<Predicate>("Predicate")({
    "not": S.optional(S.Union(S.String, S.suspend(() => Predicate))),
    "and": S.optional(S.Array(S.Union(S.String, S.suspend(() => Predicate)))),
    "or": S.optional(S.Array(S.Union(S.String, S.suspend(() => Predicate)))),
    "equal": S.optional(S.Union(S.Boolean, S.Number, S.String, DateTime)),
    "field": S.optional(S.String),
    "timeUnit": S.optional(TimeUnit),
    "range": S.optional(S.Array(S.Union(S.Number, DateTime, S.Null)).pipe(S.minItems(2)).pipe(S.maxItems(2))),
    "oneOf": S.optional(S.Array(S.Union(S.Boolean, S.Number, S.String, DateTime))),
    "selection": S.optional(S.Union(S.String, S.suspend(() => Selection))),
}) {}

export class Selection extends S.Class<Selection>("Selection")({
    "not": S.optional(S.Union(S.String, S.suspend(() => Selection))),
    "and": S.optional(S.Array(S.Union(S.String, S.suspend(() => Selection)))),
    "or": S.optional(S.Array(S.Union(S.String, S.suspend(() => Selection)))),
}) {}

export class ConditionalValueDef extends S.Class<ConditionalValueDef>("ConditionalValueDef")({
    "test": S.optional(S.Union(S.String, Predicate)),
    "value": S.Union(S.Boolean, S.Number, S.String),
    "selection": S.optional(S.Union(S.String, Selection)),
}) {}

export class BinParams extends S.Class<BinParams>("BinParams")({
    "base": S.optional(S.Number),
    "divide": S.optional(S.Array(S.Number).pipe(S.minItems(1))),
    "extent": S.optional(S.Array(S.Number).pipe(S.minItems(2)).pipe(S.maxItems(2))),
    "maxbins": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(2))),
    "minstep": S.optional(S.Number),
    "nice": S.optional(S.Boolean),
    "step": S.optional(S.Number),
    "steps": S.optional(S.Array(S.Number).pipe(S.minItems(1))),
}) {}

export class MarkPropDefWithCondition extends S.Class<MarkPropDefWithCondition>("MarkPropDefWithCondition")({
    "aggregate": S.optional(AggregateOp),
    "bin": S.optional(S.Union(S.Boolean, BinParams)),
    "condition": S.optional(S.Union(S.Array(ConditionalValueDef), ConditionalPredicateMarkPropFieldDefClass)),
    "field": S.optional(S.Union(S.String, RepeatRef)),
    "legend": S.optional(S.NullOr(Legend)),
    "scale": S.optional(Scale),
    "sort": S.optional(S.Union(SortEnum, SortField, S.Null)),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
}) {}

export class EncodingWithFacet extends S.Class<EncodingWithFacet>("EncodingWithFacet")({
    "color": S.optional(MarkPropDefWithCondition),
    "column": S.optional(FacetFieldDef),
    "detail": S.optional(S.Union(S.Array(FieldDef), FieldDef)),
    "href": S.optional(DefWithCondition),
    "opacity": S.optional(MarkPropDefWithCondition),
    "order": S.optional(S.Union(S.Array(OrderFieldDef), OrderFieldDef)),
    "row": S.optional(FacetFieldDef),
    "shape": S.optional(MarkPropDefWithCondition),
    "size": S.optional(MarkPropDefWithCondition),
    "text": S.optional(TextDefWithCondition),
    "tooltip": S.optional(TextDefWithCondition),
    "x": S.optional(S.suspend(() => XClass)),
    "x2": S.optional(X2Class),
    "y": S.optional(S.suspend(() => XClass)),
    "y2": S.optional(X2Class),
}) {}

export class DataFormat extends S.Class<DataFormat>("DataFormat")({
    "parse": S.optional(S.Union(ParseEnum, S.Record({ key: S.String, value: S.Any}))),
    "type": S.optional(DataFormatType),
    "property": S.optional(S.String),
    "feature": S.optional(S.String),
    "mesh": S.optional(S.String),
}) {}

export class Data extends S.Class<Data>("Data")({
    "format": S.optional(DataFormat),
    "url": S.optional(S.String),
    "values": S.optional(S.Union(S.Array(S.Union(S.Boolean, S.Number, S.Record({ key: S.String, value: S.Any}), S.String)), S.Record({ key: S.String, value: S.Any}), S.String)),
    "name": S.optional(S.String),
}) {}

export class ViewConfig extends S.Class<ViewConfig>("ViewConfig")({
    "clip": S.optional(S.Boolean),
    "fill": S.optional(S.String),
    "fillOpacity": S.optional(S.Number),
    "height": S.optional(S.Number),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number),
    "strokeWidth": S.optional(S.Number),
    "width": S.optional(S.Number),
}) {}

export class VgTitleConfig extends S.Class<VgTitleConfig>("VgTitleConfig")({
    "anchor": S.optional(Anchor),
    "angle": S.optional(S.Number),
    "baseline": S.optional(VerticalAlign),
    "color": S.optional(S.String),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "limit": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "offset": S.optional(S.Number),
    "orient": S.optional(TitleOrient),
}) {}

export class TickConfig extends S.Class<TickConfig>("TickConfig")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "bandSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "baseline": S.optional(VerticalAlign),
    "color": S.optional(S.String),
    "cursor": S.optional(Cursor),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "filled": S.optional(S.Boolean),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
    "thickness": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
}) {}

export class TextConfig extends S.Class<TextConfig>("TextConfig")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "baseline": S.optional(VerticalAlign),
    "color": S.optional(S.String),
    "cursor": S.optional(Cursor),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "filled": S.optional(S.Boolean),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "shortTimeLabels": S.optional(S.Boolean),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
}) {}

export class VgMarkConfig extends S.Class<VgMarkConfig>("VgMarkConfig")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "baseline": S.optional(VerticalAlign),
    "cursor": S.optional(Cursor),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
}) {}

export class VgBinding extends S.Class<VgBinding>("VgBinding")({
    "element": S.optional(S.String),
    "input": S.String,
    "options": S.optional(S.Array(S.String)),
    "max": S.optional(S.Number),
    "min": S.optional(S.Number),
    "step": S.optional(S.Number),
}) {}

export class SingleSelectionConfig extends S.Class<SingleSelectionConfig>("SingleSelectionConfig")({
    "bind": S.optional(S.Record({ key: S.String, value: VgBinding})),
    "empty": S.optional(Empty),
    "encodings": S.optional(S.Array(SingleDefChannel)),
    "fields": S.optional(S.Array(S.String)),
    "nearest": S.optional(S.Boolean),
    "on": S.optional(S.Any),
    "resolve": S.optional(SelectionResolution),
}) {}

export class MultiSelectionConfig extends S.Class<MultiSelectionConfig>("MultiSelectionConfig")({
    "empty": S.optional(Empty),
    "encodings": S.optional(S.Array(SingleDefChannel)),
    "fields": S.optional(S.Array(S.String)),
    "nearest": S.optional(S.Boolean),
    "on": S.optional(S.Any),
    "resolve": S.optional(SelectionResolution),
    "toggle": S.optional(S.Union(S.Boolean, S.String)),
}) {}

export class BrushConfig extends S.Class<BrushConfig>("BrushConfig")({
    "fill": S.optional(S.String),
    "fillOpacity": S.optional(S.Number),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number),
    "strokeWidth": S.optional(S.Number),
}) {}

export class IntervalSelectionConfig extends S.Class<IntervalSelectionConfig>("IntervalSelectionConfig")({
    "bind": S.optional(BindEnum),
    "empty": S.optional(Empty),
    "encodings": S.optional(S.Array(SingleDefChannel)),
    "fields": S.optional(S.Array(S.String)),
    "mark": S.optional(BrushConfig),
    "on": S.optional(S.Any),
    "resolve": S.optional(SelectionResolution),
    "translate": S.optional(S.Union(S.Boolean, S.String)),
    "zoom": S.optional(S.Union(S.Boolean, S.String)),
}) {}

export class XClass extends S.Class<XClass>("XClass")({
    "aggregate": S.optional(AggregateOp),
    "axis": S.optional(S.NullOr(Axis)),
    "bin": S.optional(S.Union(S.Boolean, BinParams)),
    "field": S.optional(S.Union(S.String, RepeatRef)),
    "scale": S.optional(Scale),
    "sort": S.optional(S.Union(SortEnum, SortField, S.Null)),
    "stack": S.optional(S.NullOr(StackOffset)),
    "timeUnit": S.optional(TimeUnit),
    "type": S.optional(Type),
    "value": S.optional(S.Union(S.Boolean, S.Number, S.String)),
}) {}

export class SelectionConfig extends S.Class<SelectionConfig>("SelectionConfig")({
    "interval": S.optional(IntervalSelectionConfig),
    "multi": S.optional(MultiSelectionConfig),
    "single": S.optional(SingleSelectionConfig),
}) {}

export class ScaleConfig extends S.Class<ScaleConfig>("ScaleConfig")({
    "bandPaddingInner": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "bandPaddingOuter": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "clamp": S.optional(S.Boolean),
    "continuousPadding": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "maxBandSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "maxFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "maxOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "maxSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "maxStrokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "minBandSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "minFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "minOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "minSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "minStrokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "pointPadding": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "rangeStep": S.optional(S.NullOr(S.Number.pipe(S.greaterThanOrEqualTo(0)))),
    "round": S.optional(S.Boolean),
    "textXRangeStep": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "useUnaggregatedDomain": S.optional(S.Boolean),
}) {}

export class VgScheme extends S.Class<VgScheme>("VgScheme")({
    "count": S.optional(S.Number),
    "extent": S.optional(S.Array(S.Number)),
    "scheme": S.optional(S.String),
    "step": S.optional(S.Number),
}) {}

export class ProjectionConfig extends S.Class<ProjectionConfig>("ProjectionConfig")({
    "center": S.optional(S.Array(S.Number)),
    "clipAngle": S.optional(S.Number),
    "clipExtent": S.optional(S.Array(S.Array(S.Number))),
    "coefficient": S.optional(S.Number),
    "distance": S.optional(S.Number),
    "fraction": S.optional(S.Number),
    "lobes": S.optional(S.Number),
    "parallel": S.optional(S.Number),
    "precision": S.optional(S.Record({ key: S.String, value: S.Union(S.Number, S.String)})),
    "radius": S.optional(S.Number),
    "ratio": S.optional(S.Number),
    "rotate": S.optional(S.Array(S.Number)),
    "spacing": S.optional(S.Number),
    "tilt": S.optional(S.Number),
    "type": S.optional(VgProjectionType),
}) {}

export class FacetMapping extends S.Class<FacetMapping>("FacetMapping")({
    "column": S.optional(FacetFieldDef),
    "row": S.optional(FacetFieldDef),
}) {}

export class PaddingClass extends S.Class<PaddingClass>("PaddingClass")({
    "bottom": S.optional(S.Number),
    "left": S.optional(S.Number),
    "right": S.optional(S.Number),
    "top": S.optional(S.Number),
}) {}

export class LegendConfig extends S.Class<LegendConfig>("LegendConfig")({
    "cornerRadius": S.optional(S.Number),
    "entryPadding": S.optional(S.Number),
    "fillColor": S.optional(S.String),
    "gradientHeight": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "gradientLabelBaseline": S.optional(S.String),
    "gradientLabelLimit": S.optional(S.Number),
    "gradientLabelOffset": S.optional(S.Number),
    "gradientStrokeColor": S.optional(S.String),
    "gradientStrokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "gradientWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelAlign": S.optional(S.String),
    "labelBaseline": S.optional(S.String),
    "labelColor": S.optional(S.String),
    "labelFont": S.optional(S.String),
    "labelFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelLimit": S.optional(S.Number),
    "labelOffset": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "offset": S.optional(S.Number),
    "orient": S.optional(LegendOrient),
    "padding": S.optional(S.Number),
    "shortTimeLabels": S.optional(S.Boolean),
    "strokeColor": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeWidth": S.optional(S.Number),
    "symbolColor": S.optional(S.String),
    "symbolSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "symbolStrokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "symbolType": S.optional(S.String),
    "titleAlign": S.optional(S.String),
    "titleBaseline": S.optional(S.String),
    "titleColor": S.optional(S.String),
    "titleFont": S.optional(S.String),
    "titleFontSize": S.optional(S.Number),
    "titleFontWeight": S.optional(S.Union(S.Number, S.String)),
    "titleLimit": S.optional(S.Number),
    "titlePadding": S.optional(S.Number),
}) {}

export class BarConfig extends S.Class<BarConfig>("BarConfig")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "baseline": S.optional(VerticalAlign),
    "binSpacing": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "color": S.optional(S.String),
    "continuousBandSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "cursor": S.optional(Cursor),
    "discreteBandSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "filled": S.optional(S.Boolean),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
}) {}

export class VgAxisConfig extends S.Class<VgAxisConfig>("VgAxisConfig")({
    "bandPosition": S.optional(S.Number),
    "domain": S.optional(S.Boolean),
    "domainColor": S.optional(S.String),
    "domainWidth": S.optional(S.Number),
    "grid": S.optional(S.Boolean),
    "gridColor": S.optional(S.String),
    "gridDash": S.optional(S.Array(S.Number)),
    "gridOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "gridWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelAngle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(-360)).pipe(S.lessThanOrEqualTo(360))),
    "labelBound": S.optional(S.Union(S.Boolean, S.Number)),
    "labelColor": S.optional(S.String),
    "labelFlush": S.optional(S.Union(S.Boolean, S.Number)),
    "labelFont": S.optional(S.String),
    "labelFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelLimit": S.optional(S.Number),
    "labelOverlap": S.optional(S.Union(S.Boolean, LabelOverlapEnum)),
    "labelPadding": S.optional(S.Number),
    "labels": S.optional(S.Boolean),
    "maxExtent": S.optional(S.Number),
    "minExtent": S.optional(S.Number),
    "tickColor": S.optional(S.String),
    "tickRound": S.optional(S.Boolean),
    "ticks": S.optional(S.Boolean),
    "tickSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tickWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "titleAlign": S.optional(S.String),
    "titleAngle": S.optional(S.Number),
    "titleBaseline": S.optional(S.String),
    "titleColor": S.optional(S.String),
    "titleFont": S.optional(S.String),
    "titleFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "titleFontWeight": S.optional(S.Union(S.Number, S.String)),
    "titleLimit": S.optional(S.Number),
    "titleMaxLength": S.optional(S.Number),
    "titlePadding": S.optional(S.Number),
    "titleX": S.optional(S.Number),
    "titleY": S.optional(S.Number),
}) {}

export class AxisConfig extends S.Class<AxisConfig>("AxisConfig")({
    "bandPosition": S.optional(S.Number),
    "domain": S.optional(S.Boolean),
    "domainColor": S.optional(S.String),
    "domainWidth": S.optional(S.Number),
    "grid": S.optional(S.Boolean),
    "gridColor": S.optional(S.String),
    "gridDash": S.optional(S.Array(S.Number)),
    "gridOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "gridWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelAngle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(-360)).pipe(S.lessThanOrEqualTo(360))),
    "labelBound": S.optional(S.Union(S.Boolean, S.Number)),
    "labelColor": S.optional(S.String),
    "labelFlush": S.optional(S.Union(S.Boolean, S.Number)),
    "labelFont": S.optional(S.String),
    "labelFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "labelLimit": S.optional(S.Number),
    "labelOverlap": S.optional(S.Union(S.Boolean, LabelOverlapEnum)),
    "labelPadding": S.optional(S.Number),
    "labels": S.optional(S.Boolean),
    "maxExtent": S.optional(S.Number),
    "minExtent": S.optional(S.Number),
    "shortTimeLabels": S.optional(S.Boolean),
    "tickColor": S.optional(S.String),
    "tickRound": S.optional(S.Boolean),
    "ticks": S.optional(S.Boolean),
    "tickSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tickWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "titleAlign": S.optional(S.String),
    "titleAngle": S.optional(S.Number),
    "titleBaseline": S.optional(S.String),
    "titleColor": S.optional(S.String),
    "titleFont": S.optional(S.String),
    "titleFontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "titleFontWeight": S.optional(S.Union(S.Number, S.String)),
    "titleLimit": S.optional(S.Number),
    "titleMaxLength": S.optional(S.Number),
    "titlePadding": S.optional(S.Number),
    "titleX": S.optional(S.Number),
    "titleY": S.optional(S.Number),
}) {}

export class MarkConfig extends S.Class<MarkConfig>("MarkConfig")({
    "align": S.optional(HorizontalAlign),
    "angle": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(360))),
    "baseline": S.optional(VerticalAlign),
    "color": S.optional(S.String),
    "cursor": S.optional(Cursor),
    "dx": S.optional(S.Number),
    "dy": S.optional(S.Number),
    "fill": S.optional(S.String),
    "filled": S.optional(S.Boolean),
    "fillOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "font": S.optional(S.String),
    "fontSize": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "fontStyle": S.optional(FontStyle),
    "fontWeight": S.optional(S.Union(S.Number.pipe(S.greaterThanOrEqualTo(100)).pipe(S.lessThanOrEqualTo(900)), FontWeight)),
    "href": S.optional(S.String),
    "interpolate": S.optional(Interpolate),
    "limit": S.optional(S.Number),
    "opacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "orient": S.optional(Orient),
    "radius": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "shape": S.optional(S.String),
    "size": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "stroke": S.optional(S.String),
    "strokeDash": S.optional(S.Array(S.Number)),
    "strokeDashOffset": S.optional(S.Number),
    "strokeOpacity": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "strokeWidth": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0))),
    "tension": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1))),
    "text": S.optional(S.String),
    "theta": S.optional(S.Number),
}) {}

export class Config extends S.Class<Config>("Config")({
    "area": S.optional(MarkConfig),
    "autosize": S.optional(S.Union(AutosizeType, S.suspend(() => AutoSizeParams))),
    "axis": S.optional(AxisConfig),
    "axisBand": S.optional(VgAxisConfig),
    "axisBottom": S.optional(VgAxisConfig),
    "axisLeft": S.optional(VgAxisConfig),
    "axisRight": S.optional(VgAxisConfig),
    "axisTop": S.optional(VgAxisConfig),
    "axisX": S.optional(VgAxisConfig),
    "axisY": S.optional(VgAxisConfig),
    "background": S.optional(S.String),
    "bar": S.optional(BarConfig),
    "circle": S.optional(MarkConfig),
    "countTitle": S.optional(S.String),
    "fieldTitle": S.optional(FieldTitle),
    "geoshape": S.optional(MarkConfig),
    "invalidValues": S.optional(InvalidValues),
    "legend": S.optional(LegendConfig),
    "line": S.optional(MarkConfig),
    "mark": S.optional(MarkConfig),
    "numberFormat": S.optional(S.String),
    "padding": S.optional(S.Union(S.Number, PaddingClass)),
    "point": S.optional(MarkConfig),
    "projection": S.optional(ProjectionConfig),
    "range": S.optional(S.Record({ key: S.String, value: S.Union(S.Array(S.Union(S.Number, S.String)), VgScheme)})),
    "rect": S.optional(MarkConfig),
    "rule": S.optional(MarkConfig),
    "scale": S.optional(ScaleConfig),
    "selection": S.optional(SelectionConfig),
    "square": S.optional(MarkConfig),
    "stack": S.optional(StackOffset),
    "style": S.optional(S.Record({ key: S.String, value: VgMarkConfig})),
    "text": S.optional(TextConfig),
    "tick": S.optional(TickConfig),
    "timeFormat": S.optional(S.String),
    "title": S.optional(VgTitleConfig),
    "view": S.optional(ViewConfig),
}) {}

export class AutoSizeParams extends S.Class<AutoSizeParams>("AutoSizeParams")({
    "contains": S.optional(Contains),
    "resize": S.optional(S.Boolean),
    "type": S.optional(AutosizeType),
}) {}

export class Encoding extends S.Class<Encoding>("Encoding")({
    "color": S.optional(MarkPropDefWithCondition),
    "detail": S.optional(S.Union(S.Array(FieldDef), FieldDef)),
    "href": S.optional(DefWithCondition),
    "opacity": S.optional(MarkPropDefWithCondition),
    "order": S.optional(S.Union(S.Array(OrderFieldDef), OrderFieldDef)),
    "shape": S.optional(MarkPropDefWithCondition),
    "size": S.optional(MarkPropDefWithCondition),
    "text": S.optional(TextDefWithCondition),
    "tooltip": S.optional(TextDefWithCondition),
    "x": S.optional(XClass),
    "x2": S.optional(X2Class),
    "y": S.optional(XClass),
    "y2": S.optional(X2Class),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "$schema": S.optional(S.String),
    "autosize": S.optional(S.Union(AutosizeType, AutoSizeParams)),
    "background": S.optional(S.String),
    "config": S.optional(Config),
    "data": S.optional(Data),
    "description": S.optional(S.String),
    "encoding": S.optional(EncodingWithFacet),
    "height": S.optional(S.Number),
    "mark": S.optional(S.Union(Mark, MarkDef)),
    "name": S.optional(S.String),
    "padding": S.optional(S.Union(S.Number, PaddingClass)),
    "projection": S.optional(Projection),
    "selection": S.optional(S.Record({ key: S.String, value: SelectionDef})),
    "title": S.optional(S.Union(S.String, TitleParams)),
    "transform": S.optional(S.Array(Transform)),
    "width": S.optional(S.Number),
    "layer": S.optional(S.Array(S.suspend(() => LayerSpec))),
    "resolve": S.optional(Resolve),
    "facet": S.optional(FacetMapping),
    "spec": S.optional(S.suspend(() => Spec)),
    "repeat": S.optional(Repeat),
    "vconcat": S.optional(S.Array(S.suspend(() => Spec))),
    "hconcat": S.optional(S.Array(S.suspend(() => Spec))),
}) {}

export class Spec extends S.Class<Spec>("Spec")({
    "data": S.optional(Data),
    "description": S.optional(S.String),
    "height": S.optional(S.Number),
    "layer": S.optional(S.Array(S.suspend(() => LayerSpec))),
    "name": S.optional(S.String),
    "resolve": S.optional(Resolve),
    "title": S.optional(S.Union(S.String, TitleParams)),
    "transform": S.optional(S.Array(Transform)),
    "width": S.optional(S.Number),
    "encoding": S.optional(Encoding),
    "mark": S.optional(S.Union(Mark, MarkDef)),
    "projection": S.optional(Projection),
    "selection": S.optional(S.Record({ key: S.String, value: SelectionDef})),
    "facet": S.optional(FacetMapping),
    "spec": S.optional(S.suspend(() => Spec)),
    "repeat": S.optional(Repeat),
    "vconcat": S.optional(S.Array(S.suspend(() => Spec))),
    "hconcat": S.optional(S.Array(S.suspend(() => Spec))),
}) {}

export class LayerSpec extends S.Class<LayerSpec>("LayerSpec")({
    "data": S.optional(Data),
    "description": S.optional(S.String),
    "height": S.optional(S.Number),
    "layer": S.optional(S.Array(S.suspend(() => LayerSpec))),
    "name": S.optional(S.String),
    "resolve": S.optional(Resolve),
    "title": S.optional(S.Union(S.String, TitleParams)),
    "transform": S.optional(S.Array(Transform)),
    "width": S.optional(S.Number),
    "encoding": S.optional(Encoding),
    "mark": S.optional(S.Union(Mark, MarkDef)),
    "projection": S.optional(Projection),
    "selection": S.optional(S.Record({ key: S.String, value: SelectionDef})),
}) {}
