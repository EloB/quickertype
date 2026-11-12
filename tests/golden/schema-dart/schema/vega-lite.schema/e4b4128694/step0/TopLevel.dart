// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    
    ///URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
    ///have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
    ///Setting the `$schema` property allows automatic validation and autocomplete in editors
    ///that support JSON schema.
    final String? schema;
    
    ///Sets how the visualization size should be determined. If a string, should be one of
    ///`"pad"`, `"fit"` or `"none"`.
    ///Object values can additionally specify parameters for content sizing and automatic
    ///resizing.
    ///`"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    ///__Default value__: `pad`
    final dynamic autosize;
    
    ///CSS color property to use as the background of visualization.
    ///
    ///__Default value:__ none (transparent)
    final String? background;
    
    ///Vega-Lite configuration object.  This property can only be defined at the top-level of a
    ///specification.
    final Config? config;
    
    ///An object describing the data source
    final Data? data;
    
    ///Description of this mark for commenting purpose.
    final String? description;
    
    ///A key-value mapping between encoding channels and definition of fields.
    final EncodingWithFacet? encoding;
    
    ///The height of a visualization.
    ///
    ///__Default value:__
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    ///[continuous scale](scale.html#continuous), the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the height is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    ///`rangeStep` is `null`, the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    ///__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the height of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? height;
    
    ///A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    ///`"line"`,
    ///* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    ///object](mark.html#mark-def).
    final dynamic mark;
    
    ///Name of the visualization for later reference.
    final String? name;
    
    ///The default visualization padding, in pixels, from the edge of the visualization canvas
    ///to the data rectangle.  If a number, specifies padding for all sides.
    ///If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    ///"bottom": 5}` to specify padding for each side of the visualization.
    ///
    ///__Default value__: `5`
    final dynamic padding;
    
    ///An object defining properties of geographic projection.
    ///
    ///Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    ///more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    final Projection? projection;
    
    ///A key-value mapping between selection names and definitions.
    final Map<String, SelectionDef>? selection;
    
    ///Title for the plot.
    final dynamic title;
    
    ///An array of data transformations such as filter and new field calculation.
    final List<Transform>? transform;
    
    ///The width of a visualization.
    ///
    ///__Default value:__ This will be determined by the following rules:
    ///
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    ///[continuous scale](scale.html#continuous), the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the width is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    ///`rangeStep` is `null`, the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- If no field is mapped to `x` channel, the `width` will be the value of
    ///[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    ///the value of `rangeStep` for other marks.
    ///
    ///__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the width of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? width;
    
    ///Layer or single view specifications to be layered.
    ///
    ///__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    ///layering facet specifications is not allowed.
    final List<LayerSpec>? layer;
    
    ///Scale, axis, and legend resolutions for layers.
    ///
    ///Scale, axis, and legend resolutions for facets.
    ///
    ///Scale and legend resolutions for repeated charts.
    ///
    ///Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    ///Scale, axis, and legend resolutions for horizontally concatenated charts.
    final Resolve? resolve;
    
    ///An object that describes mappings between `row` and `column` channels and their field
    ///definitions.
    final FacetMapping? facet;
    
    ///A specification of the view that gets faceted.
    final Spec? spec;
    
    ///An object that describes what fields should be repeated into views that are laid out as a
    ///`row` or `column`.
    final Repeat? repeat;
    
    ///A list of views that should be concatenated and put into a column.
    final List<Spec>? vconcat;
    
    ///A list of views that should be concatenated and put into a row.
    final List<Spec>? hconcat;

    TopLevel({
        this.schema,
        this.autosize,
        this.background,
        this.config,
        this.data,
        this.description,
        this.encoding,
        this.height,
        this.mark,
        this.name,
        this.padding,
        this.projection,
        this.selection,
        this.title,
        this.transform,
        this.width,
        this.layer,
        this.resolve,
        this.facet,
        this.spec,
        this.repeat,
        this.vconcat,
        this.hconcat,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        schema: json["\u0024schema"],
        autosize: json["autosize"],
        background: json["background"],
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
        encoding: json["encoding"] == null ? null : EncodingWithFacet.fromJson(json["encoding"]),
        height: json["height"]?.toDouble(),
        mark: json["mark"],
        name: json["name"],
        padding: json["padding"],
        projection: json["projection"] == null ? null : Projection.fromJson(json["projection"]),
        selection: json["selection"] == null ? null : Map.from(json["selection"]!).map((k, v) => MapEntry<String, SelectionDef>(k, SelectionDef.fromJson(v))),
        title: json["title"],
        transform: json["transform"] == null ? null : List<Transform>.from(json["transform"]!.map((x) => Transform.fromJson(x))),
        width: json["width"]?.toDouble(),
        layer: json["layer"] == null ? null : List<LayerSpec>.from(json["layer"]!.map((x) => LayerSpec.fromJson(x))),
        resolve: json["resolve"] == null ? null : Resolve.fromJson(json["resolve"]),
        facet: json["facet"] == null ? null : FacetMapping.fromJson(json["facet"]),
        spec: json["spec"] == null ? null : Spec.fromJson(json["spec"]),
        repeat: json["repeat"] == null ? null : Repeat.fromJson(json["repeat"]),
        vconcat: json["vconcat"] == null ? null : List<Spec>.from(json["vconcat"]!.map((x) => Spec.fromJson(x))),
        hconcat: json["hconcat"] == null ? null : List<Spec>.from(json["hconcat"]!.map((x) => Spec.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "\u0024schema": schema,
        "autosize": autosize,
        "background": background,
        "config": config?.toJson(),
        "data": data?.toJson(),
        "description": description,
        "encoding": encoding?.toJson(),
        "height": height,
        "mark": mark,
        "name": name,
        "padding": padding,
        "projection": projection?.toJson(),
        "selection": selection == null ? null : Map.from(selection!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "title": title,
        "transform": transform == null ? null : List<dynamic>.from(transform!.map((x) => x.toJson())),
        "width": width,
        "layer": layer == null ? null : List<dynamic>.from(layer!.map((x) => x.toJson())),
        "resolve": resolve?.toJson(),
        "facet": facet?.toJson(),
        "spec": spec?.toJson(),
        "repeat": repeat?.toJson(),
        "vconcat": vconcat == null ? null : List<dynamic>.from(vconcat!.map((x) => x.toJson())),
        "hconcat": hconcat == null ? null : List<dynamic>.from(hconcat!.map((x) => x.toJson())),
    };
}

class AutoSizeParams {
    
    ///Determines how size calculation should be performed, one of `"content"` or `"padding"`.
    ///The default setting (`"content"`) interprets the width and height settings as the data
    ///rectangle (plotting) dimensions, to which padding is then added. In contrast, the
    ///`"padding"` setting includes the padding within the view size calculations, such that the
    ///width and height settings indicate the **total** intended size of the view.
    ///
    ///__Default value__: `"content"`
    final Contains? contains;
    
    ///A boolean flag indicating if autosize layout should be re-calculated on every view
    ///update.
    ///
    ///__Default value__: `false`
    final bool? resize;
    
    ///The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
    ///type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
    ///descriptions of each.
    ///
    ///__Default value__: `"pad"`
    final AutosizeType? type;

    AutoSizeParams({
        this.contains,
        this.resize,
        this.type,
    });

    factory AutoSizeParams.fromJson(Map<String, dynamic> json) => AutoSizeParams(
        contains: json["contains"] == null ? null : containsValues.map[json["contains"]]!,
        resize: json["resize"],
        type: json["type"] == null ? null : autosizeTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "contains": containsValues.reverse[contains],
        "resize": resize,
        "type": autosizeTypeValues.reverse[type],
    };
}


///Determines how size calculation should be performed, one of `"content"` or `"padding"`.
///The default setting (`"content"`) interprets the width and height settings as the data
///rectangle (plotting) dimensions, to which padding is then added. In contrast, the
///`"padding"` setting includes the padding within the view size calculations, such that the
///width and height settings indicate the **total** intended size of the view.
///
///__Default value__: `"content"`
enum Contains {
    CONTENT,
    PADDING
}

final containsValues = EnumValues({
    "content": Contains.CONTENT,
    "padding": Contains.PADDING
});


///The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
///type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
///descriptions of each.
///
///__Default value__: `"pad"`
enum AutosizeType {
    PAD,
    FIT,
    NONE
}

final autosizeTypeValues = EnumValues({
    "pad": AutosizeType.PAD,
    "fit": AutosizeType.FIT,
    "none": AutosizeType.NONE
});


///Vega-Lite configuration object.  This property can only be defined at the top-level of a
///specification.
class Config {
    
    ///Area-Specific Config
    final MarkConfig? area;
    
    ///Sets how the visualization size should be determined. If a string, should be one of
    ///`"pad"`, `"fit"` or `"none"`.
    ///Object values can additionally specify parameters for content sizing and automatic
    ///resizing.
    ///`"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    ///__Default value__: `pad`
    final dynamic autosize;
    
    ///Axis configuration, which determines default properties for all `x` and `y`
    ///[axes](axis.html). For a full list of axis configuration options, please see the
    ///[corresponding section of the axis documentation](axis.html#config).
    final AxisConfig? axis;
    
    ///Specific axis config for axes with "band" scales.
    final VgAxisConfig? axisBand;
    
    ///Specific axis config for x-axis along the bottom edge of the chart.
    final VgAxisConfig? axisBottom;
    
    ///Specific axis config for y-axis along the left edge of the chart.
    final VgAxisConfig? axisLeft;
    
    ///Specific axis config for y-axis along the right edge of the chart.
    final VgAxisConfig? axisRight;
    
    ///Specific axis config for x-axis along the top edge of the chart.
    final VgAxisConfig? axisTop;
    
    ///X-axis specific config.
    final VgAxisConfig? axisX;
    
    ///Y-axis specific config.
    final VgAxisConfig? axisY;
    
    ///CSS color property to use as the background of visualization.
    ///
    ///__Default value:__ none (transparent)
    final String? background;
    
    ///Bar-Specific Config
    final BarConfig? bar;
    
    ///Circle-Specific Config
    final MarkConfig? circle;
    
    ///Default axis and legend title for count fields.
    ///
    ///__Default value:__ `'Number of Records'`.
    final String? countTitle;
    
    ///Defines how Vega-Lite generates title for fields.  There are three possible styles:
    ///
    ///- `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
    ///"Year-month of date", "field (binned)").
    ///- `"function"` - displays function using parentheses and capitalized texts (e.g.,
    ///"SUM(field)", "YEARMONTH(date)", "BIN(field)").
    ///- `"plain"` - displays only the field name without functions (e.g., "field", "date",
    ///"field").
    final FieldTitle? fieldTitle;
    
    ///Geoshape-Specific Config
    final MarkConfig? geoshape;
    
    ///Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
    ///- If set to `"filter"` (default), all data items with null values are filtered.
    ///- If `null`, all data items are included. In this case, invalid values will be
    ///interpreted as zeroes.
    final InvalidValues? invalidValues;
    
    ///Legend configuration, which determines default properties for all [legends](legend.html).
    ///For a full list of legend configuration options, please see the [corresponding section of
    ///in the legend documentation](legend.html#config).
    final LegendConfig? legend;
    
    ///Line-Specific Config
    final MarkConfig? line;
    
    ///Mark Config
    final MarkConfig? mark;
    
    ///D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
    ///number format pattern](https://github.com/d3/d3-format#locale_format).
    final String? numberFormat;
    
    ///The default visualization padding, in pixels, from the edge of the visualization canvas
    ///to the data rectangle.  If a number, specifies padding for all sides.
    ///If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    ///"bottom": 5}` to specify padding for each side of the visualization.
    ///
    ///__Default value__: `5`
    final dynamic padding;
    
    ///Point-Specific Config
    final MarkConfig? point;
    
    ///Projection configuration, which determines default properties for all
    ///[projections](projection.html). For a full list of projection configuration options,
    ///please see the [corresponding section of the projection
    ///documentation](projection.html#config).
    final ProjectionConfig? projection;
    
    ///An object hash that defines default range arrays or schemes for using with scales.
    ///For a full list of scale range configuration options, please see the [corresponding
    ///section of the scale documentation](scale.html#config).
    final Map<String, dynamic>? range;
    
    ///Rect-Specific Config
    final MarkConfig? rect;
    
    ///Rule-Specific Config
    final MarkConfig? rule;
    
    ///Scale configuration determines default properties for all [scales](scale.html). For a
    ///full list of scale configuration options, please see the [corresponding section of the
    ///scale documentation](scale.html#config).
    final ScaleConfig? scale;
    
    ///An object hash for defining default properties for each type of selections.
    final SelectionConfig? selection;
    
    ///Square-Specific Config
    final MarkConfig? square;
    
    ///Default stack offset for stackable mark.
    final StackOffset? stack;
    
    ///An object hash that defines key-value mappings to determine default properties for marks
    ///with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
    ///valid [mark configuration objects](mark.html#config).
    final Map<String, VgMarkConfig>? style;
    
    ///Text-Specific Config
    final TextConfig? text;
    
    ///Tick-Specific Config
    final TickConfig? tick;
    
    ///Default datetime format for axis and legend labels. The format can be set directly on
    ///each axis and legend. Use [D3's time format
    ///pattern](https://github.com/d3/d3-time-format#locale_format).
    ///
    ///__Default value:__ `'%b %d, %Y'`.
    final String? timeFormat;
    
    ///Title configuration, which determines default properties for all [titles](title.html).
    ///For a full list of title configuration options, please see the [corresponding section of
    ///the title documentation](title.html#config).
    final VgTitleConfig? title;
    
    ///Default properties for [single view plots](spec.html#single).
    final ViewConfig? view;

    Config({
        this.area,
        this.autosize,
        this.axis,
        this.axisBand,
        this.axisBottom,
        this.axisLeft,
        this.axisRight,
        this.axisTop,
        this.axisX,
        this.axisY,
        this.background,
        this.bar,
        this.circle,
        this.countTitle,
        this.fieldTitle,
        this.geoshape,
        this.invalidValues,
        this.legend,
        this.line,
        this.mark,
        this.numberFormat,
        this.padding,
        this.point,
        this.projection,
        this.range,
        this.rect,
        this.rule,
        this.scale,
        this.selection,
        this.square,
        this.stack,
        this.style,
        this.text,
        this.tick,
        this.timeFormat,
        this.title,
        this.view,
    });

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        area: json["area"] == null ? null : MarkConfig.fromJson(json["area"]),
        autosize: json["autosize"],
        axis: json["axis"] == null ? null : AxisConfig.fromJson(json["axis"]),
        axisBand: json["axisBand"] == null ? null : VgAxisConfig.fromJson(json["axisBand"]),
        axisBottom: json["axisBottom"] == null ? null : VgAxisConfig.fromJson(json["axisBottom"]),
        axisLeft: json["axisLeft"] == null ? null : VgAxisConfig.fromJson(json["axisLeft"]),
        axisRight: json["axisRight"] == null ? null : VgAxisConfig.fromJson(json["axisRight"]),
        axisTop: json["axisTop"] == null ? null : VgAxisConfig.fromJson(json["axisTop"]),
        axisX: json["axisX"] == null ? null : VgAxisConfig.fromJson(json["axisX"]),
        axisY: json["axisY"] == null ? null : VgAxisConfig.fromJson(json["axisY"]),
        background: json["background"],
        bar: json["bar"] == null ? null : BarConfig.fromJson(json["bar"]),
        circle: json["circle"] == null ? null : MarkConfig.fromJson(json["circle"]),
        countTitle: json["countTitle"],
        fieldTitle: json["fieldTitle"] == null ? null : fieldTitleValues.map[json["fieldTitle"]]!,
        geoshape: json["geoshape"] == null ? null : MarkConfig.fromJson(json["geoshape"]),
        invalidValues: json["invalidValues"] == null ? null : invalidValuesValues.map[json["invalidValues"]]!,
        legend: json["legend"] == null ? null : LegendConfig.fromJson(json["legend"]),
        line: json["line"] == null ? null : MarkConfig.fromJson(json["line"]),
        mark: json["mark"] == null ? null : MarkConfig.fromJson(json["mark"]),
        numberFormat: json["numberFormat"],
        padding: json["padding"],
        point: json["point"] == null ? null : MarkConfig.fromJson(json["point"]),
        projection: json["projection"] == null ? null : ProjectionConfig.fromJson(json["projection"]),
        range: json["range"] == null ? null : Map.from(json["range"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        rect: json["rect"] == null ? null : MarkConfig.fromJson(json["rect"]),
        rule: json["rule"] == null ? null : MarkConfig.fromJson(json["rule"]),
        scale: json["scale"] == null ? null : ScaleConfig.fromJson(json["scale"]),
        selection: json["selection"] == null ? null : SelectionConfig.fromJson(json["selection"]),
        square: json["square"] == null ? null : MarkConfig.fromJson(json["square"]),
        stack: json["stack"] == null ? null : stackOffsetValues.map[json["stack"]]!,
        style: json["style"] == null ? null : Map.from(json["style"]!).map((k, v) => MapEntry<String, VgMarkConfig>(k, VgMarkConfig.fromJson(v))),
        text: json["text"] == null ? null : TextConfig.fromJson(json["text"]),
        tick: json["tick"] == null ? null : TickConfig.fromJson(json["tick"]),
        timeFormat: json["timeFormat"],
        title: json["title"] == null ? null : VgTitleConfig.fromJson(json["title"]),
        view: json["view"] == null ? null : ViewConfig.fromJson(json["view"]),
    );

    Map<String, dynamic> toJson() => {
        "area": area?.toJson(),
        "autosize": autosize,
        "axis": axis?.toJson(),
        "axisBand": axisBand?.toJson(),
        "axisBottom": axisBottom?.toJson(),
        "axisLeft": axisLeft?.toJson(),
        "axisRight": axisRight?.toJson(),
        "axisTop": axisTop?.toJson(),
        "axisX": axisX?.toJson(),
        "axisY": axisY?.toJson(),
        "background": background,
        "bar": bar?.toJson(),
        "circle": circle?.toJson(),
        "countTitle": countTitle,
        "fieldTitle": fieldTitleValues.reverse[fieldTitle],
        "geoshape": geoshape?.toJson(),
        "invalidValues": invalidValuesValues.reverse[invalidValues],
        "legend": legend?.toJson(),
        "line": line?.toJson(),
        "mark": mark?.toJson(),
        "numberFormat": numberFormat,
        "padding": padding,
        "point": point?.toJson(),
        "projection": projection?.toJson(),
        "range": range == null ? null : Map.from(range!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "rect": rect?.toJson(),
        "rule": rule?.toJson(),
        "scale": scale?.toJson(),
        "selection": selection?.toJson(),
        "square": square?.toJson(),
        "stack": stackOffsetValues.reverse[stack],
        "style": style == null ? null : Map.from(style!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "text": text?.toJson(),
        "tick": tick?.toJson(),
        "timeFormat": timeFormat,
        "title": title?.toJson(),
        "view": view?.toJson(),
    };
}


///Area-Specific Config
///
///Circle-Specific Config
///
///Geoshape-Specific Config
///
///Line-Specific Config
///
///Mark Config
///
///Point-Specific Config
///
///Rect-Specific Config
///
///Rule-Specific Config
///
///Square-Specific Config
class MarkConfig {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    ///will override `color`.
    ///
    ///__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final String? color;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///Whether the mark's color should be used as fill color instead of stroke color.
    ///
    ///__Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    ///__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final bool? filled;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;

    MarkConfig({
        this.align,
        this.angle,
        this.baseline,
        this.color,
        this.cursor,
        this.dx,
        this.dy,
        this.fill,
        this.filled,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.tension,
        this.text,
        this.theta,
    });

    factory MarkConfig.fromJson(Map<String, dynamic> json) => MarkConfig(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        color: json["color"],
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        filled: json["filled"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "color": color,
        "cursor": cursorValues.reverse[cursor],
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "filled": filled,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "tension": tension,
        "text": text,
        "theta": theta,
    };
}


///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
enum HorizontalAlign {
    LEFT,
    RIGHT,
    CENTER
}

final horizontalAlignValues = EnumValues({
    "left": HorizontalAlign.LEFT,
    "right": HorizontalAlign.RIGHT,
    "center": HorizontalAlign.CENTER
});


///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
///__Default value:__ `"middle"`
///
///Vertical text baseline for title text.
enum VerticalAlign {
    TOP,
    MIDDLE,
    BOTTOM
}

final verticalAlignValues = EnumValues({
    "top": VerticalAlign.TOP,
    "middle": VerticalAlign.MIDDLE,
    "bottom": VerticalAlign.BOTTOM
});


///The mouse cursor used over the mark. Any valid [CSS cursor
///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
enum Cursor {
    AUTO,
    DEFAULT,
    NONE,
    CONTEXT_MENU,
    HELP,
    POINTER,
    PROGRESS,
    WAIT,
    CELL,
    CROSSHAIR,
    TEXT,
    VERTICAL_TEXT,
    ALIAS,
    COPY,
    MOVE,
    NO_DROP,
    NOT_ALLOWED,
    E_RESIZE,
    N_RESIZE,
    NE_RESIZE,
    NW_RESIZE,
    S_RESIZE,
    SE_RESIZE,
    SW_RESIZE,
    W_RESIZE,
    EW_RESIZE,
    NS_RESIZE,
    NESW_RESIZE,
    NWSE_RESIZE,
    COL_RESIZE,
    ROW_RESIZE,
    ALL_SCROLL,
    ZOOM_IN,
    ZOOM_OUT,
    GRAB,
    GRABBING
}

final cursorValues = EnumValues({
    "auto": Cursor.AUTO,
    "default": Cursor.DEFAULT,
    "none": Cursor.NONE,
    "context-menu": Cursor.CONTEXT_MENU,
    "help": Cursor.HELP,
    "pointer": Cursor.POINTER,
    "progress": Cursor.PROGRESS,
    "wait": Cursor.WAIT,
    "cell": Cursor.CELL,
    "crosshair": Cursor.CROSSHAIR,
    "text": Cursor.TEXT,
    "vertical-text": Cursor.VERTICAL_TEXT,
    "alias": Cursor.ALIAS,
    "copy": Cursor.COPY,
    "move": Cursor.MOVE,
    "no-drop": Cursor.NO_DROP,
    "not-allowed": Cursor.NOT_ALLOWED,
    "e-resize": Cursor.E_RESIZE,
    "n-resize": Cursor.N_RESIZE,
    "ne-resize": Cursor.NE_RESIZE,
    "nw-resize": Cursor.NW_RESIZE,
    "s-resize": Cursor.S_RESIZE,
    "se-resize": Cursor.SE_RESIZE,
    "sw-resize": Cursor.SW_RESIZE,
    "w-resize": Cursor.W_RESIZE,
    "ew-resize": Cursor.EW_RESIZE,
    "ns-resize": Cursor.NS_RESIZE,
    "nesw-resize": Cursor.NESW_RESIZE,
    "nwse-resize": Cursor.NWSE_RESIZE,
    "col-resize": Cursor.COL_RESIZE,
    "row-resize": Cursor.ROW_RESIZE,
    "all-scroll": Cursor.ALL_SCROLL,
    "zoom-in": Cursor.ZOOM_IN,
    "zoom-out": Cursor.ZOOM_OUT,
    "grab": Cursor.GRAB,
    "grabbing": Cursor.GRABBING
});


///The font style (e.g., `"italic"`).
enum FontStyle {
    NORMAL,
    ITALIC
}

final fontStyleValues = EnumValues({
    "normal": FontStyle.NORMAL,
    "italic": FontStyle.ITALIC
});

enum FontWeight {
    NORMAL,
    BOLD
}

final fontWeightValues = EnumValues({
    "normal": FontWeight.NORMAL,
    "bold": FontWeight.BOLD
});


///The line interpolation method to use for line and area marks. One of the following:
///- `"linear"`: piecewise linear segments, as in a polyline.
///- `"linear-closed"`: close the linear segments to form a polygon.
///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
///function.
///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
///function.
///- `"basis"`: a B-spline, with control point duplication on the ends.
///- `"basis-open"`: an open B-spline; may not intersect the start or end.
///- `"basis-closed"`: a closed B-spline, as in a loop.
///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
///will intersect other control points.
///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
///spline.
///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
enum Interpolate {
    LINEAR,
    LINEAR_CLOSED,
    STEP,
    STEP_BEFORE,
    STEP_AFTER,
    BASIS,
    BASIS_OPEN,
    BASIS_CLOSED,
    CARDINAL,
    CARDINAL_OPEN,
    CARDINAL_CLOSED,
    BUNDLE,
    MONOTONE
}

final interpolateValues = EnumValues({
    "linear": Interpolate.LINEAR,
    "linear-closed": Interpolate.LINEAR_CLOSED,
    "step": Interpolate.STEP,
    "step-before": Interpolate.STEP_BEFORE,
    "step-after": Interpolate.STEP_AFTER,
    "basis": Interpolate.BASIS,
    "basis-open": Interpolate.BASIS_OPEN,
    "basis-closed": Interpolate.BASIS_CLOSED,
    "cardinal": Interpolate.CARDINAL,
    "cardinal-open": Interpolate.CARDINAL_OPEN,
    "cardinal-closed": Interpolate.CARDINAL_CLOSED,
    "bundle": Interpolate.BUNDLE,
    "monotone": Interpolate.MONOTONE
});


///The orientation of a non-stacked bar, tick, area, and line charts.
///The value is either horizontal (default) or vertical.
///- For bar, rule and tick, this determines whether the size of the bar and tick
///should be applied to x or y dimension.
///- For area, this property determines the orient property of the Vega output.
///- For line, this property determines the sort order of the points in the line
///if `config.sortLineBy` is not specified.
///For stacked charts, this is always determined by the orientation of the stack;
///therefore explicitly specified value will be ignored.
enum Orient {
    HORIZONTAL,
    VERTICAL
}

final orientValues = EnumValues({
    "horizontal": Orient.HORIZONTAL,
    "vertical": Orient.VERTICAL
});


///Axis configuration, which determines default properties for all `x` and `y`
///[axes](axis.html). For a full list of axis configuration options, please see the
///[corresponding section of the axis documentation](axis.html#config).
class AxisConfig {
    
    ///An interpolation fraction indicating where, for `band` scales, axis ticks should be
    ///positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    ///places ticks in the middle of their bands.
    final double? bandPosition;
    
    ///A boolean flag indicating if the domain (the axis baseline) should be included as part of
    ///the axis.
    ///
    ///__Default value:__ `true`
    final bool? domain;
    
    ///Color of axis domain line.
    ///
    ///__Default value:__  (none, using Vega default).
    final String? domainColor;
    
    ///Stroke width of axis domain line
    ///
    ///__Default value:__  (none, using Vega default).
    final double? domainWidth;
    
    ///A boolean flag indicating if grid lines should be included as part of the axis
    ///
    ///__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    ///binned; otherwise, `false`.
    final bool? grid;
    
    ///Color of gridlines.
    final String? gridColor;
    
    ///The offset (in pixels) into which to begin drawing with the grid dash array.
    final List<double>? gridDash;
    
    ///The stroke opacity of grid (value between [0,1])
    ///
    ///__Default value:__ (`1` by default)
    final double? gridOpacity;
    
    ///The grid width, in pixels.
    final double? gridWidth;
    
    ///The rotation angle of the axis labels.
    ///
    ///__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    final double? labelAngle;
    
    ///Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    ///default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    ///they exceed the axis range by more than 1 pixel. If this property is a number, it
    ///specifies the pixel tolerance: the maximum amount by which a label bounding box may
    ///exceed the axis range.
    ///
    ///__Default value:__ `false`.
    final dynamic labelBound;
    
    ///The color of the tick label, can be in hex color code or regular color name.
    final String? labelColor;
    
    ///Indicates if the first and last axis labels should be aligned flush with the scale range.
    ///Flush alignment for a horizontal axis will left-align the first label and right-align the
    ///last label. For vertical axes, bottom and top text baselines are applied instead. If this
    ///property is a number, it also indicates the number of pixels by which to offset the first
    ///and last labels; for example, a value of 2 will flush-align the first and last labels and
    ///also push them 2 pixels outward from the center of the axis. The additional adjustment
    ///can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    ///__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    final dynamic labelFlush;
    
    ///The font of the tick label.
    final String? labelFont;
    
    ///The font size of the label, in pixels.
    final double? labelFontSize;
    
    ///Maximum allowed pixel width of axis tick labels.
    final double? labelLimit;
    
    ///The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    ///overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    ///every other label is used (this works well for standard linear axes). If set to
    ///`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    ///with the last visible label (this often works better for log-scaled axes).
    ///
    ///__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    ///scales; otherwise `false`.
    final dynamic labelOverlap;
    
    ///The padding, in pixels, between axis and text labels.
    final double? labelPadding;
    
    ///A boolean flag indicating if labels should be included as part of the axis.
    ///
    ///__Default value:__  `true`.
    final bool? labels;
    
    ///The maximum extent in pixels that axis ticks and labels should use. This determines a
    ///maximum offset value for axis titles.
    ///
    ///__Default value:__ `undefined`.
    final double? maxExtent;
    
    ///The minimum extent in pixels that axis ticks and labels should use. This determines a
    ///minimum offset value for axis titles.
    ///
    ///__Default value:__ `30` for y-axis; `undefined` for x-axis.
    final double? minExtent;
    
    ///Whether month names and weekday names should be abbreviated.
    ///
    ///__Default value:__  `false`
    final bool? shortTimeLabels;
    
    ///The color of the axis's tick.
    final String? tickColor;
    
    ///Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    final bool? tickRound;
    
    ///Boolean value that determines whether the axis should include ticks.
    final bool? ticks;
    
    ///The size in pixels of axis ticks.
    final double? tickSize;
    
    ///The width, in pixels, of ticks.
    final double? tickWidth;
    
    ///Horizontal text alignment of axis titles.
    final String? titleAlign;
    
    ///Angle in degrees of axis titles.
    final double? titleAngle;
    
    ///Vertical text baseline for axis titles.
    final String? titleBaseline;
    
    ///Color of the title, can be in hex color code or regular color name.
    final String? titleColor;
    
    ///Font of the title. (e.g., `"Helvetica Neue"`).
    final String? titleFont;
    
    ///Font size of the title.
    final double? titleFontSize;
    
    ///Font weight of the title. (e.g., `"bold"`).
    final dynamic titleFontWeight;
    
    ///Maximum allowed pixel width of axis titles.
    final double? titleLimit;
    
    ///Max length for axis title if the title is automatically generated from the field's
    ///description.
    final double? titleMaxLength;
    
    ///The padding, in pixels, between title and axis.
    final double? titlePadding;
    
    ///X-coordinate of the axis title relative to the axis group.
    final double? titleX;
    
    ///Y-coordinate of the axis title relative to the axis group.
    final double? titleY;

    AxisConfig({
        this.bandPosition,
        this.domain,
        this.domainColor,
        this.domainWidth,
        this.grid,
        this.gridColor,
        this.gridDash,
        this.gridOpacity,
        this.gridWidth,
        this.labelAngle,
        this.labelBound,
        this.labelColor,
        this.labelFlush,
        this.labelFont,
        this.labelFontSize,
        this.labelLimit,
        this.labelOverlap,
        this.labelPadding,
        this.labels,
        this.maxExtent,
        this.minExtent,
        this.shortTimeLabels,
        this.tickColor,
        this.tickRound,
        this.ticks,
        this.tickSize,
        this.tickWidth,
        this.titleAlign,
        this.titleAngle,
        this.titleBaseline,
        this.titleColor,
        this.titleFont,
        this.titleFontSize,
        this.titleFontWeight,
        this.titleLimit,
        this.titleMaxLength,
        this.titlePadding,
        this.titleX,
        this.titleY,
    });

    factory AxisConfig.fromJson(Map<String, dynamic> json) => AxisConfig(
        bandPosition: json["bandPosition"]?.toDouble(),
        domain: json["domain"],
        domainColor: json["domainColor"],
        domainWidth: json["domainWidth"]?.toDouble(),
        grid: json["grid"],
        gridColor: json["gridColor"],
        gridDash: json["gridDash"] == null ? null : List<double>.from(json["gridDash"]!.map((x) => x?.toDouble())),
        gridOpacity: json["gridOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["gridOpacity"]?.toDouble()),
        gridWidth: json["gridWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["gridWidth"]?.toDouble()),
        labelAngle: json["labelAngle"]?.toDouble() == null ? null : ((x) => x >= -360 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["labelAngle"]?.toDouble()),
        labelBound: json["labelBound"],
        labelColor: json["labelColor"],
        labelFlush: json["labelFlush"],
        labelFont: json["labelFont"],
        labelFontSize: json["labelFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["labelFontSize"]?.toDouble()),
        labelLimit: json["labelLimit"]?.toDouble(),
        labelOverlap: json["labelOverlap"],
        labelPadding: json["labelPadding"]?.toDouble(),
        labels: json["labels"],
        maxExtent: json["maxExtent"]?.toDouble(),
        minExtent: json["minExtent"]?.toDouble(),
        shortTimeLabels: json["shortTimeLabels"],
        tickColor: json["tickColor"],
        tickRound: json["tickRound"],
        ticks: json["ticks"],
        tickSize: json["tickSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["tickSize"]?.toDouble()),
        tickWidth: json["tickWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["tickWidth"]?.toDouble()),
        titleAlign: json["titleAlign"],
        titleAngle: json["titleAngle"]?.toDouble(),
        titleBaseline: json["titleBaseline"],
        titleColor: json["titleColor"],
        titleFont: json["titleFont"],
        titleFontSize: json["titleFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["titleFontSize"]?.toDouble()),
        titleFontWeight: json["titleFontWeight"],
        titleLimit: json["titleLimit"]?.toDouble(),
        titleMaxLength: json["titleMaxLength"]?.toDouble(),
        titlePadding: json["titlePadding"]?.toDouble(),
        titleX: json["titleX"]?.toDouble(),
        titleY: json["titleY"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bandPosition": bandPosition,
        "domain": domain,
        "domainColor": domainColor,
        "domainWidth": domainWidth,
        "grid": grid,
        "gridColor": gridColor,
        "gridDash": gridDash == null ? null : List<dynamic>.from(gridDash!.map((x) => x)),
        "gridOpacity": gridOpacity,
        "gridWidth": gridWidth,
        "labelAngle": labelAngle,
        "labelBound": labelBound,
        "labelColor": labelColor,
        "labelFlush": labelFlush,
        "labelFont": labelFont,
        "labelFontSize": labelFontSize,
        "labelLimit": labelLimit,
        "labelOverlap": labelOverlap,
        "labelPadding": labelPadding,
        "labels": labels,
        "maxExtent": maxExtent,
        "minExtent": minExtent,
        "shortTimeLabels": shortTimeLabels,
        "tickColor": tickColor,
        "tickRound": tickRound,
        "ticks": ticks,
        "tickSize": tickSize,
        "tickWidth": tickWidth,
        "titleAlign": titleAlign,
        "titleAngle": titleAngle,
        "titleBaseline": titleBaseline,
        "titleColor": titleColor,
        "titleFont": titleFont,
        "titleFontSize": titleFontSize,
        "titleFontWeight": titleFontWeight,
        "titleLimit": titleLimit,
        "titleMaxLength": titleMaxLength,
        "titlePadding": titlePadding,
        "titleX": titleX,
        "titleY": titleY,
    };
}

enum LabelOverlapEnum {
    PARITY,
    GREEDY
}

final labelOverlapEnumValues = EnumValues({
    "parity": LabelOverlapEnum.PARITY,
    "greedy": LabelOverlapEnum.GREEDY
});


///Specific axis config for axes with "band" scales.
///
///Specific axis config for x-axis along the bottom edge of the chart.
///
///Specific axis config for y-axis along the left edge of the chart.
///
///Specific axis config for y-axis along the right edge of the chart.
///
///Specific axis config for x-axis along the top edge of the chart.
///
///X-axis specific config.
///
///Y-axis specific config.
class VgAxisConfig {
    
    ///An interpolation fraction indicating where, for `band` scales, axis ticks should be
    ///positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    ///places ticks in the middle of their bands.
    final double? bandPosition;
    
    ///A boolean flag indicating if the domain (the axis baseline) should be included as part of
    ///the axis.
    ///
    ///__Default value:__ `true`
    final bool? domain;
    
    ///Color of axis domain line.
    ///
    ///__Default value:__  (none, using Vega default).
    final String? domainColor;
    
    ///Stroke width of axis domain line
    ///
    ///__Default value:__  (none, using Vega default).
    final double? domainWidth;
    
    ///A boolean flag indicating if grid lines should be included as part of the axis
    ///
    ///__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    ///binned; otherwise, `false`.
    final bool? grid;
    
    ///Color of gridlines.
    final String? gridColor;
    
    ///The offset (in pixels) into which to begin drawing with the grid dash array.
    final List<double>? gridDash;
    
    ///The stroke opacity of grid (value between [0,1])
    ///
    ///__Default value:__ (`1` by default)
    final double? gridOpacity;
    
    ///The grid width, in pixels.
    final double? gridWidth;
    
    ///The rotation angle of the axis labels.
    ///
    ///__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    final double? labelAngle;
    
    ///Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    ///default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    ///they exceed the axis range by more than 1 pixel. If this property is a number, it
    ///specifies the pixel tolerance: the maximum amount by which a label bounding box may
    ///exceed the axis range.
    ///
    ///__Default value:__ `false`.
    final dynamic labelBound;
    
    ///The color of the tick label, can be in hex color code or regular color name.
    final String? labelColor;
    
    ///Indicates if the first and last axis labels should be aligned flush with the scale range.
    ///Flush alignment for a horizontal axis will left-align the first label and right-align the
    ///last label. For vertical axes, bottom and top text baselines are applied instead. If this
    ///property is a number, it also indicates the number of pixels by which to offset the first
    ///and last labels; for example, a value of 2 will flush-align the first and last labels and
    ///also push them 2 pixels outward from the center of the axis. The additional adjustment
    ///can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    ///__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    final dynamic labelFlush;
    
    ///The font of the tick label.
    final String? labelFont;
    
    ///The font size of the label, in pixels.
    final double? labelFontSize;
    
    ///Maximum allowed pixel width of axis tick labels.
    final double? labelLimit;
    
    ///The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    ///overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    ///every other label is used (this works well for standard linear axes). If set to
    ///`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    ///with the last visible label (this often works better for log-scaled axes).
    ///
    ///__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    ///scales; otherwise `false`.
    final dynamic labelOverlap;
    
    ///The padding, in pixels, between axis and text labels.
    final double? labelPadding;
    
    ///A boolean flag indicating if labels should be included as part of the axis.
    ///
    ///__Default value:__  `true`.
    final bool? labels;
    
    ///The maximum extent in pixels that axis ticks and labels should use. This determines a
    ///maximum offset value for axis titles.
    ///
    ///__Default value:__ `undefined`.
    final double? maxExtent;
    
    ///The minimum extent in pixels that axis ticks and labels should use. This determines a
    ///minimum offset value for axis titles.
    ///
    ///__Default value:__ `30` for y-axis; `undefined` for x-axis.
    final double? minExtent;
    
    ///The color of the axis's tick.
    final String? tickColor;
    
    ///Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    final bool? tickRound;
    
    ///Boolean value that determines whether the axis should include ticks.
    final bool? ticks;
    
    ///The size in pixels of axis ticks.
    final double? tickSize;
    
    ///The width, in pixels, of ticks.
    final double? tickWidth;
    
    ///Horizontal text alignment of axis titles.
    final String? titleAlign;
    
    ///Angle in degrees of axis titles.
    final double? titleAngle;
    
    ///Vertical text baseline for axis titles.
    final String? titleBaseline;
    
    ///Color of the title, can be in hex color code or regular color name.
    final String? titleColor;
    
    ///Font of the title. (e.g., `"Helvetica Neue"`).
    final String? titleFont;
    
    ///Font size of the title.
    final double? titleFontSize;
    
    ///Font weight of the title. (e.g., `"bold"`).
    final dynamic titleFontWeight;
    
    ///Maximum allowed pixel width of axis titles.
    final double? titleLimit;
    
    ///Max length for axis title if the title is automatically generated from the field's
    ///description.
    final double? titleMaxLength;
    
    ///The padding, in pixels, between title and axis.
    final double? titlePadding;
    
    ///X-coordinate of the axis title relative to the axis group.
    final double? titleX;
    
    ///Y-coordinate of the axis title relative to the axis group.
    final double? titleY;

    VgAxisConfig({
        this.bandPosition,
        this.domain,
        this.domainColor,
        this.domainWidth,
        this.grid,
        this.gridColor,
        this.gridDash,
        this.gridOpacity,
        this.gridWidth,
        this.labelAngle,
        this.labelBound,
        this.labelColor,
        this.labelFlush,
        this.labelFont,
        this.labelFontSize,
        this.labelLimit,
        this.labelOverlap,
        this.labelPadding,
        this.labels,
        this.maxExtent,
        this.minExtent,
        this.tickColor,
        this.tickRound,
        this.ticks,
        this.tickSize,
        this.tickWidth,
        this.titleAlign,
        this.titleAngle,
        this.titleBaseline,
        this.titleColor,
        this.titleFont,
        this.titleFontSize,
        this.titleFontWeight,
        this.titleLimit,
        this.titleMaxLength,
        this.titlePadding,
        this.titleX,
        this.titleY,
    });

    factory VgAxisConfig.fromJson(Map<String, dynamic> json) => VgAxisConfig(
        bandPosition: json["bandPosition"]?.toDouble(),
        domain: json["domain"],
        domainColor: json["domainColor"],
        domainWidth: json["domainWidth"]?.toDouble(),
        grid: json["grid"],
        gridColor: json["gridColor"],
        gridDash: json["gridDash"] == null ? null : List<double>.from(json["gridDash"]!.map((x) => x?.toDouble())),
        gridOpacity: json["gridOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["gridOpacity"]?.toDouble()),
        gridWidth: json["gridWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["gridWidth"]?.toDouble()),
        labelAngle: json["labelAngle"]?.toDouble() == null ? null : ((x) => x >= -360 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["labelAngle"]?.toDouble()),
        labelBound: json["labelBound"],
        labelColor: json["labelColor"],
        labelFlush: json["labelFlush"],
        labelFont: json["labelFont"],
        labelFontSize: json["labelFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["labelFontSize"]?.toDouble()),
        labelLimit: json["labelLimit"]?.toDouble(),
        labelOverlap: json["labelOverlap"],
        labelPadding: json["labelPadding"]?.toDouble(),
        labels: json["labels"],
        maxExtent: json["maxExtent"]?.toDouble(),
        minExtent: json["minExtent"]?.toDouble(),
        tickColor: json["tickColor"],
        tickRound: json["tickRound"],
        ticks: json["ticks"],
        tickSize: json["tickSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["tickSize"]?.toDouble()),
        tickWidth: json["tickWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["tickWidth"]?.toDouble()),
        titleAlign: json["titleAlign"],
        titleAngle: json["titleAngle"]?.toDouble(),
        titleBaseline: json["titleBaseline"],
        titleColor: json["titleColor"],
        titleFont: json["titleFont"],
        titleFontSize: json["titleFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["titleFontSize"]?.toDouble()),
        titleFontWeight: json["titleFontWeight"],
        titleLimit: json["titleLimit"]?.toDouble(),
        titleMaxLength: json["titleMaxLength"]?.toDouble(),
        titlePadding: json["titlePadding"]?.toDouble(),
        titleX: json["titleX"]?.toDouble(),
        titleY: json["titleY"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bandPosition": bandPosition,
        "domain": domain,
        "domainColor": domainColor,
        "domainWidth": domainWidth,
        "grid": grid,
        "gridColor": gridColor,
        "gridDash": gridDash == null ? null : List<dynamic>.from(gridDash!.map((x) => x)),
        "gridOpacity": gridOpacity,
        "gridWidth": gridWidth,
        "labelAngle": labelAngle,
        "labelBound": labelBound,
        "labelColor": labelColor,
        "labelFlush": labelFlush,
        "labelFont": labelFont,
        "labelFontSize": labelFontSize,
        "labelLimit": labelLimit,
        "labelOverlap": labelOverlap,
        "labelPadding": labelPadding,
        "labels": labels,
        "maxExtent": maxExtent,
        "minExtent": minExtent,
        "tickColor": tickColor,
        "tickRound": tickRound,
        "ticks": ticks,
        "tickSize": tickSize,
        "tickWidth": tickWidth,
        "titleAlign": titleAlign,
        "titleAngle": titleAngle,
        "titleBaseline": titleBaseline,
        "titleColor": titleColor,
        "titleFont": titleFont,
        "titleFontSize": titleFontSize,
        "titleFontWeight": titleFontWeight,
        "titleLimit": titleLimit,
        "titleMaxLength": titleMaxLength,
        "titlePadding": titlePadding,
        "titleX": titleX,
        "titleY": titleY,
    };
}


///Bar-Specific Config
class BarConfig {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
    ///statisticians) or 1 (Vega-Lite Default, D3 example style).
    ///
    ///__Default value:__ `1`
    final double? binSpacing;
    
    ///Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    ///will override `color`.
    ///
    ///__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final String? color;
    
    ///The default size of the bars on continuous scales.
    ///
    ///__Default value:__ `5`
    final double? continuousBandSize;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The size of the bars.  If unspecified, the default size is  `bandSize-1`,
    ///which provides 1 pixel offset between bars.
    final double? discreteBandSize;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///Whether the mark's color should be used as fill color instead of stroke color.
    ///
    ///__Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    ///__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final bool? filled;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;

    BarConfig({
        this.align,
        this.angle,
        this.baseline,
        this.binSpacing,
        this.color,
        this.continuousBandSize,
        this.cursor,
        this.discreteBandSize,
        this.dx,
        this.dy,
        this.fill,
        this.filled,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.tension,
        this.text,
        this.theta,
    });

    factory BarConfig.fromJson(Map<String, dynamic> json) => BarConfig(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        binSpacing: json["binSpacing"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["binSpacing"]?.toDouble()),
        color: json["color"],
        continuousBandSize: json["continuousBandSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["continuousBandSize"]?.toDouble()),
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        discreteBandSize: json["discreteBandSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["discreteBandSize"]?.toDouble()),
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        filled: json["filled"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "binSpacing": binSpacing,
        "color": color,
        "continuousBandSize": continuousBandSize,
        "cursor": cursorValues.reverse[cursor],
        "discreteBandSize": discreteBandSize,
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "filled": filled,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "tension": tension,
        "text": text,
        "theta": theta,
    };
}


///Defines how Vega-Lite generates title for fields.  There are three possible styles:
///
///- `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
///"Year-month of date", "field (binned)").
///- `"function"` - displays function using parentheses and capitalized texts (e.g.,
///"SUM(field)", "YEARMONTH(date)", "BIN(field)").
///- `"plain"` - displays only the field name without functions (e.g., "field", "date",
///"field").
enum FieldTitle {
    VERBAL,
    FUNCTIONAL,
    PLAIN
}

final fieldTitleValues = EnumValues({
    "verbal": FieldTitle.VERBAL,
    "functional": FieldTitle.FUNCTIONAL,
    "plain": FieldTitle.PLAIN
});


///Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
///- If set to `"filter"` (default), all data items with null values are filtered.
///- If `null`, all data items are included. In this case, invalid values will be
///interpreted as zeroes.
enum InvalidValues {
    FILTER
}

final invalidValuesValues = EnumValues({
    "filter": InvalidValues.FILTER
});


///Legend configuration, which determines default properties for all [legends](legend.html).
///For a full list of legend configuration options, please see the [corresponding section of
///in the legend documentation](legend.html#config).
class LegendConfig {
    
    ///Corner radius for the full legend.
    final double? cornerRadius;
    
    ///Padding (in pixels) between legend entries in a symbol legend.
    final double? entryPadding;
    
    ///Background fill color for the full legend.
    final String? fillColor;
    
    ///The height of the gradient, in pixels.
    final double? gradientHeight;
    
    ///Text baseline for color ramp gradient labels.
    final String? gradientLabelBaseline;
    
    ///The maximum allowed length in pixels of color ramp gradient labels.
    final double? gradientLabelLimit;
    
    ///Vertical offset in pixels for color ramp gradient labels.
    final double? gradientLabelOffset;
    
    ///The color of the gradient stroke, can be in hex color code or regular color name.
    final String? gradientStrokeColor;
    
    ///The width of the gradient stroke, in pixels.
    final double? gradientStrokeWidth;
    
    ///The width of the gradient, in pixels.
    final double? gradientWidth;
    
    ///The alignment of the legend label, can be left, middle or right.
    final String? labelAlign;
    
    ///The position of the baseline of legend label, can be top, middle or bottom.
    final String? labelBaseline;
    
    ///The color of the legend label, can be in hex color code or regular color name.
    final String? labelColor;
    
    ///The font of the legend label.
    final String? labelFont;
    
    ///The font size of legend label.
    ///
    ///__Default value:__ `10`.
    final double? labelFontSize;
    
    ///Maximum allowed pixel width of axis tick labels.
    final double? labelLimit;
    
    ///The offset of the legend label.
    final double? labelOffset;
    
    ///The offset, in pixels, by which to displace the legend from the edge of the enclosing
    ///group or data rectangle.
    ///
    ///__Default value:__  `0`
    final double? offset;
    
    ///The orientation of the legend, which determines how the legend is positioned within the
    ///scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    ///"none".
    ///
    ///__Default value:__ `"right"`
    final LegendOrient? orient;
    
    ///The padding, in pixels, between the legend and axis.
    final double? padding;
    
    ///Whether month names and weekday names should be abbreviated.
    ///
    ///__Default value:__  `false`
    final bool? shortTimeLabels;
    
    ///Border stroke color for the full legend.
    final String? strokeColor;
    
    ///Border stroke dash pattern for the full legend.
    final List<double>? strokeDash;
    
    ///Border stroke width for the full legend.
    final double? strokeWidth;
    
    ///The color of the legend symbol,
    final String? symbolColor;
    
    ///The size of the legend symbol, in pixels.
    final double? symbolSize;
    
    ///The width of the symbol's stroke.
    final double? symbolStrokeWidth;
    
    ///Default shape type (such as "circle") for legend symbols.
    final String? symbolType;
    
    ///Horizontal text alignment for legend titles.
    final String? titleAlign;
    
    ///Vertical text baseline for legend titles.
    final String? titleBaseline;
    
    ///The color of the legend title, can be in hex color code or regular color name.
    final String? titleColor;
    
    ///The font of the legend title.
    final String? titleFont;
    
    ///The font size of the legend title.
    final double? titleFontSize;
    
    ///The font weight of the legend title.
    final dynamic titleFontWeight;
    
    ///Maximum allowed pixel width of axis titles.
    final double? titleLimit;
    
    ///The padding, in pixels, between title and legend.
    final double? titlePadding;

    LegendConfig({
        this.cornerRadius,
        this.entryPadding,
        this.fillColor,
        this.gradientHeight,
        this.gradientLabelBaseline,
        this.gradientLabelLimit,
        this.gradientLabelOffset,
        this.gradientStrokeColor,
        this.gradientStrokeWidth,
        this.gradientWidth,
        this.labelAlign,
        this.labelBaseline,
        this.labelColor,
        this.labelFont,
        this.labelFontSize,
        this.labelLimit,
        this.labelOffset,
        this.offset,
        this.orient,
        this.padding,
        this.shortTimeLabels,
        this.strokeColor,
        this.strokeDash,
        this.strokeWidth,
        this.symbolColor,
        this.symbolSize,
        this.symbolStrokeWidth,
        this.symbolType,
        this.titleAlign,
        this.titleBaseline,
        this.titleColor,
        this.titleFont,
        this.titleFontSize,
        this.titleFontWeight,
        this.titleLimit,
        this.titlePadding,
    });

    factory LegendConfig.fromJson(Map<String, dynamic> json) => LegendConfig(
        cornerRadius: json["cornerRadius"]?.toDouble(),
        entryPadding: json["entryPadding"]?.toDouble(),
        fillColor: json["fillColor"],
        gradientHeight: json["gradientHeight"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["gradientHeight"]?.toDouble()),
        gradientLabelBaseline: json["gradientLabelBaseline"],
        gradientLabelLimit: json["gradientLabelLimit"]?.toDouble(),
        gradientLabelOffset: json["gradientLabelOffset"]?.toDouble(),
        gradientStrokeColor: json["gradientStrokeColor"],
        gradientStrokeWidth: json["gradientStrokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["gradientStrokeWidth"]?.toDouble()),
        gradientWidth: json["gradientWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["gradientWidth"]?.toDouble()),
        labelAlign: json["labelAlign"],
        labelBaseline: json["labelBaseline"],
        labelColor: json["labelColor"],
        labelFont: json["labelFont"],
        labelFontSize: json["labelFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["labelFontSize"]?.toDouble()),
        labelLimit: json["labelLimit"]?.toDouble(),
        labelOffset: json["labelOffset"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["labelOffset"]?.toDouble()),
        offset: json["offset"]?.toDouble(),
        orient: json["orient"] == null ? null : legendOrientValues.map[json["orient"]]!,
        padding: json["padding"]?.toDouble(),
        shortTimeLabels: json["shortTimeLabels"],
        strokeColor: json["strokeColor"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeWidth: json["strokeWidth"]?.toDouble(),
        symbolColor: json["symbolColor"],
        symbolSize: json["symbolSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["symbolSize"]?.toDouble()),
        symbolStrokeWidth: json["symbolStrokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["symbolStrokeWidth"]?.toDouble()),
        symbolType: json["symbolType"],
        titleAlign: json["titleAlign"],
        titleBaseline: json["titleBaseline"],
        titleColor: json["titleColor"],
        titleFont: json["titleFont"],
        titleFontSize: json["titleFontSize"]?.toDouble(),
        titleFontWeight: json["titleFontWeight"],
        titleLimit: json["titleLimit"]?.toDouble(),
        titlePadding: json["titlePadding"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "cornerRadius": cornerRadius,
        "entryPadding": entryPadding,
        "fillColor": fillColor,
        "gradientHeight": gradientHeight,
        "gradientLabelBaseline": gradientLabelBaseline,
        "gradientLabelLimit": gradientLabelLimit,
        "gradientLabelOffset": gradientLabelOffset,
        "gradientStrokeColor": gradientStrokeColor,
        "gradientStrokeWidth": gradientStrokeWidth,
        "gradientWidth": gradientWidth,
        "labelAlign": labelAlign,
        "labelBaseline": labelBaseline,
        "labelColor": labelColor,
        "labelFont": labelFont,
        "labelFontSize": labelFontSize,
        "labelLimit": labelLimit,
        "labelOffset": labelOffset,
        "offset": offset,
        "orient": legendOrientValues.reverse[orient],
        "padding": padding,
        "shortTimeLabels": shortTimeLabels,
        "strokeColor": strokeColor,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeWidth": strokeWidth,
        "symbolColor": symbolColor,
        "symbolSize": symbolSize,
        "symbolStrokeWidth": symbolStrokeWidth,
        "symbolType": symbolType,
        "titleAlign": titleAlign,
        "titleBaseline": titleBaseline,
        "titleColor": titleColor,
        "titleFont": titleFont,
        "titleFontSize": titleFontSize,
        "titleFontWeight": titleFontWeight,
        "titleLimit": titleLimit,
        "titlePadding": titlePadding,
    };
}


///The orientation of the legend, which determines how the legend is positioned within the
///scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
///"none".
///
///__Default value:__ `"right"`
enum LegendOrient {
    LEFT,
    RIGHT,
    TOP_LEFT,
    TOP_RIGHT,
    BOTTOM_LEFT,
    BOTTOM_RIGHT,
    NONE
}

final legendOrientValues = EnumValues({
    "left": LegendOrient.LEFT,
    "right": LegendOrient.RIGHT,
    "top-left": LegendOrient.TOP_LEFT,
    "top-right": LegendOrient.TOP_RIGHT,
    "bottom-left": LegendOrient.BOTTOM_LEFT,
    "bottom-right": LegendOrient.BOTTOM_RIGHT,
    "none": LegendOrient.NONE
});

class PaddingClass {
    final double? bottom;
    final double? left;
    final double? right;
    final double? top;

    PaddingClass({
        this.bottom,
        this.left,
        this.right,
        this.top,
    });

    factory PaddingClass.fromJson(Map<String, dynamic> json) => PaddingClass(
        bottom: json["bottom"]?.toDouble(),
        left: json["left"]?.toDouble(),
        right: json["right"]?.toDouble(),
        top: json["top"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bottom": bottom,
        "left": left,
        "right": right,
        "top": top,
    };
}


///Projection configuration, which determines default properties for all
///[projections](projection.html). For a full list of projection configuration options,
///please see the [corresponding section of the projection
///documentation](projection.html#config).
///
///Any property of Projection can be in config
class ProjectionConfig {
    
    ///Sets the projection’s center to the specified center, a two-element array of longitude
    ///and latitude in degrees.
    ///
    ///__Default value:__ `[0, 0]`
    final List<double>? center;
    
    ///Sets the projection’s clipping circle radius to the specified angle in degrees. If
    ///`null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    ///than small-circle clipping.
    final double? clipAngle;
    
    ///Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    ///bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    ///the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    ///viewport clipping is performed.
    final List<List<double>>? clipExtent;
    final double? coefficient;
    final double? distance;
    final double? fraction;
    final double? lobes;
    final double? parallel;
    
    ///Sets the threshold for the projection’s [adaptive
    ///resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    ///value corresponds to the [Douglas–Peucker
    ///distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    ///If precision is not specified, returns the projection’s current resampling precision
    ///which defaults to `√0.5 ≅ 0.70710…`.
    final Map<String, dynamic>? precision;
    final double? radius;
    final double? ratio;
    
    ///Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    ///or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    ///angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    ///__Default value:__ `[0, 0, 0]`
    final List<double>? rotate;
    final double? spacing;
    final double? tilt;
    
    ///The cartographic projection to use. This value is case-insensitive, for example
    ///`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    ///projection types [in the
    ///documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    ///__Default value:__ `mercator`
    final VgProjectionType? type;

    ProjectionConfig({
        this.center,
        this.clipAngle,
        this.clipExtent,
        this.coefficient,
        this.distance,
        this.fraction,
        this.lobes,
        this.parallel,
        this.precision,
        this.radius,
        this.ratio,
        this.rotate,
        this.spacing,
        this.tilt,
        this.type,
    });

    factory ProjectionConfig.fromJson(Map<String, dynamic> json) => ProjectionConfig(
        center: json["center"] == null ? null : List<double>.from(json["center"]!.map((x) => x?.toDouble())),
        clipAngle: json["clipAngle"]?.toDouble(),
        clipExtent: json["clipExtent"] == null ? null : List<List<double>>.from(json["clipExtent"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        coefficient: json["coefficient"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        fraction: json["fraction"]?.toDouble(),
        lobes: json["lobes"]?.toDouble(),
        parallel: json["parallel"]?.toDouble(),
        precision: json["precision"] == null ? null : Map.from(json["precision"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        radius: json["radius"]?.toDouble(),
        ratio: json["ratio"]?.toDouble(),
        rotate: json["rotate"] == null ? null : List<double>.from(json["rotate"]!.map((x) => x?.toDouble())),
        spacing: json["spacing"]?.toDouble(),
        tilt: json["tilt"]?.toDouble(),
        type: json["type"] == null ? null : vgProjectionTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "center": center == null ? null : List<dynamic>.from(center!.map((x) => x)),
        "clipAngle": clipAngle,
        "clipExtent": clipExtent == null ? null : List<dynamic>.from(clipExtent!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "coefficient": coefficient,
        "distance": distance,
        "fraction": fraction,
        "lobes": lobes,
        "parallel": parallel,
        "precision": precision == null ? null : Map.from(precision!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "radius": radius,
        "ratio": ratio,
        "rotate": rotate == null ? null : List<dynamic>.from(rotate!.map((x) => x)),
        "spacing": spacing,
        "tilt": tilt,
        "type": vgProjectionTypeValues.reverse[type],
    };
}


///The cartographic projection to use. This value is case-insensitive, for example
///`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
///projection types [in the
///documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
///__Default value:__ `mercator`
enum VgProjectionType {
    ALBERS,
    ALBERS_USA,
    AZIMUTHAL_EQUAL_AREA,
    AZIMUTHAL_EQUIDISTANT,
    CONIC_CONFORMAL,
    CONIC_EQUAL_AREA,
    CONIC_EQUIDISTANT,
    EQUIRECTANGULAR,
    GNOMONIC,
    MERCATOR,
    ORTHOGRAPHIC,
    STEREOGRAPHIC,
    TRANSVERSE_MERCATOR
}

final vgProjectionTypeValues = EnumValues({
    "albers": VgProjectionType.ALBERS,
    "albersUsa": VgProjectionType.ALBERS_USA,
    "azimuthalEqualArea": VgProjectionType.AZIMUTHAL_EQUAL_AREA,
    "azimuthalEquidistant": VgProjectionType.AZIMUTHAL_EQUIDISTANT,
    "conicConformal": VgProjectionType.CONIC_CONFORMAL,
    "conicEqualArea": VgProjectionType.CONIC_EQUAL_AREA,
    "conicEquidistant": VgProjectionType.CONIC_EQUIDISTANT,
    "equirectangular": VgProjectionType.EQUIRECTANGULAR,
    "gnomonic": VgProjectionType.GNOMONIC,
    "mercator": VgProjectionType.MERCATOR,
    "orthographic": VgProjectionType.ORTHOGRAPHIC,
    "stereographic": VgProjectionType.STEREOGRAPHIC,
    "transverseMercator": VgProjectionType.TRANSVERSE_MERCATOR
});

class VgScheme {
    final double? count;
    final List<double>? extent;
    final String? scheme;
    final double? step;

    VgScheme({
        this.count,
        this.extent,
        this.scheme,
        this.step,
    });

    factory VgScheme.fromJson(Map<String, dynamic> json) => VgScheme(
        count: json["count"]?.toDouble(),
        extent: json["extent"] == null ? null : List<double>.from(json["extent"]!.map((x) => x?.toDouble())),
        scheme: json["scheme"],
        step: json["step"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "extent": extent == null ? null : List<dynamic>.from(extent!.map((x) => x)),
        "scheme": scheme,
        "step": step,
    };
}


///Scale configuration determines default properties for all [scales](scale.html). For a
///full list of scale configuration options, please see the [corresponding section of the
///scale documentation](scale.html#config).
class ScaleConfig {
    
    ///Default inner padding for `x` and `y` band-ordinal scales.
    ///
    ///__Default value:__ `0.1`
    final double? bandPaddingInner;
    
    ///Default outer padding for `x` and `y` band-ordinal scales.
    ///If not specified, by default, band scale's paddingOuter is paddingInner/2.
    final double? bandPaddingOuter;
    
    ///If true, values that exceed the data domain are clamped to either the minimum or maximum
    ///range value
    final bool? clamp;
    
    ///Default padding for continuous scales.
    ///
    ///__Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
    ///horizontal bar.; `0` otherwise.
    final double? continuousPadding;
    
    ///The default max value for mapping quantitative fields to bar's size/bandSize.
    ///
    ///If undefined (default), we will use the scale's `rangeStep` - 1.
    final double? maxBandSize;
    
    ///The default max value for mapping quantitative fields to text's size/fontSize.
    ///
    ///__Default value:__ `40`
    final double? maxFontSize;
    
    ///Default max opacity for mapping a field to opacity.
    ///
    ///__Default value:__ `0.8`
    final double? maxOpacity;
    
    ///Default max value for point size scale.
    final double? maxSize;
    
    ///Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
    ///
    ///__Default value:__ `4`
    final double? maxStrokeWidth;
    
    ///The default min value for mapping quantitative fields to bar and tick's size/bandSize
    ///scale with zero=false.
    ///
    ///__Default value:__ `2`
    final double? minBandSize;
    
    ///The default min value for mapping quantitative fields to tick's size/fontSize scale with
    ///zero=false
    ///
    ///__Default value:__ `8`
    final double? minFontSize;
    
    ///Default minimum opacity for mapping a field to opacity.
    ///
    ///__Default value:__ `0.3`
    final double? minOpacity;
    
    ///Default minimum value for point size scale with zero=false.
    ///
    ///__Default value:__ `9`
    final double? minSize;
    
    ///Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
    ///
    ///__Default value:__ `1`
    final double? minStrokeWidth;
    
    ///Default outer padding for `x` and `y` point-ordinal scales.
    ///
    ///__Default value:__ `0.5`
    final double? pointPadding;
    
    ///Default range step for band and point scales of (1) the `y` channel
    ///and (2) the `x` channel when the mark is not `text`.
    ///
    ///__Default value:__ `21`
    final double? rangeStep;
    
    ///If true, rounds numeric output values to integers.
    ///This can be helpful for snapping to the pixel grid.
    ///(Only available for `x`, `y`, and `size` scales.)
    final bool? round;
    
    ///Default range step for `x` band and point scales of text marks.
    ///
    ///__Default value:__ `90`
    final double? textXRangeStep;
    
    ///Use the source data range before aggregation as scale domain instead of aggregated data
    ///for aggregate axis.
    ///
    ///This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
    ///fields by default.
    ///
    ///This property only works with aggregate functions that produce values within the raw data
    ///domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
    ///aggregations that produce values outside of the raw data domain (e.g. `"count"`,
    ///`"sum"`), this property is ignored.
    ///
    ///__Default value:__ `false`
    final bool? useUnaggregatedDomain;

    ScaleConfig({
        this.bandPaddingInner,
        this.bandPaddingOuter,
        this.clamp,
        this.continuousPadding,
        this.maxBandSize,
        this.maxFontSize,
        this.maxOpacity,
        this.maxSize,
        this.maxStrokeWidth,
        this.minBandSize,
        this.minFontSize,
        this.minOpacity,
        this.minSize,
        this.minStrokeWidth,
        this.pointPadding,
        this.rangeStep,
        this.round,
        this.textXRangeStep,
        this.useUnaggregatedDomain,
    });

    factory ScaleConfig.fromJson(Map<String, dynamic> json) => ScaleConfig(
        bandPaddingInner: json["bandPaddingInner"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["bandPaddingInner"]?.toDouble()),
        bandPaddingOuter: json["bandPaddingOuter"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["bandPaddingOuter"]?.toDouble()),
        clamp: json["clamp"],
        continuousPadding: json["continuousPadding"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["continuousPadding"]?.toDouble()),
        maxBandSize: json["maxBandSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["maxBandSize"]?.toDouble()),
        maxFontSize: json["maxFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["maxFontSize"]?.toDouble()),
        maxOpacity: json["maxOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["maxOpacity"]?.toDouble()),
        maxSize: json["maxSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["maxSize"]?.toDouble()),
        maxStrokeWidth: json["maxStrokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["maxStrokeWidth"]?.toDouble()),
        minBandSize: json["minBandSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["minBandSize"]?.toDouble()),
        minFontSize: json["minFontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["minFontSize"]?.toDouble()),
        minOpacity: json["minOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["minOpacity"]?.toDouble()),
        minSize: json["minSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["minSize"]?.toDouble()),
        minStrokeWidth: json["minStrokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["minStrokeWidth"]?.toDouble()),
        pointPadding: json["pointPadding"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["pointPadding"]?.toDouble()),
        rangeStep: json["rangeStep"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["rangeStep"]?.toDouble()),
        round: json["round"],
        textXRangeStep: json["textXRangeStep"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["textXRangeStep"]?.toDouble()),
        useUnaggregatedDomain: json["useUnaggregatedDomain"],
    );

    Map<String, dynamic> toJson() => {
        "bandPaddingInner": bandPaddingInner,
        "bandPaddingOuter": bandPaddingOuter,
        "clamp": clamp,
        "continuousPadding": continuousPadding,
        "maxBandSize": maxBandSize,
        "maxFontSize": maxFontSize,
        "maxOpacity": maxOpacity,
        "maxSize": maxSize,
        "maxStrokeWidth": maxStrokeWidth,
        "minBandSize": minBandSize,
        "minFontSize": minFontSize,
        "minOpacity": minOpacity,
        "minSize": minSize,
        "minStrokeWidth": minStrokeWidth,
        "pointPadding": pointPadding,
        "rangeStep": rangeStep,
        "round": round,
        "textXRangeStep": textXRangeStep,
        "useUnaggregatedDomain": useUnaggregatedDomain,
    };
}


///An object hash for defining default properties for each type of selections.
class SelectionConfig {
    
    ///The default definition for an [`interval`](selection.html#type) selection. All properties
    ///and transformations
    ///for an interval selection definition (except `type`) may be specified here.
    ///
    ///For instance, setting `interval` to `{"translate": false}` disables the ability to move
    ///interval selections by default.
    final IntervalSelectionConfig? interval;
    
    ///The default definition for a [`multi`](selection.html#type) selection. All properties and
    ///transformations
    ///for a multi selection definition (except `type`) may be specified here.
    ///
    ///For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
    ///multi selections when clicking with the alt-key pressed by default.
    final MultiSelectionConfig? multi;
    
    ///The default definition for a [`single`](selection.html#type) selection. All properties
    ///and transformations
    ///for a single selection definition (except `type`) may be specified here.
    ///
    ///For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
    ///double-click by default.
    final SingleSelectionConfig? single;

    SelectionConfig({
        this.interval,
        this.multi,
        this.single,
    });

    factory SelectionConfig.fromJson(Map<String, dynamic> json) => SelectionConfig(
        interval: json["interval"] == null ? null : IntervalSelectionConfig.fromJson(json["interval"]),
        multi: json["multi"] == null ? null : MultiSelectionConfig.fromJson(json["multi"]),
        single: json["single"] == null ? null : SingleSelectionConfig.fromJson(json["single"]),
    );

    Map<String, dynamic> toJson() => {
        "interval": interval?.toJson(),
        "multi": multi?.toJson(),
        "single": single?.toJson(),
    };
}


///The default definition for an [`interval`](selection.html#type) selection. All properties
///and transformations
///for an interval selection definition (except `type`) may be specified here.
///
///For instance, setting `interval` to `{"translate": false}` disables the ability to move
///interval selections by default.
class IntervalSelectionConfig {
    
    ///Establishes a two-way binding between the interval selection and the scales
    ///used within the same view. This allows a user to interactively pan and
    ///zoom the view.
    final BindEnum? bind;
    
    ///By default, all data values are considered to lie within an empty selection.
    ///When set to `none`, empty selections contain no data values.
    final Empty? empty;
    
    ///An array of encoding channels. The corresponding data field values
    ///must match for a data tuple to fall within the selection.
    final List<SingleDefChannel>? encodings;
    
    ///An array of field names whose values must match for a data tuple to
    ///fall within the selection.
    final List<String>? fields;
    
    ///An interval selection also adds a rectangle mark to depict the
    ///extents of the interval. The `mark` property can be used to customize the
    ///appearance of the mark.
    final BrushConfig? mark;
    
    ///A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    ///selector) that triggers the selection.
    ///For interval selections, the event stream must specify a [start and
    ///end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    final dynamic on;
    
    ///With layered and multi-view displays, a strategy that determines how
    ///selections' data queries are resolved when applied in a filter transform,
    ///conditional encoding rule, or scale domain.
    final SelectionResolution? resolve;
    
    ///When truthy, allows a user to interactively move an interval selection
    ///back-and-forth. Can be `true`, `false` (to disable panning), or a
    ///[Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    ///which must include a start and end event to trigger continuous panning.
    ///
    ///__Default value:__ `true`, which corresponds to
    ///`[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    ///clicks and dragging within an interval selection to reposition it.
    final dynamic translate;
    
    ///When truthy, allows a user to interactively resize an interval selection.
    ///Can be `true`, `false` (to disable zooming), or a [Vega event stream
    ///definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    ///only `wheel` events are supported.
    ///
    ///
    ///__Default value:__ `true`, which corresponds to `wheel!`.
    final dynamic zoom;

    IntervalSelectionConfig({
        this.bind,
        this.empty,
        this.encodings,
        this.fields,
        this.mark,
        this.on,
        this.resolve,
        this.translate,
        this.zoom,
    });

    factory IntervalSelectionConfig.fromJson(Map<String, dynamic> json) => IntervalSelectionConfig(
        bind: json["bind"] == null ? null : bindEnumValues.map[json["bind"]]!,
        empty: json["empty"] == null ? null : emptyValues.map[json["empty"]]!,
        encodings: json["encodings"] == null ? null : List<SingleDefChannel>.from(json["encodings"]!.map((x) => singleDefChannelValues.map[x]!)),
        fields: json["fields"] == null ? null : List<String>.from(json["fields"]!.map((x) => x)),
        mark: json["mark"] == null ? null : BrushConfig.fromJson(json["mark"]),
        on: json["on"],
        resolve: json["resolve"] == null ? null : selectionResolutionValues.map[json["resolve"]]!,
        translate: json["translate"],
        zoom: json["zoom"],
    );

    Map<String, dynamic> toJson() => {
        "bind": bindEnumValues.reverse[bind],
        "empty": emptyValues.reverse[empty],
        "encodings": encodings == null ? null : List<dynamic>.from(encodings!.map((x) => singleDefChannelValues.reverse[x])),
        "fields": fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "mark": mark?.toJson(),
        "on": on,
        "resolve": selectionResolutionValues.reverse[resolve],
        "translate": translate,
        "zoom": zoom,
    };
}


///Establishes a two-way binding between the interval selection and the scales
///used within the same view. This allows a user to interactively pan and
///zoom the view.
enum BindEnum {
    SCALES
}

final bindEnumValues = EnumValues({
    "scales": BindEnum.SCALES
});


///By default, all data values are considered to lie within an empty selection.
///When set to `none`, empty selections contain no data values.
enum Empty {
    ALL,
    NONE
}

final emptyValues = EnumValues({
    "all": Empty.ALL,
    "none": Empty.NONE
});

enum SingleDefChannel {
    X,
    Y,
    X2,
    Y2,
    ROW,
    COLUMN,
    SIZE,
    SHAPE,
    COLOR,
    OPACITY,
    TEXT,
    TOOLTIP,
    HREF
}

final singleDefChannelValues = EnumValues({
    "x": SingleDefChannel.X,
    "y": SingleDefChannel.Y,
    "x2": SingleDefChannel.X2,
    "y2": SingleDefChannel.Y2,
    "row": SingleDefChannel.ROW,
    "column": SingleDefChannel.COLUMN,
    "size": SingleDefChannel.SIZE,
    "shape": SingleDefChannel.SHAPE,
    "color": SingleDefChannel.COLOR,
    "opacity": SingleDefChannel.OPACITY,
    "text": SingleDefChannel.TEXT,
    "tooltip": SingleDefChannel.TOOLTIP,
    "href": SingleDefChannel.HREF
});


///An interval selection also adds a rectangle mark to depict the
///extents of the interval. The `mark` property can be used to customize the
///appearance of the mark.
class BrushConfig {
    
    ///The fill color of the interval mark.
    ///
    ///__Default value:__ `#333333`
    final String? fill;
    
    ///The fill opacity of the interval mark (a value between 0 and 1).
    ///
    ///__Default value:__ `0.125`
    final double? fillOpacity;
    
    ///The stroke color of the interval mark.
    ///
    ///__Default value:__ `#ffffff`
    final String? stroke;
    
    ///An array of alternating stroke and space lengths,
    ///for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) with which to begin drawing the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity of the interval mark (a value between 0 and 1).
    final double? strokeOpacity;
    
    ///The stroke width of the interval mark.
    final double? strokeWidth;

    BrushConfig({
        this.fill,
        this.fillOpacity,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
    });

    factory BrushConfig.fromJson(Map<String, dynamic> json) => BrushConfig(
        fill: json["fill"],
        fillOpacity: json["fillOpacity"]?.toDouble(),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble(),
        strokeWidth: json["strokeWidth"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "fill": fill,
        "fillOpacity": fillOpacity,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
    };
}


///With layered and multi-view displays, a strategy that determines how
///selections' data queries are resolved when applied in a filter transform,
///conditional encoding rule, or scale domain.
enum SelectionResolution {
    GLOBAL,
    UNION,
    INTERSECT
}

final selectionResolutionValues = EnumValues({
    "global": SelectionResolution.GLOBAL,
    "union": SelectionResolution.UNION,
    "intersect": SelectionResolution.INTERSECT
});


///The default definition for a [`multi`](selection.html#type) selection. All properties and
///transformations
///for a multi selection definition (except `type`) may be specified here.
///
///For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
///multi selections when clicking with the alt-key pressed by default.
class MultiSelectionConfig {
    
    ///By default, all data values are considered to lie within an empty selection.
    ///When set to `none`, empty selections contain no data values.
    final Empty? empty;
    
    ///An array of encoding channels. The corresponding data field values
    ///must match for a data tuple to fall within the selection.
    final List<SingleDefChannel>? encodings;
    
    ///An array of field names whose values must match for a data tuple to
    ///fall within the selection.
    final List<String>? fields;
    
    ///When true, an invisible voronoi diagram is computed to accelerate discrete
    ///selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    ///See the [nearest transform](nearest.html) documentation for more information.
    final bool? nearest;
    
    ///A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    ///selector) that triggers the selection.
    ///For interval selections, the event stream must specify a [start and
    ///end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    final dynamic on;
    
    ///With layered and multi-view displays, a strategy that determines how
    ///selections' data queries are resolved when applied in a filter transform,
    ///conditional encoding rule, or scale domain.
    final SelectionResolution? resolve;
    
    ///Controls whether data values should be toggled or only ever inserted into
    ///multi selections. Can be `true`, `false` (for insertion only), or a
    ///[Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    ///__Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    ///data values are toggled when a user interacts with the shift-key pressed).
    ///
    ///See the [toggle transform](toggle.html) documentation for more information.
    final dynamic toggle;

    MultiSelectionConfig({
        this.empty,
        this.encodings,
        this.fields,
        this.nearest,
        this.on,
        this.resolve,
        this.toggle,
    });

    factory MultiSelectionConfig.fromJson(Map<String, dynamic> json) => MultiSelectionConfig(
        empty: json["empty"] == null ? null : emptyValues.map[json["empty"]]!,
        encodings: json["encodings"] == null ? null : List<SingleDefChannel>.from(json["encodings"]!.map((x) => singleDefChannelValues.map[x]!)),
        fields: json["fields"] == null ? null : List<String>.from(json["fields"]!.map((x) => x)),
        nearest: json["nearest"],
        on: json["on"],
        resolve: json["resolve"] == null ? null : selectionResolutionValues.map[json["resolve"]]!,
        toggle: json["toggle"],
    );

    Map<String, dynamic> toJson() => {
        "empty": emptyValues.reverse[empty],
        "encodings": encodings == null ? null : List<dynamic>.from(encodings!.map((x) => singleDefChannelValues.reverse[x])),
        "fields": fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "nearest": nearest,
        "on": on,
        "resolve": selectionResolutionValues.reverse[resolve],
        "toggle": toggle,
    };
}


///The default definition for a [`single`](selection.html#type) selection. All properties
///and transformations
///for a single selection definition (except `type`) may be specified here.
///
///For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
///double-click by default.
class SingleSelectionConfig {
    
    ///Establish a two-way binding between a single selection and input elements
    ///(also known as dynamic query widgets). A binding takes the form of
    ///Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    ///or can be a mapping between projected field/encodings and binding definitions.
    ///
    ///See the [bind transform](bind.html) documentation for more information.
    final Map<String, VgBinding>? bind;
    
    ///By default, all data values are considered to lie within an empty selection.
    ///When set to `none`, empty selections contain no data values.
    final Empty? empty;
    
    ///An array of encoding channels. The corresponding data field values
    ///must match for a data tuple to fall within the selection.
    final List<SingleDefChannel>? encodings;
    
    ///An array of field names whose values must match for a data tuple to
    ///fall within the selection.
    final List<String>? fields;
    
    ///When true, an invisible voronoi diagram is computed to accelerate discrete
    ///selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    ///See the [nearest transform](nearest.html) documentation for more information.
    final bool? nearest;
    
    ///A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    ///selector) that triggers the selection.
    ///For interval selections, the event stream must specify a [start and
    ///end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    final dynamic on;
    
    ///With layered and multi-view displays, a strategy that determines how
    ///selections' data queries are resolved when applied in a filter transform,
    ///conditional encoding rule, or scale domain.
    final SelectionResolution? resolve;

    SingleSelectionConfig({
        this.bind,
        this.empty,
        this.encodings,
        this.fields,
        this.nearest,
        this.on,
        this.resolve,
    });

    factory SingleSelectionConfig.fromJson(Map<String, dynamic> json) => SingleSelectionConfig(
        bind: json["bind"] == null ? null : Map.from(json["bind"]!).map((k, v) => MapEntry<String, VgBinding>(k, VgBinding.fromJson(v))),
        empty: json["empty"] == null ? null : emptyValues.map[json["empty"]]!,
        encodings: json["encodings"] == null ? null : List<SingleDefChannel>.from(json["encodings"]!.map((x) => singleDefChannelValues.map[x]!)),
        fields: json["fields"] == null ? null : List<String>.from(json["fields"]!.map((x) => x)),
        nearest: json["nearest"],
        on: json["on"],
        resolve: json["resolve"] == null ? null : selectionResolutionValues.map[json["resolve"]]!,
    );

    Map<String, dynamic> toJson() => {
        "bind": bind == null ? null : Map.from(bind!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "empty": emptyValues.reverse[empty],
        "encodings": encodings == null ? null : List<dynamic>.from(encodings!.map((x) => singleDefChannelValues.reverse[x])),
        "fields": fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "nearest": nearest,
        "on": on,
        "resolve": selectionResolutionValues.reverse[resolve],
    };
}

class VgBinding {
    final String? element;
    final String input;
    final List<String>? options;
    final double? max;
    final double? min;
    final double? step;

    VgBinding({
        this.element,
        required this.input,
        this.options,
        this.max,
        this.min,
        this.step,
    });

    factory VgBinding.fromJson(Map<String, dynamic> json) => VgBinding(
        element: json["element"],
        input: json["input"],
        options: json["options"] == null ? null : List<String>.from(json["options"]!.map((x) => x)),
        max: json["max"]?.toDouble(),
        min: json["min"]?.toDouble(),
        step: json["step"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "element": element,
        "input": input,
        "options": options == null ? null : List<dynamic>.from(options!.map((x) => x)),
        "max": max,
        "min": min,
        "step": step,
    };
}


///Default stack offset for stackable mark.
enum StackOffset {
    ZERO,
    CENTER,
    NORMALIZE
}

final stackOffsetValues = EnumValues({
    "zero": StackOffset.ZERO,
    "center": StackOffset.CENTER,
    "normalize": StackOffset.NORMALIZE
});

class VgMarkConfig {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;

    VgMarkConfig({
        this.align,
        this.angle,
        this.baseline,
        this.cursor,
        this.dx,
        this.dy,
        this.fill,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.tension,
        this.text,
        this.theta,
    });

    factory VgMarkConfig.fromJson(Map<String, dynamic> json) => VgMarkConfig(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "cursor": cursorValues.reverse[cursor],
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "tension": tension,
        "text": text,
        "theta": theta,
    };
}


///Text-Specific Config
class TextConfig {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    ///will override `color`.
    ///
    ///__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final String? color;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///Whether the mark's color should be used as fill color instead of stroke color.
    ///
    ///__Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    ///__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final bool? filled;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///Whether month names and weekday names should be abbreviated.
    final bool? shortTimeLabels;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;

    TextConfig({
        this.align,
        this.angle,
        this.baseline,
        this.color,
        this.cursor,
        this.dx,
        this.dy,
        this.fill,
        this.filled,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.shortTimeLabels,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.tension,
        this.text,
        this.theta,
    });

    factory TextConfig.fromJson(Map<String, dynamic> json) => TextConfig(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        color: json["color"],
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        filled: json["filled"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        shortTimeLabels: json["shortTimeLabels"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "color": color,
        "cursor": cursorValues.reverse[cursor],
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "filled": filled,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "shortTimeLabels": shortTimeLabels,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "tension": tension,
        "text": text,
        "theta": theta,
    };
}


///Tick-Specific Config
class TickConfig {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The width of the ticks.
    ///
    ///__Default value:__  2/3 of rangeStep.
    final double? bandSize;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    ///will override `color`.
    ///
    ///__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final String? color;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///Whether the mark's color should be used as fill color instead of stroke color.
    ///
    ///__Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    ///__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final bool? filled;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;
    
    ///Thickness of the tick mark.
    ///
    ///__Default value:__  `1`
    final double? thickness;

    TickConfig({
        this.align,
        this.angle,
        this.bandSize,
        this.baseline,
        this.color,
        this.cursor,
        this.dx,
        this.dy,
        this.fill,
        this.filled,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.tension,
        this.text,
        this.theta,
        this.thickness,
    });

    factory TickConfig.fromJson(Map<String, dynamic> json) => TickConfig(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        bandSize: json["bandSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["bandSize"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        color: json["color"],
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        filled: json["filled"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
        thickness: json["thickness"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["thickness"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "bandSize": bandSize,
        "baseline": verticalAlignValues.reverse[baseline],
        "color": color,
        "cursor": cursorValues.reverse[cursor],
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "filled": filled,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "tension": tension,
        "text": text,
        "theta": theta,
        "thickness": thickness,
    };
}


///Title configuration, which determines default properties for all [titles](title.html).
///For a full list of title configuration options, please see the [corresponding section of
///the title documentation](title.html#config).
class VgTitleConfig {
    
    ///The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    ///example, with an orientation of top these anchor positions map to a left-, center-, or
    ///right-aligned title.
    ///
    ///__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    ///`"start"` for other composite views.
    ///
    ///__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    ///customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    ///composite views, `anchor` is always `"start"`.
    final Anchor? anchor;
    
    ///Angle in degrees of title text.
    final double? angle;
    
    ///Vertical text baseline for title text.
    final VerticalAlign? baseline;
    
    ///Text color for title text.
    final String? color;
    
    ///Font name for title text.
    final String? font;
    
    ///Font size in pixels for title text.
    ///
    ///__Default value:__ `10`.
    final double? fontSize;
    
    ///Font weight for title text.
    final dynamic fontWeight;
    
    ///The maximum allowed length in pixels of legend labels.
    final double? limit;
    
    ///Offset in pixels of the title from the chart body and axes.
    final double? offset;
    
    ///Default title orientation ("top", "bottom", "left", or "right")
    final TitleOrient? orient;

    VgTitleConfig({
        this.anchor,
        this.angle,
        this.baseline,
        this.color,
        this.font,
        this.fontSize,
        this.fontWeight,
        this.limit,
        this.offset,
        this.orient,
    });

    factory VgTitleConfig.fromJson(Map<String, dynamic> json) => VgTitleConfig(
        anchor: json["anchor"] == null ? null : anchorValues.map[json["anchor"]]!,
        angle: json["angle"]?.toDouble(),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        color: json["color"],
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontWeight: json["fontWeight"],
        limit: json["limit"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["limit"]?.toDouble()),
        offset: json["offset"]?.toDouble(),
        orient: json["orient"] == null ? null : titleOrientValues.map[json["orient"]]!,
    );

    Map<String, dynamic> toJson() => {
        "anchor": anchorValues.reverse[anchor],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "color": color,
        "font": font,
        "fontSize": fontSize,
        "fontWeight": fontWeight,
        "limit": limit,
        "offset": offset,
        "orient": titleOrientValues.reverse[orient],
    };
}


///The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
///example, with an orientation of top these anchor positions map to a left-, center-, or
///right-aligned title.
///
///__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
///`"start"` for other composite views.
///
///__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
///customizable only for [single](spec.html) and [layered](layer.html) views.  For other
///composite views, `anchor` is always `"start"`.
enum Anchor {
    START,
    MIDDLE,
    END
}

final anchorValues = EnumValues({
    "start": Anchor.START,
    "middle": Anchor.MIDDLE,
    "end": Anchor.END
});


///Default title orientation ("top", "bottom", "left", or "right")
///
///The orientation of the title relative to the chart. One of `"top"` (the default),
///`"bottom"`, `"left"`, or `"right"`.
///
///The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
///orientation can be used to further specialize the axis type (e.g., a y axis oriented for
///the right edge of the chart).
///
///__Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
enum TitleOrient {
    TOP,
    BOTTOM,
    LEFT,
    RIGHT
}

final titleOrientValues = EnumValues({
    "top": TitleOrient.TOP,
    "bottom": TitleOrient.BOTTOM,
    "left": TitleOrient.LEFT,
    "right": TitleOrient.RIGHT
});


///Default properties for [single view plots](spec.html#single).
class ViewConfig {
    
    ///Whether the view should be clipped.
    final bool? clip;
    
    ///The fill color.
    ///
    ///__Default value:__ (none)
    final String? fill;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ (none)
    final double? fillOpacity;
    
    ///The default height of the single plot or each plot in a trellis plot when the
    ///visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
    ///
    ///__Default value:__ `200`
    final double? height;
    
    ///The stroke color.
    ///
    ///__Default value:__ (none)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    ///
    ///__Default value:__ (none)
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    ///
    ///__Default value:__ (none)
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ (none)
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    ///
    ///__Default value:__ (none)
    final double? strokeWidth;
    
    ///The default width of the single plot or each plot in a trellis plot when the
    ///visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
    ///= `null`.
    ///
    ///__Default value:__ `200`
    final double? width;

    ViewConfig({
        this.clip,
        this.fill,
        this.fillOpacity,
        this.height,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.width,
    });

    factory ViewConfig.fromJson(Map<String, dynamic> json) => ViewConfig(
        clip: json["clip"],
        fill: json["fill"],
        fillOpacity: json["fillOpacity"]?.toDouble(),
        height: json["height"]?.toDouble(),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble(),
        strokeWidth: json["strokeWidth"]?.toDouble(),
        width: json["width"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "clip": clip,
        "fill": fill,
        "fillOpacity": fillOpacity,
        "height": height,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "width": width,
    };
}


///An object describing the data source
///
///Secondary data source to lookup in.
class Data {
    
    ///An object that specifies the format for parsing the data file.
    ///
    ///An object that specifies the format for parsing the data values.
    ///
    ///An object that specifies the format for parsing the data.
    final DataFormat? format;
    
    ///An URL from which to load the data set. Use the `format.type` property
    ///to ensure the loaded data is correctly parsed.
    final String? url;
    
    ///The full data set, included inline. This can be an array of objects or primitive values
    ///or a string.
    ///Arrays of primitive values are ingested as objects with a `data` property. Strings are
    ///parsed according to the specified format type.
    final dynamic values;
    
    ///Provide a placeholder name and bind data at runtime.
    final String? name;

    Data({
        this.format,
        this.url,
        this.values,
        this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        format: json["format"] == null ? null : DataFormat.fromJson(json["format"]),
        url: json["url"],
        values: json["values"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "format": format?.toJson(),
        "url": url,
        "values": values,
        "name": name,
    };
}


///An object that specifies the format for parsing the data file.
///
///An object that specifies the format for parsing the data values.
///
///An object that specifies the format for parsing the data.
class DataFormat {
    
    ///If set to auto (the default), perform automatic type inference to determine the desired
    ///data types.
    ///Alternatively, a parsing directive object can be provided for explicit data types. Each
    ///property of the object corresponds to a field name, and the value to the desired data
    ///type (one of `"number"`, `"boolean"` or `"date"`).
    ///For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
    ///input record a Date value.
    ///
    ///For `"date"`, we parse data based using Javascript's
    ///[`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
    ///For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
    ///[d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
    ///format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
    ///[UTC time](timeunit.html#utc)
    final dynamic parse;
    
    ///Type of input data: `"json"`, `"csv"`, `"tsv"`.
    ///The default format type is determined by the extension of the file URL.
    ///If no extension is detected, `"json"` will be used by default.
    final DataFormatType? type;
    
    ///The JSON property containing the desired data.
    ///This parameter can be used when the loaded JSON file may have surrounding structure or
    ///meta-data.
    ///For example `"property": "values.features"` is equivalent to retrieving
    ///`json.values.features`
    ///from the loaded JSON object.
    final String? property;
    
    ///The name of the TopoJSON object set to convert to a GeoJSON feature collection.
    ///For example, in a map of the world, there may be an object set named `"countries"`.
    ///Using the feature property, we can extract this set and generate a GeoJSON feature object
    ///for each country.
    final String? feature;
    
    ///The name of the TopoJSON object set to convert to mesh.
    ///Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
    ///Unlike the `feature` option, the corresponding geo data is returned as a single, unified
    ///mesh instance, not as individual GeoJSON features.
    ///Extracting a mesh is useful for more efficiently drawing borders or other geographic
    ///elements that you do not need to associate with specific regions such as individual
    ///countries, states or counties.
    final String? mesh;

    DataFormat({
        this.parse,
        this.type,
        this.property,
        this.feature,
        this.mesh,
    });

    factory DataFormat.fromJson(Map<String, dynamic> json) => DataFormat(
        parse: json["parse"],
        type: json["type"] == null ? null : dataFormatTypeValues.map[json["type"]]!,
        property: json["property"],
        feature: json["feature"],
        mesh: json["mesh"],
    );

    Map<String, dynamic> toJson() => {
        "parse": parse,
        "type": dataFormatTypeValues.reverse[type],
        "property": property,
        "feature": feature,
        "mesh": mesh,
    };
}

enum ParseEnum {
    AUTO
}

final parseEnumValues = EnumValues({
    "auto": ParseEnum.AUTO
});


///Type of input data: `"json"`, `"csv"`, `"tsv"`.
///The default format type is determined by the extension of the file URL.
///If no extension is detected, `"json"` will be used by default.
enum DataFormatType {
    CSV,
    TSV,
    JSON,
    TOPOJSON
}

final dataFormatTypeValues = EnumValues({
    "csv": DataFormatType.CSV,
    "tsv": DataFormatType.TSV,
    "json": DataFormatType.JSON,
    "topojson": DataFormatType.TOPOJSON
});


///A key-value mapping between encoding channels and definition of fields.
class EncodingWithFacet {
    
    ///Color of the marks – either fill or stroke color based on mark type.
    ///By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    ///`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    ///__Default value:__ If undefined, the default color depends on [mark
    ///config](config.html#mark)'s `color` property.
    ///
    ///_Note:_ See the scale documentation for more information about customizing [color
    ///scheme](scale.html#scheme).
    final MarkPropDefWithCondition? color;
    
    ///Horizontal facets for trellis plots.
    final FacetFieldDef? column;
    
    ///Additional levels of detail for grouping data in aggregate views and
    ///in line and area marks without mapping data to a specific visual channel.
    final dynamic detail;
    
    ///A URL to load upon mouse click.
    final DefWithCondition? href;
    
    ///Opacity of the marks – either can be a value or a range.
    ///
    ///__Default value:__ If undefined, the default opacity depends on [mark
    ///config](config.html#mark)'s `opacity` property.
    final MarkPropDefWithCondition? opacity;
    
    ///Stack order for stacked marks or order of data points in line marks for connected scatter
    ///plots.
    ///
    ///__Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    ///additional aggregation grouping.
    final dynamic order;
    
    ///Vertical facets for trellis plots.
    final FacetFieldDef? row;
    
    ///For `point` marks the supported values are
    ///`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    ///or `"triangle-down"`, or else a custom SVG path string.
    ///For `geoshape` marks it should be a field definition of the geojson data
    ///
    ///__Default value:__ If undefined, the default shape depends on [mark
    ///config](config.html#point-config)'s `shape` property.
    final MarkPropDefWithCondition? shape;
    
    ///Size of the mark.
    ///- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    ///- For `"bar"` and `"tick"` – the bar and tick's size.
    ///- For `"text"` – the text's font size.
    ///- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    final MarkPropDefWithCondition? size;
    
    ///Text of the `text` mark.
    final TextDefWithCondition? text;
    
    ///The tooltip text to show upon mouse hover.
    final TextDefWithCondition? tooltip;
    
    ///X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    final XClass? x;
    
    ///X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    final X2Class? x2;
    
    ///Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    final XClass? y;
    
    ///Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    final X2Class? y2;

    EncodingWithFacet({
        this.color,
        this.column,
        this.detail,
        this.href,
        this.opacity,
        this.order,
        this.row,
        this.shape,
        this.size,
        this.text,
        this.tooltip,
        this.x,
        this.x2,
        this.y,
        this.y2,
    });

    factory EncodingWithFacet.fromJson(Map<String, dynamic> json) => EncodingWithFacet(
        color: json["color"] == null ? null : MarkPropDefWithCondition.fromJson(json["color"]),
        column: json["column"] == null ? null : FacetFieldDef.fromJson(json["column"]),
        detail: json["detail"],
        href: json["href"] == null ? null : DefWithCondition.fromJson(json["href"]),
        opacity: json["opacity"] == null ? null : MarkPropDefWithCondition.fromJson(json["opacity"]),
        order: json["order"],
        row: json["row"] == null ? null : FacetFieldDef.fromJson(json["row"]),
        shape: json["shape"] == null ? null : MarkPropDefWithCondition.fromJson(json["shape"]),
        size: json["size"] == null ? null : MarkPropDefWithCondition.fromJson(json["size"]),
        text: json["text"] == null ? null : TextDefWithCondition.fromJson(json["text"]),
        tooltip: json["tooltip"] == null ? null : TextDefWithCondition.fromJson(json["tooltip"]),
        x: json["x"] == null ? null : XClass.fromJson(json["x"]),
        x2: json["x2"] == null ? null : X2Class.fromJson(json["x2"]),
        y: json["y"] == null ? null : XClass.fromJson(json["y"]),
        y2: json["y2"] == null ? null : X2Class.fromJson(json["y2"]),
    );

    Map<String, dynamic> toJson() => {
        "color": color?.toJson(),
        "column": column?.toJson(),
        "detail": detail,
        "href": href?.toJson(),
        "opacity": opacity?.toJson(),
        "order": order,
        "row": row?.toJson(),
        "shape": shape?.toJson(),
        "size": size?.toJson(),
        "text": text?.toJson(),
        "tooltip": tooltip?.toJson(),
        "x": x?.toJson(),
        "x2": x2?.toJson(),
        "y": y?.toJson(),
        "y2": y2?.toJson(),
    };
}


///Color of the marks – either fill or stroke color based on mark type.
///By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
///`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
///
///__Default value:__ If undefined, the default color depends on [mark
///config](config.html#mark)'s `color` property.
///
///_Note:_ See the scale documentation for more information about customizing [color
///scheme](scale.html#scheme).
///
///Opacity of the marks – either can be a value or a range.
///
///__Default value:__ If undefined, the default opacity depends on [mark
///config](config.html#mark)'s `opacity` property.
///
///For `point` marks the supported values are
///`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
///or `"triangle-down"`, or else a custom SVG path string.
///For `geoshape` marks it should be a field definition of the geojson data
///
///__Default value:__ If undefined, the default shape depends on [mark
///config](config.html#point-config)'s `shape` property.
///
///Size of the mark.
///- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
///- For `"bar"` and `"tick"` – the bar and tick's size.
///- For `"text"` – the text's font size.
///- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
///
///A FieldDef with Condition<ValueDef>
///{
///condition: {value: ...},
///field: ...,
///...
///}
///
///A ValueDef with Condition<ValueDef | FieldDef>
///{
///condition: {field: ...} | {value: ...},
///value: ...,
///}
class MarkPropDefWithCondition {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///One or more value definition(s) with a selection predicate.
    ///
    ///__Note:__ A field definition's `condition` property can only contain [value
    ///definitions](encoding.html#value-def)
    ///since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    ///A field definition or one or more value definition(s) with a selection predicate.
    final dynamic condition;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///An object defining properties of the legend.
    ///If `null`, the legend for the encoding channel will be removed.
    ///
    ///__Default value:__ If undefined, default [legend properties](legend.html) are applied.
    final Legend? legend;
    
    ///An object defining properties of the channel's scale, which is the function that
    ///transforms values in the data domain (numbers, dates, strings, etc) to visual values
    ///(pixels, colors, sizes) of the encoding channels.
    ///
    ///__Default value:__ If undefined, default [scale properties](scale.html) are applied.
    final Scale? scale;
    
    ///Sort order for the encoded field.
    ///Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    ///For fields with discrete domains, `sort` can also be a [sort field definition
    ///object](sort.html#sort-field).
    ///
    ///__Default value:__ `"ascending"`
    final dynamic sort;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;
    
    ///A constant value in visual domain.
    final dynamic value;

    MarkPropDefWithCondition({
        this.aggregate,
        this.bin,
        this.condition,
        this.field,
        this.legend,
        this.scale,
        this.sort,
        this.timeUnit,
        this.type,
        this.value,
    });

    factory MarkPropDefWithCondition.fromJson(Map<String, dynamic> json) => MarkPropDefWithCondition(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        condition: json["condition"],
        field: json["field"],
        legend: json["legend"] == null ? null : Legend.fromJson(json["legend"]),
        scale: json["scale"] == null ? null : Scale.fromJson(json["scale"]),
        sort: json["sort"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "condition": condition,
        "field": field,
        "legend": legend?.toJson(),
        "scale": scale?.toJson(),
        "sort": sort,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
        "value": value,
    };
}


///Aggregation function for the field
///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
///
///__Default value:__ `undefined` (None)
///
///An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
///(e.g., `"count"`, `"mean"` and `"median"`).
///This property is required in cases where the sort field and the data reference field do
///not match.
///The input data objects will be aggregated, grouped by the encoded data field.
///
///For a full list of operations, please see the documentation for
///[aggregate](aggregate.html#ops).
///
///The aggregation operations to apply to the fields, such as sum, average or count.
///See the [full list of supported aggregation
///operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
///for more information.
enum AggregateOp {
    ARGMAX,
    ARGMIN,
    AVERAGE,
    COUNT,
    DISTINCT,
    MAX,
    MEAN,
    MEDIAN,
    MIN,
    MISSING,
    Q1,
    Q3,
    CI0,
    CI1,
    STDEV,
    STDEVP,
    SUM,
    VALID,
    VALUES,
    VARIANCE,
    VARIANCEP
}

final aggregateOpValues = EnumValues({
    "argmax": AggregateOp.ARGMAX,
    "argmin": AggregateOp.ARGMIN,
    "average": AggregateOp.AVERAGE,
    "count": AggregateOp.COUNT,
    "distinct": AggregateOp.DISTINCT,
    "max": AggregateOp.MAX,
    "mean": AggregateOp.MEAN,
    "median": AggregateOp.MEDIAN,
    "min": AggregateOp.MIN,
    "missing": AggregateOp.MISSING,
    "q1": AggregateOp.Q1,
    "q3": AggregateOp.Q3,
    "ci0": AggregateOp.CI0,
    "ci1": AggregateOp.CI1,
    "stdev": AggregateOp.STDEV,
    "stdevp": AggregateOp.STDEVP,
    "sum": AggregateOp.SUM,
    "valid": AggregateOp.VALID,
    "values": AggregateOp.VALUES,
    "variance": AggregateOp.VARIANCE,
    "variancep": AggregateOp.VARIANCEP
});


///Binning properties or boolean flag for determining whether to bin data or not.
class BinParams {
    
    ///The number base to use for automatic bin determination (default is base 10).
    ///
    ///__Default value:__ `10`
    final double? base;
    
    ///Scale factors indicating allowable subdivisions. The default value is [5, 2], which
    ///indicates that for base 10 numbers (the default base), the method may consider dividing
    ///bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
    ///check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
    ///given constraints.
    ///
    ///__Default value:__ `[5, 2]`
    final List<double>? divide;
    
    ///A two-element (`[min, max]`) array indicating the range of desired bin values.
    final List<double>? extent;
    
    ///Maximum number of bins.
    ///
    ///__Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
    final double? maxbins;
    
    ///A minimum allowable step size (particularly useful for integer values).
    final double? minstep;
    
    ///If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
    ///such as multiples of ten.
    final bool? nice;
    
    ///An exact step size to use between bins.
    ///
    ///__Note:__ If provided, options such as maxbins will be ignored.
    final double? step;
    
    ///An array of allowable step sizes to choose from.
    final List<double>? steps;

    BinParams({
        this.base,
        this.divide,
        this.extent,
        this.maxbins,
        this.minstep,
        this.nice,
        this.step,
        this.steps,
    });

    factory BinParams.fromJson(Map<String, dynamic> json) => BinParams(
        base: json["base"]?.toDouble(),
        divide: json["divide"] == null ? null : (() { final x = List<double>.from(json["divide"]!.map((x) => x?.toDouble())); if (x.length < 1) throw FormatException('Invalid array length'); return x; })(),
        extent: json["extent"] == null ? null : (() { final x = List<double>.from(json["extent"]!.map((x) => x?.toDouble())); if (x.length < 2 || x.length > 2) throw FormatException('Invalid array length'); return x; })(),
        maxbins: json["maxbins"]?.toDouble() == null ? null : ((x) => x >= 2 && true ? x : throw FormatException("Expected bounded number"))(json["maxbins"]?.toDouble()),
        minstep: json["minstep"]?.toDouble(),
        nice: json["nice"],
        step: json["step"]?.toDouble(),
        steps: json["steps"] == null ? null : (() { final x = List<double>.from(json["steps"]!.map((x) => x?.toDouble())); if (x.length < 1) throw FormatException('Invalid array length'); return x; })(),
    );

    Map<String, dynamic> toJson() => {
        "base": base,
        "divide": divide == null ? null : List<dynamic>.from(divide!.map((x) => x)),
        "extent": extent == null ? null : List<dynamic>.from(extent!.map((x) => x)),
        "maxbins": maxbins,
        "minstep": minstep,
        "nice": nice,
        "step": step,
        "steps": steps == null ? null : List<dynamic>.from(steps!.map((x) => x)),
    };
}

class ConditionalValueDef {
    final dynamic test;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;
    
    ///A [selection name](selection.html), or a series of [composed
    ///selections](selection.html#compose).
    final dynamic selection;

    ConditionalValueDef({
        this.test,
        required this.value,
        this.selection,
    });

    factory ConditionalValueDef.fromJson(Map<String, dynamic> json) => ConditionalValueDef(
        test: json["test"],
        value: json["value"],
        selection: json["selection"],
    );

    Map<String, dynamic> toJson() => {
        "test": test,
        "value": value,
        "selection": selection,
    };
}

class Selection {
    final dynamic not;
    final List<dynamic>? and;
    final List<dynamic>? or;

    Selection({
        this.not,
        this.and,
        this.or,
    });

    factory Selection.fromJson(Map<String, dynamic> json) => Selection(
        not: json["not"],
        and: json["and"] == null ? null : List<dynamic>.from(json["and"]!.map((x) => x)),
        or: json["or"] == null ? null : List<dynamic>.from(json["or"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "not": not,
        "and": and == null ? null : List<dynamic>.from(and!.map((x) => x)),
        "or": or == null ? null : List<dynamic>.from(or!.map((x) => x)),
    };
}

class Predicate {
    final dynamic not;
    final List<dynamic>? and;
    final List<dynamic>? or;
    
    ///The value that the field should be equal to.
    final dynamic equal;
    
    ///Field to be filtered.
    ///
    ///Field to be filtered
    final String? field;
    
    ///Time unit for the field to be filtered.
    ///
    ///time unit for the field to be filtered.
    final TimeUnit? timeUnit;
    
    ///An array of inclusive minimum and maximum values
    ///for a field value of a data item to be included in the filtered data.
    final List<dynamic>? range;
    
    ///A set of values that the `field`'s value should be a member of,
    ///for a data item included in the filtered data.
    final List<dynamic>? oneOf;
    
    ///Filter using a selection name.
    final dynamic selection;

    Predicate({
        this.not,
        this.and,
        this.or,
        this.equal,
        this.field,
        this.timeUnit,
        this.range,
        this.oneOf,
        this.selection,
    });

    factory Predicate.fromJson(Map<String, dynamic> json) => Predicate(
        not: json["not"],
        and: json["and"] == null ? null : List<dynamic>.from(json["and"]!.map((x) => x)),
        or: json["or"] == null ? null : List<dynamic>.from(json["or"]!.map((x) => x)),
        equal: json["equal"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        range: json["range"] == null ? null : (() { final x = List<dynamic>.from(json["range"]!.map((x) => x)); if (x.length < 2 || x.length > 2) throw FormatException('Invalid array length'); return x; })(),
        oneOf: json["oneOf"] == null ? null : List<dynamic>.from(json["oneOf"]!.map((x) => x)),
        selection: json["selection"],
    );

    Map<String, dynamic> toJson() => {
        "not": not,
        "and": and == null ? null : List<dynamic>.from(and!.map((x) => x)),
        "or": or == null ? null : List<dynamic>.from(or!.map((x) => x)),
        "equal": equal,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "range": range == null ? null : List<dynamic>.from(range!.map((x) => x)),
        "oneOf": oneOf == null ? null : List<dynamic>.from(oneOf!.map((x) => x)),
        "selection": selection,
    };
}


///Object for defining datetime in Vega-Lite Filter.
///If both month and quarter are provided, month has higher precedence.
///`day` cannot be combined with other date.
///We accept string for month and day names.
class DateTimeClass {
    
    ///Integer value representing the date from 1-31.
    final double? date;
    
    ///Value representing the day of a week.  This can be one of: (1) integer value -- `1`
    ///represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
    ///case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
    ///DateTime definition object with `day`** should not be combined with `year`, `quarter`,
    ///`month`, or `date`.
    final dynamic day;
    
    ///Integer value representing the hour of a day from 0-23.
    final double? hours;
    
    ///Integer value representing the millisecond segment of time.
    final double? milliseconds;
    
    ///Integer value representing the minute segment of time from 0-59.
    final double? minutes;
    
    ///One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
    ///(2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
    ///short month name (e.g., `"Jan"`).
    final dynamic month;
    
    ///Integer value representing the quarter of the year (from 1-4).
    final double? quarter;
    
    ///Integer value representing the second segment (0-59) of a time value
    final double? seconds;
    
    ///A boolean flag indicating if date time is in utc time. If false, the date time is in
    ///local time
    final bool? utc;
    
    ///Integer value representing the year.
    final double? year;

    DateTimeClass({
        this.date,
        this.day,
        this.hours,
        this.milliseconds,
        this.minutes,
        this.month,
        this.quarter,
        this.seconds,
        this.utc,
        this.year,
    });

    factory DateTimeClass.fromJson(Map<String, dynamic> json) => DateTimeClass(
        date: json["date"]?.toDouble() == null ? null : ((x) => x >= 1 && x <= 31 ? x : throw FormatException("Expected bounded number"))(json["date"]?.toDouble()),
        day: json["day"],
        hours: json["hours"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 23 ? x : throw FormatException("Expected bounded number"))(json["hours"]?.toDouble()),
        milliseconds: json["milliseconds"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 999 ? x : throw FormatException("Expected bounded number"))(json["milliseconds"]?.toDouble()),
        minutes: json["minutes"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 59 ? x : throw FormatException("Expected bounded number"))(json["minutes"]?.toDouble()),
        month: json["month"],
        quarter: json["quarter"]?.toDouble() == null ? null : ((x) => x >= 1 && x <= 4 ? x : throw FormatException("Expected bounded number"))(json["quarter"]?.toDouble()),
        seconds: json["seconds"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 59 ? x : throw FormatException("Expected bounded number"))(json["seconds"]?.toDouble()),
        utc: json["utc"],
        year: json["year"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "hours": hours,
        "milliseconds": milliseconds,
        "minutes": minutes,
        "month": month,
        "quarter": quarter,
        "seconds": seconds,
        "utc": utc,
        "year": year,
    };
}


///Time unit for the field to be filtered.
///
///time unit for the field to be filtered.
///
///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
///or [a temporal field that gets casted as ordinal](type.html#cast).
///
///__Default value:__ `undefined` (None)
///
///The timeUnit.
enum TimeUnit {
    YEAR,
    QUARTER,
    MONTH,
    DAY,
    DATE,
    HOURS,
    MINUTES,
    SECONDS,
    MILLISECONDS,
    UTCYEAR,
    UTCQUARTER,
    UTCMONTH,
    UTCDAY,
    UTCDATE,
    UTCHOURS,
    UTCMINUTES,
    UTCSECONDS,
    UTCMILLISECONDS,
    YEARQUARTER,
    YEARQUARTERMONTH,
    YEARMONTH,
    YEARMONTHDATE,
    YEARMONTHDATEHOURS,
    YEARMONTHDATEHOURSMINUTES,
    YEARMONTHDATEHOURSMINUTESSECONDS,
    QUARTERMONTH,
    MONTHDATE,
    HOURSMINUTES,
    HOURSMINUTESSECONDS,
    MINUTESSECONDS,
    SECONDSMILLISECONDS,
    UTCYEARQUARTER,
    UTCYEARQUARTERMONTH,
    UTCYEARMONTH,
    UTCYEARMONTHDATE,
    UTCYEARMONTHDATEHOURS,
    UTCYEARMONTHDATEHOURSMINUTES,
    UTCYEARMONTHDATEHOURSMINUTESSECONDS,
    UTCQUARTERMONTH,
    UTCMONTHDATE,
    UTCHOURSMINUTES,
    UTCHOURSMINUTESSECONDS,
    UTCMINUTESSECONDS,
    UTCSECONDSMILLISECONDS
}

final timeUnitValues = EnumValues({
    "year": TimeUnit.YEAR,
    "quarter": TimeUnit.QUARTER,
    "month": TimeUnit.MONTH,
    "day": TimeUnit.DAY,
    "date": TimeUnit.DATE,
    "hours": TimeUnit.HOURS,
    "minutes": TimeUnit.MINUTES,
    "seconds": TimeUnit.SECONDS,
    "milliseconds": TimeUnit.MILLISECONDS,
    "utcyear": TimeUnit.UTCYEAR,
    "utcquarter": TimeUnit.UTCQUARTER,
    "utcmonth": TimeUnit.UTCMONTH,
    "utcday": TimeUnit.UTCDAY,
    "utcdate": TimeUnit.UTCDATE,
    "utchours": TimeUnit.UTCHOURS,
    "utcminutes": TimeUnit.UTCMINUTES,
    "utcseconds": TimeUnit.UTCSECONDS,
    "utcmilliseconds": TimeUnit.UTCMILLISECONDS,
    "yearquarter": TimeUnit.YEARQUARTER,
    "yearquartermonth": TimeUnit.YEARQUARTERMONTH,
    "yearmonth": TimeUnit.YEARMONTH,
    "yearmonthdate": TimeUnit.YEARMONTHDATE,
    "yearmonthdatehours": TimeUnit.YEARMONTHDATEHOURS,
    "yearmonthdatehoursminutes": TimeUnit.YEARMONTHDATEHOURSMINUTES,
    "yearmonthdatehoursminutesseconds": TimeUnit.YEARMONTHDATEHOURSMINUTESSECONDS,
    "quartermonth": TimeUnit.QUARTERMONTH,
    "monthdate": TimeUnit.MONTHDATE,
    "hoursminutes": TimeUnit.HOURSMINUTES,
    "hoursminutesseconds": TimeUnit.HOURSMINUTESSECONDS,
    "minutesseconds": TimeUnit.MINUTESSECONDS,
    "secondsmilliseconds": TimeUnit.SECONDSMILLISECONDS,
    "utcyearquarter": TimeUnit.UTCYEARQUARTER,
    "utcyearquartermonth": TimeUnit.UTCYEARQUARTERMONTH,
    "utcyearmonth": TimeUnit.UTCYEARMONTH,
    "utcyearmonthdate": TimeUnit.UTCYEARMONTHDATE,
    "utcyearmonthdatehours": TimeUnit.UTCYEARMONTHDATEHOURS,
    "utcyearmonthdatehoursminutes": TimeUnit.UTCYEARMONTHDATEHOURSMINUTES,
    "utcyearmonthdatehoursminutesseconds": TimeUnit.UTCYEARMONTHDATEHOURSMINUTESSECONDS,
    "utcquartermonth": TimeUnit.UTCQUARTERMONTH,
    "utcmonthdate": TimeUnit.UTCMONTHDATE,
    "utchoursminutes": TimeUnit.UTCHOURSMINUTES,
    "utchoursminutesseconds": TimeUnit.UTCHOURSMINUTESSECONDS,
    "utcminutesseconds": TimeUnit.UTCMINUTESSECONDS,
    "utcsecondsmilliseconds": TimeUnit.UTCSECONDSMILLISECONDS
});

class ConditionalPredicateMarkPropFieldDefClass {
    final dynamic test;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;
    
    ///A [selection name](selection.html), or a series of [composed
    ///selections](selection.html#compose).
    final dynamic selection;
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///An object defining properties of the legend.
    ///If `null`, the legend for the encoding channel will be removed.
    ///
    ///__Default value:__ If undefined, default [legend properties](legend.html) are applied.
    final Legend? legend;
    
    ///An object defining properties of the channel's scale, which is the function that
    ///transforms values in the data domain (numbers, dates, strings, etc) to visual values
    ///(pixels, colors, sizes) of the encoding channels.
    ///
    ///__Default value:__ If undefined, default [scale properties](scale.html) are applied.
    final Scale? scale;
    
    ///Sort order for the encoded field.
    ///Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    ///For fields with discrete domains, `sort` can also be a [sort field definition
    ///object](sort.html#sort-field).
    ///
    ///__Default value:__ `"ascending"`
    final dynamic sort;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;

    ConditionalPredicateMarkPropFieldDefClass({
        this.test,
        this.value,
        this.selection,
        this.aggregate,
        this.bin,
        this.field,
        this.legend,
        this.scale,
        this.sort,
        this.timeUnit,
        this.type,
    });

    factory ConditionalPredicateMarkPropFieldDefClass.fromJson(Map<String, dynamic> json) => ConditionalPredicateMarkPropFieldDefClass(
        test: json["test"],
        value: json["value"],
        selection: json["selection"],
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        legend: json["legend"] == null ? null : Legend.fromJson(json["legend"]),
        scale: json["scale"] == null ? null : Scale.fromJson(json["scale"]),
        sort: json["sort"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "test": test,
        "value": value,
        "selection": selection,
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "legend": legend?.toJson(),
        "scale": scale?.toJson(),
        "sort": sort,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}


///Reference to a repeated value.
class RepeatRef {
    final RepeatEnum repeat;

    RepeatRef({
        required this.repeat,
    });

    factory RepeatRef.fromJson(Map<String, dynamic> json) => RepeatRef(
        repeat: repeatEnumValues.map[json["repeat"]]!,
    );

    Map<String, dynamic> toJson() => {
        "repeat": repeatEnumValues.reverse[repeat],
    };
}

enum RepeatEnum {
    ROW,
    COLUMN
}

final repeatEnumValues = EnumValues({
    "row": RepeatEnum.ROW,
    "column": RepeatEnum.COLUMN
});


///Properties of a legend or boolean flag for determining whether to show it.
class Legend {
    
    ///Padding (in pixels) between legend entries in a symbol legend.
    final double? entryPadding;
    
    ///The formatting pattern for labels. This is D3's [number format
    ///pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    ///[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    ///field.
    ///
    ///See the [format documentation](format.html) for more information.
    ///
    ///__Default value:__  derived from [numberFormat](config.html#format) config for
    ///quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    final String? format;
    
    ///The offset, in pixels, by which to displace the legend from the edge of the enclosing
    ///group or data rectangle.
    ///
    ///__Default value:__  `0`
    final double? offset;
    
    ///The orientation of the legend, which determines how the legend is positioned within the
    ///scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    ///"none".
    ///
    ///__Default value:__ `"right"`
    final LegendOrient? orient;
    
    ///The padding, in pixels, between the legend and axis.
    final double? padding;
    
    ///The desired number of tick values for quantitative legends.
    final double? tickCount;
    
    ///A title for the field. If `null`, the title will be removed.
    ///
    ///__Default value:__  derived from the field's name and transformation function
    ///(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    ///function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    ///binned or has a time unit applied, the applied function will be denoted in parentheses
    ///(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    ///simply the field name.
    ///
    ///__Note__: You can customize the default field title format by providing the [`fieldTitle`
    ///property in the [config](config.html) or [`fieldTitle` function via the `compile`
    ///function's options](compile.html#field-title).
    final String? title;
    
    ///The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
    ///continuous color gradient.
    ///
    ///__Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
    ///`"symbol"` otherwise.
    final LegendType? type;
    
    ///Explicitly set the visible legend values.
    final List<dynamic>? values;
    
    ///A non-positive integer indicating z-index of the legend.
    ///If zindex is 0, legend should be drawn behind all chart elements.
    ///To put them in front, use zindex = 1.
    final double? zindex;

    Legend({
        this.entryPadding,
        this.format,
        this.offset,
        this.orient,
        this.padding,
        this.tickCount,
        this.title,
        this.type,
        this.values,
        this.zindex,
    });

    factory Legend.fromJson(Map<String, dynamic> json) => Legend(
        entryPadding: json["entryPadding"]?.toDouble(),
        format: json["format"],
        offset: json["offset"]?.toDouble(),
        orient: json["orient"] == null ? null : legendOrientValues.map[json["orient"]]!,
        padding: json["padding"]?.toDouble(),
        tickCount: json["tickCount"]?.toDouble(),
        title: json["title"],
        type: json["type"] == null ? null : legendTypeValues.map[json["type"]]!,
        values: json["values"] == null ? null : List<dynamic>.from(json["values"]!.map((x) => x)),
        zindex: json["zindex"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["zindex"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "entryPadding": entryPadding,
        "format": format,
        "offset": offset,
        "orient": legendOrientValues.reverse[orient],
        "padding": padding,
        "tickCount": tickCount,
        "title": title,
        "type": legendTypeValues.reverse[type],
        "values": values == null ? null : List<dynamic>.from(values!.map((x) => x)),
        "zindex": zindex,
    };
}


///The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
///continuous color gradient.
///
///__Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
///`"symbol"` otherwise.
enum LegendType {
    SYMBOL,
    GRADIENT
}

final legendTypeValues = EnumValues({
    "symbol": LegendType.SYMBOL,
    "gradient": LegendType.GRADIENT
});


///An object defining properties of the channel's scale, which is the function that
///transforms values in the data domain (numbers, dates, strings, etc) to visual values
///(pixels, colors, sizes) of the encoding channels.
///
///__Default value:__ If undefined, default [scale properties](scale.html) are applied.
class Scale {
    
    ///The logarithm base of the `log` scale (default `10`).
    final double? base;
    
    ///If `true`, values that exceed the data domain are clamped to either the minimum or
    ///maximum range value
    ///
    ///__Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
    ///(`true` by default).
    final bool? clamp;
    
    ///Customized domain values.
    ///
    ///For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
    ///and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
    ///a `domain` with more than two entries.
    ///If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
    ///indicating that the domain should include the raw data values prior to the aggregation.
    ///
    ///For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
    ///the form of either timestamps or the [DateTime definition objects](types.html#datetime).
    ///
    ///For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
    ///values.
    ///
    ///The `selection` property can be used to [interactively
    ///determine](selection.html#scale-domains) the scale domain.
    final dynamic domain;
    
    ///The exponent of the `pow` scale.
    final double? exponent;
    
    ///The interpolation method for range values. By default, a general interpolator for
    ///numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
    ///property allows interpolation in alternative color spaces. Legal values include `rgb`,
    ///`hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
    ///variants use longer paths in polar coordinate spaces). If object-valued, this property
    ///accepts an object with a string-valued _type_ property and an optional numeric _gamma_
    ///property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
    ///documentation](https://github.com/d3/d3-interpolate).
    ///
    ///__Note:__ Sequential scales do not support `interpolate` as they have a fixed
    ///interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
    ///you have to set the scale `type` to other quantitative scale type such as `"linear"` to
    ///customize `interpolate`.
    final dynamic interpolate;
    
    ///Extending the domain so that it starts and ends on nice round values. This method
    ///typically modifies the scale’s domain, and may only extend the bounds to the nearest
    ///round value. Nicing is useful if the domain is computed from data and may be irregular.
    ///For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
    ///1.0]_.
    ///
    ///For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
    ///If `nice` is a number, it will represent a desired tick count. This allows greater
    ///control over the step size used to extend the bounds, guaranteeing that the returned
    ///ticks will exactly cover the domain.
    ///
    ///For temporal fields with time and utc scales, the `nice` value can be a string indicating
    ///the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
    ///`"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
    ///scales can accept an object-valued interval specifier of the form `{"interval": "month",
    ///"step": 3}`, which includes a desired number of interval steps. Here, the domain would
    ///snap to quarter (Jan, Apr, Jul, Oct) boundaries.
    ///
    ///__Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
    final dynamic nice;
    
    ///For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
    ///the specified number of pixels on each of the scale range. The scale range must represent
    ///pixels for this parameter to function as intended. Padding adjustment is performed prior
    ///to all other adjustments, including the effects of the zero, nice, domainMin, and
    ///domainMax properties.
    ///
    ///For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
    ///`paddingOuter` to the same value.
    ///
    ///For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
    ///
    ///__Default value:__ For _continuous_ scales, derived from the [scale
    ///config](scale.html#config)'s `continuousPadding`.
    ///For _band and point_ scales, see `paddingInner` and `paddingOuter`.
    final double? padding;
    
    ///The inner padding (spacing) within each band step of band scales, as a fraction of the
    ///step size. This value must lie in the range [0,1].
    ///
    ///For point scale, this property is invalid as point scales do not have internal band
    ///widths (only step sizes between bands).
    ///
    ///__Default value:__ derived from the [scale config](scale.html#config)'s
    ///`bandPaddingInner`.
    final double? paddingInner;
    
    ///The outer padding (spacing) at the ends of the range of band and point scales,
    ///as a fraction of the step size. This value must lie in the range [0,1].
    ///
    ///__Default value:__ derived from the [scale config](scale.html#config)'s
    ///`bandPaddingOuter` for band scales and `pointPadding` for point scales.
    final double? paddingOuter;
    
    ///The range of the scale. One of:
    ///
    ///- A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
    ///example, `"symbol"`, or `"diverging"`).
    ///
    ///- For [continuous scales](scale.html#continuous), two-element array indicating  minimum
    ///and maximum values, or an array with more than two entries for specifying a [piecewise
    ///scale](scale.html#piecewise).
    ///
    ///- For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
    ///an array of desired output values.
    ///
    ///__Notes:__
    ///
    ///1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
    ///discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
    ///instead of `range`.
    ///
    ///2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
    ///customized via the view's corresponding [size](size.html) (`width` and `height`) or via
    ///[range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
    ///scales.
    final dynamic range;
    
    ///The distance between the starts of adjacent bands or points in [band](scale.html#band)
    ///and [point](scale.html#point) scales.
    ///
    ///If `rangeStep` is `null` or if the view contains the scale's corresponding
    ///[size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
    ///be automatically determined to fit the size of the view.
    ///
    ///__Default value:__  derived the [scale config](config.html#scale-config)'s
    ///`textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
    ///default) for x-scales of other marks and y-scales.
    ///
    ///__Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
    ///than `width` or `height`, the rangeStep might become less than one pixel and the mark
    ///might not appear correctly.
    final double? rangeStep;
    
    ///If `true`, rounds numeric output values to integers. This can be helpful for snapping to
    ///the pixel grid.
    ///
    ///__Default value:__ `false`.
    final bool? round;
    
    ///A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
    ///`"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
    ///
    ///Discrete color schemes may be used with [discrete](scale.html#discrete) or
    ///[discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
    ///use with [sequential](scales.html#sequential) scales.
    ///
    ///For the full list of supported scheme, please refer to the [Vega
    ///Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    final dynamic scheme;
    
    ///The type of scale.  Vega-Lite supports the following categories of scale types:
    ///
    ///1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
    ///continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
    ///[`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
    ///[`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
    ///
    ///2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
    ///([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
    ///[`"point"`](scale.html#point)) output ranges.
    ///
    ///3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
    ///discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
    ///[`"bin-ordinal"`](scale.html#bin-ordinal)).
    ///
    ///__Default value:__ please see the [scale type table](scale.html#type).
    final ScaleType? type;
    
    ///If `true`, ensures that a zero baseline value is included in the scale domain.
    ///
    ///__Default value:__ `true` for x and y channels if the quantitative field is not binned
    ///and no custom `domain` is provided; `false` otherwise.
    ///
    ///__Note:__ Log, time, and utc scales do not support `zero`.
    final bool? zero;

    Scale({
        this.base,
        this.clamp,
        this.domain,
        this.exponent,
        this.interpolate,
        this.nice,
        this.padding,
        this.paddingInner,
        this.paddingOuter,
        this.range,
        this.rangeStep,
        this.round,
        this.scheme,
        this.type,
        this.zero,
    });

    factory Scale.fromJson(Map<String, dynamic> json) => Scale(
        base: json["base"]?.toDouble(),
        clamp: json["clamp"],
        domain: json["domain"],
        exponent: json["exponent"]?.toDouble(),
        interpolate: json["interpolate"],
        nice: json["nice"],
        padding: json["padding"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["padding"]?.toDouble()),
        paddingInner: json["paddingInner"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["paddingInner"]?.toDouble()),
        paddingOuter: json["paddingOuter"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["paddingOuter"]?.toDouble()),
        range: json["range"],
        rangeStep: json["rangeStep"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["rangeStep"]?.toDouble()),
        round: json["round"],
        scheme: json["scheme"],
        type: json["type"] == null ? null : scaleTypeValues.map[json["type"]]!,
        zero: json["zero"],
    );

    Map<String, dynamic> toJson() => {
        "base": base,
        "clamp": clamp,
        "domain": domain,
        "exponent": exponent,
        "interpolate": interpolate,
        "nice": nice,
        "padding": padding,
        "paddingInner": paddingInner,
        "paddingOuter": paddingOuter,
        "range": range,
        "rangeStep": rangeStep,
        "round": round,
        "scheme": scheme,
        "type": scaleTypeValues.reverse[type],
        "zero": zero,
    };
}

class DomainClass {
    
    ///The field name to extract selected values for, when a selection is
    ///[projected](project.html)
    ///over multiple fields or encodings.
    final String? field;
    
    ///The name of a selection.
    final String selection;
    
    ///The encoding channel to extract selected values for, when a selection is
    ///[projected](project.html)
    ///over multiple fields or encodings.
    final String? encoding;

    DomainClass({
        this.field,
        required this.selection,
        this.encoding,
    });

    factory DomainClass.fromJson(Map<String, dynamic> json) => DomainClass(
        field: json["field"],
        selection: json["selection"],
        encoding: json["encoding"],
    );

    Map<String, dynamic> toJson() => {
        "field": field,
        "selection": selection,
        "encoding": encoding,
    };
}

enum Domain {
    UNAGGREGATED
}

final domainValues = EnumValues({
    "unaggregated": Domain.UNAGGREGATED
});

class InterpolateParams {
    final double? gamma;
    final InterpolateParamsType type;

    InterpolateParams({
        this.gamma,
        required this.type,
    });

    factory InterpolateParams.fromJson(Map<String, dynamic> json) => InterpolateParams(
        gamma: json["gamma"]?.toDouble(),
        type: interpolateParamsTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "gamma": gamma,
        "type": interpolateParamsTypeValues.reverse[type],
    };
}

enum InterpolateParamsType {
    RGB,
    CUBEHELIX,
    CUBEHELIX_LONG
}

final interpolateParamsTypeValues = EnumValues({
    "rgb": InterpolateParamsType.RGB,
    "cubehelix": InterpolateParamsType.CUBEHELIX,
    "cubehelix-long": InterpolateParamsType.CUBEHELIX_LONG
});

class NiceClass {
    final String interval;
    final double step;

    NiceClass({
        required this.interval,
        required this.step,
    });

    factory NiceClass.fromJson(Map<String, dynamic> json) => NiceClass(
        interval: json["interval"],
        step: json["step"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "interval": interval,
        "step": step,
    };
}

enum NiceTime {
    SECOND,
    MINUTE,
    HOUR,
    DAY,
    WEEK,
    MONTH,
    YEAR
}

final niceTimeValues = EnumValues({
    "second": NiceTime.SECOND,
    "minute": NiceTime.MINUTE,
    "hour": NiceTime.HOUR,
    "day": NiceTime.DAY,
    "week": NiceTime.WEEK,
    "month": NiceTime.MONTH,
    "year": NiceTime.YEAR
});

class SchemeParams {
    
    ///For sequential and diverging schemes only, determines the extent of the color range to
    ///use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
    ///range _[0, 0.2)_ are excluded from the scheme.
    final List<double>? extent;
    
    ///A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
    ///
    ///For the full list of supported scheme, please refer to the [Vega
    ///Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    final String name;

    SchemeParams({
        this.extent,
        required this.name,
    });

    factory SchemeParams.fromJson(Map<String, dynamic> json) => SchemeParams(
        extent: json["extent"] == null ? null : List<double>.from(json["extent"]!.map((x) => x?.toDouble())),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "extent": extent == null ? null : List<dynamic>.from(extent!.map((x) => x)),
        "name": name,
    };
}


///The type of scale.  Vega-Lite supports the following categories of scale types:
///
///1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
///continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
///[`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
///[`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
///
///2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
///([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
///[`"point"`](scale.html#point)) output ranges.
///
///3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
///discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
///[`"bin-ordinal"`](scale.html#bin-ordinal)).
///
///__Default value:__ please see the [scale type table](scale.html#type).
enum ScaleType {
    LINEAR,
    BIN_LINEAR,
    LOG,
    POW,
    SQRT,
    TIME,
    UTC,
    SEQUENTIAL,
    ORDINAL,
    BIN_ORDINAL,
    POINT,
    BAND
}

final scaleTypeValues = EnumValues({
    "linear": ScaleType.LINEAR,
    "bin-linear": ScaleType.BIN_LINEAR,
    "log": ScaleType.LOG,
    "pow": ScaleType.POW,
    "sqrt": ScaleType.SQRT,
    "time": ScaleType.TIME,
    "utc": ScaleType.UTC,
    "sequential": ScaleType.SEQUENTIAL,
    "ordinal": ScaleType.ORDINAL,
    "bin-ordinal": ScaleType.BIN_ORDINAL,
    "point": ScaleType.POINT,
    "band": ScaleType.BAND
});

class SortField {
    
    ///The data [field](field.html) to sort by.
    ///
    ///__Default value:__ If unspecified, defaults to the field specified in the outer data
    ///reference.
    final dynamic field;
    
    ///An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
    ///(e.g., `"count"`, `"mean"` and `"median"`).
    ///This property is required in cases where the sort field and the data reference field do
    ///not match.
    ///The input data objects will be aggregated, grouped by the encoded data field.
    ///
    ///For a full list of operations, please see the documentation for
    ///[aggregate](aggregate.html#ops).
    final AggregateOp op;
    
    ///The sort order. One of `"ascending"` (default) or `"descending"`.
    final SortEnum? order;

    SortField({
        this.field,
        required this.op,
        this.order,
    });

    factory SortField.fromJson(Map<String, dynamic> json) => SortField(
        field: json["field"],
        op: aggregateOpValues.map[json["op"]]!,
        order: json["order"] == null ? null : sortEnumValues.map[json["order"]]!,
    );

    Map<String, dynamic> toJson() => {
        "field": field,
        "op": aggregateOpValues.reverse[op],
        "order": sortEnumValues.reverse[order],
    };
}

enum SortEnum {
    ASCENDING,
    DESCENDING
}

final sortEnumValues = EnumValues({
    "ascending": SortEnum.ASCENDING,
    "descending": SortEnum.DESCENDING
});


///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
///`"nominal"`).
///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
///[geographic projection](projection.html) is applied.
///
///Constants and utilities for data type
///Data type based on level of measurement
enum Type {
    QUANTITATIVE,
    ORDINAL,
    TEMPORAL,
    NOMINAL,
    LATITUDE,
    LONGITUDE,
    GEOJSON
}

final typeValues = EnumValues({
    "quantitative": Type.QUANTITATIVE,
    "ordinal": Type.ORDINAL,
    "temporal": Type.TEMPORAL,
    "nominal": Type.NOMINAL,
    "latitude": Type.LATITUDE,
    "longitude": Type.LONGITUDE,
    "geojson": Type.GEOJSON
});


///Horizontal facets for trellis plots.
///
///Vertical facets for trellis plots.
class FacetFieldDef {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///An object defining properties of a facet's header.
    final Header? header;
    
    ///Sort order for a facet field.
    ///This can be `"ascending"`, `"descending"`.
    final SortEnum? sort;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type type;

    FacetFieldDef({
        this.aggregate,
        this.bin,
        this.field,
        this.header,
        this.sort,
        this.timeUnit,
        required this.type,
    });

    factory FacetFieldDef.fromJson(Map<String, dynamic> json) => FacetFieldDef(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        sort: json["sort"] == null ? null : sortEnumValues.map[json["sort"]]!,
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "header": header?.toJson(),
        "sort": sortEnumValues.reverse[sort],
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}


///An object defining properties of a facet's header.
///
///Headers of row / column channels for faceted plots.
class Header {
    
    ///The formatting pattern for labels. This is D3's [number format
    ///pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    ///[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    ///field.
    ///
    ///See the [format documentation](format.html) for more information.
    ///
    ///__Default value:__  derived from [numberFormat](config.html#format) config for
    ///quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    final String? format;
    
    ///The rotation angle of the header labels.
    ///
    ///__Default value:__ `0`.
    final double? labelAngle;
    
    ///A title for the field. If `null`, the title will be removed.
    ///
    ///__Default value:__  derived from the field's name and transformation function
    ///(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    ///function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    ///binned or has a time unit applied, the applied function will be denoted in parentheses
    ///(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    ///simply the field name.
    ///
    ///__Note__: You can customize the default field title format by providing the [`fieldTitle`
    ///property in the [config](config.html) or [`fieldTitle` function via the `compile`
    ///function's options](compile.html#field-title).
    final String? title;

    Header({
        this.format,
        this.labelAngle,
        this.title,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        format: json["format"],
        labelAngle: json["labelAngle"]?.toDouble() == null ? null : ((x) => x >= -360 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["labelAngle"]?.toDouble()),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "format": format,
        "labelAngle": labelAngle,
        "title": title,
    };
}


///Definition object for a data field, its type and transformation of an encoding channel.
class FieldDef {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type type;

    FieldDef({
        this.aggregate,
        this.bin,
        this.field,
        this.timeUnit,
        required this.type,
    });

    factory FieldDef.fromJson(Map<String, dynamic> json) => FieldDef(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}


///A URL to load upon mouse click.
///
///A FieldDef with Condition<ValueDef>
///{
///condition: {value: ...},
///field: ...,
///...
///}
///
///A ValueDef with Condition<ValueDef | FieldDef>
///{
///condition: {field: ...} | {value: ...},
///value: ...,
///}
class DefWithCondition {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///One or more value definition(s) with a selection predicate.
    ///
    ///__Note:__ A field definition's `condition` property can only contain [value
    ///definitions](encoding.html#value-def)
    ///since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    ///A field definition or one or more value definition(s) with a selection predicate.
    final dynamic condition;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;
    
    ///A constant value in visual domain.
    final dynamic value;

    DefWithCondition({
        this.aggregate,
        this.bin,
        this.condition,
        this.field,
        this.timeUnit,
        this.type,
        this.value,
    });

    factory DefWithCondition.fromJson(Map<String, dynamic> json) => DefWithCondition(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        condition: json["condition"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "condition": condition,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
        "value": value,
    };
}

class ConditionalPredicateFieldDefClass {
    final dynamic test;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;
    
    ///A [selection name](selection.html), or a series of [composed
    ///selections](selection.html#compose).
    final dynamic selection;
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;

    ConditionalPredicateFieldDefClass({
        this.test,
        this.value,
        this.selection,
        this.aggregate,
        this.bin,
        this.field,
        this.timeUnit,
        this.type,
    });

    factory ConditionalPredicateFieldDefClass.fromJson(Map<String, dynamic> json) => ConditionalPredicateFieldDefClass(
        test: json["test"],
        value: json["value"],
        selection: json["selection"],
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "test": test,
        "value": value,
        "selection": selection,
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}

class OrderFieldDef {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///The sort order. One of `"ascending"` (default) or `"descending"`.
    final SortEnum? sort;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type type;

    OrderFieldDef({
        this.aggregate,
        this.bin,
        this.field,
        this.sort,
        this.timeUnit,
        required this.type,
    });

    factory OrderFieldDef.fromJson(Map<String, dynamic> json) => OrderFieldDef(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        sort: json["sort"] == null ? null : sortEnumValues.map[json["sort"]]!,
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "sort": sortEnumValues.reverse[sort],
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}


///Text of the `text` mark.
///
///The tooltip text to show upon mouse hover.
///
///A FieldDef with Condition<ValueDef>
///{
///condition: {value: ...},
///field: ...,
///...
///}
///
///A ValueDef with Condition<ValueDef | FieldDef>
///{
///condition: {field: ...} | {value: ...},
///value: ...,
///}
class TextDefWithCondition {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///One or more value definition(s) with a selection predicate.
    ///
    ///__Note:__ A field definition's `condition` property can only contain [value
    ///definitions](encoding.html#value-def)
    ///since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    ///A field definition or one or more value definition(s) with a selection predicate.
    final dynamic condition;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///The [formatting pattern](format.html) for a text field. If not defined, this will be
    ///determined automatically.
    final String? format;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;
    
    ///A constant value in visual domain.
    final dynamic value;

    TextDefWithCondition({
        this.aggregate,
        this.bin,
        this.condition,
        this.field,
        this.format,
        this.timeUnit,
        this.type,
        this.value,
    });

    factory TextDefWithCondition.fromJson(Map<String, dynamic> json) => TextDefWithCondition(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        condition: json["condition"],
        field: json["field"],
        format: json["format"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "condition": condition,
        "field": field,
        "format": format,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
        "value": value,
    };
}

class ConditionalPredicateTextFieldDefClass {
    final dynamic test;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;
    
    ///A [selection name](selection.html), or a series of [composed
    ///selections](selection.html#compose).
    final dynamic selection;
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///The [formatting pattern](format.html) for a text field. If not defined, this will be
    ///determined automatically.
    final String? format;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;

    ConditionalPredicateTextFieldDefClass({
        this.test,
        this.value,
        this.selection,
        this.aggregate,
        this.bin,
        this.field,
        this.format,
        this.timeUnit,
        this.type,
    });

    factory ConditionalPredicateTextFieldDefClass.fromJson(Map<String, dynamic> json) => ConditionalPredicateTextFieldDefClass(
        test: json["test"],
        value: json["value"],
        selection: json["selection"],
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        format: json["format"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "test": test,
        "value": value,
        "selection": selection,
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "format": format,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
    };
}


///X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
///
///Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
///
///Definition object for a constant value of an encoding channel.
class XClass {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///An object defining properties of axis's gridlines, ticks and labels.
    ///If `null`, the axis for the encoding channel will be removed.
    ///
    ///__Default value:__ If undefined, default [axis properties](axis.html) are applied.
    final Axis? axis;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///An object defining properties of the channel's scale, which is the function that
    ///transforms values in the data domain (numbers, dates, strings, etc) to visual values
    ///(pixels, colors, sizes) of the encoding channels.
    ///
    ///__Default value:__ If undefined, default [scale properties](scale.html) are applied.
    final Scale? scale;
    
    ///Sort order for the encoded field.
    ///Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    ///For fields with discrete domains, `sort` can also be a [sort field definition
    ///object](sort.html#sort-field).
    ///
    ///__Default value:__ `"ascending"`
    final dynamic sort;
    
    ///Type of stacking offset if the field should be stacked.
    ///`stack` is only applicable for `x` and `y` channels with continuous domains.
    ///For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
    ///
    ///`stack` can be one of the following values:
    ///
    ///- `"zero"`: stacking with baseline offset at zero value of the scale (for creating
    ///typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
    ///- `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
    ///and area charts](stack.html#normalized). <br/>
    ///- `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
    ///- `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
    ///area chart.
    ///
    ///__Default value:__ `zero` for plots with all of the following conditions are true:
    ///
    ///1. The mark is `bar` or `area`;
    ///2. The stacked measure channel (x or y) has a linear scale;
    ///3. At least one of non-position channels mapped to an unaggregated field that is
    ///different from x and y.  Otherwise, `null` by default.
    final StackOffset? stack;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;

    XClass({
        this.aggregate,
        this.axis,
        this.bin,
        this.field,
        this.scale,
        this.sort,
        this.stack,
        this.timeUnit,
        this.type,
        this.value,
    });

    factory XClass.fromJson(Map<String, dynamic> json) => XClass(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        axis: json["axis"] == null ? null : Axis.fromJson(json["axis"]),
        bin: json["bin"],
        field: json["field"],
        scale: json["scale"] == null ? null : Scale.fromJson(json["scale"]),
        sort: json["sort"],
        stack: json["stack"] == null ? null : stackOffsetValues.map[json["stack"]]!,
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "axis": axis?.toJson(),
        "bin": bin,
        "field": field,
        "scale": scale?.toJson(),
        "sort": sort,
        "stack": stackOffsetValues.reverse[stack],
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
        "value": value,
    };
}

class Axis {
    
    ///A boolean flag indicating if the domain (the axis baseline) should be included as part of
    ///the axis.
    ///
    ///__Default value:__ `true`
    final bool? domain;
    
    ///The formatting pattern for labels. This is D3's [number format
    ///pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    ///[time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    ///field.
    ///
    ///See the [format documentation](format.html) for more information.
    ///
    ///__Default value:__  derived from [numberFormat](config.html#format) config for
    ///quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    final String? format;
    
    ///A boolean flag indicating if grid lines should be included as part of the axis
    ///
    ///__Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    ///binned; otherwise, `false`.
    final bool? grid;
    
    ///The rotation angle of the axis labels.
    ///
    ///__Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    final double? labelAngle;
    
    ///Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    ///default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    ///they exceed the axis range by more than 1 pixel. If this property is a number, it
    ///specifies the pixel tolerance: the maximum amount by which a label bounding box may
    ///exceed the axis range.
    ///
    ///__Default value:__ `false`.
    final dynamic labelBound;
    
    ///Indicates if the first and last axis labels should be aligned flush with the scale range.
    ///Flush alignment for a horizontal axis will left-align the first label and right-align the
    ///last label. For vertical axes, bottom and top text baselines are applied instead. If this
    ///property is a number, it also indicates the number of pixels by which to offset the first
    ///and last labels; for example, a value of 2 will flush-align the first and last labels and
    ///also push them 2 pixels outward from the center of the axis. The additional adjustment
    ///can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    ///__Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    final dynamic labelFlush;
    
    ///The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    ///overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    ///every other label is used (this works well for standard linear axes). If set to
    ///`"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    ///with the last visible label (this often works better for log-scaled axes).
    ///
    ///__Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    ///scales; otherwise `false`.
    final dynamic labelOverlap;
    
    ///The padding, in pixels, between axis and text labels.
    final double? labelPadding;
    
    ///A boolean flag indicating if labels should be included as part of the axis.
    ///
    ///__Default value:__  `true`.
    final bool? labels;
    
    ///The maximum extent in pixels that axis ticks and labels should use. This determines a
    ///maximum offset value for axis titles.
    ///
    ///__Default value:__ `undefined`.
    final double? maxExtent;
    
    ///The minimum extent in pixels that axis ticks and labels should use. This determines a
    ///minimum offset value for axis titles.
    ///
    ///__Default value:__ `30` for y-axis; `undefined` for x-axis.
    final double? minExtent;
    
    ///The offset, in pixels, by which to displace the axis from the edge of the enclosing group
    ///or data rectangle.
    ///
    ///__Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
    ///`offset` (`0` by default)
    final double? offset;
    
    ///The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
    ///orientation can be used to further specialize the axis type (e.g., a y axis oriented for
    ///the right edge of the chart).
    ///
    ///__Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
    final TitleOrient? orient;
    
    ///The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
    ///this sets the axis group x coordinate. For y-axis with left or right orientation, this
    ///sets the axis group y coordinate.
    ///
    ///__Default value__: `0`
    final double? position;
    
    ///A desired number of ticks, for axes visualizing quantitative scales. The resulting number
    ///may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
    ///underlying scale's range.
    final double? tickCount;
    
    ///Boolean value that determines whether the axis should include ticks.
    final bool? ticks;
    
    ///The size in pixels of axis ticks.
    final double? tickSize;
    
    ///A title for the field. If `null`, the title will be removed.
    ///
    ///__Default value:__  derived from the field's name and transformation function
    ///(`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    ///function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    ///binned or has a time unit applied, the applied function will be denoted in parentheses
    ///(e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    ///simply the field name.
    ///
    ///__Note__: You can customize the default field title format by providing the [`fieldTitle`
    ///property in the [config](config.html) or [`fieldTitle` function via the `compile`
    ///function's options](compile.html#field-title).
    final String? title;
    
    ///Max length for axis title if the title is automatically generated from the field's
    ///description.
    final double? titleMaxLength;
    
    ///The padding, in pixels, between title and axis.
    final double? titlePadding;
    
    ///Explicitly set the visible axis tick values.
    final List<dynamic>? values;
    
    ///A non-positive integer indicating z-index of the axis.
    ///If zindex is 0, axes should be drawn behind all chart elements.
    ///To put them in front, use `"zindex = 1"`.
    ///
    ///__Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
    ///for grids.
    final double? zindex;

    Axis({
        this.domain,
        this.format,
        this.grid,
        this.labelAngle,
        this.labelBound,
        this.labelFlush,
        this.labelOverlap,
        this.labelPadding,
        this.labels,
        this.maxExtent,
        this.minExtent,
        this.offset,
        this.orient,
        this.position,
        this.tickCount,
        this.ticks,
        this.tickSize,
        this.title,
        this.titleMaxLength,
        this.titlePadding,
        this.values,
        this.zindex,
    });

    factory Axis.fromJson(Map<String, dynamic> json) => Axis(
        domain: json["domain"],
        format: json["format"],
        grid: json["grid"],
        labelAngle: json["labelAngle"]?.toDouble() == null ? null : ((x) => x >= -360 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["labelAngle"]?.toDouble()),
        labelBound: json["labelBound"],
        labelFlush: json["labelFlush"],
        labelOverlap: json["labelOverlap"],
        labelPadding: json["labelPadding"]?.toDouble(),
        labels: json["labels"],
        maxExtent: json["maxExtent"]?.toDouble(),
        minExtent: json["minExtent"]?.toDouble(),
        offset: json["offset"]?.toDouble(),
        orient: json["orient"] == null ? null : titleOrientValues.map[json["orient"]]!,
        position: json["position"]?.toDouble(),
        tickCount: json["tickCount"]?.toDouble(),
        ticks: json["ticks"],
        tickSize: json["tickSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["tickSize"]?.toDouble()),
        title: json["title"],
        titleMaxLength: json["titleMaxLength"]?.toDouble(),
        titlePadding: json["titlePadding"]?.toDouble(),
        values: json["values"] == null ? null : List<dynamic>.from(json["values"]!.map((x) => x)),
        zindex: json["zindex"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["zindex"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "format": format,
        "grid": grid,
        "labelAngle": labelAngle,
        "labelBound": labelBound,
        "labelFlush": labelFlush,
        "labelOverlap": labelOverlap,
        "labelPadding": labelPadding,
        "labels": labels,
        "maxExtent": maxExtent,
        "minExtent": minExtent,
        "offset": offset,
        "orient": titleOrientValues.reverse[orient],
        "position": position,
        "tickCount": tickCount,
        "ticks": ticks,
        "tickSize": tickSize,
        "title": title,
        "titleMaxLength": titleMaxLength,
        "titlePadding": titlePadding,
        "values": values == null ? null : List<dynamic>.from(values!.map((x) => x)),
        "zindex": zindex,
    };
}


///X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
///Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
///Definition object for a data field, its type and transformation of an encoding channel.
///
///Definition object for a constant value of an encoding channel.
class X2Class {
    
    ///Aggregation function for the field
    ///(e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    ///__Default value:__ `undefined` (None)
    final AggregateOp? aggregate;
    
    ///A flag for binning a `quantitative` field, or [an object defining binning
    ///parameters](bin.html#params).
    ///If `true`, default [binning parameters](bin.html) will be applied.
    ///
    ///__Default value:__ `false`
    final dynamic bin;
    
    ///__Required.__ A string defining the name of the field from which to pull a data value
    ///or an object defining iterated values from the [`repeat`](repeat.html) operator.
    ///
    ///__Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    ///(e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    ///If field names contain dots or brackets but are not nested, you can use `\\` to escape
    ///dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
    ///See more details about escaping in the [field documentation](field.html).
    ///
    ///__Note:__ `field` is not required if `aggregate` is `count`.
    final dynamic field;
    
    ///Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    ///or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    ///__Default value:__ `undefined` (None)
    final TimeUnit? timeUnit;
    
    ///The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    ///`"nominal"`).
    ///It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    ///[geographic projection](projection.html) is applied.
    final Type? type;
    
    ///A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    ///`0` to `1` for opacity).
    final dynamic value;

    X2Class({
        this.aggregate,
        this.bin,
        this.field,
        this.timeUnit,
        this.type,
        this.value,
    });

    factory X2Class.fromJson(Map<String, dynamic> json) => X2Class(
        aggregate: json["aggregate"] == null ? null : aggregateOpValues.map[json["aggregate"]]!,
        bin: json["bin"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        type: json["type"] == null ? null : typeValues.map[json["type"]]!,
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "aggregate": aggregateOpValues.reverse[aggregate],
        "bin": bin,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "type": typeValues.reverse[type],
        "value": value,
    };
}


///An object that describes mappings between `row` and `column` channels and their field
///definitions.
class FacetMapping {
    
    ///Horizontal facets for trellis plots.
    final FacetFieldDef? column;
    
    ///Vertical facets for trellis plots.
    final FacetFieldDef? row;

    FacetMapping({
        this.column,
        this.row,
    });

    factory FacetMapping.fromJson(Map<String, dynamic> json) => FacetMapping(
        column: json["column"] == null ? null : FacetFieldDef.fromJson(json["column"]),
        row: json["row"] == null ? null : FacetFieldDef.fromJson(json["row"]),
    );

    Map<String, dynamic> toJson() => {
        "column": column?.toJson(),
        "row": row?.toJson(),
    };
}


///Unit spec that can have a composite mark.
class Spec {
    
    ///An object describing the data source
    final Data? data;
    
    ///Description of this mark for commenting purpose.
    final String? description;
    
    ///The height of a visualization.
    ///
    ///__Default value:__
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    ///[continuous scale](scale.html#continuous), the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the height is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    ///`rangeStep` is `null`, the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    ///__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the height of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? height;
    
    ///Layer or single view specifications to be layered.
    ///
    ///__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    ///layering facet specifications is not allowed.
    final List<LayerSpec>? layer;
    
    ///Name of the visualization for later reference.
    final String? name;
    
    ///Scale, axis, and legend resolutions for layers.
    ///
    ///Scale, axis, and legend resolutions for facets.
    ///
    ///Scale and legend resolutions for repeated charts.
    ///
    ///Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    ///Scale, axis, and legend resolutions for horizontally concatenated charts.
    final Resolve? resolve;
    
    ///Title for the plot.
    final dynamic title;
    
    ///An array of data transformations such as filter and new field calculation.
    final List<Transform>? transform;
    
    ///The width of a visualization.
    ///
    ///__Default value:__ This will be determined by the following rules:
    ///
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    ///[continuous scale](scale.html#continuous), the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the width is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    ///`rangeStep` is `null`, the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- If no field is mapped to `x` channel, the `width` will be the value of
    ///[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    ///the value of `rangeStep` for other marks.
    ///
    ///__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the width of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? width;
    
    ///A key-value mapping between encoding channels and definition of fields.
    final Encoding? encoding;
    
    ///A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    ///`"line"`,
    ///* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    ///object](mark.html#mark-def).
    final dynamic mark;
    
    ///An object defining properties of geographic projection.
    ///
    ///Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    ///more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    final Projection? projection;
    
    ///A key-value mapping between selection names and definitions.
    final Map<String, SelectionDef>? selection;
    
    ///An object that describes mappings between `row` and `column` channels and their field
    ///definitions.
    final FacetMapping? facet;
    
    ///A specification of the view that gets faceted.
    final Spec? spec;
    
    ///An object that describes what fields should be repeated into views that are laid out as a
    ///`row` or `column`.
    final Repeat? repeat;
    
    ///A list of views that should be concatenated and put into a column.
    final List<Spec>? vconcat;
    
    ///A list of views that should be concatenated and put into a row.
    final List<Spec>? hconcat;

    Spec({
        this.data,
        this.description,
        this.height,
        this.layer,
        this.name,
        this.resolve,
        this.title,
        this.transform,
        this.width,
        this.encoding,
        this.mark,
        this.projection,
        this.selection,
        this.facet,
        this.spec,
        this.repeat,
        this.vconcat,
        this.hconcat,
    });

    factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
        height: json["height"]?.toDouble(),
        layer: json["layer"] == null ? null : List<LayerSpec>.from(json["layer"]!.map((x) => LayerSpec.fromJson(x))),
        name: json["name"],
        resolve: json["resolve"] == null ? null : Resolve.fromJson(json["resolve"]),
        title: json["title"],
        transform: json["transform"] == null ? null : List<Transform>.from(json["transform"]!.map((x) => Transform.fromJson(x))),
        width: json["width"]?.toDouble(),
        encoding: json["encoding"] == null ? null : Encoding.fromJson(json["encoding"]),
        mark: json["mark"],
        projection: json["projection"] == null ? null : Projection.fromJson(json["projection"]),
        selection: json["selection"] == null ? null : Map.from(json["selection"]!).map((k, v) => MapEntry<String, SelectionDef>(k, SelectionDef.fromJson(v))),
        facet: json["facet"] == null ? null : FacetMapping.fromJson(json["facet"]),
        spec: json["spec"] == null ? null : Spec.fromJson(json["spec"]),
        repeat: json["repeat"] == null ? null : Repeat.fromJson(json["repeat"]),
        vconcat: json["vconcat"] == null ? null : List<Spec>.from(json["vconcat"]!.map((x) => Spec.fromJson(x))),
        hconcat: json["hconcat"] == null ? null : List<Spec>.from(json["hconcat"]!.map((x) => Spec.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "description": description,
        "height": height,
        "layer": layer == null ? null : List<dynamic>.from(layer!.map((x) => x.toJson())),
        "name": name,
        "resolve": resolve?.toJson(),
        "title": title,
        "transform": transform == null ? null : List<dynamic>.from(transform!.map((x) => x.toJson())),
        "width": width,
        "encoding": encoding?.toJson(),
        "mark": mark,
        "projection": projection?.toJson(),
        "selection": selection == null ? null : Map.from(selection!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "facet": facet?.toJson(),
        "spec": spec?.toJson(),
        "repeat": repeat?.toJson(),
        "vconcat": vconcat == null ? null : List<dynamic>.from(vconcat!.map((x) => x.toJson())),
        "hconcat": hconcat == null ? null : List<dynamic>.from(hconcat!.map((x) => x.toJson())),
    };
}


///A key-value mapping between encoding channels and definition of fields.
class Encoding {
    
    ///Color of the marks – either fill or stroke color based on mark type.
    ///By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    ///`"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    ///__Default value:__ If undefined, the default color depends on [mark
    ///config](config.html#mark)'s `color` property.
    ///
    ///_Note:_ See the scale documentation for more information about customizing [color
    ///scheme](scale.html#scheme).
    final MarkPropDefWithCondition? color;
    
    ///Additional levels of detail for grouping data in aggregate views and
    ///in line and area marks without mapping data to a specific visual channel.
    final dynamic detail;
    
    ///A URL to load upon mouse click.
    final DefWithCondition? href;
    
    ///Opacity of the marks – either can be a value or a range.
    ///
    ///__Default value:__ If undefined, the default opacity depends on [mark
    ///config](config.html#mark)'s `opacity` property.
    final MarkPropDefWithCondition? opacity;
    
    ///Stack order for stacked marks or order of data points in line marks for connected scatter
    ///plots.
    ///
    ///__Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    ///additional aggregation grouping.
    final dynamic order;
    
    ///For `point` marks the supported values are
    ///`"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    ///or `"triangle-down"`, or else a custom SVG path string.
    ///For `geoshape` marks it should be a field definition of the geojson data
    ///
    ///__Default value:__ If undefined, the default shape depends on [mark
    ///config](config.html#point-config)'s `shape` property.
    final MarkPropDefWithCondition? shape;
    
    ///Size of the mark.
    ///- For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    ///- For `"bar"` and `"tick"` – the bar and tick's size.
    ///- For `"text"` – the text's font size.
    ///- Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    final MarkPropDefWithCondition? size;
    
    ///Text of the `text` mark.
    final TextDefWithCondition? text;
    
    ///The tooltip text to show upon mouse hover.
    final TextDefWithCondition? tooltip;
    
    ///X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    final XClass? x;
    
    ///X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    final X2Class? x2;
    
    ///Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    final XClass? y;
    
    ///Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    final X2Class? y2;

    Encoding({
        this.color,
        this.detail,
        this.href,
        this.opacity,
        this.order,
        this.shape,
        this.size,
        this.text,
        this.tooltip,
        this.x,
        this.x2,
        this.y,
        this.y2,
    });

    factory Encoding.fromJson(Map<String, dynamic> json) => Encoding(
        color: json["color"] == null ? null : MarkPropDefWithCondition.fromJson(json["color"]),
        detail: json["detail"],
        href: json["href"] == null ? null : DefWithCondition.fromJson(json["href"]),
        opacity: json["opacity"] == null ? null : MarkPropDefWithCondition.fromJson(json["opacity"]),
        order: json["order"],
        shape: json["shape"] == null ? null : MarkPropDefWithCondition.fromJson(json["shape"]),
        size: json["size"] == null ? null : MarkPropDefWithCondition.fromJson(json["size"]),
        text: json["text"] == null ? null : TextDefWithCondition.fromJson(json["text"]),
        tooltip: json["tooltip"] == null ? null : TextDefWithCondition.fromJson(json["tooltip"]),
        x: json["x"] == null ? null : XClass.fromJson(json["x"]),
        x2: json["x2"] == null ? null : X2Class.fromJson(json["x2"]),
        y: json["y"] == null ? null : XClass.fromJson(json["y"]),
        y2: json["y2"] == null ? null : X2Class.fromJson(json["y2"]),
    );

    Map<String, dynamic> toJson() => {
        "color": color?.toJson(),
        "detail": detail,
        "href": href?.toJson(),
        "opacity": opacity?.toJson(),
        "order": order,
        "shape": shape?.toJson(),
        "size": size?.toJson(),
        "text": text?.toJson(),
        "tooltip": tooltip?.toJson(),
        "x": x?.toJson(),
        "x2": x2?.toJson(),
        "y": y?.toJson(),
        "y2": y2?.toJson(),
    };
}


///Unit spec that can have a composite mark.
class LayerSpec {
    
    ///An object describing the data source
    final Data? data;
    
    ///Description of this mark for commenting purpose.
    final String? description;
    
    ///The height of a visualization.
    ///
    ///__Default value:__
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    ///[continuous scale](scale.html#continuous), the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the height is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    ///`rangeStep` is `null`, the height will be the value of
    ///[`config.view.height`](spec.html#config).
    ///- If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    ///
    ///__Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the height of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? height;
    
    ///Layer or single view specifications to be layered.
    ///
    ///__Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    ///layering facet specifications is not allowed.
    final List<LayerSpec>? layer;
    
    ///Name of the visualization for later reference.
    final String? name;
    
    ///Scale, axis, and legend resolutions for layers.
    final Resolve? resolve;
    
    ///Title for the plot.
    final dynamic title;
    
    ///An array of data transformations such as filter and new field calculation.
    final List<Transform>? transform;
    
    ///The width of a visualization.
    ///
    ///__Default value:__ This will be determined by the following rules:
    ///
    ///- If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    ///[continuous scale](scale.html#continuous), the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    ///value or unspecified, the width is [determined by the range step, paddings, and the
    ///cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    ///`rangeStep` is `null`, the width will be the value of
    ///[`config.view.width`](spec.html#config).
    ///- If no field is mapped to `x` channel, the `width` will be the value of
    ///[`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    ///the value of `rangeStep` for other marks.
    ///
    ///__Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    ///represents the width of a single view.
    ///
    ///__See also:__ The documentation for [width and height](size.html) contains more examples.
    final double? width;
    
    ///A key-value mapping between encoding channels and definition of fields.
    final Encoding? encoding;
    
    ///A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    ///`"line"`,
    ///* `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    ///object](mark.html#mark-def).
    final dynamic mark;
    
    ///An object defining properties of geographic projection.
    ///
    ///Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    ///more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    final Projection? projection;
    
    ///A key-value mapping between selection names and definitions.
    final Map<String, SelectionDef>? selection;

    LayerSpec({
        this.data,
        this.description,
        this.height,
        this.layer,
        this.name,
        this.resolve,
        this.title,
        this.transform,
        this.width,
        this.encoding,
        this.mark,
        this.projection,
        this.selection,
    });

    factory LayerSpec.fromJson(Map<String, dynamic> json) => LayerSpec(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
        height: json["height"]?.toDouble(),
        layer: json["layer"] == null ? null : List<LayerSpec>.from(json["layer"]!.map((x) => LayerSpec.fromJson(x))),
        name: json["name"],
        resolve: json["resolve"] == null ? null : Resolve.fromJson(json["resolve"]),
        title: json["title"],
        transform: json["transform"] == null ? null : List<Transform>.from(json["transform"]!.map((x) => Transform.fromJson(x))),
        width: json["width"]?.toDouble(),
        encoding: json["encoding"] == null ? null : Encoding.fromJson(json["encoding"]),
        mark: json["mark"],
        projection: json["projection"] == null ? null : Projection.fromJson(json["projection"]),
        selection: json["selection"] == null ? null : Map.from(json["selection"]!).map((k, v) => MapEntry<String, SelectionDef>(k, SelectionDef.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "description": description,
        "height": height,
        "layer": layer == null ? null : List<dynamic>.from(layer!.map((x) => x.toJson())),
        "name": name,
        "resolve": resolve?.toJson(),
        "title": title,
        "transform": transform == null ? null : List<dynamic>.from(transform!.map((x) => x.toJson())),
        "width": width,
        "encoding": encoding?.toJson(),
        "mark": mark,
        "projection": projection?.toJson(),
        "selection": selection == null ? null : Map.from(selection!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class MarkDef {
    
    ///The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    final HorizontalAlign? align;
    
    ///The rotation angle of the text, in degrees.
    final double? angle;
    
    ///The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    ///__Default value:__ `"middle"`
    final VerticalAlign? baseline;
    
    ///Whether a mark be clipped to the enclosing group’s width and height.
    final bool? clip;
    
    ///Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    ///will override `color`.
    ///
    ///__Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final String? color;
    
    ///The mouse cursor used over the mark. Any valid [CSS cursor
    ///type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    final Cursor? cursor;
    
    ///The horizontal offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dx;
    
    ///The vertical offset, in pixels, between the text label and its anchor point. The offset
    ///is applied after rotation by the _angle_ property.
    final double? dy;
    
    ///Default Fill Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? fill;
    
    ///Whether the mark's color should be used as fill color instead of stroke color.
    ///
    ///__Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    ///__Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    ///__Note:__ This property cannot be used in a [style config](mark.html#style-config).
    final bool? filled;
    
    ///The fill opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? fillOpacity;
    
    ///The typeface to set the text in (e.g., `"Helvetica Neue"`).
    final String? font;
    
    ///The font size, in pixels.
    final double? fontSize;
    
    ///The font style (e.g., `"italic"`).
    final FontStyle? fontStyle;
    
    ///The font weight (e.g., `"bold"`).
    final dynamic fontWeight;
    
    ///A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    final String? href;
    
    ///The line interpolation method to use for line and area marks. One of the following:
    ///- `"linear"`: piecewise linear segments, as in a polyline.
    ///- `"linear-closed"`: close the linear segments to form a polygon.
    ///- `"step"`: alternate between horizontal and vertical segments, as in a step function.
    ///- `"step-before"`: alternate between vertical and horizontal segments, as in a step
    ///function.
    ///- `"step-after"`: alternate between horizontal and vertical segments, as in a step
    ///function.
    ///- `"basis"`: a B-spline, with control point duplication on the ends.
    ///- `"basis-open"`: an open B-spline; may not intersect the start or end.
    ///- `"basis-closed"`: a closed B-spline, as in a loop.
    ///- `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    ///- `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    ///will intersect other control points.
    ///- `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    ///- `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    ///spline.
    ///- `"monotone"`: cubic interpolation that preserves monotonicity in y.
    final Interpolate? interpolate;
    
    ///The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    ///value will be automatically truncated if the rendered size exceeds the limit.
    final double? limit;
    
    ///The overall opacity (value between [0,1]).
    ///
    ///__Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    ///`square` marks or layered `bar` charts and `1` otherwise.
    final double? opacity;
    
    ///The orientation of a non-stacked bar, tick, area, and line charts.
    ///The value is either horizontal (default) or vertical.
    ///- For bar, rule and tick, this determines whether the size of the bar and tick
    ///should be applied to x or y dimension.
    ///- For area, this property determines the orient property of the Vega output.
    ///- For line, this property determines the sort order of the points in the line
    ///if `config.sortLineBy` is not specified.
    ///For stacked charts, this is always determined by the orientation of the stack;
    ///therefore explicitly specified value will be ignored.
    final Orient? orient;
    
    ///Polar coordinate radial offset, in pixels, of the text label from the origin determined
    ///by the `x` and `y` properties.
    final double? radius;
    
    ///The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    ///`"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    ///__Default value:__ `"circle"`
    final String? shape;
    
    ///The pixel area each the point/circle/square.
    ///For example: in the case of circles, the radius is determined in part by the square root
    ///of the size value.
    ///
    ///__Default value:__ `30`
    final double? size;
    
    ///Default Stroke Color.  This has higher precedence than config.color
    ///
    ///__Default value:__ (None)
    final String? stroke;
    
    ///An array of alternating stroke, space lengths for creating dashed or dotted lines.
    final List<double>? strokeDash;
    
    ///The offset (in pixels) into which to begin drawing with the stroke dash array.
    final double? strokeDashOffset;
    
    ///The stroke opacity (value between [0,1]).
    ///
    ///__Default value:__ `1`
    final double? strokeOpacity;
    
    ///The stroke width, in pixels.
    final double? strokeWidth;
    
    ///A string or array of strings indicating the name of custom styles to apply to the mark. A
    ///style is a named collection of mark property defaults defined within the [style
    ///configuration](mark.html#style-config). If style is an array, later styles will override
    ///earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
    ///the `encoding` will override a style default.
    ///
    ///__Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
    ///default.
    ///__Note:__ Any specified style will augment the default style. For example, a bar mark
    ///with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
    ///specified style `"foo"` has higher precedence).
    final dynamic style;
    
    ///Depending on the interpolation type, sets the tension parameter (for line and area marks).
    final double? tension;
    
    ///Placeholder text if the `text` channel is not specified
    final String? text;
    
    ///Polar coordinate angle, in radians, of the text label from the origin determined by the
    ///`x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    ///`startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    ///indicating "north".
    final double? theta;
    
    ///The mark type.
    ///One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
    ///`"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
    final Mark type;

    MarkDef({
        this.align,
        this.angle,
        this.baseline,
        this.clip,
        this.color,
        this.cursor,
        this.dx,
        this.dy,
        this.fill,
        this.filled,
        this.fillOpacity,
        this.font,
        this.fontSize,
        this.fontStyle,
        this.fontWeight,
        this.href,
        this.interpolate,
        this.limit,
        this.opacity,
        this.orient,
        this.radius,
        this.shape,
        this.size,
        this.stroke,
        this.strokeDash,
        this.strokeDashOffset,
        this.strokeOpacity,
        this.strokeWidth,
        this.style,
        this.tension,
        this.text,
        this.theta,
        required this.type,
    });

    factory MarkDef.fromJson(Map<String, dynamic> json) => MarkDef(
        align: json["align"] == null ? null : horizontalAlignValues.map[json["align"]]!,
        angle: json["angle"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 360 ? x : throw FormatException("Expected bounded number"))(json["angle"]?.toDouble()),
        baseline: json["baseline"] == null ? null : verticalAlignValues.map[json["baseline"]]!,
        clip: json["clip"],
        color: json["color"],
        cursor: json["cursor"] == null ? null : cursorValues.map[json["cursor"]]!,
        dx: json["dx"]?.toDouble(),
        dy: json["dy"]?.toDouble(),
        fill: json["fill"],
        filled: json["filled"],
        fillOpacity: json["fillOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["fillOpacity"]?.toDouble()),
        font: json["font"],
        fontSize: json["fontSize"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["fontSize"]?.toDouble()),
        fontStyle: json["fontStyle"] == null ? null : fontStyleValues.map[json["fontStyle"]]!,
        fontWeight: json["fontWeight"],
        href: json["href"],
        interpolate: json["interpolate"] == null ? null : interpolateValues.map[json["interpolate"]]!,
        limit: json["limit"]?.toDouble(),
        opacity: json["opacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["opacity"]?.toDouble()),
        orient: json["orient"] == null ? null : orientValues.map[json["orient"]]!,
        radius: json["radius"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["radius"]?.toDouble()),
        shape: json["shape"],
        size: json["size"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["size"]?.toDouble()),
        stroke: json["stroke"],
        strokeDash: json["strokeDash"] == null ? null : List<double>.from(json["strokeDash"]!.map((x) => x?.toDouble())),
        strokeDashOffset: json["strokeDashOffset"]?.toDouble(),
        strokeOpacity: json["strokeOpacity"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["strokeOpacity"]?.toDouble()),
        strokeWidth: json["strokeWidth"]?.toDouble() == null ? null : ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["strokeWidth"]?.toDouble()),
        style: json["style"],
        tension: json["tension"]?.toDouble() == null ? null : ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["tension"]?.toDouble()),
        text: json["text"],
        theta: json["theta"]?.toDouble(),
        type: markValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "align": horizontalAlignValues.reverse[align],
        "angle": angle,
        "baseline": verticalAlignValues.reverse[baseline],
        "clip": clip,
        "color": color,
        "cursor": cursorValues.reverse[cursor],
        "dx": dx,
        "dy": dy,
        "fill": fill,
        "filled": filled,
        "fillOpacity": fillOpacity,
        "font": font,
        "fontSize": fontSize,
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "href": href,
        "interpolate": interpolateValues.reverse[interpolate],
        "limit": limit,
        "opacity": opacity,
        "orient": orientValues.reverse[orient],
        "radius": radius,
        "shape": shape,
        "size": size,
        "stroke": stroke,
        "strokeDash": strokeDash == null ? null : List<dynamic>.from(strokeDash!.map((x) => x)),
        "strokeDashOffset": strokeDashOffset,
        "strokeOpacity": strokeOpacity,
        "strokeWidth": strokeWidth,
        "style": style,
        "tension": tension,
        "text": text,
        "theta": theta,
        "type": markValues.reverse[type],
    };
}


///All types of primitive marks.
///
///The mark type.
///One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
///`"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
enum Mark {
    AREA,
    BAR,
    LINE,
    POINT,
    TEXT,
    TICK,
    RECT,
    RULE,
    CIRCLE,
    SQUARE,
    GEOSHAPE
}

final markValues = EnumValues({
    "area": Mark.AREA,
    "bar": Mark.BAR,
    "line": Mark.LINE,
    "point": Mark.POINT,
    "text": Mark.TEXT,
    "tick": Mark.TICK,
    "rect": Mark.RECT,
    "rule": Mark.RULE,
    "circle": Mark.CIRCLE,
    "square": Mark.SQUARE,
    "geoshape": Mark.GEOSHAPE
});


///An object defining properties of geographic projection.
///
///Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
///more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
class Projection {
    
    ///Sets the projection’s center to the specified center, a two-element array of longitude
    ///and latitude in degrees.
    ///
    ///__Default value:__ `[0, 0]`
    final List<double>? center;
    
    ///Sets the projection’s clipping circle radius to the specified angle in degrees. If
    ///`null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    ///than small-circle clipping.
    final double? clipAngle;
    
    ///Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    ///bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    ///the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    ///viewport clipping is performed.
    final List<List<double>>? clipExtent;
    final double? coefficient;
    final double? distance;
    final double? fraction;
    final double? lobes;
    final double? parallel;
    
    ///Sets the threshold for the projection’s [adaptive
    ///resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    ///value corresponds to the [Douglas–Peucker
    ///distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    ///If precision is not specified, returns the projection’s current resampling precision
    ///which defaults to `√0.5 ≅ 0.70710…`.
    final Map<String, dynamic>? precision;
    final double? radius;
    final double? ratio;
    
    ///Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    ///or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    ///angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    ///__Default value:__ `[0, 0, 0]`
    final List<double>? rotate;
    final double? spacing;
    final double? tilt;
    
    ///The cartographic projection to use. This value is case-insensitive, for example
    ///`"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    ///projection types [in the
    ///documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    ///__Default value:__ `mercator`
    final VgProjectionType? type;

    Projection({
        this.center,
        this.clipAngle,
        this.clipExtent,
        this.coefficient,
        this.distance,
        this.fraction,
        this.lobes,
        this.parallel,
        this.precision,
        this.radius,
        this.ratio,
        this.rotate,
        this.spacing,
        this.tilt,
        this.type,
    });

    factory Projection.fromJson(Map<String, dynamic> json) => Projection(
        center: json["center"] == null ? null : List<double>.from(json["center"]!.map((x) => x?.toDouble())),
        clipAngle: json["clipAngle"]?.toDouble(),
        clipExtent: json["clipExtent"] == null ? null : List<List<double>>.from(json["clipExtent"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        coefficient: json["coefficient"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        fraction: json["fraction"]?.toDouble(),
        lobes: json["lobes"]?.toDouble(),
        parallel: json["parallel"]?.toDouble(),
        precision: json["precision"] == null ? null : Map.from(json["precision"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        radius: json["radius"]?.toDouble(),
        ratio: json["ratio"]?.toDouble(),
        rotate: json["rotate"] == null ? null : List<double>.from(json["rotate"]!.map((x) => x?.toDouble())),
        spacing: json["spacing"]?.toDouble(),
        tilt: json["tilt"]?.toDouble(),
        type: json["type"] == null ? null : vgProjectionTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "center": center == null ? null : List<dynamic>.from(center!.map((x) => x)),
        "clipAngle": clipAngle,
        "clipExtent": clipExtent == null ? null : List<dynamic>.from(clipExtent!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "coefficient": coefficient,
        "distance": distance,
        "fraction": fraction,
        "lobes": lobes,
        "parallel": parallel,
        "precision": precision == null ? null : Map.from(precision!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "radius": radius,
        "ratio": ratio,
        "rotate": rotate == null ? null : List<dynamic>.from(rotate!.map((x) => x)),
        "spacing": spacing,
        "tilt": tilt,
        "type": vgProjectionTypeValues.reverse[type],
    };
}


///Scale, axis, and legend resolutions for layers.
///
///Defines how scales, axes, and legends from different specs should be combined. Resolve is
///a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
///
///Scale, axis, and legend resolutions for facets.
///
///Scale and legend resolutions for repeated charts.
///
///Scale, axis, and legend resolutions for vertically concatenated charts.
///
///Scale, axis, and legend resolutions for horizontally concatenated charts.
class Resolve {
    final AxisResolveMap? axis;
    final LegendResolveMap? legend;
    final ScaleResolveMap? scale;

    Resolve({
        this.axis,
        this.legend,
        this.scale,
    });

    factory Resolve.fromJson(Map<String, dynamic> json) => Resolve(
        axis: json["axis"] == null ? null : AxisResolveMap.fromJson(json["axis"]),
        legend: json["legend"] == null ? null : LegendResolveMap.fromJson(json["legend"]),
        scale: json["scale"] == null ? null : ScaleResolveMap.fromJson(json["scale"]),
    );

    Map<String, dynamic> toJson() => {
        "axis": axis?.toJson(),
        "legend": legend?.toJson(),
        "scale": scale?.toJson(),
    };
}

class AxisResolveMap {
    final ResolveMode? x;
    final ResolveMode? y;

    AxisResolveMap({
        this.x,
        this.y,
    });

    factory AxisResolveMap.fromJson(Map<String, dynamic> json) => AxisResolveMap(
        x: json["x"] == null ? null : resolveModeValues.map[json["x"]]!,
        y: json["y"] == null ? null : resolveModeValues.map[json["y"]]!,
    );

    Map<String, dynamic> toJson() => {
        "x": resolveModeValues.reverse[x],
        "y": resolveModeValues.reverse[y],
    };
}

enum ResolveMode {
    INDEPENDENT,
    SHARED
}

final resolveModeValues = EnumValues({
    "independent": ResolveMode.INDEPENDENT,
    "shared": ResolveMode.SHARED
});

class LegendResolveMap {
    final ResolveMode? color;
    final ResolveMode? opacity;
    final ResolveMode? shape;
    final ResolveMode? size;

    LegendResolveMap({
        this.color,
        this.opacity,
        this.shape,
        this.size,
    });

    factory LegendResolveMap.fromJson(Map<String, dynamic> json) => LegendResolveMap(
        color: json["color"] == null ? null : resolveModeValues.map[json["color"]]!,
        opacity: json["opacity"] == null ? null : resolveModeValues.map[json["opacity"]]!,
        shape: json["shape"] == null ? null : resolveModeValues.map[json["shape"]]!,
        size: json["size"] == null ? null : resolveModeValues.map[json["size"]]!,
    );

    Map<String, dynamic> toJson() => {
        "color": resolveModeValues.reverse[color],
        "opacity": resolveModeValues.reverse[opacity],
        "shape": resolveModeValues.reverse[shape],
        "size": resolveModeValues.reverse[size],
    };
}

class ScaleResolveMap {
    final ResolveMode? color;
    final ResolveMode? opacity;
    final ResolveMode? shape;
    final ResolveMode? size;
    final ResolveMode? x;
    final ResolveMode? y;

    ScaleResolveMap({
        this.color,
        this.opacity,
        this.shape,
        this.size,
        this.x,
        this.y,
    });

    factory ScaleResolveMap.fromJson(Map<String, dynamic> json) => ScaleResolveMap(
        color: json["color"] == null ? null : resolveModeValues.map[json["color"]]!,
        opacity: json["opacity"] == null ? null : resolveModeValues.map[json["opacity"]]!,
        shape: json["shape"] == null ? null : resolveModeValues.map[json["shape"]]!,
        size: json["size"] == null ? null : resolveModeValues.map[json["size"]]!,
        x: json["x"] == null ? null : resolveModeValues.map[json["x"]]!,
        y: json["y"] == null ? null : resolveModeValues.map[json["y"]]!,
    );

    Map<String, dynamic> toJson() => {
        "color": resolveModeValues.reverse[color],
        "opacity": resolveModeValues.reverse[opacity],
        "shape": resolveModeValues.reverse[shape],
        "size": resolveModeValues.reverse[size],
        "x": resolveModeValues.reverse[x],
        "y": resolveModeValues.reverse[y],
    };
}

class SelectionDef {
    
    ///Establish a two-way binding between a single selection and input elements
    ///(also known as dynamic query widgets). A binding takes the form of
    ///Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    ///or can be a mapping between projected field/encodings and binding definitions.
    ///
    ///See the [bind transform](bind.html) documentation for more information.
    ///
    ///Establishes a two-way binding between the interval selection and the scales
    ///used within the same view. This allows a user to interactively pan and
    ///zoom the view.
    final dynamic bind;
    
    ///By default, all data values are considered to lie within an empty selection.
    ///When set to `none`, empty selections contain no data values.
    final Empty? empty;
    
    ///An array of encoding channels. The corresponding data field values
    ///must match for a data tuple to fall within the selection.
    final List<SingleDefChannel>? encodings;
    
    ///An array of field names whose values must match for a data tuple to
    ///fall within the selection.
    final List<String>? fields;
    
    ///When true, an invisible voronoi diagram is computed to accelerate discrete
    ///selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    ///See the [nearest transform](nearest.html) documentation for more information.
    final bool? nearest;
    
    ///A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    ///selector) that triggers the selection.
    ///For interval selections, the event stream must specify a [start and
    ///end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    final dynamic on;
    
    ///With layered and multi-view displays, a strategy that determines how
    ///selections' data queries are resolved when applied in a filter transform,
    ///conditional encoding rule, or scale domain.
    final SelectionResolution? resolve;
    final SelectionDefType type;
    
    ///Controls whether data values should be toggled or only ever inserted into
    ///multi selections. Can be `true`, `false` (for insertion only), or a
    ///[Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    ///__Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    ///data values are toggled when a user interacts with the shift-key pressed).
    ///
    ///See the [toggle transform](toggle.html) documentation for more information.
    final dynamic toggle;
    
    ///An interval selection also adds a rectangle mark to depict the
    ///extents of the interval. The `mark` property can be used to customize the
    ///appearance of the mark.
    final BrushConfig? mark;
    
    ///When truthy, allows a user to interactively move an interval selection
    ///back-and-forth. Can be `true`, `false` (to disable panning), or a
    ///[Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    ///which must include a start and end event to trigger continuous panning.
    ///
    ///__Default value:__ `true`, which corresponds to
    ///`[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    ///clicks and dragging within an interval selection to reposition it.
    final dynamic translate;
    
    ///When truthy, allows a user to interactively resize an interval selection.
    ///Can be `true`, `false` (to disable zooming), or a [Vega event stream
    ///definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    ///only `wheel` events are supported.
    ///
    ///
    ///__Default value:__ `true`, which corresponds to `wheel!`.
    final dynamic zoom;

    SelectionDef({
        this.bind,
        this.empty,
        this.encodings,
        this.fields,
        this.nearest,
        this.on,
        this.resolve,
        required this.type,
        this.toggle,
        this.mark,
        this.translate,
        this.zoom,
    });

    factory SelectionDef.fromJson(Map<String, dynamic> json) => SelectionDef(
        bind: json["bind"],
        empty: json["empty"] == null ? null : emptyValues.map[json["empty"]]!,
        encodings: json["encodings"] == null ? null : List<SingleDefChannel>.from(json["encodings"]!.map((x) => singleDefChannelValues.map[x]!)),
        fields: json["fields"] == null ? null : List<String>.from(json["fields"]!.map((x) => x)),
        nearest: json["nearest"],
        on: json["on"],
        resolve: json["resolve"] == null ? null : selectionResolutionValues.map[json["resolve"]]!,
        type: selectionDefTypeValues.map[json["type"]]!,
        toggle: json["toggle"],
        mark: json["mark"] == null ? null : BrushConfig.fromJson(json["mark"]),
        translate: json["translate"],
        zoom: json["zoom"],
    );

    Map<String, dynamic> toJson() => {
        "bind": bind,
        "empty": emptyValues.reverse[empty],
        "encodings": encodings == null ? null : List<dynamic>.from(encodings!.map((x) => singleDefChannelValues.reverse[x])),
        "fields": fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "nearest": nearest,
        "on": on,
        "resolve": selectionResolutionValues.reverse[resolve],
        "type": selectionDefTypeValues.reverse[type],
        "toggle": toggle,
        "mark": mark?.toJson(),
        "translate": translate,
        "zoom": zoom,
    };
}

enum SelectionDefType {
    SINGLE,
    MULTI,
    INTERVAL
}

final selectionDefTypeValues = EnumValues({
    "single": SelectionDefType.SINGLE,
    "multi": SelectionDefType.MULTI,
    "interval": SelectionDefType.INTERVAL
});

class TitleParams {
    
    ///The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    ///example, with an orientation of top these anchor positions map to a left-, center-, or
    ///right-aligned title.
    ///
    ///__Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    ///`"start"` for other composite views.
    ///
    ///__Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    ///customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    ///composite views, `anchor` is always `"start"`.
    final Anchor? anchor;
    
    ///The orthogonal offset in pixels by which to displace the title from its position along
    ///the edge of the chart.
    final double? offset;
    
    ///The orientation of the title relative to the chart. One of `"top"` (the default),
    ///`"bottom"`, `"left"`, or `"right"`.
    final TitleOrient? orient;
    
    ///A [mark style property](config.html#style) to apply to the title text mark.
    ///
    ///__Default value:__ `"group-title"`.
    final dynamic style;
    
    ///The title text.
    final String text;

    TitleParams({
        this.anchor,
        this.offset,
        this.orient,
        this.style,
        required this.text,
    });

    factory TitleParams.fromJson(Map<String, dynamic> json) => TitleParams(
        anchor: json["anchor"] == null ? null : anchorValues.map[json["anchor"]]!,
        offset: json["offset"]?.toDouble(),
        orient: json["orient"] == null ? null : titleOrientValues.map[json["orient"]]!,
        style: json["style"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "anchor": anchorValues.reverse[anchor],
        "offset": offset,
        "orient": titleOrientValues.reverse[orient],
        "style": style,
        "text": text,
    };
}

class Transform {
    
    ///The `filter` property must be one of the predicate definitions:
    ///(1) an [expression](types.html#expression) string,
    ///where `datum` can be used to refer to the current data object;
    ///(2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
    ///[range predicate](filter.html#range-predicate), [one-of
    ///predicate](filter.html#one-of-predicate);
    ///(3) a [selection predicate](filter.html#selection-predicate);
    ///or (4) a logical operand that combines (1), (2), or (3).
    final dynamic filter;
    
    ///The field for storing the computed formula value.
    ///
    ///The field or fields for storing the computed formula value.
    ///If `from.fields` is specified, the transform will use the same names for `as`.
    ///If `from.fields` is not specified, `as` has to be a string and we put the whole object
    ///into the data under the specified name.
    ///
    ///The output fields at which to write the start and end bin values.
    ///
    ///The output field to write the timeUnit value.
    final dynamic transformAs;
    
    ///A [expression](types.html#expression) string. Use the variable `datum` to refer to the
    ///current data object.
    final String? calculate;
    
    ///The default value to use if lookup fails.
    ///
    ///__Default value:__ `null`
    final String? transformDefault;
    
    ///Secondary data reference.
    final LookupData? from;
    
    ///Key in primary data source.
    final String? lookup;
    
    ///An object indicating bin properties, or simply `true` for using default bin parameters.
    final dynamic bin;
    
    ///The data field to bin.
    ///
    ///The data field to apply time unit.
    final String? field;
    
    ///The timeUnit.
    final TimeUnit? timeUnit;
    
    ///Array of objects that define fields to aggregate.
    final List<AggregatedFieldDef>? aggregate;
    
    ///The data fields to group by. If not specified, a single group containing all data objects
    ///will be used.
    final List<String>? groupby;

    Transform({
        this.filter,
        this.transformAs,
        this.calculate,
        this.transformDefault,
        this.from,
        this.lookup,
        this.bin,
        this.field,
        this.timeUnit,
        this.aggregate,
        this.groupby,
    });

    factory Transform.fromJson(Map<String, dynamic> json) => Transform(
        filter: json["filter"],
        transformAs: json["as"],
        calculate: json["calculate"],
        transformDefault: json["default"],
        from: json["from"] == null ? null : LookupData.fromJson(json["from"]),
        lookup: json["lookup"],
        bin: json["bin"],
        field: json["field"],
        timeUnit: json["timeUnit"] == null ? null : timeUnitValues.map[json["timeUnit"]]!,
        aggregate: json["aggregate"] == null ? null : List<AggregatedFieldDef>.from(json["aggregate"]!.map((x) => AggregatedFieldDef.fromJson(x))),
        groupby: json["groupby"] == null ? null : List<String>.from(json["groupby"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "filter": filter,
        "as": transformAs,
        "calculate": calculate,
        "default": transformDefault,
        "from": from?.toJson(),
        "lookup": lookup,
        "bin": bin,
        "field": field,
        "timeUnit": timeUnitValues.reverse[timeUnit],
        "aggregate": aggregate == null ? null : List<dynamic>.from(aggregate!.map((x) => x.toJson())),
        "groupby": groupby == null ? null : List<dynamic>.from(groupby!.map((x) => x)),
    };
}

class AggregatedFieldDef {
    
    ///The output field names to use for each aggregated field.
    final String aggregatedFieldDefAs;
    
    ///The data field for which to compute aggregate function.
    final String field;
    
    ///The aggregation operations to apply to the fields, such as sum, average or count.
    ///See the [full list of supported aggregation
    ///operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
    ///for more information.
    final AggregateOp op;

    AggregatedFieldDef({
        required this.aggregatedFieldDefAs,
        required this.field,
        required this.op,
    });

    factory AggregatedFieldDef.fromJson(Map<String, dynamic> json) => AggregatedFieldDef(
        aggregatedFieldDefAs: json["as"],
        field: json["field"],
        op: aggregateOpValues.map[json["op"]]!,
    );

    Map<String, dynamic> toJson() => {
        "as": aggregatedFieldDefAs,
        "field": field,
        "op": aggregateOpValues.reverse[op],
    };
}


///Secondary data reference.
class LookupData {
    
    ///Secondary data source to lookup in.
    final Data data;
    
    ///Fields in foreign data to lookup.
    ///If not specified, the entire object is queried.
    final List<String>? fields;
    
    ///Key in data to lookup.
    final String key;

    LookupData({
        required this.data,
        this.fields,
        required this.key,
    });

    factory LookupData.fromJson(Map<String, dynamic> json) => LookupData(
        data: Data.fromJson(json["data"]),
        fields: json["fields"] == null ? null : List<String>.from(json["fields"]!.map((x) => x)),
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "fields": fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
        "key": key,
    };
}


///An object that describes what fields should be repeated into views that are laid out as a
///`row` or `column`.
class Repeat {
    
    ///Horizontal repeated views.
    final List<String>? column;
    
    ///Vertical repeated views.
    final List<String>? row;

    Repeat({
        this.column,
        this.row,
    });

    factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
        column: json["column"] == null ? null : List<String>.from(json["column"]!.map((x) => x)),
        row: json["row"] == null ? null : List<String>.from(json["row"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "column": column == null ? null : List<dynamic>.from(column!.map((x) => x)),
        "row": row == null ? null : List<dynamic>.from(row!.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
