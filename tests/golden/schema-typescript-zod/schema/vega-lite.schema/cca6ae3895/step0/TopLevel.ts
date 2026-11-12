import * as z from "zod";

// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
// The default setting (`"content"`) interprets the width and height settings as the data
// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
// `"padding"` setting includes the padding within the view size calculations, such that the
// width and height settings indicate the **total** intended size of the view.
//
// __Default value__: `"content"`

export const ContainsSchema = z.enum([
    "content",
    "padding",
]);
export type Contains = z.infer<typeof ContainsSchema>;

// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
// descriptions of each.
//
// __Default value__: `"pad"`

export const AutosizeTypeSchema = z.enum([
    "pad",
    "fit",
    "none",
]);
export type AutosizeType = z.infer<typeof AutosizeTypeSchema>;

// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

export const HorizontalAlignSchema = z.enum([
    "left",
    "right",
    "center",
]);
export type HorizontalAlign = z.infer<typeof HorizontalAlignSchema>;

// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
//
// __Default value:__ `"middle"`
//
// Vertical text baseline for title text.

export const VerticalAlignSchema = z.enum([
    "top",
    "middle",
    "bottom",
]);
export type VerticalAlign = z.infer<typeof VerticalAlignSchema>;

// The mouse cursor used over the mark. Any valid [CSS cursor
// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

export const CursorSchema = z.enum([
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
]);
export type Cursor = z.infer<typeof CursorSchema>;

// The font style (e.g., `"italic"`).

export const FontStyleSchema = z.enum([
    "normal",
    "italic",
]);
export type FontStyle = z.infer<typeof FontStyleSchema>;


export const FontWeightSchema = z.enum([
    "normal",
    "bold",
]);
export type FontWeight = z.infer<typeof FontWeightSchema>;

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

export const InterpolateSchema = z.enum([
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
]);
export type Interpolate = z.infer<typeof InterpolateSchema>;

// The orientation of a non-stacked bar, tick, area, and line charts.
// The value is either horizontal (default) or vertical.
// - For bar, rule and tick, this determines whether the size of the bar and tick
// should be applied to x or y dimension.
// - For area, this property determines the orient property of the Vega output.
// - For line, this property determines the sort order of the points in the line
// if `config.sortLineBy` is not specified.
// For stacked charts, this is always determined by the orientation of the stack;
// therefore explicitly specified value will be ignored.

export const OrientSchema = z.enum([
    "horizontal",
    "vertical",
]);
export type Orient = z.infer<typeof OrientSchema>;


export const LabelOverlapEnumSchema = z.enum([
    "parity",
    "greedy",
]);
export type LabelOverlapEnum = z.infer<typeof LabelOverlapEnumSchema>;

// Defines how Vega-Lite generates title for fields.  There are three possible styles:
//
// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
// "Year-month of date", "field (binned)").
// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
// "field").

export const FieldTitleSchema = z.enum([
    "verbal",
    "functional",
    "plain",
]);
export type FieldTitle = z.infer<typeof FieldTitleSchema>;

// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
// - If set to `"filter"` (default), all data items with null values are filtered.
// - If `null`, all data items are included. In this case, invalid values will be
// interpreted as zeroes.

export const InvalidValuesSchema = z.enum([
    "filter",
]);
export type InvalidValues = z.infer<typeof InvalidValuesSchema>;

// The orientation of the legend, which determines how the legend is positioned within the
// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
// "none".
//
// __Default value:__ `"right"`

export const LegendOrientSchema = z.enum([
    "left",
    "right",
    "top-left",
    "top-right",
    "bottom-left",
    "bottom-right",
    "none",
]);
export type LegendOrient = z.infer<typeof LegendOrientSchema>;

// The cartographic projection to use. This value is case-insensitive, for example
// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
// projection types [in the
// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
//
// __Default value:__ `mercator`

export const VgProjectionTypeSchema = z.enum([
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
]);
export type VgProjectionType = z.infer<typeof VgProjectionTypeSchema>;

// Establishes a two-way binding between the interval selection and the scales
// used within the same view. This allows a user to interactively pan and
// zoom the view.

export const BindEnumSchema = z.enum([
    "scales",
]);
export type BindEnum = z.infer<typeof BindEnumSchema>;

// By default, all data values are considered to lie within an empty selection.
// When set to `none`, empty selections contain no data values.

export const EmptySchema = z.enum([
    "all",
    "none",
]);
export type Empty = z.infer<typeof EmptySchema>;


export const SingleDefChannelSchema = z.enum([
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
]);
export type SingleDefChannel = z.infer<typeof SingleDefChannelSchema>;

// With layered and multi-view displays, a strategy that determines how
// selections' data queries are resolved when applied in a filter transform,
// conditional encoding rule, or scale domain.

export const SelectionResolutionSchema = z.enum([
    "global",
    "union",
    "intersect",
]);
export type SelectionResolution = z.infer<typeof SelectionResolutionSchema>;

// Default stack offset for stackable mark.

export const StackOffsetSchema = z.enum([
    "zero",
    "center",
    "normalize",
]);
export type StackOffset = z.infer<typeof StackOffsetSchema>;

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

export const AnchorSchema = z.enum([
    "start",
    "middle",
    "end",
]);
export type Anchor = z.infer<typeof AnchorSchema>;

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

export const TitleOrientSchema = z.enum([
    "top",
    "bottom",
    "left",
    "right",
]);
export type TitleOrient = z.infer<typeof TitleOrientSchema>;


export const ParseEnumSchema = z.enum([
    "auto",
]);
export type ParseEnum = z.infer<typeof ParseEnumSchema>;

// Type of input data: `"json"`, `"csv"`, `"tsv"`.
// The default format type is determined by the extension of the file URL.
// If no extension is detected, `"json"` will be used by default.

export const DataFormatTypeSchema = z.enum([
    "csv",
    "tsv",
    "json",
    "topojson",
]);
export type DataFormatType = z.infer<typeof DataFormatTypeSchema>;

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

export const AggregateOpSchema = z.enum([
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
]);
export type AggregateOp = z.infer<typeof AggregateOpSchema>;

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

export const TimeUnitSchema = z.enum([
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
]);
export type TimeUnit = z.infer<typeof TimeUnitSchema>;


export const RepeatEnumSchema = z.enum([
    "row",
    "column",
]);
export type RepeatEnum = z.infer<typeof RepeatEnumSchema>;

// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
// continuous color gradient.
//
// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
// `"symbol"` otherwise.

export const LegendTypeSchema = z.enum([
    "symbol",
    "gradient",
]);
export type LegendType = z.infer<typeof LegendTypeSchema>;


export const DomainSchema = z.enum([
    "unaggregated",
]);
export type Domain = z.infer<typeof DomainSchema>;


export const InterpolateParamsTypeSchema = z.enum([
    "rgb",
    "cubehelix",
    "cubehelix-long",
]);
export type InterpolateParamsType = z.infer<typeof InterpolateParamsTypeSchema>;


export const NiceTimeSchema = z.enum([
    "second",
    "minute",
    "hour",
    "day",
    "week",
    "month",
    "year",
]);
export type NiceTime = z.infer<typeof NiceTimeSchema>;

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

export const ScaleTypeSchema = z.enum([
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
]);
export type ScaleType = z.infer<typeof ScaleTypeSchema>;


export const SortEnumSchema = z.enum([
    "ascending",
    "descending",
]);
export type SortEnum = z.infer<typeof SortEnumSchema>;

// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
// `"nominal"`).
// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
// [geographic projection](projection.html) is applied.
//
// Constants and utilities for data type
// Data type based on level of measurement

export const TypeSchema = z.enum([
    "quantitative",
    "ordinal",
    "temporal",
    "nominal",
    "latitude",
    "longitude",
    "geojson",
]);
export type Type = z.infer<typeof TypeSchema>;

// All types of primitive marks.
//
// The mark type.
// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.

export const MarkSchema = z.enum([
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
]);
export type Mark = z.infer<typeof MarkSchema>;


export const ResolveModeSchema = z.enum([
    "independent",
    "shared",
]);
export type ResolveMode = z.infer<typeof ResolveModeSchema>;


export const SelectionDefTypeSchema = z.enum([
    "single",
    "multi",
    "interval",
]);
export type SelectionDefType = z.infer<typeof SelectionDefTypeSchema>;

export type Selection = {
    "not"?: Selection | string;
    "and"?: Array<Selection | string>;
    "or"?: Array<Selection | string>;
};
export const SelectionSchema: z.ZodType<Selection> = z.lazy(() =>
    z.object({
        "not": z.union([SelectionSchema, z.string()]).optional(),
        "and": z.array(z.union([SelectionSchema, z.string()])).optional(),
        "or": z.array(z.union([SelectionSchema, z.string()])).optional(),
    })
);

export type Predicate = {
    "not"?: Predicate | string;
    "and"?: Array<Predicate | string>;
    "or"?: Array<Predicate | string>;
    "equal"?: boolean | DateTime | number | string;
    "field"?: string;
    "timeUnit"?: TimeUnit;
    "range"?: Array<DateTime | number | null>;
    "oneOf"?: Array<boolean | DateTime | number | string>;
    "selection"?: Selection | string;
};
export const PredicateSchema: z.ZodType<Predicate> = z.lazy(() =>
    z.object({
        "not": z.union([PredicateSchema, z.string()]).optional(),
        "and": z.array(z.union([PredicateSchema, z.string()])).optional(),
        "or": z.array(z.union([PredicateSchema, z.string()])).optional(),
        "equal": z.union([z.boolean(), DateTimeSchema, z.number(), z.string()]).optional(),
        "field": z.string().optional(),
        "timeUnit": TimeUnitSchema.optional(),
        "range": z.array(z.union([z.null(), DateTimeSchema, z.number()])).min(2).max(2).optional(),
        "oneOf": z.array(z.union([z.boolean(), DateTimeSchema, z.number(), z.string()])).optional(),
        "selection": z.union([SelectionSchema, z.string()]).optional(),
    })
);

export type Spec = {
    "data"?: Data;
    "description"?: string;
    "height"?: number;
    "layer"?: Array<LayerSpec>;
    "name"?: string;
    "resolve"?: Resolve;
    "title"?: TitleParams | string;
    "transform"?: Array<Transform>;
    "width"?: number;
    "encoding"?: Encoding;
    "mark"?: MarkDef | Mark;
    "projection"?: Projection;
    "selection"?: Record<string, SelectionDef>;
    "facet"?: FacetMapping;
    "spec"?: Spec;
    "repeat"?: Repeat;
    "vconcat"?: Array<Spec>;
    "hconcat"?: Array<Spec>;
};
export const SpecSchema: z.ZodType<Spec> = z.lazy(() =>
    z.object({
        "data": DataSchema.optional(),
        "description": z.string().optional(),
        "height": z.number().optional(),
        "layer": z.array(LayerSpecSchema).optional(),
        "name": z.string().optional(),
        "resolve": ResolveSchema.optional(),
        "title": z.union([TitleParamsSchema, z.string()]).optional(),
        "transform": z.array(TransformSchema).optional(),
        "width": z.number().optional(),
        "encoding": EncodingSchema.optional(),
        "mark": z.union([MarkDefSchema, MarkSchema]).optional(),
        "projection": ProjectionSchema.optional(),
        "selection": z.record(z.string(), SelectionDefSchema).optional(),
        "facet": FacetMappingSchema.optional(),
        "spec": SpecSchema.optional(),
        "repeat": RepeatSchema.optional(),
        "vconcat": z.array(SpecSchema).optional(),
        "hconcat": z.array(SpecSchema).optional(),
    })
);

export type LayerSpec = {
    "data"?: Data;
    "description"?: string;
    "height"?: number;
    "layer"?: Array<LayerSpec>;
    "name"?: string;
    "resolve"?: Resolve;
    "title"?: TitleParams | string;
    "transform"?: Array<Transform>;
    "width"?: number;
    "encoding"?: Encoding;
    "mark"?: MarkDef | Mark;
    "projection"?: Projection;
    "selection"?: Record<string, SelectionDef>;
};
export const LayerSpecSchema: z.ZodType<LayerSpec> = z.lazy(() =>
    z.object({
        "data": DataSchema.optional(),
        "description": z.string().optional(),
        "height": z.number().optional(),
        "layer": z.array(LayerSpecSchema).optional(),
        "name": z.string().optional(),
        "resolve": ResolveSchema.optional(),
        "title": z.union([TitleParamsSchema, z.string()]).optional(),
        "transform": z.array(TransformSchema).optional(),
        "width": z.number().optional(),
        "encoding": EncodingSchema.optional(),
        "mark": z.union([MarkDefSchema, MarkSchema]).optional(),
        "projection": ProjectionSchema.optional(),
        "selection": z.record(z.string(), SelectionDefSchema).optional(),
    })
);

export const AutoSizeParamsSchema = z.object({
    "contains": ContainsSchema.optional(),
    "resize": z.boolean().optional(),
    "type": AutosizeTypeSchema.optional(),
});
export type AutoSizeParams = z.infer<typeof AutoSizeParamsSchema>;

export const MarkConfigSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "color": z.string().optional(),
    "cursor": CursorSchema.optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "filled": z.boolean().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
});
export type MarkConfig = z.infer<typeof MarkConfigSchema>;

export const AxisConfigSchema = z.object({
    "bandPosition": z.number().optional(),
    "domain": z.boolean().optional(),
    "domainColor": z.string().optional(),
    "domainWidth": z.number().optional(),
    "grid": z.boolean().optional(),
    "gridColor": z.string().optional(),
    "gridDash": z.array(z.number()).optional(),
    "gridOpacity": z.number().min(0).max(1).optional(),
    "gridWidth": z.number().min(0).optional(),
    "labelAngle": z.number().min(-360).max(360).optional(),
    "labelBound": z.union([z.boolean(), z.number()]).optional(),
    "labelColor": z.string().optional(),
    "labelFlush": z.union([z.boolean(), z.number()]).optional(),
    "labelFont": z.string().optional(),
    "labelFontSize": z.number().min(0).optional(),
    "labelLimit": z.number().optional(),
    "labelOverlap": z.union([z.boolean(), LabelOverlapEnumSchema]).optional(),
    "labelPadding": z.number().optional(),
    "labels": z.boolean().optional(),
    "maxExtent": z.number().optional(),
    "minExtent": z.number().optional(),
    "shortTimeLabels": z.boolean().optional(),
    "tickColor": z.string().optional(),
    "tickRound": z.boolean().optional(),
    "ticks": z.boolean().optional(),
    "tickSize": z.number().min(0).optional(),
    "tickWidth": z.number().min(0).optional(),
    "titleAlign": z.string().optional(),
    "titleAngle": z.number().optional(),
    "titleBaseline": z.string().optional(),
    "titleColor": z.string().optional(),
    "titleFont": z.string().optional(),
    "titleFontSize": z.number().min(0).optional(),
    "titleFontWeight": z.union([z.number(), z.string()]).optional(),
    "titleLimit": z.number().optional(),
    "titleMaxLength": z.number().optional(),
    "titlePadding": z.number().optional(),
    "titleX": z.number().optional(),
    "titleY": z.number().optional(),
});
export type AxisConfig = z.infer<typeof AxisConfigSchema>;

export const VgAxisConfigSchema = z.object({
    "bandPosition": z.number().optional(),
    "domain": z.boolean().optional(),
    "domainColor": z.string().optional(),
    "domainWidth": z.number().optional(),
    "grid": z.boolean().optional(),
    "gridColor": z.string().optional(),
    "gridDash": z.array(z.number()).optional(),
    "gridOpacity": z.number().min(0).max(1).optional(),
    "gridWidth": z.number().min(0).optional(),
    "labelAngle": z.number().min(-360).max(360).optional(),
    "labelBound": z.union([z.boolean(), z.number()]).optional(),
    "labelColor": z.string().optional(),
    "labelFlush": z.union([z.boolean(), z.number()]).optional(),
    "labelFont": z.string().optional(),
    "labelFontSize": z.number().min(0).optional(),
    "labelLimit": z.number().optional(),
    "labelOverlap": z.union([z.boolean(), LabelOverlapEnumSchema]).optional(),
    "labelPadding": z.number().optional(),
    "labels": z.boolean().optional(),
    "maxExtent": z.number().optional(),
    "minExtent": z.number().optional(),
    "tickColor": z.string().optional(),
    "tickRound": z.boolean().optional(),
    "ticks": z.boolean().optional(),
    "tickSize": z.number().min(0).optional(),
    "tickWidth": z.number().min(0).optional(),
    "titleAlign": z.string().optional(),
    "titleAngle": z.number().optional(),
    "titleBaseline": z.string().optional(),
    "titleColor": z.string().optional(),
    "titleFont": z.string().optional(),
    "titleFontSize": z.number().min(0).optional(),
    "titleFontWeight": z.union([z.number(), z.string()]).optional(),
    "titleLimit": z.number().optional(),
    "titleMaxLength": z.number().optional(),
    "titlePadding": z.number().optional(),
    "titleX": z.number().optional(),
    "titleY": z.number().optional(),
});
export type VgAxisConfig = z.infer<typeof VgAxisConfigSchema>;

export const BarConfigSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "binSpacing": z.number().min(0).optional(),
    "color": z.string().optional(),
    "continuousBandSize": z.number().min(0).optional(),
    "cursor": CursorSchema.optional(),
    "discreteBandSize": z.number().min(0).optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "filled": z.boolean().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
});
export type BarConfig = z.infer<typeof BarConfigSchema>;

export const LegendConfigSchema = z.object({
    "cornerRadius": z.number().optional(),
    "entryPadding": z.number().optional(),
    "fillColor": z.string().optional(),
    "gradientHeight": z.number().min(0).optional(),
    "gradientLabelBaseline": z.string().optional(),
    "gradientLabelLimit": z.number().optional(),
    "gradientLabelOffset": z.number().optional(),
    "gradientStrokeColor": z.string().optional(),
    "gradientStrokeWidth": z.number().min(0).optional(),
    "gradientWidth": z.number().min(0).optional(),
    "labelAlign": z.string().optional(),
    "labelBaseline": z.string().optional(),
    "labelColor": z.string().optional(),
    "labelFont": z.string().optional(),
    "labelFontSize": z.number().min(0).optional(),
    "labelLimit": z.number().optional(),
    "labelOffset": z.number().min(0).optional(),
    "offset": z.number().optional(),
    "orient": LegendOrientSchema.optional(),
    "padding": z.number().optional(),
    "shortTimeLabels": z.boolean().optional(),
    "strokeColor": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeWidth": z.number().optional(),
    "symbolColor": z.string().optional(),
    "symbolSize": z.number().min(0).optional(),
    "symbolStrokeWidth": z.number().min(0).optional(),
    "symbolType": z.string().optional(),
    "titleAlign": z.string().optional(),
    "titleBaseline": z.string().optional(),
    "titleColor": z.string().optional(),
    "titleFont": z.string().optional(),
    "titleFontSize": z.number().optional(),
    "titleFontWeight": z.union([z.number(), z.string()]).optional(),
    "titleLimit": z.number().optional(),
    "titlePadding": z.number().optional(),
});
export type LegendConfig = z.infer<typeof LegendConfigSchema>;

export const PaddingClassSchema = z.object({
    "bottom": z.number().optional(),
    "left": z.number().optional(),
    "right": z.number().optional(),
    "top": z.number().optional(),
});
export type PaddingClass = z.infer<typeof PaddingClassSchema>;

export const ProjectionConfigSchema = z.object({
    "center": z.array(z.number()).optional(),
    "clipAngle": z.number().optional(),
    "clipExtent": z.array(z.array(z.number())).optional(),
    "coefficient": z.number().optional(),
    "distance": z.number().optional(),
    "fraction": z.number().optional(),
    "lobes": z.number().optional(),
    "parallel": z.number().optional(),
    "precision": z.record(z.string(), z.union([z.number(), z.string()])).optional(),
    "radius": z.number().optional(),
    "ratio": z.number().optional(),
    "rotate": z.array(z.number()).optional(),
    "spacing": z.number().optional(),
    "tilt": z.number().optional(),
    "type": VgProjectionTypeSchema.optional(),
});
export type ProjectionConfig = z.infer<typeof ProjectionConfigSchema>;

export const VgSchemeSchema = z.object({
    "count": z.number().optional(),
    "extent": z.array(z.number()).optional(),
    "scheme": z.string().optional(),
    "step": z.number().optional(),
});
export type VgScheme = z.infer<typeof VgSchemeSchema>;

export const ScaleConfigSchema = z.object({
    "bandPaddingInner": z.number().min(0).max(1).optional(),
    "bandPaddingOuter": z.number().min(0).max(1).optional(),
    "clamp": z.boolean().optional(),
    "continuousPadding": z.number().min(0).optional(),
    "maxBandSize": z.number().min(0).optional(),
    "maxFontSize": z.number().min(0).optional(),
    "maxOpacity": z.number().min(0).max(1).optional(),
    "maxSize": z.number().min(0).optional(),
    "maxStrokeWidth": z.number().min(0).optional(),
    "minBandSize": z.number().min(0).optional(),
    "minFontSize": z.number().min(0).optional(),
    "minOpacity": z.number().min(0).max(1).optional(),
    "minSize": z.number().min(0).optional(),
    "minStrokeWidth": z.number().min(0).optional(),
    "pointPadding": z.number().min(0).max(1).optional(),
    "rangeStep": z.union([z.null(), z.number().min(0)]).optional(),
    "round": z.boolean().optional(),
    "textXRangeStep": z.number().min(0).optional(),
    "useUnaggregatedDomain": z.boolean().optional(),
});
export type ScaleConfig = z.infer<typeof ScaleConfigSchema>;

export const BrushConfigSchema = z.object({
    "fill": z.string().optional(),
    "fillOpacity": z.number().optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().optional(),
    "strokeWidth": z.number().optional(),
});
export type BrushConfig = z.infer<typeof BrushConfigSchema>;

export const MultiSelectionConfigSchema = z.object({
    "empty": EmptySchema.optional(),
    "encodings": z.array(SingleDefChannelSchema).optional(),
    "fields": z.array(z.string()).optional(),
    "nearest": z.boolean().optional(),
    "on": z.any().optional(),
    "resolve": SelectionResolutionSchema.optional(),
    "toggle": z.union([z.boolean(), z.string()]).optional(),
});
export type MultiSelectionConfig = z.infer<typeof MultiSelectionConfigSchema>;

export const VgBindingSchema = z.object({
    "element": z.string().optional(),
    "input": z.string(),
    "options": z.array(z.string()).optional(),
    "max": z.number().optional(),
    "min": z.number().optional(),
    "step": z.number().optional(),
});
export type VgBinding = z.infer<typeof VgBindingSchema>;

export const VgMarkConfigSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "cursor": CursorSchema.optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
});
export type VgMarkConfig = z.infer<typeof VgMarkConfigSchema>;

export const TextConfigSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "color": z.string().optional(),
    "cursor": CursorSchema.optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "filled": z.boolean().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "shortTimeLabels": z.boolean().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
});
export type TextConfig = z.infer<typeof TextConfigSchema>;

export const TickConfigSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "bandSize": z.number().min(0).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "color": z.string().optional(),
    "cursor": CursorSchema.optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "filled": z.boolean().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
    "thickness": z.number().min(0).optional(),
});
export type TickConfig = z.infer<typeof TickConfigSchema>;

export const VgTitleConfigSchema = z.object({
    "anchor": AnchorSchema.optional(),
    "angle": z.number().optional(),
    "baseline": VerticalAlignSchema.optional(),
    "color": z.string().optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "limit": z.number().min(0).optional(),
    "offset": z.number().optional(),
    "orient": TitleOrientSchema.optional(),
});
export type VgTitleConfig = z.infer<typeof VgTitleConfigSchema>;

export const ViewConfigSchema = z.object({
    "clip": z.boolean().optional(),
    "fill": z.string().optional(),
    "fillOpacity": z.number().optional(),
    "height": z.number().optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().optional(),
    "strokeWidth": z.number().optional(),
    "width": z.number().optional(),
});
export type ViewConfig = z.infer<typeof ViewConfigSchema>;

export const DataFormatSchema = z.object({
    "parse": z.union([ParseEnumSchema, z.record(z.string(), z.any())]).optional(),
    "type": DataFormatTypeSchema.optional(),
    "property": z.string().optional(),
    "feature": z.string().optional(),
    "mesh": z.string().optional(),
});
export type DataFormat = z.infer<typeof DataFormatSchema>;

export const BinParamsSchema = z.object({
    "base": z.number().optional(),
    "divide": z.array(z.number()).min(1).optional(),
    "extent": z.array(z.number()).min(2).max(2).optional(),
    "maxbins": z.number().min(2).optional(),
    "minstep": z.number().optional(),
    "nice": z.boolean().optional(),
    "step": z.number().optional(),
    "steps": z.array(z.number()).min(1).optional(),
});
export type BinParams = z.infer<typeof BinParamsSchema>;

export const ConditionalValueDefSchema = z.object({
    "test": z.union([PredicateSchema, z.string()]).optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]),
    "selection": z.union([SelectionSchema, z.string()]).optional(),
});
export type ConditionalValueDef = z.infer<typeof ConditionalValueDefSchema>;

export const DateTimeSchema = z.object({
    "date": z.number().min(1).max(31).optional(),
    "day": z.union([z.number().min(1).max(7), z.string()]).optional(),
    "hours": z.number().min(0).max(23).optional(),
    "milliseconds": z.number().min(0).max(999).optional(),
    "minutes": z.number().min(0).max(59).optional(),
    "month": z.union([z.number().min(1).max(12), z.string()]).optional(),
    "quarter": z.number().min(1).max(4).optional(),
    "seconds": z.number().min(0).max(59).optional(),
    "utc": z.boolean().optional(),
    "year": z.number().optional(),
});
export type DateTime = z.infer<typeof DateTimeSchema>;

export const RepeatRefSchema = z.object({
    "repeat": RepeatEnumSchema,
});
export type RepeatRef = z.infer<typeof RepeatRefSchema>;

export const LegendSchema = z.object({
    "entryPadding": z.number().optional(),
    "format": z.string().optional(),
    "offset": z.number().optional(),
    "orient": LegendOrientSchema.optional(),
    "padding": z.number().optional(),
    "tickCount": z.number().optional(),
    "title": z.union([z.null(), z.string()]).optional(),
    "type": LegendTypeSchema.optional(),
    "values": z.array(z.union([DateTimeSchema, z.number(), z.string()])).optional(),
    "zindex": z.number().min(0).optional(),
});
export type Legend = z.infer<typeof LegendSchema>;

export const DomainClassSchema = z.object({
    "field": z.string().optional(),
    "selection": z.string(),
    "encoding": z.string().optional(),
});
export type DomainClass = z.infer<typeof DomainClassSchema>;

export const InterpolateParamsSchema = z.object({
    "gamma": z.number().optional(),
    "type": InterpolateParamsTypeSchema,
});
export type InterpolateParams = z.infer<typeof InterpolateParamsSchema>;

export const NiceClassSchema = z.object({
    "interval": z.string(),
    "step": z.number(),
});
export type NiceClass = z.infer<typeof NiceClassSchema>;

export const SchemeParamsSchema = z.object({
    "extent": z.array(z.number()).optional(),
    "name": z.string(),
});
export type SchemeParams = z.infer<typeof SchemeParamsSchema>;

export const SortFieldSchema = z.object({
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "op": AggregateOpSchema,
    "order": z.union([z.null(), SortEnumSchema]).optional(),
});
export type SortField = z.infer<typeof SortFieldSchema>;

export const HeaderSchema = z.object({
    "format": z.string().optional(),
    "labelAngle": z.number().min(-360).max(360).optional(),
    "title": z.union([z.null(), z.string()]).optional(),
});
export type Header = z.infer<typeof HeaderSchema>;

export const FieldDefSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema,
});
export type FieldDef = z.infer<typeof FieldDefSchema>;

export const ConditionalPredicateFieldDefClassSchema = z.object({
    "test": z.union([PredicateSchema, z.string()]).optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
    "selection": z.union([SelectionSchema, z.string()]).optional(),
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
});
export type ConditionalPredicateFieldDefClass = z.infer<typeof ConditionalPredicateFieldDefClassSchema>;

export const OrderFieldDefSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "sort": z.union([z.null(), SortEnumSchema]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema,
});
export type OrderFieldDef = z.infer<typeof OrderFieldDefSchema>;

export const ConditionalPredicateTextFieldDefClassSchema = z.object({
    "test": z.union([PredicateSchema, z.string()]).optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
    "selection": z.union([SelectionSchema, z.string()]).optional(),
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "format": z.string().optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
});
export type ConditionalPredicateTextFieldDefClass = z.infer<typeof ConditionalPredicateTextFieldDefClassSchema>;

export const AxisSchema = z.object({
    "domain": z.boolean().optional(),
    "format": z.string().optional(),
    "grid": z.boolean().optional(),
    "labelAngle": z.number().min(-360).max(360).optional(),
    "labelBound": z.union([z.boolean(), z.number()]).optional(),
    "labelFlush": z.union([z.boolean(), z.number()]).optional(),
    "labelOverlap": z.union([z.boolean(), LabelOverlapEnumSchema]).optional(),
    "labelPadding": z.number().optional(),
    "labels": z.boolean().optional(),
    "maxExtent": z.number().optional(),
    "minExtent": z.number().optional(),
    "offset": z.number().optional(),
    "orient": TitleOrientSchema.optional(),
    "position": z.number().optional(),
    "tickCount": z.number().optional(),
    "ticks": z.boolean().optional(),
    "tickSize": z.number().min(0).optional(),
    "title": z.union([z.null(), z.string()]).optional(),
    "titleMaxLength": z.number().optional(),
    "titlePadding": z.number().optional(),
    "values": z.array(z.union([DateTimeSchema, z.number()])).optional(),
    "zindex": z.number().min(0).optional(),
});
export type Axis = z.infer<typeof AxisSchema>;

export const X2ClassSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
});
export type X2Class = z.infer<typeof X2ClassSchema>;

export const MarkDefSchema = z.object({
    "align": HorizontalAlignSchema.optional(),
    "angle": z.number().min(0).max(360).optional(),
    "baseline": VerticalAlignSchema.optional(),
    "clip": z.boolean().optional(),
    "color": z.string().optional(),
    "cursor": CursorSchema.optional(),
    "dx": z.number().optional(),
    "dy": z.number().optional(),
    "fill": z.string().optional(),
    "filled": z.boolean().optional(),
    "fillOpacity": z.number().min(0).max(1).optional(),
    "font": z.string().optional(),
    "fontSize": z.number().min(0).optional(),
    "fontStyle": FontStyleSchema.optional(),
    "fontWeight": z.union([z.number().min(100).max(900), FontWeightSchema]).optional(),
    "href": z.string().optional(),
    "interpolate": InterpolateSchema.optional(),
    "limit": z.number().optional(),
    "opacity": z.number().min(0).max(1).optional(),
    "orient": OrientSchema.optional(),
    "radius": z.number().min(0).optional(),
    "shape": z.string().optional(),
    "size": z.number().min(0).optional(),
    "stroke": z.string().optional(),
    "strokeDash": z.array(z.number()).optional(),
    "strokeDashOffset": z.number().optional(),
    "strokeOpacity": z.number().min(0).max(1).optional(),
    "strokeWidth": z.number().min(0).optional(),
    "style": z.union([z.array(z.string()), z.string()]).optional(),
    "tension": z.number().min(0).max(1).optional(),
    "text": z.string().optional(),
    "theta": z.number().optional(),
    "type": MarkSchema,
});
export type MarkDef = z.infer<typeof MarkDefSchema>;

export const ProjectionSchema = z.object({
    "center": z.array(z.number()).optional(),
    "clipAngle": z.number().optional(),
    "clipExtent": z.array(z.array(z.number())).optional(),
    "coefficient": z.number().optional(),
    "distance": z.number().optional(),
    "fraction": z.number().optional(),
    "lobes": z.number().optional(),
    "parallel": z.number().optional(),
    "precision": z.record(z.string(), z.union([z.number(), z.string()])).optional(),
    "radius": z.number().optional(),
    "ratio": z.number().optional(),
    "rotate": z.array(z.number()).optional(),
    "spacing": z.number().optional(),
    "tilt": z.number().optional(),
    "type": VgProjectionTypeSchema.optional(),
});
export type Projection = z.infer<typeof ProjectionSchema>;

export const AxisResolveMapSchema = z.object({
    "x": ResolveModeSchema.optional(),
    "y": ResolveModeSchema.optional(),
});
export type AxisResolveMap = z.infer<typeof AxisResolveMapSchema>;

export const LegendResolveMapSchema = z.object({
    "color": ResolveModeSchema.optional(),
    "opacity": ResolveModeSchema.optional(),
    "shape": ResolveModeSchema.optional(),
    "size": ResolveModeSchema.optional(),
});
export type LegendResolveMap = z.infer<typeof LegendResolveMapSchema>;

export const ScaleResolveMapSchema = z.object({
    "color": ResolveModeSchema.optional(),
    "opacity": ResolveModeSchema.optional(),
    "shape": ResolveModeSchema.optional(),
    "size": ResolveModeSchema.optional(),
    "x": ResolveModeSchema.optional(),
    "y": ResolveModeSchema.optional(),
});
export type ScaleResolveMap = z.infer<typeof ScaleResolveMapSchema>;

export const SelectionDefSchema = z.object({
    "bind": z.union([BindEnumSchema, z.record(z.string(), VgBindingSchema)]).optional(),
    "empty": EmptySchema.optional(),
    "encodings": z.array(SingleDefChannelSchema).optional(),
    "fields": z.array(z.string()).optional(),
    "nearest": z.boolean().optional(),
    "on": z.any().optional(),
    "resolve": SelectionResolutionSchema.optional(),
    "type": SelectionDefTypeSchema,
    "toggle": z.union([z.boolean(), z.string()]).optional(),
    "mark": BrushConfigSchema.optional(),
    "translate": z.union([z.boolean(), z.string()]).optional(),
    "zoom": z.union([z.boolean(), z.string()]).optional(),
});
export type SelectionDef = z.infer<typeof SelectionDefSchema>;

export const TitleParamsSchema = z.object({
    "anchor": AnchorSchema.optional(),
    "offset": z.number().optional(),
    "orient": TitleOrientSchema.optional(),
    "style": z.union([z.array(z.string()), z.string()]).optional(),
    "text": z.string(),
});
export type TitleParams = z.infer<typeof TitleParamsSchema>;

export const AggregatedFieldDefSchema = z.object({
    "as": z.string(),
    "field": z.string(),
    "op": AggregateOpSchema,
});
export type AggregatedFieldDef = z.infer<typeof AggregatedFieldDefSchema>;

export const RepeatSchema = z.object({
    "column": z.array(z.string()).optional(),
    "row": z.array(z.string()).optional(),
});
export type Repeat = z.infer<typeof RepeatSchema>;

export const IntervalSelectionConfigSchema = z.object({
    "bind": BindEnumSchema.optional(),
    "empty": EmptySchema.optional(),
    "encodings": z.array(SingleDefChannelSchema).optional(),
    "fields": z.array(z.string()).optional(),
    "mark": BrushConfigSchema.optional(),
    "on": z.any().optional(),
    "resolve": SelectionResolutionSchema.optional(),
    "translate": z.union([z.boolean(), z.string()]).optional(),
    "zoom": z.union([z.boolean(), z.string()]).optional(),
});
export type IntervalSelectionConfig = z.infer<typeof IntervalSelectionConfigSchema>;

export const SingleSelectionConfigSchema = z.object({
    "bind": z.record(z.string(), VgBindingSchema).optional(),
    "empty": EmptySchema.optional(),
    "encodings": z.array(SingleDefChannelSchema).optional(),
    "fields": z.array(z.string()).optional(),
    "nearest": z.boolean().optional(),
    "on": z.any().optional(),
    "resolve": SelectionResolutionSchema.optional(),
});
export type SingleSelectionConfig = z.infer<typeof SingleSelectionConfigSchema>;

export const DataSchema = z.object({
    "format": DataFormatSchema.optional(),
    "url": z.string().optional(),
    "values": z.union([z.array(z.union([z.boolean(), z.number(), z.record(z.string(), z.any()), z.string()])), z.record(z.string(), z.any()), z.string()]).optional(),
    "name": z.string().optional(),
});
export type Data = z.infer<typeof DataSchema>;

export const ScaleSchema = z.object({
    "base": z.number().optional(),
    "clamp": z.boolean().optional(),
    "domain": z.union([z.array(z.union([z.boolean(), DateTimeSchema, z.number(), z.string()])), DomainClassSchema, DomainSchema]).optional(),
    "exponent": z.number().optional(),
    "interpolate": z.union([InterpolateParamsSchema, InterpolateSchema]).optional(),
    "nice": z.union([z.boolean(), NiceClassSchema, z.number(), NiceTimeSchema]).optional(),
    "padding": z.number().min(0).optional(),
    "paddingInner": z.number().min(0).max(1).optional(),
    "paddingOuter": z.number().min(0).max(1).optional(),
    "range": z.union([z.array(z.union([z.number(), z.string()])), z.string()]).optional(),
    "rangeStep": z.union([z.null(), z.number().min(0)]).optional(),
    "round": z.boolean().optional(),
    "scheme": z.union([SchemeParamsSchema, z.string()]).optional(),
    "type": ScaleTypeSchema.optional(),
    "zero": z.boolean().optional(),
});
export type Scale = z.infer<typeof ScaleSchema>;

export const FacetFieldDefSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "header": HeaderSchema.optional(),
    "sort": z.union([z.null(), SortEnumSchema]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema,
});
export type FacetFieldDef = z.infer<typeof FacetFieldDefSchema>;

export const DefWithConditionSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "condition": z.union([z.array(ConditionalValueDefSchema), ConditionalPredicateFieldDefClassSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
});
export type DefWithCondition = z.infer<typeof DefWithConditionSchema>;

export const TextDefWithConditionSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "condition": z.union([z.array(ConditionalValueDefSchema), ConditionalPredicateTextFieldDefClassSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "format": z.string().optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
});
export type TextDefWithCondition = z.infer<typeof TextDefWithConditionSchema>;

export const XClassSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "axis": z.union([z.null(), AxisSchema]).optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "scale": ScaleSchema.optional(),
    "sort": z.union([z.null(), SortFieldSchema, SortEnumSchema]).optional(),
    "stack": z.union([z.null(), StackOffsetSchema]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
});
export type XClass = z.infer<typeof XClassSchema>;

export const FacetMappingSchema = z.object({
    "column": FacetFieldDefSchema.optional(),
    "row": FacetFieldDefSchema.optional(),
});
export type FacetMapping = z.infer<typeof FacetMappingSchema>;

export const ResolveSchema = z.object({
    "axis": AxisResolveMapSchema.optional(),
    "legend": LegendResolveMapSchema.optional(),
    "scale": ScaleResolveMapSchema.optional(),
});
export type Resolve = z.infer<typeof ResolveSchema>;

export const LookupDataSchema = z.object({
    "data": DataSchema,
    "fields": z.array(z.string()).optional(),
    "key": z.string(),
});
export type LookupData = z.infer<typeof LookupDataSchema>;

export const SelectionConfigSchema = z.object({
    "interval": IntervalSelectionConfigSchema.optional(),
    "multi": MultiSelectionConfigSchema.optional(),
    "single": SingleSelectionConfigSchema.optional(),
});
export type SelectionConfig = z.infer<typeof SelectionConfigSchema>;

export const ConditionalPredicateMarkPropFieldDefClassSchema = z.object({
    "test": z.union([PredicateSchema, z.string()]).optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
    "selection": z.union([SelectionSchema, z.string()]).optional(),
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "legend": z.union([z.null(), LegendSchema]).optional(),
    "scale": ScaleSchema.optional(),
    "sort": z.union([z.null(), SortFieldSchema, SortEnumSchema]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
});
export type ConditionalPredicateMarkPropFieldDefClass = z.infer<typeof ConditionalPredicateMarkPropFieldDefClassSchema>;

export const TransformSchema = z.object({
    "filter": z.union([PredicateSchema, z.string()]).optional(),
    "as": z.union([z.array(z.string()), z.string()]).optional(),
    "calculate": z.string().optional(),
    "default": z.string().optional(),
    "from": LookupDataSchema.optional(),
    "lookup": z.string().optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "field": z.string().optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "aggregate": z.array(AggregatedFieldDefSchema).optional(),
    "groupby": z.array(z.string()).optional(),
});
export type Transform = z.infer<typeof TransformSchema>;

export const ConfigSchema = z.object({
    "area": MarkConfigSchema.optional(),
    "autosize": z.union([AutoSizeParamsSchema, AutosizeTypeSchema]).optional(),
    "axis": AxisConfigSchema.optional(),
    "axisBand": VgAxisConfigSchema.optional(),
    "axisBottom": VgAxisConfigSchema.optional(),
    "axisLeft": VgAxisConfigSchema.optional(),
    "axisRight": VgAxisConfigSchema.optional(),
    "axisTop": VgAxisConfigSchema.optional(),
    "axisX": VgAxisConfigSchema.optional(),
    "axisY": VgAxisConfigSchema.optional(),
    "background": z.string().optional(),
    "bar": BarConfigSchema.optional(),
    "circle": MarkConfigSchema.optional(),
    "countTitle": z.string().optional(),
    "fieldTitle": FieldTitleSchema.optional(),
    "geoshape": MarkConfigSchema.optional(),
    "invalidValues": InvalidValuesSchema.optional(),
    "legend": LegendConfigSchema.optional(),
    "line": MarkConfigSchema.optional(),
    "mark": MarkConfigSchema.optional(),
    "numberFormat": z.string().optional(),
    "padding": z.union([PaddingClassSchema, z.number()]).optional(),
    "point": MarkConfigSchema.optional(),
    "projection": ProjectionConfigSchema.optional(),
    "range": z.record(z.string(), z.union([z.array(z.union([z.number(), z.string()])), VgSchemeSchema])).optional(),
    "rect": MarkConfigSchema.optional(),
    "rule": MarkConfigSchema.optional(),
    "scale": ScaleConfigSchema.optional(),
    "selection": SelectionConfigSchema.optional(),
    "square": MarkConfigSchema.optional(),
    "stack": StackOffsetSchema.optional(),
    "style": z.record(z.string(), VgMarkConfigSchema).optional(),
    "text": TextConfigSchema.optional(),
    "tick": TickConfigSchema.optional(),
    "timeFormat": z.string().optional(),
    "title": VgTitleConfigSchema.optional(),
    "view": ViewConfigSchema.optional(),
});
export type Config = z.infer<typeof ConfigSchema>;

export const MarkPropDefWithConditionSchema = z.object({
    "aggregate": AggregateOpSchema.optional(),
    "bin": z.union([z.boolean(), BinParamsSchema]).optional(),
    "condition": z.union([z.array(ConditionalValueDefSchema), ConditionalPredicateMarkPropFieldDefClassSchema]).optional(),
    "field": z.union([RepeatRefSchema, z.string()]).optional(),
    "legend": z.union([z.null(), LegendSchema]).optional(),
    "scale": ScaleSchema.optional(),
    "sort": z.union([z.null(), SortFieldSchema, SortEnumSchema]).optional(),
    "timeUnit": TimeUnitSchema.optional(),
    "type": TypeSchema.optional(),
    "value": z.union([z.boolean(), z.number(), z.string()]).optional(),
});
export type MarkPropDefWithCondition = z.infer<typeof MarkPropDefWithConditionSchema>;

export const EncodingSchema = z.object({
    "color": MarkPropDefWithConditionSchema.optional(),
    "detail": z.union([z.array(FieldDefSchema), FieldDefSchema]).optional(),
    "href": DefWithConditionSchema.optional(),
    "opacity": MarkPropDefWithConditionSchema.optional(),
    "order": z.union([z.array(OrderFieldDefSchema), OrderFieldDefSchema]).optional(),
    "shape": MarkPropDefWithConditionSchema.optional(),
    "size": MarkPropDefWithConditionSchema.optional(),
    "text": TextDefWithConditionSchema.optional(),
    "tooltip": TextDefWithConditionSchema.optional(),
    "x": XClassSchema.optional(),
    "x2": X2ClassSchema.optional(),
    "y": XClassSchema.optional(),
    "y2": X2ClassSchema.optional(),
});
export type Encoding = z.infer<typeof EncodingSchema>;

export const EncodingWithFacetSchema = z.object({
    "color": MarkPropDefWithConditionSchema.optional(),
    "column": FacetFieldDefSchema.optional(),
    "detail": z.union([z.array(FieldDefSchema), FieldDefSchema]).optional(),
    "href": DefWithConditionSchema.optional(),
    "opacity": MarkPropDefWithConditionSchema.optional(),
    "order": z.union([z.array(OrderFieldDefSchema), OrderFieldDefSchema]).optional(),
    "row": FacetFieldDefSchema.optional(),
    "shape": MarkPropDefWithConditionSchema.optional(),
    "size": MarkPropDefWithConditionSchema.optional(),
    "text": TextDefWithConditionSchema.optional(),
    "tooltip": TextDefWithConditionSchema.optional(),
    "x": XClassSchema.optional(),
    "x2": X2ClassSchema.optional(),
    "y": XClassSchema.optional(),
    "y2": X2ClassSchema.optional(),
});
export type EncodingWithFacet = z.infer<typeof EncodingWithFacetSchema>;

export const TopLevelSchema = z.object({
    "$schema": z.string().optional(),
    "autosize": z.union([AutoSizeParamsSchema, AutosizeTypeSchema]).optional(),
    "background": z.string().optional(),
    "config": ConfigSchema.optional(),
    "data": DataSchema.optional(),
    "description": z.string().optional(),
    "encoding": EncodingWithFacetSchema.optional(),
    "height": z.number().optional(),
    "mark": z.union([MarkDefSchema, MarkSchema]).optional(),
    "name": z.string().optional(),
    "padding": z.union([PaddingClassSchema, z.number()]).optional(),
    "projection": ProjectionSchema.optional(),
    "selection": z.record(z.string(), SelectionDefSchema).optional(),
    "title": z.union([TitleParamsSchema, z.string()]).optional(),
    "transform": z.array(TransformSchema).optional(),
    "width": z.number().optional(),
    "layer": z.array(LayerSpecSchema).optional(),
    "resolve": ResolveSchema.optional(),
    "facet": FacetMappingSchema.optional(),
    "spec": SpecSchema.optional(),
    "repeat": RepeatSchema.optional(),
    "vconcat": z.array(SpecSchema).optional(),
    "hconcat": z.array(SpecSchema).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
