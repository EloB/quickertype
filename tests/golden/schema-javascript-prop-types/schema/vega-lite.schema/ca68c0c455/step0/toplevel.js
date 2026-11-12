// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";

let _TopLevel;
let _AutoSizeParams;
let _Config;
let _MarkConfig;
let _AxisConfig;
let _VGAxisConfig;
let _BarConfig;
let _LegendConfig;
let _PaddingClass;
let _ProjectionConfig;
let _VGScheme;
let _ScaleConfig;
let _SelectionConfig;
let _IntervalSelectionConfig;
let _BrushConfig;
let _MultiSelectionConfig;
let _SingleSelectionConfig;
let _VGBinding;
let _VGMarkConfig;
let _TextConfig;
let _TickConfig;
let _VGTitleConfig;
let _ViewConfig;
let _Data;
let _DataFormat;
let _EncodingWithFacet;
let _MarkPropDefWithCondition;
let _BinParams;
let _ConditionalValueDef;
let _Selection;
let _Predicate;
let _DateTime;
let _ConditionalPredicateMarkPropFieldDefClass;
let _RepeatRef;
let _Legend;
let _Scale;
let _DomainClass;
let _InterpolateParams;
let _NiceClass;
let _SchemeParams;
let _SortField;
let _FacetFieldDef;
let _Header;
let _FieldDef;
let _DefWithCondition;
let _ConditionalPredicateFieldDefClass;
let _OrderFieldDef;
let _TextDefWithCondition;
let _ConditionalPredicateTextFieldDefClass;
let _XClass;
let _Axis;
let _X2Class;
let _FacetMapping;
let _Spec;
let _Encoding;
let _LayerSpec;
let _MarkDef;
let _Projection;
let _Resolve;
let _AxisResolveMap;
let _LegendResolveMap;
let _ScaleResolveMap;
let _SelectionDef;
let _TitleParams;
let _Transform;
let _AggregatedFieldDef;
let _LookupData;
let _Repeat;
const _Contains = PropTypes.oneOf(['content', 'padding']);
const _AutosizeType = PropTypes.oneOf(['pad', 'fit', 'none']);
const _HorizontalAlign = PropTypes.oneOf(['left', 'right', 'center']);
const _VerticalAlign = PropTypes.oneOf(['top', 'middle', 'bottom']);
const _Cursor = PropTypes.oneOf(['auto', 'default', 'none', 'context-menu', 'help', 'pointer', 'progress', 'wait', 'cell', 'crosshair', 'text', 'vertical-text', 'alias', 'copy', 'move', 'no-drop', 'not-allowed', 'e-resize', 'n-resize', 'ne-resize', 'nw-resize', 's-resize', 'se-resize', 'sw-resize', 'w-resize', 'ew-resize', 'ns-resize', 'nesw-resize', 'nwse-resize', 'col-resize', 'row-resize', 'all-scroll', 'zoom-in', 'zoom-out', 'grab', 'grabbing']);
const _FontStyle = PropTypes.oneOf(['normal', 'italic']);
const _FontWeight = PropTypes.oneOf(['normal', 'bold']);
const _Interpolate = PropTypes.oneOf(['linear', 'linear-closed', 'step', 'step-before', 'step-after', 'basis', 'basis-open', 'basis-closed', 'cardinal', 'cardinal-open', 'cardinal-closed', 'bundle', 'monotone']);
const _Orient = PropTypes.oneOf(['horizontal', 'vertical']);
const _LabelOverlapEnum = PropTypes.oneOf(['parity', 'greedy']);
const _FieldTitle = PropTypes.oneOf(['verbal', 'functional', 'plain']);
const _InvalidValues = PropTypes.oneOf(['filter']);
const _LegendOrient = PropTypes.oneOf(['left', 'right', 'top-left', 'top-right', 'bottom-left', 'bottom-right', 'none']);
const _VGProjectionType = PropTypes.oneOf(['albers', 'albersUsa', 'azimuthalEqualArea', 'azimuthalEquidistant', 'conicConformal', 'conicEqualArea', 'conicEquidistant', 'equirectangular', 'gnomonic', 'mercator', 'orthographic', 'stereographic', 'transverseMercator']);
const _BindEnum = PropTypes.oneOf(['scales']);
const _Empty = PropTypes.oneOf(['all', 'none']);
const _SingleDefChannel = PropTypes.oneOf(['x', 'y', 'x2', 'y2', 'row', 'column', 'size', 'shape', 'color', 'opacity', 'text', 'tooltip', 'href']);
const _SelectionResolution = PropTypes.oneOf(['global', 'union', 'intersect']);
const _StackOffset = PropTypes.oneOf(['zero', 'center', 'normalize']);
const _Anchor = PropTypes.oneOf(['start', 'middle', 'end']);
const _TitleOrient = PropTypes.oneOf(['top', 'bottom', 'left', 'right']);
const _ParseEnum = PropTypes.oneOf(['auto']);
const _DataFormatType = PropTypes.oneOf(['csv', 'tsv', 'json', 'topojson']);
const _AggregateOp = PropTypes.oneOf(['argmax', 'argmin', 'average', 'count', 'distinct', 'max', 'mean', 'median', 'min', 'missing', 'q1', 'q3', 'ci0', 'ci1', 'stdev', 'stdevp', 'sum', 'valid', 'values', 'variance', 'variancep']);
const _TimeUnit = PropTypes.oneOf(['year', 'quarter', 'month', 'day', 'date', 'hours', 'minutes', 'seconds', 'milliseconds', 'utcyear', 'utcquarter', 'utcmonth', 'utcday', 'utcdate', 'utchours', 'utcminutes', 'utcseconds', 'utcmilliseconds', 'yearquarter', 'yearquartermonth', 'yearmonth', 'yearmonthdate', 'yearmonthdatehours', 'yearmonthdatehoursminutes', 'yearmonthdatehoursminutesseconds', 'quartermonth', 'monthdate', 'hoursminutes', 'hoursminutesseconds', 'minutesseconds', 'secondsmilliseconds', 'utcyearquarter', 'utcyearquartermonth', 'utcyearmonth', 'utcyearmonthdate', 'utcyearmonthdatehours', 'utcyearmonthdatehoursminutes', 'utcyearmonthdatehoursminutesseconds', 'utcquartermonth', 'utcmonthdate', 'utchoursminutes', 'utchoursminutesseconds', 'utcminutesseconds', 'utcsecondsmilliseconds']);
const _RepeatEnum = PropTypes.oneOf(['row', 'column']);
const _LegendType = PropTypes.oneOf(['symbol', 'gradient']);
const _Domain = PropTypes.oneOf(['unaggregated']);
const _InterpolateParamsType = PropTypes.oneOf(['rgb', 'cubehelix', 'cubehelix-long']);
const _NiceTime = PropTypes.oneOf(['second', 'minute', 'hour', 'day', 'week', 'month', 'year']);
const _ScaleType = PropTypes.oneOf(['linear', 'bin-linear', 'log', 'pow', 'sqrt', 'time', 'utc', 'sequential', 'ordinal', 'bin-ordinal', 'point', 'band']);
const _SortEnum = PropTypes.oneOf(['ascending', 'descending']);
const _Type = PropTypes.oneOf(['quantitative', 'ordinal', 'temporal', 'nominal', 'latitude', 'longitude', 'geojson']);
const _Mark = PropTypes.oneOf(['area', 'bar', 'line', 'point', 'text', 'tick', 'rect', 'rule', 'circle', 'square', 'geoshape']);
const _ResolveMode = PropTypes.oneOf(['independent', 'shared']);
const _SelectionDefType = PropTypes.oneOf(['single', 'multi', 'interval']);
_AutoSizeParams = PropTypes.shape({
    "contains": PropTypes.oneOfType([_Contains, PropTypes.oneOf([null])]),
    "resize": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_AutosizeType, PropTypes.oneOf([null])]),
});
_MarkConfig = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "filled": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_AxisConfig = PropTypes.shape({
    "bandPosition": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "domain": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "domainColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "domainWidth": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "grid": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "gridColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gridDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "gridOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "gridWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelAngle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= -360 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelBound": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFlush": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labelOverlap": PropTypes.oneOfType([PropTypes.bool, _LabelOverlapEnum, PropTypes.oneOf([null])]),
    "labelPadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "maxExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "minExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "shortTimeLabels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "tickColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "tickRound": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "ticks": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "tickSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tickWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "titleAlign": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleAngle": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleBaseline": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "titleFontWeight": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "titleLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleMaxLength": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titlePadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleX": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleY": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_VGAxisConfig = PropTypes.shape({
    "bandPosition": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "domain": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "domainColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "domainWidth": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "grid": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "gridColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gridDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "gridOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "gridWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelAngle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= -360 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelBound": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFlush": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labelOverlap": PropTypes.oneOfType([PropTypes.bool, _LabelOverlapEnum, PropTypes.oneOf([null])]),
    "labelPadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "maxExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "minExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "tickColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "tickRound": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "ticks": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "tickSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tickWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "titleAlign": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleAngle": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleBaseline": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "titleFontWeight": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "titleLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleMaxLength": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titlePadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleX": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleY": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_BarConfig = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "binSpacing": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "continuousBandSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "discreteBandSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "filled": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_LegendConfig = PropTypes.shape({
    "cornerRadius": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "entryPadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fillColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gradientHeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "gradientLabelBaseline": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gradientLabelLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "gradientLabelOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "gradientStrokeColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gradientStrokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "gradientWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelAlign": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelBaseline": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labelOffset": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "offset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_LegendOrient, PropTypes.oneOf([null])]),
    "padding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "shortTimeLabels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "strokeColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "symbolColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "symbolSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "symbolStrokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "symbolType": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleAlign": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleBaseline": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleColor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFont": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleFontSize": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titleFontWeight": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "titleLimit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titlePadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_PaddingClass = PropTypes.shape({
    "bottom": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "left": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "right": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "top": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_ProjectionConfig = PropTypes.shape({
    "center": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "clipAngle": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "clipExtent": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.number)), PropTypes.oneOf([null])]),
    "coefficient": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "distance": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fraction": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "lobes": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "parallel": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "precision": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([PropTypes.number, PropTypes.string])), PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "ratio": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "rotate": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "spacing": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "tilt": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_VGProjectionType, PropTypes.oneOf([null])]),
});
_VGScheme = PropTypes.shape({
    "count": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "extent": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "scheme": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "step": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_ScaleConfig = PropTypes.shape({
    "bandPaddingInner": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "bandPaddingOuter": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "clamp": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "continuousPadding": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "maxBandSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "maxFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "maxOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "maxSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "maxStrokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minBandSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minFontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minStrokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "pointPadding": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "rangeStep": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "round": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "textXRangeStep": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "useUnaggregatedDomain": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_BrushConfig = PropTypes.shape({
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fillOpacity": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_IntervalSelectionConfig = PropTypes.shape({
    "bind": PropTypes.oneOfType([_BindEnum, PropTypes.oneOf([null])]),
    "empty": PropTypes.oneOfType([_Empty, PropTypes.oneOf([null])]),
    "encodings": PropTypes.oneOfType([PropTypes.arrayOf(_SingleDefChannel), PropTypes.oneOf([null])]),
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "mark": PropTypes.oneOfType([_BrushConfig, PropTypes.oneOf([null])]),
    "on": PropTypes.any,
    "resolve": PropTypes.oneOfType([_SelectionResolution, PropTypes.oneOf([null])]),
    "translate": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
    "zoom": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
});
_MultiSelectionConfig = PropTypes.shape({
    "empty": PropTypes.oneOfType([_Empty, PropTypes.oneOf([null])]),
    "encodings": PropTypes.oneOfType([PropTypes.arrayOf(_SingleDefChannel), PropTypes.oneOf([null])]),
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "nearest": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "on": PropTypes.any,
    "resolve": PropTypes.oneOfType([_SelectionResolution, PropTypes.oneOf([null])]),
    "toggle": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
});
_VGBinding = PropTypes.shape({
    "element": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "input": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "options": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "max": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "min": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "step": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_SingleSelectionConfig = PropTypes.shape({
    "bind": PropTypes.oneOfType([PropTypes.objectOf(_VGBinding), PropTypes.oneOf([null])]),
    "empty": PropTypes.oneOfType([_Empty, PropTypes.oneOf([null])]),
    "encodings": PropTypes.oneOfType([PropTypes.arrayOf(_SingleDefChannel), PropTypes.oneOf([null])]),
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "nearest": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "on": PropTypes.any,
    "resolve": PropTypes.oneOfType([_SelectionResolution, PropTypes.oneOf([null])]),
});
_SelectionConfig = PropTypes.shape({
    "interval": PropTypes.oneOfType([_IntervalSelectionConfig, PropTypes.oneOf([null])]),
    "multi": PropTypes.oneOfType([_MultiSelectionConfig, PropTypes.oneOf([null])]),
    "single": PropTypes.oneOfType([_SingleSelectionConfig, PropTypes.oneOf([null])]),
});
_VGMarkConfig = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_TextConfig = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "filled": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "shortTimeLabels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_TickConfig = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "bandSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "filled": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "thickness": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
});
_VGTitleConfig = PropTypes.shape({
    "anchor": PropTypes.oneOfType([_Anchor, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "offset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_TitleOrient, PropTypes.oneOf([null])]),
});
_ViewConfig = PropTypes.shape({
    "clip": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fillOpacity": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "height": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_Config = PropTypes.shape({
    "area": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "autosize": PropTypes.oneOfType([_AutoSizeParams, _AutosizeType, PropTypes.oneOf([null])]),
    "axis": PropTypes.oneOfType([_AxisConfig, PropTypes.oneOf([null])]),
    "axisBand": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisBottom": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisLeft": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisRight": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisTop": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisX": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "axisY": PropTypes.oneOfType([_VGAxisConfig, PropTypes.oneOf([null])]),
    "background": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "bar": PropTypes.oneOfType([_BarConfig, PropTypes.oneOf([null])]),
    "circle": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "countTitle": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fieldTitle": PropTypes.oneOfType([_FieldTitle, PropTypes.oneOf([null])]),
    "geoshape": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "invalidValues": PropTypes.oneOfType([_InvalidValues, PropTypes.oneOf([null])]),
    "legend": PropTypes.oneOfType([_LegendConfig, PropTypes.oneOf([null])]),
    "line": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "mark": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "numberFormat": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "padding": PropTypes.oneOfType([_PaddingClass, PropTypes.number, PropTypes.oneOf([null])]),
    "point": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "projection": PropTypes.oneOfType([_ProjectionConfig, PropTypes.oneOf([null])]),
    "range": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.number, PropTypes.string])), _VGScheme])), PropTypes.oneOf([null])]),
    "rect": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "rule": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "scale": PropTypes.oneOfType([_ScaleConfig, PropTypes.oneOf([null])]),
    "selection": PropTypes.oneOfType([_SelectionConfig, PropTypes.oneOf([null])]),
    "square": PropTypes.oneOfType([_MarkConfig, PropTypes.oneOf([null])]),
    "stack": PropTypes.oneOfType([_StackOffset, PropTypes.oneOf([null])]),
    "style": PropTypes.oneOfType([PropTypes.objectOf(_VGMarkConfig), PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([_TextConfig, PropTypes.oneOf([null])]),
    "tick": PropTypes.oneOfType([_TickConfig, PropTypes.oneOf([null])]),
    "timeFormat": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "title": PropTypes.oneOfType([_VGTitleConfig, PropTypes.oneOf([null])]),
    "view": PropTypes.oneOfType([_ViewConfig, PropTypes.oneOf([null])]),
});
_DataFormat = PropTypes.shape({
    "parse": PropTypes.oneOfType([_ParseEnum, PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_DataFormatType, PropTypes.oneOf([null])]),
    "property": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "feature": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "mesh": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_Data = PropTypes.shape({
    "format": PropTypes.oneOfType([_DataFormat, PropTypes.oneOf([null])]),
    "url": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "values": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.objectOf(PropTypes.any), PropTypes.string])), PropTypes.objectOf(PropTypes.any), PropTypes.oneOf([null]), PropTypes.string]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_BinParams = PropTypes.shape({
    "base": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "divide": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 1 || false)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.number)(props, name, ...args); }, PropTypes.oneOf([null])]),
    "extent": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 2 || value.length > 2)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.number)(props, name, ...args); }, PropTypes.oneOf([null])]),
    "maxbins": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 2) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minstep": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "nice": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "step": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "steps": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 1 || false)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.number)(props, name, ...args); }, PropTypes.oneOf([null])]),
});
_ConditionalValueDef = PropTypes.shape({
    "test": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.string])]).isRequired,
    "selection": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
});
_Selection = PropTypes.shape({
    "not": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "and": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.string])), PropTypes.oneOf([null])]),
    "or": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.string])), PropTypes.oneOf([null])]),
});
_DateTime = PropTypes.shape({
    "date": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 1 && value <= 31) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "day": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 1 && value <= 7) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null]), PropTypes.string]),
    "hours": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 23) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "milliseconds": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 999) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "minutes": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 59) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "month": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 1 && value <= 12) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null]), PropTypes.string]),
    "quarter": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 1 && value <= 4) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "seconds": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 59) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "utc": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "year": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
});
_Predicate = PropTypes.shape({
    "not": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "and": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.string])), PropTypes.oneOf([null])]),
    "or": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.string])), PropTypes.oneOf([null])]),
    "equal": PropTypes.oneOfType([PropTypes.bool, _DateTime, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "field": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "range": PropTypes.oneOfType([(props, name, ...args) => { const value = props[name]; if (value != null && (value.length < 2 || value.length > 2)) return new Error("Expected bounded array"); return PropTypes.arrayOf(PropTypes.oneOfType([_DateTime, PropTypes.number, PropTypes.oneOf([null])]))(props, name, ...args); }, PropTypes.oneOf([null])]),
    "oneOf": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.bool, _DateTime, PropTypes.number, PropTypes.string])), PropTypes.oneOf([null])]),
    "selection": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
});
_RepeatRef = PropTypes.shape({
    "repeat": _RepeatEnum,
});
_Legend = PropTypes.shape({
    "entryPadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "format": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "offset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_LegendOrient, PropTypes.oneOf([null])]),
    "padding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "tickCount": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": PropTypes.oneOfType([_LegendType, PropTypes.oneOf([null])]),
    "values": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([_DateTime, PropTypes.number, PropTypes.string])), PropTypes.oneOf([null])]),
    "zindex": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
});
_DomainClass = PropTypes.shape({
    "field": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "selection": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "encoding": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_InterpolateParams = PropTypes.shape({
    "gamma": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "type": _InterpolateParamsType,
});
_NiceClass = PropTypes.shape({
    "interval": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "step": PropTypes.oneOfType([PropTypes.number]).isRequired,
});
_SchemeParams = PropTypes.shape({
    "extent": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Scale = PropTypes.shape({
    "base": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "clamp": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "domain": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.bool, _DateTime, PropTypes.number, PropTypes.string])), _DomainClass, _Domain, PropTypes.oneOf([null])]),
    "exponent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "interpolate": PropTypes.oneOfType([_InterpolateParams, _Interpolate, PropTypes.oneOf([null])]),
    "nice": PropTypes.oneOfType([PropTypes.bool, _NiceClass, PropTypes.number, _NiceTime, PropTypes.oneOf([null])]),
    "padding": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "paddingInner": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "paddingOuter": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "range": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([PropTypes.number, PropTypes.string])), PropTypes.oneOf([null]), PropTypes.string]),
    "rangeStep": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "round": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "scheme": PropTypes.oneOfType([_SchemeParams, PropTypes.oneOf([null]), PropTypes.string]),
    "type": PropTypes.oneOfType([_ScaleType, PropTypes.oneOf([null])]),
    "zero": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
});
_SortField = PropTypes.shape({
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "op": _AggregateOp,
    "order": PropTypes.oneOfType([_SortEnum, PropTypes.oneOf([null])]),
});
_ConditionalPredicateMarkPropFieldDefClass = PropTypes.shape({
    "test": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "selection": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "legend": PropTypes.oneOfType([_Legend, PropTypes.oneOf([null])]),
    "scale": PropTypes.oneOfType([_Scale, PropTypes.oneOf([null])]),
    "sort": PropTypes.oneOfType([_SortField, _SortEnum, PropTypes.oneOf([null])]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
});
_MarkPropDefWithCondition = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "condition": PropTypes.oneOfType([PropTypes.arrayOf(_ConditionalValueDef), _ConditionalPredicateMarkPropFieldDefClass, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "legend": PropTypes.oneOfType([_Legend, PropTypes.oneOf([null])]),
    "scale": PropTypes.oneOfType([_Scale, PropTypes.oneOf([null])]),
    "sort": PropTypes.oneOfType([_SortField, _SortEnum, PropTypes.oneOf([null])]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
});
_Header = PropTypes.shape({
    "format": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "labelAngle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= -360 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
});
_FacetFieldDef = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "header": PropTypes.oneOfType([_Header, PropTypes.oneOf([null])]),
    "sort": PropTypes.oneOfType([_SortEnum, PropTypes.oneOf([null])]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": _Type,
});
_FieldDef = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": _Type,
});
_ConditionalPredicateFieldDefClass = PropTypes.shape({
    "test": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "selection": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
});
_DefWithCondition = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "condition": PropTypes.oneOfType([PropTypes.arrayOf(_ConditionalValueDef), _ConditionalPredicateFieldDefClass, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
});
_OrderFieldDef = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "sort": PropTypes.oneOfType([_SortEnum, PropTypes.oneOf([null])]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": _Type,
});
_ConditionalPredicateTextFieldDefClass = PropTypes.shape({
    "test": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
    "selection": PropTypes.oneOfType([(...args) => _Selection(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "format": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
});
_TextDefWithCondition = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "condition": PropTypes.oneOfType([PropTypes.arrayOf(_ConditionalValueDef), _ConditionalPredicateTextFieldDefClass, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "format": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
});
_Axis = PropTypes.shape({
    "domain": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "format": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "grid": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "labelAngle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= -360 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "labelBound": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelFlush": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null])]),
    "labelOverlap": PropTypes.oneOfType([PropTypes.bool, _LabelOverlapEnum, PropTypes.oneOf([null])]),
    "labelPadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "labels": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "maxExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "minExtent": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "offset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_TitleOrient, PropTypes.oneOf([null])]),
    "position": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "tickCount": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "ticks": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "tickSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "titleMaxLength": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "titlePadding": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "values": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.oneOfType([_DateTime, PropTypes.number])), PropTypes.oneOf([null])]),
    "zindex": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
});
_XClass = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "axis": PropTypes.oneOfType([_Axis, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "scale": PropTypes.oneOfType([_Scale, PropTypes.oneOf([null])]),
    "sort": PropTypes.oneOfType([_SortField, _SortEnum, PropTypes.oneOf([null])]),
    "stack": PropTypes.oneOfType([_StackOffset, PropTypes.oneOf([null])]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
});
_X2Class = PropTypes.shape({
    "aggregate": PropTypes.oneOfType([_AggregateOp, PropTypes.oneOf([null])]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([_RepeatRef, PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_Type, PropTypes.oneOf([null])]),
    "value": PropTypes.oneOfType([PropTypes.bool, PropTypes.number, PropTypes.oneOf([null]), PropTypes.string]),
});
_EncodingWithFacet = PropTypes.shape({
    "color": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "column": PropTypes.oneOfType([_FacetFieldDef, PropTypes.oneOf([null])]),
    "detail": PropTypes.oneOfType([PropTypes.arrayOf(_FieldDef), _FieldDef, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([_DefWithCondition, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "order": PropTypes.oneOfType([PropTypes.arrayOf(_OrderFieldDef), _OrderFieldDef, PropTypes.oneOf([null])]),
    "row": PropTypes.oneOfType([_FacetFieldDef, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "size": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([_TextDefWithCondition, PropTypes.oneOf([null])]),
    "tooltip": PropTypes.oneOfType([_TextDefWithCondition, PropTypes.oneOf([null])]),
    "x": PropTypes.oneOfType([_XClass, PropTypes.oneOf([null])]),
    "x2": PropTypes.oneOfType([_X2Class, PropTypes.oneOf([null])]),
    "y": PropTypes.oneOfType([_XClass, PropTypes.oneOf([null])]),
    "y2": PropTypes.oneOfType([_X2Class, PropTypes.oneOf([null])]),
});
_FacetMapping = PropTypes.shape({
    "column": PropTypes.oneOfType([_FacetFieldDef, PropTypes.oneOf([null])]),
    "row": PropTypes.oneOfType([_FacetFieldDef, PropTypes.oneOf([null])]),
});
_Encoding = PropTypes.shape({
    "color": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "detail": PropTypes.oneOfType([PropTypes.arrayOf(_FieldDef), _FieldDef, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([_DefWithCondition, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "order": PropTypes.oneOfType([PropTypes.arrayOf(_OrderFieldDef), _OrderFieldDef, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "size": PropTypes.oneOfType([_MarkPropDefWithCondition, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([_TextDefWithCondition, PropTypes.oneOf([null])]),
    "tooltip": PropTypes.oneOfType([_TextDefWithCondition, PropTypes.oneOf([null])]),
    "x": PropTypes.oneOfType([_XClass, PropTypes.oneOf([null])]),
    "x2": PropTypes.oneOfType([_X2Class, PropTypes.oneOf([null])]),
    "y": PropTypes.oneOfType([_XClass, PropTypes.oneOf([null])]),
    "y2": PropTypes.oneOfType([_X2Class, PropTypes.oneOf([null])]),
});
_MarkDef = PropTypes.shape({
    "align": PropTypes.oneOfType([_HorizontalAlign, PropTypes.oneOf([null])]),
    "angle": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 360) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "baseline": PropTypes.oneOfType([_VerticalAlign, PropTypes.oneOf([null])]),
    "clip": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "color": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "cursor": PropTypes.oneOfType([_Cursor, PropTypes.oneOf([null])]),
    "dx": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "dy": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fill": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "filled": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "fillOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "font": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "fontSize": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "fontStyle": PropTypes.oneOfType([_FontStyle, PropTypes.oneOf([null])]),
    "fontWeight": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 100 && value <= 900) ? null : new Error("Expected bounded number"); }, _FontWeight, PropTypes.oneOf([null])]),
    "href": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "interpolate": PropTypes.oneOfType([_Interpolate, PropTypes.oneOf([null])]),
    "limit": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_Orient, PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "stroke": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "strokeDash": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "strokeDashOffset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "strokeOpacity": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "strokeWidth": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "style": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null]), PropTypes.string]),
    "tension": PropTypes.oneOfType([(props, name) => { const value = props[name]; return value == null || (typeof value === 'number' && value >= 0 && value <= 1) ? null : new Error("Expected bounded number"); }, PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "theta": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "type": _Mark,
});
_Projection = PropTypes.shape({
    "center": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "clipAngle": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "clipExtent": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.number)), PropTypes.oneOf([null])]),
    "coefficient": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "distance": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "fraction": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "lobes": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "parallel": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "precision": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.oneOfType([PropTypes.number, PropTypes.string])), PropTypes.oneOf([null])]),
    "radius": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "ratio": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "rotate": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.number), PropTypes.oneOf([null])]),
    "spacing": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "tilt": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "type": PropTypes.oneOfType([_VGProjectionType, PropTypes.oneOf([null])]),
});
_AxisResolveMap = PropTypes.shape({
    "x": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "y": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
});
_LegendResolveMap = PropTypes.shape({
    "color": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "size": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
});
_ScaleResolveMap = PropTypes.shape({
    "color": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "opacity": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "shape": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "size": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "x": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
    "y": PropTypes.oneOfType([_ResolveMode, PropTypes.oneOf([null])]),
});
_Resolve = PropTypes.shape({
    "axis": PropTypes.oneOfType([_AxisResolveMap, PropTypes.oneOf([null])]),
    "legend": PropTypes.oneOfType([_LegendResolveMap, PropTypes.oneOf([null])]),
    "scale": PropTypes.oneOfType([_ScaleResolveMap, PropTypes.oneOf([null])]),
});
_SelectionDef = PropTypes.shape({
    "bind": PropTypes.oneOfType([_BindEnum, PropTypes.objectOf(_VGBinding), PropTypes.oneOf([null])]),
    "empty": PropTypes.oneOfType([_Empty, PropTypes.oneOf([null])]),
    "encodings": PropTypes.oneOfType([PropTypes.arrayOf(_SingleDefChannel), PropTypes.oneOf([null])]),
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "nearest": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "on": PropTypes.any,
    "resolve": PropTypes.oneOfType([_SelectionResolution, PropTypes.oneOf([null])]),
    "type": _SelectionDefType,
    "toggle": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
    "mark": PropTypes.oneOfType([_BrushConfig, PropTypes.oneOf([null])]),
    "translate": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
    "zoom": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null]), PropTypes.string]),
});
_TitleParams = PropTypes.shape({
    "anchor": PropTypes.oneOfType([_Anchor, PropTypes.oneOf([null])]),
    "offset": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "orient": PropTypes.oneOfType([_TitleOrient, PropTypes.oneOf([null])]),
    "style": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null]), PropTypes.string]),
    "text": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_AggregatedFieldDef = PropTypes.shape({
    "as": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "field": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "op": _AggregateOp,
});
_LookupData = PropTypes.shape({
    "data": _Data,
    "fields": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "key": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Transform = PropTypes.shape({
    "filter": PropTypes.oneOfType([(...args) => _Predicate(...args), PropTypes.oneOf([null]), PropTypes.string]),
    "as": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null]), PropTypes.string]),
    "calculate": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "default": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "from": PropTypes.oneOfType([_LookupData, PropTypes.oneOf([null])]),
    "lookup": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "bin": PropTypes.oneOfType([PropTypes.bool, _BinParams, PropTypes.oneOf([null])]),
    "field": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "timeUnit": PropTypes.oneOfType([_TimeUnit, PropTypes.oneOf([null])]),
    "aggregate": PropTypes.oneOfType([PropTypes.arrayOf(_AggregatedFieldDef), PropTypes.oneOf([null])]),
    "groupby": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
});
_LayerSpec = PropTypes.shape({
    "data": PropTypes.oneOfType([_Data, PropTypes.oneOf([null])]),
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "height": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "layer": PropTypes.oneOfType([PropTypes.arrayOf(_LayerSpec), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "resolve": PropTypes.oneOfType([_Resolve, PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([_TitleParams, PropTypes.oneOf([null]), PropTypes.string]),
    "transform": PropTypes.oneOfType([PropTypes.arrayOf(_Transform), PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "encoding": PropTypes.oneOfType([_Encoding, PropTypes.oneOf([null])]),
    "mark": PropTypes.oneOfType([_MarkDef, _Mark, PropTypes.oneOf([null])]),
    "projection": PropTypes.oneOfType([_Projection, PropTypes.oneOf([null])]),
    "selection": PropTypes.oneOfType([PropTypes.objectOf(_SelectionDef), PropTypes.oneOf([null])]),
});
_Repeat = PropTypes.shape({
    "column": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "row": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
});
_TopLevel = PropTypes.shape({
    "$schema": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "autosize": PropTypes.oneOfType([_AutoSizeParams, _AutosizeType, PropTypes.oneOf([null])]),
    "background": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "config": PropTypes.oneOfType([_Config, PropTypes.oneOf([null])]),
    "data": PropTypes.oneOfType([_Data, PropTypes.oneOf([null])]),
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "encoding": PropTypes.oneOfType([_EncodingWithFacet, PropTypes.oneOf([null])]),
    "height": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "mark": PropTypes.oneOfType([_MarkDef, _Mark, PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "padding": PropTypes.oneOfType([_PaddingClass, PropTypes.number, PropTypes.oneOf([null])]),
    "projection": PropTypes.oneOfType([_Projection, PropTypes.oneOf([null])]),
    "selection": PropTypes.oneOfType([PropTypes.objectOf(_SelectionDef), PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([_TitleParams, PropTypes.oneOf([null]), PropTypes.string]),
    "transform": PropTypes.oneOfType([PropTypes.arrayOf(_Transform), PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "layer": PropTypes.oneOfType([PropTypes.arrayOf(_LayerSpec), PropTypes.oneOf([null])]),
    "resolve": PropTypes.oneOfType([_Resolve, PropTypes.oneOf([null])]),
    "facet": PropTypes.oneOfType([_FacetMapping, PropTypes.oneOf([null])]),
    "spec": PropTypes.oneOfType([(...args) => _Spec(...args), PropTypes.oneOf([null])]),
    "repeat": PropTypes.oneOfType([_Repeat, PropTypes.oneOf([null])]),
    "vconcat": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _Spec(...args)), PropTypes.oneOf([null])]),
    "hconcat": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _Spec(...args)), PropTypes.oneOf([null])]),
});
_Spec = PropTypes.shape({
    "data": PropTypes.oneOfType([_Data, PropTypes.oneOf([null])]),
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "height": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "layer": PropTypes.oneOfType([PropTypes.arrayOf(_LayerSpec), PropTypes.oneOf([null])]),
    "name": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "resolve": PropTypes.oneOfType([_Resolve, PropTypes.oneOf([null])]),
    "title": PropTypes.oneOfType([_TitleParams, PropTypes.oneOf([null]), PropTypes.string]),
    "transform": PropTypes.oneOfType([PropTypes.arrayOf(_Transform), PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    "encoding": PropTypes.oneOfType([_Encoding, PropTypes.oneOf([null])]),
    "mark": PropTypes.oneOfType([_MarkDef, _Mark, PropTypes.oneOf([null])]),
    "projection": PropTypes.oneOfType([_Projection, PropTypes.oneOf([null])]),
    "selection": PropTypes.oneOfType([PropTypes.objectOf(_SelectionDef), PropTypes.oneOf([null])]),
    "facet": PropTypes.oneOfType([_FacetMapping, PropTypes.oneOf([null])]),
    "spec": PropTypes.oneOfType([(...args) => _Spec(...args), PropTypes.oneOf([null])]),
    "repeat": PropTypes.oneOfType([_Repeat, PropTypes.oneOf([null])]),
    "vconcat": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _Spec(...args)), PropTypes.oneOf([null])]),
    "hconcat": PropTypes.oneOfType([PropTypes.arrayOf((...args) => _Spec(...args)), PropTypes.oneOf([null])]),
});

export const TopLevel = _TopLevel;
