// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTAutoSizeParams;
@class QTContains;
@class QTAutosizeType;
@class QTConfig;
@class QTMarkConfig;
@class QTHorizontalAlign;
@class QTVerticalAlign;
@class QTCursor;
@class QTFontStyle;
@class QTFontWeight;
@class QTInterpolate;
@class QTOrient;
@class QTAxisConfig;
@class QTLabelOverlapEnum;
@class QTVGAxisConfig;
@class QTBarConfig;
@class QTFieldTitle;
@class QTInvalidValues;
@class QTLegendConfig;
@class QTLegendOrient;
@class QTPaddingClass;
@class QTProjectionConfig;
@class QTVGProjectionType;
@class QTVGScheme;
@class QTScaleConfig;
@class QTSelectionConfig;
@class QTIntervalSelectionConfig;
@class QTBindEnum;
@class QTEmpty;
@class QTSingleDefChannel;
@class QTBrushConfig;
@class QTSelectionResolution;
@class QTMultiSelectionConfig;
@class QTSingleSelectionConfig;
@class QTVGBinding;
@class QTStackOffset;
@class QTVGMarkConfig;
@class QTTextConfig;
@class QTTickConfig;
@class QTVGTitleConfig;
@class QTAnchor;
@class QTTitleOrient;
@class QTViewConfig;
@class QTData;
@class QTDataFormat;
@class QTParseEnum;
@class QTDataFormatType;
@class QTEncodingWithFacet;
@class QTMarkPropDefWithCondition;
@class QTAggregateOp;
@class QTBinParams;
@class QTConditionalValueDef;
@class QTSelection;
@class QTPredicate;
@class QTDateTime;
@class QTTimeUnit;
@class QTConditionalPredicateMarkPropFieldDefClass;
@class QTRepeatRef;
@class QTRepeatEnum;
@class QTLegend;
@class QTLegendType;
@class QTScale;
@class QTDomainClass;
@class QTDomain;
@class QTInterpolateParams;
@class QTInterpolateParamsType;
@class QTNiceClass;
@class QTNiceTime;
@class QTSchemeParams;
@class QTScaleType;
@class QTSortField;
@class QTSortEnum;
@class QTType;
@class QTFacetFieldDef;
@class QTHeader;
@class QTFieldDef;
@class QTDefWithCondition;
@class QTConditionalPredicateFieldDefClass;
@class QTOrderFieldDef;
@class QTTextDefWithCondition;
@class QTConditionalPredicateTextFieldDefClass;
@class QTXClass;
@class QTAxis;
@class QTX2Class;
@class QTFacetMapping;
@class QTSpec;
@class QTEncoding;
@class QTLayerSpec;
@class QTMarkDef;
@class QTMark;
@class QTProjection;
@class QTResolve;
@class QTAxisResolveMap;
@class QTResolveMode;
@class QTLegendResolveMap;
@class QTScaleResolveMap;
@class QTSelectionDef;
@class QTSelectionDefType;
@class QTTitleParams;
@class QTTransform;
@class QTAggregatedFieldDef;
@class QTLookupData;
@class QTRepeat;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

/// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
/// The default setting (`"content"`) interprets the width and height settings as the data
/// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
/// `"padding"` setting includes the padding within the view size calculations, such that the
/// width and height settings indicate the **total** intended size of the view.
///
/// __Default value__: `"content"`
@interface QTContains : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTContains *)content;
+ (QTContains *)padding;
@end

/// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
/// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
/// descriptions of each.
///
/// __Default value__: `"pad"`
@interface QTAutosizeType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTAutosizeType *)pad;
+ (QTAutosizeType *)fit;
+ (QTAutosizeType *)none;
@end

/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@interface QTHorizontalAlign : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTHorizontalAlign *)left;
+ (QTHorizontalAlign *)right;
+ (QTHorizontalAlign *)center;
@end

/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
///
/// Vertical text baseline for title text.
@interface QTVerticalAlign : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTVerticalAlign *)top;
+ (QTVerticalAlign *)middle;
+ (QTVerticalAlign *)bottom;
@end

/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@interface QTCursor : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCursor *)cursorAuto;
+ (QTCursor *)cursorDefault;
+ (QTCursor *)none;
+ (QTCursor *)contextMenu;
+ (QTCursor *)help;
+ (QTCursor *)pointer;
+ (QTCursor *)progress;
+ (QTCursor *)wait;
+ (QTCursor *)cell;
+ (QTCursor *)crosshair;
+ (QTCursor *)text;
+ (QTCursor *)verticalText;
+ (QTCursor *)alias;
+ (QTCursor *)theCopy;
+ (QTCursor *)move;
+ (QTCursor *)noDrop;
+ (QTCursor *)notAllowed;
+ (QTCursor *)eResize;
+ (QTCursor *)nResize;
+ (QTCursor *)neResize;
+ (QTCursor *)nwResize;
+ (QTCursor *)sResize;
+ (QTCursor *)seResize;
+ (QTCursor *)swResize;
+ (QTCursor *)wResize;
+ (QTCursor *)ewResize;
+ (QTCursor *)nsResize;
+ (QTCursor *)neswResize;
+ (QTCursor *)nwseResize;
+ (QTCursor *)colResize;
+ (QTCursor *)rowResize;
+ (QTCursor *)allScroll;
+ (QTCursor *)zoomIn;
+ (QTCursor *)zoomOut;
+ (QTCursor *)grab;
+ (QTCursor *)grabbing;
@end

/// The font style (e.g., `"italic"`).
@interface QTFontStyle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFontStyle *)normal;
+ (QTFontStyle *)italic;
@end

@interface QTFontWeight : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFontWeight *)normal;
+ (QTFontWeight *)bold;
@end

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
@interface QTInterpolate : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTInterpolate *)linear;
+ (QTInterpolate *)linearClosed;
+ (QTInterpolate *)step;
+ (QTInterpolate *)stepBefore;
+ (QTInterpolate *)stepAfter;
+ (QTInterpolate *)basis;
+ (QTInterpolate *)basisOpen;
+ (QTInterpolate *)basisClosed;
+ (QTInterpolate *)cardinal;
+ (QTInterpolate *)cardinalOpen;
+ (QTInterpolate *)cardinalClosed;
+ (QTInterpolate *)bundle;
+ (QTInterpolate *)monotone;
@end

/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@interface QTOrient : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTOrient *)horizontal;
+ (QTOrient *)vertical;
@end

@interface QTLabelOverlapEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLabelOverlapEnum *)parity;
+ (QTLabelOverlapEnum *)greedy;
@end

/// Defines how Vega-Lite generates title for fields.  There are three possible styles:
///
/// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
/// "Year-month of date", "field (binned)").
/// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
/// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
/// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
/// "field").
@interface QTFieldTitle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFieldTitle *)verbal;
+ (QTFieldTitle *)functional;
+ (QTFieldTitle *)plain;
@end

/// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
/// - If set to `"filter"` (default), all data items with null values are filtered.
/// - If `null`, all data items are included. In this case, invalid values will be
/// interpreted as zeroes.
@interface QTInvalidValues : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTInvalidValues *)filter;
@end

/// The orientation of the legend, which determines how the legend is positioned within the
/// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
/// "none".
///
/// __Default value:__ `"right"`
@interface QTLegendOrient : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLegendOrient *)left;
+ (QTLegendOrient *)right;
+ (QTLegendOrient *)topLeft;
+ (QTLegendOrient *)topRight;
+ (QTLegendOrient *)bottomLeft;
+ (QTLegendOrient *)bottomRight;
+ (QTLegendOrient *)none;
@end

/// The cartographic projection to use. This value is case-insensitive, for example
/// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
/// projection types [in the
/// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
/// __Default value:__ `mercator`
@interface QTVGProjectionType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTVGProjectionType *)albers;
+ (QTVGProjectionType *)albersUsa;
+ (QTVGProjectionType *)azimuthalEqualArea;
+ (QTVGProjectionType *)azimuthalEquidistant;
+ (QTVGProjectionType *)conicConformal;
+ (QTVGProjectionType *)conicEqualArea;
+ (QTVGProjectionType *)conicEquidistant;
+ (QTVGProjectionType *)equirectangular;
+ (QTVGProjectionType *)gnomonic;
+ (QTVGProjectionType *)mercator;
+ (QTVGProjectionType *)orthographic;
+ (QTVGProjectionType *)stereographic;
+ (QTVGProjectionType *)transverseMercator;
@end

/// Establishes a two-way binding between the interval selection and the scales
/// used within the same view. This allows a user to interactively pan and
/// zoom the view.
@interface QTBindEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTBindEnum *)scales;
@end

/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
@interface QTEmpty : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTEmpty *)all;
+ (QTEmpty *)none;
@end

@interface QTSingleDefChannel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSingleDefChannel *)x;
+ (QTSingleDefChannel *)y;
+ (QTSingleDefChannel *)x2;
+ (QTSingleDefChannel *)y2;
+ (QTSingleDefChannel *)row;
+ (QTSingleDefChannel *)column;
+ (QTSingleDefChannel *)size;
+ (QTSingleDefChannel *)shape;
+ (QTSingleDefChannel *)color;
+ (QTSingleDefChannel *)opacity;
+ (QTSingleDefChannel *)text;
+ (QTSingleDefChannel *)tooltip;
+ (QTSingleDefChannel *)href;
@end

/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
@interface QTSelectionResolution : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSelectionResolution *)global;
+ (QTSelectionResolution *)selectionResolutionUnion;
+ (QTSelectionResolution *)intersect;
@end

/// Default stack offset for stackable mark.
@interface QTStackOffset : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStackOffset *)zero;
+ (QTStackOffset *)center;
+ (QTStackOffset *)normalize;
@end

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
@interface QTAnchor : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTAnchor *)start;
+ (QTAnchor *)middle;
+ (QTAnchor *)end;
@end

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
@interface QTTitleOrient : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTitleOrient *)top;
+ (QTTitleOrient *)bottom;
+ (QTTitleOrient *)left;
+ (QTTitleOrient *)right;
@end

@interface QTParseEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTParseEnum *)parseAuto;
@end

/// Type of input data: `"json"`, `"csv"`, `"tsv"`.
/// The default format type is determined by the extension of the file URL.
/// If no extension is detected, `"json"` will be used by default.
@interface QTDataFormatType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDataFormatType *)csv;
+ (QTDataFormatType *)tsv;
+ (QTDataFormatType *)json;
+ (QTDataFormatType *)topojson;
@end

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
@interface QTAggregateOp : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTAggregateOp *)argmax;
+ (QTAggregateOp *)argmin;
+ (QTAggregateOp *)average;
+ (QTAggregateOp *)count;
+ (QTAggregateOp *)distinct;
+ (QTAggregateOp *)max;
+ (QTAggregateOp *)mean;
+ (QTAggregateOp *)median;
+ (QTAggregateOp *)min;
+ (QTAggregateOp *)missing;
+ (QTAggregateOp *)q1;
+ (QTAggregateOp *)q3;
+ (QTAggregateOp *)ci0;
+ (QTAggregateOp *)ci1;
+ (QTAggregateOp *)stdev;
+ (QTAggregateOp *)stdevp;
+ (QTAggregateOp *)sum;
+ (QTAggregateOp *)valid;
+ (QTAggregateOp *)aggregateOpValues;
+ (QTAggregateOp *)variance;
+ (QTAggregateOp *)variancep;
@end

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
@interface QTTimeUnit : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTimeUnit *)year;
+ (QTTimeUnit *)quarter;
+ (QTTimeUnit *)month;
+ (QTTimeUnit *)day;
+ (QTTimeUnit *)date;
+ (QTTimeUnit *)hours;
+ (QTTimeUnit *)minutes;
+ (QTTimeUnit *)seconds;
+ (QTTimeUnit *)milliseconds;
+ (QTTimeUnit *)utcyear;
+ (QTTimeUnit *)utcquarter;
+ (QTTimeUnit *)utcmonth;
+ (QTTimeUnit *)utcday;
+ (QTTimeUnit *)utcdate;
+ (QTTimeUnit *)utchours;
+ (QTTimeUnit *)utcminutes;
+ (QTTimeUnit *)utcseconds;
+ (QTTimeUnit *)utcmilliseconds;
+ (QTTimeUnit *)yearquarter;
+ (QTTimeUnit *)yearquartermonth;
+ (QTTimeUnit *)yearmonth;
+ (QTTimeUnit *)yearmonthdate;
+ (QTTimeUnit *)yearmonthdatehours;
+ (QTTimeUnit *)yearmonthdatehoursminutes;
+ (QTTimeUnit *)yearmonthdatehoursminutesseconds;
+ (QTTimeUnit *)quartermonth;
+ (QTTimeUnit *)monthdate;
+ (QTTimeUnit *)hoursminutes;
+ (QTTimeUnit *)hoursminutesseconds;
+ (QTTimeUnit *)minutesseconds;
+ (QTTimeUnit *)secondsmilliseconds;
+ (QTTimeUnit *)utcyearquarter;
+ (QTTimeUnit *)utcyearquartermonth;
+ (QTTimeUnit *)utcyearmonth;
+ (QTTimeUnit *)utcyearmonthdate;
+ (QTTimeUnit *)utcyearmonthdatehours;
+ (QTTimeUnit *)utcyearmonthdatehoursminutes;
+ (QTTimeUnit *)utcyearmonthdatehoursminutesseconds;
+ (QTTimeUnit *)utcquartermonth;
+ (QTTimeUnit *)utcmonthdate;
+ (QTTimeUnit *)utchoursminutes;
+ (QTTimeUnit *)utchoursminutesseconds;
+ (QTTimeUnit *)utcminutesseconds;
+ (QTTimeUnit *)utcsecondsmilliseconds;
@end

@interface QTRepeatEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRepeatEnum *)row;
+ (QTRepeatEnum *)column;
@end

/// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
/// continuous color gradient.
///
/// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
/// `"symbol"` otherwise.
@interface QTLegendType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLegendType *)symbol;
+ (QTLegendType *)gradient;
@end

@interface QTDomain : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDomain *)unaggregated;
@end

@interface QTInterpolateParamsType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTInterpolateParamsType *)rgb;
+ (QTInterpolateParamsType *)cubehelix;
+ (QTInterpolateParamsType *)cubehelixLong;
@end

@interface QTNiceTime : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTNiceTime *)second;
+ (QTNiceTime *)minute;
+ (QTNiceTime *)hour;
+ (QTNiceTime *)day;
+ (QTNiceTime *)week;
+ (QTNiceTime *)month;
+ (QTNiceTime *)year;
@end

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
@interface QTScaleType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTScaleType *)linear;
+ (QTScaleType *)binLinear;
+ (QTScaleType *)log;
+ (QTScaleType *)pow;
+ (QTScaleType *)sqrt;
+ (QTScaleType *)time;
+ (QTScaleType *)utc;
+ (QTScaleType *)sequential;
+ (QTScaleType *)ordinal;
+ (QTScaleType *)binOrdinal;
+ (QTScaleType *)point;
+ (QTScaleType *)band;
@end

@interface QTSortEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSortEnum *)ascending;
+ (QTSortEnum *)descending;
@end

/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
///
/// Constants and utilities for data type
/// Data type based on level of measurement
@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)quantitative;
+ (QTType *)ordinal;
+ (QTType *)temporal;
+ (QTType *)nominal;
+ (QTType *)latitude;
+ (QTType *)longitude;
+ (QTType *)geojson;
@end

/// All types of primitive marks.
///
/// The mark type.
/// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
/// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
@interface QTMark : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMark *)area;
+ (QTMark *)bar;
+ (QTMark *)line;
+ (QTMark *)point;
+ (QTMark *)text;
+ (QTMark *)tick;
+ (QTMark *)rect;
+ (QTMark *)rule;
+ (QTMark *)circle;
+ (QTMark *)square;
+ (QTMark *)geoshape;
@end

@interface QTResolveMode : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTResolveMode *)independent;
+ (QTResolveMode *)shared;
@end

@interface QTSelectionDefType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSelectionDefType *)single;
+ (QTSelectionDefType *)multi;
+ (QTSelectionDefType *)interval;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
/// URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
/// have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
/// Setting the `$schema` property allows automatic validation and autocomplete in editors
/// that support JSON schema.
@property (nonatomic, nullable, copy) NSString *schema;
/// Sets how the visualization size should be determined. If a string, should be one of
/// `"pad"`, `"fit"` or `"none"`.
/// Object values can additionally specify parameters for content sizing and automatic
/// resizing.
/// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
///
/// __Default value__: `pad`
@property (nonatomic, nullable, copy) id autosize;
/// CSS color property to use as the background of visualization.
///
/// __Default value:__ none (transparent)
@property (nonatomic, nullable, copy) NSString *background;
/// Vega-Lite configuration object.  This property can only be defined at the top-level of a
/// specification.
@property (nonatomic, nullable, strong) QTConfig *config;
/// An object describing the data source
@property (nonatomic, nullable, strong) QTData *data;
/// Description of this mark for commenting purpose.
@property (nonatomic, nullable, copy) NSString *theDescription;
/// A key-value mapping between encoding channels and definition of fields.
@property (nonatomic, nullable, strong) QTEncodingWithFacet *encoding;
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
@property (nonatomic, nullable, strong) NSNumber *height;
/// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
/// `"line"`,
/// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
/// object](mark.html#mark-def).
@property (nonatomic, nullable, copy) id mark;
/// Name of the visualization for later reference.
@property (nonatomic, nullable, copy) NSString *name;
/// The default visualization padding, in pixels, from the edge of the visualization canvas
/// to the data rectangle.  If a number, specifies padding for all sides.
/// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
/// "bottom": 5}` to specify padding for each side of the visualization.
///
/// __Default value__: `5`
@property (nonatomic, nullable, copy) id padding;
/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
@property (nonatomic, nullable, strong) QTProjection *projection;
/// A key-value mapping between selection names and definitions.
@property (nonatomic, nullable, copy) NSDictionary<NSString *, QTSelectionDef *> *selection;
/// Title for the plot.
@property (nonatomic, nullable, copy) id title;
/// An array of data transformations such as filter and new field calculation.
@property (nonatomic, nullable, copy) NSArray<QTTransform *> *transform;
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
@property (nonatomic, nullable, strong) NSNumber *width;
/// Layer or single view specifications to be layered.
///
/// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
/// layering facet specifications is not allowed.
@property (nonatomic, nullable, copy) NSArray<QTLayerSpec *> *layer;
/// Scale, axis, and legend resolutions for layers.
///
/// Scale, axis, and legend resolutions for facets.
///
/// Scale and legend resolutions for repeated charts.
///
/// Scale, axis, and legend resolutions for vertically concatenated charts.
///
/// Scale, axis, and legend resolutions for horizontally concatenated charts.
@property (nonatomic, nullable, strong) QTResolve *resolve;
/// An object that describes mappings between `row` and `column` channels and their field
/// definitions.
@property (nonatomic, nullable, strong) QTFacetMapping *facet;
/// A specification of the view that gets faceted.
@property (nonatomic, nullable, strong) QTSpec *spec;
/// An object that describes what fields should be repeated into views that are laid out as a
/// `row` or `column`.
@property (nonatomic, nullable, strong) QTRepeat *repeat;
/// A list of views that should be concatenated and put into a column.
@property (nonatomic, nullable, copy) NSArray<QTSpec *> *vconcat;
/// A list of views that should be concatenated and put into a row.
@property (nonatomic, nullable, copy) NSArray<QTSpec *> *hconcat;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTAutoSizeParams : NSObject
/// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
/// The default setting (`"content"`) interprets the width and height settings as the data
/// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
/// `"padding"` setting includes the padding within the view size calculations, such that the
/// width and height settings indicate the **total** intended size of the view.
///
/// __Default value__: `"content"`
@property (nonatomic, nullable, assign) QTContains *contains;
/// A boolean flag indicating if autosize layout should be re-calculated on every view
/// update.
///
/// __Default value__: `false`
@property (nonatomic, nullable, strong) NSNumber *resize;
/// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
/// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
/// descriptions of each.
///
/// __Default value__: `"pad"`
@property (nonatomic, nullable, assign) QTAutosizeType *type;
@end

/// Vega-Lite configuration object.  This property can only be defined at the top-level of a
/// specification.
@interface QTConfig : NSObject
/// Area-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *area;
/// Sets how the visualization size should be determined. If a string, should be one of
/// `"pad"`, `"fit"` or `"none"`.
/// Object values can additionally specify parameters for content sizing and automatic
/// resizing.
/// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
///
/// __Default value__: `pad`
@property (nonatomic, nullable, copy) id autosize;
/// Axis configuration, which determines default properties for all `x` and `y`
/// [axes](axis.html). For a full list of axis configuration options, please see the
/// [corresponding section of the axis documentation](axis.html#config).
@property (nonatomic, nullable, strong) QTAxisConfig *axis;
/// Specific axis config for axes with "band" scales.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisBand;
/// Specific axis config for x-axis along the bottom edge of the chart.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisBottom;
/// Specific axis config for y-axis along the left edge of the chart.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisLeft;
/// Specific axis config for y-axis along the right edge of the chart.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisRight;
/// Specific axis config for x-axis along the top edge of the chart.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisTop;
/// X-axis specific config.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisX;
/// Y-axis specific config.
@property (nonatomic, nullable, strong) QTVGAxisConfig *axisY;
/// CSS color property to use as the background of visualization.
///
/// __Default value:__ none (transparent)
@property (nonatomic, nullable, copy) NSString *background;
/// Bar-Specific Config
@property (nonatomic, nullable, strong) QTBarConfig *bar;
/// Circle-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *circle;
/// Default axis and legend title for count fields.
///
/// __Default value:__ `'Number of Records'`.
@property (nonatomic, nullable, copy) NSString *countTitle;
/// Defines how Vega-Lite generates title for fields.  There are three possible styles:
///
/// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
/// "Year-month of date", "field (binned)").
/// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
/// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
/// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
/// "field").
@property (nonatomic, nullable, assign) QTFieldTitle *fieldTitle;
/// Geoshape-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *geoshape;
/// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
/// - If set to `"filter"` (default), all data items with null values are filtered.
/// - If `null`, all data items are included. In this case, invalid values will be
/// interpreted as zeroes.
@property (nonatomic, nullable, assign) QTInvalidValues *invalidValues;
/// Legend configuration, which determines default properties for all [legends](legend.html).
/// For a full list of legend configuration options, please see the [corresponding section of
/// in the legend documentation](legend.html#config).
@property (nonatomic, nullable, strong) QTLegendConfig *legend;
/// Line-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *line;
/// Mark Config
@property (nonatomic, nullable, strong) QTMarkConfig *mark;
/// D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
/// number format pattern](https://github.com/d3/d3-format#locale_format).
@property (nonatomic, nullable, copy) NSString *numberFormat;
/// The default visualization padding, in pixels, from the edge of the visualization canvas
/// to the data rectangle.  If a number, specifies padding for all sides.
/// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
/// "bottom": 5}` to specify padding for each side of the visualization.
///
/// __Default value__: `5`
@property (nonatomic, nullable, copy) id padding;
/// Point-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *point;
/// Projection configuration, which determines default properties for all
/// [projections](projection.html). For a full list of projection configuration options,
/// please see the [corresponding section of the projection
/// documentation](projection.html#config).
@property (nonatomic, nullable, strong) QTProjectionConfig *projection;
/// An object hash that defines default range arrays or schemes for using with scales.
/// For a full list of scale range configuration options, please see the [corresponding
/// section of the scale documentation](scale.html#config).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id> *range;
/// Rect-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *rect;
/// Rule-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *rule;
/// Scale configuration determines default properties for all [scales](scale.html). For a
/// full list of scale configuration options, please see the [corresponding section of the
/// scale documentation](scale.html#config).
@property (nonatomic, nullable, strong) QTScaleConfig *scale;
/// An object hash for defining default properties for each type of selections.
@property (nonatomic, nullable, strong) QTSelectionConfig *selection;
/// Square-Specific Config
@property (nonatomic, nullable, strong) QTMarkConfig *square;
/// Default stack offset for stackable mark.
@property (nonatomic, nullable, assign) QTStackOffset *stack;
/// An object hash that defines key-value mappings to determine default properties for marks
/// with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
/// valid [mark configuration objects](mark.html#config).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, QTVGMarkConfig *> *style;
/// Text-Specific Config
@property (nonatomic, nullable, strong) QTTextConfig *text;
/// Tick-Specific Config
@property (nonatomic, nullable, strong) QTTickConfig *tick;
/// Default datetime format for axis and legend labels. The format can be set directly on
/// each axis and legend. Use [D3's time format
/// pattern](https://github.com/d3/d3-time-format#locale_format).
///
/// __Default value:__ `'%b %d, %Y'`.
@property (nonatomic, nullable, copy) NSString *timeFormat;
/// Title configuration, which determines default properties for all [titles](title.html).
/// For a full list of title configuration options, please see the [corresponding section of
/// the title documentation](title.html#config).
@property (nonatomic, nullable, strong) QTVGTitleConfig *title;
/// Default properties for [single view plots](spec.html#single).
@property (nonatomic, nullable, strong) QTViewConfig *view;
@end

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
@interface QTMarkConfig : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
/// will override `color`.
///
/// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, copy) NSString *color;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// Whether the mark's color should be used as fill color instead of stroke color.
///
/// __Default value:__ `true` for all marks except `point` and `false` for `point`.
///
/// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, strong) NSNumber *filled;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
@end

/// Axis configuration, which determines default properties for all `x` and `y`
/// [axes](axis.html). For a full list of axis configuration options, please see the
/// [corresponding section of the axis documentation](axis.html#config).
@interface QTAxisConfig : NSObject
/// An interpolation fraction indicating where, for `band` scales, axis ticks should be
/// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
/// places ticks in the middle of their bands.
@property (nonatomic, nullable, strong) NSNumber *bandPosition;
/// A boolean flag indicating if the domain (the axis baseline) should be included as part of
/// the axis.
///
/// __Default value:__ `true`
@property (nonatomic, nullable, strong) NSNumber *domain;
/// Color of axis domain line.
///
/// __Default value:__  (none, using Vega default).
@property (nonatomic, nullable, copy) NSString *domainColor;
/// Stroke width of axis domain line
///
/// __Default value:__  (none, using Vega default).
@property (nonatomic, nullable, strong) NSNumber *domainWidth;
/// A boolean flag indicating if grid lines should be included as part of the axis
///
/// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
/// binned; otherwise, `false`.
@property (nonatomic, nullable, strong) NSNumber *grid;
/// Color of gridlines.
@property (nonatomic, nullable, copy) NSString *gridColor;
/// The offset (in pixels) into which to begin drawing with the grid dash array.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *gridDash;
/// The stroke opacity of grid (value between [0,1])
///
/// __Default value:__ (`1` by default)
@property (nonatomic, nullable, strong) NSNumber *gridOpacity;
/// The grid width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *gridWidth;
/// The rotation angle of the axis labels.
///
/// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
@property (nonatomic, nullable, strong) NSNumber *labelAngle;
/// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
/// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
/// they exceed the axis range by more than 1 pixel. If this property is a number, it
/// specifies the pixel tolerance: the maximum amount by which a label bounding box may
/// exceed the axis range.
///
/// __Default value:__ `false`.
@property (nonatomic, nullable, copy) id labelBound;
/// The color of the tick label, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *labelColor;
/// Indicates if the first and last axis labels should be aligned flush with the scale range.
/// Flush alignment for a horizontal axis will left-align the first label and right-align the
/// last label. For vertical axes, bottom and top text baselines are applied instead. If this
/// property is a number, it also indicates the number of pixels by which to offset the first
/// and last labels; for example, a value of 2 will flush-align the first and last labels and
/// also push them 2 pixels outward from the center of the axis. The additional adjustment
/// can sometimes help the labels better visually group with corresponding axis ticks.
///
/// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
@property (nonatomic, nullable, copy) id labelFlush;
/// The font of the tick label.
@property (nonatomic, nullable, copy) NSString *labelFont;
/// The font size of the label, in pixels.
@property (nonatomic, nullable, strong) NSNumber *labelFontSize;
/// Maximum allowed pixel width of axis tick labels.
@property (nonatomic, nullable, strong) NSNumber *labelLimit;
/// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
/// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
/// every other label is used (this works well for standard linear axes). If set to
/// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
/// with the last visible label (this often works better for log-scaled axes).
///
/// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
/// scales; otherwise `false`.
@property (nonatomic, nullable, copy) id labelOverlap;
/// The padding, in pixels, between axis and text labels.
@property (nonatomic, nullable, strong) NSNumber *labelPadding;
/// A boolean flag indicating if labels should be included as part of the axis.
///
/// __Default value:__  `true`.
@property (nonatomic, nullable, strong) NSNumber *labels;
/// The maximum extent in pixels that axis ticks and labels should use. This determines a
/// maximum offset value for axis titles.
///
/// __Default value:__ `undefined`.
@property (nonatomic, nullable, strong) NSNumber *maxExtent;
/// The minimum extent in pixels that axis ticks and labels should use. This determines a
/// minimum offset value for axis titles.
///
/// __Default value:__ `30` for y-axis; `undefined` for x-axis.
@property (nonatomic, nullable, strong) NSNumber *minExtent;
/// Whether month names and weekday names should be abbreviated.
///
/// __Default value:__  `false`
@property (nonatomic, nullable, strong) NSNumber *shortTimeLabels;
/// The color of the axis's tick.
@property (nonatomic, nullable, copy) NSString *tickColor;
/// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
@property (nonatomic, nullable, strong) NSNumber *tickRound;
/// Boolean value that determines whether the axis should include ticks.
@property (nonatomic, nullable, strong) NSNumber *ticks;
/// The size in pixels of axis ticks.
@property (nonatomic, nullable, strong) NSNumber *tickSize;
/// The width, in pixels, of ticks.
@property (nonatomic, nullable, strong) NSNumber *tickWidth;
/// Horizontal text alignment of axis titles.
@property (nonatomic, nullable, copy) NSString *titleAlign;
/// Angle in degrees of axis titles.
@property (nonatomic, nullable, strong) NSNumber *titleAngle;
/// Vertical text baseline for axis titles.
@property (nonatomic, nullable, copy) NSString *titleBaseline;
/// Color of the title, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *titleColor;
/// Font of the title. (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *titleFont;
/// Font size of the title.
@property (nonatomic, nullable, strong) NSNumber *titleFontSize;
/// Font weight of the title. (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id titleFontWeight;
/// Maximum allowed pixel width of axis titles.
@property (nonatomic, nullable, strong) NSNumber *titleLimit;
/// Max length for axis title if the title is automatically generated from the field's
/// description.
@property (nonatomic, nullable, strong) NSNumber *titleMaxLength;
/// The padding, in pixels, between title and axis.
@property (nonatomic, nullable, strong) NSNumber *titlePadding;
/// X-coordinate of the axis title relative to the axis group.
@property (nonatomic, nullable, strong) NSNumber *titleX;
/// Y-coordinate of the axis title relative to the axis group.
@property (nonatomic, nullable, strong) NSNumber *titleY;
@end

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
@interface QTVGAxisConfig : NSObject
/// An interpolation fraction indicating where, for `band` scales, axis ticks should be
/// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
/// places ticks in the middle of their bands.
@property (nonatomic, nullable, strong) NSNumber *bandPosition;
/// A boolean flag indicating if the domain (the axis baseline) should be included as part of
/// the axis.
///
/// __Default value:__ `true`
@property (nonatomic, nullable, strong) NSNumber *domain;
/// Color of axis domain line.
///
/// __Default value:__  (none, using Vega default).
@property (nonatomic, nullable, copy) NSString *domainColor;
/// Stroke width of axis domain line
///
/// __Default value:__  (none, using Vega default).
@property (nonatomic, nullable, strong) NSNumber *domainWidth;
/// A boolean flag indicating if grid lines should be included as part of the axis
///
/// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
/// binned; otherwise, `false`.
@property (nonatomic, nullable, strong) NSNumber *grid;
/// Color of gridlines.
@property (nonatomic, nullable, copy) NSString *gridColor;
/// The offset (in pixels) into which to begin drawing with the grid dash array.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *gridDash;
/// The stroke opacity of grid (value between [0,1])
///
/// __Default value:__ (`1` by default)
@property (nonatomic, nullable, strong) NSNumber *gridOpacity;
/// The grid width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *gridWidth;
/// The rotation angle of the axis labels.
///
/// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
@property (nonatomic, nullable, strong) NSNumber *labelAngle;
/// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
/// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
/// they exceed the axis range by more than 1 pixel. If this property is a number, it
/// specifies the pixel tolerance: the maximum amount by which a label bounding box may
/// exceed the axis range.
///
/// __Default value:__ `false`.
@property (nonatomic, nullable, copy) id labelBound;
/// The color of the tick label, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *labelColor;
/// Indicates if the first and last axis labels should be aligned flush with the scale range.
/// Flush alignment for a horizontal axis will left-align the first label and right-align the
/// last label. For vertical axes, bottom and top text baselines are applied instead. If this
/// property is a number, it also indicates the number of pixels by which to offset the first
/// and last labels; for example, a value of 2 will flush-align the first and last labels and
/// also push them 2 pixels outward from the center of the axis. The additional adjustment
/// can sometimes help the labels better visually group with corresponding axis ticks.
///
/// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
@property (nonatomic, nullable, copy) id labelFlush;
/// The font of the tick label.
@property (nonatomic, nullable, copy) NSString *labelFont;
/// The font size of the label, in pixels.
@property (nonatomic, nullable, strong) NSNumber *labelFontSize;
/// Maximum allowed pixel width of axis tick labels.
@property (nonatomic, nullable, strong) NSNumber *labelLimit;
/// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
/// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
/// every other label is used (this works well for standard linear axes). If set to
/// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
/// with the last visible label (this often works better for log-scaled axes).
///
/// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
/// scales; otherwise `false`.
@property (nonatomic, nullable, copy) id labelOverlap;
/// The padding, in pixels, between axis and text labels.
@property (nonatomic, nullable, strong) NSNumber *labelPadding;
/// A boolean flag indicating if labels should be included as part of the axis.
///
/// __Default value:__  `true`.
@property (nonatomic, nullable, strong) NSNumber *labels;
/// The maximum extent in pixels that axis ticks and labels should use. This determines a
/// maximum offset value for axis titles.
///
/// __Default value:__ `undefined`.
@property (nonatomic, nullable, strong) NSNumber *maxExtent;
/// The minimum extent in pixels that axis ticks and labels should use. This determines a
/// minimum offset value for axis titles.
///
/// __Default value:__ `30` for y-axis; `undefined` for x-axis.
@property (nonatomic, nullable, strong) NSNumber *minExtent;
/// The color of the axis's tick.
@property (nonatomic, nullable, copy) NSString *tickColor;
/// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
@property (nonatomic, nullable, strong) NSNumber *tickRound;
/// Boolean value that determines whether the axis should include ticks.
@property (nonatomic, nullable, strong) NSNumber *ticks;
/// The size in pixels of axis ticks.
@property (nonatomic, nullable, strong) NSNumber *tickSize;
/// The width, in pixels, of ticks.
@property (nonatomic, nullable, strong) NSNumber *tickWidth;
/// Horizontal text alignment of axis titles.
@property (nonatomic, nullable, copy) NSString *titleAlign;
/// Angle in degrees of axis titles.
@property (nonatomic, nullable, strong) NSNumber *titleAngle;
/// Vertical text baseline for axis titles.
@property (nonatomic, nullable, copy) NSString *titleBaseline;
/// Color of the title, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *titleColor;
/// Font of the title. (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *titleFont;
/// Font size of the title.
@property (nonatomic, nullable, strong) NSNumber *titleFontSize;
/// Font weight of the title. (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id titleFontWeight;
/// Maximum allowed pixel width of axis titles.
@property (nonatomic, nullable, strong) NSNumber *titleLimit;
/// Max length for axis title if the title is automatically generated from the field's
/// description.
@property (nonatomic, nullable, strong) NSNumber *titleMaxLength;
/// The padding, in pixels, between title and axis.
@property (nonatomic, nullable, strong) NSNumber *titlePadding;
/// X-coordinate of the axis title relative to the axis group.
@property (nonatomic, nullable, strong) NSNumber *titleX;
/// Y-coordinate of the axis title relative to the axis group.
@property (nonatomic, nullable, strong) NSNumber *titleY;
@end

/// Bar-Specific Config
@interface QTBarConfig : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
/// statisticians) or 1 (Vega-Lite Default, D3 example style).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *binSpacing;
/// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
/// will override `color`.
///
/// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, copy) NSString *color;
/// The default size of the bars on continuous scales.
///
/// __Default value:__ `5`
@property (nonatomic, nullable, strong) NSNumber *continuousBandSize;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The size of the bars.  If unspecified, the default size is  `bandSize-1`,
/// which provides 1 pixel offset between bars.
@property (nonatomic, nullable, strong) NSNumber *discreteBandSize;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// Whether the mark's color should be used as fill color instead of stroke color.
///
/// __Default value:__ `true` for all marks except `point` and `false` for `point`.
///
/// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, strong) NSNumber *filled;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
@end

/// Legend configuration, which determines default properties for all [legends](legend.html).
/// For a full list of legend configuration options, please see the [corresponding section of
/// in the legend documentation](legend.html#config).
@interface QTLegendConfig : NSObject
/// Corner radius for the full legend.
@property (nonatomic, nullable, strong) NSNumber *cornerRadius;
/// Padding (in pixels) between legend entries in a symbol legend.
@property (nonatomic, nullable, strong) NSNumber *entryPadding;
/// Background fill color for the full legend.
@property (nonatomic, nullable, copy) NSString *fillColor;
/// The height of the gradient, in pixels.
@property (nonatomic, nullable, strong) NSNumber *gradientHeight;
/// Text baseline for color ramp gradient labels.
@property (nonatomic, nullable, copy) NSString *gradientLabelBaseline;
/// The maximum allowed length in pixels of color ramp gradient labels.
@property (nonatomic, nullable, strong) NSNumber *gradientLabelLimit;
/// Vertical offset in pixels for color ramp gradient labels.
@property (nonatomic, nullable, strong) NSNumber *gradientLabelOffset;
/// The color of the gradient stroke, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *gradientStrokeColor;
/// The width of the gradient stroke, in pixels.
@property (nonatomic, nullable, strong) NSNumber *gradientStrokeWidth;
/// The width of the gradient, in pixels.
@property (nonatomic, nullable, strong) NSNumber *gradientWidth;
/// The alignment of the legend label, can be left, middle or right.
@property (nonatomic, nullable, copy) NSString *labelAlign;
/// The position of the baseline of legend label, can be top, middle or bottom.
@property (nonatomic, nullable, copy) NSString *labelBaseline;
/// The color of the legend label, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *labelColor;
/// The font of the legend label.
@property (nonatomic, nullable, copy) NSString *labelFont;
/// The font size of legend label.
///
/// __Default value:__ `10`.
@property (nonatomic, nullable, strong) NSNumber *labelFontSize;
/// Maximum allowed pixel width of axis tick labels.
@property (nonatomic, nullable, strong) NSNumber *labelLimit;
/// The offset of the legend label.
@property (nonatomic, nullable, strong) NSNumber *labelOffset;
/// The offset, in pixels, by which to displace the legend from the edge of the enclosing
/// group or data rectangle.
///
/// __Default value:__  `0`
@property (nonatomic, nullable, strong) NSNumber *offset;
/// The orientation of the legend, which determines how the legend is positioned within the
/// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
/// "none".
///
/// __Default value:__ `"right"`
@property (nonatomic, nullable, assign) QTLegendOrient *orient;
/// The padding, in pixels, between the legend and axis.
@property (nonatomic, nullable, strong) NSNumber *padding;
/// Whether month names and weekday names should be abbreviated.
///
/// __Default value:__  `false`
@property (nonatomic, nullable, strong) NSNumber *shortTimeLabels;
/// Border stroke color for the full legend.
@property (nonatomic, nullable, copy) NSString *strokeColor;
/// Border stroke dash pattern for the full legend.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// Border stroke width for the full legend.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// The color of the legend symbol,
@property (nonatomic, nullable, copy) NSString *symbolColor;
/// The size of the legend symbol, in pixels.
@property (nonatomic, nullable, strong) NSNumber *symbolSize;
/// The width of the symbol's stroke.
@property (nonatomic, nullable, strong) NSNumber *symbolStrokeWidth;
/// Default shape type (such as "circle") for legend symbols.
@property (nonatomic, nullable, copy) NSString *symbolType;
/// Horizontal text alignment for legend titles.
@property (nonatomic, nullable, copy) NSString *titleAlign;
/// Vertical text baseline for legend titles.
@property (nonatomic, nullable, copy) NSString *titleBaseline;
/// The color of the legend title, can be in hex color code or regular color name.
@property (nonatomic, nullable, copy) NSString *titleColor;
/// The font of the legend title.
@property (nonatomic, nullable, copy) NSString *titleFont;
/// The font size of the legend title.
@property (nonatomic, nullable, strong) NSNumber *titleFontSize;
/// The font weight of the legend title.
@property (nonatomic, nullable, copy) id titleFontWeight;
/// Maximum allowed pixel width of axis titles.
@property (nonatomic, nullable, strong) NSNumber *titleLimit;
/// The padding, in pixels, between title and legend.
@property (nonatomic, nullable, strong) NSNumber *titlePadding;
@end

@interface QTPaddingClass : NSObject
@property (nonatomic, nullable, strong) NSNumber *bottom;
@property (nonatomic, nullable, strong) NSNumber *left;
@property (nonatomic, nullable, strong) NSNumber *right;
@property (nonatomic, nullable, strong) NSNumber *top;
@end

/// Projection configuration, which determines default properties for all
/// [projections](projection.html). For a full list of projection configuration options,
/// please see the [corresponding section of the projection
/// documentation](projection.html#config).
///
/// Any property of Projection can be in config
@interface QTProjectionConfig : NSObject
/// Sets the projection’s center to the specified center, a two-element array of longitude
/// and latitude in degrees.
///
/// __Default value:__ `[0, 0]`
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *center;
/// Sets the projection’s clipping circle radius to the specified angle in degrees. If
/// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
/// than small-circle clipping.
@property (nonatomic, nullable, strong) NSNumber *clipAngle;
/// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
/// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
/// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
/// viewport clipping is performed.
@property (nonatomic, nullable, copy)   NSArray<NSArray<NSNumber *> *> *clipExtent;
@property (nonatomic, nullable, strong) NSNumber *coefficient;
@property (nonatomic, nullable, strong) NSNumber *distance;
@property (nonatomic, nullable, strong) NSNumber *fraction;
@property (nonatomic, nullable, strong) NSNumber *lobes;
@property (nonatomic, nullable, strong) NSNumber *parallel;
/// Sets the threshold for the projection’s [adaptive
/// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
/// value corresponds to the [Douglas–Peucker
/// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
/// If precision is not specified, returns the projection’s current resampling precision
/// which defaults to `√0.5 ≅ 0.70710…`.
@property (nonatomic, nullable, copy)   NSDictionary<NSString *, id> *precision;
@property (nonatomic, nullable, strong) NSNumber *radius;
@property (nonatomic, nullable, strong) NSNumber *ratio;
/// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
/// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
/// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
///
/// __Default value:__ `[0, 0, 0]`
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *rotate;
@property (nonatomic, nullable, strong) NSNumber *spacing;
@property (nonatomic, nullable, strong) NSNumber *tilt;
/// The cartographic projection to use. This value is case-insensitive, for example
/// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
/// projection types [in the
/// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
/// __Default value:__ `mercator`
@property (nonatomic, nullable, assign) QTVGProjectionType *type;
@end

@interface QTVGScheme : NSObject
@property (nonatomic, nullable, strong) NSNumber *count;
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *extent;
@property (nonatomic, nullable, copy)   NSString *scheme;
@property (nonatomic, nullable, strong) NSNumber *step;
@end

/// Scale configuration determines default properties for all [scales](scale.html). For a
/// full list of scale configuration options, please see the [corresponding section of the
/// scale documentation](scale.html#config).
@interface QTScaleConfig : NSObject
/// Default inner padding for `x` and `y` band-ordinal scales.
///
/// __Default value:__ `0.1`
@property (nonatomic, nullable, strong) NSNumber *bandPaddingInner;
/// Default outer padding for `x` and `y` band-ordinal scales.
/// If not specified, by default, band scale's paddingOuter is paddingInner/2.
@property (nonatomic, nullable, strong) NSNumber *bandPaddingOuter;
/// If true, values that exceed the data domain are clamped to either the minimum or maximum
/// range value
@property (nonatomic, nullable, strong) NSNumber *clamp;
/// Default padding for continuous scales.
///
/// __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
/// horizontal bar.; `0` otherwise.
@property (nonatomic, nullable, strong) NSNumber *continuousPadding;
/// The default max value for mapping quantitative fields to bar's size/bandSize.
///
/// If undefined (default), we will use the scale's `rangeStep` - 1.
@property (nonatomic, nullable, strong) NSNumber *maxBandSize;
/// The default max value for mapping quantitative fields to text's size/fontSize.
///
/// __Default value:__ `40`
@property (nonatomic, nullable, strong) NSNumber *maxFontSize;
/// Default max opacity for mapping a field to opacity.
///
/// __Default value:__ `0.8`
@property (nonatomic, nullable, strong) NSNumber *maxOpacity;
/// Default max value for point size scale.
@property (nonatomic, nullable, strong) NSNumber *maxSize;
/// Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
///
/// __Default value:__ `4`
@property (nonatomic, nullable, strong) NSNumber *maxStrokeWidth;
/// The default min value for mapping quantitative fields to bar and tick's size/bandSize
/// scale with zero=false.
///
/// __Default value:__ `2`
@property (nonatomic, nullable, strong) NSNumber *minBandSize;
/// The default min value for mapping quantitative fields to tick's size/fontSize scale with
/// zero=false
///
/// __Default value:__ `8`
@property (nonatomic, nullable, strong) NSNumber *minFontSize;
/// Default minimum opacity for mapping a field to opacity.
///
/// __Default value:__ `0.3`
@property (nonatomic, nullable, strong) NSNumber *minOpacity;
/// Default minimum value for point size scale with zero=false.
///
/// __Default value:__ `9`
@property (nonatomic, nullable, strong) NSNumber *minSize;
/// Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *minStrokeWidth;
/// Default outer padding for `x` and `y` point-ordinal scales.
///
/// __Default value:__ `0.5`
@property (nonatomic, nullable, strong) NSNumber *pointPadding;
/// Default range step for band and point scales of (1) the `y` channel
/// and (2) the `x` channel when the mark is not `text`.
///
/// __Default value:__ `21`
@property (nonatomic, nullable, strong) NSNumber *rangeStep;
/// If true, rounds numeric output values to integers.
/// This can be helpful for snapping to the pixel grid.
/// (Only available for `x`, `y`, and `size` scales.)
@property (nonatomic, nullable, strong) NSNumber *round;
/// Default range step for `x` band and point scales of text marks.
///
/// __Default value:__ `90`
@property (nonatomic, nullable, strong) NSNumber *textXRangeStep;
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
@property (nonatomic, nullable, strong) NSNumber *useUnaggregatedDomain;
@end

/// An object hash for defining default properties for each type of selections.
@interface QTSelectionConfig : NSObject
/// The default definition for an [`interval`](selection.html#type) selection. All properties
/// and transformations
/// for an interval selection definition (except `type`) may be specified here.
///
/// For instance, setting `interval` to `{"translate": false}` disables the ability to move
/// interval selections by default.
@property (nonatomic, nullable, strong) QTIntervalSelectionConfig *interval;
/// The default definition for a [`multi`](selection.html#type) selection. All properties and
/// transformations
/// for a multi selection definition (except `type`) may be specified here.
///
/// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
/// multi selections when clicking with the alt-key pressed by default.
@property (nonatomic, nullable, strong) QTMultiSelectionConfig *multi;
/// The default definition for a [`single`](selection.html#type) selection. All properties
/// and transformations
/// for a single selection definition (except `type`) may be specified here.
///
/// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
/// double-click by default.
@property (nonatomic, nullable, strong) QTSingleSelectionConfig *single;
@end

/// The default definition for an [`interval`](selection.html#type) selection. All properties
/// and transformations
/// for an interval selection definition (except `type`) may be specified here.
///
/// For instance, setting `interval` to `{"translate": false}` disables the ability to move
/// interval selections by default.
@interface QTIntervalSelectionConfig : NSObject
/// Establishes a two-way binding between the interval selection and the scales
/// used within the same view. This allows a user to interactively pan and
/// zoom the view.
@property (nonatomic, nullable, assign) QTBindEnum *bind;
/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
@property (nonatomic, nullable, assign) QTEmpty *empty;
/// An array of encoding channels. The corresponding data field values
/// must match for a data tuple to fall within the selection.
@property (nonatomic, nullable, copy) NSArray<QTSingleDefChannel *> *encodings;
/// An array of field names whose values must match for a data tuple to
/// fall within the selection.
@property (nonatomic, nullable, copy) NSArray<NSString *> *fields;
/// An interval selection also adds a rectangle mark to depict the
/// extents of the interval. The `mark` property can be used to customize the
/// appearance of the mark.
@property (nonatomic, nullable, strong) QTBrushConfig *mark;
/// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
/// selector) that triggers the selection.
/// For interval selections, the event stream must specify a [start and
/// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
@property (nonatomic, nullable, copy) id on;
/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
@property (nonatomic, nullable, assign) QTSelectionResolution *resolve;
/// When truthy, allows a user to interactively move an interval selection
/// back-and-forth. Can be `true`, `false` (to disable panning), or a
/// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
/// which must include a start and end event to trigger continuous panning.
///
/// __Default value:__ `true`, which corresponds to
/// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
/// clicks and dragging within an interval selection to reposition it.
@property (nonatomic, nullable, copy) id translate;
/// When truthy, allows a user to interactively resize an interval selection.
/// Can be `true`, `false` (to disable zooming), or a [Vega event stream
/// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
/// only `wheel` events are supported.
///
///
/// __Default value:__ `true`, which corresponds to `wheel!`.
@property (nonatomic, nullable, copy) id zoom;
@end

/// An interval selection also adds a rectangle mark to depict the
/// extents of the interval. The `mark` property can be used to customize the
/// appearance of the mark.
@interface QTBrushConfig : NSObject
/// The fill color of the interval mark.
///
/// __Default value:__ `#333333`
@property (nonatomic, nullable, copy) NSString *fill;
/// The fill opacity of the interval mark (a value between 0 and 1).
///
/// __Default value:__ `0.125`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The stroke color of the interval mark.
///
/// __Default value:__ `#ffffff`
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke and space lengths,
/// for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) with which to begin drawing the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity of the interval mark (a value between 0 and 1).
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width of the interval mark.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
@end

/// The default definition for a [`multi`](selection.html#type) selection. All properties and
/// transformations
/// for a multi selection definition (except `type`) may be specified here.
///
/// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
/// multi selections when clicking with the alt-key pressed by default.
@interface QTMultiSelectionConfig : NSObject
/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
@property (nonatomic, nullable, assign) QTEmpty *empty;
/// An array of encoding channels. The corresponding data field values
/// must match for a data tuple to fall within the selection.
@property (nonatomic, nullable, copy) NSArray<QTSingleDefChannel *> *encodings;
/// An array of field names whose values must match for a data tuple to
/// fall within the selection.
@property (nonatomic, nullable, copy) NSArray<NSString *> *fields;
/// When true, an invisible voronoi diagram is computed to accelerate discrete
/// selection. The data value _nearest_ the mouse cursor is added to the selection.
///
/// See the [nearest transform](nearest.html) documentation for more information.
@property (nonatomic, nullable, strong) NSNumber *nearest;
/// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
/// selector) that triggers the selection.
/// For interval selections, the event stream must specify a [start and
/// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
@property (nonatomic, nullable, copy) id on;
/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
@property (nonatomic, nullable, assign) QTSelectionResolution *resolve;
/// Controls whether data values should be toggled or only ever inserted into
/// multi selections. Can be `true`, `false` (for insertion only), or a
/// [Vega expression](https://vega.github.io/vega/docs/expressions/).
///
/// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
/// data values are toggled when a user interacts with the shift-key pressed).
///
/// See the [toggle transform](toggle.html) documentation for more information.
@property (nonatomic, nullable, copy) id toggle;
@end

/// The default definition for a [`single`](selection.html#type) selection. All properties
/// and transformations
/// for a single selection definition (except `type`) may be specified here.
///
/// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
/// double-click by default.
@interface QTSingleSelectionConfig : NSObject
/// Establish a two-way binding between a single selection and input elements
/// (also known as dynamic query widgets). A binding takes the form of
/// Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
/// or can be a mapping between projected field/encodings and binding definitions.
///
/// See the [bind transform](bind.html) documentation for more information.
@property (nonatomic, nullable, copy) NSDictionary<NSString *, QTVGBinding *> *bind;
/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
@property (nonatomic, nullable, assign) QTEmpty *empty;
/// An array of encoding channels. The corresponding data field values
/// must match for a data tuple to fall within the selection.
@property (nonatomic, nullable, copy) NSArray<QTSingleDefChannel *> *encodings;
/// An array of field names whose values must match for a data tuple to
/// fall within the selection.
@property (nonatomic, nullable, copy) NSArray<NSString *> *fields;
/// When true, an invisible voronoi diagram is computed to accelerate discrete
/// selection. The data value _nearest_ the mouse cursor is added to the selection.
///
/// See the [nearest transform](nearest.html) documentation for more information.
@property (nonatomic, nullable, strong) NSNumber *nearest;
/// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
/// selector) that triggers the selection.
/// For interval selections, the event stream must specify a [start and
/// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
@property (nonatomic, nullable, copy) id on;
/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
@property (nonatomic, nullable, assign) QTSelectionResolution *resolve;
@end

@interface QTVGBinding : NSObject
@property (nonatomic, nullable, copy)   NSString *element;
@property (nonatomic, copy)             NSString *input;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *options;
@property (nonatomic, nullable, strong) NSNumber *max;
@property (nonatomic, nullable, strong) NSNumber *min;
@property (nonatomic, nullable, strong) NSNumber *step;
@end

@interface QTVGMarkConfig : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
@end

/// Text-Specific Config
@interface QTTextConfig : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
/// will override `color`.
///
/// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, copy) NSString *color;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// Whether the mark's color should be used as fill color instead of stroke color.
///
/// __Default value:__ `true` for all marks except `point` and `false` for `point`.
///
/// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, strong) NSNumber *filled;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// Whether month names and weekday names should be abbreviated.
@property (nonatomic, nullable, strong) NSNumber *shortTimeLabels;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
@end

/// Tick-Specific Config
@interface QTTickConfig : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The width of the ticks.
///
/// __Default value:__  2/3 of rangeStep.
@property (nonatomic, nullable, strong) NSNumber *bandSize;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
/// will override `color`.
///
/// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, copy) NSString *color;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// Whether the mark's color should be used as fill color instead of stroke color.
///
/// __Default value:__ `true` for all marks except `point` and `false` for `point`.
///
/// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, strong) NSNumber *filled;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
/// Thickness of the tick mark.
///
/// __Default value:__  `1`
@property (nonatomic, nullable, strong) NSNumber *thickness;
@end

/// Title configuration, which determines default properties for all [titles](title.html).
/// For a full list of title configuration options, please see the [corresponding section of
/// the title documentation](title.html#config).
@interface QTVGTitleConfig : NSObject
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
@property (nonatomic, nullable, assign) QTAnchor *anchor;
/// Angle in degrees of title text.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// Vertical text baseline for title text.
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Text color for title text.
@property (nonatomic, nullable, copy) NSString *color;
/// Font name for title text.
@property (nonatomic, nullable, copy) NSString *font;
/// Font size in pixels for title text.
///
/// __Default value:__ `10`.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// Font weight for title text.
@property (nonatomic, nullable, copy) id fontWeight;
/// The maximum allowed length in pixels of legend labels.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// Offset in pixels of the title from the chart body and axes.
@property (nonatomic, nullable, strong) NSNumber *offset;
/// Default title orientation ("top", "bottom", "left", or "right")
@property (nonatomic, nullable, assign) QTTitleOrient *orient;
@end

/// Default properties for [single view plots](spec.html#single).
@interface QTViewConfig : NSObject
/// Whether the view should be clipped.
@property (nonatomic, nullable, strong) NSNumber *clip;
/// The fill color.
///
/// __Default value:__ (none)
@property (nonatomic, nullable, copy) NSString *fill;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ (none)
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The default height of the single plot or each plot in a trellis plot when the
/// visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
///
/// __Default value:__ `200`
@property (nonatomic, nullable, strong) NSNumber *height;
/// The stroke color.
///
/// __Default value:__ (none)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
///
/// __Default value:__ (none)
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
///
/// __Default value:__ (none)
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ (none)
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
///
/// __Default value:__ (none)
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
/// The default width of the single plot or each plot in a trellis plot when the
/// visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
/// = `null`.
///
/// __Default value:__ `200`
@property (nonatomic, nullable, strong) NSNumber *width;
@end

/// An object describing the data source
///
/// Secondary data source to lookup in.
@interface QTData : NSObject
/// An object that specifies the format for parsing the data file.
///
/// An object that specifies the format for parsing the data values.
///
/// An object that specifies the format for parsing the data.
@property (nonatomic, nullable, strong) QTDataFormat *format;
/// An URL from which to load the data set. Use the `format.type` property
/// to ensure the loaded data is correctly parsed.
@property (nonatomic, nullable, copy) NSString *url;
/// The full data set, included inline. This can be an array of objects or primitive values
/// or a string.
/// Arrays of primitive values are ingested as objects with a `data` property. Strings are
/// parsed according to the specified format type.
@property (nonatomic, nullable, copy) id values;
/// Provide a placeholder name and bind data at runtime.
@property (nonatomic, nullable, copy) NSString *name;
@end

/// An object that specifies the format for parsing the data file.
///
/// An object that specifies the format for parsing the data values.
///
/// An object that specifies the format for parsing the data.
@interface QTDataFormat : NSObject
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
@property (nonatomic, nullable, copy) id parse;
/// Type of input data: `"json"`, `"csv"`, `"tsv"`.
/// The default format type is determined by the extension of the file URL.
/// If no extension is detected, `"json"` will be used by default.
@property (nonatomic, nullable, assign) QTDataFormatType *type;
/// The JSON property containing the desired data.
/// This parameter can be used when the loaded JSON file may have surrounding structure or
/// meta-data.
/// For example `"property": "values.features"` is equivalent to retrieving
/// `json.values.features`
/// from the loaded JSON object.
@property (nonatomic, nullable, copy) NSString *property;
/// The name of the TopoJSON object set to convert to a GeoJSON feature collection.
/// For example, in a map of the world, there may be an object set named `"countries"`.
/// Using the feature property, we can extract this set and generate a GeoJSON feature object
/// for each country.
@property (nonatomic, nullable, copy) NSString *feature;
/// The name of the TopoJSON object set to convert to mesh.
/// Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
/// Unlike the `feature` option, the corresponding geo data is returned as a single, unified
/// mesh instance, not as individual GeoJSON features.
/// Extracting a mesh is useful for more efficiently drawing borders or other geographic
/// elements that you do not need to associate with specific regions such as individual
/// countries, states or counties.
@property (nonatomic, nullable, copy) NSString *mesh;
@end

/// A key-value mapping between encoding channels and definition of fields.
@interface QTEncodingWithFacet : NSObject
/// Color of the marks – either fill or stroke color based on mark type.
/// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
/// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
///
/// __Default value:__ If undefined, the default color depends on [mark
/// config](config.html#mark)'s `color` property.
///
/// _Note:_ See the scale documentation for more information about customizing [color
/// scheme](scale.html#scheme).
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *color;
/// Horizontal facets for trellis plots.
@property (nonatomic, nullable, strong) QTFacetFieldDef *column;
/// Additional levels of detail for grouping data in aggregate views and
/// in line and area marks without mapping data to a specific visual channel.
@property (nonatomic, nullable, copy) id detail;
/// A URL to load upon mouse click.
@property (nonatomic, nullable, strong) QTDefWithCondition *href;
/// Opacity of the marks – either can be a value or a range.
///
/// __Default value:__ If undefined, the default opacity depends on [mark
/// config](config.html#mark)'s `opacity` property.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *opacity;
/// Stack order for stacked marks or order of data points in line marks for connected scatter
/// plots.
///
/// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
/// additional aggregation grouping.
@property (nonatomic, nullable, copy) id order;
/// Vertical facets for trellis plots.
@property (nonatomic, nullable, strong) QTFacetFieldDef *row;
/// For `point` marks the supported values are
/// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
/// or `"triangle-down"`, or else a custom SVG path string.
/// For `geoshape` marks it should be a field definition of the geojson data
///
/// __Default value:__ If undefined, the default shape depends on [mark
/// config](config.html#point-config)'s `shape` property.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *shape;
/// Size of the mark.
/// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
/// - For `"bar"` and `"tick"` – the bar and tick's size.
/// - For `"text"` – the text's font size.
/// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *size;
/// Text of the `text` mark.
@property (nonatomic, nullable, strong) QTTextDefWithCondition *text;
/// The tooltip text to show upon mouse hover.
@property (nonatomic, nullable, strong) QTTextDefWithCondition *tooltip;
/// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
@property (nonatomic, nullable, strong) QTXClass *x;
/// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
@property (nonatomic, nullable, strong) QTX2Class *x2;
/// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
@property (nonatomic, nullable, strong) QTXClass *y;
/// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
@property (nonatomic, nullable, strong) QTX2Class *y2;
@end

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
@interface QTMarkPropDefWithCondition : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
/// One or more value definition(s) with a selection predicate.
///
/// __Note:__ A field definition's `condition` property can only contain [value
/// definitions](encoding.html#value-def)
/// since Vega-Lite only allows at most one encoded field per encoding channel.
///
/// A field definition or one or more value definition(s) with a selection predicate.
@property (nonatomic, nullable, copy) id condition;
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
@property (nonatomic, nullable, copy) id field;
/// An object defining properties of the legend.
/// If `null`, the legend for the encoding channel will be removed.
///
/// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
@property (nonatomic, nullable, strong) QTLegend *legend;
/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
@property (nonatomic, nullable, strong) QTScale *scale;
/// Sort order for the encoded field.
/// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
/// For fields with discrete domains, `sort` can also be a [sort field definition
/// object](sort.html#sort-field).
///
/// __Default value:__ `"ascending"`
@property (nonatomic, nullable, copy) id sort;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
/// A constant value in visual domain.
@property (nonatomic, nullable, copy) id value;
@end

/// Binning properties or boolean flag for determining whether to bin data or not.
@interface QTBinParams : NSObject
/// The number base to use for automatic bin determination (default is base 10).
///
/// __Default value:__ `10`
@property (nonatomic, nullable, strong) NSNumber *base;
/// Scale factors indicating allowable subdivisions. The default value is [5, 2], which
/// indicates that for base 10 numbers (the default base), the method may consider dividing
/// bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
/// check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
/// given constraints.
///
/// __Default value:__ `[5, 2]`
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *divide;
/// A two-element (`[min, max]`) array indicating the range of desired bin values.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *extent;
/// Maximum number of bins.
///
/// __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
@property (nonatomic, nullable, strong) NSNumber *maxbins;
/// A minimum allowable step size (particularly useful for integer values).
@property (nonatomic, nullable, strong) NSNumber *minstep;
/// If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
/// such as multiples of ten.
@property (nonatomic, nullable, strong) NSNumber *nice;
/// An exact step size to use between bins.
///
/// __Note:__ If provided, options such as maxbins will be ignored.
@property (nonatomic, nullable, strong) NSNumber *step;
/// An array of allowable step sizes to choose from.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *steps;
@end

@interface QTConditionalValueDef : NSObject
@property (nonatomic, nullable, copy) id test;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, copy) id value;
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
@property (nonatomic, nullable, copy) id selection;
@end

@interface QTSelection : NSObject
@property (nonatomic, nullable, copy) id not;
@property (nonatomic, nullable, copy) NSArray<id> *and;
@property (nonatomic, nullable, copy) NSArray<id> *or;
@end

@interface QTPredicate : NSObject
@property (nonatomic, nullable, copy) id not;
@property (nonatomic, nullable, copy) NSArray<id> *and;
@property (nonatomic, nullable, copy) NSArray<id> *or;
/// The value that the field should be equal to.
@property (nonatomic, nullable, copy) id equal;
/// Field to be filtered.
///
/// Field to be filtered
@property (nonatomic, nullable, copy) NSString *field;
/// Time unit for the field to be filtered.
///
/// time unit for the field to be filtered.
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// An array of inclusive minimum and maximum values
/// for a field value of a data item to be included in the filtered data.
@property (nonatomic, nullable, copy) NSArray<id> *range;
/// A set of values that the `field`'s value should be a member of,
/// for a data item included in the filtered data.
@property (nonatomic, nullable, copy) NSArray<id> *oneOf;
/// Filter using a selection name.
@property (nonatomic, nullable, copy) id selection;
@end

/// Object for defining datetime in Vega-Lite Filter.
/// If both month and quarter are provided, month has higher precedence.
/// `day` cannot be combined with other date.
/// We accept string for month and day names.
@interface QTDateTime : NSObject
/// Integer value representing the date from 1-31.
@property (nonatomic, nullable, strong) NSNumber *date;
/// Value representing the day of a week.  This can be one of: (1) integer value -- `1`
/// represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
/// case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
/// DateTime definition object with `day`** should not be combined with `year`, `quarter`,
/// `month`, or `date`.
@property (nonatomic, nullable, copy) id day;
/// Integer value representing the hour of a day from 0-23.
@property (nonatomic, nullable, strong) NSNumber *hours;
/// Integer value representing the millisecond segment of time.
@property (nonatomic, nullable, strong) NSNumber *milliseconds;
/// Integer value representing the minute segment of time from 0-59.
@property (nonatomic, nullable, strong) NSNumber *minutes;
/// One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
/// (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
/// short month name (e.g., `"Jan"`).
@property (nonatomic, nullable, copy) id month;
/// Integer value representing the quarter of the year (from 1-4).
@property (nonatomic, nullable, strong) NSNumber *quarter;
/// Integer value representing the second segment (0-59) of a time value
@property (nonatomic, nullable, strong) NSNumber *seconds;
/// A boolean flag indicating if date time is in utc time. If false, the date time is in
/// local time
@property (nonatomic, nullable, strong) NSNumber *utc;
/// Integer value representing the year.
@property (nonatomic, nullable, strong) NSNumber *year;
@end

@interface QTConditionalPredicateMarkPropFieldDefClass : NSObject
@property (nonatomic, nullable, copy) id test;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, nullable, copy) id value;
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
@property (nonatomic, nullable, copy) id selection;
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// An object defining properties of the legend.
/// If `null`, the legend for the encoding channel will be removed.
///
/// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
@property (nonatomic, nullable, strong) QTLegend *legend;
/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
@property (nonatomic, nullable, strong) QTScale *scale;
/// Sort order for the encoded field.
/// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
/// For fields with discrete domains, `sort` can also be a [sort field definition
/// object](sort.html#sort-field).
///
/// __Default value:__ `"ascending"`
@property (nonatomic, nullable, copy) id sort;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
@end

/// Reference to a repeated value.
@interface QTRepeatRef : NSObject
@property (nonatomic, assign) QTRepeatEnum *repeat;
@end

/// Properties of a legend or boolean flag for determining whether to show it.
@interface QTLegend : NSObject
/// Padding (in pixels) between legend entries in a symbol legend.
@property (nonatomic, nullable, strong) NSNumber *entryPadding;
/// The formatting pattern for labels. This is D3's [number format
/// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
/// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
/// field.
///
/// See the [format documentation](format.html) for more information.
///
/// __Default value:__  derived from [numberFormat](config.html#format) config for
/// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
@property (nonatomic, nullable, copy) NSString *format;
/// The offset, in pixels, by which to displace the legend from the edge of the enclosing
/// group or data rectangle.
///
/// __Default value:__  `0`
@property (nonatomic, nullable, strong) NSNumber *offset;
/// The orientation of the legend, which determines how the legend is positioned within the
/// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
/// "none".
///
/// __Default value:__ `"right"`
@property (nonatomic, nullable, assign) QTLegendOrient *orient;
/// The padding, in pixels, between the legend and axis.
@property (nonatomic, nullable, strong) NSNumber *padding;
/// The desired number of tick values for quantitative legends.
@property (nonatomic, nullable, strong) NSNumber *tickCount;
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
@property (nonatomic, nullable, copy) NSString *title;
/// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
/// continuous color gradient.
///
/// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
/// `"symbol"` otherwise.
@property (nonatomic, nullable, assign) QTLegendType *type;
/// Explicitly set the visible legend values.
@property (nonatomic, nullable, copy) NSArray<id> *values;
/// A non-positive integer indicating z-index of the legend.
/// If zindex is 0, legend should be drawn behind all chart elements.
/// To put them in front, use zindex = 1.
@property (nonatomic, nullable, strong) NSNumber *zindex;
@end

/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
@interface QTScale : NSObject
/// The logarithm base of the `log` scale (default `10`).
@property (nonatomic, nullable, strong) NSNumber *base;
/// If `true`, values that exceed the data domain are clamped to either the minimum or
/// maximum range value
///
/// __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
/// (`true` by default).
@property (nonatomic, nullable, strong) NSNumber *clamp;
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
@property (nonatomic, nullable, copy) id domain;
/// The exponent of the `pow` scale.
@property (nonatomic, nullable, strong) NSNumber *exponent;
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
@property (nonatomic, nullable, copy) id interpolate;
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
@property (nonatomic, nullable, copy) id nice;
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
@property (nonatomic, nullable, strong) NSNumber *padding;
/// The inner padding (spacing) within each band step of band scales, as a fraction of the
/// step size. This value must lie in the range [0,1].
///
/// For point scale, this property is invalid as point scales do not have internal band
/// widths (only step sizes between bands).
///
/// __Default value:__ derived from the [scale config](scale.html#config)'s
/// `bandPaddingInner`.
@property (nonatomic, nullable, strong) NSNumber *paddingInner;
/// The outer padding (spacing) at the ends of the range of band and point scales,
/// as a fraction of the step size. This value must lie in the range [0,1].
///
/// __Default value:__ derived from the [scale config](scale.html#config)'s
/// `bandPaddingOuter` for band scales and `pointPadding` for point scales.
@property (nonatomic, nullable, strong) NSNumber *paddingOuter;
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
@property (nonatomic, nullable, copy) id range;
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
@property (nonatomic, nullable, strong) NSNumber *rangeStep;
/// If `true`, rounds numeric output values to integers. This can be helpful for snapping to
/// the pixel grid.
///
/// __Default value:__ `false`.
@property (nonatomic, nullable, strong) NSNumber *round;
/// A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
/// `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
///
/// Discrete color schemes may be used with [discrete](scale.html#discrete) or
/// [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
/// use with [sequential](scales.html#sequential) scales.
///
/// For the full list of supported scheme, please refer to the [Vega
/// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
@property (nonatomic, nullable, copy) id scheme;
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
@property (nonatomic, nullable, assign) QTScaleType *type;
/// If `true`, ensures that a zero baseline value is included in the scale domain.
///
/// __Default value:__ `true` for x and y channels if the quantitative field is not binned
/// and no custom `domain` is provided; `false` otherwise.
///
/// __Note:__ Log, time, and utc scales do not support `zero`.
@property (nonatomic, nullable, strong) NSNumber *zero;
@end

@interface QTDomainClass : NSObject
/// The field name to extract selected values for, when a selection is
/// [projected](project.html)
/// over multiple fields or encodings.
@property (nonatomic, nullable, copy) NSString *field;
/// The name of a selection.
@property (nonatomic, copy) NSString *selection;
/// The encoding channel to extract selected values for, when a selection is
/// [projected](project.html)
/// over multiple fields or encodings.
@property (nonatomic, nullable, copy) NSString *encoding;
@end

@interface QTInterpolateParams : NSObject
@property (nonatomic, nullable, strong) NSNumber *gamma;
@property (nonatomic, assign)           QTInterpolateParamsType *type;
@end

@interface QTNiceClass : NSObject
@property (nonatomic, copy)   NSString *interval;
@property (nonatomic, assign) double step;
@end

@interface QTSchemeParams : NSObject
/// For sequential and diverging schemes only, determines the extent of the color range to
/// use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
/// range _[0, 0.2)_ are excluded from the scheme.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *extent;
/// A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
///
/// For the full list of supported scheme, please refer to the [Vega
/// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
@property (nonatomic, copy) NSString *name;
@end

@interface QTSortField : NSObject
/// The data [field](field.html) to sort by.
///
/// __Default value:__ If unspecified, defaults to the field specified in the outer data
/// reference.
@property (nonatomic, nullable, copy) id field;
/// An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
/// (e.g., `"count"`, `"mean"` and `"median"`).
/// This property is required in cases where the sort field and the data reference field do
/// not match.
/// The input data objects will be aggregated, grouped by the encoded data field.
///
/// For a full list of operations, please see the documentation for
/// [aggregate](aggregate.html#ops).
@property (nonatomic, assign) QTAggregateOp *op;
/// The sort order. One of `"ascending"` (default) or `"descending"`.
@property (nonatomic, nullable, assign) QTSortEnum *order;
@end

/// Horizontal facets for trellis plots.
///
/// Vertical facets for trellis plots.
@interface QTFacetFieldDef : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// An object defining properties of a facet's header.
@property (nonatomic, nullable, strong) QTHeader *header;
/// Sort order for a facet field.
/// This can be `"ascending"`, `"descending"`.
@property (nonatomic, nullable, assign) QTSortEnum *sort;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, assign) QTType *type;
@end

/// An object defining properties of a facet's header.
///
/// Headers of row / column channels for faceted plots.
@interface QTHeader : NSObject
/// The formatting pattern for labels. This is D3's [number format
/// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
/// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
/// field.
///
/// See the [format documentation](format.html) for more information.
///
/// __Default value:__  derived from [numberFormat](config.html#format) config for
/// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
@property (nonatomic, nullable, copy) NSString *format;
/// The rotation angle of the header labels.
///
/// __Default value:__ `0`.
@property (nonatomic, nullable, strong) NSNumber *labelAngle;
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
@property (nonatomic, nullable, copy) NSString *title;
@end

/// Definition object for a data field, its type and transformation of an encoding channel.
@interface QTFieldDef : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, assign) QTType *type;
@end

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
@interface QTDefWithCondition : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
/// One or more value definition(s) with a selection predicate.
///
/// __Note:__ A field definition's `condition` property can only contain [value
/// definitions](encoding.html#value-def)
/// since Vega-Lite only allows at most one encoded field per encoding channel.
///
/// A field definition or one or more value definition(s) with a selection predicate.
@property (nonatomic, nullable, copy) id condition;
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
@property (nonatomic, nullable, copy) id field;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
/// A constant value in visual domain.
@property (nonatomic, nullable, copy) id value;
@end

@interface QTConditionalPredicateFieldDefClass : NSObject
@property (nonatomic, nullable, copy) id test;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, nullable, copy) id value;
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
@property (nonatomic, nullable, copy) id selection;
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
@end

@interface QTOrderFieldDef : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// The sort order. One of `"ascending"` (default) or `"descending"`.
@property (nonatomic, nullable, assign) QTSortEnum *sort;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, assign) QTType *type;
@end

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
@interface QTTextDefWithCondition : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
/// One or more value definition(s) with a selection predicate.
///
/// __Note:__ A field definition's `condition` property can only contain [value
/// definitions](encoding.html#value-def)
/// since Vega-Lite only allows at most one encoded field per encoding channel.
///
/// A field definition or one or more value definition(s) with a selection predicate.
@property (nonatomic, nullable, copy) id condition;
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
@property (nonatomic, nullable, copy) id field;
/// The [formatting pattern](format.html) for a text field. If not defined, this will be
/// determined automatically.
@property (nonatomic, nullable, copy) NSString *format;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
/// A constant value in visual domain.
@property (nonatomic, nullable, copy) id value;
@end

@interface QTConditionalPredicateTextFieldDefClass : NSObject
@property (nonatomic, nullable, copy) id test;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, nullable, copy) id value;
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
@property (nonatomic, nullable, copy) id selection;
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// The [formatting pattern](format.html) for a text field. If not defined, this will be
/// determined automatically.
@property (nonatomic, nullable, copy) NSString *format;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
@end

/// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
///
/// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
///
/// Definition object for a constant value of an encoding channel.
@interface QTXClass : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// An object defining properties of axis's gridlines, ticks and labels.
/// If `null`, the axis for the encoding channel will be removed.
///
/// __Default value:__ If undefined, default [axis properties](axis.html) are applied.
@property (nonatomic, nullable, strong) QTAxis *axis;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
@property (nonatomic, nullable, strong) QTScale *scale;
/// Sort order for the encoded field.
/// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
/// For fields with discrete domains, `sort` can also be a [sort field definition
/// object](sort.html#sort-field).
///
/// __Default value:__ `"ascending"`
@property (nonatomic, nullable, copy) id sort;
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
@property (nonatomic, nullable, assign) QTStackOffset *stack;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, nullable, copy) id value;
@end

@interface QTAxis : NSObject
/// A boolean flag indicating if the domain (the axis baseline) should be included as part of
/// the axis.
///
/// __Default value:__ `true`
@property (nonatomic, nullable, strong) NSNumber *domain;
/// The formatting pattern for labels. This is D3's [number format
/// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
/// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
/// field.
///
/// See the [format documentation](format.html) for more information.
///
/// __Default value:__  derived from [numberFormat](config.html#format) config for
/// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
@property (nonatomic, nullable, copy) NSString *format;
/// A boolean flag indicating if grid lines should be included as part of the axis
///
/// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
/// binned; otherwise, `false`.
@property (nonatomic, nullable, strong) NSNumber *grid;
/// The rotation angle of the axis labels.
///
/// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
@property (nonatomic, nullable, strong) NSNumber *labelAngle;
/// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
/// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
/// they exceed the axis range by more than 1 pixel. If this property is a number, it
/// specifies the pixel tolerance: the maximum amount by which a label bounding box may
/// exceed the axis range.
///
/// __Default value:__ `false`.
@property (nonatomic, nullable, copy) id labelBound;
/// Indicates if the first and last axis labels should be aligned flush with the scale range.
/// Flush alignment for a horizontal axis will left-align the first label and right-align the
/// last label. For vertical axes, bottom and top text baselines are applied instead. If this
/// property is a number, it also indicates the number of pixels by which to offset the first
/// and last labels; for example, a value of 2 will flush-align the first and last labels and
/// also push them 2 pixels outward from the center of the axis. The additional adjustment
/// can sometimes help the labels better visually group with corresponding axis ticks.
///
/// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
@property (nonatomic, nullable, copy) id labelFlush;
/// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
/// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
/// every other label is used (this works well for standard linear axes). If set to
/// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
/// with the last visible label (this often works better for log-scaled axes).
///
/// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
/// scales; otherwise `false`.
@property (nonatomic, nullable, copy) id labelOverlap;
/// The padding, in pixels, between axis and text labels.
@property (nonatomic, nullable, strong) NSNumber *labelPadding;
/// A boolean flag indicating if labels should be included as part of the axis.
///
/// __Default value:__  `true`.
@property (nonatomic, nullable, strong) NSNumber *labels;
/// The maximum extent in pixels that axis ticks and labels should use. This determines a
/// maximum offset value for axis titles.
///
/// __Default value:__ `undefined`.
@property (nonatomic, nullable, strong) NSNumber *maxExtent;
/// The minimum extent in pixels that axis ticks and labels should use. This determines a
/// minimum offset value for axis titles.
///
/// __Default value:__ `30` for y-axis; `undefined` for x-axis.
@property (nonatomic, nullable, strong) NSNumber *minExtent;
/// The offset, in pixels, by which to displace the axis from the edge of the enclosing group
/// or data rectangle.
///
/// __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
/// `offset` (`0` by default)
@property (nonatomic, nullable, strong) NSNumber *offset;
/// The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
/// orientation can be used to further specialize the axis type (e.g., a y axis oriented for
/// the right edge of the chart).
///
/// __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
@property (nonatomic, nullable, assign) QTTitleOrient *orient;
/// The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
/// this sets the axis group x coordinate. For y-axis with left or right orientation, this
/// sets the axis group y coordinate.
///
/// __Default value__: `0`
@property (nonatomic, nullable, strong) NSNumber *position;
/// A desired number of ticks, for axes visualizing quantitative scales. The resulting number
/// may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
/// underlying scale's range.
@property (nonatomic, nullable, strong) NSNumber *tickCount;
/// Boolean value that determines whether the axis should include ticks.
@property (nonatomic, nullable, strong) NSNumber *ticks;
/// The size in pixels of axis ticks.
@property (nonatomic, nullable, strong) NSNumber *tickSize;
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
@property (nonatomic, nullable, copy) NSString *title;
/// Max length for axis title if the title is automatically generated from the field's
/// description.
@property (nonatomic, nullable, strong) NSNumber *titleMaxLength;
/// The padding, in pixels, between title and axis.
@property (nonatomic, nullable, strong) NSNumber *titlePadding;
/// Explicitly set the visible axis tick values.
@property (nonatomic, nullable, copy) NSArray<id> *values;
/// A non-positive integer indicating z-index of the axis.
/// If zindex is 0, axes should be drawn behind all chart elements.
/// To put them in front, use `"zindex = 1"`.
///
/// __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
/// for grids.
@property (nonatomic, nullable, strong) NSNumber *zindex;
@end

/// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Definition object for a data field, its type and transformation of an encoding channel.
///
/// Definition object for a constant value of an encoding channel.
@interface QTX2Class : NSObject
/// Aggregation function for the field
/// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTAggregateOp *aggregate;
/// A flag for binning a `quantitative` field, or [an object defining binning
/// parameters](bin.html#params).
/// If `true`, default [binning parameters](bin.html) will be applied.
///
/// __Default value:__ `false`
@property (nonatomic, nullable, copy) id bin;
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
@property (nonatomic, nullable, copy) id field;
/// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
/// or [a temporal field that gets casted as ordinal](type.html#cast).
///
/// __Default value:__ `undefined` (None)
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
@property (nonatomic, nullable, assign) QTType *type;
/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
@property (nonatomic, nullable, copy) id value;
@end

/// An object that describes mappings between `row` and `column` channels and their field
/// definitions.
@interface QTFacetMapping : NSObject
/// Horizontal facets for trellis plots.
@property (nonatomic, nullable, strong) QTFacetFieldDef *column;
/// Vertical facets for trellis plots.
@property (nonatomic, nullable, strong) QTFacetFieldDef *row;
@end

/// Unit spec that can have a composite mark.
@interface QTSpec : NSObject
/// An object describing the data source
@property (nonatomic, nullable, strong) QTData *data;
/// Description of this mark for commenting purpose.
@property (nonatomic, nullable, copy) NSString *theDescription;
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
@property (nonatomic, nullable, strong) NSNumber *height;
/// Layer or single view specifications to be layered.
///
/// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
/// layering facet specifications is not allowed.
@property (nonatomic, nullable, copy) NSArray<QTLayerSpec *> *layer;
/// Name of the visualization for later reference.
@property (nonatomic, nullable, copy) NSString *name;
/// Scale, axis, and legend resolutions for layers.
///
/// Scale, axis, and legend resolutions for facets.
///
/// Scale and legend resolutions for repeated charts.
///
/// Scale, axis, and legend resolutions for vertically concatenated charts.
///
/// Scale, axis, and legend resolutions for horizontally concatenated charts.
@property (nonatomic, nullable, strong) QTResolve *resolve;
/// Title for the plot.
@property (nonatomic, nullable, copy) id title;
/// An array of data transformations such as filter and new field calculation.
@property (nonatomic, nullable, copy) NSArray<QTTransform *> *transform;
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
@property (nonatomic, nullable, strong) NSNumber *width;
/// A key-value mapping between encoding channels and definition of fields.
@property (nonatomic, nullable, strong) QTEncoding *encoding;
/// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
/// `"line"`,
/// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
/// object](mark.html#mark-def).
@property (nonatomic, nullable, copy) id mark;
/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
@property (nonatomic, nullable, strong) QTProjection *projection;
/// A key-value mapping between selection names and definitions.
@property (nonatomic, nullable, copy) NSDictionary<NSString *, QTSelectionDef *> *selection;
/// An object that describes mappings between `row` and `column` channels and their field
/// definitions.
@property (nonatomic, nullable, strong) QTFacetMapping *facet;
/// A specification of the view that gets faceted.
@property (nonatomic, nullable, strong) QTSpec *spec;
/// An object that describes what fields should be repeated into views that are laid out as a
/// `row` or `column`.
@property (nonatomic, nullable, strong) QTRepeat *repeat;
/// A list of views that should be concatenated and put into a column.
@property (nonatomic, nullable, copy) NSArray<QTSpec *> *vconcat;
/// A list of views that should be concatenated and put into a row.
@property (nonatomic, nullable, copy) NSArray<QTSpec *> *hconcat;
@end

/// A key-value mapping between encoding channels and definition of fields.
@interface QTEncoding : NSObject
/// Color of the marks – either fill or stroke color based on mark type.
/// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
/// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
///
/// __Default value:__ If undefined, the default color depends on [mark
/// config](config.html#mark)'s `color` property.
///
/// _Note:_ See the scale documentation for more information about customizing [color
/// scheme](scale.html#scheme).
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *color;
/// Additional levels of detail for grouping data in aggregate views and
/// in line and area marks without mapping data to a specific visual channel.
@property (nonatomic, nullable, copy) id detail;
/// A URL to load upon mouse click.
@property (nonatomic, nullable, strong) QTDefWithCondition *href;
/// Opacity of the marks – either can be a value or a range.
///
/// __Default value:__ If undefined, the default opacity depends on [mark
/// config](config.html#mark)'s `opacity` property.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *opacity;
/// Stack order for stacked marks or order of data points in line marks for connected scatter
/// plots.
///
/// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
/// additional aggregation grouping.
@property (nonatomic, nullable, copy) id order;
/// For `point` marks the supported values are
/// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
/// or `"triangle-down"`, or else a custom SVG path string.
/// For `geoshape` marks it should be a field definition of the geojson data
///
/// __Default value:__ If undefined, the default shape depends on [mark
/// config](config.html#point-config)'s `shape` property.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *shape;
/// Size of the mark.
/// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
/// - For `"bar"` and `"tick"` – the bar and tick's size.
/// - For `"text"` – the text's font size.
/// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
@property (nonatomic, nullable, strong) QTMarkPropDefWithCondition *size;
/// Text of the `text` mark.
@property (nonatomic, nullable, strong) QTTextDefWithCondition *text;
/// The tooltip text to show upon mouse hover.
@property (nonatomic, nullable, strong) QTTextDefWithCondition *tooltip;
/// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
@property (nonatomic, nullable, strong) QTXClass *x;
/// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
@property (nonatomic, nullable, strong) QTX2Class *x2;
/// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
@property (nonatomic, nullable, strong) QTXClass *y;
/// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
@property (nonatomic, nullable, strong) QTX2Class *y2;
@end

/// Unit spec that can have a composite mark.
@interface QTLayerSpec : NSObject
/// An object describing the data source
@property (nonatomic, nullable, strong) QTData *data;
/// Description of this mark for commenting purpose.
@property (nonatomic, nullable, copy) NSString *theDescription;
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
@property (nonatomic, nullable, strong) NSNumber *height;
/// Layer or single view specifications to be layered.
///
/// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
/// layering facet specifications is not allowed.
@property (nonatomic, nullable, copy) NSArray<QTLayerSpec *> *layer;
/// Name of the visualization for later reference.
@property (nonatomic, nullable, copy) NSString *name;
/// Scale, axis, and legend resolutions for layers.
@property (nonatomic, nullable, strong) QTResolve *resolve;
/// Title for the plot.
@property (nonatomic, nullable, copy) id title;
/// An array of data transformations such as filter and new field calculation.
@property (nonatomic, nullable, copy) NSArray<QTTransform *> *transform;
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
@property (nonatomic, nullable, strong) NSNumber *width;
/// A key-value mapping between encoding channels and definition of fields.
@property (nonatomic, nullable, strong) QTEncoding *encoding;
/// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
/// `"line"`,
/// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
/// object](mark.html#mark-def).
@property (nonatomic, nullable, copy) id mark;
/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
@property (nonatomic, nullable, strong) QTProjection *projection;
/// A key-value mapping between selection names and definitions.
@property (nonatomic, nullable, copy) NSDictionary<NSString *, QTSelectionDef *> *selection;
@end

@interface QTMarkDef : NSObject
/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
@property (nonatomic, nullable, assign) QTHorizontalAlign *align;
/// The rotation angle of the text, in degrees.
@property (nonatomic, nullable, strong) NSNumber *angle;
/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
@property (nonatomic, nullable, assign) QTVerticalAlign *baseline;
/// Whether a mark be clipped to the enclosing group’s width and height.
@property (nonatomic, nullable, strong) NSNumber *clip;
/// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
/// will override `color`.
///
/// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, copy) NSString *color;
/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
@property (nonatomic, nullable, assign) QTCursor *cursor;
/// The horizontal offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dx;
/// The vertical offset, in pixels, between the text label and its anchor point. The offset
/// is applied after rotation by the _angle_ property.
@property (nonatomic, nullable, strong) NSNumber *dy;
/// Default Fill Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *fill;
/// Whether the mark's color should be used as fill color instead of stroke color.
///
/// __Default value:__ `true` for all marks except `point` and `false` for `point`.
///
/// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
///
/// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
@property (nonatomic, nullable, strong) NSNumber *filled;
/// The fill opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *fillOpacity;
/// The typeface to set the text in (e.g., `"Helvetica Neue"`).
@property (nonatomic, nullable, copy) NSString *font;
/// The font size, in pixels.
@property (nonatomic, nullable, strong) NSNumber *fontSize;
/// The font style (e.g., `"italic"`).
@property (nonatomic, nullable, assign) QTFontStyle *fontStyle;
/// The font weight (e.g., `"bold"`).
@property (nonatomic, nullable, copy) id fontWeight;
/// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
@property (nonatomic, nullable, copy) NSString *href;
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
@property (nonatomic, nullable, assign) QTInterpolate *interpolate;
/// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
/// value will be automatically truncated if the rendered size exceeds the limit.
@property (nonatomic, nullable, strong) NSNumber *limit;
/// The overall opacity (value between [0,1]).
///
/// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
/// `square` marks or layered `bar` charts and `1` otherwise.
@property (nonatomic, nullable, strong) NSNumber *opacity;
/// The orientation of a non-stacked bar, tick, area, and line charts.
/// The value is either horizontal (default) or vertical.
/// - For bar, rule and tick, this determines whether the size of the bar and tick
/// should be applied to x or y dimension.
/// - For area, this property determines the orient property of the Vega output.
/// - For line, this property determines the sort order of the points in the line
/// if `config.sortLineBy` is not specified.
/// For stacked charts, this is always determined by the orientation of the stack;
/// therefore explicitly specified value will be ignored.
@property (nonatomic, nullable, assign) QTOrient *orient;
/// Polar coordinate radial offset, in pixels, of the text label from the origin determined
/// by the `x` and `y` properties.
@property (nonatomic, nullable, strong) NSNumber *radius;
/// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
/// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
///
/// __Default value:__ `"circle"`
@property (nonatomic, nullable, copy) NSString *shape;
/// The pixel area each the point/circle/square.
/// For example: in the case of circles, the radius is determined in part by the square root
/// of the size value.
///
/// __Default value:__ `30`
@property (nonatomic, nullable, strong) NSNumber *size;
/// Default Stroke Color.  This has higher precedence than config.color
///
/// __Default value:__ (None)
@property (nonatomic, nullable, copy) NSString *stroke;
/// An array of alternating stroke, space lengths for creating dashed or dotted lines.
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *strokeDash;
/// The offset (in pixels) into which to begin drawing with the stroke dash array.
@property (nonatomic, nullable, strong) NSNumber *strokeDashOffset;
/// The stroke opacity (value between [0,1]).
///
/// __Default value:__ `1`
@property (nonatomic, nullable, strong) NSNumber *strokeOpacity;
/// The stroke width, in pixels.
@property (nonatomic, nullable, strong) NSNumber *strokeWidth;
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
@property (nonatomic, nullable, copy) id style;
/// Depending on the interpolation type, sets the tension parameter (for line and area marks).
@property (nonatomic, nullable, strong) NSNumber *tension;
/// Placeholder text if the `text` channel is not specified
@property (nonatomic, nullable, copy) NSString *text;
/// Polar coordinate angle, in radians, of the text label from the origin determined by the
/// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
/// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
/// indicating "north".
@property (nonatomic, nullable, strong) NSNumber *theta;
/// The mark type.
/// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
/// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
@property (nonatomic, assign) QTMark *type;
@end

/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
@interface QTProjection : NSObject
/// Sets the projection’s center to the specified center, a two-element array of longitude
/// and latitude in degrees.
///
/// __Default value:__ `[0, 0]`
@property (nonatomic, nullable, copy) NSArray<NSNumber *> *center;
/// Sets the projection’s clipping circle radius to the specified angle in degrees. If
/// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
/// than small-circle clipping.
@property (nonatomic, nullable, strong) NSNumber *clipAngle;
/// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
/// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
/// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
/// viewport clipping is performed.
@property (nonatomic, nullable, copy)   NSArray<NSArray<NSNumber *> *> *clipExtent;
@property (nonatomic, nullable, strong) NSNumber *coefficient;
@property (nonatomic, nullable, strong) NSNumber *distance;
@property (nonatomic, nullable, strong) NSNumber *fraction;
@property (nonatomic, nullable, strong) NSNumber *lobes;
@property (nonatomic, nullable, strong) NSNumber *parallel;
/// Sets the threshold for the projection’s [adaptive
/// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
/// value corresponds to the [Douglas–Peucker
/// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
/// If precision is not specified, returns the projection’s current resampling precision
/// which defaults to `√0.5 ≅ 0.70710…`.
@property (nonatomic, nullable, copy)   NSDictionary<NSString *, id> *precision;
@property (nonatomic, nullable, strong) NSNumber *radius;
@property (nonatomic, nullable, strong) NSNumber *ratio;
/// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
/// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
/// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
///
/// __Default value:__ `[0, 0, 0]`
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *rotate;
@property (nonatomic, nullable, strong) NSNumber *spacing;
@property (nonatomic, nullable, strong) NSNumber *tilt;
/// The cartographic projection to use. This value is case-insensitive, for example
/// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
/// projection types [in the
/// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
/// __Default value:__ `mercator`
@property (nonatomic, nullable, assign) QTVGProjectionType *type;
@end

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
@interface QTResolve : NSObject
@property (nonatomic, nullable, strong) QTAxisResolveMap *axis;
@property (nonatomic, nullable, strong) QTLegendResolveMap *legend;
@property (nonatomic, nullable, strong) QTScaleResolveMap *scale;
@end

@interface QTAxisResolveMap : NSObject
@property (nonatomic, nullable, assign) QTResolveMode *x;
@property (nonatomic, nullable, assign) QTResolveMode *y;
@end

@interface QTLegendResolveMap : NSObject
@property (nonatomic, nullable, assign) QTResolveMode *color;
@property (nonatomic, nullable, assign) QTResolveMode *opacity;
@property (nonatomic, nullable, assign) QTResolveMode *shape;
@property (nonatomic, nullable, assign) QTResolveMode *size;
@end

@interface QTScaleResolveMap : NSObject
@property (nonatomic, nullable, assign) QTResolveMode *color;
@property (nonatomic, nullable, assign) QTResolveMode *opacity;
@property (nonatomic, nullable, assign) QTResolveMode *shape;
@property (nonatomic, nullable, assign) QTResolveMode *size;
@property (nonatomic, nullable, assign) QTResolveMode *x;
@property (nonatomic, nullable, assign) QTResolveMode *y;
@end

@interface QTSelectionDef : NSObject
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
@property (nonatomic, nullable, copy) id bind;
/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
@property (nonatomic, nullable, assign) QTEmpty *empty;
/// An array of encoding channels. The corresponding data field values
/// must match for a data tuple to fall within the selection.
@property (nonatomic, nullable, copy) NSArray<QTSingleDefChannel *> *encodings;
/// An array of field names whose values must match for a data tuple to
/// fall within the selection.
@property (nonatomic, nullable, copy) NSArray<NSString *> *fields;
/// When true, an invisible voronoi diagram is computed to accelerate discrete
/// selection. The data value _nearest_ the mouse cursor is added to the selection.
///
/// See the [nearest transform](nearest.html) documentation for more information.
@property (nonatomic, nullable, strong) NSNumber *nearest;
/// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
/// selector) that triggers the selection.
/// For interval selections, the event stream must specify a [start and
/// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
@property (nonatomic, nullable, copy) id on;
/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
@property (nonatomic, nullable, assign) QTSelectionResolution *resolve;
@property (nonatomic, assign)           QTSelectionDefType *type;
/// Controls whether data values should be toggled or only ever inserted into
/// multi selections. Can be `true`, `false` (for insertion only), or a
/// [Vega expression](https://vega.github.io/vega/docs/expressions/).
///
/// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
/// data values are toggled when a user interacts with the shift-key pressed).
///
/// See the [toggle transform](toggle.html) documentation for more information.
@property (nonatomic, nullable, copy) id toggle;
/// An interval selection also adds a rectangle mark to depict the
/// extents of the interval. The `mark` property can be used to customize the
/// appearance of the mark.
@property (nonatomic, nullable, strong) QTBrushConfig *mark;
/// When truthy, allows a user to interactively move an interval selection
/// back-and-forth. Can be `true`, `false` (to disable panning), or a
/// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
/// which must include a start and end event to trigger continuous panning.
///
/// __Default value:__ `true`, which corresponds to
/// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
/// clicks and dragging within an interval selection to reposition it.
@property (nonatomic, nullable, copy) id translate;
/// When truthy, allows a user to interactively resize an interval selection.
/// Can be `true`, `false` (to disable zooming), or a [Vega event stream
/// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
/// only `wheel` events are supported.
///
///
/// __Default value:__ `true`, which corresponds to `wheel!`.
@property (nonatomic, nullable, copy) id zoom;
@end

@interface QTTitleParams : NSObject
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
@property (nonatomic, nullable, assign) QTAnchor *anchor;
/// The orthogonal offset in pixels by which to displace the title from its position along
/// the edge of the chart.
@property (nonatomic, nullable, strong) NSNumber *offset;
/// The orientation of the title relative to the chart. One of `"top"` (the default),
/// `"bottom"`, `"left"`, or `"right"`.
@property (nonatomic, nullable, assign) QTTitleOrient *orient;
/// A [mark style property](config.html#style) to apply to the title text mark.
///
/// __Default value:__ `"group-title"`.
@property (nonatomic, nullable, copy) id style;
/// The title text.
@property (nonatomic, copy) NSString *text;
@end

@interface QTTransform : NSObject
/// The `filter` property must be one of the predicate definitions:
/// (1) an [expression](types.html#expression) string,
/// where `datum` can be used to refer to the current data object;
/// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
/// [range predicate](filter.html#range-predicate), [one-of
/// predicate](filter.html#one-of-predicate);
/// (3) a [selection predicate](filter.html#selection-predicate);
/// or (4) a logical operand that combines (1), (2), or (3).
@property (nonatomic, nullable, copy) id filter;
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
@property (nonatomic, nullable, copy) id as;
/// A [expression](types.html#expression) string. Use the variable `datum` to refer to the
/// current data object.
@property (nonatomic, nullable, copy) NSString *calculate;
/// The default value to use if lookup fails.
///
/// __Default value:__ `null`
@property (nonatomic, nullable, copy) NSString *transformDefault;
/// Secondary data reference.
@property (nonatomic, nullable, strong) QTLookupData *from;
/// Key in primary data source.
@property (nonatomic, nullable, copy) NSString *lookup;
/// An object indicating bin properties, or simply `true` for using default bin parameters.
@property (nonatomic, nullable, copy) id bin;
/// The data field to bin.
///
/// The data field to apply time unit.
@property (nonatomic, nullable, copy) NSString *field;
/// The timeUnit.
@property (nonatomic, nullable, assign) QTTimeUnit *timeUnit;
/// Array of objects that define fields to aggregate.
@property (nonatomic, nullable, copy) NSArray<QTAggregatedFieldDef *> *aggregate;
/// The data fields to group by. If not specified, a single group containing all data objects
/// will be used.
@property (nonatomic, nullable, copy) NSArray<NSString *> *groupby;
@end

@interface QTAggregatedFieldDef : NSObject
/// The output field names to use for each aggregated field.
@property (nonatomic, copy) NSString *as;
/// The data field for which to compute aggregate function.
@property (nonatomic, copy) NSString *field;
/// The aggregation operations to apply to the fields, such as sum, average or count.
/// See the [full list of supported aggregation
/// operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
/// for more information.
@property (nonatomic, assign) QTAggregateOp *op;
@end

/// Secondary data reference.
@interface QTLookupData : NSObject
/// Secondary data source to lookup in.
@property (nonatomic, strong) QTData *data;
/// Fields in foreign data to lookup.
/// If not specified, the entire object is queried.
@property (nonatomic, nullable, copy) NSArray<NSString *> *fields;
/// Key in data to lookup.
@property (nonatomic, copy) NSString *key;
@end

/// An object that describes what fields should be repeated into views that are laid out as a
/// `row` or `column`.
@interface QTRepeat : NSObject
/// Horizontal repeated views.
@property (nonatomic, nullable, copy) NSArray<NSString *> *column;
/// Vertical repeated views.
@property (nonatomic, nullable, copy) NSArray<NSString *> *row;
@end

NS_ASSUME_NONNULL_END
