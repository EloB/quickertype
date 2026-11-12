{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , AutoSizeParams (..)
    , Config (..)
    , MarkConfig (..)
    , AxisConfig (..)
    , VGAxisConfig (..)
    , BarConfig (..)
    , TextConfig (..)
    , LegendConfig (..)
    , PaddingClass (..)
    , ProjectionConfig (..)
    , VGScheme (..)
    , ScaleConfig (..)
    , SelectionConfig (..)
    , IntervalSelectionConfig (..)
    , BrushConfig (..)
    , MultiSelectionConfig (..)
    , SingleSelectionConfig (..)
    , VGBinding (..)
    , VGMarkConfig (..)
    , TickConfig (..)
    , VGTitleConfig (..)
    , ViewConfig (..)
    , EncodingWithFacet (..)
    , MarkPropDefWithCondition (..)
    , BinParams (..)
    , ConditionalValueDef (..)
    , Selection (..)
    , Predicate (..)
    , DateTime (..)
    , ConditionalPredicateMarkPropFieldDefClass (..)
    , RepeatRef (..)
    , Legend (..)
    , Scale (..)
    , DomainClass (..)
    , InterpolateParams (..)
    , NiceClass (..)
    , SchemeParams (..)
    , SortField (..)
    , FacetFieldDef (..)
    , Header (..)
    , FieldDef (..)
    , TextDefWithCondition (..)
    , ConditionalPredicateTextFieldDefClass (..)
    , DefWithCondition (..)
    , ConditionalPredicateFieldDefClass (..)
    , OrderFieldDef (..)
    , XClass (..)
    , Axis (..)
    , X2Class (..)
    , FacetMapping (..)
    , Spec (..)
    , Encoding (..)
    , LayerSpec (..)
    , Data (..)
    , DataFormat (..)
    , MarkDef (..)
    , Projection (..)
    , Resolve (..)
    , AxisResolveMap (..)
    , LegendResolveMap (..)
    , ScaleResolveMap (..)
    , SelectionDef (..)
    , TitleParams (..)
    , Transform (..)
    , AggregatedFieldDef (..)
    , LookupData (..)
    , Repeat (..)
    , AutosizeType (..)
    , Contains (..)
    , HorizontalAlign (..)
    , VerticalAlign (..)
    , Cursor (..)
    , FontStyle (..)
    , FontWeight (..)
    , Interpolate (..)
    , Orient (..)
    , LabelOverlapEnum (..)
    , FieldTitle (..)
    , InvalidValues (..)
    , LegendOrient (..)
    , VGProjectionType (..)
    , BindEnum (..)
    , Empty (..)
    , SingleDefChannel (..)
    , SelectionResolution (..)
    , StackOffset (..)
    , Anchor (..)
    , TitleOrient (..)
    , AggregateOp (..)
    , TimeUnit (..)
    , Type (..)
    , RepeatEnum (..)
    , LegendType (..)
    , Domain (..)
    , InterpolateParamsType (..)
    , NiceTime (..)
    , ScaleType (..)
    , SortEnum (..)
    , DataFormatType (..)
    , ParseEnum (..)
    , Mark (..)
    , ResolveMode (..)
    , SelectionDefType (..)
    , Autosize (..)
    , FontWeightUnion (..)
    , Label (..)
    , LabelOverlapUnion (..)
    , TitleFontWeight (..)
    , Padding (..)
    , RangeConfigValue (..)
    , Translate (..)
    , Bin (..)
    , ColorCondition (..)
    , SelectionOperand (..)
    , LogicalOperandPredicate (..)
    , Equal (..)
    , Day (..)
    , Month (..)
    , RangeElement (..)
    , ConditionalValueDefValue (..)
    , Field (..)
    , LegendValue (..)
    , DomainUnion (..)
    , InterpolateUnion (..)
    , NiceUnion (..)
    , ScaleRange (..)
    , Scheme (..)
    , SortUnion (..)
    , Detail (..)
    , TextCondition (..)
    , HrefCondition (..)
    , Order (..)
    , AxisValue (..)
    , ParseUnion (..)
    , Values (..)
    , ValuesValue (..)
    , AnyMark (..)
    , Style (..)
    , BindUnion (..)
    , Title (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

{-| schema:
URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
Setting the `$schema` property allows automatic validation and autocomplete in editors
that support JSON schema.

autosize:
Sets how the visualization size should be determined. If a string, should be one of
`"pad"`, `"fit"` or `"none"`.
Object values can additionally specify parameters for content sizing and automatic
resizing.
`"fit"` is only supported for single and layered views that don't use `rangeStep`.

__Default value__: `pad`

background:
CSS color property to use as the background of visualization.

__Default value:__ none (transparent)

config:
Vega-Lite configuration object.  This property can only be defined at the top-level of a
specification.

quickTypeData:
An object describing the data source

description:
Description of this mark for commenting purpose.

encoding:
A key-value mapping between encoding channels and definition of fields.

height:
The height of a visualization.

__Default value:__
- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
[continuous scale](scale.html#continuous), the height will be the value of
[`config.view.height`](spec.html#config).
- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the height is [determined by the range step, paddings, and the
cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
`rangeStep` is `null`, the height will be the value of
[`config.view.height`](spec.html#config).
- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.

__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
represents the height of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

mark:
A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
`"line"`,
* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
object](mark.html#mark-def).

name:
Name of the visualization for later reference.

padding:
The default visualization padding, in pixels, from the edge of the visualization canvas
to the data rectangle.  If a number, specifies padding for all sides.
If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
"bottom": 5}` to specify padding for each side of the visualization.

__Default value__: `5`

projection:
An object defining properties of geographic projection.

Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.

selection:
A key-value mapping between selection names and definitions.

title:
Title for the plot.

transform:
An array of data transformations such as filter and new field calculation.

width:
The width of a visualization.

__Default value:__ This will be determined by the following rules:

- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
[continuous scale](scale.html#continuous), the width will be the value of
[`config.view.width`](spec.html#config).
- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the width is [determined by the range step, paddings, and the
cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
`rangeStep` is `null`, the width will be the value of
[`config.view.width`](spec.html#config).
- If no field is mapped to `x` channel, the `width` will be the value of
[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
the value of `rangeStep` for other marks.

__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
represents the width of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

layer:
Layer or single view specifications to be layered.

__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
layering facet specifications is not allowed.

resolve:
Scale, axis, and legend resolutions for layers.

Scale, axis, and legend resolutions for facets.

Scale and legend resolutions for repeated charts.

Scale, axis, and legend resolutions for vertically concatenated charts.

Scale, axis, and legend resolutions for horizontally concatenated charts.

facet:
An object that describes mappings between `row` and `column` channels and their field
definitions.

spec:
A specification of the view that gets faceted.

repeat:
An object that describes what fields should be repeated into views that are laid out as a
`row` or `column`.

vconcat:
A list of views that should be concatenated and put into a column.

hconcat:
A list of views that should be concatenated and put into a row.
-}
data QuickType = QuickType
    { schemaQuickType :: Maybe Text
    , autosizeQuickType :: Maybe Autosize
    , backgroundQuickType :: Maybe Text
    , configQuickType :: Maybe Config
    , quickTypeDataQuickType :: Maybe Data
    , descriptionQuickType :: Maybe Text
    , encodingQuickType :: Maybe EncodingWithFacet
    , heightQuickType :: Maybe Double
    , markQuickType :: Maybe AnyMark
    , nameQuickType :: Maybe Text
    , paddingQuickType :: Maybe Padding
    , projectionQuickType :: Maybe Projection
    , selectionQuickType :: Maybe (HashMap Text SelectionDef)
    , titleQuickType :: Maybe Title
    , transformQuickType :: Maybe ([Transform])
    , widthQuickType :: Maybe Double
    , layerQuickType :: Maybe ([LayerSpec])
    , resolveQuickType :: Maybe Resolve
    , facetQuickType :: Maybe FacetMapping
    , specQuickType :: Maybe Spec
    , repeatQuickType :: Maybe Repeat
    , vconcatQuickType :: Maybe ([Spec])
    , hconcatQuickType :: Maybe ([Spec])
    } deriving (Show)

{-| Sets how the visualization size should be determined. If a string, should be one of
`"pad"`, `"fit"` or `"none"`.
Object values can additionally specify parameters for content sizing and automatic
resizing.
`"fit"` is only supported for single and layered views that don't use `rangeStep`.

__Default value__: `pad`
-}
data Autosize
    = AutoSizeParamsInAutosize AutoSizeParams
    | EnumInAutosize AutosizeType
    deriving (Show)

{-| contains:
Determines how size calculation should be performed, one of `"content"` or `"padding"`.
The default setting (`"content"`) interprets the width and height settings as the data
rectangle (plotting) dimensions, to which padding is then added. In contrast, the
`"padding"` setting includes the padding within the view size calculations, such that the
width and height settings indicate the **total** intended size of the view.

__Default value__: `"content"`

resize:
A boolean flag indicating if autosize layout should be re-calculated on every view
update.

__Default value__: `false`

autoSizeParamsType:
The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
descriptions of each.

__Default value__: `"pad"`
-}
data AutoSizeParams = AutoSizeParams
    { containsAutoSizeParams :: Maybe Contains
    , resizeAutoSizeParams :: Maybe Bool
    , autoSizeParamsTypeAutoSizeParams :: Maybe AutosizeType
    } deriving (Show)

{-| The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
descriptions of each.

__Default value__: `"pad"`
-}
data AutosizeType
    = PadAutosizeType
    | FitAutosizeType
    | NoneAutosizeType
    deriving (Show)

{-| Determines how size calculation should be performed, one of `"content"` or `"padding"`.
The default setting (`"content"`) interprets the width and height settings as the data
rectangle (plotting) dimensions, to which padding is then added. In contrast, the
`"padding"` setting includes the padding within the view size calculations, such that the
width and height settings indicate the **total** intended size of the view.

__Default value__: `"content"`
-}
data Contains
    = ContentContains
    | PaddingContains
    deriving (Show)

{-| Vega-Lite configuration object.  This property can only be defined at the top-level of a
specification.

area:
Area-Specific Config

autosize:
Sets how the visualization size should be determined. If a string, should be one of
`"pad"`, `"fit"` or `"none"`.
Object values can additionally specify parameters for content sizing and automatic
resizing.
`"fit"` is only supported for single and layered views that don't use `rangeStep`.

__Default value__: `pad`

axis:
Axis configuration, which determines default properties for all `x` and `y`
[axes](axis.html). For a full list of axis configuration options, please see the
[corresponding section of the axis documentation](axis.html#config).

axisBand:
Specific axis config for axes with "band" scales.

axisBottom:
Specific axis config for x-axis along the bottom edge of the chart.

axisLeft:
Specific axis config for y-axis along the left edge of the chart.

axisRight:
Specific axis config for y-axis along the right edge of the chart.

axisTop:
Specific axis config for x-axis along the top edge of the chart.

axisX:
X-axis specific config.

axisY:
Y-axis specific config.

background:
CSS color property to use as the background of visualization.

__Default value:__ none (transparent)

bar:
Bar-Specific Config

circle:
Circle-Specific Config

countTitle:
Default axis and legend title for count fields.

__Default value:__ `'Number of Records'`.

fieldTitle:
Defines how Vega-Lite generates title for fields.  There are three possible styles:

- `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
"Year-month of date", "field (binned)").
- `"function"` - displays function using parentheses and capitalized texts (e.g.,
"SUM(field)", "YEARMONTH(date)", "BIN(field)").
- `"plain"` - displays only the field name without functions (e.g., "field", "date",
"field").

geoshape:
Geoshape-Specific Config

invalidValues:
Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
- If set to `"filter"` (default), all data items with null values are filtered.
- If `null`, all data items are included. In this case, invalid values will be
interpreted as zeroes.

legend:
Legend configuration, which determines default properties for all [legends](legend.html).
For a full list of legend configuration options, please see the [corresponding section of
in the legend documentation](legend.html#config).

line:
Line-Specific Config

mark:
Mark Config

numberFormat:
D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
number format pattern](https://github.com/d3/d3-format#locale_format).

padding:
The default visualization padding, in pixels, from the edge of the visualization canvas
to the data rectangle.  If a number, specifies padding for all sides.
If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
"bottom": 5}` to specify padding for each side of the visualization.

__Default value__: `5`

point:
Point-Specific Config

projection:
Projection configuration, which determines default properties for all
[projections](projection.html). For a full list of projection configuration options,
please see the [corresponding section of the projection
documentation](projection.html#config).

range:
An object hash that defines default range arrays or schemes for using with scales.
For a full list of scale range configuration options, please see the [corresponding
section of the scale documentation](scale.html#config).

rect:
Rect-Specific Config

rule:
Rule-Specific Config

scale:
Scale configuration determines default properties for all [scales](scale.html). For a
full list of scale configuration options, please see the [corresponding section of the
scale documentation](scale.html#config).

selection:
An object hash for defining default properties for each type of selections.

square:
Square-Specific Config

stack:
Default stack offset for stackable mark.

style:
An object hash that defines key-value mappings to determine default properties for marks
with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
valid [mark configuration objects](mark.html#config).

configText:
Text-Specific Config

tick:
Tick-Specific Config

timeFormat:
Default datetime format for axis and legend labels. The format can be set directly on
each axis and legend. Use [D3's time format
pattern](https://github.com/d3/d3-time-format#locale_format).

__Default value:__ `'%b %d, %Y'`.

title:
Title configuration, which determines default properties for all [titles](title.html).
For a full list of title configuration options, please see the [corresponding section of
the title documentation](title.html#config).

view:
Default properties for [single view plots](spec.html#single).
-}
data Config = Config
    { areaConfig :: Maybe MarkConfig
    , autosizeConfig :: Maybe Autosize
    , axisConfig :: Maybe AxisConfig
    , axisBandConfig :: Maybe VGAxisConfig
    , axisBottomConfig :: Maybe VGAxisConfig
    , axisLeftConfig :: Maybe VGAxisConfig
    , axisRightConfig :: Maybe VGAxisConfig
    , axisTopConfig :: Maybe VGAxisConfig
    , axisXConfig :: Maybe VGAxisConfig
    , axisYConfig :: Maybe VGAxisConfig
    , backgroundConfig :: Maybe Text
    , barConfig :: Maybe BarConfig
    , circleConfig :: Maybe MarkConfig
    , countTitleConfig :: Maybe Text
    , fieldTitleConfig :: Maybe FieldTitle
    , geoshapeConfig :: Maybe MarkConfig
    , invalidValuesConfig :: Maybe InvalidValues
    , legendConfig :: Maybe LegendConfig
    , lineConfig :: Maybe MarkConfig
    , markConfig :: Maybe MarkConfig
    , numberFormatConfig :: Maybe Text
    , paddingConfig :: Maybe Padding
    , pointConfig :: Maybe MarkConfig
    , projectionConfig :: Maybe ProjectionConfig
    , rangeConfig :: Maybe (HashMap Text RangeConfigValue)
    , rectConfig :: Maybe MarkConfig
    , ruleConfig :: Maybe MarkConfig
    , scaleConfig :: Maybe ScaleConfig
    , selectionConfig :: Maybe SelectionConfig
    , squareConfig :: Maybe MarkConfig
    , stackConfig :: Maybe StackOffset
    , styleConfig :: Maybe (HashMap Text VGMarkConfig)
    , configTextConfig :: Maybe TextConfig
    , tickConfig :: Maybe TickConfig
    , timeFormatConfig :: Maybe Text
    , titleConfig :: Maybe VGTitleConfig
    , viewConfig :: Maybe ViewConfig
    } deriving (Show)

{-| Area-Specific Config

Circle-Specific Config

Geoshape-Specific Config

Line-Specific Config

Mark Config

Point-Specific Config

Rect-Specific Config

Rule-Specific Config

Square-Specific Config

align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

color:
Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
will override `color`.

__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

filled:
Whether the mark's color should be used as fill color instead of stroke color.

__Default value:__ `true` for all marks except `point` and `false` for `point`.

__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

markConfigText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".
-}
data MarkConfig = MarkConfig
    { alignMarkConfig :: Maybe HorizontalAlign
    , angleMarkConfig :: Maybe Double
    , baselineMarkConfig :: Maybe VerticalAlign
    , colorMarkConfig :: Maybe Text
    , cursorMarkConfig :: Maybe Cursor
    , dxMarkConfig :: Maybe Double
    , dyMarkConfig :: Maybe Double
    , fillMarkConfig :: Maybe Text
    , filledMarkConfig :: Maybe Bool
    , fillOpacityMarkConfig :: Maybe Double
    , fontMarkConfig :: Maybe Text
    , fontSizeMarkConfig :: Maybe Double
    , fontStyleMarkConfig :: Maybe FontStyle
    , fontWeightMarkConfig :: Maybe FontWeightUnion
    , hrefMarkConfig :: Maybe Text
    , interpolateMarkConfig :: Maybe Interpolate
    , limitMarkConfig :: Maybe Double
    , opacityMarkConfig :: Maybe Double
    , orientMarkConfig :: Maybe Orient
    , radiusMarkConfig :: Maybe Double
    , shapeMarkConfig :: Maybe Text
    , sizeMarkConfig :: Maybe Double
    , strokeMarkConfig :: Maybe Text
    , strokeDashMarkConfig :: Maybe ([Double])
    , strokeDashOffsetMarkConfig :: Maybe Double
    , strokeOpacityMarkConfig :: Maybe Double
    , strokeWidthMarkConfig :: Maybe Double
    , tensionMarkConfig :: Maybe Double
    , markConfigTextMarkConfig :: Maybe Text
    , thetaMarkConfig :: Maybe Double
    } deriving (Show)

{-| The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`. -}

data HorizontalAlign
    = LeftHorizontalAlign
    | RightHorizontalAlign
    | CenterHorizontalAlign
    deriving (Show)

{-| The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

Vertical text baseline for title text.
-}
data VerticalAlign
    = TopVerticalAlign
    | MiddleVerticalAlign
    | BottomVerticalAlign
    deriving (Show)

{-| The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
-}
data Cursor
    = AutoCursor
    | DefaultCursor
    | NoneCursor
    | ContextMenuCursor
    | HelpCursor
    | PointerCursor
    | ProgressCursor
    | WaitCursor
    | CellCursor
    | CrosshairCursor
    | TextCursor
    | VerticalTextCursor
    | AliasCursor
    | CopyCursor
    | MoveCursor
    | NoDropCursor
    | NotAllowedCursor
    | EResizeCursor
    | NResizeCursor
    | NeResizeCursor
    | NwResizeCursor
    | SResizeCursor
    | SEResizeCursor
    | SwResizeCursor
    | WResizeCursor
    | EwResizeCursor
    | NSResizeCursor
    | NeswResizeCursor
    | NwseResizeCursor
    | ColResizeCursor
    | RowResizeCursor
    | AllScrollCursor
    | ZoomInCursor
    | ZoomOutCursor
    | GrabCursor
    | GrabbingCursor
    deriving (Show)

{-| The font style (e.g., `"italic"`). -}

data FontStyle
    = NormalFontStyle
    | ItalicFontStyle
    deriving (Show)

{-| The font weight (e.g., `"bold"`).

Font weight for title text.
-}
data FontWeightUnion
    = DoubleInFontWeightUnion Double
    | EnumInFontWeightUnion FontWeight
    deriving (Show)

data FontWeight
    = NormalFontWeight
    | BoldFontWeight
    deriving (Show)

{-| The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.
-}
data Interpolate
    = LinearInterpolate
    | LinearClosedInterpolate
    | StepInterpolate
    | StepBeforeInterpolate
    | StepAfterInterpolate
    | BasisInterpolate
    | BasisOpenInterpolate
    | BasisClosedInterpolate
    | CardinalInterpolate
    | CardinalOpenInterpolate
    | CardinalClosedInterpolate
    | BundleInterpolate
    | MonotoneInterpolate
    deriving (Show)

{-| The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.
-}
data Orient
    = HorizontalOrient
    | VerticalOrient
    deriving (Show)

{-| Axis configuration, which determines default properties for all `x` and `y`
[axes](axis.html). For a full list of axis configuration options, please see the
[corresponding section of the axis documentation](axis.html#config).

bandPosition:
An interpolation fraction indicating where, for `band` scales, axis ticks should be
positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
places ticks in the middle of their bands.

domain:
A boolean flag indicating if the domain (the axis baseline) should be included as part of
the axis.

__Default value:__ `true`

domainColor:
Color of axis domain line.

__Default value:__  (none, using Vega default).

domainWidth:
Stroke width of axis domain line

__Default value:__  (none, using Vega default).

grid:
A boolean flag indicating if grid lines should be included as part of the axis

__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
binned; otherwise, `false`.

gridColor:
Color of gridlines.

gridDash:
The offset (in pixels) into which to begin drawing with the grid dash array.

gridOpacity:
The stroke opacity of grid (value between [0,1])

__Default value:__ (`1` by default)

gridWidth:
The grid width, in pixels.

labelAngle:
The rotation angle of the axis labels.

__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.

labelBound:
Indicates if labels should be hidden if they exceed the axis range. If `false `(the
default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
they exceed the axis range by more than 1 pixel. If this property is a number, it
specifies the pixel tolerance: the maximum amount by which a label bounding box may
exceed the axis range.

__Default value:__ `false`.

labelColor:
The color of the tick label, can be in hex color code or regular color name.

labelFlush:
Indicates if the first and last axis labels should be aligned flush with the scale range.
Flush alignment for a horizontal axis will left-align the first label and right-align the
last label. For vertical axes, bottom and top text baselines are applied instead. If this
property is a number, it also indicates the number of pixels by which to offset the first
and last labels; for example, a value of 2 will flush-align the first and last labels and
also push them 2 pixels outward from the center of the axis. The additional adjustment
can sometimes help the labels better visually group with corresponding axis ticks.

__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.

labelFont:
The font of the tick label.

labelFontSize:
The font size of the label, in pixels.

labelLimit:
Maximum allowed pixel width of axis tick labels.

labelOverlap:
The strategy to use for resolving overlap of axis labels. If `false` (the default), no
overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
every other label is used (this works well for standard linear axes). If set to
`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
with the last visible label (this often works better for log-scaled axes).

__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
scales; otherwise `false`.

labelPadding:
The padding, in pixels, between axis and text labels.

labels:
A boolean flag indicating if labels should be included as part of the axis.

__Default value:__  `true`.

maxExtent:
The maximum extent in pixels that axis ticks and labels should use. This determines a
maximum offset value for axis titles.

__Default value:__ `undefined`.

minExtent:
The minimum extent in pixels that axis ticks and labels should use. This determines a
minimum offset value for axis titles.

__Default value:__ `30` for y-axis; `undefined` for x-axis.

shortTimeLabels:
Whether month names and weekday names should be abbreviated.

__Default value:__  `false`

tickColor:
The color of the axis's tick.

tickRound:
Boolean flag indicating if pixel position values should be rounded to the nearest integer.

ticks:
Boolean value that determines whether the axis should include ticks.

tickSize:
The size in pixels of axis ticks.

tickWidth:
The width, in pixels, of ticks.

titleAlign:
Horizontal text alignment of axis titles.

titleAngle:
Angle in degrees of axis titles.

titleBaseline:
Vertical text baseline for axis titles.

titleColor:
Color of the title, can be in hex color code or regular color name.

titleFont:
Font of the title. (e.g., `"Helvetica Neue"`).

titleFontSize:
Font size of the title.

titleFontWeight:
Font weight of the title. (e.g., `"bold"`).

titleLimit:
Maximum allowed pixel width of axis titles.

titleMaxLength:
Max length for axis title if the title is automatically generated from the field's
description.

titlePadding:
The padding, in pixels, between title and axis.

titleX:
X-coordinate of the axis title relative to the axis group.

titleY:
Y-coordinate of the axis title relative to the axis group.
-}
data AxisConfig = AxisConfig
    { bandPositionAxisConfig :: Maybe Double
    , domainAxisConfig :: Maybe Bool
    , domainColorAxisConfig :: Maybe Text
    , domainWidthAxisConfig :: Maybe Double
    , gridAxisConfig :: Maybe Bool
    , gridColorAxisConfig :: Maybe Text
    , gridDashAxisConfig :: Maybe ([Double])
    , gridOpacityAxisConfig :: Maybe Double
    , gridWidthAxisConfig :: Maybe Double
    , labelAngleAxisConfig :: Maybe Double
    , labelBoundAxisConfig :: Maybe Label
    , labelColorAxisConfig :: Maybe Text
    , labelFlushAxisConfig :: Maybe Label
    , labelFontAxisConfig :: Maybe Text
    , labelFontSizeAxisConfig :: Maybe Double
    , labelLimitAxisConfig :: Maybe Double
    , labelOverlapAxisConfig :: Maybe LabelOverlapUnion
    , labelPaddingAxisConfig :: Maybe Double
    , labelsAxisConfig :: Maybe Bool
    , maxExtentAxisConfig :: Maybe Double
    , minExtentAxisConfig :: Maybe Double
    , shortTimeLabelsAxisConfig :: Maybe Bool
    , tickColorAxisConfig :: Maybe Text
    , tickRoundAxisConfig :: Maybe Bool
    , ticksAxisConfig :: Maybe Bool
    , tickSizeAxisConfig :: Maybe Double
    , tickWidthAxisConfig :: Maybe Double
    , titleAlignAxisConfig :: Maybe Text
    , titleAngleAxisConfig :: Maybe Double
    , titleBaselineAxisConfig :: Maybe Text
    , titleColorAxisConfig :: Maybe Text
    , titleFontAxisConfig :: Maybe Text
    , titleFontSizeAxisConfig :: Maybe Double
    , titleFontWeightAxisConfig :: Maybe TitleFontWeight
    , titleLimitAxisConfig :: Maybe Double
    , titleMaxLengthAxisConfig :: Maybe Double
    , titlePaddingAxisConfig :: Maybe Double
    , titleXAxisConfig :: Maybe Double
    , titleYAxisConfig :: Maybe Double
    } deriving (Show)

{-| Indicates if labels should be hidden if they exceed the axis range. If `false `(the
default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
they exceed the axis range by more than 1 pixel. If this property is a number, it
specifies the pixel tolerance: the maximum amount by which a label bounding box may
exceed the axis range.

__Default value:__ `false`.

Indicates if the first and last axis labels should be aligned flush with the scale range.
Flush alignment for a horizontal axis will left-align the first label and right-align the
last label. For vertical axes, bottom and top text baselines are applied instead. If this
property is a number, it also indicates the number of pixels by which to offset the first
and last labels; for example, a value of 2 will flush-align the first and last labels and
also push them 2 pixels outward from the center of the axis. The additional adjustment
can sometimes help the labels better visually group with corresponding axis ticks.

__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
-}
data Label
    = BoolInLabel Bool
    | DoubleInLabel Double
    deriving (Show)

data LabelOverlapUnion
    = BoolInLabelOverlapUnion Bool
    | EnumInLabelOverlapUnion LabelOverlapEnum
    deriving (Show)

data LabelOverlapEnum
    = ParityLabelOverlapEnum
    | GreedyLabelOverlapEnum
    deriving (Show)

{-| Font weight of the title. (e.g., `"bold"`).

The font weight of the legend title.
-}
data TitleFontWeight
    = DoubleInTitleFontWeight Double
    | StringInTitleFontWeight Text
    deriving (Show)

{-| Specific axis config for axes with "band" scales.

Specific axis config for x-axis along the bottom edge of the chart.

Specific axis config for y-axis along the left edge of the chart.

Specific axis config for y-axis along the right edge of the chart.

Specific axis config for x-axis along the top edge of the chart.

X-axis specific config.

Y-axis specific config.

bandPosition:
An interpolation fraction indicating where, for `band` scales, axis ticks should be
positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
places ticks in the middle of their bands.

domain:
A boolean flag indicating if the domain (the axis baseline) should be included as part of
the axis.

__Default value:__ `true`

domainColor:
Color of axis domain line.

__Default value:__  (none, using Vega default).

domainWidth:
Stroke width of axis domain line

__Default value:__  (none, using Vega default).

grid:
A boolean flag indicating if grid lines should be included as part of the axis

__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
binned; otherwise, `false`.

gridColor:
Color of gridlines.

gridDash:
The offset (in pixels) into which to begin drawing with the grid dash array.

gridOpacity:
The stroke opacity of grid (value between [0,1])

__Default value:__ (`1` by default)

gridWidth:
The grid width, in pixels.

labelAngle:
The rotation angle of the axis labels.

__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.

labelBound:
Indicates if labels should be hidden if they exceed the axis range. If `false `(the
default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
they exceed the axis range by more than 1 pixel. If this property is a number, it
specifies the pixel tolerance: the maximum amount by which a label bounding box may
exceed the axis range.

__Default value:__ `false`.

labelColor:
The color of the tick label, can be in hex color code or regular color name.

labelFlush:
Indicates if the first and last axis labels should be aligned flush with the scale range.
Flush alignment for a horizontal axis will left-align the first label and right-align the
last label. For vertical axes, bottom and top text baselines are applied instead. If this
property is a number, it also indicates the number of pixels by which to offset the first
and last labels; for example, a value of 2 will flush-align the first and last labels and
also push them 2 pixels outward from the center of the axis. The additional adjustment
can sometimes help the labels better visually group with corresponding axis ticks.

__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.

labelFont:
The font of the tick label.

labelFontSize:
The font size of the label, in pixels.

labelLimit:
Maximum allowed pixel width of axis tick labels.

labelOverlap:
The strategy to use for resolving overlap of axis labels. If `false` (the default), no
overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
every other label is used (this works well for standard linear axes). If set to
`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
with the last visible label (this often works better for log-scaled axes).

__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
scales; otherwise `false`.

labelPadding:
The padding, in pixels, between axis and text labels.

labels:
A boolean flag indicating if labels should be included as part of the axis.

__Default value:__  `true`.

maxExtent:
The maximum extent in pixels that axis ticks and labels should use. This determines a
maximum offset value for axis titles.

__Default value:__ `undefined`.

minExtent:
The minimum extent in pixels that axis ticks and labels should use. This determines a
minimum offset value for axis titles.

__Default value:__ `30` for y-axis; `undefined` for x-axis.

tickColor:
The color of the axis's tick.

tickRound:
Boolean flag indicating if pixel position values should be rounded to the nearest integer.

ticks:
Boolean value that determines whether the axis should include ticks.

tickSize:
The size in pixels of axis ticks.

tickWidth:
The width, in pixels, of ticks.

titleAlign:
Horizontal text alignment of axis titles.

titleAngle:
Angle in degrees of axis titles.

titleBaseline:
Vertical text baseline for axis titles.

titleColor:
Color of the title, can be in hex color code or regular color name.

titleFont:
Font of the title. (e.g., `"Helvetica Neue"`).

titleFontSize:
Font size of the title.

titleFontWeight:
Font weight of the title. (e.g., `"bold"`).

titleLimit:
Maximum allowed pixel width of axis titles.

titleMaxLength:
Max length for axis title if the title is automatically generated from the field's
description.

titlePadding:
The padding, in pixels, between title and axis.

titleX:
X-coordinate of the axis title relative to the axis group.

titleY:
Y-coordinate of the axis title relative to the axis group.
-}
data VGAxisConfig = VGAxisConfig
    { bandPositionVGAxisConfig :: Maybe Double
    , domainVGAxisConfig :: Maybe Bool
    , domainColorVGAxisConfig :: Maybe Text
    , domainWidthVGAxisConfig :: Maybe Double
    , gridVGAxisConfig :: Maybe Bool
    , gridColorVGAxisConfig :: Maybe Text
    , gridDashVGAxisConfig :: Maybe ([Double])
    , gridOpacityVGAxisConfig :: Maybe Double
    , gridWidthVGAxisConfig :: Maybe Double
    , labelAngleVGAxisConfig :: Maybe Double
    , labelBoundVGAxisConfig :: Maybe Label
    , labelColorVGAxisConfig :: Maybe Text
    , labelFlushVGAxisConfig :: Maybe Label
    , labelFontVGAxisConfig :: Maybe Text
    , labelFontSizeVGAxisConfig :: Maybe Double
    , labelLimitVGAxisConfig :: Maybe Double
    , labelOverlapVGAxisConfig :: Maybe LabelOverlapUnion
    , labelPaddingVGAxisConfig :: Maybe Double
    , labelsVGAxisConfig :: Maybe Bool
    , maxExtentVGAxisConfig :: Maybe Double
    , minExtentVGAxisConfig :: Maybe Double
    , tickColorVGAxisConfig :: Maybe Text
    , tickRoundVGAxisConfig :: Maybe Bool
    , ticksVGAxisConfig :: Maybe Bool
    , tickSizeVGAxisConfig :: Maybe Double
    , tickWidthVGAxisConfig :: Maybe Double
    , titleAlignVGAxisConfig :: Maybe Text
    , titleAngleVGAxisConfig :: Maybe Double
    , titleBaselineVGAxisConfig :: Maybe Text
    , titleColorVGAxisConfig :: Maybe Text
    , titleFontVGAxisConfig :: Maybe Text
    , titleFontSizeVGAxisConfig :: Maybe Double
    , titleFontWeightVGAxisConfig :: Maybe TitleFontWeight
    , titleLimitVGAxisConfig :: Maybe Double
    , titleMaxLengthVGAxisConfig :: Maybe Double
    , titlePaddingVGAxisConfig :: Maybe Double
    , titleXVGAxisConfig :: Maybe Double
    , titleYVGAxisConfig :: Maybe Double
    } deriving (Show)

{-| Bar-Specific Config

align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

binSpacing:
Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
statisticians) or 1 (Vega-Lite Default, D3 example style).

__Default value:__ `1`

color:
Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
will override `color`.

__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

continuousBandSize:
The default size of the bars on continuous scales.

__Default value:__ `5`

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

discreteBandSize:
The size of the bars.  If unspecified, the default size is  `bandSize-1`,
which provides 1 pixel offset between bars.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

filled:
Whether the mark's color should be used as fill color instead of stroke color.

__Default value:__ `true` for all marks except `point` and `false` for `point`.

__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

barConfigText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".
-}
data BarConfig = BarConfig
    { alignBarConfig :: Maybe HorizontalAlign
    , angleBarConfig :: Maybe Double
    , baselineBarConfig :: Maybe VerticalAlign
    , binSpacingBarConfig :: Maybe Double
    , colorBarConfig :: Maybe Text
    , continuousBandSizeBarConfig :: Maybe Double
    , cursorBarConfig :: Maybe Cursor
    , discreteBandSizeBarConfig :: Maybe Double
    , dxBarConfig :: Maybe Double
    , dyBarConfig :: Maybe Double
    , fillBarConfig :: Maybe Text
    , filledBarConfig :: Maybe Bool
    , fillOpacityBarConfig :: Maybe Double
    , fontBarConfig :: Maybe Text
    , fontSizeBarConfig :: Maybe Double
    , fontStyleBarConfig :: Maybe FontStyle
    , fontWeightBarConfig :: Maybe FontWeightUnion
    , hrefBarConfig :: Maybe Text
    , interpolateBarConfig :: Maybe Interpolate
    , limitBarConfig :: Maybe Double
    , opacityBarConfig :: Maybe Double
    , orientBarConfig :: Maybe Orient
    , radiusBarConfig :: Maybe Double
    , shapeBarConfig :: Maybe Text
    , sizeBarConfig :: Maybe Double
    , strokeBarConfig :: Maybe Text
    , strokeDashBarConfig :: Maybe ([Double])
    , strokeDashOffsetBarConfig :: Maybe Double
    , strokeOpacityBarConfig :: Maybe Double
    , strokeWidthBarConfig :: Maybe Double
    , tensionBarConfig :: Maybe Double
    , barConfigTextBarConfig :: Maybe Text
    , thetaBarConfig :: Maybe Double
    } deriving (Show)

{-| Text-Specific Config

align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

color:
Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
will override `color`.

__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

filled:
Whether the mark's color should be used as fill color instead of stroke color.

__Default value:__ `true` for all marks except `point` and `false` for `point`.

__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

shortTimeLabels:
Whether month names and weekday names should be abbreviated.

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

textConfigText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".
-}
data TextConfig = TextConfig
    { alignTextConfig :: Maybe HorizontalAlign
    , angleTextConfig :: Maybe Double
    , baselineTextConfig :: Maybe VerticalAlign
    , colorTextConfig :: Maybe Text
    , cursorTextConfig :: Maybe Cursor
    , dxTextConfig :: Maybe Double
    , dyTextConfig :: Maybe Double
    , fillTextConfig :: Maybe Text
    , filledTextConfig :: Maybe Bool
    , fillOpacityTextConfig :: Maybe Double
    , fontTextConfig :: Maybe Text
    , fontSizeTextConfig :: Maybe Double
    , fontStyleTextConfig :: Maybe FontStyle
    , fontWeightTextConfig :: Maybe FontWeightUnion
    , hrefTextConfig :: Maybe Text
    , interpolateTextConfig :: Maybe Interpolate
    , limitTextConfig :: Maybe Double
    , opacityTextConfig :: Maybe Double
    , orientTextConfig :: Maybe Orient
    , radiusTextConfig :: Maybe Double
    , shapeTextConfig :: Maybe Text
    , shortTimeLabelsTextConfig :: Maybe Bool
    , sizeTextConfig :: Maybe Double
    , strokeTextConfig :: Maybe Text
    , strokeDashTextConfig :: Maybe ([Double])
    , strokeDashOffsetTextConfig :: Maybe Double
    , strokeOpacityTextConfig :: Maybe Double
    , strokeWidthTextConfig :: Maybe Double
    , tensionTextConfig :: Maybe Double
    , textConfigTextTextConfig :: Maybe Text
    , thetaTextConfig :: Maybe Double
    } deriving (Show)

{-| Defines how Vega-Lite generates title for fields.  There are three possible styles:

- `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
"Year-month of date", "field (binned)").
- `"function"` - displays function using parentheses and capitalized texts (e.g.,
"SUM(field)", "YEARMONTH(date)", "BIN(field)").
- `"plain"` - displays only the field name without functions (e.g., "field", "date",
"field").
-}
data FieldTitle
    = VerbalFieldTitle
    | FunctionalFieldTitle
    | PlainFieldTitle
    deriving (Show)

{-| Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
- If set to `"filter"` (default), all data items with null values are filtered.
- If `null`, all data items are included. In this case, invalid values will be
interpreted as zeroes.
-}
data InvalidValues
    = FilterInvalidValues
    deriving (Show)

{-| Legend configuration, which determines default properties for all [legends](legend.html).
For a full list of legend configuration options, please see the [corresponding section of
in the legend documentation](legend.html#config).

cornerRadius:
Corner radius for the full legend.

entryPadding:
Padding (in pixels) between legend entries in a symbol legend.

fillColor:
Background fill color for the full legend.

gradientHeight:
The height of the gradient, in pixels.

gradientLabelBaseline:
Text baseline for color ramp gradient labels.

gradientLabelLimit:
The maximum allowed length in pixels of color ramp gradient labels.

gradientLabelOffset:
Vertical offset in pixels for color ramp gradient labels.

gradientStrokeColor:
The color of the gradient stroke, can be in hex color code or regular color name.

gradientStrokeWidth:
The width of the gradient stroke, in pixels.

gradientWidth:
The width of the gradient, in pixels.

labelAlign:
The alignment of the legend label, can be left, middle or right.

labelBaseline:
The position of the baseline of legend label, can be top, middle or bottom.

labelColor:
The color of the legend label, can be in hex color code or regular color name.

labelFont:
The font of the legend label.

labelFontSize:
The font size of legend label.

__Default value:__ `10`.

labelLimit:
Maximum allowed pixel width of axis tick labels.

labelOffset:
The offset of the legend label.

offset:
The offset, in pixels, by which to displace the legend from the edge of the enclosing
group or data rectangle.

__Default value:__  `0`

orient:
The orientation of the legend, which determines how the legend is positioned within the
scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
"none".

__Default value:__ `"right"`

padding:
The padding, in pixels, between the legend and axis.

shortTimeLabels:
Whether month names and weekday names should be abbreviated.

__Default value:__  `false`

strokeColor:
Border stroke color for the full legend.

strokeDash:
Border stroke dash pattern for the full legend.

strokeWidth:
Border stroke width for the full legend.

symbolColor:
The color of the legend symbol,

symbolSize:
The size of the legend symbol, in pixels.

symbolStrokeWidth:
The width of the symbol's stroke.

symbolType:
Default shape type (such as "circle") for legend symbols.

titleAlign:
Horizontal text alignment for legend titles.

titleBaseline:
Vertical text baseline for legend titles.

titleColor:
The color of the legend title, can be in hex color code or regular color name.

titleFont:
The font of the legend title.

titleFontSize:
The font size of the legend title.

titleFontWeight:
The font weight of the legend title.

titleLimit:
Maximum allowed pixel width of axis titles.

titlePadding:
The padding, in pixels, between title and legend.
-}
data LegendConfig = LegendConfig
    { cornerRadiusLegendConfig :: Maybe Double
    , entryPaddingLegendConfig :: Maybe Double
    , fillColorLegendConfig :: Maybe Text
    , gradientHeightLegendConfig :: Maybe Double
    , gradientLabelBaselineLegendConfig :: Maybe Text
    , gradientLabelLimitLegendConfig :: Maybe Double
    , gradientLabelOffsetLegendConfig :: Maybe Double
    , gradientStrokeColorLegendConfig :: Maybe Text
    , gradientStrokeWidthLegendConfig :: Maybe Double
    , gradientWidthLegendConfig :: Maybe Double
    , labelAlignLegendConfig :: Maybe Text
    , labelBaselineLegendConfig :: Maybe Text
    , labelColorLegendConfig :: Maybe Text
    , labelFontLegendConfig :: Maybe Text
    , labelFontSizeLegendConfig :: Maybe Double
    , labelLimitLegendConfig :: Maybe Double
    , labelOffsetLegendConfig :: Maybe Double
    , offsetLegendConfig :: Maybe Double
    , orientLegendConfig :: Maybe LegendOrient
    , paddingLegendConfig :: Maybe Double
    , shortTimeLabelsLegendConfig :: Maybe Bool
    , strokeColorLegendConfig :: Maybe Text
    , strokeDashLegendConfig :: Maybe ([Double])
    , strokeWidthLegendConfig :: Maybe Double
    , symbolColorLegendConfig :: Maybe Text
    , symbolSizeLegendConfig :: Maybe Double
    , symbolStrokeWidthLegendConfig :: Maybe Double
    , symbolTypeLegendConfig :: Maybe Text
    , titleAlignLegendConfig :: Maybe Text
    , titleBaselineLegendConfig :: Maybe Text
    , titleColorLegendConfig :: Maybe Text
    , titleFontLegendConfig :: Maybe Text
    , titleFontSizeLegendConfig :: Maybe Double
    , titleFontWeightLegendConfig :: Maybe TitleFontWeight
    , titleLimitLegendConfig :: Maybe Double
    , titlePaddingLegendConfig :: Maybe Double
    } deriving (Show)

{-| The orientation of the legend, which determines how the legend is positioned within the
scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
"none".

__Default value:__ `"right"`
-}
data LegendOrient
    = LeftLegendOrient
    | RightLegendOrient
    | TopLeftLegendOrient
    | TopRightLegendOrient
    | BottomLeftLegendOrient
    | BottomRightLegendOrient
    | NoneLegendOrient
    deriving (Show)

{-| The default visualization padding, in pixels, from the edge of the visualization canvas
to the data rectangle.  If a number, specifies padding for all sides.
If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
"bottom": 5}` to specify padding for each side of the visualization.

__Default value__: `5`
-}
data Padding
    = DoubleInPadding Double
    | PaddingClassInPadding PaddingClass
    deriving (Show)

data PaddingClass = PaddingClass
    { bottomPaddingClass :: Maybe Double
    , leftPaddingClass :: Maybe Double
    , rightPaddingClass :: Maybe Double
    , topPaddingClass :: Maybe Double
    } deriving (Show)

{-| Projection configuration, which determines default properties for all
[projections](projection.html). For a full list of projection configuration options,
please see the [corresponding section of the projection
documentation](projection.html#config).

Any property of Projection can be in config

center:
Sets the projection’s center to the specified center, a two-element array of longitude
and latitude in degrees.

__Default value:__ `[0, 0]`

clipAngle:
Sets the projection’s clipping circle radius to the specified angle in degrees. If
`null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
than small-circle clipping.

clipExtent:
Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
viewport clipping is performed.

precision:
Sets the threshold for the projection’s [adaptive
resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
value corresponds to the [Douglas–Peucker
distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
If precision is not specified, returns the projection’s current resampling precision
which defaults to `√0.5 ≅ 0.70710…`.

rotate:
Sets the projection’s three-axis rotation to the specified angles, which must be a two-
or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)

__Default value:__ `[0, 0, 0]`

projectionConfigType:
The cartographic projection to use. This value is case-insensitive, for example
`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
projection types [in the
documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).

__Default value:__ `mercator`
-}
data ProjectionConfig = ProjectionConfig
    { centerProjectionConfig :: Maybe ([Double])
    , clipAngleProjectionConfig :: Maybe Double
    , clipExtentProjectionConfig :: Maybe ([([Double])])
    , coefficientProjectionConfig :: Maybe Double
    , distanceProjectionConfig :: Maybe Double
    , fractionProjectionConfig :: Maybe Double
    , lobesProjectionConfig :: Maybe Double
    , parallelProjectionConfig :: Maybe Double
    , precisionProjectionConfig :: Maybe (HashMap Text TitleFontWeight)
    , radiusProjectionConfig :: Maybe Double
    , ratioProjectionConfig :: Maybe Double
    , rotateProjectionConfig :: Maybe ([Double])
    , spacingProjectionConfig :: Maybe Double
    , tiltProjectionConfig :: Maybe Double
    , projectionConfigTypeProjectionConfig :: Maybe VGProjectionType
    } deriving (Show)

{-| The cartographic projection to use. This value is case-insensitive, for example
`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
projection types [in the
documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).

__Default value:__ `mercator`
-}
data VGProjectionType
    = AlbersVGProjectionType
    | AlbersUsaVGProjectionType
    | AzimuthalEqualAreaVGProjectionType
    | AzimuthalEquidistantVGProjectionType
    | ConicConformalVGProjectionType
    | ConicEqualAreaVGProjectionType
    | ConicEquidistantVGProjectionType
    | EquirectangularVGProjectionType
    | GnomonicVGProjectionType
    | MercatorVGProjectionType
    | OrthographicVGProjectionType
    | StereographicVGProjectionType
    | TransverseMercatorVGProjectionType
    deriving (Show)

data RangeConfigValue
    = UnionArrayInRangeConfigValue ([TitleFontWeight])
    | VGSchemeInRangeConfigValue VGScheme
    deriving (Show)

data VGScheme = VGScheme
    { countVGScheme :: Maybe Double
    , extentVGScheme :: Maybe ([Double])
    , schemeVGScheme :: Maybe Text
    , stepVGScheme :: Maybe Double
    } deriving (Show)

{-| Scale configuration determines default properties for all [scales](scale.html). For a
full list of scale configuration options, please see the [corresponding section of the
scale documentation](scale.html#config).

bandPaddingInner:
Default inner padding for `x` and `y` band-ordinal scales.

__Default value:__ `0.1`

bandPaddingOuter:
Default outer padding for `x` and `y` band-ordinal scales.
If not specified, by default, band scale's paddingOuter is paddingInner/2.

clamp:
If true, values that exceed the data domain are clamped to either the minimum or maximum
range value

continuousPadding:
Default padding for continuous scales.

__Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
horizontal bar.; `0` otherwise.

maxBandSize:
The default max value for mapping quantitative fields to bar's size/bandSize.

If undefined (default), we will use the scale's `rangeStep` - 1.

maxFontSize:
The default max value for mapping quantitative fields to text's size/fontSize.

__Default value:__ `40`

maxOpacity:
Default max opacity for mapping a field to opacity.

__Default value:__ `0.8`

maxSize:
Default max value for point size scale.

maxStrokeWidth:
Default max strokeWidth for strokeWidth  (or rule/line's size) scale.

__Default value:__ `4`

minBandSize:
The default min value for mapping quantitative fields to bar and tick's size/bandSize
scale with zero=false.

__Default value:__ `2`

minFontSize:
The default min value for mapping quantitative fields to tick's size/fontSize scale with
zero=false

__Default value:__ `8`

minOpacity:
Default minimum opacity for mapping a field to opacity.

__Default value:__ `0.3`

minSize:
Default minimum value for point size scale with zero=false.

__Default value:__ `9`

minStrokeWidth:
Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.

__Default value:__ `1`

pointPadding:
Default outer padding for `x` and `y` point-ordinal scales.

__Default value:__ `0.5`

rangeStep:
Default range step for band and point scales of (1) the `y` channel
and (2) the `x` channel when the mark is not `text`.

__Default value:__ `21`

round:
If true, rounds numeric output values to integers.
This can be helpful for snapping to the pixel grid.
(Only available for `x`, `y`, and `size` scales.)

textXRangeStep:
Default range step for `x` band and point scales of text marks.

__Default value:__ `90`

useUnaggregatedDomain:
Use the source data range before aggregation as scale domain instead of aggregated data
for aggregate axis.

This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
fields by default.

This property only works with aggregate functions that produce values within the raw data
domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
aggregations that produce values outside of the raw data domain (e.g. `"count"`,
`"sum"`), this property is ignored.

__Default value:__ `false`
-}
data ScaleConfig = ScaleConfig
    { bandPaddingInnerScaleConfig :: Maybe Double
    , bandPaddingOuterScaleConfig :: Maybe Double
    , clampScaleConfig :: Maybe Bool
    , continuousPaddingScaleConfig :: Maybe Double
    , maxBandSizeScaleConfig :: Maybe Double
    , maxFontSizeScaleConfig :: Maybe Double
    , maxOpacityScaleConfig :: Maybe Double
    , maxSizeScaleConfig :: Maybe Double
    , maxStrokeWidthScaleConfig :: Maybe Double
    , minBandSizeScaleConfig :: Maybe Double
    , minFontSizeScaleConfig :: Maybe Double
    , minOpacityScaleConfig :: Maybe Double
    , minSizeScaleConfig :: Maybe Double
    , minStrokeWidthScaleConfig :: Maybe Double
    , pointPaddingScaleConfig :: Maybe Double
    , rangeStepScaleConfig :: Maybe (Maybe Double)
    , roundScaleConfig :: Maybe Bool
    , textXRangeStepScaleConfig :: Maybe Double
    , useUnaggregatedDomainScaleConfig :: Maybe Bool
    } deriving (Show)

{-| An object hash for defining default properties for each type of selections.

interval:
The default definition for an [`interval`](selection.html#type) selection. All properties
and transformations
for an interval selection definition (except `type`) may be specified here.

For instance, setting `interval` to `{"translate": false}` disables the ability to move
interval selections by default.

multi:
The default definition for a [`multi`](selection.html#type) selection. All properties and
transformations
for a multi selection definition (except `type`) may be specified here.

For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
multi selections when clicking with the alt-key pressed by default.

single:
The default definition for a [`single`](selection.html#type) selection. All properties
and transformations
for a single selection definition (except `type`) may be specified here.

For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
double-click by default.
-}
data SelectionConfig = SelectionConfig
    { intervalSelectionConfig :: Maybe IntervalSelectionConfig
    , multiSelectionConfig :: Maybe MultiSelectionConfig
    , singleSelectionConfig :: Maybe SingleSelectionConfig
    } deriving (Show)

{-| The default definition for an [`interval`](selection.html#type) selection. All properties
and transformations
for an interval selection definition (except `type`) may be specified here.

For instance, setting `interval` to `{"translate": false}` disables the ability to move
interval selections by default.

bind:
Establishes a two-way binding between the interval selection and the scales
used within the same view. This allows a user to interactively pan and
zoom the view.

empty:
By default, all data values are considered to lie within an empty selection.
When set to `none`, empty selections contain no data values.

encodings:
An array of encoding channels. The corresponding data field values
must match for a data tuple to fall within the selection.

fields:
An array of field names whose values must match for a data tuple to
fall within the selection.

mark:
An interval selection also adds a rectangle mark to depict the
extents of the interval. The `mark` property can be used to customize the
appearance of the mark.

on:
A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
selector) that triggers the selection.
For interval selections, the event stream must specify a [start and
end](https://vega.github.io/vega/docs/event-streams/#between-filters).

resolve:
With layered and multi-view displays, a strategy that determines how
selections' data queries are resolved when applied in a filter transform,
conditional encoding rule, or scale domain.

translate:
When truthy, allows a user to interactively move an interval selection
back-and-forth. Can be `true`, `false` (to disable panning), or a
[Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
which must include a start and end event to trigger continuous panning.

__Default value:__ `true`, which corresponds to
`[mousedown, window:mouseup] > window:mousemove!` which corresponds to
clicks and dragging within an interval selection to reposition it.

zoom:
When truthy, allows a user to interactively resize an interval selection.
Can be `true`, `false` (to disable zooming), or a [Vega event stream
definition](https://vega.github.io/vega/docs/event-streams/). Currently,
only `wheel` events are supported.


__Default value:__ `true`, which corresponds to `wheel!`.
-}
data IntervalSelectionConfig = IntervalSelectionConfig
    { bindIntervalSelectionConfig :: Maybe BindEnum
    , emptyIntervalSelectionConfig :: Maybe Empty
    , encodingsIntervalSelectionConfig :: Maybe ([SingleDefChannel])
    , fieldsIntervalSelectionConfig :: Maybe ([Text])
    , markIntervalSelectionConfig :: Maybe BrushConfig
    , onIntervalSelectionConfig :: Maybe Value
    , resolveIntervalSelectionConfig :: Maybe SelectionResolution
    , translateIntervalSelectionConfig :: Maybe Translate
    , zoomIntervalSelectionConfig :: Maybe Translate
    } deriving (Show)

{-| Establishes a two-way binding between the interval selection and the scales
used within the same view. This allows a user to interactively pan and
zoom the view.
-}
data BindEnum
    = ScalesBindEnum
    deriving (Show)

{-| By default, all data values are considered to lie within an empty selection.
When set to `none`, empty selections contain no data values.
-}
data Empty
    = AllEmpty
    | NoneEmpty
    deriving (Show)

data SingleDefChannel
    = XSingleDefChannel
    | YSingleDefChannel
    | X2SingleDefChannel
    | Y2SingleDefChannel
    | RowSingleDefChannel
    | ColumnSingleDefChannel
    | SizeSingleDefChannel
    | ShapeSingleDefChannel
    | ColorSingleDefChannel
    | OpacitySingleDefChannel
    | TextSingleDefChannel
    | TooltipSingleDefChannel
    | HrefSingleDefChannel
    deriving (Show)

{-| An interval selection also adds a rectangle mark to depict the
extents of the interval. The `mark` property can be used to customize the
appearance of the mark.

fill:
The fill color of the interval mark.

__Default value:__ `#333333`

fillOpacity:
The fill opacity of the interval mark (a value between 0 and 1).

__Default value:__ `0.125`

stroke:
The stroke color of the interval mark.

__Default value:__ `#ffffff`

strokeDash:
An array of alternating stroke and space lengths,
for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) with which to begin drawing the stroke dash array.

strokeOpacity:
The stroke opacity of the interval mark (a value between 0 and 1).

strokeWidth:
The stroke width of the interval mark.
-}
data BrushConfig = BrushConfig
    { fillBrushConfig :: Maybe Text
    , fillOpacityBrushConfig :: Maybe Double
    , strokeBrushConfig :: Maybe Text
    , strokeDashBrushConfig :: Maybe ([Double])
    , strokeDashOffsetBrushConfig :: Maybe Double
    , strokeOpacityBrushConfig :: Maybe Double
    , strokeWidthBrushConfig :: Maybe Double
    } deriving (Show)

{-| With layered and multi-view displays, a strategy that determines how
selections' data queries are resolved when applied in a filter transform,
conditional encoding rule, or scale domain.
-}
data SelectionResolution
    = GlobalSelectionResolution
    | UnionSelectionResolution
    | IntersectSelectionResolution
    deriving (Show)

{-| When truthy, allows a user to interactively move an interval selection
back-and-forth. Can be `true`, `false` (to disable panning), or a
[Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
which must include a start and end event to trigger continuous panning.

__Default value:__ `true`, which corresponds to
`[mousedown, window:mouseup] > window:mousemove!` which corresponds to
clicks and dragging within an interval selection to reposition it.

When truthy, allows a user to interactively resize an interval selection.
Can be `true`, `false` (to disable zooming), or a [Vega event stream
definition](https://vega.github.io/vega/docs/event-streams/). Currently,
only `wheel` events are supported.


__Default value:__ `true`, which corresponds to `wheel!`.

Controls whether data values should be toggled or only ever inserted into
multi selections. Can be `true`, `false` (for insertion only), or a
[Vega expression](https://vega.github.io/vega/docs/expressions/).

__Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
data values are toggled when a user interacts with the shift-key pressed).

See the [toggle transform](toggle.html) documentation for more information.
-}
data Translate
    = BoolInTranslate Bool
    | StringInTranslate Text
    deriving (Show)

{-| The default definition for a [`multi`](selection.html#type) selection. All properties and
transformations
for a multi selection definition (except `type`) may be specified here.

For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
multi selections when clicking with the alt-key pressed by default.

empty:
By default, all data values are considered to lie within an empty selection.
When set to `none`, empty selections contain no data values.

encodings:
An array of encoding channels. The corresponding data field values
must match for a data tuple to fall within the selection.

fields:
An array of field names whose values must match for a data tuple to
fall within the selection.

nearest:
When true, an invisible voronoi diagram is computed to accelerate discrete
selection. The data value _nearest_ the mouse cursor is added to the selection.

See the [nearest transform](nearest.html) documentation for more information.

on:
A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
selector) that triggers the selection.
For interval selections, the event stream must specify a [start and
end](https://vega.github.io/vega/docs/event-streams/#between-filters).

resolve:
With layered and multi-view displays, a strategy that determines how
selections' data queries are resolved when applied in a filter transform,
conditional encoding rule, or scale domain.

toggle:
Controls whether data values should be toggled or only ever inserted into
multi selections. Can be `true`, `false` (for insertion only), or a
[Vega expression](https://vega.github.io/vega/docs/expressions/).

__Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
data values are toggled when a user interacts with the shift-key pressed).

See the [toggle transform](toggle.html) documentation for more information.
-}
data MultiSelectionConfig = MultiSelectionConfig
    { emptyMultiSelectionConfig :: Maybe Empty
    , encodingsMultiSelectionConfig :: Maybe ([SingleDefChannel])
    , fieldsMultiSelectionConfig :: Maybe ([Text])
    , nearestMultiSelectionConfig :: Maybe Bool
    , onMultiSelectionConfig :: Maybe Value
    , resolveMultiSelectionConfig :: Maybe SelectionResolution
    , toggleMultiSelectionConfig :: Maybe Translate
    } deriving (Show)

{-| The default definition for a [`single`](selection.html#type) selection. All properties
and transformations
for a single selection definition (except `type`) may be specified here.

For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
double-click by default.

bind:
Establish a two-way binding between a single selection and input elements
(also known as dynamic query widgets). A binding takes the form of
Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
or can be a mapping between projected field/encodings and binding definitions.

See the [bind transform](bind.html) documentation for more information.

empty:
By default, all data values are considered to lie within an empty selection.
When set to `none`, empty selections contain no data values.

encodings:
An array of encoding channels. The corresponding data field values
must match for a data tuple to fall within the selection.

fields:
An array of field names whose values must match for a data tuple to
fall within the selection.

nearest:
When true, an invisible voronoi diagram is computed to accelerate discrete
selection. The data value _nearest_ the mouse cursor is added to the selection.

See the [nearest transform](nearest.html) documentation for more information.

on:
A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
selector) that triggers the selection.
For interval selections, the event stream must specify a [start and
end](https://vega.github.io/vega/docs/event-streams/#between-filters).

resolve:
With layered and multi-view displays, a strategy that determines how
selections' data queries are resolved when applied in a filter transform,
conditional encoding rule, or scale domain.
-}
data SingleSelectionConfig = SingleSelectionConfig
    { bindSingleSelectionConfig :: Maybe (HashMap Text VGBinding)
    , emptySingleSelectionConfig :: Maybe Empty
    , encodingsSingleSelectionConfig :: Maybe ([SingleDefChannel])
    , fieldsSingleSelectionConfig :: Maybe ([Text])
    , nearestSingleSelectionConfig :: Maybe Bool
    , onSingleSelectionConfig :: Maybe Value
    , resolveSingleSelectionConfig :: Maybe SelectionResolution
    } deriving (Show)

data VGBinding = VGBinding
    { elementVGBinding :: Maybe Text
    , inputVGBinding :: Text
    , optionsVGBinding :: Maybe ([Text])
    , maxVGBinding :: Maybe Double
    , minVGBinding :: Maybe Double
    , stepVGBinding :: Maybe Double
    } deriving (Show)

{-| Default stack offset for stackable mark. -}

data StackOffset
    = ZeroStackOffset
    | CenterStackOffset
    | NormalizeStackOffset
    deriving (Show)

{-| align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

vgMarkConfigText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".
-}
data VGMarkConfig = VGMarkConfig
    { alignVGMarkConfig :: Maybe HorizontalAlign
    , angleVGMarkConfig :: Maybe Double
    , baselineVGMarkConfig :: Maybe VerticalAlign
    , cursorVGMarkConfig :: Maybe Cursor
    , dxVGMarkConfig :: Maybe Double
    , dyVGMarkConfig :: Maybe Double
    , fillVGMarkConfig :: Maybe Text
    , fillOpacityVGMarkConfig :: Maybe Double
    , fontVGMarkConfig :: Maybe Text
    , fontSizeVGMarkConfig :: Maybe Double
    , fontStyleVGMarkConfig :: Maybe FontStyle
    , fontWeightVGMarkConfig :: Maybe FontWeightUnion
    , hrefVGMarkConfig :: Maybe Text
    , interpolateVGMarkConfig :: Maybe Interpolate
    , limitVGMarkConfig :: Maybe Double
    , opacityVGMarkConfig :: Maybe Double
    , orientVGMarkConfig :: Maybe Orient
    , radiusVGMarkConfig :: Maybe Double
    , shapeVGMarkConfig :: Maybe Text
    , sizeVGMarkConfig :: Maybe Double
    , strokeVGMarkConfig :: Maybe Text
    , strokeDashVGMarkConfig :: Maybe ([Double])
    , strokeDashOffsetVGMarkConfig :: Maybe Double
    , strokeOpacityVGMarkConfig :: Maybe Double
    , strokeWidthVGMarkConfig :: Maybe Double
    , tensionVGMarkConfig :: Maybe Double
    , vgMarkConfigTextVGMarkConfig :: Maybe Text
    , thetaVGMarkConfig :: Maybe Double
    } deriving (Show)

{-| Tick-Specific Config

align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

bandSize:
The width of the ticks.

__Default value:__  2/3 of rangeStep.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

color:
Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
will override `color`.

__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

filled:
Whether the mark's color should be used as fill color instead of stroke color.

__Default value:__ `true` for all marks except `point` and `false` for `point`.

__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

tickConfigText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".

thickness:
Thickness of the tick mark.

__Default value:__  `1`
-}
data TickConfig = TickConfig
    { alignTickConfig :: Maybe HorizontalAlign
    , angleTickConfig :: Maybe Double
    , bandSizeTickConfig :: Maybe Double
    , baselineTickConfig :: Maybe VerticalAlign
    , colorTickConfig :: Maybe Text
    , cursorTickConfig :: Maybe Cursor
    , dxTickConfig :: Maybe Double
    , dyTickConfig :: Maybe Double
    , fillTickConfig :: Maybe Text
    , filledTickConfig :: Maybe Bool
    , fillOpacityTickConfig :: Maybe Double
    , fontTickConfig :: Maybe Text
    , fontSizeTickConfig :: Maybe Double
    , fontStyleTickConfig :: Maybe FontStyle
    , fontWeightTickConfig :: Maybe FontWeightUnion
    , hrefTickConfig :: Maybe Text
    , interpolateTickConfig :: Maybe Interpolate
    , limitTickConfig :: Maybe Double
    , opacityTickConfig :: Maybe Double
    , orientTickConfig :: Maybe Orient
    , radiusTickConfig :: Maybe Double
    , shapeTickConfig :: Maybe Text
    , sizeTickConfig :: Maybe Double
    , strokeTickConfig :: Maybe Text
    , strokeDashTickConfig :: Maybe ([Double])
    , strokeDashOffsetTickConfig :: Maybe Double
    , strokeOpacityTickConfig :: Maybe Double
    , strokeWidthTickConfig :: Maybe Double
    , tensionTickConfig :: Maybe Double
    , tickConfigTextTickConfig :: Maybe Text
    , thetaTickConfig :: Maybe Double
    , thicknessTickConfig :: Maybe Double
    } deriving (Show)

{-| Title configuration, which determines default properties for all [titles](title.html).
For a full list of title configuration options, please see the [corresponding section of
the title documentation](title.html#config).

anchor:
The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
example, with an orientation of top these anchor positions map to a left-, center-, or
right-aligned title.

__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
`"start"` for other composite views.

__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
customizable only for [single](spec.html) and [layered](layer.html) views.  For other
composite views, `anchor` is always `"start"`.

angle:
Angle in degrees of title text.

baseline:
Vertical text baseline for title text.

color:
Text color for title text.

font:
Font name for title text.

fontSize:
Font size in pixels for title text.

__Default value:__ `10`.

fontWeight:
Font weight for title text.

limit:
The maximum allowed length in pixels of legend labels.

offset:
Offset in pixels of the title from the chart body and axes.

orient:
Default title orientation ("top", "bottom", "left", or "right")
-}
data VGTitleConfig = VGTitleConfig
    { anchorVGTitleConfig :: Maybe Anchor
    , angleVGTitleConfig :: Maybe Double
    , baselineVGTitleConfig :: Maybe VerticalAlign
    , colorVGTitleConfig :: Maybe Text
    , fontVGTitleConfig :: Maybe Text
    , fontSizeVGTitleConfig :: Maybe Double
    , fontWeightVGTitleConfig :: Maybe FontWeightUnion
    , limitVGTitleConfig :: Maybe Double
    , offsetVGTitleConfig :: Maybe Double
    , orientVGTitleConfig :: Maybe TitleOrient
    } deriving (Show)

{-| The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
example, with an orientation of top these anchor positions map to a left-, center-, or
right-aligned title.

__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
`"start"` for other composite views.

__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
customizable only for [single](spec.html) and [layered](layer.html) views.  For other
composite views, `anchor` is always `"start"`.
-}
data Anchor
    = StartAnchor
    | MiddleAnchor
    | EndAnchor
    deriving (Show)

{-| Default title orientation ("top", "bottom", "left", or "right")

The orientation of the title relative to the chart. One of `"top"` (the default),
`"bottom"`, `"left"`, or `"right"`.

The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
orientation can be used to further specialize the axis type (e.g., a y axis oriented for
the right edge of the chart).

__Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
-}
data TitleOrient
    = TopTitleOrient
    | BottomTitleOrient
    | LeftTitleOrient
    | RightTitleOrient
    deriving (Show)

{-| Default properties for [single view plots](spec.html#single).

clip:
Whether the view should be clipped.

fill:
The fill color.

__Default value:__ (none)

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ (none)

height:
The default height of the single plot or each plot in a trellis plot when the
visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.

__Default value:__ `200`

stroke:
The stroke color.

__Default value:__ (none)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

__Default value:__ (none)

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

__Default value:__ (none)

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ (none)

strokeWidth:
The stroke width, in pixels.

__Default value:__ (none)

width:
The default width of the single plot or each plot in a trellis plot when the
visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
= `null`.

__Default value:__ `200`
-}
data ViewConfig = ViewConfig
    { clipViewConfig :: Maybe Bool
    , fillViewConfig :: Maybe Text
    , fillOpacityViewConfig :: Maybe Double
    , heightViewConfig :: Maybe Double
    , strokeViewConfig :: Maybe Text
    , strokeDashViewConfig :: Maybe ([Double])
    , strokeDashOffsetViewConfig :: Maybe Double
    , strokeOpacityViewConfig :: Maybe Double
    , strokeWidthViewConfig :: Maybe Double
    , widthViewConfig :: Maybe Double
    } deriving (Show)

{-| A key-value mapping between encoding channels and definition of fields.

color:
Color of the marks – either fill or stroke color based on mark type.
By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.

__Default value:__ If undefined, the default color depends on [mark
config](config.html#mark)'s `color` property.

_Note:_ See the scale documentation for more information about customizing [color
scheme](scale.html#scheme).

column:
Horizontal facets for trellis plots.

detail:
Additional levels of detail for grouping data in aggregate views and
in line and area marks without mapping data to a specific visual channel.

href:
A URL to load upon mouse click.

opacity:
Opacity of the marks – either can be a value or a range.

__Default value:__ If undefined, the default opacity depends on [mark
config](config.html#mark)'s `opacity` property.

order:
Stack order for stacked marks or order of data points in line marks for connected scatter
plots.

__Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
additional aggregation grouping.

row:
Vertical facets for trellis plots.

shape:
For `point` marks the supported values are
`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
or `"triangle-down"`, or else a custom SVG path string.
For `geoshape` marks it should be a field definition of the geojson data

__Default value:__ If undefined, the default shape depends on [mark
config](config.html#point-config)'s `shape` property.

size:
Size of the mark.
- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
- For `"bar"` and `"tick"` – the bar and tick's size.
- For `"text"` – the text's font size.
- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.

encodingWithFacetText:
Text of the `text` mark.

tooltip:
The tooltip text to show upon mouse hover.

x:
X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.

x2:
X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.

y:
Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.

y2:
Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
-}
data EncodingWithFacet = EncodingWithFacet
    { colorEncodingWithFacet :: Maybe MarkPropDefWithCondition
    , columnEncodingWithFacet :: Maybe FacetFieldDef
    , detailEncodingWithFacet :: Maybe Detail
    , hrefEncodingWithFacet :: Maybe DefWithCondition
    , opacityEncodingWithFacet :: Maybe MarkPropDefWithCondition
    , orderEncodingWithFacet :: Maybe Order
    , rowEncodingWithFacet :: Maybe FacetFieldDef
    , shapeEncodingWithFacet :: Maybe MarkPropDefWithCondition
    , sizeEncodingWithFacet :: Maybe MarkPropDefWithCondition
    , encodingWithFacetTextEncodingWithFacet :: Maybe TextDefWithCondition
    , tooltipEncodingWithFacet :: Maybe TextDefWithCondition
    , xEncodingWithFacet :: Maybe XClass
    , x2EncodingWithFacet :: Maybe X2Class
    , yEncodingWithFacet :: Maybe XClass
    , y2EncodingWithFacet :: Maybe X2Class
    } deriving (Show)

{-| Color of the marks – either fill or stroke color based on mark type.
By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.

__Default value:__ If undefined, the default color depends on [mark
config](config.html#mark)'s `color` property.

_Note:_ See the scale documentation for more information about customizing [color
scheme](scale.html#scheme).

Opacity of the marks – either can be a value or a range.

__Default value:__ If undefined, the default opacity depends on [mark
config](config.html#mark)'s `opacity` property.

For `point` marks the supported values are
`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
or `"triangle-down"`, or else a custom SVG path string.
For `geoshape` marks it should be a field definition of the geojson data

__Default value:__ If undefined, the default shape depends on [mark
config](config.html#point-config)'s `shape` property.

Size of the mark.
- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
- For `"bar"` and `"tick"` – the bar and tick's size.
- For `"text"` – the text's font size.
- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.

A FieldDef with Condition<ValueDef>
{
condition: {value: ...},
field: ...,
...
}

A ValueDef with Condition<ValueDef | FieldDef>
{
condition: {field: ...} | {value: ...},
value: ...,
}

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

condition:
One or more value definition(s) with a selection predicate.

__Note:__ A field definition's `condition` property can only contain [value
definitions](encoding.html#value-def)
since Vega-Lite only allows at most one encoded field per encoding channel.

A field definition or one or more value definition(s) with a selection predicate.

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

legend:
An object defining properties of the legend.
If `null`, the legend for the encoding channel will be removed.

__Default value:__ If undefined, default [legend properties](legend.html) are applied.

scale:
An object defining properties of the channel's scale, which is the function that
transforms values in the data domain (numbers, dates, strings, etc) to visual values
(pixels, colors, sizes) of the encoding channels.

__Default value:__ If undefined, default [scale properties](scale.html) are applied.

sort:
Sort order for the encoded field.
Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
For fields with discrete domains, `sort` can also be a [sort field definition
object](sort.html#sort-field).

__Default value:__ `"ascending"`

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

markPropDefWithConditionType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

value:
A constant value in visual domain.
-}
data MarkPropDefWithCondition = MarkPropDefWithCondition
    { aggregateMarkPropDefWithCondition :: Maybe AggregateOp
    , binMarkPropDefWithCondition :: Maybe Bin
    , conditionMarkPropDefWithCondition :: Maybe ColorCondition
    , fieldMarkPropDefWithCondition :: Maybe Field
    , legendMarkPropDefWithCondition :: Maybe (Maybe Legend)
    , scaleMarkPropDefWithCondition :: Maybe Scale
    , sortMarkPropDefWithCondition :: Maybe SortUnion
    , timeUnitMarkPropDefWithCondition :: Maybe TimeUnit
    , markPropDefWithConditionTypeMarkPropDefWithCondition :: Maybe Type
    , valueMarkPropDefWithCondition :: Maybe ConditionalValueDefValue
    } deriving (Show)

{-| Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
(e.g., `"count"`, `"mean"` and `"median"`).
This property is required in cases where the sort field and the data reference field do
not match.
The input data objects will be aggregated, grouped by the encoded data field.

For a full list of operations, please see the documentation for
[aggregate](aggregate.html#ops).

The aggregation operations to apply to the fields, such as sum, average or count.
See the [full list of supported aggregation
operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
for more information.
-}
data AggregateOp
    = ArgmaxAggregateOp
    | ArgminAggregateOp
    | AverageAggregateOp
    | CountAggregateOp
    | DistinctAggregateOp
    | MaxAggregateOp
    | MeanAggregateOp
    | MedianAggregateOp
    | MinAggregateOp
    | MissingAggregateOp
    | Q1AggregateOp
    | Q3AggregateOp
    | Ci0AggregateOp
    | Ci1AggregateOp
    | StdevAggregateOp
    | StdevpAggregateOp
    | SumAggregateOp
    | ValidAggregateOp
    | ValuesAggregateOp
    | VarianceAggregateOp
    | VariancepAggregateOp
    deriving (Show)

data Bin
    = BinParamsInBin BinParams
    | BoolInBin Bool
    deriving (Show)

{-| Binning properties or boolean flag for determining whether to bin data or not.

base:
The number base to use for automatic bin determination (default is base 10).

__Default value:__ `10`

divide:
Scale factors indicating allowable subdivisions. The default value is [5, 2], which
indicates that for base 10 numbers (the default base), the method may consider dividing
bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
given constraints.

__Default value:__ `[5, 2]`

extent:
A two-element (`[min, max]`) array indicating the range of desired bin values.

maxbins:
Maximum number of bins.

__Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels

minstep:
A minimum allowable step size (particularly useful for integer values).

nice:
If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
such as multiples of ten.

step:
An exact step size to use between bins.

__Note:__ If provided, options such as maxbins will be ignored.

steps:
An array of allowable step sizes to choose from.
-}
data BinParams = BinParams
    { baseBinParams :: Maybe Double
    , divideBinParams :: Maybe ([Double])
    , extentBinParams :: Maybe ([Double])
    , maxbinsBinParams :: Maybe Double
    , minstepBinParams :: Maybe Double
    , niceBinParams :: Maybe Bool
    , stepBinParams :: Maybe Double
    , stepsBinParams :: Maybe ([Double])
    } deriving (Show)

data ColorCondition
    = ConditionalPredicateMarkPropFieldDefClassInColorCondition ConditionalPredicateMarkPropFieldDefClass
    | ConditionalValueDefArrayInColorCondition ([ConditionalValueDef])
    deriving (Show)

{-| value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).

selection:
A [selection name](selection.html), or a series of [composed
selections](selection.html#compose).
-}
data ConditionalValueDef = ConditionalValueDef
    { testConditionalValueDef :: Maybe LogicalOperandPredicate
    , valueConditionalValueDef :: ConditionalValueDefValue
    , selectionConditionalValueDef :: Maybe SelectionOperand
    } deriving (Show)

data Selection = Selection
    { notSelection :: Maybe SelectionOperand
    , andSelection :: Maybe ([SelectionOperand])
    , orSelection :: Maybe ([SelectionOperand])
    } deriving (Show)

{-| Filter using a selection name.

A [selection name](selection.html), or a series of [composed
selections](selection.html#compose).
-}
data SelectionOperand
    = SelectionInSelectionOperand Selection
    | StringInSelectionOperand Text
    deriving (Show)

{-| equal:
The value that the field should be equal to.

field:
Field to be filtered.

Field to be filtered

timeUnit:
Time unit for the field to be filtered.

time unit for the field to be filtered.

range:
An array of inclusive minimum and maximum values
for a field value of a data item to be included in the filtered data.

oneOf:
A set of values that the `field`'s value should be a member of,
for a data item included in the filtered data.

selection:
Filter using a selection name.
-}
data Predicate = Predicate
    { notPredicate :: Maybe LogicalOperandPredicate
    , andPredicate :: Maybe ([LogicalOperandPredicate])
    , orPredicate :: Maybe ([LogicalOperandPredicate])
    , equalPredicate :: Maybe Equal
    , fieldPredicate :: Maybe Text
    , timeUnitPredicate :: Maybe TimeUnit
    , rangePredicate :: Maybe ([RangeElement])
    , oneOfPredicate :: Maybe ([Equal])
    , selectionPredicate :: Maybe SelectionOperand
    } deriving (Show)

{-| The `filter` property must be one of the predicate definitions:
(1) an [expression](types.html#expression) string,
where `datum` can be used to refer to the current data object;
(2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
[range predicate](filter.html#range-predicate), [one-of
predicate](filter.html#one-of-predicate);
(3) a [selection predicate](filter.html#selection-predicate);
or (4) a logical operand that combines (1), (2), or (3).
-}
data LogicalOperandPredicate
    = PredicateInLogicalOperandPredicate Predicate
    | StringInLogicalOperandPredicate Text
    deriving (Show)

{-| The value that the field should be equal to. -}

data Equal
    = BoolInEqual Bool
    | DateTimeInEqual DateTime
    | DoubleInEqual Double
    | StringInEqual Text
    deriving (Show)

{-| Object for defining datetime in Vega-Lite Filter.
If both month and quarter are provided, month has higher precedence.
`day` cannot be combined with other date.
We accept string for month and day names.

date:
Integer value representing the date from 1-31.

day:
Value representing the day of a week.  This can be one of: (1) integer value -- `1`
represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
DateTime definition object with `day`** should not be combined with `year`, `quarter`,
`month`, or `date`.

hours:
Integer value representing the hour of a day from 0-23.

milliseconds:
Integer value representing the millisecond segment of time.

minutes:
Integer value representing the minute segment of time from 0-59.

month:
One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
(2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
short month name (e.g., `"Jan"`).

quarter:
Integer value representing the quarter of the year (from 1-4).

seconds:
Integer value representing the second segment (0-59) of a time value

utc:
A boolean flag indicating if date time is in utc time. If false, the date time is in
local time

year:
Integer value representing the year.
-}
data DateTime = DateTime
    { dateDateTime :: Maybe Double
    , dayDateTime :: Maybe Day
    , hoursDateTime :: Maybe Double
    , millisecondsDateTime :: Maybe Double
    , minutesDateTime :: Maybe Double
    , monthDateTime :: Maybe Month
    , quarterDateTime :: Maybe Double
    , secondsDateTime :: Maybe Double
    , utcDateTime :: Maybe Bool
    , yearDateTime :: Maybe Double
    } deriving (Show)

{-| Value representing the day of a week.  This can be one of: (1) integer value -- `1`
represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
DateTime definition object with `day`** should not be combined with `year`, `quarter`,
`month`, or `date`.
-}
data Day
    = DoubleInDay Double
    | StringInDay Text
    deriving (Show)

{-| One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
(2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
short month name (e.g., `"Jan"`).
-}
data Month
    = DoubleInMonth Double
    | StringInMonth Text
    deriving (Show)

data RangeElement
    = DateTimeInRangeElement DateTime
    | DoubleInRangeElement Double
    | NullInRangeElement
    deriving (Show)

{-| Time unit for the field to be filtered.

time unit for the field to be filtered.

Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

The timeUnit.
-}
data TimeUnit
    = YearTimeUnit
    | QuarterTimeUnit
    | MonthTimeUnit
    | DayTimeUnit
    | DateTimeUnit
    | HoursTimeUnit
    | MinutesTimeUnit
    | SecondsTimeUnit
    | MillisecondsTimeUnit
    | UtcyearTimeUnit
    | UtcquarterTimeUnit
    | UtcmonthTimeUnit
    | UtcdayTimeUnit
    | UtcdateTimeUnit
    | UtchoursTimeUnit
    | UtcminutesTimeUnit
    | UtcsecondsTimeUnit
    | UtcmillisecondsTimeUnit
    | YearquarterTimeUnit
    | YearquartermonthTimeUnit
    | YearmonthTimeUnit
    | YearmonthdateTimeUnit
    | YearmonthdatehoursTimeUnit
    | YearmonthdatehoursminutesTimeUnit
    | YearmonthdatehoursminutessecondsTimeUnit
    | QuartermonthTimeUnit
    | MonthdateTimeUnit
    | HoursminutesTimeUnit
    | HoursminutessecondsTimeUnit
    | MinutessecondsTimeUnit
    | SecondsmillisecondsTimeUnit
    | UtcyearquarterTimeUnit
    | UtcyearquartermonthTimeUnit
    | UtcyearmonthTimeUnit
    | UtcyearmonthdateTimeUnit
    | UtcyearmonthdatehoursTimeUnit
    | UtcyearmonthdatehoursminutesTimeUnit
    | UtcyearmonthdatehoursminutessecondsTimeUnit
    | UtcquartermonthTimeUnit
    | UtcmonthdateTimeUnit
    | UtchoursminutesTimeUnit
    | UtchoursminutessecondsTimeUnit
    | UtcminutessecondsTimeUnit
    | UtcsecondsmillisecondsTimeUnit
    deriving (Show)

{-| A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).

A constant value in visual domain.
-}
data ConditionalValueDefValue
    = BoolInConditionalValueDefValue Bool
    | DoubleInConditionalValueDefValue Double
    | StringInConditionalValueDefValue Text
    deriving (Show)

{-| value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).

selection:
A [selection name](selection.html), or a series of [composed
selections](selection.html#compose).

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

legend:
An object defining properties of the legend.
If `null`, the legend for the encoding channel will be removed.

__Default value:__ If undefined, default [legend properties](legend.html) are applied.

scale:
An object defining properties of the channel's scale, which is the function that
transforms values in the data domain (numbers, dates, strings, etc) to visual values
(pixels, colors, sizes) of the encoding channels.

__Default value:__ If undefined, default [scale properties](scale.html) are applied.

sort:
Sort order for the encoded field.
Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
For fields with discrete domains, `sort` can also be a [sort field definition
object](sort.html#sort-field).

__Default value:__ `"ascending"`

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

conditionalDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data ConditionalPredicateMarkPropFieldDefClass = ConditionalPredicateMarkPropFieldDefClass
    { testConditionalPredicateMarkPropFieldDefClass :: Maybe LogicalOperandPredicate
    , valueConditionalPredicateMarkPropFieldDefClass :: Maybe ConditionalValueDefValue
    , selectionConditionalPredicateMarkPropFieldDefClass :: Maybe SelectionOperand
    , aggregateConditionalPredicateMarkPropFieldDefClass :: Maybe AggregateOp
    , binConditionalPredicateMarkPropFieldDefClass :: Maybe Bin
    , fieldConditionalPredicateMarkPropFieldDefClass :: Maybe Field
    , legendConditionalPredicateMarkPropFieldDefClass :: Maybe (Maybe Legend)
    , scaleConditionalPredicateMarkPropFieldDefClass :: Maybe Scale
    , sortConditionalPredicateMarkPropFieldDefClass :: Maybe SortUnion
    , timeUnitConditionalPredicateMarkPropFieldDefClass :: Maybe TimeUnit
    , conditionalDefTypeConditionalPredicateMarkPropFieldDefClass :: Maybe Type
    } deriving (Show)

{-| The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

Constants and utilities for data type
Data type based on level of measurement
-}
data Type
    = QuantitativeType
    | OrdinalType
    | TemporalType
    | NominalType
    | LatitudeType
    | LongitudeType
    | GeojsonType
    deriving (Show)

data Field
    = RepeatRefInField RepeatRef
    | StringInField Text
    deriving (Show)

{-| Reference to a repeated value. -}

data RepeatRef = RepeatRef
    { repeatRepeatRef :: RepeatEnum
    } deriving (Show)

data RepeatEnum
    = RowRepeatEnum
    | ColumnRepeatEnum
    deriving (Show)

{-| Properties of a legend or boolean flag for determining whether to show it.

entryPadding:
Padding (in pixels) between legend entries in a symbol legend.

format:
The formatting pattern for labels. This is D3's [number format
pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
field.

See the [format documentation](format.html) for more information.

__Default value:__  derived from [numberFormat](config.html#format) config for
quantitative fields and from [timeFormat](config.html#format) config for temporal fields.

offset:
The offset, in pixels, by which to displace the legend from the edge of the enclosing
group or data rectangle.

__Default value:__  `0`

orient:
The orientation of the legend, which determines how the legend is positioned within the
scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
"none".

__Default value:__ `"right"`

padding:
The padding, in pixels, between the legend and axis.

tickCount:
The desired number of tick values for quantitative legends.

title:
A title for the field. If `null`, the title will be removed.

__Default value:__  derived from the field's name and transformation function
(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
binned or has a time unit applied, the applied function will be denoted in parentheses
(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
simply the field name.

__Note__: You can customize the default field title format by providing the [`fieldTitle`
property in the [config](config.html) or [`fieldTitle` function via the `compile`
function's options](compile.html#field-title).

legendType:
The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
continuous color gradient.

__Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
`"symbol"` otherwise.

values:
Explicitly set the visible legend values.

zindex:
A non-positive integer indicating z-index of the legend.
If zindex is 0, legend should be drawn behind all chart elements.
To put them in front, use zindex = 1.
-}
data Legend = Legend
    { entryPaddingLegend :: Maybe Double
    , formatLegend :: Maybe Text
    , offsetLegend :: Maybe Double
    , orientLegend :: Maybe LegendOrient
    , paddingLegend :: Maybe Double
    , tickCountLegend :: Maybe Double
    , titleLegend :: Maybe (Maybe Text)
    , legendTypeLegend :: Maybe LegendType
    , valuesLegend :: Maybe ([LegendValue])
    , zindexLegend :: Maybe Double
    } deriving (Show)

{-| The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
continuous color gradient.

__Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
`"symbol"` otherwise.
-}
data LegendType
    = SymbolLegendType
    | GradientLegendType
    deriving (Show)

data LegendValue
    = DateTimeInLegendValue DateTime
    | DoubleInLegendValue Double
    | StringInLegendValue Text
    deriving (Show)

{-| An object defining properties of the channel's scale, which is the function that
transforms values in the data domain (numbers, dates, strings, etc) to visual values
(pixels, colors, sizes) of the encoding channels.

__Default value:__ If undefined, default [scale properties](scale.html) are applied.

base:
The logarithm base of the `log` scale (default `10`).

clamp:
If `true`, values that exceed the data domain are clamped to either the minimum or
maximum range value

__Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
(`true` by default).

domain:
Customized domain values.

For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
a `domain` with more than two entries.
If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
indicating that the domain should include the raw data values prior to the aggregation.

For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
the form of either timestamps or the [DateTime definition objects](types.html#datetime).

For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
values.

The `selection` property can be used to [interactively
determine](selection.html#scale-domains) the scale domain.

exponent:
The exponent of the `pow` scale.

interpolate:
The interpolation method for range values. By default, a general interpolator for
numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
property allows interpolation in alternative color spaces. Legal values include `rgb`,
`hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
variants use longer paths in polar coordinate spaces). If object-valued, this property
accepts an object with a string-valued _type_ property and an optional numeric _gamma_
property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
documentation](https://github.com/d3/d3-interpolate).

__Note:__ Sequential scales do not support `interpolate` as they have a fixed
interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
you have to set the scale `type` to other quantitative scale type such as `"linear"` to
customize `interpolate`.

nice:
Extending the domain so that it starts and ends on nice round values. This method
typically modifies the scale’s domain, and may only extend the bounds to the nearest
round value. Nicing is useful if the domain is computed from data and may be irregular.
For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
1.0]_.

For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
If `nice` is a number, it will represent a desired tick count. This allows greater
control over the step size used to extend the bounds, guaranteeing that the returned
ticks will exactly cover the domain.

For temporal fields with time and utc scales, the `nice` value can be a string indicating
the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
`"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
scales can accept an object-valued interval specifier of the form `{"interval": "month",
"step": 3}`, which includes a desired number of interval steps. Here, the domain would
snap to quarter (Jan, Apr, Jul, Oct) boundaries.

__Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.

padding:
For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
the specified number of pixels on each of the scale range. The scale range must represent
pixels for this parameter to function as intended. Padding adjustment is performed prior
to all other adjustments, including the effects of the zero, nice, domainMin, and
domainMax properties.

For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
`paddingOuter` to the same value.

For _[point](scale.html#point)_ scales, alias for `paddingOuter`.

__Default value:__ For _continuous_ scales, derived from the [scale
config](scale.html#config)'s `continuousPadding`.
For _band and point_ scales, see `paddingInner` and `paddingOuter`.

paddingInner:
The inner padding (spacing) within each band step of band scales, as a fraction of the
step size. This value must lie in the range [0,1].

For point scale, this property is invalid as point scales do not have internal band
widths (only step sizes between bands).

__Default value:__ derived from the [scale config](scale.html#config)'s
`bandPaddingInner`.

paddingOuter:
The outer padding (spacing) at the ends of the range of band and point scales,
as a fraction of the step size. This value must lie in the range [0,1].

__Default value:__ derived from the [scale config](scale.html#config)'s
`bandPaddingOuter` for band scales and `pointPadding` for point scales.

range:
The range of the scale. One of:

- A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
example, `"symbol"`, or `"diverging"`).

- For [continuous scales](scale.html#continuous), two-element array indicating  minimum
and maximum values, or an array with more than two entries for specifying a [piecewise
scale](scale.html#piecewise).

- For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
an array of desired output values.

__Notes:__

1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
instead of `range`.

2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
customized via the view's corresponding [size](size.html) (`width` and `height`) or via
[range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
scales.

rangeStep:
The distance between the starts of adjacent bands or points in [band](scale.html#band)
and [point](scale.html#point) scales.

If `rangeStep` is `null` or if the view contains the scale's corresponding
[size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
be automatically determined to fit the size of the view.

__Default value:__  derived the [scale config](config.html#scale-config)'s
`textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
default) for x-scales of other marks and y-scales.

__Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
than `width` or `height`, the rangeStep might become less than one pixel and the mark
might not appear correctly.

round:
If `true`, rounds numeric output values to integers. This can be helpful for snapping to
the pixel grid.

__Default value:__ `false`.

scheme:
A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
`"viridis"`) or a [scheme parameter object](scale.html#scheme-params).

Discrete color schemes may be used with [discrete](scale.html#discrete) or
[discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
use with [sequential](scales.html#sequential) scales.

For the full list of supported scheme, please refer to the [Vega
Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.

scaleType:
The type of scale.  Vega-Lite supports the following categories of scale types:

1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
[`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
[`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).

2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
[`"point"`](scale.html#point)) output ranges.

3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
[`"bin-ordinal"`](scale.html#bin-ordinal)).

__Default value:__ please see the [scale type table](scale.html#type).

zero:
If `true`, ensures that a zero baseline value is included in the scale domain.

__Default value:__ `true` for x and y channels if the quantitative field is not binned
and no custom `domain` is provided; `false` otherwise.

__Note:__ Log, time, and utc scales do not support `zero`.
-}
data Scale = Scale
    { baseScale :: Maybe Double
    , clampScale :: Maybe Bool
    , domainScale :: Maybe DomainUnion
    , exponentScale :: Maybe Double
    , interpolateScale :: Maybe InterpolateUnion
    , niceScale :: Maybe NiceUnion
    , paddingScale :: Maybe Double
    , paddingInnerScale :: Maybe Double
    , paddingOuterScale :: Maybe Double
    , rangeScale :: Maybe ScaleRange
    , rangeStepScale :: Maybe (Maybe Double)
    , roundScale :: Maybe Bool
    , schemeScale :: Maybe Scheme
    , scaleTypeScale :: Maybe ScaleType
    , zeroScale :: Maybe Bool
    } deriving (Show)

{-| Customized domain values.

For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
a `domain` with more than two entries.
If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
indicating that the domain should include the raw data values prior to the aggregation.

For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
the form of either timestamps or the [DateTime definition objects](types.html#datetime).

For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
values.

The `selection` property can be used to [interactively
determine](selection.html#scale-domains) the scale domain.
-}
data DomainUnion
    = DomainClassInDomainUnion DomainClass
    | EnumInDomainUnion Domain
    | UnionArrayInDomainUnion ([Equal])
    deriving (Show)

{-| field:
The field name to extract selected values for, when a selection is
[projected](project.html)
over multiple fields or encodings.

selection:
The name of a selection.

encoding:
The encoding channel to extract selected values for, when a selection is
[projected](project.html)
over multiple fields or encodings.
-}
data DomainClass = DomainClass
    { fieldDomainClass :: Maybe Text
    , selectionDomainClass :: Text
    , encodingDomainClass :: Maybe Text
    } deriving (Show)

data Domain
    = UnaggregatedDomain
    deriving (Show)

{-| The interpolation method for range values. By default, a general interpolator for
numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
property allows interpolation in alternative color spaces. Legal values include `rgb`,
`hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
variants use longer paths in polar coordinate spaces). If object-valued, this property
accepts an object with a string-valued _type_ property and an optional numeric _gamma_
property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
documentation](https://github.com/d3/d3-interpolate).

__Note:__ Sequential scales do not support `interpolate` as they have a fixed
interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
you have to set the scale `type` to other quantitative scale type such as `"linear"` to
customize `interpolate`.
-}
data InterpolateUnion
    = EnumInInterpolateUnion Interpolate
    | InterpolateParamsInInterpolateUnion InterpolateParams
    deriving (Show)

data InterpolateParams = InterpolateParams
    { gammaInterpolateParams :: Maybe Double
    , interpolateParamsTypeInterpolateParams :: InterpolateParamsType
    } deriving (Show)

data InterpolateParamsType
    = RGBInterpolateParamsType
    | CubehelixInterpolateParamsType
    | CubehelixLongInterpolateParamsType
    deriving (Show)

{-| Extending the domain so that it starts and ends on nice round values. This method
typically modifies the scale’s domain, and may only extend the bounds to the nearest
round value. Nicing is useful if the domain is computed from data and may be irregular.
For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
1.0]_.

For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
If `nice` is a number, it will represent a desired tick count. This allows greater
control over the step size used to extend the bounds, guaranteeing that the returned
ticks will exactly cover the domain.

For temporal fields with time and utc scales, the `nice` value can be a string indicating
the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
`"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
scales can accept an object-valued interval specifier of the form `{"interval": "month",
"step": 3}`, which includes a desired number of interval steps. Here, the domain would
snap to quarter (Jan, Apr, Jul, Oct) boundaries.

__Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
-}
data NiceUnion
    = BoolInNiceUnion Bool
    | DoubleInNiceUnion Double
    | EnumInNiceUnion NiceTime
    | NiceClassInNiceUnion NiceClass
    deriving (Show)

data NiceClass = NiceClass
    { intervalNiceClass :: Text
    , stepNiceClass :: Double
    } deriving (Show)

data NiceTime
    = SecondNiceTime
    | MinuteNiceTime
    | HourNiceTime
    | DayNiceTime
    | WeekNiceTime
    | MonthNiceTime
    | YearNiceTime
    deriving (Show)

{-| The range of the scale. One of:

- A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
example, `"symbol"`, or `"diverging"`).

- For [continuous scales](scale.html#continuous), two-element array indicating  minimum
and maximum values, or an array with more than two entries for specifying a [piecewise
scale](scale.html#piecewise).

- For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
an array of desired output values.

__Notes:__

1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
instead of `range`.

2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
customized via the view's corresponding [size](size.html) (`width` and `height`) or via
[range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
scales.
-}
data ScaleRange
    = StringInScaleRange Text
    | UnionArrayInScaleRange ([TitleFontWeight])
    deriving (Show)

{-| The type of scale.  Vega-Lite supports the following categories of scale types:

1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
[`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
[`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).

2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
[`"point"`](scale.html#point)) output ranges.

3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
[`"bin-ordinal"`](scale.html#bin-ordinal)).

__Default value:__ please see the [scale type table](scale.html#type).
-}
data ScaleType
    = LinearScaleType
    | BinLinearScaleType
    | LogScaleType
    | PowScaleType
    | SqrtScaleType
    | TimeScaleType
    | UTCScaleType
    | SequentialScaleType
    | OrdinalScaleType
    | BinOrdinalScaleType
    | PointScaleType
    | BandScaleType
    deriving (Show)

{-| A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
`"viridis"`) or a [scheme parameter object](scale.html#scheme-params).

Discrete color schemes may be used with [discrete](scale.html#discrete) or
[discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
use with [sequential](scales.html#sequential) scales.

For the full list of supported scheme, please refer to the [Vega
Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
-}
data Scheme
    = SchemeParamsInScheme SchemeParams
    | StringInScheme Text
    deriving (Show)

{-| extent:
For sequential and diverging schemes only, determines the extent of the color range to
use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
range _[0, 0.2)_ are excluded from the scheme.

name:
A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).

For the full list of supported scheme, please refer to the [Vega
Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
-}
data SchemeParams = SchemeParams
    { extentSchemeParams :: Maybe ([Double])
    , nameSchemeParams :: Text
    } deriving (Show)

data SortUnion
    = EnumInSortUnion SortEnum
    | NullInSortUnion
    | SortFieldInSortUnion SortField
    deriving (Show)

{-| field:
The data [field](field.html) to sort by.

__Default value:__ If unspecified, defaults to the field specified in the outer data
reference.

op:
An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
(e.g., `"count"`, `"mean"` and `"median"`).
This property is required in cases where the sort field and the data reference field do
not match.
The input data objects will be aggregated, grouped by the encoded data field.

For a full list of operations, please see the documentation for
[aggregate](aggregate.html#ops).

order:
The sort order. One of `"ascending"` (default) or `"descending"`.
-}
data SortField = SortField
    { fieldSortField :: Maybe Field
    , opSortField :: AggregateOp
    , orderSortField :: Maybe (Maybe SortEnum)
    } deriving (Show)

data SortEnum
    = AscendingSortEnum
    | DescendingSortEnum
    deriving (Show)

{-| Horizontal facets for trellis plots.

Vertical facets for trellis plots.

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

header:
An object defining properties of a facet's header.

sort:
Sort order for a facet field.
This can be `"ascending"`, `"descending"`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

facetFieldDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data FacetFieldDef = FacetFieldDef
    { aggregateFacetFieldDef :: Maybe AggregateOp
    , binFacetFieldDef :: Maybe Bin
    , fieldFacetFieldDef :: Maybe Field
    , headerFacetFieldDef :: Maybe Header
    , sortFacetFieldDef :: Maybe (Maybe SortEnum)
    , timeUnitFacetFieldDef :: Maybe TimeUnit
    , facetFieldDefTypeFacetFieldDef :: Type
    } deriving (Show)

{-| An object defining properties of a facet's header.

Headers of row / column channels for faceted plots.

format:
The formatting pattern for labels. This is D3's [number format
pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
field.

See the [format documentation](format.html) for more information.

__Default value:__  derived from [numberFormat](config.html#format) config for
quantitative fields and from [timeFormat](config.html#format) config for temporal fields.

labelAngle:
The rotation angle of the header labels.

__Default value:__ `0`.

title:
A title for the field. If `null`, the title will be removed.

__Default value:__  derived from the field's name and transformation function
(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
binned or has a time unit applied, the applied function will be denoted in parentheses
(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
simply the field name.

__Note__: You can customize the default field title format by providing the [`fieldTitle`
property in the [config](config.html) or [`fieldTitle` function via the `compile`
function's options](compile.html#field-title).
-}
data Header = Header
    { formatHeader :: Maybe Text
    , labelAngleHeader :: Maybe Double
    , titleHeader :: Maybe (Maybe Text)
    } deriving (Show)

data Detail
    = FieldDefArrayInDetail ([FieldDef])
    | FieldDefInDetail FieldDef
    deriving (Show)

{-| Definition object for a data field, its type and transformation of an encoding channel.

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

fieldDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data FieldDef = FieldDef
    { aggregateFieldDef :: Maybe AggregateOp
    , binFieldDef :: Maybe Bin
    , fieldFieldDef :: Maybe Field
    , timeUnitFieldDef :: Maybe TimeUnit
    , fieldDefTypeFieldDef :: Type
    } deriving (Show)

{-| Text of the `text` mark.

The tooltip text to show upon mouse hover.

A FieldDef with Condition<ValueDef>
{
condition: {value: ...},
field: ...,
...
}

A ValueDef with Condition<ValueDef | FieldDef>
{
condition: {field: ...} | {value: ...},
value: ...,
}

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

condition:
One or more value definition(s) with a selection predicate.

__Note:__ A field definition's `condition` property can only contain [value
definitions](encoding.html#value-def)
since Vega-Lite only allows at most one encoded field per encoding channel.

A field definition or one or more value definition(s) with a selection predicate.

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

format:
The [formatting pattern](format.html) for a text field. If not defined, this will be
determined automatically.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

textDefWithConditionType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

value:
A constant value in visual domain.
-}
data TextDefWithCondition = TextDefWithCondition
    { aggregateTextDefWithCondition :: Maybe AggregateOp
    , binTextDefWithCondition :: Maybe Bin
    , conditionTextDefWithCondition :: Maybe TextCondition
    , fieldTextDefWithCondition :: Maybe Field
    , formatTextDefWithCondition :: Maybe Text
    , timeUnitTextDefWithCondition :: Maybe TimeUnit
    , textDefWithConditionTypeTextDefWithCondition :: Maybe Type
    , valueTextDefWithCondition :: Maybe ConditionalValueDefValue
    } deriving (Show)

data TextCondition
    = ConditionalPredicateTextFieldDefClassInTextCondition ConditionalPredicateTextFieldDefClass
    | ConditionalValueDefArrayInTextCondition ([ConditionalValueDef])
    deriving (Show)

{-| value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).

selection:
A [selection name](selection.html), or a series of [composed
selections](selection.html#compose).

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

format:
The [formatting pattern](format.html) for a text field. If not defined, this will be
determined automatically.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

conditionalDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data ConditionalPredicateTextFieldDefClass = ConditionalPredicateTextFieldDefClass
    { testConditionalPredicateTextFieldDefClass :: Maybe LogicalOperandPredicate
    , valueConditionalPredicateTextFieldDefClass :: Maybe ConditionalValueDefValue
    , selectionConditionalPredicateTextFieldDefClass :: Maybe SelectionOperand
    , aggregateConditionalPredicateTextFieldDefClass :: Maybe AggregateOp
    , binConditionalPredicateTextFieldDefClass :: Maybe Bin
    , fieldConditionalPredicateTextFieldDefClass :: Maybe Field
    , formatConditionalPredicateTextFieldDefClass :: Maybe Text
    , timeUnitConditionalPredicateTextFieldDefClass :: Maybe TimeUnit
    , conditionalDefTypeConditionalPredicateTextFieldDefClass :: Maybe Type
    } deriving (Show)

{-| A URL to load upon mouse click.

A FieldDef with Condition<ValueDef>
{
condition: {value: ...},
field: ...,
...
}

A ValueDef with Condition<ValueDef | FieldDef>
{
condition: {field: ...} | {value: ...},
value: ...,
}

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

condition:
One or more value definition(s) with a selection predicate.

__Note:__ A field definition's `condition` property can only contain [value
definitions](encoding.html#value-def)
since Vega-Lite only allows at most one encoded field per encoding channel.

A field definition or one or more value definition(s) with a selection predicate.

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

defWithConditionType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

value:
A constant value in visual domain.
-}
data DefWithCondition = DefWithCondition
    { aggregateDefWithCondition :: Maybe AggregateOp
    , binDefWithCondition :: Maybe Bin
    , conditionDefWithCondition :: Maybe HrefCondition
    , fieldDefWithCondition :: Maybe Field
    , timeUnitDefWithCondition :: Maybe TimeUnit
    , defWithConditionTypeDefWithCondition :: Maybe Type
    , valueDefWithCondition :: Maybe ConditionalValueDefValue
    } deriving (Show)

data HrefCondition
    = ConditionalPredicateFieldDefClassInHrefCondition ConditionalPredicateFieldDefClass
    | ConditionalValueDefArrayInHrefCondition ([ConditionalValueDef])
    deriving (Show)

{-| value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).

selection:
A [selection name](selection.html), or a series of [composed
selections](selection.html#compose).

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

conditionalDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data ConditionalPredicateFieldDefClass = ConditionalPredicateFieldDefClass
    { testConditionalPredicateFieldDefClass :: Maybe LogicalOperandPredicate
    , valueConditionalPredicateFieldDefClass :: Maybe ConditionalValueDefValue
    , selectionConditionalPredicateFieldDefClass :: Maybe SelectionOperand
    , aggregateConditionalPredicateFieldDefClass :: Maybe AggregateOp
    , binConditionalPredicateFieldDefClass :: Maybe Bin
    , fieldConditionalPredicateFieldDefClass :: Maybe Field
    , timeUnitConditionalPredicateFieldDefClass :: Maybe TimeUnit
    , conditionalDefTypeConditionalPredicateFieldDefClass :: Maybe Type
    } deriving (Show)

data Order
    = OrderFieldDefArrayInOrder ([OrderFieldDef])
    | OrderFieldDefInOrder OrderFieldDef
    deriving (Show)

{-| aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

sort:
The sort order. One of `"ascending"` (default) or `"descending"`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

orderFieldDefType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.
-}
data OrderFieldDef = OrderFieldDef
    { aggregateOrderFieldDef :: Maybe AggregateOp
    , binOrderFieldDef :: Maybe Bin
    , fieldOrderFieldDef :: Maybe Field
    , sortOrderFieldDef :: Maybe (Maybe SortEnum)
    , timeUnitOrderFieldDef :: Maybe TimeUnit
    , orderFieldDefTypeOrderFieldDef :: Type
    } deriving (Show)

{-| X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.

Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.

Definition object for a constant value of an encoding channel.

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

axis:
An object defining properties of axis's gridlines, ticks and labels.
If `null`, the axis for the encoding channel will be removed.

__Default value:__ If undefined, default [axis properties](axis.html) are applied.

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

scale:
An object defining properties of the channel's scale, which is the function that
transforms values in the data domain (numbers, dates, strings, etc) to visual values
(pixels, colors, sizes) of the encoding channels.

__Default value:__ If undefined, default [scale properties](scale.html) are applied.

sort:
Sort order for the encoded field.
Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
For fields with discrete domains, `sort` can also be a [sort field definition
object](sort.html#sort-field).

__Default value:__ `"ascending"`

stack:
Type of stacking offset if the field should be stacked.
`stack` is only applicable for `x` and `y` channels with continuous domains.
For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.

`stack` can be one of the following values:

- `"zero"`: stacking with baseline offset at zero value of the scale (for creating
typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
- `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
and area charts](stack.html#normalized). <br/>
- `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
- `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
area chart.

__Default value:__ `zero` for plots with all of the following conditions are true:

1. The mark is `bar` or `area`;
2. The stacked measure channel (x or y) has a linear scale;
3. At least one of non-position channels mapped to an unaggregated field that is
different from x and y.  Otherwise, `null` by default.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

defType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).
-}
data XClass = XClass
    { aggregateXClass :: Maybe AggregateOp
    , axisXClass :: Maybe (Maybe Axis)
    , binXClass :: Maybe Bin
    , fieldXClass :: Maybe Field
    , scaleXClass :: Maybe Scale
    , sortXClass :: Maybe SortUnion
    , stackXClass :: Maybe (Maybe StackOffset)
    , timeUnitXClass :: Maybe TimeUnit
    , defTypeXClass :: Maybe Type
    , valueXClass :: Maybe ConditionalValueDefValue
    } deriving (Show)

{-| domain:
A boolean flag indicating if the domain (the axis baseline) should be included as part of
the axis.

__Default value:__ `true`

format:
The formatting pattern for labels. This is D3's [number format
pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
field.

See the [format documentation](format.html) for more information.

__Default value:__  derived from [numberFormat](config.html#format) config for
quantitative fields and from [timeFormat](config.html#format) config for temporal fields.

grid:
A boolean flag indicating if grid lines should be included as part of the axis

__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
binned; otherwise, `false`.

labelAngle:
The rotation angle of the axis labels.

__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.

labelBound:
Indicates if labels should be hidden if they exceed the axis range. If `false `(the
default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
they exceed the axis range by more than 1 pixel. If this property is a number, it
specifies the pixel tolerance: the maximum amount by which a label bounding box may
exceed the axis range.

__Default value:__ `false`.

labelFlush:
Indicates if the first and last axis labels should be aligned flush with the scale range.
Flush alignment for a horizontal axis will left-align the first label and right-align the
last label. For vertical axes, bottom and top text baselines are applied instead. If this
property is a number, it also indicates the number of pixels by which to offset the first
and last labels; for example, a value of 2 will flush-align the first and last labels and
also push them 2 pixels outward from the center of the axis. The additional adjustment
can sometimes help the labels better visually group with corresponding axis ticks.

__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.

labelOverlap:
The strategy to use for resolving overlap of axis labels. If `false` (the default), no
overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
every other label is used (this works well for standard linear axes). If set to
`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
with the last visible label (this often works better for log-scaled axes).

__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
scales; otherwise `false`.

labelPadding:
The padding, in pixels, between axis and text labels.

labels:
A boolean flag indicating if labels should be included as part of the axis.

__Default value:__  `true`.

maxExtent:
The maximum extent in pixels that axis ticks and labels should use. This determines a
maximum offset value for axis titles.

__Default value:__ `undefined`.

minExtent:
The minimum extent in pixels that axis ticks and labels should use. This determines a
minimum offset value for axis titles.

__Default value:__ `30` for y-axis; `undefined` for x-axis.

offset:
The offset, in pixels, by which to displace the axis from the edge of the enclosing group
or data rectangle.

__Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
`offset` (`0` by default)

orient:
The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
orientation can be used to further specialize the axis type (e.g., a y axis oriented for
the right edge of the chart).

__Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.

position:
The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
this sets the axis group x coordinate. For y-axis with left or right orientation, this
sets the axis group y coordinate.

__Default value__: `0`

tickCount:
A desired number of ticks, for axes visualizing quantitative scales. The resulting number
may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
underlying scale's range.

ticks:
Boolean value that determines whether the axis should include ticks.

tickSize:
The size in pixels of axis ticks.

title:
A title for the field. If `null`, the title will be removed.

__Default value:__  derived from the field's name and transformation function
(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
binned or has a time unit applied, the applied function will be denoted in parentheses
(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
simply the field name.

__Note__: You can customize the default field title format by providing the [`fieldTitle`
property in the [config](config.html) or [`fieldTitle` function via the `compile`
function's options](compile.html#field-title).

titleMaxLength:
Max length for axis title if the title is automatically generated from the field's
description.

titlePadding:
The padding, in pixels, between title and axis.

values:
Explicitly set the visible axis tick values.

zindex:
A non-positive integer indicating z-index of the axis.
If zindex is 0, axes should be drawn behind all chart elements.
To put them in front, use `"zindex = 1"`.

__Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
for grids.
-}
data Axis = Axis
    { domainAxis :: Maybe Bool
    , formatAxis :: Maybe Text
    , gridAxis :: Maybe Bool
    , labelAngleAxis :: Maybe Double
    , labelBoundAxis :: Maybe Label
    , labelFlushAxis :: Maybe Label
    , labelOverlapAxis :: Maybe LabelOverlapUnion
    , labelPaddingAxis :: Maybe Double
    , labelsAxis :: Maybe Bool
    , maxExtentAxis :: Maybe Double
    , minExtentAxis :: Maybe Double
    , offsetAxis :: Maybe Double
    , orientAxis :: Maybe TitleOrient
    , positionAxis :: Maybe Double
    , tickCountAxis :: Maybe Double
    , ticksAxis :: Maybe Bool
    , tickSizeAxis :: Maybe Double
    , titleAxis :: Maybe (Maybe Text)
    , titleMaxLengthAxis :: Maybe Double
    , titlePaddingAxis :: Maybe Double
    , valuesAxis :: Maybe ([AxisValue])
    , zindexAxis :: Maybe Double
    } deriving (Show)

data AxisValue
    = DateTimeInAxisValue DateTime
    | DoubleInAxisValue Double
    deriving (Show)

{-| X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.

Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.

Definition object for a data field, its type and transformation of an encoding channel.

Definition object for a constant value of an encoding channel.

aggregate:
Aggregation function for the field
(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).

__Default value:__ `undefined` (None)

bin:
A flag for binning a `quantitative` field, or [an object defining binning
parameters](bin.html#params).
If `true`, default [binning parameters](bin.html) will be applied.

__Default value:__ `false`

field:
__Required.__ A string defining the name of the field from which to pull a data value
or an object defining iterated values from the [`repeat`](repeat.html) operator.

__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
If field names contain dots or brackets but are not nested, you can use `\\` to escape
dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
See more details about escaping in the [field documentation](field.html).

__Note:__ `field` is not required if `aggregate` is `count`.

timeUnit:
Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
or [a temporal field that gets casted as ordinal](type.html#cast).

__Default value:__ `undefined` (None)

defType:
The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
`"nominal"`).
It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
[geographic projection](projection.html) is applied.

value:
A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
`0` to `1` for opacity).
-}
data X2Class = X2Class
    { aggregateX2Class :: Maybe AggregateOp
    , binX2Class :: Maybe Bin
    , fieldX2Class :: Maybe Field
    , timeUnitX2Class :: Maybe TimeUnit
    , defTypeX2Class :: Maybe Type
    , valueX2Class :: Maybe ConditionalValueDefValue
    } deriving (Show)

{-| An object that describes mappings between `row` and `column` channels and their field
definitions.

column:
Horizontal facets for trellis plots.

row:
Vertical facets for trellis plots.
-}
data FacetMapping = FacetMapping
    { columnFacetMapping :: Maybe FacetFieldDef
    , rowFacetMapping :: Maybe FacetFieldDef
    } deriving (Show)

{-| Unit spec that can have a composite mark.

specData:
An object describing the data source

description:
Description of this mark for commenting purpose.

height:
The height of a visualization.

__Default value:__
- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
[continuous scale](scale.html#continuous), the height will be the value of
[`config.view.height`](spec.html#config).
- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the height is [determined by the range step, paddings, and the
cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
`rangeStep` is `null`, the height will be the value of
[`config.view.height`](spec.html#config).
- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.

__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
represents the height of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

layer:
Layer or single view specifications to be layered.

__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
layering facet specifications is not allowed.

name:
Name of the visualization for later reference.

resolve:
Scale, axis, and legend resolutions for layers.

Scale, axis, and legend resolutions for facets.

Scale and legend resolutions for repeated charts.

Scale, axis, and legend resolutions for vertically concatenated charts.

Scale, axis, and legend resolutions for horizontally concatenated charts.

title:
Title for the plot.

transform:
An array of data transformations such as filter and new field calculation.

width:
The width of a visualization.

__Default value:__ This will be determined by the following rules:

- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
[continuous scale](scale.html#continuous), the width will be the value of
[`config.view.width`](spec.html#config).
- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the width is [determined by the range step, paddings, and the
cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
`rangeStep` is `null`, the width will be the value of
[`config.view.width`](spec.html#config).
- If no field is mapped to `x` channel, the `width` will be the value of
[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
the value of `rangeStep` for other marks.

__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
represents the width of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

encoding:
A key-value mapping between encoding channels and definition of fields.

mark:
A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
`"line"`,
* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
object](mark.html#mark-def).

projection:
An object defining properties of geographic projection.

Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.

selection:
A key-value mapping between selection names and definitions.

facet:
An object that describes mappings between `row` and `column` channels and their field
definitions.

spec:
A specification of the view that gets faceted.

repeat:
An object that describes what fields should be repeated into views that are laid out as a
`row` or `column`.

vconcat:
A list of views that should be concatenated and put into a column.

hconcat:
A list of views that should be concatenated and put into a row.
-}
data Spec = Spec
    { specDataSpec :: Maybe Data
    , descriptionSpec :: Maybe Text
    , heightSpec :: Maybe Double
    , layerSpec :: Maybe ([LayerSpec])
    , nameSpec :: Maybe Text
    , resolveSpec :: Maybe Resolve
    , titleSpec :: Maybe Title
    , transformSpec :: Maybe ([Transform])
    , widthSpec :: Maybe Double
    , encodingSpec :: Maybe Encoding
    , markSpec :: Maybe AnyMark
    , projectionSpec :: Maybe Projection
    , selectionSpec :: Maybe (HashMap Text SelectionDef)
    , facetSpec :: Maybe FacetMapping
    , specSpec :: Maybe Spec
    , repeatSpec :: Maybe Repeat
    , vconcatSpec :: Maybe ([Spec])
    , hconcatSpec :: Maybe ([Spec])
    } deriving (Show)

{-| A key-value mapping between encoding channels and definition of fields.

color:
Color of the marks – either fill or stroke color based on mark type.
By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.

__Default value:__ If undefined, the default color depends on [mark
config](config.html#mark)'s `color` property.

_Note:_ See the scale documentation for more information about customizing [color
scheme](scale.html#scheme).

detail:
Additional levels of detail for grouping data in aggregate views and
in line and area marks without mapping data to a specific visual channel.

href:
A URL to load upon mouse click.

opacity:
Opacity of the marks – either can be a value or a range.

__Default value:__ If undefined, the default opacity depends on [mark
config](config.html#mark)'s `opacity` property.

order:
Stack order for stacked marks or order of data points in line marks for connected scatter
plots.

__Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
additional aggregation grouping.

shape:
For `point` marks the supported values are
`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
or `"triangle-down"`, or else a custom SVG path string.
For `geoshape` marks it should be a field definition of the geojson data

__Default value:__ If undefined, the default shape depends on [mark
config](config.html#point-config)'s `shape` property.

size:
Size of the mark.
- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
- For `"bar"` and `"tick"` – the bar and tick's size.
- For `"text"` – the text's font size.
- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.

encodingText:
Text of the `text` mark.

tooltip:
The tooltip text to show upon mouse hover.

x:
X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.

x2:
X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.

y:
Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.

y2:
Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
-}
data Encoding = Encoding
    { colorEncoding :: Maybe MarkPropDefWithCondition
    , detailEncoding :: Maybe Detail
    , hrefEncoding :: Maybe DefWithCondition
    , opacityEncoding :: Maybe MarkPropDefWithCondition
    , orderEncoding :: Maybe Order
    , shapeEncoding :: Maybe MarkPropDefWithCondition
    , sizeEncoding :: Maybe MarkPropDefWithCondition
    , encodingTextEncoding :: Maybe TextDefWithCondition
    , tooltipEncoding :: Maybe TextDefWithCondition
    , xEncoding :: Maybe XClass
    , x2Encoding :: Maybe X2Class
    , yEncoding :: Maybe XClass
    , y2Encoding :: Maybe X2Class
    } deriving (Show)

{-| Unit spec that can have a composite mark.

layerSpecData:
An object describing the data source

description:
Description of this mark for commenting purpose.

height:
The height of a visualization.

__Default value:__
- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
[continuous scale](scale.html#continuous), the height will be the value of
[`config.view.height`](spec.html#config).
- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the height is [determined by the range step, paddings, and the
cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
`rangeStep` is `null`, the height will be the value of
[`config.view.height`](spec.html#config).
- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.

__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
represents the height of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

layer:
Layer or single view specifications to be layered.

__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
layering facet specifications is not allowed.

name:
Name of the visualization for later reference.

resolve:
Scale, axis, and legend resolutions for layers.

title:
Title for the plot.

transform:
An array of data transformations such as filter and new field calculation.

width:
The width of a visualization.

__Default value:__ This will be determined by the following rules:

- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
[continuous scale](scale.html#continuous), the width will be the value of
[`config.view.width`](spec.html#config).
- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
value or unspecified, the width is [determined by the range step, paddings, and the
cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
`rangeStep` is `null`, the width will be the value of
[`config.view.width`](spec.html#config).
- If no field is mapped to `x` channel, the `width` will be the value of
[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
the value of `rangeStep` for other marks.

__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
represents the width of a single view.

__See also:__ The documentation for [width and height](size.html) contains more examples.

encoding:
A key-value mapping between encoding channels and definition of fields.

mark:
A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
`"line"`,
* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
object](mark.html#mark-def).

projection:
An object defining properties of geographic projection.

Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.

selection:
A key-value mapping between selection names and definitions.
-}
data LayerSpec = LayerSpec
    { layerSpecDataLayerSpec :: Maybe Data
    , descriptionLayerSpec :: Maybe Text
    , heightLayerSpec :: Maybe Double
    , layerLayerSpec :: Maybe ([LayerSpec])
    , nameLayerSpec :: Maybe Text
    , resolveLayerSpec :: Maybe Resolve
    , titleLayerSpec :: Maybe Title
    , transformLayerSpec :: Maybe ([Transform])
    , widthLayerSpec :: Maybe Double
    , encodingLayerSpec :: Maybe Encoding
    , markLayerSpec :: Maybe AnyMark
    , projectionLayerSpec :: Maybe Projection
    , selectionLayerSpec :: Maybe (HashMap Text SelectionDef)
    } deriving (Show)

{-| An object describing the data source

Secondary data source to lookup in.

format:
An object that specifies the format for parsing the data file.

An object that specifies the format for parsing the data values.

An object that specifies the format for parsing the data.

url:
An URL from which to load the data set. Use the `format.type` property
to ensure the loaded data is correctly parsed.

values:
The full data set, included inline. This can be an array of objects or primitive values
or a string.
Arrays of primitive values are ingested as objects with a `data` property. Strings are
parsed according to the specified format type.

name:
Provide a placeholder name and bind data at runtime.
-}
data Data = Data
    { formatData :: Maybe DataFormat
    , urlData :: Maybe Text
    , valuesData :: Maybe Values
    , nameData :: Maybe Text
    } deriving (Show)

{-| An object that specifies the format for parsing the data file.

An object that specifies the format for parsing the data values.

An object that specifies the format for parsing the data.

parse:
If set to auto (the default), perform automatic type inference to determine the desired
data types.
Alternatively, a parsing directive object can be provided for explicit data types. Each
property of the object corresponds to a field name, and the value to the desired data
type (one of `"number"`, `"boolean"` or `"date"`).
For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
input record a Date value.

For `"date"`, we parse data based using Javascript's
[`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
[d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
[UTC time](timeunit.html#utc)

dataFormatType:
Type of input data: `"json"`, `"csv"`, `"tsv"`.
The default format type is determined by the extension of the file URL.
If no extension is detected, `"json"` will be used by default.

property:
The JSON property containing the desired data.
This parameter can be used when the loaded JSON file may have surrounding structure or
meta-data.
For example `"property": "values.features"` is equivalent to retrieving
`json.values.features`
from the loaded JSON object.

feature:
The name of the TopoJSON object set to convert to a GeoJSON feature collection.
For example, in a map of the world, there may be an object set named `"countries"`.
Using the feature property, we can extract this set and generate a GeoJSON feature object
for each country.

mesh:
The name of the TopoJSON object set to convert to mesh.
Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
Unlike the `feature` option, the corresponding geo data is returned as a single, unified
mesh instance, not as individual GeoJSON features.
Extracting a mesh is useful for more efficiently drawing borders or other geographic
elements that you do not need to associate with specific regions such as individual
countries, states or counties.
-}
data DataFormat = DataFormat
    { parseDataFormat :: Maybe ParseUnion
    , dataFormatTypeDataFormat :: Maybe DataFormatType
    , propertyDataFormat :: Maybe Text
    , featureDataFormat :: Maybe Text
    , meshDataFormat :: Maybe Text
    } deriving (Show)

{-| Type of input data: `"json"`, `"csv"`, `"tsv"`.
The default format type is determined by the extension of the file URL.
If no extension is detected, `"json"` will be used by default.
-}
data DataFormatType
    = CSVDataFormatType
    | TsvDataFormatType
    | JSONDataFormatType
    | TopojsonDataFormatType
    deriving (Show)

data ParseUnion
    = AnythingMapInParseUnion (HashMap Text Value)
    | EnumInParseUnion ParseEnum
    deriving (Show)

data ParseEnum
    = AutoParseEnum
    deriving (Show)

{-| The full data set, included inline. This can be an array of objects or primitive values
or a string.
Arrays of primitive values are ingested as objects with a `data` property. Strings are
parsed according to the specified format type.
-}
data Values
    = AnythingMapInValues (HashMap Text Value)
    | StringInValues Text
    | UnionArrayInValues ([ValuesValue])
    deriving (Show)

data ValuesValue
    = AnythingMapInValuesValue (HashMap Text Value)
    | BoolInValuesValue Bool
    | DoubleInValuesValue Double
    | StringInValuesValue Text
    deriving (Show)

{-| A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
`"line"`,
* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
object](mark.html#mark-def).
-}
data AnyMark
    = EnumInAnyMark Mark
    | MarkDefInAnyMark MarkDef
    deriving (Show)

{-| align:
The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.

angle:
The rotation angle of the text, in degrees.

baseline:
The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.

__Default value:__ `"middle"`

clip:
Whether a mark be clipped to the enclosing group’s width and height.

color:
Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
will override `color`.

__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

cursor:
The mouse cursor used over the mark. Any valid [CSS cursor
type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.

dx:
The horizontal offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

dy:
The vertical offset, in pixels, between the text label and its anchor point. The offset
is applied after rotation by the _angle_ property.

fill:
Default Fill Color.  This has higher precedence than config.color

__Default value:__ (None)

filled:
Whether the mark's color should be used as fill color instead of stroke color.

__Default value:__ `true` for all marks except `point` and `false` for `point`.

__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.

__Note:__ This property cannot be used in a [style config](mark.html#style-config).

fillOpacity:
The fill opacity (value between [0,1]).

__Default value:__ `1`

font:
The typeface to set the text in (e.g., `"Helvetica Neue"`).

fontSize:
The font size, in pixels.

fontStyle:
The font style (e.g., `"italic"`).

fontWeight:
The font weight (e.g., `"bold"`).

href:
A URL to load upon mouse click. If defined, the mark acts as a hyperlink.

interpolate:
The line interpolation method to use for line and area marks. One of the following:
- `"linear"`: piecewise linear segments, as in a polyline.
- `"linear-closed"`: close the linear segments to form a polygon.
- `"step"`: alternate between horizontal and vertical segments, as in a step function.
- `"step-before"`: alternate between vertical and horizontal segments, as in a step
function.
- `"step-after"`: alternate between horizontal and vertical segments, as in a step
function.
- `"basis"`: a B-spline, with control point duplication on the ends.
- `"basis-open"`: an open B-spline; may not intersect the start or end.
- `"basis-closed"`: a closed B-spline, as in a loop.
- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
will intersect other control points.
- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
spline.
- `"monotone"`: cubic interpolation that preserves monotonicity in y.

limit:
The maximum length of the text mark in pixels (default 0, indicating no limit). The text
value will be automatically truncated if the rendered size exceeds the limit.

opacity:
The overall opacity (value between [0,1]).

__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
`square` marks or layered `bar` charts and `1` otherwise.

orient:
The orientation of a non-stacked bar, tick, area, and line charts.
The value is either horizontal (default) or vertical.
- For bar, rule and tick, this determines whether the size of the bar and tick
should be applied to x or y dimension.
- For area, this property determines the orient property of the Vega output.
- For line, this property determines the sort order of the points in the line
if `config.sortLineBy` is not specified.
For stacked charts, this is always determined by the orientation of the stack;
therefore explicitly specified value will be ignored.

radius:
Polar coordinate radial offset, in pixels, of the text label from the origin determined
by the `x` and `y` properties.

shape:
The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.

__Default value:__ `"circle"`

size:
The pixel area each the point/circle/square.
For example: in the case of circles, the radius is determined in part by the square root
of the size value.

__Default value:__ `30`

stroke:
Default Stroke Color.  This has higher precedence than config.color

__Default value:__ (None)

strokeDash:
An array of alternating stroke, space lengths for creating dashed or dotted lines.

strokeDashOffset:
The offset (in pixels) into which to begin drawing with the stroke dash array.

strokeOpacity:
The stroke opacity (value between [0,1]).

__Default value:__ `1`

strokeWidth:
The stroke width, in pixels.

style:
A string or array of strings indicating the name of custom styles to apply to the mark. A
style is a named collection of mark property defaults defined within the [style
configuration](mark.html#style-config). If style is an array, later styles will override
earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
the `encoding` will override a style default.

__Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
default.
__Note:__ Any specified style will augment the default style. For example, a bar mark
with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
specified style `"foo"` has higher precedence).

tension:
Depending on the interpolation type, sets the tension parameter (for line and area marks).

markDefText:
Placeholder text if the `text` channel is not specified

theta:
Polar coordinate angle, in radians, of the text label from the origin determined by the
`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
indicating "north".

markDefType:
The mark type.
One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
`"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
-}
data MarkDef = MarkDef
    { alignMarkDef :: Maybe HorizontalAlign
    , angleMarkDef :: Maybe Double
    , baselineMarkDef :: Maybe VerticalAlign
    , clipMarkDef :: Maybe Bool
    , colorMarkDef :: Maybe Text
    , cursorMarkDef :: Maybe Cursor
    , dxMarkDef :: Maybe Double
    , dyMarkDef :: Maybe Double
    , fillMarkDef :: Maybe Text
    , filledMarkDef :: Maybe Bool
    , fillOpacityMarkDef :: Maybe Double
    , fontMarkDef :: Maybe Text
    , fontSizeMarkDef :: Maybe Double
    , fontStyleMarkDef :: Maybe FontStyle
    , fontWeightMarkDef :: Maybe FontWeightUnion
    , hrefMarkDef :: Maybe Text
    , interpolateMarkDef :: Maybe Interpolate
    , limitMarkDef :: Maybe Double
    , opacityMarkDef :: Maybe Double
    , orientMarkDef :: Maybe Orient
    , radiusMarkDef :: Maybe Double
    , shapeMarkDef :: Maybe Text
    , sizeMarkDef :: Maybe Double
    , strokeMarkDef :: Maybe Text
    , strokeDashMarkDef :: Maybe ([Double])
    , strokeDashOffsetMarkDef :: Maybe Double
    , strokeOpacityMarkDef :: Maybe Double
    , strokeWidthMarkDef :: Maybe Double
    , styleMarkDef :: Maybe Style
    , tensionMarkDef :: Maybe Double
    , markDefTextMarkDef :: Maybe Text
    , thetaMarkDef :: Maybe Double
    , markDefTypeMarkDef :: Mark
    } deriving (Show)

{-| All types of primitive marks.

The mark type.
One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
`"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
-}
data Mark
    = AreaMark
    | BarMark
    | LineMark
    | PointMark
    | TextMark
    | TickMark
    | RectMark
    | RuleMark
    | CircleMark
    | SquareMark
    | GeoshapeMark
    deriving (Show)

{-| A string or array of strings indicating the name of custom styles to apply to the mark. A
style is a named collection of mark property defaults defined within the [style
configuration](mark.html#style-config). If style is an array, later styles will override
earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
the `encoding` will override a style default.

__Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
default.
__Note:__ Any specified style will augment the default style. For example, a bar mark
with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
specified style `"foo"` has higher precedence).

A [mark style property](config.html#style) to apply to the title text mark.

__Default value:__ `"group-title"`.
-}
data Style
    = StringArrayInStyle ([Text])
    | StringInStyle Text
    deriving (Show)

{-| An object defining properties of geographic projection.

Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.

center:
Sets the projection’s center to the specified center, a two-element array of longitude
and latitude in degrees.

__Default value:__ `[0, 0]`

clipAngle:
Sets the projection’s clipping circle radius to the specified angle in degrees. If
`null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
than small-circle clipping.

clipExtent:
Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
viewport clipping is performed.

precision:
Sets the threshold for the projection’s [adaptive
resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
value corresponds to the [Douglas–Peucker
distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
If precision is not specified, returns the projection’s current resampling precision
which defaults to `√0.5 ≅ 0.70710…`.

rotate:
Sets the projection’s three-axis rotation to the specified angles, which must be a two-
or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)

__Default value:__ `[0, 0, 0]`

projectionType:
The cartographic projection to use. This value is case-insensitive, for example
`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
projection types [in the
documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).

__Default value:__ `mercator`
-}
data Projection = Projection
    { centerProjection :: Maybe ([Double])
    , clipAngleProjection :: Maybe Double
    , clipExtentProjection :: Maybe ([([Double])])
    , coefficientProjection :: Maybe Double
    , distanceProjection :: Maybe Double
    , fractionProjection :: Maybe Double
    , lobesProjection :: Maybe Double
    , parallelProjection :: Maybe Double
    , precisionProjection :: Maybe (HashMap Text TitleFontWeight)
    , radiusProjection :: Maybe Double
    , ratioProjection :: Maybe Double
    , rotateProjection :: Maybe ([Double])
    , spacingProjection :: Maybe Double
    , tiltProjection :: Maybe Double
    , projectionTypeProjection :: Maybe VGProjectionType
    } deriving (Show)

{-| Scale, axis, and legend resolutions for layers.

Defines how scales, axes, and legends from different specs should be combined. Resolve is
a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.

Scale, axis, and legend resolutions for facets.

Scale and legend resolutions for repeated charts.

Scale, axis, and legend resolutions for vertically concatenated charts.

Scale, axis, and legend resolutions for horizontally concatenated charts.
-}
data Resolve = Resolve
    { axisResolve :: Maybe AxisResolveMap
    , legendResolve :: Maybe LegendResolveMap
    , scaleResolve :: Maybe ScaleResolveMap
    } deriving (Show)

data AxisResolveMap = AxisResolveMap
    { xAxisResolveMap :: Maybe ResolveMode
    , yAxisResolveMap :: Maybe ResolveMode
    } deriving (Show)

data ResolveMode
    = IndependentResolveMode
    | SharedResolveMode
    deriving (Show)

data LegendResolveMap = LegendResolveMap
    { colorLegendResolveMap :: Maybe ResolveMode
    , opacityLegendResolveMap :: Maybe ResolveMode
    , shapeLegendResolveMap :: Maybe ResolveMode
    , sizeLegendResolveMap :: Maybe ResolveMode
    } deriving (Show)

data ScaleResolveMap = ScaleResolveMap
    { colorScaleResolveMap :: Maybe ResolveMode
    , opacityScaleResolveMap :: Maybe ResolveMode
    , shapeScaleResolveMap :: Maybe ResolveMode
    , sizeScaleResolveMap :: Maybe ResolveMode
    , xScaleResolveMap :: Maybe ResolveMode
    , yScaleResolveMap :: Maybe ResolveMode
    } deriving (Show)

{-| bind:
Establish a two-way binding between a single selection and input elements
(also known as dynamic query widgets). A binding takes the form of
Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
or can be a mapping between projected field/encodings and binding definitions.

See the [bind transform](bind.html) documentation for more information.

Establishes a two-way binding between the interval selection and the scales
used within the same view. This allows a user to interactively pan and
zoom the view.

empty:
By default, all data values are considered to lie within an empty selection.
When set to `none`, empty selections contain no data values.

encodings:
An array of encoding channels. The corresponding data field values
must match for a data tuple to fall within the selection.

fields:
An array of field names whose values must match for a data tuple to
fall within the selection.

nearest:
When true, an invisible voronoi diagram is computed to accelerate discrete
selection. The data value _nearest_ the mouse cursor is added to the selection.

See the [nearest transform](nearest.html) documentation for more information.

on:
A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
selector) that triggers the selection.
For interval selections, the event stream must specify a [start and
end](https://vega.github.io/vega/docs/event-streams/#between-filters).

resolve:
With layered and multi-view displays, a strategy that determines how
selections' data queries are resolved when applied in a filter transform,
conditional encoding rule, or scale domain.

toggle:
Controls whether data values should be toggled or only ever inserted into
multi selections. Can be `true`, `false` (for insertion only), or a
[Vega expression](https://vega.github.io/vega/docs/expressions/).

__Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
data values are toggled when a user interacts with the shift-key pressed).

See the [toggle transform](toggle.html) documentation for more information.

mark:
An interval selection also adds a rectangle mark to depict the
extents of the interval. The `mark` property can be used to customize the
appearance of the mark.

translate:
When truthy, allows a user to interactively move an interval selection
back-and-forth. Can be `true`, `false` (to disable panning), or a
[Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
which must include a start and end event to trigger continuous panning.

__Default value:__ `true`, which corresponds to
`[mousedown, window:mouseup] > window:mousemove!` which corresponds to
clicks and dragging within an interval selection to reposition it.

zoom:
When truthy, allows a user to interactively resize an interval selection.
Can be `true`, `false` (to disable zooming), or a [Vega event stream
definition](https://vega.github.io/vega/docs/event-streams/). Currently,
only `wheel` events are supported.


__Default value:__ `true`, which corresponds to `wheel!`.
-}
data SelectionDef = SelectionDef
    { bindSelectionDef :: Maybe BindUnion
    , emptySelectionDef :: Maybe Empty
    , encodingsSelectionDef :: Maybe ([SingleDefChannel])
    , fieldsSelectionDef :: Maybe ([Text])
    , nearestSelectionDef :: Maybe Bool
    , onSelectionDef :: Maybe Value
    , resolveSelectionDef :: Maybe SelectionResolution
    , selectionDefTypeSelectionDef :: SelectionDefType
    , toggleSelectionDef :: Maybe Translate
    , markSelectionDef :: Maybe BrushConfig
    , translateSelectionDef :: Maybe Translate
    , zoomSelectionDef :: Maybe Translate
    } deriving (Show)

data BindUnion
    = EnumInBindUnion BindEnum
    | VGBindingMapInBindUnion (HashMap Text VGBinding)
    deriving (Show)

data SelectionDefType
    = SingleSelectionDefType
    | MultiSelectionDefType
    | IntervalSelectionDefType
    deriving (Show)

data Title
    = StringInTitle Text
    | TitleParamsInTitle TitleParams
    deriving (Show)

{-| anchor:
The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
example, with an orientation of top these anchor positions map to a left-, center-, or
right-aligned title.

__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
`"start"` for other composite views.

__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
customizable only for [single](spec.html) and [layered](layer.html) views.  For other
composite views, `anchor` is always `"start"`.

offset:
The orthogonal offset in pixels by which to displace the title from its position along
the edge of the chart.

orient:
The orientation of the title relative to the chart. One of `"top"` (the default),
`"bottom"`, `"left"`, or `"right"`.

style:
A [mark style property](config.html#style) to apply to the title text mark.

__Default value:__ `"group-title"`.

titleParamsText:
The title text.
-}
data TitleParams = TitleParams
    { anchorTitleParams :: Maybe Anchor
    , offsetTitleParams :: Maybe Double
    , orientTitleParams :: Maybe TitleOrient
    , styleTitleParams :: Maybe Style
    , titleParamsTextTitleParams :: Text
    } deriving (Show)

{-| filter:
The `filter` property must be one of the predicate definitions:
(1) an [expression](types.html#expression) string,
where `datum` can be used to refer to the current data object;
(2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
[range predicate](filter.html#range-predicate), [one-of
predicate](filter.html#one-of-predicate);
(3) a [selection predicate](filter.html#selection-predicate);
or (4) a logical operand that combines (1), (2), or (3).

transformAs:
The field for storing the computed formula value.

The field or fields for storing the computed formula value.
If `from.fields` is specified, the transform will use the same names for `as`.
If `from.fields` is not specified, `as` has to be a string and we put the whole object
into the data under the specified name.

The output fields at which to write the start and end bin values.

The output field to write the timeUnit value.

calculate:
A [expression](types.html#expression) string. Use the variable `datum` to refer to the
current data object.

transformDefault:
The default value to use if lookup fails.

__Default value:__ `null`

from:
Secondary data reference.

lookup:
Key in primary data source.

bin:
An object indicating bin properties, or simply `true` for using default bin parameters.

field:
The data field to bin.

The data field to apply time unit.

timeUnit:
The timeUnit.

aggregate:
Array of objects that define fields to aggregate.

groupby:
The data fields to group by. If not specified, a single group containing all data objects
will be used.
-}
data Transform = Transform
    { filterTransform :: Maybe LogicalOperandPredicate
    , transformAsTransform :: Maybe Style
    , calculateTransform :: Maybe Text
    , transformDefaultTransform :: Maybe Text
    , fromTransform :: Maybe LookupData
    , lookupTransform :: Maybe Text
    , binTransform :: Maybe Bin
    , fieldTransform :: Maybe Text
    , timeUnitTransform :: Maybe TimeUnit
    , aggregateTransform :: Maybe ([AggregatedFieldDef])
    , groupbyTransform :: Maybe ([Text])
    } deriving (Show)

{-| aggregatedFieldDefAs:
The output field names to use for each aggregated field.

field:
The data field for which to compute aggregate function.

op:
The aggregation operations to apply to the fields, such as sum, average or count.
See the [full list of supported aggregation
operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
for more information.
-}
data AggregatedFieldDef = AggregatedFieldDef
    { aggregatedFieldDefAsAggregatedFieldDef :: Text
    , fieldAggregatedFieldDef :: Text
    , opAggregatedFieldDef :: AggregateOp
    } deriving (Show)

{-| Secondary data reference.

lookupDataData:
Secondary data source to lookup in.

fields:
Fields in foreign data to lookup.
If not specified, the entire object is queried.

key:
Key in data to lookup.
-}
data LookupData = LookupData
    { lookupDataDataLookupData :: Data
    , fieldsLookupData :: Maybe ([Text])
    , keyLookupData :: Text
    } deriving (Show)

{-| An object that describes what fields should be repeated into views that are laid out as a
`row` or `column`.

column:
Horizontal repeated views.

row:
Vertical repeated views.
-}
data Repeat = Repeat
    { columnRepeat :: Maybe ([Text])
    , rowRepeat :: Maybe ([Text])
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType schemaQuickType autosizeQuickType backgroundQuickType configQuickType quickTypeDataQuickType descriptionQuickType encodingQuickType heightQuickType markQuickType nameQuickType paddingQuickType projectionQuickType selectionQuickType titleQuickType transformQuickType widthQuickType layerQuickType resolveQuickType facetQuickType specQuickType repeatQuickType vconcatQuickType hconcatQuickType) =
        object $ foldMap (maybe [] pure)
        [ ("$schema" .=) <$> schemaQuickType
        , ("autosize" .=) <$> autosizeQuickType
        , ("background" .=) <$> backgroundQuickType
        , ("config" .=) <$> configQuickType
        , ("data" .=) <$> quickTypeDataQuickType
        , ("description" .=) <$> descriptionQuickType
        , ("encoding" .=) <$> encodingQuickType
        , ("height" .=) <$> heightQuickType
        , ("mark" .=) <$> markQuickType
        , ("name" .=) <$> nameQuickType
        , ("padding" .=) <$> paddingQuickType
        , ("projection" .=) <$> projectionQuickType
        , ("selection" .=) <$> selectionQuickType
        , ("title" .=) <$> titleQuickType
        , ("transform" .=) <$> transformQuickType
        , ("width" .=) <$> widthQuickType
        , ("layer" .=) <$> layerQuickType
        , ("resolve" .=) <$> resolveQuickType
        , ("facet" .=) <$> facetQuickType
        , ("spec" .=) <$> specQuickType
        , ("repeat" .=) <$> repeatQuickType
        , ("vconcat" .=) <$> vconcatQuickType
        , ("hconcat" .=) <$> hconcatQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .:! "$schema"
        <*> v .:! "autosize"
        <*> v .:! "background"
        <*> v .:! "config"
        <*> v .:! "data"
        <*> v .:! "description"
        <*> v .:! "encoding"
        <*> v .:! "height"
        <*> v .:! "mark"
        <*> v .:! "name"
        <*> v .:! "padding"
        <*> v .:! "projection"
        <*> v .:! "selection"
        <*> v .:! "title"
        <*> v .:! "transform"
        <*> v .:! "width"
        <*> v .:! "layer"
        <*> v .:! "resolve"
        <*> v .:! "facet"
        <*> v .:! "spec"
        <*> v .:! "repeat"
        <*> v .:! "vconcat"
        <*> v .:! "hconcat"

instance ToJSON Autosize where
    toJSON (AutoSizeParamsInAutosize x) = toJSON x
    toJSON (EnumInAutosize x) = toJSON x

instance FromJSON Autosize where
    parseJSON xs@(Object _) = (fmap AutoSizeParamsInAutosize . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInAutosize . parseJSON) xs

instance ToJSON AutoSizeParams where
    toJSON (AutoSizeParams containsAutoSizeParams resizeAutoSizeParams autoSizeParamsTypeAutoSizeParams) =
        object $ foldMap (maybe [] pure)
        [ ("contains" .=) <$> containsAutoSizeParams
        , ("resize" .=) <$> resizeAutoSizeParams
        , ("type" .=) <$> autoSizeParamsTypeAutoSizeParams
        ]

instance FromJSON AutoSizeParams where
    parseJSON (Object v) = AutoSizeParams
        <$> v .:! "contains"
        <*> v .:! "resize"
        <*> v .:! "type"

instance ToJSON AutosizeType where
    toJSON PadAutosizeType = "pad"
    toJSON FitAutosizeType = "fit"
    toJSON NoneAutosizeType = "none"

instance FromJSON AutosizeType where
    parseJSON = withText "AutosizeType" parseText
        where
            parseText "pad" = return PadAutosizeType
            parseText "fit" = return FitAutosizeType
            parseText "none" = return NoneAutosizeType

instance ToJSON Contains where
    toJSON ContentContains = "content"
    toJSON PaddingContains = "padding"

instance FromJSON Contains where
    parseJSON = withText "Contains" parseText
        where
            parseText "content" = return ContentContains
            parseText "padding" = return PaddingContains

instance ToJSON Config where
    toJSON (Config areaConfig autosizeConfig axisConfig axisBandConfig axisBottomConfig axisLeftConfig axisRightConfig axisTopConfig axisXConfig axisYConfig backgroundConfig barConfig circleConfig countTitleConfig fieldTitleConfig geoshapeConfig invalidValuesConfig legendConfig lineConfig markConfig numberFormatConfig paddingConfig pointConfig projectionConfig rangeConfig rectConfig ruleConfig scaleConfig selectionConfig squareConfig stackConfig styleConfig configTextConfig tickConfig timeFormatConfig titleConfig viewConfig) =
        object $ foldMap (maybe [] pure)
        [ ("area" .=) <$> areaConfig
        , ("autosize" .=) <$> autosizeConfig
        , ("axis" .=) <$> axisConfig
        , ("axisBand" .=) <$> axisBandConfig
        , ("axisBottom" .=) <$> axisBottomConfig
        , ("axisLeft" .=) <$> axisLeftConfig
        , ("axisRight" .=) <$> axisRightConfig
        , ("axisTop" .=) <$> axisTopConfig
        , ("axisX" .=) <$> axisXConfig
        , ("axisY" .=) <$> axisYConfig
        , ("background" .=) <$> backgroundConfig
        , ("bar" .=) <$> barConfig
        , ("circle" .=) <$> circleConfig
        , ("countTitle" .=) <$> countTitleConfig
        , ("fieldTitle" .=) <$> fieldTitleConfig
        , ("geoshape" .=) <$> geoshapeConfig
        , ("invalidValues" .=) <$> invalidValuesConfig
        , ("legend" .=) <$> legendConfig
        , ("line" .=) <$> lineConfig
        , ("mark" .=) <$> markConfig
        , ("numberFormat" .=) <$> numberFormatConfig
        , ("padding" .=) <$> paddingConfig
        , ("point" .=) <$> pointConfig
        , ("projection" .=) <$> projectionConfig
        , ("range" .=) <$> rangeConfig
        , ("rect" .=) <$> rectConfig
        , ("rule" .=) <$> ruleConfig
        , ("scale" .=) <$> scaleConfig
        , ("selection" .=) <$> selectionConfig
        , ("square" .=) <$> squareConfig
        , ("stack" .=) <$> stackConfig
        , ("style" .=) <$> styleConfig
        , ("text" .=) <$> configTextConfig
        , ("tick" .=) <$> tickConfig
        , ("timeFormat" .=) <$> timeFormatConfig
        , ("title" .=) <$> titleConfig
        , ("view" .=) <$> viewConfig
        ]

instance FromJSON Config where
    parseJSON (Object v) = Config
        <$> v .:! "area"
        <*> v .:! "autosize"
        <*> v .:! "axis"
        <*> v .:! "axisBand"
        <*> v .:! "axisBottom"
        <*> v .:! "axisLeft"
        <*> v .:! "axisRight"
        <*> v .:! "axisTop"
        <*> v .:! "axisX"
        <*> v .:! "axisY"
        <*> v .:! "background"
        <*> v .:! "bar"
        <*> v .:! "circle"
        <*> v .:! "countTitle"
        <*> v .:! "fieldTitle"
        <*> v .:! "geoshape"
        <*> v .:! "invalidValues"
        <*> v .:! "legend"
        <*> v .:! "line"
        <*> v .:! "mark"
        <*> v .:! "numberFormat"
        <*> v .:! "padding"
        <*> v .:! "point"
        <*> v .:! "projection"
        <*> v .:! "range"
        <*> v .:! "rect"
        <*> v .:! "rule"
        <*> v .:! "scale"
        <*> v .:! "selection"
        <*> v .:! "square"
        <*> v .:! "stack"
        <*> v .:! "style"
        <*> v .:! "text"
        <*> v .:! "tick"
        <*> v .:! "timeFormat"
        <*> v .:! "title"
        <*> v .:! "view"

instance ToJSON MarkConfig where
    toJSON (MarkConfig alignMarkConfig angleMarkConfig baselineMarkConfig colorMarkConfig cursorMarkConfig dxMarkConfig dyMarkConfig fillMarkConfig filledMarkConfig fillOpacityMarkConfig fontMarkConfig fontSizeMarkConfig fontStyleMarkConfig fontWeightMarkConfig hrefMarkConfig interpolateMarkConfig limitMarkConfig opacityMarkConfig orientMarkConfig radiusMarkConfig shapeMarkConfig sizeMarkConfig strokeMarkConfig strokeDashMarkConfig strokeDashOffsetMarkConfig strokeOpacityMarkConfig strokeWidthMarkConfig tensionMarkConfig markConfigTextMarkConfig thetaMarkConfig) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignMarkConfig
        , ("angle" .=) <$> angleMarkConfig
        , ("baseline" .=) <$> baselineMarkConfig
        , ("color" .=) <$> colorMarkConfig
        , ("cursor" .=) <$> cursorMarkConfig
        , ("dx" .=) <$> dxMarkConfig
        , ("dy" .=) <$> dyMarkConfig
        , ("fill" .=) <$> fillMarkConfig
        , ("filled" .=) <$> filledMarkConfig
        , ("fillOpacity" .=) <$> fillOpacityMarkConfig
        , ("font" .=) <$> fontMarkConfig
        , ("fontSize" .=) <$> fontSizeMarkConfig
        , ("fontStyle" .=) <$> fontStyleMarkConfig
        , ("fontWeight" .=) <$> fontWeightMarkConfig
        , ("href" .=) <$> hrefMarkConfig
        , ("interpolate" .=) <$> interpolateMarkConfig
        , ("limit" .=) <$> limitMarkConfig
        , ("opacity" .=) <$> opacityMarkConfig
        , ("orient" .=) <$> orientMarkConfig
        , ("radius" .=) <$> radiusMarkConfig
        , ("shape" .=) <$> shapeMarkConfig
        , ("size" .=) <$> sizeMarkConfig
        , ("stroke" .=) <$> strokeMarkConfig
        , ("strokeDash" .=) <$> strokeDashMarkConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetMarkConfig
        , ("strokeOpacity" .=) <$> strokeOpacityMarkConfig
        , ("strokeWidth" .=) <$> strokeWidthMarkConfig
        , ("tension" .=) <$> tensionMarkConfig
        , ("text" .=) <$> markConfigTextMarkConfig
        , ("theta" .=) <$> thetaMarkConfig
        ]

instance FromJSON MarkConfig where
    parseJSON (Object v) = MarkConfig
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "color"
        <*> v .:! "cursor"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "filled"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"

instance ToJSON HorizontalAlign where
    toJSON LeftHorizontalAlign = "left"
    toJSON RightHorizontalAlign = "right"
    toJSON CenterHorizontalAlign = "center"

instance FromJSON HorizontalAlign where
    parseJSON = withText "HorizontalAlign" parseText
        where
            parseText "left" = return LeftHorizontalAlign
            parseText "right" = return RightHorizontalAlign
            parseText "center" = return CenterHorizontalAlign

instance ToJSON VerticalAlign where
    toJSON TopVerticalAlign = "top"
    toJSON MiddleVerticalAlign = "middle"
    toJSON BottomVerticalAlign = "bottom"

instance FromJSON VerticalAlign where
    parseJSON = withText "VerticalAlign" parseText
        where
            parseText "top" = return TopVerticalAlign
            parseText "middle" = return MiddleVerticalAlign
            parseText "bottom" = return BottomVerticalAlign

instance ToJSON Cursor where
    toJSON AutoCursor = "auto"
    toJSON DefaultCursor = "default"
    toJSON NoneCursor = "none"
    toJSON ContextMenuCursor = "context-menu"
    toJSON HelpCursor = "help"
    toJSON PointerCursor = "pointer"
    toJSON ProgressCursor = "progress"
    toJSON WaitCursor = "wait"
    toJSON CellCursor = "cell"
    toJSON CrosshairCursor = "crosshair"
    toJSON TextCursor = "text"
    toJSON VerticalTextCursor = "vertical-text"
    toJSON AliasCursor = "alias"
    toJSON CopyCursor = "copy"
    toJSON MoveCursor = "move"
    toJSON NoDropCursor = "no-drop"
    toJSON NotAllowedCursor = "not-allowed"
    toJSON EResizeCursor = "e-resize"
    toJSON NResizeCursor = "n-resize"
    toJSON NeResizeCursor = "ne-resize"
    toJSON NwResizeCursor = "nw-resize"
    toJSON SResizeCursor = "s-resize"
    toJSON SEResizeCursor = "se-resize"
    toJSON SwResizeCursor = "sw-resize"
    toJSON WResizeCursor = "w-resize"
    toJSON EwResizeCursor = "ew-resize"
    toJSON NSResizeCursor = "ns-resize"
    toJSON NeswResizeCursor = "nesw-resize"
    toJSON NwseResizeCursor = "nwse-resize"
    toJSON ColResizeCursor = "col-resize"
    toJSON RowResizeCursor = "row-resize"
    toJSON AllScrollCursor = "all-scroll"
    toJSON ZoomInCursor = "zoom-in"
    toJSON ZoomOutCursor = "zoom-out"
    toJSON GrabCursor = "grab"
    toJSON GrabbingCursor = "grabbing"

instance FromJSON Cursor where
    parseJSON = withText "Cursor" parseText
        where
            parseText "auto" = return AutoCursor
            parseText "default" = return DefaultCursor
            parseText "none" = return NoneCursor
            parseText "context-menu" = return ContextMenuCursor
            parseText "help" = return HelpCursor
            parseText "pointer" = return PointerCursor
            parseText "progress" = return ProgressCursor
            parseText "wait" = return WaitCursor
            parseText "cell" = return CellCursor
            parseText "crosshair" = return CrosshairCursor
            parseText "text" = return TextCursor
            parseText "vertical-text" = return VerticalTextCursor
            parseText "alias" = return AliasCursor
            parseText "copy" = return CopyCursor
            parseText "move" = return MoveCursor
            parseText "no-drop" = return NoDropCursor
            parseText "not-allowed" = return NotAllowedCursor
            parseText "e-resize" = return EResizeCursor
            parseText "n-resize" = return NResizeCursor
            parseText "ne-resize" = return NeResizeCursor
            parseText "nw-resize" = return NwResizeCursor
            parseText "s-resize" = return SResizeCursor
            parseText "se-resize" = return SEResizeCursor
            parseText "sw-resize" = return SwResizeCursor
            parseText "w-resize" = return WResizeCursor
            parseText "ew-resize" = return EwResizeCursor
            parseText "ns-resize" = return NSResizeCursor
            parseText "nesw-resize" = return NeswResizeCursor
            parseText "nwse-resize" = return NwseResizeCursor
            parseText "col-resize" = return ColResizeCursor
            parseText "row-resize" = return RowResizeCursor
            parseText "all-scroll" = return AllScrollCursor
            parseText "zoom-in" = return ZoomInCursor
            parseText "zoom-out" = return ZoomOutCursor
            parseText "grab" = return GrabCursor
            parseText "grabbing" = return GrabbingCursor

instance ToJSON FontStyle where
    toJSON NormalFontStyle = "normal"
    toJSON ItalicFontStyle = "italic"

instance FromJSON FontStyle where
    parseJSON = withText "FontStyle" parseText
        where
            parseText "normal" = return NormalFontStyle
            parseText "italic" = return ItalicFontStyle

instance ToJSON FontWeightUnion where
    toJSON (DoubleInFontWeightUnion x) = toJSON x
    toJSON (EnumInFontWeightUnion x) = toJSON x

instance FromJSON FontWeightUnion where
    parseJSON xs@(Number _) = (fmap DoubleInFontWeightUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInFontWeightUnion . parseJSON) xs

instance ToJSON FontWeight where
    toJSON NormalFontWeight = "normal"
    toJSON BoldFontWeight = "bold"

instance FromJSON FontWeight where
    parseJSON = withText "FontWeight" parseText
        where
            parseText "normal" = return NormalFontWeight
            parseText "bold" = return BoldFontWeight

instance ToJSON Interpolate where
    toJSON LinearInterpolate = "linear"
    toJSON LinearClosedInterpolate = "linear-closed"
    toJSON StepInterpolate = "step"
    toJSON StepBeforeInterpolate = "step-before"
    toJSON StepAfterInterpolate = "step-after"
    toJSON BasisInterpolate = "basis"
    toJSON BasisOpenInterpolate = "basis-open"
    toJSON BasisClosedInterpolate = "basis-closed"
    toJSON CardinalInterpolate = "cardinal"
    toJSON CardinalOpenInterpolate = "cardinal-open"
    toJSON CardinalClosedInterpolate = "cardinal-closed"
    toJSON BundleInterpolate = "bundle"
    toJSON MonotoneInterpolate = "monotone"

instance FromJSON Interpolate where
    parseJSON = withText "Interpolate" parseText
        where
            parseText "linear" = return LinearInterpolate
            parseText "linear-closed" = return LinearClosedInterpolate
            parseText "step" = return StepInterpolate
            parseText "step-before" = return StepBeforeInterpolate
            parseText "step-after" = return StepAfterInterpolate
            parseText "basis" = return BasisInterpolate
            parseText "basis-open" = return BasisOpenInterpolate
            parseText "basis-closed" = return BasisClosedInterpolate
            parseText "cardinal" = return CardinalInterpolate
            parseText "cardinal-open" = return CardinalOpenInterpolate
            parseText "cardinal-closed" = return CardinalClosedInterpolate
            parseText "bundle" = return BundleInterpolate
            parseText "monotone" = return MonotoneInterpolate

instance ToJSON Orient where
    toJSON HorizontalOrient = "horizontal"
    toJSON VerticalOrient = "vertical"

instance FromJSON Orient where
    parseJSON = withText "Orient" parseText
        where
            parseText "horizontal" = return HorizontalOrient
            parseText "vertical" = return VerticalOrient

instance ToJSON AxisConfig where
    toJSON (AxisConfig bandPositionAxisConfig domainAxisConfig domainColorAxisConfig domainWidthAxisConfig gridAxisConfig gridColorAxisConfig gridDashAxisConfig gridOpacityAxisConfig gridWidthAxisConfig labelAngleAxisConfig labelBoundAxisConfig labelColorAxisConfig labelFlushAxisConfig labelFontAxisConfig labelFontSizeAxisConfig labelLimitAxisConfig labelOverlapAxisConfig labelPaddingAxisConfig labelsAxisConfig maxExtentAxisConfig minExtentAxisConfig shortTimeLabelsAxisConfig tickColorAxisConfig tickRoundAxisConfig ticksAxisConfig tickSizeAxisConfig tickWidthAxisConfig titleAlignAxisConfig titleAngleAxisConfig titleBaselineAxisConfig titleColorAxisConfig titleFontAxisConfig titleFontSizeAxisConfig titleFontWeightAxisConfig titleLimitAxisConfig titleMaxLengthAxisConfig titlePaddingAxisConfig titleXAxisConfig titleYAxisConfig) =
        object $ foldMap (maybe [] pure)
        [ ("bandPosition" .=) <$> bandPositionAxisConfig
        , ("domain" .=) <$> domainAxisConfig
        , ("domainColor" .=) <$> domainColorAxisConfig
        , ("domainWidth" .=) <$> domainWidthAxisConfig
        , ("grid" .=) <$> gridAxisConfig
        , ("gridColor" .=) <$> gridColorAxisConfig
        , ("gridDash" .=) <$> gridDashAxisConfig
        , ("gridOpacity" .=) <$> gridOpacityAxisConfig
        , ("gridWidth" .=) <$> gridWidthAxisConfig
        , ("labelAngle" .=) <$> labelAngleAxisConfig
        , ("labelBound" .=) <$> labelBoundAxisConfig
        , ("labelColor" .=) <$> labelColorAxisConfig
        , ("labelFlush" .=) <$> labelFlushAxisConfig
        , ("labelFont" .=) <$> labelFontAxisConfig
        , ("labelFontSize" .=) <$> labelFontSizeAxisConfig
        , ("labelLimit" .=) <$> labelLimitAxisConfig
        , ("labelOverlap" .=) <$> labelOverlapAxisConfig
        , ("labelPadding" .=) <$> labelPaddingAxisConfig
        , ("labels" .=) <$> labelsAxisConfig
        , ("maxExtent" .=) <$> maxExtentAxisConfig
        , ("minExtent" .=) <$> minExtentAxisConfig
        , ("shortTimeLabels" .=) <$> shortTimeLabelsAxisConfig
        , ("tickColor" .=) <$> tickColorAxisConfig
        , ("tickRound" .=) <$> tickRoundAxisConfig
        , ("ticks" .=) <$> ticksAxisConfig
        , ("tickSize" .=) <$> tickSizeAxisConfig
        , ("tickWidth" .=) <$> tickWidthAxisConfig
        , ("titleAlign" .=) <$> titleAlignAxisConfig
        , ("titleAngle" .=) <$> titleAngleAxisConfig
        , ("titleBaseline" .=) <$> titleBaselineAxisConfig
        , ("titleColor" .=) <$> titleColorAxisConfig
        , ("titleFont" .=) <$> titleFontAxisConfig
        , ("titleFontSize" .=) <$> titleFontSizeAxisConfig
        , ("titleFontWeight" .=) <$> titleFontWeightAxisConfig
        , ("titleLimit" .=) <$> titleLimitAxisConfig
        , ("titleMaxLength" .=) <$> titleMaxLengthAxisConfig
        , ("titlePadding" .=) <$> titlePaddingAxisConfig
        , ("titleX" .=) <$> titleXAxisConfig
        , ("titleY" .=) <$> titleYAxisConfig
        ]

instance FromJSON AxisConfig where
    parseJSON (Object v) = AxisConfig
        <$> v .:! "bandPosition"
        <*> v .:! "domain"
        <*> v .:! "domainColor"
        <*> v .:! "domainWidth"
        <*> v .:! "grid"
        <*> v .:! "gridColor"
        <*> v .:! "gridDash"
        <*> v .:! "gridOpacity"
        <*> v .:! "gridWidth"
        <*> v .:! "labelAngle"
        <*> v .:! "labelBound"
        <*> v .:! "labelColor"
        <*> v .:! "labelFlush"
        <*> v .:! "labelFont"
        <*> v .:! "labelFontSize"
        <*> v .:! "labelLimit"
        <*> v .:! "labelOverlap"
        <*> v .:! "labelPadding"
        <*> v .:! "labels"
        <*> v .:! "maxExtent"
        <*> v .:! "minExtent"
        <*> v .:! "shortTimeLabels"
        <*> v .:! "tickColor"
        <*> v .:! "tickRound"
        <*> v .:! "ticks"
        <*> v .:! "tickSize"
        <*> v .:! "tickWidth"
        <*> v .:! "titleAlign"
        <*> v .:! "titleAngle"
        <*> v .:! "titleBaseline"
        <*> v .:! "titleColor"
        <*> v .:! "titleFont"
        <*> v .:! "titleFontSize"
        <*> v .:! "titleFontWeight"
        <*> v .:! "titleLimit"
        <*> v .:! "titleMaxLength"
        <*> v .:! "titlePadding"
        <*> v .:! "titleX"
        <*> v .:! "titleY"

instance ToJSON Label where
    toJSON (BoolInLabel x) = toJSON x
    toJSON (DoubleInLabel x) = toJSON x

instance FromJSON Label where
    parseJSON xs@(Bool _) = (fmap BoolInLabel . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInLabel . parseJSON) xs

instance ToJSON LabelOverlapUnion where
    toJSON (BoolInLabelOverlapUnion x) = toJSON x
    toJSON (EnumInLabelOverlapUnion x) = toJSON x

instance FromJSON LabelOverlapUnion where
    parseJSON xs@(Bool _) = (fmap BoolInLabelOverlapUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInLabelOverlapUnion . parseJSON) xs

instance ToJSON LabelOverlapEnum where
    toJSON ParityLabelOverlapEnum = "parity"
    toJSON GreedyLabelOverlapEnum = "greedy"

instance FromJSON LabelOverlapEnum where
    parseJSON = withText "LabelOverlapEnum" parseText
        where
            parseText "parity" = return ParityLabelOverlapEnum
            parseText "greedy" = return GreedyLabelOverlapEnum

instance ToJSON TitleFontWeight where
    toJSON (DoubleInTitleFontWeight x) = toJSON x
    toJSON (StringInTitleFontWeight x) = toJSON x

instance FromJSON TitleFontWeight where
    parseJSON xs@(Number _) = (fmap DoubleInTitleFontWeight . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInTitleFontWeight . parseJSON) xs

instance ToJSON VGAxisConfig where
    toJSON (VGAxisConfig bandPositionVGAxisConfig domainVGAxisConfig domainColorVGAxisConfig domainWidthVGAxisConfig gridVGAxisConfig gridColorVGAxisConfig gridDashVGAxisConfig gridOpacityVGAxisConfig gridWidthVGAxisConfig labelAngleVGAxisConfig labelBoundVGAxisConfig labelColorVGAxisConfig labelFlushVGAxisConfig labelFontVGAxisConfig labelFontSizeVGAxisConfig labelLimitVGAxisConfig labelOverlapVGAxisConfig labelPaddingVGAxisConfig labelsVGAxisConfig maxExtentVGAxisConfig minExtentVGAxisConfig tickColorVGAxisConfig tickRoundVGAxisConfig ticksVGAxisConfig tickSizeVGAxisConfig tickWidthVGAxisConfig titleAlignVGAxisConfig titleAngleVGAxisConfig titleBaselineVGAxisConfig titleColorVGAxisConfig titleFontVGAxisConfig titleFontSizeVGAxisConfig titleFontWeightVGAxisConfig titleLimitVGAxisConfig titleMaxLengthVGAxisConfig titlePaddingVGAxisConfig titleXVGAxisConfig titleYVGAxisConfig) =
        object $ foldMap (maybe [] pure)
        [ ("bandPosition" .=) <$> bandPositionVGAxisConfig
        , ("domain" .=) <$> domainVGAxisConfig
        , ("domainColor" .=) <$> domainColorVGAxisConfig
        , ("domainWidth" .=) <$> domainWidthVGAxisConfig
        , ("grid" .=) <$> gridVGAxisConfig
        , ("gridColor" .=) <$> gridColorVGAxisConfig
        , ("gridDash" .=) <$> gridDashVGAxisConfig
        , ("gridOpacity" .=) <$> gridOpacityVGAxisConfig
        , ("gridWidth" .=) <$> gridWidthVGAxisConfig
        , ("labelAngle" .=) <$> labelAngleVGAxisConfig
        , ("labelBound" .=) <$> labelBoundVGAxisConfig
        , ("labelColor" .=) <$> labelColorVGAxisConfig
        , ("labelFlush" .=) <$> labelFlushVGAxisConfig
        , ("labelFont" .=) <$> labelFontVGAxisConfig
        , ("labelFontSize" .=) <$> labelFontSizeVGAxisConfig
        , ("labelLimit" .=) <$> labelLimitVGAxisConfig
        , ("labelOverlap" .=) <$> labelOverlapVGAxisConfig
        , ("labelPadding" .=) <$> labelPaddingVGAxisConfig
        , ("labels" .=) <$> labelsVGAxisConfig
        , ("maxExtent" .=) <$> maxExtentVGAxisConfig
        , ("minExtent" .=) <$> minExtentVGAxisConfig
        , ("tickColor" .=) <$> tickColorVGAxisConfig
        , ("tickRound" .=) <$> tickRoundVGAxisConfig
        , ("ticks" .=) <$> ticksVGAxisConfig
        , ("tickSize" .=) <$> tickSizeVGAxisConfig
        , ("tickWidth" .=) <$> tickWidthVGAxisConfig
        , ("titleAlign" .=) <$> titleAlignVGAxisConfig
        , ("titleAngle" .=) <$> titleAngleVGAxisConfig
        , ("titleBaseline" .=) <$> titleBaselineVGAxisConfig
        , ("titleColor" .=) <$> titleColorVGAxisConfig
        , ("titleFont" .=) <$> titleFontVGAxisConfig
        , ("titleFontSize" .=) <$> titleFontSizeVGAxisConfig
        , ("titleFontWeight" .=) <$> titleFontWeightVGAxisConfig
        , ("titleLimit" .=) <$> titleLimitVGAxisConfig
        , ("titleMaxLength" .=) <$> titleMaxLengthVGAxisConfig
        , ("titlePadding" .=) <$> titlePaddingVGAxisConfig
        , ("titleX" .=) <$> titleXVGAxisConfig
        , ("titleY" .=) <$> titleYVGAxisConfig
        ]

instance FromJSON VGAxisConfig where
    parseJSON (Object v) = VGAxisConfig
        <$> v .:! "bandPosition"
        <*> v .:! "domain"
        <*> v .:! "domainColor"
        <*> v .:! "domainWidth"
        <*> v .:! "grid"
        <*> v .:! "gridColor"
        <*> v .:! "gridDash"
        <*> v .:! "gridOpacity"
        <*> v .:! "gridWidth"
        <*> v .:! "labelAngle"
        <*> v .:! "labelBound"
        <*> v .:! "labelColor"
        <*> v .:! "labelFlush"
        <*> v .:! "labelFont"
        <*> v .:! "labelFontSize"
        <*> v .:! "labelLimit"
        <*> v .:! "labelOverlap"
        <*> v .:! "labelPadding"
        <*> v .:! "labels"
        <*> v .:! "maxExtent"
        <*> v .:! "minExtent"
        <*> v .:! "tickColor"
        <*> v .:! "tickRound"
        <*> v .:! "ticks"
        <*> v .:! "tickSize"
        <*> v .:! "tickWidth"
        <*> v .:! "titleAlign"
        <*> v .:! "titleAngle"
        <*> v .:! "titleBaseline"
        <*> v .:! "titleColor"
        <*> v .:! "titleFont"
        <*> v .:! "titleFontSize"
        <*> v .:! "titleFontWeight"
        <*> v .:! "titleLimit"
        <*> v .:! "titleMaxLength"
        <*> v .:! "titlePadding"
        <*> v .:! "titleX"
        <*> v .:! "titleY"

instance ToJSON BarConfig where
    toJSON (BarConfig alignBarConfig angleBarConfig baselineBarConfig binSpacingBarConfig colorBarConfig continuousBandSizeBarConfig cursorBarConfig discreteBandSizeBarConfig dxBarConfig dyBarConfig fillBarConfig filledBarConfig fillOpacityBarConfig fontBarConfig fontSizeBarConfig fontStyleBarConfig fontWeightBarConfig hrefBarConfig interpolateBarConfig limitBarConfig opacityBarConfig orientBarConfig radiusBarConfig shapeBarConfig sizeBarConfig strokeBarConfig strokeDashBarConfig strokeDashOffsetBarConfig strokeOpacityBarConfig strokeWidthBarConfig tensionBarConfig barConfigTextBarConfig thetaBarConfig) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignBarConfig
        , ("angle" .=) <$> angleBarConfig
        , ("baseline" .=) <$> baselineBarConfig
        , ("binSpacing" .=) <$> binSpacingBarConfig
        , ("color" .=) <$> colorBarConfig
        , ("continuousBandSize" .=) <$> continuousBandSizeBarConfig
        , ("cursor" .=) <$> cursorBarConfig
        , ("discreteBandSize" .=) <$> discreteBandSizeBarConfig
        , ("dx" .=) <$> dxBarConfig
        , ("dy" .=) <$> dyBarConfig
        , ("fill" .=) <$> fillBarConfig
        , ("filled" .=) <$> filledBarConfig
        , ("fillOpacity" .=) <$> fillOpacityBarConfig
        , ("font" .=) <$> fontBarConfig
        , ("fontSize" .=) <$> fontSizeBarConfig
        , ("fontStyle" .=) <$> fontStyleBarConfig
        , ("fontWeight" .=) <$> fontWeightBarConfig
        , ("href" .=) <$> hrefBarConfig
        , ("interpolate" .=) <$> interpolateBarConfig
        , ("limit" .=) <$> limitBarConfig
        , ("opacity" .=) <$> opacityBarConfig
        , ("orient" .=) <$> orientBarConfig
        , ("radius" .=) <$> radiusBarConfig
        , ("shape" .=) <$> shapeBarConfig
        , ("size" .=) <$> sizeBarConfig
        , ("stroke" .=) <$> strokeBarConfig
        , ("strokeDash" .=) <$> strokeDashBarConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetBarConfig
        , ("strokeOpacity" .=) <$> strokeOpacityBarConfig
        , ("strokeWidth" .=) <$> strokeWidthBarConfig
        , ("tension" .=) <$> tensionBarConfig
        , ("text" .=) <$> barConfigTextBarConfig
        , ("theta" .=) <$> thetaBarConfig
        ]

instance FromJSON BarConfig where
    parseJSON (Object v) = BarConfig
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "binSpacing"
        <*> v .:! "color"
        <*> v .:! "continuousBandSize"
        <*> v .:! "cursor"
        <*> v .:! "discreteBandSize"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "filled"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"

instance ToJSON TextConfig where
    toJSON (TextConfig alignTextConfig angleTextConfig baselineTextConfig colorTextConfig cursorTextConfig dxTextConfig dyTextConfig fillTextConfig filledTextConfig fillOpacityTextConfig fontTextConfig fontSizeTextConfig fontStyleTextConfig fontWeightTextConfig hrefTextConfig interpolateTextConfig limitTextConfig opacityTextConfig orientTextConfig radiusTextConfig shapeTextConfig shortTimeLabelsTextConfig sizeTextConfig strokeTextConfig strokeDashTextConfig strokeDashOffsetTextConfig strokeOpacityTextConfig strokeWidthTextConfig tensionTextConfig textConfigTextTextConfig thetaTextConfig) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignTextConfig
        , ("angle" .=) <$> angleTextConfig
        , ("baseline" .=) <$> baselineTextConfig
        , ("color" .=) <$> colorTextConfig
        , ("cursor" .=) <$> cursorTextConfig
        , ("dx" .=) <$> dxTextConfig
        , ("dy" .=) <$> dyTextConfig
        , ("fill" .=) <$> fillTextConfig
        , ("filled" .=) <$> filledTextConfig
        , ("fillOpacity" .=) <$> fillOpacityTextConfig
        , ("font" .=) <$> fontTextConfig
        , ("fontSize" .=) <$> fontSizeTextConfig
        , ("fontStyle" .=) <$> fontStyleTextConfig
        , ("fontWeight" .=) <$> fontWeightTextConfig
        , ("href" .=) <$> hrefTextConfig
        , ("interpolate" .=) <$> interpolateTextConfig
        , ("limit" .=) <$> limitTextConfig
        , ("opacity" .=) <$> opacityTextConfig
        , ("orient" .=) <$> orientTextConfig
        , ("radius" .=) <$> radiusTextConfig
        , ("shape" .=) <$> shapeTextConfig
        , ("shortTimeLabels" .=) <$> shortTimeLabelsTextConfig
        , ("size" .=) <$> sizeTextConfig
        , ("stroke" .=) <$> strokeTextConfig
        , ("strokeDash" .=) <$> strokeDashTextConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetTextConfig
        , ("strokeOpacity" .=) <$> strokeOpacityTextConfig
        , ("strokeWidth" .=) <$> strokeWidthTextConfig
        , ("tension" .=) <$> tensionTextConfig
        , ("text" .=) <$> textConfigTextTextConfig
        , ("theta" .=) <$> thetaTextConfig
        ]

instance FromJSON TextConfig where
    parseJSON (Object v) = TextConfig
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "color"
        <*> v .:! "cursor"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "filled"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "shortTimeLabels"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"

instance ToJSON FieldTitle where
    toJSON VerbalFieldTitle = "verbal"
    toJSON FunctionalFieldTitle = "functional"
    toJSON PlainFieldTitle = "plain"

instance FromJSON FieldTitle where
    parseJSON = withText "FieldTitle" parseText
        where
            parseText "verbal" = return VerbalFieldTitle
            parseText "functional" = return FunctionalFieldTitle
            parseText "plain" = return PlainFieldTitle

instance ToJSON InvalidValues where
    toJSON FilterInvalidValues = "filter"

instance FromJSON InvalidValues where
    parseJSON = withText "InvalidValues" parseText
        where
            parseText "filter" = return FilterInvalidValues

instance ToJSON LegendConfig where
    toJSON (LegendConfig cornerRadiusLegendConfig entryPaddingLegendConfig fillColorLegendConfig gradientHeightLegendConfig gradientLabelBaselineLegendConfig gradientLabelLimitLegendConfig gradientLabelOffsetLegendConfig gradientStrokeColorLegendConfig gradientStrokeWidthLegendConfig gradientWidthLegendConfig labelAlignLegendConfig labelBaselineLegendConfig labelColorLegendConfig labelFontLegendConfig labelFontSizeLegendConfig labelLimitLegendConfig labelOffsetLegendConfig offsetLegendConfig orientLegendConfig paddingLegendConfig shortTimeLabelsLegendConfig strokeColorLegendConfig strokeDashLegendConfig strokeWidthLegendConfig symbolColorLegendConfig symbolSizeLegendConfig symbolStrokeWidthLegendConfig symbolTypeLegendConfig titleAlignLegendConfig titleBaselineLegendConfig titleColorLegendConfig titleFontLegendConfig titleFontSizeLegendConfig titleFontWeightLegendConfig titleLimitLegendConfig titlePaddingLegendConfig) =
        object $ foldMap (maybe [] pure)
        [ ("cornerRadius" .=) <$> cornerRadiusLegendConfig
        , ("entryPadding" .=) <$> entryPaddingLegendConfig
        , ("fillColor" .=) <$> fillColorLegendConfig
        , ("gradientHeight" .=) <$> gradientHeightLegendConfig
        , ("gradientLabelBaseline" .=) <$> gradientLabelBaselineLegendConfig
        , ("gradientLabelLimit" .=) <$> gradientLabelLimitLegendConfig
        , ("gradientLabelOffset" .=) <$> gradientLabelOffsetLegendConfig
        , ("gradientStrokeColor" .=) <$> gradientStrokeColorLegendConfig
        , ("gradientStrokeWidth" .=) <$> gradientStrokeWidthLegendConfig
        , ("gradientWidth" .=) <$> gradientWidthLegendConfig
        , ("labelAlign" .=) <$> labelAlignLegendConfig
        , ("labelBaseline" .=) <$> labelBaselineLegendConfig
        , ("labelColor" .=) <$> labelColorLegendConfig
        , ("labelFont" .=) <$> labelFontLegendConfig
        , ("labelFontSize" .=) <$> labelFontSizeLegendConfig
        , ("labelLimit" .=) <$> labelLimitLegendConfig
        , ("labelOffset" .=) <$> labelOffsetLegendConfig
        , ("offset" .=) <$> offsetLegendConfig
        , ("orient" .=) <$> orientLegendConfig
        , ("padding" .=) <$> paddingLegendConfig
        , ("shortTimeLabels" .=) <$> shortTimeLabelsLegendConfig
        , ("strokeColor" .=) <$> strokeColorLegendConfig
        , ("strokeDash" .=) <$> strokeDashLegendConfig
        , ("strokeWidth" .=) <$> strokeWidthLegendConfig
        , ("symbolColor" .=) <$> symbolColorLegendConfig
        , ("symbolSize" .=) <$> symbolSizeLegendConfig
        , ("symbolStrokeWidth" .=) <$> symbolStrokeWidthLegendConfig
        , ("symbolType" .=) <$> symbolTypeLegendConfig
        , ("titleAlign" .=) <$> titleAlignLegendConfig
        , ("titleBaseline" .=) <$> titleBaselineLegendConfig
        , ("titleColor" .=) <$> titleColorLegendConfig
        , ("titleFont" .=) <$> titleFontLegendConfig
        , ("titleFontSize" .=) <$> titleFontSizeLegendConfig
        , ("titleFontWeight" .=) <$> titleFontWeightLegendConfig
        , ("titleLimit" .=) <$> titleLimitLegendConfig
        , ("titlePadding" .=) <$> titlePaddingLegendConfig
        ]

instance FromJSON LegendConfig where
    parseJSON (Object v) = LegendConfig
        <$> v .:! "cornerRadius"
        <*> v .:! "entryPadding"
        <*> v .:! "fillColor"
        <*> v .:! "gradientHeight"
        <*> v .:! "gradientLabelBaseline"
        <*> v .:! "gradientLabelLimit"
        <*> v .:! "gradientLabelOffset"
        <*> v .:! "gradientStrokeColor"
        <*> v .:! "gradientStrokeWidth"
        <*> v .:! "gradientWidth"
        <*> v .:! "labelAlign"
        <*> v .:! "labelBaseline"
        <*> v .:! "labelColor"
        <*> v .:! "labelFont"
        <*> v .:! "labelFontSize"
        <*> v .:! "labelLimit"
        <*> v .:! "labelOffset"
        <*> v .:! "offset"
        <*> v .:! "orient"
        <*> v .:! "padding"
        <*> v .:! "shortTimeLabels"
        <*> v .:! "strokeColor"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeWidth"
        <*> v .:! "symbolColor"
        <*> v .:! "symbolSize"
        <*> v .:! "symbolStrokeWidth"
        <*> v .:! "symbolType"
        <*> v .:! "titleAlign"
        <*> v .:! "titleBaseline"
        <*> v .:! "titleColor"
        <*> v .:! "titleFont"
        <*> v .:! "titleFontSize"
        <*> v .:! "titleFontWeight"
        <*> v .:! "titleLimit"
        <*> v .:! "titlePadding"

instance ToJSON LegendOrient where
    toJSON LeftLegendOrient = "left"
    toJSON RightLegendOrient = "right"
    toJSON TopLeftLegendOrient = "top-left"
    toJSON TopRightLegendOrient = "top-right"
    toJSON BottomLeftLegendOrient = "bottom-left"
    toJSON BottomRightLegendOrient = "bottom-right"
    toJSON NoneLegendOrient = "none"

instance FromJSON LegendOrient where
    parseJSON = withText "LegendOrient" parseText
        where
            parseText "left" = return LeftLegendOrient
            parseText "right" = return RightLegendOrient
            parseText "top-left" = return TopLeftLegendOrient
            parseText "top-right" = return TopRightLegendOrient
            parseText "bottom-left" = return BottomLeftLegendOrient
            parseText "bottom-right" = return BottomRightLegendOrient
            parseText "none" = return NoneLegendOrient

instance ToJSON Padding where
    toJSON (DoubleInPadding x) = toJSON x
    toJSON (PaddingClassInPadding x) = toJSON x

instance FromJSON Padding where
    parseJSON xs@(Number _) = (fmap DoubleInPadding . parseJSON) xs
    parseJSON xs@(Object _) = (fmap PaddingClassInPadding . parseJSON) xs

instance ToJSON PaddingClass where
    toJSON (PaddingClass bottomPaddingClass leftPaddingClass rightPaddingClass topPaddingClass) =
        object $ foldMap (maybe [] pure)
        [ ("bottom" .=) <$> bottomPaddingClass
        , ("left" .=) <$> leftPaddingClass
        , ("right" .=) <$> rightPaddingClass
        , ("top" .=) <$> topPaddingClass
        ]

instance FromJSON PaddingClass where
    parseJSON (Object v) = PaddingClass
        <$> v .:! "bottom"
        <*> v .:! "left"
        <*> v .:! "right"
        <*> v .:! "top"

instance ToJSON ProjectionConfig where
    toJSON (ProjectionConfig centerProjectionConfig clipAngleProjectionConfig clipExtentProjectionConfig coefficientProjectionConfig distanceProjectionConfig fractionProjectionConfig lobesProjectionConfig parallelProjectionConfig precisionProjectionConfig radiusProjectionConfig ratioProjectionConfig rotateProjectionConfig spacingProjectionConfig tiltProjectionConfig projectionConfigTypeProjectionConfig) =
        object $ foldMap (maybe [] pure)
        [ ("center" .=) <$> centerProjectionConfig
        , ("clipAngle" .=) <$> clipAngleProjectionConfig
        , ("clipExtent" .=) <$> clipExtentProjectionConfig
        , ("coefficient" .=) <$> coefficientProjectionConfig
        , ("distance" .=) <$> distanceProjectionConfig
        , ("fraction" .=) <$> fractionProjectionConfig
        , ("lobes" .=) <$> lobesProjectionConfig
        , ("parallel" .=) <$> parallelProjectionConfig
        , ("precision" .=) <$> precisionProjectionConfig
        , ("radius" .=) <$> radiusProjectionConfig
        , ("ratio" .=) <$> ratioProjectionConfig
        , ("rotate" .=) <$> rotateProjectionConfig
        , ("spacing" .=) <$> spacingProjectionConfig
        , ("tilt" .=) <$> tiltProjectionConfig
        , ("type" .=) <$> projectionConfigTypeProjectionConfig
        ]

instance FromJSON ProjectionConfig where
    parseJSON (Object v) = ProjectionConfig
        <$> v .:! "center"
        <*> v .:! "clipAngle"
        <*> v .:! "clipExtent"
        <*> v .:! "coefficient"
        <*> v .:! "distance"
        <*> v .:! "fraction"
        <*> v .:! "lobes"
        <*> v .:! "parallel"
        <*> v .:! "precision"
        <*> v .:! "radius"
        <*> v .:! "ratio"
        <*> v .:! "rotate"
        <*> v .:! "spacing"
        <*> v .:! "tilt"
        <*> v .:! "type"

instance ToJSON VGProjectionType where
    toJSON AlbersVGProjectionType = "albers"
    toJSON AlbersUsaVGProjectionType = "albersUsa"
    toJSON AzimuthalEqualAreaVGProjectionType = "azimuthalEqualArea"
    toJSON AzimuthalEquidistantVGProjectionType = "azimuthalEquidistant"
    toJSON ConicConformalVGProjectionType = "conicConformal"
    toJSON ConicEqualAreaVGProjectionType = "conicEqualArea"
    toJSON ConicEquidistantVGProjectionType = "conicEquidistant"
    toJSON EquirectangularVGProjectionType = "equirectangular"
    toJSON GnomonicVGProjectionType = "gnomonic"
    toJSON MercatorVGProjectionType = "mercator"
    toJSON OrthographicVGProjectionType = "orthographic"
    toJSON StereographicVGProjectionType = "stereographic"
    toJSON TransverseMercatorVGProjectionType = "transverseMercator"

instance FromJSON VGProjectionType where
    parseJSON = withText "VGProjectionType" parseText
        where
            parseText "albers" = return AlbersVGProjectionType
            parseText "albersUsa" = return AlbersUsaVGProjectionType
            parseText "azimuthalEqualArea" = return AzimuthalEqualAreaVGProjectionType
            parseText "azimuthalEquidistant" = return AzimuthalEquidistantVGProjectionType
            parseText "conicConformal" = return ConicConformalVGProjectionType
            parseText "conicEqualArea" = return ConicEqualAreaVGProjectionType
            parseText "conicEquidistant" = return ConicEquidistantVGProjectionType
            parseText "equirectangular" = return EquirectangularVGProjectionType
            parseText "gnomonic" = return GnomonicVGProjectionType
            parseText "mercator" = return MercatorVGProjectionType
            parseText "orthographic" = return OrthographicVGProjectionType
            parseText "stereographic" = return StereographicVGProjectionType
            parseText "transverseMercator" = return TransverseMercatorVGProjectionType

instance ToJSON RangeConfigValue where
    toJSON (UnionArrayInRangeConfigValue x) = toJSON x
    toJSON (VGSchemeInRangeConfigValue x) = toJSON x

instance FromJSON RangeConfigValue where
    parseJSON xs@(Array _) = (fmap UnionArrayInRangeConfigValue . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VGSchemeInRangeConfigValue . parseJSON) xs

instance ToJSON VGScheme where
    toJSON (VGScheme countVGScheme extentVGScheme schemeVGScheme stepVGScheme) =
        object $ foldMap (maybe [] pure)
        [ ("count" .=) <$> countVGScheme
        , ("extent" .=) <$> extentVGScheme
        , ("scheme" .=) <$> schemeVGScheme
        , ("step" .=) <$> stepVGScheme
        ]

instance FromJSON VGScheme where
    parseJSON (Object v) = VGScheme
        <$> v .:! "count"
        <*> v .:! "extent"
        <*> v .:! "scheme"
        <*> v .:! "step"

instance ToJSON ScaleConfig where
    toJSON (ScaleConfig bandPaddingInnerScaleConfig bandPaddingOuterScaleConfig clampScaleConfig continuousPaddingScaleConfig maxBandSizeScaleConfig maxFontSizeScaleConfig maxOpacityScaleConfig maxSizeScaleConfig maxStrokeWidthScaleConfig minBandSizeScaleConfig minFontSizeScaleConfig minOpacityScaleConfig minSizeScaleConfig minStrokeWidthScaleConfig pointPaddingScaleConfig rangeStepScaleConfig roundScaleConfig textXRangeStepScaleConfig useUnaggregatedDomainScaleConfig) =
        object $ foldMap (maybe [] pure)
        [ ("bandPaddingInner" .=) <$> bandPaddingInnerScaleConfig
        , ("bandPaddingOuter" .=) <$> bandPaddingOuterScaleConfig
        , ("clamp" .=) <$> clampScaleConfig
        , ("continuousPadding" .=) <$> continuousPaddingScaleConfig
        , ("maxBandSize" .=) <$> maxBandSizeScaleConfig
        , ("maxFontSize" .=) <$> maxFontSizeScaleConfig
        , ("maxOpacity" .=) <$> maxOpacityScaleConfig
        , ("maxSize" .=) <$> maxSizeScaleConfig
        , ("maxStrokeWidth" .=) <$> maxStrokeWidthScaleConfig
        , ("minBandSize" .=) <$> minBandSizeScaleConfig
        , ("minFontSize" .=) <$> minFontSizeScaleConfig
        , ("minOpacity" .=) <$> minOpacityScaleConfig
        , ("minSize" .=) <$> minSizeScaleConfig
        , ("minStrokeWidth" .=) <$> minStrokeWidthScaleConfig
        , ("pointPadding" .=) <$> pointPaddingScaleConfig
        , ("rangeStep" .=) <$> rangeStepScaleConfig
        , ("round" .=) <$> roundScaleConfig
        , ("textXRangeStep" .=) <$> textXRangeStepScaleConfig
        , ("useUnaggregatedDomain" .=) <$> useUnaggregatedDomainScaleConfig
        ]

instance FromJSON ScaleConfig where
    parseJSON (Object v) = ScaleConfig
        <$> v .:! "bandPaddingInner"
        <*> v .:! "bandPaddingOuter"
        <*> v .:! "clamp"
        <*> v .:! "continuousPadding"
        <*> v .:! "maxBandSize"
        <*> v .:! "maxFontSize"
        <*> v .:! "maxOpacity"
        <*> v .:! "maxSize"
        <*> v .:! "maxStrokeWidth"
        <*> v .:! "minBandSize"
        <*> v .:! "minFontSize"
        <*> v .:! "minOpacity"
        <*> v .:! "minSize"
        <*> v .:! "minStrokeWidth"
        <*> v .:! "pointPadding"
        <*> v .:! "rangeStep"
        <*> v .:! "round"
        <*> v .:! "textXRangeStep"
        <*> v .:! "useUnaggregatedDomain"

instance ToJSON SelectionConfig where
    toJSON (SelectionConfig intervalSelectionConfig multiSelectionConfig singleSelectionConfig) =
        object $ foldMap (maybe [] pure)
        [ ("interval" .=) <$> intervalSelectionConfig
        , ("multi" .=) <$> multiSelectionConfig
        , ("single" .=) <$> singleSelectionConfig
        ]

instance FromJSON SelectionConfig where
    parseJSON (Object v) = SelectionConfig
        <$> v .:! "interval"
        <*> v .:! "multi"
        <*> v .:! "single"

instance ToJSON IntervalSelectionConfig where
    toJSON (IntervalSelectionConfig bindIntervalSelectionConfig emptyIntervalSelectionConfig encodingsIntervalSelectionConfig fieldsIntervalSelectionConfig markIntervalSelectionConfig onIntervalSelectionConfig resolveIntervalSelectionConfig translateIntervalSelectionConfig zoomIntervalSelectionConfig) =
        object $ foldMap (maybe [] pure)
        [ ("bind" .=) <$> bindIntervalSelectionConfig
        , ("empty" .=) <$> emptyIntervalSelectionConfig
        , ("encodings" .=) <$> encodingsIntervalSelectionConfig
        , ("fields" .=) <$> fieldsIntervalSelectionConfig
        , ("mark" .=) <$> markIntervalSelectionConfig
        , ("on" .=) <$> onIntervalSelectionConfig
        , ("resolve" .=) <$> resolveIntervalSelectionConfig
        , ("translate" .=) <$> translateIntervalSelectionConfig
        , ("zoom" .=) <$> zoomIntervalSelectionConfig
        ]

instance FromJSON IntervalSelectionConfig where
    parseJSON (Object v) = IntervalSelectionConfig
        <$> v .:! "bind"
        <*> v .:! "empty"
        <*> v .:! "encodings"
        <*> v .:! "fields"
        <*> v .:! "mark"
        <*> v .:! "on"
        <*> v .:! "resolve"
        <*> v .:! "translate"
        <*> v .:! "zoom"

instance ToJSON BindEnum where
    toJSON ScalesBindEnum = "scales"

instance FromJSON BindEnum where
    parseJSON = withText "BindEnum" parseText
        where
            parseText "scales" = return ScalesBindEnum

instance ToJSON Empty where
    toJSON AllEmpty = "all"
    toJSON NoneEmpty = "none"

instance FromJSON Empty where
    parseJSON = withText "Empty" parseText
        where
            parseText "all" = return AllEmpty
            parseText "none" = return NoneEmpty

instance ToJSON SingleDefChannel where
    toJSON XSingleDefChannel = "x"
    toJSON YSingleDefChannel = "y"
    toJSON X2SingleDefChannel = "x2"
    toJSON Y2SingleDefChannel = "y2"
    toJSON RowSingleDefChannel = "row"
    toJSON ColumnSingleDefChannel = "column"
    toJSON SizeSingleDefChannel = "size"
    toJSON ShapeSingleDefChannel = "shape"
    toJSON ColorSingleDefChannel = "color"
    toJSON OpacitySingleDefChannel = "opacity"
    toJSON TextSingleDefChannel = "text"
    toJSON TooltipSingleDefChannel = "tooltip"
    toJSON HrefSingleDefChannel = "href"

instance FromJSON SingleDefChannel where
    parseJSON = withText "SingleDefChannel" parseText
        where
            parseText "x" = return XSingleDefChannel
            parseText "y" = return YSingleDefChannel
            parseText "x2" = return X2SingleDefChannel
            parseText "y2" = return Y2SingleDefChannel
            parseText "row" = return RowSingleDefChannel
            parseText "column" = return ColumnSingleDefChannel
            parseText "size" = return SizeSingleDefChannel
            parseText "shape" = return ShapeSingleDefChannel
            parseText "color" = return ColorSingleDefChannel
            parseText "opacity" = return OpacitySingleDefChannel
            parseText "text" = return TextSingleDefChannel
            parseText "tooltip" = return TooltipSingleDefChannel
            parseText "href" = return HrefSingleDefChannel

instance ToJSON BrushConfig where
    toJSON (BrushConfig fillBrushConfig fillOpacityBrushConfig strokeBrushConfig strokeDashBrushConfig strokeDashOffsetBrushConfig strokeOpacityBrushConfig strokeWidthBrushConfig) =
        object $ foldMap (maybe [] pure)
        [ ("fill" .=) <$> fillBrushConfig
        , ("fillOpacity" .=) <$> fillOpacityBrushConfig
        , ("stroke" .=) <$> strokeBrushConfig
        , ("strokeDash" .=) <$> strokeDashBrushConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetBrushConfig
        , ("strokeOpacity" .=) <$> strokeOpacityBrushConfig
        , ("strokeWidth" .=) <$> strokeWidthBrushConfig
        ]

instance FromJSON BrushConfig where
    parseJSON (Object v) = BrushConfig
        <$> v .:! "fill"
        <*> v .:! "fillOpacity"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"

instance ToJSON SelectionResolution where
    toJSON GlobalSelectionResolution = "global"
    toJSON UnionSelectionResolution = "union"
    toJSON IntersectSelectionResolution = "intersect"

instance FromJSON SelectionResolution where
    parseJSON = withText "SelectionResolution" parseText
        where
            parseText "global" = return GlobalSelectionResolution
            parseText "union" = return UnionSelectionResolution
            parseText "intersect" = return IntersectSelectionResolution

instance ToJSON Translate where
    toJSON (BoolInTranslate x) = toJSON x
    toJSON (StringInTranslate x) = toJSON x

instance FromJSON Translate where
    parseJSON xs@(Bool _) = (fmap BoolInTranslate . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInTranslate . parseJSON) xs

instance ToJSON MultiSelectionConfig where
    toJSON (MultiSelectionConfig emptyMultiSelectionConfig encodingsMultiSelectionConfig fieldsMultiSelectionConfig nearestMultiSelectionConfig onMultiSelectionConfig resolveMultiSelectionConfig toggleMultiSelectionConfig) =
        object $ foldMap (maybe [] pure)
        [ ("empty" .=) <$> emptyMultiSelectionConfig
        , ("encodings" .=) <$> encodingsMultiSelectionConfig
        , ("fields" .=) <$> fieldsMultiSelectionConfig
        , ("nearest" .=) <$> nearestMultiSelectionConfig
        , ("on" .=) <$> onMultiSelectionConfig
        , ("resolve" .=) <$> resolveMultiSelectionConfig
        , ("toggle" .=) <$> toggleMultiSelectionConfig
        ]

instance FromJSON MultiSelectionConfig where
    parseJSON (Object v) = MultiSelectionConfig
        <$> v .:! "empty"
        <*> v .:! "encodings"
        <*> v .:! "fields"
        <*> v .:! "nearest"
        <*> v .:! "on"
        <*> v .:! "resolve"
        <*> v .:! "toggle"

instance ToJSON SingleSelectionConfig where
    toJSON (SingleSelectionConfig bindSingleSelectionConfig emptySingleSelectionConfig encodingsSingleSelectionConfig fieldsSingleSelectionConfig nearestSingleSelectionConfig onSingleSelectionConfig resolveSingleSelectionConfig) =
        object $ foldMap (maybe [] pure)
        [ ("bind" .=) <$> bindSingleSelectionConfig
        , ("empty" .=) <$> emptySingleSelectionConfig
        , ("encodings" .=) <$> encodingsSingleSelectionConfig
        , ("fields" .=) <$> fieldsSingleSelectionConfig
        , ("nearest" .=) <$> nearestSingleSelectionConfig
        , ("on" .=) <$> onSingleSelectionConfig
        , ("resolve" .=) <$> resolveSingleSelectionConfig
        ]

instance FromJSON SingleSelectionConfig where
    parseJSON (Object v) = SingleSelectionConfig
        <$> v .:! "bind"
        <*> v .:! "empty"
        <*> v .:! "encodings"
        <*> v .:! "fields"
        <*> v .:! "nearest"
        <*> v .:! "on"
        <*> v .:! "resolve"

instance ToJSON VGBinding where
    toJSON (VGBinding elementVGBinding inputVGBinding optionsVGBinding maxVGBinding minVGBinding stepVGBinding) =
        object $ foldMap (maybe [] pure)
        [ ("element" .=) <$> elementVGBinding
        , Just $ "input" .= inputVGBinding
        , ("options" .=) <$> optionsVGBinding
        , ("max" .=) <$> maxVGBinding
        , ("min" .=) <$> minVGBinding
        , ("step" .=) <$> stepVGBinding
        ]

instance FromJSON VGBinding where
    parseJSON (Object v) = VGBinding
        <$> v .:! "element"
        <*> v .: "input"
        <*> v .:! "options"
        <*> v .:! "max"
        <*> v .:! "min"
        <*> v .:! "step"

instance ToJSON StackOffset where
    toJSON ZeroStackOffset = "zero"
    toJSON CenterStackOffset = "center"
    toJSON NormalizeStackOffset = "normalize"

instance FromJSON StackOffset where
    parseJSON = withText "StackOffset" parseText
        where
            parseText "zero" = return ZeroStackOffset
            parseText "center" = return CenterStackOffset
            parseText "normalize" = return NormalizeStackOffset

instance ToJSON VGMarkConfig where
    toJSON (VGMarkConfig alignVGMarkConfig angleVGMarkConfig baselineVGMarkConfig cursorVGMarkConfig dxVGMarkConfig dyVGMarkConfig fillVGMarkConfig fillOpacityVGMarkConfig fontVGMarkConfig fontSizeVGMarkConfig fontStyleVGMarkConfig fontWeightVGMarkConfig hrefVGMarkConfig interpolateVGMarkConfig limitVGMarkConfig opacityVGMarkConfig orientVGMarkConfig radiusVGMarkConfig shapeVGMarkConfig sizeVGMarkConfig strokeVGMarkConfig strokeDashVGMarkConfig strokeDashOffsetVGMarkConfig strokeOpacityVGMarkConfig strokeWidthVGMarkConfig tensionVGMarkConfig vgMarkConfigTextVGMarkConfig thetaVGMarkConfig) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignVGMarkConfig
        , ("angle" .=) <$> angleVGMarkConfig
        , ("baseline" .=) <$> baselineVGMarkConfig
        , ("cursor" .=) <$> cursorVGMarkConfig
        , ("dx" .=) <$> dxVGMarkConfig
        , ("dy" .=) <$> dyVGMarkConfig
        , ("fill" .=) <$> fillVGMarkConfig
        , ("fillOpacity" .=) <$> fillOpacityVGMarkConfig
        , ("font" .=) <$> fontVGMarkConfig
        , ("fontSize" .=) <$> fontSizeVGMarkConfig
        , ("fontStyle" .=) <$> fontStyleVGMarkConfig
        , ("fontWeight" .=) <$> fontWeightVGMarkConfig
        , ("href" .=) <$> hrefVGMarkConfig
        , ("interpolate" .=) <$> interpolateVGMarkConfig
        , ("limit" .=) <$> limitVGMarkConfig
        , ("opacity" .=) <$> opacityVGMarkConfig
        , ("orient" .=) <$> orientVGMarkConfig
        , ("radius" .=) <$> radiusVGMarkConfig
        , ("shape" .=) <$> shapeVGMarkConfig
        , ("size" .=) <$> sizeVGMarkConfig
        , ("stroke" .=) <$> strokeVGMarkConfig
        , ("strokeDash" .=) <$> strokeDashVGMarkConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetVGMarkConfig
        , ("strokeOpacity" .=) <$> strokeOpacityVGMarkConfig
        , ("strokeWidth" .=) <$> strokeWidthVGMarkConfig
        , ("tension" .=) <$> tensionVGMarkConfig
        , ("text" .=) <$> vgMarkConfigTextVGMarkConfig
        , ("theta" .=) <$> thetaVGMarkConfig
        ]

instance FromJSON VGMarkConfig where
    parseJSON (Object v) = VGMarkConfig
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "cursor"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"

instance ToJSON TickConfig where
    toJSON (TickConfig alignTickConfig angleTickConfig bandSizeTickConfig baselineTickConfig colorTickConfig cursorTickConfig dxTickConfig dyTickConfig fillTickConfig filledTickConfig fillOpacityTickConfig fontTickConfig fontSizeTickConfig fontStyleTickConfig fontWeightTickConfig hrefTickConfig interpolateTickConfig limitTickConfig opacityTickConfig orientTickConfig radiusTickConfig shapeTickConfig sizeTickConfig strokeTickConfig strokeDashTickConfig strokeDashOffsetTickConfig strokeOpacityTickConfig strokeWidthTickConfig tensionTickConfig tickConfigTextTickConfig thetaTickConfig thicknessTickConfig) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignTickConfig
        , ("angle" .=) <$> angleTickConfig
        , ("bandSize" .=) <$> bandSizeTickConfig
        , ("baseline" .=) <$> baselineTickConfig
        , ("color" .=) <$> colorTickConfig
        , ("cursor" .=) <$> cursorTickConfig
        , ("dx" .=) <$> dxTickConfig
        , ("dy" .=) <$> dyTickConfig
        , ("fill" .=) <$> fillTickConfig
        , ("filled" .=) <$> filledTickConfig
        , ("fillOpacity" .=) <$> fillOpacityTickConfig
        , ("font" .=) <$> fontTickConfig
        , ("fontSize" .=) <$> fontSizeTickConfig
        , ("fontStyle" .=) <$> fontStyleTickConfig
        , ("fontWeight" .=) <$> fontWeightTickConfig
        , ("href" .=) <$> hrefTickConfig
        , ("interpolate" .=) <$> interpolateTickConfig
        , ("limit" .=) <$> limitTickConfig
        , ("opacity" .=) <$> opacityTickConfig
        , ("orient" .=) <$> orientTickConfig
        , ("radius" .=) <$> radiusTickConfig
        , ("shape" .=) <$> shapeTickConfig
        , ("size" .=) <$> sizeTickConfig
        , ("stroke" .=) <$> strokeTickConfig
        , ("strokeDash" .=) <$> strokeDashTickConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetTickConfig
        , ("strokeOpacity" .=) <$> strokeOpacityTickConfig
        , ("strokeWidth" .=) <$> strokeWidthTickConfig
        , ("tension" .=) <$> tensionTickConfig
        , ("text" .=) <$> tickConfigTextTickConfig
        , ("theta" .=) <$> thetaTickConfig
        , ("thickness" .=) <$> thicknessTickConfig
        ]

instance FromJSON TickConfig where
    parseJSON (Object v) = TickConfig
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "bandSize"
        <*> v .:! "baseline"
        <*> v .:! "color"
        <*> v .:! "cursor"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "filled"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"
        <*> v .:! "thickness"

instance ToJSON VGTitleConfig where
    toJSON (VGTitleConfig anchorVGTitleConfig angleVGTitleConfig baselineVGTitleConfig colorVGTitleConfig fontVGTitleConfig fontSizeVGTitleConfig fontWeightVGTitleConfig limitVGTitleConfig offsetVGTitleConfig orientVGTitleConfig) =
        object $ foldMap (maybe [] pure)
        [ ("anchor" .=) <$> anchorVGTitleConfig
        , ("angle" .=) <$> angleVGTitleConfig
        , ("baseline" .=) <$> baselineVGTitleConfig
        , ("color" .=) <$> colorVGTitleConfig
        , ("font" .=) <$> fontVGTitleConfig
        , ("fontSize" .=) <$> fontSizeVGTitleConfig
        , ("fontWeight" .=) <$> fontWeightVGTitleConfig
        , ("limit" .=) <$> limitVGTitleConfig
        , ("offset" .=) <$> offsetVGTitleConfig
        , ("orient" .=) <$> orientVGTitleConfig
        ]

instance FromJSON VGTitleConfig where
    parseJSON (Object v) = VGTitleConfig
        <$> v .:! "anchor"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "color"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontWeight"
        <*> v .:! "limit"
        <*> v .:! "offset"
        <*> v .:! "orient"

instance ToJSON Anchor where
    toJSON StartAnchor = "start"
    toJSON MiddleAnchor = "middle"
    toJSON EndAnchor = "end"

instance FromJSON Anchor where
    parseJSON = withText "Anchor" parseText
        where
            parseText "start" = return StartAnchor
            parseText "middle" = return MiddleAnchor
            parseText "end" = return EndAnchor

instance ToJSON TitleOrient where
    toJSON TopTitleOrient = "top"
    toJSON BottomTitleOrient = "bottom"
    toJSON LeftTitleOrient = "left"
    toJSON RightTitleOrient = "right"

instance FromJSON TitleOrient where
    parseJSON = withText "TitleOrient" parseText
        where
            parseText "top" = return TopTitleOrient
            parseText "bottom" = return BottomTitleOrient
            parseText "left" = return LeftTitleOrient
            parseText "right" = return RightTitleOrient

instance ToJSON ViewConfig where
    toJSON (ViewConfig clipViewConfig fillViewConfig fillOpacityViewConfig heightViewConfig strokeViewConfig strokeDashViewConfig strokeDashOffsetViewConfig strokeOpacityViewConfig strokeWidthViewConfig widthViewConfig) =
        object $ foldMap (maybe [] pure)
        [ ("clip" .=) <$> clipViewConfig
        , ("fill" .=) <$> fillViewConfig
        , ("fillOpacity" .=) <$> fillOpacityViewConfig
        , ("height" .=) <$> heightViewConfig
        , ("stroke" .=) <$> strokeViewConfig
        , ("strokeDash" .=) <$> strokeDashViewConfig
        , ("strokeDashOffset" .=) <$> strokeDashOffsetViewConfig
        , ("strokeOpacity" .=) <$> strokeOpacityViewConfig
        , ("strokeWidth" .=) <$> strokeWidthViewConfig
        , ("width" .=) <$> widthViewConfig
        ]

instance FromJSON ViewConfig where
    parseJSON (Object v) = ViewConfig
        <$> v .:! "clip"
        <*> v .:! "fill"
        <*> v .:! "fillOpacity"
        <*> v .:! "height"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "width"

instance ToJSON EncodingWithFacet where
    toJSON (EncodingWithFacet colorEncodingWithFacet columnEncodingWithFacet detailEncodingWithFacet hrefEncodingWithFacet opacityEncodingWithFacet orderEncodingWithFacet rowEncodingWithFacet shapeEncodingWithFacet sizeEncodingWithFacet encodingWithFacetTextEncodingWithFacet tooltipEncodingWithFacet xEncodingWithFacet x2EncodingWithFacet yEncodingWithFacet y2EncodingWithFacet) =
        object $ foldMap (maybe [] pure)
        [ ("color" .=) <$> colorEncodingWithFacet
        , ("column" .=) <$> columnEncodingWithFacet
        , ("detail" .=) <$> detailEncodingWithFacet
        , ("href" .=) <$> hrefEncodingWithFacet
        , ("opacity" .=) <$> opacityEncodingWithFacet
        , ("order" .=) <$> orderEncodingWithFacet
        , ("row" .=) <$> rowEncodingWithFacet
        , ("shape" .=) <$> shapeEncodingWithFacet
        , ("size" .=) <$> sizeEncodingWithFacet
        , ("text" .=) <$> encodingWithFacetTextEncodingWithFacet
        , ("tooltip" .=) <$> tooltipEncodingWithFacet
        , ("x" .=) <$> xEncodingWithFacet
        , ("x2" .=) <$> x2EncodingWithFacet
        , ("y" .=) <$> yEncodingWithFacet
        , ("y2" .=) <$> y2EncodingWithFacet
        ]

instance FromJSON EncodingWithFacet where
    parseJSON (Object v) = EncodingWithFacet
        <$> v .:! "color"
        <*> v .:! "column"
        <*> v .:! "detail"
        <*> v .:! "href"
        <*> v .:! "opacity"
        <*> v .:! "order"
        <*> v .:! "row"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "text"
        <*> v .:! "tooltip"
        <*> v .:! "x"
        <*> v .:! "x2"
        <*> v .:! "y"
        <*> v .:! "y2"

instance ToJSON MarkPropDefWithCondition where
    toJSON (MarkPropDefWithCondition aggregateMarkPropDefWithCondition binMarkPropDefWithCondition conditionMarkPropDefWithCondition fieldMarkPropDefWithCondition legendMarkPropDefWithCondition scaleMarkPropDefWithCondition sortMarkPropDefWithCondition timeUnitMarkPropDefWithCondition markPropDefWithConditionTypeMarkPropDefWithCondition valueMarkPropDefWithCondition) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateMarkPropDefWithCondition
        , ("bin" .=) <$> binMarkPropDefWithCondition
        , ("condition" .=) <$> conditionMarkPropDefWithCondition
        , ("field" .=) <$> fieldMarkPropDefWithCondition
        , ("legend" .=) <$> legendMarkPropDefWithCondition
        , ("scale" .=) <$> scaleMarkPropDefWithCondition
        , ("sort" .=) <$> sortMarkPropDefWithCondition
        , ("timeUnit" .=) <$> timeUnitMarkPropDefWithCondition
        , ("type" .=) <$> markPropDefWithConditionTypeMarkPropDefWithCondition
        , ("value" .=) <$> valueMarkPropDefWithCondition
        ]

instance FromJSON MarkPropDefWithCondition where
    parseJSON (Object v) = MarkPropDefWithCondition
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "condition"
        <*> v .:! "field"
        <*> v .:! "legend"
        <*> v .:! "scale"
        <*> v .:! "sort"
        <*> v .:! "timeUnit"
        <*> v .:! "type"
        <*> v .:! "value"

instance ToJSON AggregateOp where
    toJSON ArgmaxAggregateOp = "argmax"
    toJSON ArgminAggregateOp = "argmin"
    toJSON AverageAggregateOp = "average"
    toJSON CountAggregateOp = "count"
    toJSON DistinctAggregateOp = "distinct"
    toJSON MaxAggregateOp = "max"
    toJSON MeanAggregateOp = "mean"
    toJSON MedianAggregateOp = "median"
    toJSON MinAggregateOp = "min"
    toJSON MissingAggregateOp = "missing"
    toJSON Q1AggregateOp = "q1"
    toJSON Q3AggregateOp = "q3"
    toJSON Ci0AggregateOp = "ci0"
    toJSON Ci1AggregateOp = "ci1"
    toJSON StdevAggregateOp = "stdev"
    toJSON StdevpAggregateOp = "stdevp"
    toJSON SumAggregateOp = "sum"
    toJSON ValidAggregateOp = "valid"
    toJSON ValuesAggregateOp = "values"
    toJSON VarianceAggregateOp = "variance"
    toJSON VariancepAggregateOp = "variancep"

instance FromJSON AggregateOp where
    parseJSON = withText "AggregateOp" parseText
        where
            parseText "argmax" = return ArgmaxAggregateOp
            parseText "argmin" = return ArgminAggregateOp
            parseText "average" = return AverageAggregateOp
            parseText "count" = return CountAggregateOp
            parseText "distinct" = return DistinctAggregateOp
            parseText "max" = return MaxAggregateOp
            parseText "mean" = return MeanAggregateOp
            parseText "median" = return MedianAggregateOp
            parseText "min" = return MinAggregateOp
            parseText "missing" = return MissingAggregateOp
            parseText "q1" = return Q1AggregateOp
            parseText "q3" = return Q3AggregateOp
            parseText "ci0" = return Ci0AggregateOp
            parseText "ci1" = return Ci1AggregateOp
            parseText "stdev" = return StdevAggregateOp
            parseText "stdevp" = return StdevpAggregateOp
            parseText "sum" = return SumAggregateOp
            parseText "valid" = return ValidAggregateOp
            parseText "values" = return ValuesAggregateOp
            parseText "variance" = return VarianceAggregateOp
            parseText "variancep" = return VariancepAggregateOp

instance ToJSON Bin where
    toJSON (BinParamsInBin x) = toJSON x
    toJSON (BoolInBin x) = toJSON x

instance FromJSON Bin where
    parseJSON xs@(Object _) = (fmap BinParamsInBin . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInBin . parseJSON) xs

instance ToJSON BinParams where
    toJSON (BinParams baseBinParams divideBinParams extentBinParams maxbinsBinParams minstepBinParams niceBinParams stepBinParams stepsBinParams) =
        object $ foldMap (maybe [] pure)
        [ ("base" .=) <$> baseBinParams
        , ("divide" .=) <$> divideBinParams
        , ("extent" .=) <$> extentBinParams
        , ("maxbins" .=) <$> maxbinsBinParams
        , ("minstep" .=) <$> minstepBinParams
        , ("nice" .=) <$> niceBinParams
        , ("step" .=) <$> stepBinParams
        , ("steps" .=) <$> stepsBinParams
        ]

instance FromJSON BinParams where
    parseJSON (Object v) = BinParams
        <$> v .:! "base"
        <*> v .:! "divide"
        <*> v .:! "extent"
        <*> v .:! "maxbins"
        <*> v .:! "minstep"
        <*> v .:! "nice"
        <*> v .:! "step"
        <*> v .:! "steps"

instance ToJSON ColorCondition where
    toJSON (ConditionalPredicateMarkPropFieldDefClassInColorCondition x) = toJSON x
    toJSON (ConditionalValueDefArrayInColorCondition x) = toJSON x

instance FromJSON ColorCondition where
    parseJSON xs@(Object _) = (fmap ConditionalPredicateMarkPropFieldDefClassInColorCondition . parseJSON) xs
    parseJSON xs@(Array _) = (fmap ConditionalValueDefArrayInColorCondition . parseJSON) xs

instance ToJSON ConditionalValueDef where
    toJSON (ConditionalValueDef testConditionalValueDef valueConditionalValueDef selectionConditionalValueDef) =
        object $ foldMap (maybe [] pure)
        [ ("test" .=) <$> testConditionalValueDef
        , Just $ "value" .= valueConditionalValueDef
        , ("selection" .=) <$> selectionConditionalValueDef
        ]

instance FromJSON ConditionalValueDef where
    parseJSON (Object v) = ConditionalValueDef
        <$> v .:! "test"
        <*> v .: "value"
        <*> v .:! "selection"

instance ToJSON Selection where
    toJSON (Selection notSelection andSelection orSelection) =
        object $ foldMap (maybe [] pure)
        [ ("not" .=) <$> notSelection
        , ("and" .=) <$> andSelection
        , ("or" .=) <$> orSelection
        ]

instance FromJSON Selection where
    parseJSON (Object v) = Selection
        <$> v .:! "not"
        <*> v .:! "and"
        <*> v .:! "or"

instance ToJSON SelectionOperand where
    toJSON (SelectionInSelectionOperand x) = toJSON x
    toJSON (StringInSelectionOperand x) = toJSON x

instance FromJSON SelectionOperand where
    parseJSON xs@(Object _) = (fmap SelectionInSelectionOperand . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInSelectionOperand . parseJSON) xs

instance ToJSON Predicate where
    toJSON (Predicate notPredicate andPredicate orPredicate equalPredicate fieldPredicate timeUnitPredicate rangePredicate oneOfPredicate selectionPredicate) =
        object $ foldMap (maybe [] pure)
        [ ("not" .=) <$> notPredicate
        , ("and" .=) <$> andPredicate
        , ("or" .=) <$> orPredicate
        , ("equal" .=) <$> equalPredicate
        , ("field" .=) <$> fieldPredicate
        , ("timeUnit" .=) <$> timeUnitPredicate
        , ("range" .=) <$> rangePredicate
        , ("oneOf" .=) <$> oneOfPredicate
        , ("selection" .=) <$> selectionPredicate
        ]

instance FromJSON Predicate where
    parseJSON (Object v) = Predicate
        <$> v .:! "not"
        <*> v .:! "and"
        <*> v .:! "or"
        <*> v .:! "equal"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .:! "range"
        <*> v .:! "oneOf"
        <*> v .:! "selection"

instance ToJSON LogicalOperandPredicate where
    toJSON (PredicateInLogicalOperandPredicate x) = toJSON x
    toJSON (StringInLogicalOperandPredicate x) = toJSON x

instance FromJSON LogicalOperandPredicate where
    parseJSON xs@(Object _) = (fmap PredicateInLogicalOperandPredicate . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInLogicalOperandPredicate . parseJSON) xs

instance ToJSON Equal where
    toJSON (BoolInEqual x) = toJSON x
    toJSON (DateTimeInEqual x) = toJSON x
    toJSON (DoubleInEqual x) = toJSON x
    toJSON (StringInEqual x) = toJSON x

instance FromJSON Equal where
    parseJSON xs@(Bool _) = (fmap BoolInEqual . parseJSON) xs
    parseJSON xs@(Object _) = (fmap DateTimeInEqual . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInEqual . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInEqual . parseJSON) xs

instance ToJSON DateTime where
    toJSON (DateTime dateDateTime dayDateTime hoursDateTime millisecondsDateTime minutesDateTime monthDateTime quarterDateTime secondsDateTime utcDateTime yearDateTime) =
        object $ foldMap (maybe [] pure)
        [ ("date" .=) <$> dateDateTime
        , ("day" .=) <$> dayDateTime
        , ("hours" .=) <$> hoursDateTime
        , ("milliseconds" .=) <$> millisecondsDateTime
        , ("minutes" .=) <$> minutesDateTime
        , ("month" .=) <$> monthDateTime
        , ("quarter" .=) <$> quarterDateTime
        , ("seconds" .=) <$> secondsDateTime
        , ("utc" .=) <$> utcDateTime
        , ("year" .=) <$> yearDateTime
        ]

instance FromJSON DateTime where
    parseJSON (Object v) = DateTime
        <$> v .:! "date"
        <*> v .:! "day"
        <*> v .:! "hours"
        <*> v .:! "milliseconds"
        <*> v .:! "minutes"
        <*> v .:! "month"
        <*> v .:! "quarter"
        <*> v .:! "seconds"
        <*> v .:! "utc"
        <*> v .:! "year"

instance ToJSON Day where
    toJSON (DoubleInDay x) = toJSON x
    toJSON (StringInDay x) = toJSON x

instance FromJSON Day where
    parseJSON xs@(Number _) = (fmap DoubleInDay . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInDay . parseJSON) xs

instance ToJSON Month where
    toJSON (DoubleInMonth x) = toJSON x
    toJSON (StringInMonth x) = toJSON x

instance FromJSON Month where
    parseJSON xs@(Number _) = (fmap DoubleInMonth . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInMonth . parseJSON) xs

instance ToJSON RangeElement where
    toJSON (DateTimeInRangeElement x) = toJSON x
    toJSON (DoubleInRangeElement x) = toJSON x
    toJSON NullInRangeElement = Null

instance FromJSON RangeElement where
    parseJSON xs@(Object _) = (fmap DateTimeInRangeElement . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInRangeElement . parseJSON) xs
    parseJSON Null = return NullInRangeElement

instance ToJSON TimeUnit where
    toJSON YearTimeUnit = "year"
    toJSON QuarterTimeUnit = "quarter"
    toJSON MonthTimeUnit = "month"
    toJSON DayTimeUnit = "day"
    toJSON DateTimeUnit = "date"
    toJSON HoursTimeUnit = "hours"
    toJSON MinutesTimeUnit = "minutes"
    toJSON SecondsTimeUnit = "seconds"
    toJSON MillisecondsTimeUnit = "milliseconds"
    toJSON UtcyearTimeUnit = "utcyear"
    toJSON UtcquarterTimeUnit = "utcquarter"
    toJSON UtcmonthTimeUnit = "utcmonth"
    toJSON UtcdayTimeUnit = "utcday"
    toJSON UtcdateTimeUnit = "utcdate"
    toJSON UtchoursTimeUnit = "utchours"
    toJSON UtcminutesTimeUnit = "utcminutes"
    toJSON UtcsecondsTimeUnit = "utcseconds"
    toJSON UtcmillisecondsTimeUnit = "utcmilliseconds"
    toJSON YearquarterTimeUnit = "yearquarter"
    toJSON YearquartermonthTimeUnit = "yearquartermonth"
    toJSON YearmonthTimeUnit = "yearmonth"
    toJSON YearmonthdateTimeUnit = "yearmonthdate"
    toJSON YearmonthdatehoursTimeUnit = "yearmonthdatehours"
    toJSON YearmonthdatehoursminutesTimeUnit = "yearmonthdatehoursminutes"
    toJSON YearmonthdatehoursminutessecondsTimeUnit = "yearmonthdatehoursminutesseconds"
    toJSON QuartermonthTimeUnit = "quartermonth"
    toJSON MonthdateTimeUnit = "monthdate"
    toJSON HoursminutesTimeUnit = "hoursminutes"
    toJSON HoursminutessecondsTimeUnit = "hoursminutesseconds"
    toJSON MinutessecondsTimeUnit = "minutesseconds"
    toJSON SecondsmillisecondsTimeUnit = "secondsmilliseconds"
    toJSON UtcyearquarterTimeUnit = "utcyearquarter"
    toJSON UtcyearquartermonthTimeUnit = "utcyearquartermonth"
    toJSON UtcyearmonthTimeUnit = "utcyearmonth"
    toJSON UtcyearmonthdateTimeUnit = "utcyearmonthdate"
    toJSON UtcyearmonthdatehoursTimeUnit = "utcyearmonthdatehours"
    toJSON UtcyearmonthdatehoursminutesTimeUnit = "utcyearmonthdatehoursminutes"
    toJSON UtcyearmonthdatehoursminutessecondsTimeUnit = "utcyearmonthdatehoursminutesseconds"
    toJSON UtcquartermonthTimeUnit = "utcquartermonth"
    toJSON UtcmonthdateTimeUnit = "utcmonthdate"
    toJSON UtchoursminutesTimeUnit = "utchoursminutes"
    toJSON UtchoursminutessecondsTimeUnit = "utchoursminutesseconds"
    toJSON UtcminutessecondsTimeUnit = "utcminutesseconds"
    toJSON UtcsecondsmillisecondsTimeUnit = "utcsecondsmilliseconds"

instance FromJSON TimeUnit where
    parseJSON = withText "TimeUnit" parseText
        where
            parseText "year" = return YearTimeUnit
            parseText "quarter" = return QuarterTimeUnit
            parseText "month" = return MonthTimeUnit
            parseText "day" = return DayTimeUnit
            parseText "date" = return DateTimeUnit
            parseText "hours" = return HoursTimeUnit
            parseText "minutes" = return MinutesTimeUnit
            parseText "seconds" = return SecondsTimeUnit
            parseText "milliseconds" = return MillisecondsTimeUnit
            parseText "utcyear" = return UtcyearTimeUnit
            parseText "utcquarter" = return UtcquarterTimeUnit
            parseText "utcmonth" = return UtcmonthTimeUnit
            parseText "utcday" = return UtcdayTimeUnit
            parseText "utcdate" = return UtcdateTimeUnit
            parseText "utchours" = return UtchoursTimeUnit
            parseText "utcminutes" = return UtcminutesTimeUnit
            parseText "utcseconds" = return UtcsecondsTimeUnit
            parseText "utcmilliseconds" = return UtcmillisecondsTimeUnit
            parseText "yearquarter" = return YearquarterTimeUnit
            parseText "yearquartermonth" = return YearquartermonthTimeUnit
            parseText "yearmonth" = return YearmonthTimeUnit
            parseText "yearmonthdate" = return YearmonthdateTimeUnit
            parseText "yearmonthdatehours" = return YearmonthdatehoursTimeUnit
            parseText "yearmonthdatehoursminutes" = return YearmonthdatehoursminutesTimeUnit
            parseText "yearmonthdatehoursminutesseconds" = return YearmonthdatehoursminutessecondsTimeUnit
            parseText "quartermonth" = return QuartermonthTimeUnit
            parseText "monthdate" = return MonthdateTimeUnit
            parseText "hoursminutes" = return HoursminutesTimeUnit
            parseText "hoursminutesseconds" = return HoursminutessecondsTimeUnit
            parseText "minutesseconds" = return MinutessecondsTimeUnit
            parseText "secondsmilliseconds" = return SecondsmillisecondsTimeUnit
            parseText "utcyearquarter" = return UtcyearquarterTimeUnit
            parseText "utcyearquartermonth" = return UtcyearquartermonthTimeUnit
            parseText "utcyearmonth" = return UtcyearmonthTimeUnit
            parseText "utcyearmonthdate" = return UtcyearmonthdateTimeUnit
            parseText "utcyearmonthdatehours" = return UtcyearmonthdatehoursTimeUnit
            parseText "utcyearmonthdatehoursminutes" = return UtcyearmonthdatehoursminutesTimeUnit
            parseText "utcyearmonthdatehoursminutesseconds" = return UtcyearmonthdatehoursminutessecondsTimeUnit
            parseText "utcquartermonth" = return UtcquartermonthTimeUnit
            parseText "utcmonthdate" = return UtcmonthdateTimeUnit
            parseText "utchoursminutes" = return UtchoursminutesTimeUnit
            parseText "utchoursminutesseconds" = return UtchoursminutessecondsTimeUnit
            parseText "utcminutesseconds" = return UtcminutessecondsTimeUnit
            parseText "utcsecondsmilliseconds" = return UtcsecondsmillisecondsTimeUnit

instance ToJSON ConditionalValueDefValue where
    toJSON (BoolInConditionalValueDefValue x) = toJSON x
    toJSON (DoubleInConditionalValueDefValue x) = toJSON x
    toJSON (StringInConditionalValueDefValue x) = toJSON x

instance FromJSON ConditionalValueDefValue where
    parseJSON xs@(Bool _) = (fmap BoolInConditionalValueDefValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInConditionalValueDefValue . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInConditionalValueDefValue . parseJSON) xs

instance ToJSON ConditionalPredicateMarkPropFieldDefClass where
    toJSON (ConditionalPredicateMarkPropFieldDefClass testConditionalPredicateMarkPropFieldDefClass valueConditionalPredicateMarkPropFieldDefClass selectionConditionalPredicateMarkPropFieldDefClass aggregateConditionalPredicateMarkPropFieldDefClass binConditionalPredicateMarkPropFieldDefClass fieldConditionalPredicateMarkPropFieldDefClass legendConditionalPredicateMarkPropFieldDefClass scaleConditionalPredicateMarkPropFieldDefClass sortConditionalPredicateMarkPropFieldDefClass timeUnitConditionalPredicateMarkPropFieldDefClass conditionalDefTypeConditionalPredicateMarkPropFieldDefClass) =
        object $ foldMap (maybe [] pure)
        [ ("test" .=) <$> testConditionalPredicateMarkPropFieldDefClass
        , ("value" .=) <$> valueConditionalPredicateMarkPropFieldDefClass
        , ("selection" .=) <$> selectionConditionalPredicateMarkPropFieldDefClass
        , ("aggregate" .=) <$> aggregateConditionalPredicateMarkPropFieldDefClass
        , ("bin" .=) <$> binConditionalPredicateMarkPropFieldDefClass
        , ("field" .=) <$> fieldConditionalPredicateMarkPropFieldDefClass
        , ("legend" .=) <$> legendConditionalPredicateMarkPropFieldDefClass
        , ("scale" .=) <$> scaleConditionalPredicateMarkPropFieldDefClass
        , ("sort" .=) <$> sortConditionalPredicateMarkPropFieldDefClass
        , ("timeUnit" .=) <$> timeUnitConditionalPredicateMarkPropFieldDefClass
        , ("type" .=) <$> conditionalDefTypeConditionalPredicateMarkPropFieldDefClass
        ]

instance FromJSON ConditionalPredicateMarkPropFieldDefClass where
    parseJSON (Object v) = ConditionalPredicateMarkPropFieldDefClass
        <$> v .:! "test"
        <*> v .:! "value"
        <*> v .:! "selection"
        <*> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "legend"
        <*> v .:! "scale"
        <*> v .:! "sort"
        <*> v .:! "timeUnit"
        <*> v .:! "type"

instance ToJSON Type where
    toJSON QuantitativeType = "quantitative"
    toJSON OrdinalType = "ordinal"
    toJSON TemporalType = "temporal"
    toJSON NominalType = "nominal"
    toJSON LatitudeType = "latitude"
    toJSON LongitudeType = "longitude"
    toJSON GeojsonType = "geojson"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "quantitative" = return QuantitativeType
            parseText "ordinal" = return OrdinalType
            parseText "temporal" = return TemporalType
            parseText "nominal" = return NominalType
            parseText "latitude" = return LatitudeType
            parseText "longitude" = return LongitudeType
            parseText "geojson" = return GeojsonType

instance ToJSON Field where
    toJSON (RepeatRefInField x) = toJSON x
    toJSON (StringInField x) = toJSON x

instance FromJSON Field where
    parseJSON xs@(Object _) = (fmap RepeatRefInField . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInField . parseJSON) xs

instance ToJSON RepeatRef where
    toJSON (RepeatRef repeatRepeatRef) =
        object $ foldMap (maybe [] pure)
        [ Just $ "repeat" .= repeatRepeatRef
        ]

instance FromJSON RepeatRef where
    parseJSON (Object v) = RepeatRef
        <$> v .: "repeat"

instance ToJSON RepeatEnum where
    toJSON RowRepeatEnum = "row"
    toJSON ColumnRepeatEnum = "column"

instance FromJSON RepeatEnum where
    parseJSON = withText "RepeatEnum" parseText
        where
            parseText "row" = return RowRepeatEnum
            parseText "column" = return ColumnRepeatEnum

instance ToJSON Legend where
    toJSON (Legend entryPaddingLegend formatLegend offsetLegend orientLegend paddingLegend tickCountLegend titleLegend legendTypeLegend valuesLegend zindexLegend) =
        object $ foldMap (maybe [] pure)
        [ ("entryPadding" .=) <$> entryPaddingLegend
        , ("format" .=) <$> formatLegend
        , ("offset" .=) <$> offsetLegend
        , ("orient" .=) <$> orientLegend
        , ("padding" .=) <$> paddingLegend
        , ("tickCount" .=) <$> tickCountLegend
        , ("title" .=) <$> titleLegend
        , ("type" .=) <$> legendTypeLegend
        , ("values" .=) <$> valuesLegend
        , ("zindex" .=) <$> zindexLegend
        ]

instance FromJSON Legend where
    parseJSON (Object v) = Legend
        <$> v .:! "entryPadding"
        <*> v .:! "format"
        <*> v .:! "offset"
        <*> v .:! "orient"
        <*> v .:! "padding"
        <*> v .:! "tickCount"
        <*> v .:! "title"
        <*> v .:! "type"
        <*> v .:! "values"
        <*> v .:! "zindex"

instance ToJSON LegendType where
    toJSON SymbolLegendType = "symbol"
    toJSON GradientLegendType = "gradient"

instance FromJSON LegendType where
    parseJSON = withText "LegendType" parseText
        where
            parseText "symbol" = return SymbolLegendType
            parseText "gradient" = return GradientLegendType

instance ToJSON LegendValue where
    toJSON (DateTimeInLegendValue x) = toJSON x
    toJSON (DoubleInLegendValue x) = toJSON x
    toJSON (StringInLegendValue x) = toJSON x

instance FromJSON LegendValue where
    parseJSON xs@(Object _) = (fmap DateTimeInLegendValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInLegendValue . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInLegendValue . parseJSON) xs

instance ToJSON Scale where
    toJSON (Scale baseScale clampScale domainScale exponentScale interpolateScale niceScale paddingScale paddingInnerScale paddingOuterScale rangeScale rangeStepScale roundScale schemeScale scaleTypeScale zeroScale) =
        object $ foldMap (maybe [] pure)
        [ ("base" .=) <$> baseScale
        , ("clamp" .=) <$> clampScale
        , ("domain" .=) <$> domainScale
        , ("exponent" .=) <$> exponentScale
        , ("interpolate" .=) <$> interpolateScale
        , ("nice" .=) <$> niceScale
        , ("padding" .=) <$> paddingScale
        , ("paddingInner" .=) <$> paddingInnerScale
        , ("paddingOuter" .=) <$> paddingOuterScale
        , ("range" .=) <$> rangeScale
        , ("rangeStep" .=) <$> rangeStepScale
        , ("round" .=) <$> roundScale
        , ("scheme" .=) <$> schemeScale
        , ("type" .=) <$> scaleTypeScale
        , ("zero" .=) <$> zeroScale
        ]

instance FromJSON Scale where
    parseJSON (Object v) = Scale
        <$> v .:! "base"
        <*> v .:! "clamp"
        <*> v .:! "domain"
        <*> v .:! "exponent"
        <*> v .:! "interpolate"
        <*> v .:! "nice"
        <*> v .:! "padding"
        <*> v .:! "paddingInner"
        <*> v .:! "paddingOuter"
        <*> v .:! "range"
        <*> v .:! "rangeStep"
        <*> v .:! "round"
        <*> v .:! "scheme"
        <*> v .:! "type"
        <*> v .:! "zero"

instance ToJSON DomainUnion where
    toJSON (DomainClassInDomainUnion x) = toJSON x
    toJSON (EnumInDomainUnion x) = toJSON x
    toJSON (UnionArrayInDomainUnion x) = toJSON x

instance FromJSON DomainUnion where
    parseJSON xs@(Object _) = (fmap DomainClassInDomainUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInDomainUnion . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInDomainUnion . parseJSON) xs

instance ToJSON DomainClass where
    toJSON (DomainClass fieldDomainClass selectionDomainClass encodingDomainClass) =
        object $ foldMap (maybe [] pure)
        [ ("field" .=) <$> fieldDomainClass
        , Just $ "selection" .= selectionDomainClass
        , ("encoding" .=) <$> encodingDomainClass
        ]

instance FromJSON DomainClass where
    parseJSON (Object v) = DomainClass
        <$> v .:! "field"
        <*> v .: "selection"
        <*> v .:! "encoding"

instance ToJSON Domain where
    toJSON UnaggregatedDomain = "unaggregated"

instance FromJSON Domain where
    parseJSON = withText "Domain" parseText
        where
            parseText "unaggregated" = return UnaggregatedDomain

instance ToJSON InterpolateUnion where
    toJSON (EnumInInterpolateUnion x) = toJSON x
    toJSON (InterpolateParamsInInterpolateUnion x) = toJSON x

instance FromJSON InterpolateUnion where
    parseJSON xs@(String _) = (fmap EnumInInterpolateUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap InterpolateParamsInInterpolateUnion . parseJSON) xs

instance ToJSON InterpolateParams where
    toJSON (InterpolateParams gammaInterpolateParams interpolateParamsTypeInterpolateParams) =
        object $ foldMap (maybe [] pure)
        [ ("gamma" .=) <$> gammaInterpolateParams
        , Just $ "type" .= interpolateParamsTypeInterpolateParams
        ]

instance FromJSON InterpolateParams where
    parseJSON (Object v) = InterpolateParams
        <$> v .:! "gamma"
        <*> v .: "type"

instance ToJSON InterpolateParamsType where
    toJSON RGBInterpolateParamsType = "rgb"
    toJSON CubehelixInterpolateParamsType = "cubehelix"
    toJSON CubehelixLongInterpolateParamsType = "cubehelix-long"

instance FromJSON InterpolateParamsType where
    parseJSON = withText "InterpolateParamsType" parseText
        where
            parseText "rgb" = return RGBInterpolateParamsType
            parseText "cubehelix" = return CubehelixInterpolateParamsType
            parseText "cubehelix-long" = return CubehelixLongInterpolateParamsType

instance ToJSON NiceUnion where
    toJSON (BoolInNiceUnion x) = toJSON x
    toJSON (DoubleInNiceUnion x) = toJSON x
    toJSON (EnumInNiceUnion x) = toJSON x
    toJSON (NiceClassInNiceUnion x) = toJSON x

instance FromJSON NiceUnion where
    parseJSON xs@(Bool _) = (fmap BoolInNiceUnion . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInNiceUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInNiceUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap NiceClassInNiceUnion . parseJSON) xs

instance ToJSON NiceClass where
    toJSON (NiceClass intervalNiceClass stepNiceClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "interval" .= intervalNiceClass
        , Just $ "step" .= stepNiceClass
        ]

instance FromJSON NiceClass where
    parseJSON (Object v) = NiceClass
        <$> v .: "interval"
        <*> v .: "step"

instance ToJSON NiceTime where
    toJSON SecondNiceTime = "second"
    toJSON MinuteNiceTime = "minute"
    toJSON HourNiceTime = "hour"
    toJSON DayNiceTime = "day"
    toJSON WeekNiceTime = "week"
    toJSON MonthNiceTime = "month"
    toJSON YearNiceTime = "year"

instance FromJSON NiceTime where
    parseJSON = withText "NiceTime" parseText
        where
            parseText "second" = return SecondNiceTime
            parseText "minute" = return MinuteNiceTime
            parseText "hour" = return HourNiceTime
            parseText "day" = return DayNiceTime
            parseText "week" = return WeekNiceTime
            parseText "month" = return MonthNiceTime
            parseText "year" = return YearNiceTime

instance ToJSON ScaleRange where
    toJSON (StringInScaleRange x) = toJSON x
    toJSON (UnionArrayInScaleRange x) = toJSON x

instance FromJSON ScaleRange where
    parseJSON xs@(String _) = (fmap StringInScaleRange . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInScaleRange . parseJSON) xs

instance ToJSON ScaleType where
    toJSON LinearScaleType = "linear"
    toJSON BinLinearScaleType = "bin-linear"
    toJSON LogScaleType = "log"
    toJSON PowScaleType = "pow"
    toJSON SqrtScaleType = "sqrt"
    toJSON TimeScaleType = "time"
    toJSON UTCScaleType = "utc"
    toJSON SequentialScaleType = "sequential"
    toJSON OrdinalScaleType = "ordinal"
    toJSON BinOrdinalScaleType = "bin-ordinal"
    toJSON PointScaleType = "point"
    toJSON BandScaleType = "band"

instance FromJSON ScaleType where
    parseJSON = withText "ScaleType" parseText
        where
            parseText "linear" = return LinearScaleType
            parseText "bin-linear" = return BinLinearScaleType
            parseText "log" = return LogScaleType
            parseText "pow" = return PowScaleType
            parseText "sqrt" = return SqrtScaleType
            parseText "time" = return TimeScaleType
            parseText "utc" = return UTCScaleType
            parseText "sequential" = return SequentialScaleType
            parseText "ordinal" = return OrdinalScaleType
            parseText "bin-ordinal" = return BinOrdinalScaleType
            parseText "point" = return PointScaleType
            parseText "band" = return BandScaleType

instance ToJSON Scheme where
    toJSON (SchemeParamsInScheme x) = toJSON x
    toJSON (StringInScheme x) = toJSON x

instance FromJSON Scheme where
    parseJSON xs@(Object _) = (fmap SchemeParamsInScheme . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInScheme . parseJSON) xs

instance ToJSON SchemeParams where
    toJSON (SchemeParams extentSchemeParams nameSchemeParams) =
        object $ foldMap (maybe [] pure)
        [ ("extent" .=) <$> extentSchemeParams
        , Just $ "name" .= nameSchemeParams
        ]

instance FromJSON SchemeParams where
    parseJSON (Object v) = SchemeParams
        <$> v .:! "extent"
        <*> v .: "name"

instance ToJSON SortUnion where
    toJSON (EnumInSortUnion x) = toJSON x
    toJSON NullInSortUnion = Null
    toJSON (SortFieldInSortUnion x) = toJSON x

instance FromJSON SortUnion where
    parseJSON xs@(String _) = (fmap EnumInSortUnion . parseJSON) xs
    parseJSON Null = return NullInSortUnion
    parseJSON xs@(Object _) = (fmap SortFieldInSortUnion . parseJSON) xs

instance ToJSON SortField where
    toJSON (SortField fieldSortField opSortField orderSortField) =
        object $ foldMap (maybe [] pure)
        [ ("field" .=) <$> fieldSortField
        , Just $ "op" .= opSortField
        , ("order" .=) <$> orderSortField
        ]

instance FromJSON SortField where
    parseJSON (Object v) = SortField
        <$> v .:! "field"
        <*> v .: "op"
        <*> v .:! "order"

instance ToJSON SortEnum where
    toJSON AscendingSortEnum = "ascending"
    toJSON DescendingSortEnum = "descending"

instance FromJSON SortEnum where
    parseJSON = withText "SortEnum" parseText
        where
            parseText "ascending" = return AscendingSortEnum
            parseText "descending" = return DescendingSortEnum

instance ToJSON FacetFieldDef where
    toJSON (FacetFieldDef aggregateFacetFieldDef binFacetFieldDef fieldFacetFieldDef headerFacetFieldDef sortFacetFieldDef timeUnitFacetFieldDef facetFieldDefTypeFacetFieldDef) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateFacetFieldDef
        , ("bin" .=) <$> binFacetFieldDef
        , ("field" .=) <$> fieldFacetFieldDef
        , ("header" .=) <$> headerFacetFieldDef
        , ("sort" .=) <$> sortFacetFieldDef
        , ("timeUnit" .=) <$> timeUnitFacetFieldDef
        , Just $ "type" .= facetFieldDefTypeFacetFieldDef
        ]

instance FromJSON FacetFieldDef where
    parseJSON (Object v) = FacetFieldDef
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "header"
        <*> v .:! "sort"
        <*> v .:! "timeUnit"
        <*> v .: "type"

instance ToJSON Header where
    toJSON (Header formatHeader labelAngleHeader titleHeader) =
        object $ foldMap (maybe [] pure)
        [ ("format" .=) <$> formatHeader
        , ("labelAngle" .=) <$> labelAngleHeader
        , ("title" .=) <$> titleHeader
        ]

instance FromJSON Header where
    parseJSON (Object v) = Header
        <$> v .:! "format"
        <*> v .:! "labelAngle"
        <*> v .:! "title"

instance ToJSON Detail where
    toJSON (FieldDefArrayInDetail x) = toJSON x
    toJSON (FieldDefInDetail x) = toJSON x

instance FromJSON Detail where
    parseJSON xs@(Array _) = (fmap FieldDefArrayInDetail . parseJSON) xs
    parseJSON xs@(Object _) = (fmap FieldDefInDetail . parseJSON) xs

instance ToJSON FieldDef where
    toJSON (FieldDef aggregateFieldDef binFieldDef fieldFieldDef timeUnitFieldDef fieldDefTypeFieldDef) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateFieldDef
        , ("bin" .=) <$> binFieldDef
        , ("field" .=) <$> fieldFieldDef
        , ("timeUnit" .=) <$> timeUnitFieldDef
        , Just $ "type" .= fieldDefTypeFieldDef
        ]

instance FromJSON FieldDef where
    parseJSON (Object v) = FieldDef
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .: "type"

instance ToJSON TextDefWithCondition where
    toJSON (TextDefWithCondition aggregateTextDefWithCondition binTextDefWithCondition conditionTextDefWithCondition fieldTextDefWithCondition formatTextDefWithCondition timeUnitTextDefWithCondition textDefWithConditionTypeTextDefWithCondition valueTextDefWithCondition) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateTextDefWithCondition
        , ("bin" .=) <$> binTextDefWithCondition
        , ("condition" .=) <$> conditionTextDefWithCondition
        , ("field" .=) <$> fieldTextDefWithCondition
        , ("format" .=) <$> formatTextDefWithCondition
        , ("timeUnit" .=) <$> timeUnitTextDefWithCondition
        , ("type" .=) <$> textDefWithConditionTypeTextDefWithCondition
        , ("value" .=) <$> valueTextDefWithCondition
        ]

instance FromJSON TextDefWithCondition where
    parseJSON (Object v) = TextDefWithCondition
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "condition"
        <*> v .:! "field"
        <*> v .:! "format"
        <*> v .:! "timeUnit"
        <*> v .:! "type"
        <*> v .:! "value"

instance ToJSON TextCondition where
    toJSON (ConditionalPredicateTextFieldDefClassInTextCondition x) = toJSON x
    toJSON (ConditionalValueDefArrayInTextCondition x) = toJSON x

instance FromJSON TextCondition where
    parseJSON xs@(Object _) = (fmap ConditionalPredicateTextFieldDefClassInTextCondition . parseJSON) xs
    parseJSON xs@(Array _) = (fmap ConditionalValueDefArrayInTextCondition . parseJSON) xs

instance ToJSON ConditionalPredicateTextFieldDefClass where
    toJSON (ConditionalPredicateTextFieldDefClass testConditionalPredicateTextFieldDefClass valueConditionalPredicateTextFieldDefClass selectionConditionalPredicateTextFieldDefClass aggregateConditionalPredicateTextFieldDefClass binConditionalPredicateTextFieldDefClass fieldConditionalPredicateTextFieldDefClass formatConditionalPredicateTextFieldDefClass timeUnitConditionalPredicateTextFieldDefClass conditionalDefTypeConditionalPredicateTextFieldDefClass) =
        object $ foldMap (maybe [] pure)
        [ ("test" .=) <$> testConditionalPredicateTextFieldDefClass
        , ("value" .=) <$> valueConditionalPredicateTextFieldDefClass
        , ("selection" .=) <$> selectionConditionalPredicateTextFieldDefClass
        , ("aggregate" .=) <$> aggregateConditionalPredicateTextFieldDefClass
        , ("bin" .=) <$> binConditionalPredicateTextFieldDefClass
        , ("field" .=) <$> fieldConditionalPredicateTextFieldDefClass
        , ("format" .=) <$> formatConditionalPredicateTextFieldDefClass
        , ("timeUnit" .=) <$> timeUnitConditionalPredicateTextFieldDefClass
        , ("type" .=) <$> conditionalDefTypeConditionalPredicateTextFieldDefClass
        ]

instance FromJSON ConditionalPredicateTextFieldDefClass where
    parseJSON (Object v) = ConditionalPredicateTextFieldDefClass
        <$> v .:! "test"
        <*> v .:! "value"
        <*> v .:! "selection"
        <*> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "format"
        <*> v .:! "timeUnit"
        <*> v .:! "type"

instance ToJSON DefWithCondition where
    toJSON (DefWithCondition aggregateDefWithCondition binDefWithCondition conditionDefWithCondition fieldDefWithCondition timeUnitDefWithCondition defWithConditionTypeDefWithCondition valueDefWithCondition) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateDefWithCondition
        , ("bin" .=) <$> binDefWithCondition
        , ("condition" .=) <$> conditionDefWithCondition
        , ("field" .=) <$> fieldDefWithCondition
        , ("timeUnit" .=) <$> timeUnitDefWithCondition
        , ("type" .=) <$> defWithConditionTypeDefWithCondition
        , ("value" .=) <$> valueDefWithCondition
        ]

instance FromJSON DefWithCondition where
    parseJSON (Object v) = DefWithCondition
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "condition"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .:! "type"
        <*> v .:! "value"

instance ToJSON HrefCondition where
    toJSON (ConditionalPredicateFieldDefClassInHrefCondition x) = toJSON x
    toJSON (ConditionalValueDefArrayInHrefCondition x) = toJSON x

instance FromJSON HrefCondition where
    parseJSON xs@(Object _) = (fmap ConditionalPredicateFieldDefClassInHrefCondition . parseJSON) xs
    parseJSON xs@(Array _) = (fmap ConditionalValueDefArrayInHrefCondition . parseJSON) xs

instance ToJSON ConditionalPredicateFieldDefClass where
    toJSON (ConditionalPredicateFieldDefClass testConditionalPredicateFieldDefClass valueConditionalPredicateFieldDefClass selectionConditionalPredicateFieldDefClass aggregateConditionalPredicateFieldDefClass binConditionalPredicateFieldDefClass fieldConditionalPredicateFieldDefClass timeUnitConditionalPredicateFieldDefClass conditionalDefTypeConditionalPredicateFieldDefClass) =
        object $ foldMap (maybe [] pure)
        [ ("test" .=) <$> testConditionalPredicateFieldDefClass
        , ("value" .=) <$> valueConditionalPredicateFieldDefClass
        , ("selection" .=) <$> selectionConditionalPredicateFieldDefClass
        , ("aggregate" .=) <$> aggregateConditionalPredicateFieldDefClass
        , ("bin" .=) <$> binConditionalPredicateFieldDefClass
        , ("field" .=) <$> fieldConditionalPredicateFieldDefClass
        , ("timeUnit" .=) <$> timeUnitConditionalPredicateFieldDefClass
        , ("type" .=) <$> conditionalDefTypeConditionalPredicateFieldDefClass
        ]

instance FromJSON ConditionalPredicateFieldDefClass where
    parseJSON (Object v) = ConditionalPredicateFieldDefClass
        <$> v .:! "test"
        <*> v .:! "value"
        <*> v .:! "selection"
        <*> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .:! "type"

instance ToJSON Order where
    toJSON (OrderFieldDefArrayInOrder x) = toJSON x
    toJSON (OrderFieldDefInOrder x) = toJSON x

instance FromJSON Order where
    parseJSON xs@(Array _) = (fmap OrderFieldDefArrayInOrder . parseJSON) xs
    parseJSON xs@(Object _) = (fmap OrderFieldDefInOrder . parseJSON) xs

instance ToJSON OrderFieldDef where
    toJSON (OrderFieldDef aggregateOrderFieldDef binOrderFieldDef fieldOrderFieldDef sortOrderFieldDef timeUnitOrderFieldDef orderFieldDefTypeOrderFieldDef) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateOrderFieldDef
        , ("bin" .=) <$> binOrderFieldDef
        , ("field" .=) <$> fieldOrderFieldDef
        , ("sort" .=) <$> sortOrderFieldDef
        , ("timeUnit" .=) <$> timeUnitOrderFieldDef
        , Just $ "type" .= orderFieldDefTypeOrderFieldDef
        ]

instance FromJSON OrderFieldDef where
    parseJSON (Object v) = OrderFieldDef
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "sort"
        <*> v .:! "timeUnit"
        <*> v .: "type"

instance ToJSON XClass where
    toJSON (XClass aggregateXClass axisXClass binXClass fieldXClass scaleXClass sortXClass stackXClass timeUnitXClass defTypeXClass valueXClass) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateXClass
        , ("axis" .=) <$> axisXClass
        , ("bin" .=) <$> binXClass
        , ("field" .=) <$> fieldXClass
        , ("scale" .=) <$> scaleXClass
        , ("sort" .=) <$> sortXClass
        , ("stack" .=) <$> stackXClass
        , ("timeUnit" .=) <$> timeUnitXClass
        , ("type" .=) <$> defTypeXClass
        , ("value" .=) <$> valueXClass
        ]

instance FromJSON XClass where
    parseJSON (Object v) = XClass
        <$> v .:! "aggregate"
        <*> v .:! "axis"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "scale"
        <*> v .:! "sort"
        <*> v .:! "stack"
        <*> v .:! "timeUnit"
        <*> v .:! "type"
        <*> v .:! "value"

instance ToJSON Axis where
    toJSON (Axis domainAxis formatAxis gridAxis labelAngleAxis labelBoundAxis labelFlushAxis labelOverlapAxis labelPaddingAxis labelsAxis maxExtentAxis minExtentAxis offsetAxis orientAxis positionAxis tickCountAxis ticksAxis tickSizeAxis titleAxis titleMaxLengthAxis titlePaddingAxis valuesAxis zindexAxis) =
        object $ foldMap (maybe [] pure)
        [ ("domain" .=) <$> domainAxis
        , ("format" .=) <$> formatAxis
        , ("grid" .=) <$> gridAxis
        , ("labelAngle" .=) <$> labelAngleAxis
        , ("labelBound" .=) <$> labelBoundAxis
        , ("labelFlush" .=) <$> labelFlushAxis
        , ("labelOverlap" .=) <$> labelOverlapAxis
        , ("labelPadding" .=) <$> labelPaddingAxis
        , ("labels" .=) <$> labelsAxis
        , ("maxExtent" .=) <$> maxExtentAxis
        , ("minExtent" .=) <$> minExtentAxis
        , ("offset" .=) <$> offsetAxis
        , ("orient" .=) <$> orientAxis
        , ("position" .=) <$> positionAxis
        , ("tickCount" .=) <$> tickCountAxis
        , ("ticks" .=) <$> ticksAxis
        , ("tickSize" .=) <$> tickSizeAxis
        , ("title" .=) <$> titleAxis
        , ("titleMaxLength" .=) <$> titleMaxLengthAxis
        , ("titlePadding" .=) <$> titlePaddingAxis
        , ("values" .=) <$> valuesAxis
        , ("zindex" .=) <$> zindexAxis
        ]

instance FromJSON Axis where
    parseJSON (Object v) = Axis
        <$> v .:! "domain"
        <*> v .:! "format"
        <*> v .:! "grid"
        <*> v .:! "labelAngle"
        <*> v .:! "labelBound"
        <*> v .:! "labelFlush"
        <*> v .:! "labelOverlap"
        <*> v .:! "labelPadding"
        <*> v .:! "labels"
        <*> v .:! "maxExtent"
        <*> v .:! "minExtent"
        <*> v .:! "offset"
        <*> v .:! "orient"
        <*> v .:! "position"
        <*> v .:! "tickCount"
        <*> v .:! "ticks"
        <*> v .:! "tickSize"
        <*> v .:! "title"
        <*> v .:! "titleMaxLength"
        <*> v .:! "titlePadding"
        <*> v .:! "values"
        <*> v .:! "zindex"

instance ToJSON AxisValue where
    toJSON (DateTimeInAxisValue x) = toJSON x
    toJSON (DoubleInAxisValue x) = toJSON x

instance FromJSON AxisValue where
    parseJSON xs@(Object _) = (fmap DateTimeInAxisValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInAxisValue . parseJSON) xs

instance ToJSON X2Class where
    toJSON (X2Class aggregateX2Class binX2Class fieldX2Class timeUnitX2Class defTypeX2Class valueX2Class) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateX2Class
        , ("bin" .=) <$> binX2Class
        , ("field" .=) <$> fieldX2Class
        , ("timeUnit" .=) <$> timeUnitX2Class
        , ("type" .=) <$> defTypeX2Class
        , ("value" .=) <$> valueX2Class
        ]

instance FromJSON X2Class where
    parseJSON (Object v) = X2Class
        <$> v .:! "aggregate"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .:! "type"
        <*> v .:! "value"

instance ToJSON FacetMapping where
    toJSON (FacetMapping columnFacetMapping rowFacetMapping) =
        object $ foldMap (maybe [] pure)
        [ ("column" .=) <$> columnFacetMapping
        , ("row" .=) <$> rowFacetMapping
        ]

instance FromJSON FacetMapping where
    parseJSON (Object v) = FacetMapping
        <$> v .:! "column"
        <*> v .:! "row"

instance ToJSON Spec where
    toJSON (Spec specDataSpec descriptionSpec heightSpec layerSpec nameSpec resolveSpec titleSpec transformSpec widthSpec encodingSpec markSpec projectionSpec selectionSpec facetSpec specSpec repeatSpec vconcatSpec hconcatSpec) =
        object $ foldMap (maybe [] pure)
        [ ("data" .=) <$> specDataSpec
        , ("description" .=) <$> descriptionSpec
        , ("height" .=) <$> heightSpec
        , ("layer" .=) <$> layerSpec
        , ("name" .=) <$> nameSpec
        , ("resolve" .=) <$> resolveSpec
        , ("title" .=) <$> titleSpec
        , ("transform" .=) <$> transformSpec
        , ("width" .=) <$> widthSpec
        , ("encoding" .=) <$> encodingSpec
        , ("mark" .=) <$> markSpec
        , ("projection" .=) <$> projectionSpec
        , ("selection" .=) <$> selectionSpec
        , ("facet" .=) <$> facetSpec
        , ("spec" .=) <$> specSpec
        , ("repeat" .=) <$> repeatSpec
        , ("vconcat" .=) <$> vconcatSpec
        , ("hconcat" .=) <$> hconcatSpec
        ]

instance FromJSON Spec where
    parseJSON (Object v) = Spec
        <$> v .:! "data"
        <*> v .:! "description"
        <*> v .:! "height"
        <*> v .:! "layer"
        <*> v .:! "name"
        <*> v .:! "resolve"
        <*> v .:! "title"
        <*> v .:! "transform"
        <*> v .:! "width"
        <*> v .:! "encoding"
        <*> v .:! "mark"
        <*> v .:! "projection"
        <*> v .:! "selection"
        <*> v .:! "facet"
        <*> v .:! "spec"
        <*> v .:! "repeat"
        <*> v .:! "vconcat"
        <*> v .:! "hconcat"

instance ToJSON Encoding where
    toJSON (Encoding colorEncoding detailEncoding hrefEncoding opacityEncoding orderEncoding shapeEncoding sizeEncoding encodingTextEncoding tooltipEncoding xEncoding x2Encoding yEncoding y2Encoding) =
        object $ foldMap (maybe [] pure)
        [ ("color" .=) <$> colorEncoding
        , ("detail" .=) <$> detailEncoding
        , ("href" .=) <$> hrefEncoding
        , ("opacity" .=) <$> opacityEncoding
        , ("order" .=) <$> orderEncoding
        , ("shape" .=) <$> shapeEncoding
        , ("size" .=) <$> sizeEncoding
        , ("text" .=) <$> encodingTextEncoding
        , ("tooltip" .=) <$> tooltipEncoding
        , ("x" .=) <$> xEncoding
        , ("x2" .=) <$> x2Encoding
        , ("y" .=) <$> yEncoding
        , ("y2" .=) <$> y2Encoding
        ]

instance FromJSON Encoding where
    parseJSON (Object v) = Encoding
        <$> v .:! "color"
        <*> v .:! "detail"
        <*> v .:! "href"
        <*> v .:! "opacity"
        <*> v .:! "order"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "text"
        <*> v .:! "tooltip"
        <*> v .:! "x"
        <*> v .:! "x2"
        <*> v .:! "y"
        <*> v .:! "y2"

instance ToJSON LayerSpec where
    toJSON (LayerSpec layerSpecDataLayerSpec descriptionLayerSpec heightLayerSpec layerLayerSpec nameLayerSpec resolveLayerSpec titleLayerSpec transformLayerSpec widthLayerSpec encodingLayerSpec markLayerSpec projectionLayerSpec selectionLayerSpec) =
        object $ foldMap (maybe [] pure)
        [ ("data" .=) <$> layerSpecDataLayerSpec
        , ("description" .=) <$> descriptionLayerSpec
        , ("height" .=) <$> heightLayerSpec
        , ("layer" .=) <$> layerLayerSpec
        , ("name" .=) <$> nameLayerSpec
        , ("resolve" .=) <$> resolveLayerSpec
        , ("title" .=) <$> titleLayerSpec
        , ("transform" .=) <$> transformLayerSpec
        , ("width" .=) <$> widthLayerSpec
        , ("encoding" .=) <$> encodingLayerSpec
        , ("mark" .=) <$> markLayerSpec
        , ("projection" .=) <$> projectionLayerSpec
        , ("selection" .=) <$> selectionLayerSpec
        ]

instance FromJSON LayerSpec where
    parseJSON (Object v) = LayerSpec
        <$> v .:! "data"
        <*> v .:! "description"
        <*> v .:! "height"
        <*> v .:! "layer"
        <*> v .:! "name"
        <*> v .:! "resolve"
        <*> v .:! "title"
        <*> v .:! "transform"
        <*> v .:! "width"
        <*> v .:! "encoding"
        <*> v .:! "mark"
        <*> v .:! "projection"
        <*> v .:! "selection"

instance ToJSON Data where
    toJSON (Data formatData urlData valuesData nameData) =
        object $ foldMap (maybe [] pure)
        [ ("format" .=) <$> formatData
        , ("url" .=) <$> urlData
        , ("values" .=) <$> valuesData
        , ("name" .=) <$> nameData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .:! "format"
        <*> v .:! "url"
        <*> v .:! "values"
        <*> v .:! "name"

instance ToJSON DataFormat where
    toJSON (DataFormat parseDataFormat dataFormatTypeDataFormat propertyDataFormat featureDataFormat meshDataFormat) =
        object $ foldMap (maybe [] pure)
        [ ("parse" .=) <$> parseDataFormat
        , ("type" .=) <$> dataFormatTypeDataFormat
        , ("property" .=) <$> propertyDataFormat
        , ("feature" .=) <$> featureDataFormat
        , ("mesh" .=) <$> meshDataFormat
        ]

instance FromJSON DataFormat where
    parseJSON (Object v) = DataFormat
        <$> v .:! "parse"
        <*> v .:! "type"
        <*> v .:! "property"
        <*> v .:! "feature"
        <*> v .:! "mesh"

instance ToJSON DataFormatType where
    toJSON CSVDataFormatType = "csv"
    toJSON TsvDataFormatType = "tsv"
    toJSON JSONDataFormatType = "json"
    toJSON TopojsonDataFormatType = "topojson"

instance FromJSON DataFormatType where
    parseJSON = withText "DataFormatType" parseText
        where
            parseText "csv" = return CSVDataFormatType
            parseText "tsv" = return TsvDataFormatType
            parseText "json" = return JSONDataFormatType
            parseText "topojson" = return TopojsonDataFormatType

instance ToJSON ParseUnion where
    toJSON (AnythingMapInParseUnion x) = toJSON x
    toJSON (EnumInParseUnion x) = toJSON x

instance FromJSON ParseUnion where
    parseJSON xs@(Object _) = (fmap AnythingMapInParseUnion . parseJSON) xs
    parseJSON xs@(String _) = (fmap EnumInParseUnion . parseJSON) xs

instance ToJSON ParseEnum where
    toJSON AutoParseEnum = "auto"

instance FromJSON ParseEnum where
    parseJSON = withText "ParseEnum" parseText
        where
            parseText "auto" = return AutoParseEnum

instance ToJSON Values where
    toJSON (AnythingMapInValues x) = toJSON x
    toJSON (StringInValues x) = toJSON x
    toJSON (UnionArrayInValues x) = toJSON x

instance FromJSON Values where
    parseJSON xs@(Object _) = (fmap AnythingMapInValues . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInValues . parseJSON) xs
    parseJSON xs@(Array _) = (fmap UnionArrayInValues . parseJSON) xs

instance ToJSON ValuesValue where
    toJSON (AnythingMapInValuesValue x) = toJSON x
    toJSON (BoolInValuesValue x) = toJSON x
    toJSON (DoubleInValuesValue x) = toJSON x
    toJSON (StringInValuesValue x) = toJSON x

instance FromJSON ValuesValue where
    parseJSON xs@(Object _) = (fmap AnythingMapInValuesValue . parseJSON) xs
    parseJSON xs@(Bool _) = (fmap BoolInValuesValue . parseJSON) xs
    parseJSON xs@(Number _) = (fmap DoubleInValuesValue . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInValuesValue . parseJSON) xs

instance ToJSON AnyMark where
    toJSON (EnumInAnyMark x) = toJSON x
    toJSON (MarkDefInAnyMark x) = toJSON x

instance FromJSON AnyMark where
    parseJSON xs@(String _) = (fmap EnumInAnyMark . parseJSON) xs
    parseJSON xs@(Object _) = (fmap MarkDefInAnyMark . parseJSON) xs

instance ToJSON MarkDef where
    toJSON (MarkDef alignMarkDef angleMarkDef baselineMarkDef clipMarkDef colorMarkDef cursorMarkDef dxMarkDef dyMarkDef fillMarkDef filledMarkDef fillOpacityMarkDef fontMarkDef fontSizeMarkDef fontStyleMarkDef fontWeightMarkDef hrefMarkDef interpolateMarkDef limitMarkDef opacityMarkDef orientMarkDef radiusMarkDef shapeMarkDef sizeMarkDef strokeMarkDef strokeDashMarkDef strokeDashOffsetMarkDef strokeOpacityMarkDef strokeWidthMarkDef styleMarkDef tensionMarkDef markDefTextMarkDef thetaMarkDef markDefTypeMarkDef) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignMarkDef
        , ("angle" .=) <$> angleMarkDef
        , ("baseline" .=) <$> baselineMarkDef
        , ("clip" .=) <$> clipMarkDef
        , ("color" .=) <$> colorMarkDef
        , ("cursor" .=) <$> cursorMarkDef
        , ("dx" .=) <$> dxMarkDef
        , ("dy" .=) <$> dyMarkDef
        , ("fill" .=) <$> fillMarkDef
        , ("filled" .=) <$> filledMarkDef
        , ("fillOpacity" .=) <$> fillOpacityMarkDef
        , ("font" .=) <$> fontMarkDef
        , ("fontSize" .=) <$> fontSizeMarkDef
        , ("fontStyle" .=) <$> fontStyleMarkDef
        , ("fontWeight" .=) <$> fontWeightMarkDef
        , ("href" .=) <$> hrefMarkDef
        , ("interpolate" .=) <$> interpolateMarkDef
        , ("limit" .=) <$> limitMarkDef
        , ("opacity" .=) <$> opacityMarkDef
        , ("orient" .=) <$> orientMarkDef
        , ("radius" .=) <$> radiusMarkDef
        , ("shape" .=) <$> shapeMarkDef
        , ("size" .=) <$> sizeMarkDef
        , ("stroke" .=) <$> strokeMarkDef
        , ("strokeDash" .=) <$> strokeDashMarkDef
        , ("strokeDashOffset" .=) <$> strokeDashOffsetMarkDef
        , ("strokeOpacity" .=) <$> strokeOpacityMarkDef
        , ("strokeWidth" .=) <$> strokeWidthMarkDef
        , ("style" .=) <$> styleMarkDef
        , ("tension" .=) <$> tensionMarkDef
        , ("text" .=) <$> markDefTextMarkDef
        , ("theta" .=) <$> thetaMarkDef
        , Just $ "type" .= markDefTypeMarkDef
        ]

instance FromJSON MarkDef where
    parseJSON (Object v) = MarkDef
        <$> v .:! "align"
        <*> v .:! "angle"
        <*> v .:! "baseline"
        <*> v .:! "clip"
        <*> v .:! "color"
        <*> v .:! "cursor"
        <*> v .:! "dx"
        <*> v .:! "dy"
        <*> v .:! "fill"
        <*> v .:! "filled"
        <*> v .:! "fillOpacity"
        <*> v .:! "font"
        <*> v .:! "fontSize"
        <*> v .:! "fontStyle"
        <*> v .:! "fontWeight"
        <*> v .:! "href"
        <*> v .:! "interpolate"
        <*> v .:! "limit"
        <*> v .:! "opacity"
        <*> v .:! "orient"
        <*> v .:! "radius"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "stroke"
        <*> v .:! "strokeDash"
        <*> v .:! "strokeDashOffset"
        <*> v .:! "strokeOpacity"
        <*> v .:! "strokeWidth"
        <*> v .:! "style"
        <*> v .:! "tension"
        <*> v .:! "text"
        <*> v .:! "theta"
        <*> v .: "type"

instance ToJSON Mark where
    toJSON AreaMark = "area"
    toJSON BarMark = "bar"
    toJSON LineMark = "line"
    toJSON PointMark = "point"
    toJSON TextMark = "text"
    toJSON TickMark = "tick"
    toJSON RectMark = "rect"
    toJSON RuleMark = "rule"
    toJSON CircleMark = "circle"
    toJSON SquareMark = "square"
    toJSON GeoshapeMark = "geoshape"

instance FromJSON Mark where
    parseJSON = withText "Mark" parseText
        where
            parseText "area" = return AreaMark
            parseText "bar" = return BarMark
            parseText "line" = return LineMark
            parseText "point" = return PointMark
            parseText "text" = return TextMark
            parseText "tick" = return TickMark
            parseText "rect" = return RectMark
            parseText "rule" = return RuleMark
            parseText "circle" = return CircleMark
            parseText "square" = return SquareMark
            parseText "geoshape" = return GeoshapeMark

instance ToJSON Style where
    toJSON (StringArrayInStyle x) = toJSON x
    toJSON (StringInStyle x) = toJSON x

instance FromJSON Style where
    parseJSON xs@(Array _) = (fmap StringArrayInStyle . parseJSON) xs
    parseJSON xs@(String _) = (fmap StringInStyle . parseJSON) xs

instance ToJSON Projection where
    toJSON (Projection centerProjection clipAngleProjection clipExtentProjection coefficientProjection distanceProjection fractionProjection lobesProjection parallelProjection precisionProjection radiusProjection ratioProjection rotateProjection spacingProjection tiltProjection projectionTypeProjection) =
        object $ foldMap (maybe [] pure)
        [ ("center" .=) <$> centerProjection
        , ("clipAngle" .=) <$> clipAngleProjection
        , ("clipExtent" .=) <$> clipExtentProjection
        , ("coefficient" .=) <$> coefficientProjection
        , ("distance" .=) <$> distanceProjection
        , ("fraction" .=) <$> fractionProjection
        , ("lobes" .=) <$> lobesProjection
        , ("parallel" .=) <$> parallelProjection
        , ("precision" .=) <$> precisionProjection
        , ("radius" .=) <$> radiusProjection
        , ("ratio" .=) <$> ratioProjection
        , ("rotate" .=) <$> rotateProjection
        , ("spacing" .=) <$> spacingProjection
        , ("tilt" .=) <$> tiltProjection
        , ("type" .=) <$> projectionTypeProjection
        ]

instance FromJSON Projection where
    parseJSON (Object v) = Projection
        <$> v .:! "center"
        <*> v .:! "clipAngle"
        <*> v .:! "clipExtent"
        <*> v .:! "coefficient"
        <*> v .:! "distance"
        <*> v .:! "fraction"
        <*> v .:! "lobes"
        <*> v .:! "parallel"
        <*> v .:! "precision"
        <*> v .:! "radius"
        <*> v .:! "ratio"
        <*> v .:! "rotate"
        <*> v .:! "spacing"
        <*> v .:! "tilt"
        <*> v .:! "type"

instance ToJSON Resolve where
    toJSON (Resolve axisResolve legendResolve scaleResolve) =
        object $ foldMap (maybe [] pure)
        [ ("axis" .=) <$> axisResolve
        , ("legend" .=) <$> legendResolve
        , ("scale" .=) <$> scaleResolve
        ]

instance FromJSON Resolve where
    parseJSON (Object v) = Resolve
        <$> v .:! "axis"
        <*> v .:! "legend"
        <*> v .:! "scale"

instance ToJSON AxisResolveMap where
    toJSON (AxisResolveMap xAxisResolveMap yAxisResolveMap) =
        object $ foldMap (maybe [] pure)
        [ ("x" .=) <$> xAxisResolveMap
        , ("y" .=) <$> yAxisResolveMap
        ]

instance FromJSON AxisResolveMap where
    parseJSON (Object v) = AxisResolveMap
        <$> v .:! "x"
        <*> v .:! "y"

instance ToJSON ResolveMode where
    toJSON IndependentResolveMode = "independent"
    toJSON SharedResolveMode = "shared"

instance FromJSON ResolveMode where
    parseJSON = withText "ResolveMode" parseText
        where
            parseText "independent" = return IndependentResolveMode
            parseText "shared" = return SharedResolveMode

instance ToJSON LegendResolveMap where
    toJSON (LegendResolveMap colorLegendResolveMap opacityLegendResolveMap shapeLegendResolveMap sizeLegendResolveMap) =
        object $ foldMap (maybe [] pure)
        [ ("color" .=) <$> colorLegendResolveMap
        , ("opacity" .=) <$> opacityLegendResolveMap
        , ("shape" .=) <$> shapeLegendResolveMap
        , ("size" .=) <$> sizeLegendResolveMap
        ]

instance FromJSON LegendResolveMap where
    parseJSON (Object v) = LegendResolveMap
        <$> v .:! "color"
        <*> v .:! "opacity"
        <*> v .:! "shape"
        <*> v .:! "size"

instance ToJSON ScaleResolveMap where
    toJSON (ScaleResolveMap colorScaleResolveMap opacityScaleResolveMap shapeScaleResolveMap sizeScaleResolveMap xScaleResolveMap yScaleResolveMap) =
        object $ foldMap (maybe [] pure)
        [ ("color" .=) <$> colorScaleResolveMap
        , ("opacity" .=) <$> opacityScaleResolveMap
        , ("shape" .=) <$> shapeScaleResolveMap
        , ("size" .=) <$> sizeScaleResolveMap
        , ("x" .=) <$> xScaleResolveMap
        , ("y" .=) <$> yScaleResolveMap
        ]

instance FromJSON ScaleResolveMap where
    parseJSON (Object v) = ScaleResolveMap
        <$> v .:! "color"
        <*> v .:! "opacity"
        <*> v .:! "shape"
        <*> v .:! "size"
        <*> v .:! "x"
        <*> v .:! "y"

instance ToJSON SelectionDef where
    toJSON (SelectionDef bindSelectionDef emptySelectionDef encodingsSelectionDef fieldsSelectionDef nearestSelectionDef onSelectionDef resolveSelectionDef selectionDefTypeSelectionDef toggleSelectionDef markSelectionDef translateSelectionDef zoomSelectionDef) =
        object $ foldMap (maybe [] pure)
        [ ("bind" .=) <$> bindSelectionDef
        , ("empty" .=) <$> emptySelectionDef
        , ("encodings" .=) <$> encodingsSelectionDef
        , ("fields" .=) <$> fieldsSelectionDef
        , ("nearest" .=) <$> nearestSelectionDef
        , ("on" .=) <$> onSelectionDef
        , ("resolve" .=) <$> resolveSelectionDef
        , Just $ "type" .= selectionDefTypeSelectionDef
        , ("toggle" .=) <$> toggleSelectionDef
        , ("mark" .=) <$> markSelectionDef
        , ("translate" .=) <$> translateSelectionDef
        , ("zoom" .=) <$> zoomSelectionDef
        ]

instance FromJSON SelectionDef where
    parseJSON (Object v) = SelectionDef
        <$> v .:! "bind"
        <*> v .:! "empty"
        <*> v .:! "encodings"
        <*> v .:! "fields"
        <*> v .:! "nearest"
        <*> v .:! "on"
        <*> v .:! "resolve"
        <*> v .: "type"
        <*> v .:! "toggle"
        <*> v .:! "mark"
        <*> v .:! "translate"
        <*> v .:! "zoom"

instance ToJSON BindUnion where
    toJSON (EnumInBindUnion x) = toJSON x
    toJSON (VGBindingMapInBindUnion x) = toJSON x

instance FromJSON BindUnion where
    parseJSON xs@(String _) = (fmap EnumInBindUnion . parseJSON) xs
    parseJSON xs@(Object _) = (fmap VGBindingMapInBindUnion . parseJSON) xs

instance ToJSON SelectionDefType where
    toJSON SingleSelectionDefType = "single"
    toJSON MultiSelectionDefType = "multi"
    toJSON IntervalSelectionDefType = "interval"

instance FromJSON SelectionDefType where
    parseJSON = withText "SelectionDefType" parseText
        where
            parseText "single" = return SingleSelectionDefType
            parseText "multi" = return MultiSelectionDefType
            parseText "interval" = return IntervalSelectionDefType

instance ToJSON Title where
    toJSON (StringInTitle x) = toJSON x
    toJSON (TitleParamsInTitle x) = toJSON x

instance FromJSON Title where
    parseJSON xs@(String _) = (fmap StringInTitle . parseJSON) xs
    parseJSON xs@(Object _) = (fmap TitleParamsInTitle . parseJSON) xs

instance ToJSON TitleParams where
    toJSON (TitleParams anchorTitleParams offsetTitleParams orientTitleParams styleTitleParams titleParamsTextTitleParams) =
        object $ foldMap (maybe [] pure)
        [ ("anchor" .=) <$> anchorTitleParams
        , ("offset" .=) <$> offsetTitleParams
        , ("orient" .=) <$> orientTitleParams
        , ("style" .=) <$> styleTitleParams
        , Just $ "text" .= titleParamsTextTitleParams
        ]

instance FromJSON TitleParams where
    parseJSON (Object v) = TitleParams
        <$> v .:! "anchor"
        <*> v .:! "offset"
        <*> v .:! "orient"
        <*> v .:! "style"
        <*> v .: "text"

instance ToJSON Transform where
    toJSON (Transform filterTransform transformAsTransform calculateTransform transformDefaultTransform fromTransform lookupTransform binTransform fieldTransform timeUnitTransform aggregateTransform groupbyTransform) =
        object $ foldMap (maybe [] pure)
        [ ("filter" .=) <$> filterTransform
        , ("as" .=) <$> transformAsTransform
        , ("calculate" .=) <$> calculateTransform
        , ("default" .=) <$> transformDefaultTransform
        , ("from" .=) <$> fromTransform
        , ("lookup" .=) <$> lookupTransform
        , ("bin" .=) <$> binTransform
        , ("field" .=) <$> fieldTransform
        , ("timeUnit" .=) <$> timeUnitTransform
        , ("aggregate" .=) <$> aggregateTransform
        , ("groupby" .=) <$> groupbyTransform
        ]

instance FromJSON Transform where
    parseJSON (Object v) = Transform
        <$> v .:! "filter"
        <*> v .:! "as"
        <*> v .:! "calculate"
        <*> v .:! "default"
        <*> v .:! "from"
        <*> v .:! "lookup"
        <*> v .:! "bin"
        <*> v .:! "field"
        <*> v .:! "timeUnit"
        <*> v .:! "aggregate"
        <*> v .:! "groupby"

instance ToJSON AggregatedFieldDef where
    toJSON (AggregatedFieldDef aggregatedFieldDefAsAggregatedFieldDef fieldAggregatedFieldDef opAggregatedFieldDef) =
        object $ foldMap (maybe [] pure)
        [ Just $ "as" .= aggregatedFieldDefAsAggregatedFieldDef
        , Just $ "field" .= fieldAggregatedFieldDef
        , Just $ "op" .= opAggregatedFieldDef
        ]

instance FromJSON AggregatedFieldDef where
    parseJSON (Object v) = AggregatedFieldDef
        <$> v .: "as"
        <*> v .: "field"
        <*> v .: "op"

instance ToJSON LookupData where
    toJSON (LookupData lookupDataDataLookupData fieldsLookupData keyLookupData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= lookupDataDataLookupData
        , ("fields" .=) <$> fieldsLookupData
        , Just $ "key" .= keyLookupData
        ]

instance FromJSON LookupData where
    parseJSON (Object v) = LookupData
        <$> v .: "data"
        <*> v .:! "fields"
        <*> v .: "key"

instance ToJSON Repeat where
    toJSON (Repeat columnRepeat rowRepeat) =
        object $ foldMap (maybe [] pure)
        [ ("column" .=) <$> columnRepeat
        , ("row" .=) <$> rowRepeat
        ]

instance FromJSON Repeat where
    parseJSON (Object v) = Repeat
        <$> v .:! "column"
        <*> v .:! "row"
