// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    /// URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
    /// have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
    /// Setting the `$schema` property allows automatic validation and autocomplete in editors
    /// that support JSON schema.
    let schema: String?
    /// Sets how the visualization size should be determined. If a string, should be one of
    /// `"pad"`, `"fit"` or `"none"`.
    /// Object values can additionally specify parameters for content sizing and automatic
    /// resizing.
    /// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    /// __Default value__: `pad`
    let autosize: Autosize?
    /// CSS color property to use as the background of visualization.
    ///
    /// __Default value:__ none (transparent)
    let background: String?
    /// Vega-Lite configuration object.  This property can only be defined at the top-level of a
    /// specification.
    let config: Config?
    /// An object describing the data source
    let data: DataClass?
    /// Description of this mark for commenting purpose.
    let description: String?
    /// A key-value mapping between encoding channels and definition of fields.
    let encoding: EncodingWithFacet?
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
    let height: Double?
    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    let mark: AnyMark?
    /// Name of the visualization for later reference.
    let name: String?
    /// The default visualization padding, in pixels, from the edge of the visualization canvas
    /// to the data rectangle.  If a number, specifies padding for all sides.
    /// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    /// "bottom": 5}` to specify padding for each side of the visualization.
    ///
    /// __Default value__: `5`
    let padding: Padding?
    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    let projection: Projection?
    /// A key-value mapping between selection names and definitions.
    let selection: [String: SelectionDef]?
    /// Title for the plot.
    let title: Title?
    /// An array of data transformations such as filter and new field calculation.
    let transform: [Transform]?
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
    let width: Double?
    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    let layer: [LayerSpec]?
    /// Scale, axis, and legend resolutions for layers.
    ///
    /// Scale, axis, and legend resolutions for facets.
    ///
    /// Scale and legend resolutions for repeated charts.
    ///
    /// Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    /// Scale, axis, and legend resolutions for horizontally concatenated charts.
    let resolve: Resolve?
    /// An object that describes mappings between `row` and `column` channels and their field
    /// definitions.
    let facet: FacetMapping?
    /// A specification of the view that gets faceted.
    let spec: Spec?
    /// An object that describes what fields should be repeated into views that are laid out as a
    /// `row` or `column`.
    let topLevelRepeat: Repeat?
    /// A list of views that should be concatenated and put into a column.
    let vconcat: [Spec]?
    /// A list of views that should be concatenated and put into a row.
    let hconcat: [Spec]?

    enum CodingKeys: String, CodingKey {
        case schema = "$schema"
        case autosize = "autosize"
        case background = "background"
        case config = "config"
        case data = "data"
        case description = "description"
        case encoding = "encoding"
        case height = "height"
        case mark = "mark"
        case name = "name"
        case padding = "padding"
        case projection = "projection"
        case selection = "selection"
        case title = "title"
        case transform = "transform"
        case width = "width"
        case layer = "layer"
        case resolve = "resolve"
        case facet = "facet"
        case spec = "spec"
        case topLevelRepeat = "repeat"
        case vconcat = "vconcat"
        case hconcat = "hconcat"
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        schema: String?? = nil,
        autosize: Autosize?? = nil,
        background: String?? = nil,
        config: Config?? = nil,
        data: DataClass?? = nil,
        description: String?? = nil,
        encoding: EncodingWithFacet?? = nil,
        height: Double?? = nil,
        mark: AnyMark?? = nil,
        name: String?? = nil,
        padding: Padding?? = nil,
        projection: Projection?? = nil,
        selection: [String: SelectionDef]?? = nil,
        title: Title?? = nil,
        transform: [Transform]?? = nil,
        width: Double?? = nil,
        layer: [LayerSpec]?? = nil,
        resolve: Resolve?? = nil,
        facet: FacetMapping?? = nil,
        spec: Spec?? = nil,
        topLevelRepeat: Repeat?? = nil,
        vconcat: [Spec]?? = nil,
        hconcat: [Spec]?? = nil
    ) -> TopLevel {
        return TopLevel(
            schema: schema ?? self.schema,
            autosize: autosize ?? self.autosize,
            background: background ?? self.background,
            config: config ?? self.config,
            data: data ?? self.data,
            description: description ?? self.description,
            encoding: encoding ?? self.encoding,
            height: height ?? self.height,
            mark: mark ?? self.mark,
            name: name ?? self.name,
            padding: padding ?? self.padding,
            projection: projection ?? self.projection,
            selection: selection ?? self.selection,
            title: title ?? self.title,
            transform: transform ?? self.transform,
            width: width ?? self.width,
            layer: layer ?? self.layer,
            resolve: resolve ?? self.resolve,
            facet: facet ?? self.facet,
            spec: spec ?? self.spec,
            topLevelRepeat: topLevelRepeat ?? self.topLevelRepeat,
            vconcat: vconcat ?? self.vconcat,
            hconcat: hconcat ?? self.hconcat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Sets how the visualization size should be determined. If a string, should be one of
/// `"pad"`, `"fit"` or `"none"`.
/// Object values can additionally specify parameters for content sizing and automatic
/// resizing.
/// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
///
/// __Default value__: `pad`
enum Autosize: Codable {
    case autoSizeParams(AutoSizeParams)
    case enumeration(AutosizeType)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(AutosizeType.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(AutoSizeParams.self) {
            self = .autoSizeParams(x)
            return
        }
        throw DecodingError.typeMismatch(Autosize.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Autosize"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .autoSizeParams(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AutoSizeParams
struct AutoSizeParams: Codable {
    /// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
    /// The default setting (`"content"`) interprets the width and height settings as the data
    /// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
    /// `"padding"` setting includes the padding within the view size calculations, such that the
    /// width and height settings indicate the **total** intended size of the view.
    ///
    /// __Default value__: `"content"`
    let contains: Contains?
    /// A boolean flag indicating if autosize layout should be re-calculated on every view
    /// update.
    ///
    /// __Default value__: `false`
    let resize: Bool?
    /// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
    /// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
    /// descriptions of each.
    ///
    /// __Default value__: `"pad"`
    let type: AutosizeType?

    enum CodingKeys: String, CodingKey {
        case contains = "contains"
        case resize = "resize"
        case type = "type"
    }
}

// MARK: AutoSizeParams convenience initializers and mutators

extension AutoSizeParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AutoSizeParams.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        contains: Contains?? = nil,
        resize: Bool?? = nil,
        type: AutosizeType?? = nil
    ) -> AutoSizeParams {
        return AutoSizeParams(
            contains: contains ?? self.contains,
            resize: resize ?? self.resize,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Determines how size calculation should be performed, one of `"content"` or `"padding"`.
/// The default setting (`"content"`) interprets the width and height settings as the data
/// rectangle (plotting) dimensions, to which padding is then added. In contrast, the
/// `"padding"` setting includes the padding within the view size calculations, such that the
/// width and height settings indicate the **total** intended size of the view.
///
/// __Default value__: `"content"`
enum Contains: String, Codable {
    case content = "content"
    case padding = "padding"
}

/// The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
/// type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
/// descriptions of each.
///
/// __Default value__: `"pad"`
enum AutosizeType: String, Codable {
    case pad = "pad"
    case fit = "fit"
    case none = "none"
}

/// Vega-Lite configuration object.  This property can only be defined at the top-level of a
/// specification.
// MARK: - Config
struct Config: Codable {
    /// Area-Specific Config
    let area: MarkConfig?
    /// Sets how the visualization size should be determined. If a string, should be one of
    /// `"pad"`, `"fit"` or `"none"`.
    /// Object values can additionally specify parameters for content sizing and automatic
    /// resizing.
    /// `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    ///
    /// __Default value__: `pad`
    let autosize: Autosize?
    /// Axis configuration, which determines default properties for all `x` and `y`
    /// [axes](axis.html). For a full list of axis configuration options, please see the
    /// [corresponding section of the axis documentation](axis.html#config).
    let axis: AxisConfig?
    /// Specific axis config for axes with "band" scales.
    let axisBand: VGAxisConfig?
    /// Specific axis config for x-axis along the bottom edge of the chart.
    let axisBottom: VGAxisConfig?
    /// Specific axis config for y-axis along the left edge of the chart.
    let axisLeft: VGAxisConfig?
    /// Specific axis config for y-axis along the right edge of the chart.
    let axisRight: VGAxisConfig?
    /// Specific axis config for x-axis along the top edge of the chart.
    let axisTop: VGAxisConfig?
    /// X-axis specific config.
    let axisX: VGAxisConfig?
    /// Y-axis specific config.
    let axisY: VGAxisConfig?
    /// CSS color property to use as the background of visualization.
    ///
    /// __Default value:__ none (transparent)
    let background: String?
    /// Bar-Specific Config
    let bar: BarConfig?
    /// Circle-Specific Config
    let circle: MarkConfig?
    /// Default axis and legend title for count fields.
    ///
    /// __Default value:__ `'Number of Records'`.
    let countTitle: String?
    /// Defines how Vega-Lite generates title for fields.  There are three possible styles:
    ///
    /// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
    /// "Year-month of date", "field (binned)").
    /// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
    /// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
    /// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
    /// "field").
    let fieldTitle: FieldTitle?
    /// Geoshape-Specific Config
    let geoshape: MarkConfig?
    /// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
    /// - If set to `"filter"` (default), all data items with null values are filtered.
    /// - If `null`, all data items are included. In this case, invalid values will be
    /// interpreted as zeroes.
    let invalidValues: InvalidValues?
    /// Legend configuration, which determines default properties for all [legends](legend.html).
    /// For a full list of legend configuration options, please see the [corresponding section of
    /// in the legend documentation](legend.html#config).
    let legend: LegendConfig?
    /// Line-Specific Config
    let line: MarkConfig?
    /// Mark Config
    let mark: MarkConfig?
    /// D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
    /// number format pattern](https://github.com/d3/d3-format#locale_format).
    let numberFormat: String?
    /// The default visualization padding, in pixels, from the edge of the visualization canvas
    /// to the data rectangle.  If a number, specifies padding for all sides.
    /// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    /// "bottom": 5}` to specify padding for each side of the visualization.
    ///
    /// __Default value__: `5`
    let padding: Padding?
    /// Point-Specific Config
    let point: MarkConfig?
    /// Projection configuration, which determines default properties for all
    /// [projections](projection.html). For a full list of projection configuration options,
    /// please see the [corresponding section of the projection
    /// documentation](projection.html#config).
    let projection: ProjectionConfig?
    /// An object hash that defines default range arrays or schemes for using with scales.
    /// For a full list of scale range configuration options, please see the [corresponding
    /// section of the scale documentation](scale.html#config).
    let range: [String: RangeConfigValue]?
    /// Rect-Specific Config
    let rect: MarkConfig?
    /// Rule-Specific Config
    let rule: MarkConfig?
    /// Scale configuration determines default properties for all [scales](scale.html). For a
    /// full list of scale configuration options, please see the [corresponding section of the
    /// scale documentation](scale.html#config).
    let scale: ScaleConfig?
    /// An object hash for defining default properties for each type of selections.
    let selection: SelectionConfig?
    /// Square-Specific Config
    let square: MarkConfig?
    /// Default stack offset for stackable mark.
    let stack: StackOffset?
    /// An object hash that defines key-value mappings to determine default properties for marks
    /// with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
    /// valid [mark configuration objects](mark.html#config).
    let style: [String: VGMarkConfig]?
    /// Text-Specific Config
    let text: TextConfig?
    /// Tick-Specific Config
    let tick: TickConfig?
    /// Default datetime format for axis and legend labels. The format can be set directly on
    /// each axis and legend. Use [D3's time format
    /// pattern](https://github.com/d3/d3-time-format#locale_format).
    ///
    /// __Default value:__ `'%b %d, %Y'`.
    let timeFormat: String?
    /// Title configuration, which determines default properties for all [titles](title.html).
    /// For a full list of title configuration options, please see the [corresponding section of
    /// the title documentation](title.html#config).
    let title: VGTitleConfig?
    /// Default properties for [single view plots](spec.html#single).
    let view: ViewConfig?

    enum CodingKeys: String, CodingKey {
        case area = "area"
        case autosize = "autosize"
        case axis = "axis"
        case axisBand = "axisBand"
        case axisBottom = "axisBottom"
        case axisLeft = "axisLeft"
        case axisRight = "axisRight"
        case axisTop = "axisTop"
        case axisX = "axisX"
        case axisY = "axisY"
        case background = "background"
        case bar = "bar"
        case circle = "circle"
        case countTitle = "countTitle"
        case fieldTitle = "fieldTitle"
        case geoshape = "geoshape"
        case invalidValues = "invalidValues"
        case legend = "legend"
        case line = "line"
        case mark = "mark"
        case numberFormat = "numberFormat"
        case padding = "padding"
        case point = "point"
        case projection = "projection"
        case range = "range"
        case rect = "rect"
        case rule = "rule"
        case scale = "scale"
        case selection = "selection"
        case square = "square"
        case stack = "stack"
        case style = "style"
        case text = "text"
        case tick = "tick"
        case timeFormat = "timeFormat"
        case title = "title"
        case view = "view"
    }
}

// MARK: Config convenience initializers and mutators

extension Config {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Config.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        area: MarkConfig?? = nil,
        autosize: Autosize?? = nil,
        axis: AxisConfig?? = nil,
        axisBand: VGAxisConfig?? = nil,
        axisBottom: VGAxisConfig?? = nil,
        axisLeft: VGAxisConfig?? = nil,
        axisRight: VGAxisConfig?? = nil,
        axisTop: VGAxisConfig?? = nil,
        axisX: VGAxisConfig?? = nil,
        axisY: VGAxisConfig?? = nil,
        background: String?? = nil,
        bar: BarConfig?? = nil,
        circle: MarkConfig?? = nil,
        countTitle: String?? = nil,
        fieldTitle: FieldTitle?? = nil,
        geoshape: MarkConfig?? = nil,
        invalidValues: InvalidValues?? = nil,
        legend: LegendConfig?? = nil,
        line: MarkConfig?? = nil,
        mark: MarkConfig?? = nil,
        numberFormat: String?? = nil,
        padding: Padding?? = nil,
        point: MarkConfig?? = nil,
        projection: ProjectionConfig?? = nil,
        range: [String: RangeConfigValue]?? = nil,
        rect: MarkConfig?? = nil,
        rule: MarkConfig?? = nil,
        scale: ScaleConfig?? = nil,
        selection: SelectionConfig?? = nil,
        square: MarkConfig?? = nil,
        stack: StackOffset?? = nil,
        style: [String: VGMarkConfig]?? = nil,
        text: TextConfig?? = nil,
        tick: TickConfig?? = nil,
        timeFormat: String?? = nil,
        title: VGTitleConfig?? = nil,
        view: ViewConfig?? = nil
    ) -> Config {
        return Config(
            area: area ?? self.area,
            autosize: autosize ?? self.autosize,
            axis: axis ?? self.axis,
            axisBand: axisBand ?? self.axisBand,
            axisBottom: axisBottom ?? self.axisBottom,
            axisLeft: axisLeft ?? self.axisLeft,
            axisRight: axisRight ?? self.axisRight,
            axisTop: axisTop ?? self.axisTop,
            axisX: axisX ?? self.axisX,
            axisY: axisY ?? self.axisY,
            background: background ?? self.background,
            bar: bar ?? self.bar,
            circle: circle ?? self.circle,
            countTitle: countTitle ?? self.countTitle,
            fieldTitle: fieldTitle ?? self.fieldTitle,
            geoshape: geoshape ?? self.geoshape,
            invalidValues: invalidValues ?? self.invalidValues,
            legend: legend ?? self.legend,
            line: line ?? self.line,
            mark: mark ?? self.mark,
            numberFormat: numberFormat ?? self.numberFormat,
            padding: padding ?? self.padding,
            point: point ?? self.point,
            projection: projection ?? self.projection,
            range: range ?? self.range,
            rect: rect ?? self.rect,
            rule: rule ?? self.rule,
            scale: scale ?? self.scale,
            selection: selection ?? self.selection,
            square: square ?? self.square,
            stack: stack ?? self.stack,
            style: style ?? self.style,
            text: text ?? self.text,
            tick: tick ?? self.tick,
            timeFormat: timeFormat ?? self.timeFormat,
            title: title ?? self.title,
            view: view ?? self.view
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
// MARK: - MarkConfig
struct MarkConfig: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let color: String?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let filled: Bool?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case baseline = "baseline"
        case color = "color"
        case cursor = "cursor"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case filled = "filled"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
    }
}

// MARK: MarkConfig convenience initializers and mutators

extension MarkConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarkConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        color: String?? = nil,
        cursor: Cursor?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        filled: Bool?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil
    ) -> MarkConfig {
        return MarkConfig(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            color: color ?? self.color,
            cursor: cursor ?? self.cursor,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            filled: filled ?? self.filled,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
enum HorizontalAlign: String, Codable {
    case horizontalAlignLeft = "left"
    case horizontalAlignRight = "right"
    case center = "center"
}

/// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
///
/// __Default value:__ `"middle"`
///
/// Vertical text baseline for title text.
enum VerticalAlign: String, Codable {
    case top = "top"
    case middle = "middle"
    case bottom = "bottom"
}

/// The mouse cursor used over the mark. Any valid [CSS cursor
/// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
enum Cursor: String, Codable {
    case auto = "auto"
    case cursorDefault = "default"
    case none = "none"
    case contextMenu = "context-menu"
    case help = "help"
    case pointer = "pointer"
    case progress = "progress"
    case wait = "wait"
    case cell = "cell"
    case crosshair = "crosshair"
    case text = "text"
    case verticalText = "vertical-text"
    case alias = "alias"
    case copy = "copy"
    case move = "move"
    case noDrop = "no-drop"
    case notAllowed = "not-allowed"
    case eResize = "e-resize"
    case nResize = "n-resize"
    case neResize = "ne-resize"
    case nwResize = "nw-resize"
    case sResize = "s-resize"
    case seResize = "se-resize"
    case swResize = "sw-resize"
    case wResize = "w-resize"
    case ewResize = "ew-resize"
    case nsResize = "ns-resize"
    case neswResize = "nesw-resize"
    case nwseResize = "nwse-resize"
    case colResize = "col-resize"
    case rowResize = "row-resize"
    case allScroll = "all-scroll"
    case zoomIn = "zoom-in"
    case zoomOut = "zoom-out"
    case grab = "grab"
    case grabbing = "grabbing"
}

/// The font style (e.g., `"italic"`).
enum FontStyle: String, Codable {
    case normal = "normal"
    case italic = "italic"
}

/// The font weight (e.g., `"bold"`).
///
/// Font weight for title text.
enum FontWeightUnion: Codable {
    case double(Double)
    case enumeration(FontWeight)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(FontWeight.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(FontWeightUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FontWeightUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

enum FontWeight: String, Codable {
    case normal = "normal"
    case bold = "bold"
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
enum Interpolate: String, Codable {
    case linear = "linear"
    case linearClosed = "linear-closed"
    case step = "step"
    case stepBefore = "step-before"
    case stepAfter = "step-after"
    case basis = "basis"
    case basisOpen = "basis-open"
    case basisClosed = "basis-closed"
    case cardinal = "cardinal"
    case cardinalOpen = "cardinal-open"
    case cardinalClosed = "cardinal-closed"
    case bundle = "bundle"
    case monotone = "monotone"
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
enum Orient: String, Codable {
    case horizontal = "horizontal"
    case vertical = "vertical"
}

/// Axis configuration, which determines default properties for all `x` and `y`
/// [axes](axis.html). For a full list of axis configuration options, please see the
/// [corresponding section of the axis documentation](axis.html#config).
// MARK: - AxisConfig
struct AxisConfig: Codable {
    /// An interpolation fraction indicating where, for `band` scales, axis ticks should be
    /// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    /// places ticks in the middle of their bands.
    let bandPosition: Double?
    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    let domain: Bool?
    /// Color of axis domain line.
    ///
    /// __Default value:__  (none, using Vega default).
    let domainColor: String?
    /// Stroke width of axis domain line
    ///
    /// __Default value:__  (none, using Vega default).
    let domainWidth: Double?
    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    let grid: Bool?
    /// Color of gridlines.
    let gridColor: String?
    /// The offset (in pixels) into which to begin drawing with the grid dash array.
    let gridDash: [Double]?
    /// The stroke opacity of grid (value between [0,1])
    ///
    /// __Default value:__ (`1` by default)
    let gridOpacity: Double?
    /// The grid width, in pixels.
    let gridWidth: Double?
    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    let labelAngle: Double?
    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    let labelBound: Label?
    /// The color of the tick label, can be in hex color code or regular color name.
    let labelColor: String?
    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    let labelFlush: Label?
    /// The font of the tick label.
    let labelFont: String?
    /// The font size of the label, in pixels.
    let labelFontSize: Double?
    /// Maximum allowed pixel width of axis tick labels.
    let labelLimit: Double?
    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    let labelOverlap: LabelOverlapUnion?
    /// The padding, in pixels, between axis and text labels.
    let labelPadding: Double?
    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    let labels: Bool?
    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    let maxExtent: Double?
    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    let minExtent: Double?
    /// Whether month names and weekday names should be abbreviated.
    ///
    /// __Default value:__  `false`
    let shortTimeLabels: Bool?
    /// The color of the axis's tick.
    let tickColor: String?
    /// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    let tickRound: Bool?
    /// Boolean value that determines whether the axis should include ticks.
    let ticks: Bool?
    /// The size in pixels of axis ticks.
    let tickSize: Double?
    /// The width, in pixels, of ticks.
    let tickWidth: Double?
    /// Horizontal text alignment of axis titles.
    let titleAlign: String?
    /// Angle in degrees of axis titles.
    let titleAngle: Double?
    /// Vertical text baseline for axis titles.
    let titleBaseline: String?
    /// Color of the title, can be in hex color code or regular color name.
    let titleColor: String?
    /// Font of the title. (e.g., `"Helvetica Neue"`).
    let titleFont: String?
    /// Font size of the title.
    let titleFontSize: Double?
    /// Font weight of the title. (e.g., `"bold"`).
    let titleFontWeight: TitleFontWeight?
    /// Maximum allowed pixel width of axis titles.
    let titleLimit: Double?
    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    let titleMaxLength: Double?
    /// The padding, in pixels, between title and axis.
    let titlePadding: Double?
    /// X-coordinate of the axis title relative to the axis group.
    let titleX: Double?
    /// Y-coordinate of the axis title relative to the axis group.
    let titleY: Double?

    enum CodingKeys: String, CodingKey {
        case bandPosition = "bandPosition"
        case domain = "domain"
        case domainColor = "domainColor"
        case domainWidth = "domainWidth"
        case grid = "grid"
        case gridColor = "gridColor"
        case gridDash = "gridDash"
        case gridOpacity = "gridOpacity"
        case gridWidth = "gridWidth"
        case labelAngle = "labelAngle"
        case labelBound = "labelBound"
        case labelColor = "labelColor"
        case labelFlush = "labelFlush"
        case labelFont = "labelFont"
        case labelFontSize = "labelFontSize"
        case labelLimit = "labelLimit"
        case labelOverlap = "labelOverlap"
        case labelPadding = "labelPadding"
        case labels = "labels"
        case maxExtent = "maxExtent"
        case minExtent = "minExtent"
        case shortTimeLabels = "shortTimeLabels"
        case tickColor = "tickColor"
        case tickRound = "tickRound"
        case ticks = "ticks"
        case tickSize = "tickSize"
        case tickWidth = "tickWidth"
        case titleAlign = "titleAlign"
        case titleAngle = "titleAngle"
        case titleBaseline = "titleBaseline"
        case titleColor = "titleColor"
        case titleFont = "titleFont"
        case titleFontSize = "titleFontSize"
        case titleFontWeight = "titleFontWeight"
        case titleLimit = "titleLimit"
        case titleMaxLength = "titleMaxLength"
        case titlePadding = "titlePadding"
        case titleX = "titleX"
        case titleY = "titleY"
    }
}

// MARK: AxisConfig convenience initializers and mutators

extension AxisConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AxisConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bandPosition: Double?? = nil,
        domain: Bool?? = nil,
        domainColor: String?? = nil,
        domainWidth: Double?? = nil,
        grid: Bool?? = nil,
        gridColor: String?? = nil,
        gridDash: [Double]?? = nil,
        gridOpacity: Double?? = nil,
        gridWidth: Double?? = nil,
        labelAngle: Double?? = nil,
        labelBound: Label?? = nil,
        labelColor: String?? = nil,
        labelFlush: Label?? = nil,
        labelFont: String?? = nil,
        labelFontSize: Double?? = nil,
        labelLimit: Double?? = nil,
        labelOverlap: LabelOverlapUnion?? = nil,
        labelPadding: Double?? = nil,
        labels: Bool?? = nil,
        maxExtent: Double?? = nil,
        minExtent: Double?? = nil,
        shortTimeLabels: Bool?? = nil,
        tickColor: String?? = nil,
        tickRound: Bool?? = nil,
        ticks: Bool?? = nil,
        tickSize: Double?? = nil,
        tickWidth: Double?? = nil,
        titleAlign: String?? = nil,
        titleAngle: Double?? = nil,
        titleBaseline: String?? = nil,
        titleColor: String?? = nil,
        titleFont: String?? = nil,
        titleFontSize: Double?? = nil,
        titleFontWeight: TitleFontWeight?? = nil,
        titleLimit: Double?? = nil,
        titleMaxLength: Double?? = nil,
        titlePadding: Double?? = nil,
        titleX: Double?? = nil,
        titleY: Double?? = nil
    ) -> AxisConfig {
        return AxisConfig(
            bandPosition: bandPosition ?? self.bandPosition,
            domain: domain ?? self.domain,
            domainColor: domainColor ?? self.domainColor,
            domainWidth: domainWidth ?? self.domainWidth,
            grid: grid ?? self.grid,
            gridColor: gridColor ?? self.gridColor,
            gridDash: gridDash ?? self.gridDash,
            gridOpacity: gridOpacity ?? self.gridOpacity,
            gridWidth: gridWidth ?? self.gridWidth,
            labelAngle: labelAngle ?? self.labelAngle,
            labelBound: labelBound ?? self.labelBound,
            labelColor: labelColor ?? self.labelColor,
            labelFlush: labelFlush ?? self.labelFlush,
            labelFont: labelFont ?? self.labelFont,
            labelFontSize: labelFontSize ?? self.labelFontSize,
            labelLimit: labelLimit ?? self.labelLimit,
            labelOverlap: labelOverlap ?? self.labelOverlap,
            labelPadding: labelPadding ?? self.labelPadding,
            labels: labels ?? self.labels,
            maxExtent: maxExtent ?? self.maxExtent,
            minExtent: minExtent ?? self.minExtent,
            shortTimeLabels: shortTimeLabels ?? self.shortTimeLabels,
            tickColor: tickColor ?? self.tickColor,
            tickRound: tickRound ?? self.tickRound,
            ticks: ticks ?? self.ticks,
            tickSize: tickSize ?? self.tickSize,
            tickWidth: tickWidth ?? self.tickWidth,
            titleAlign: titleAlign ?? self.titleAlign,
            titleAngle: titleAngle ?? self.titleAngle,
            titleBaseline: titleBaseline ?? self.titleBaseline,
            titleColor: titleColor ?? self.titleColor,
            titleFont: titleFont ?? self.titleFont,
            titleFontSize: titleFontSize ?? self.titleFontSize,
            titleFontWeight: titleFontWeight ?? self.titleFontWeight,
            titleLimit: titleLimit ?? self.titleLimit,
            titleMaxLength: titleMaxLength ?? self.titleMaxLength,
            titlePadding: titlePadding ?? self.titlePadding,
            titleX: titleX ?? self.titleX,
            titleY: titleY ?? self.titleY
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum Label: Codable {
    case bool(Bool)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Label.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Label"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

enum LabelOverlapUnion: Codable {
    case bool(Bool)
    case enumeration(LabelOverlapEnum)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(LabelOverlapEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(LabelOverlapUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LabelOverlapUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

enum LabelOverlapEnum: String, Codable {
    case parity = "parity"
    case greedy = "greedy"
}

/// Font weight of the title. (e.g., `"bold"`).
///
/// The font weight of the legend title.
enum TitleFontWeight: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TitleFontWeight.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TitleFontWeight"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
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
// MARK: - VGAxisConfig
struct VGAxisConfig: Codable {
    /// An interpolation fraction indicating where, for `band` scales, axis ticks should be
    /// positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    /// places ticks in the middle of their bands.
    let bandPosition: Double?
    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    let domain: Bool?
    /// Color of axis domain line.
    ///
    /// __Default value:__  (none, using Vega default).
    let domainColor: String?
    /// Stroke width of axis domain line
    ///
    /// __Default value:__  (none, using Vega default).
    let domainWidth: Double?
    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    let grid: Bool?
    /// Color of gridlines.
    let gridColor: String?
    /// The offset (in pixels) into which to begin drawing with the grid dash array.
    let gridDash: [Double]?
    /// The stroke opacity of grid (value between [0,1])
    ///
    /// __Default value:__ (`1` by default)
    let gridOpacity: Double?
    /// The grid width, in pixels.
    let gridWidth: Double?
    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    let labelAngle: Double?
    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    let labelBound: Label?
    /// The color of the tick label, can be in hex color code or regular color name.
    let labelColor: String?
    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    let labelFlush: Label?
    /// The font of the tick label.
    let labelFont: String?
    /// The font size of the label, in pixels.
    let labelFontSize: Double?
    /// Maximum allowed pixel width of axis tick labels.
    let labelLimit: Double?
    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    let labelOverlap: LabelOverlapUnion?
    /// The padding, in pixels, between axis and text labels.
    let labelPadding: Double?
    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    let labels: Bool?
    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    let maxExtent: Double?
    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    let minExtent: Double?
    /// The color of the axis's tick.
    let tickColor: String?
    /// Boolean flag indicating if pixel position values should be rounded to the nearest integer.
    let tickRound: Bool?
    /// Boolean value that determines whether the axis should include ticks.
    let ticks: Bool?
    /// The size in pixels of axis ticks.
    let tickSize: Double?
    /// The width, in pixels, of ticks.
    let tickWidth: Double?
    /// Horizontal text alignment of axis titles.
    let titleAlign: String?
    /// Angle in degrees of axis titles.
    let titleAngle: Double?
    /// Vertical text baseline for axis titles.
    let titleBaseline: String?
    /// Color of the title, can be in hex color code or regular color name.
    let titleColor: String?
    /// Font of the title. (e.g., `"Helvetica Neue"`).
    let titleFont: String?
    /// Font size of the title.
    let titleFontSize: Double?
    /// Font weight of the title. (e.g., `"bold"`).
    let titleFontWeight: TitleFontWeight?
    /// Maximum allowed pixel width of axis titles.
    let titleLimit: Double?
    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    let titleMaxLength: Double?
    /// The padding, in pixels, between title and axis.
    let titlePadding: Double?
    /// X-coordinate of the axis title relative to the axis group.
    let titleX: Double?
    /// Y-coordinate of the axis title relative to the axis group.
    let titleY: Double?

    enum CodingKeys: String, CodingKey {
        case bandPosition = "bandPosition"
        case domain = "domain"
        case domainColor = "domainColor"
        case domainWidth = "domainWidth"
        case grid = "grid"
        case gridColor = "gridColor"
        case gridDash = "gridDash"
        case gridOpacity = "gridOpacity"
        case gridWidth = "gridWidth"
        case labelAngle = "labelAngle"
        case labelBound = "labelBound"
        case labelColor = "labelColor"
        case labelFlush = "labelFlush"
        case labelFont = "labelFont"
        case labelFontSize = "labelFontSize"
        case labelLimit = "labelLimit"
        case labelOverlap = "labelOverlap"
        case labelPadding = "labelPadding"
        case labels = "labels"
        case maxExtent = "maxExtent"
        case minExtent = "minExtent"
        case tickColor = "tickColor"
        case tickRound = "tickRound"
        case ticks = "ticks"
        case tickSize = "tickSize"
        case tickWidth = "tickWidth"
        case titleAlign = "titleAlign"
        case titleAngle = "titleAngle"
        case titleBaseline = "titleBaseline"
        case titleColor = "titleColor"
        case titleFont = "titleFont"
        case titleFontSize = "titleFontSize"
        case titleFontWeight = "titleFontWeight"
        case titleLimit = "titleLimit"
        case titleMaxLength = "titleMaxLength"
        case titlePadding = "titlePadding"
        case titleX = "titleX"
        case titleY = "titleY"
    }
}

// MARK: VGAxisConfig convenience initializers and mutators

extension VGAxisConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VGAxisConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bandPosition: Double?? = nil,
        domain: Bool?? = nil,
        domainColor: String?? = nil,
        domainWidth: Double?? = nil,
        grid: Bool?? = nil,
        gridColor: String?? = nil,
        gridDash: [Double]?? = nil,
        gridOpacity: Double?? = nil,
        gridWidth: Double?? = nil,
        labelAngle: Double?? = nil,
        labelBound: Label?? = nil,
        labelColor: String?? = nil,
        labelFlush: Label?? = nil,
        labelFont: String?? = nil,
        labelFontSize: Double?? = nil,
        labelLimit: Double?? = nil,
        labelOverlap: LabelOverlapUnion?? = nil,
        labelPadding: Double?? = nil,
        labels: Bool?? = nil,
        maxExtent: Double?? = nil,
        minExtent: Double?? = nil,
        tickColor: String?? = nil,
        tickRound: Bool?? = nil,
        ticks: Bool?? = nil,
        tickSize: Double?? = nil,
        tickWidth: Double?? = nil,
        titleAlign: String?? = nil,
        titleAngle: Double?? = nil,
        titleBaseline: String?? = nil,
        titleColor: String?? = nil,
        titleFont: String?? = nil,
        titleFontSize: Double?? = nil,
        titleFontWeight: TitleFontWeight?? = nil,
        titleLimit: Double?? = nil,
        titleMaxLength: Double?? = nil,
        titlePadding: Double?? = nil,
        titleX: Double?? = nil,
        titleY: Double?? = nil
    ) -> VGAxisConfig {
        return VGAxisConfig(
            bandPosition: bandPosition ?? self.bandPosition,
            domain: domain ?? self.domain,
            domainColor: domainColor ?? self.domainColor,
            domainWidth: domainWidth ?? self.domainWidth,
            grid: grid ?? self.grid,
            gridColor: gridColor ?? self.gridColor,
            gridDash: gridDash ?? self.gridDash,
            gridOpacity: gridOpacity ?? self.gridOpacity,
            gridWidth: gridWidth ?? self.gridWidth,
            labelAngle: labelAngle ?? self.labelAngle,
            labelBound: labelBound ?? self.labelBound,
            labelColor: labelColor ?? self.labelColor,
            labelFlush: labelFlush ?? self.labelFlush,
            labelFont: labelFont ?? self.labelFont,
            labelFontSize: labelFontSize ?? self.labelFontSize,
            labelLimit: labelLimit ?? self.labelLimit,
            labelOverlap: labelOverlap ?? self.labelOverlap,
            labelPadding: labelPadding ?? self.labelPadding,
            labels: labels ?? self.labels,
            maxExtent: maxExtent ?? self.maxExtent,
            minExtent: minExtent ?? self.minExtent,
            tickColor: tickColor ?? self.tickColor,
            tickRound: tickRound ?? self.tickRound,
            ticks: ticks ?? self.ticks,
            tickSize: tickSize ?? self.tickSize,
            tickWidth: tickWidth ?? self.tickWidth,
            titleAlign: titleAlign ?? self.titleAlign,
            titleAngle: titleAngle ?? self.titleAngle,
            titleBaseline: titleBaseline ?? self.titleBaseline,
            titleColor: titleColor ?? self.titleColor,
            titleFont: titleFont ?? self.titleFont,
            titleFontSize: titleFontSize ?? self.titleFontSize,
            titleFontWeight: titleFontWeight ?? self.titleFontWeight,
            titleLimit: titleLimit ?? self.titleLimit,
            titleMaxLength: titleMaxLength ?? self.titleMaxLength,
            titlePadding: titlePadding ?? self.titlePadding,
            titleX: titleX ?? self.titleX,
            titleY: titleY ?? self.titleY
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Bar-Specific Config
// MARK: - BarConfig
struct BarConfig: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
    /// statisticians) or 1 (Vega-Lite Default, D3 example style).
    ///
    /// __Default value:__ `1`
    let binSpacing: Double?
    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let color: String?
    /// The default size of the bars on continuous scales.
    ///
    /// __Default value:__ `5`
    let continuousBandSize: Double?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The size of the bars.  If unspecified, the default size is  `bandSize-1`,
    /// which provides 1 pixel offset between bars.
    let discreteBandSize: Double?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let filled: Bool?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case baseline = "baseline"
        case binSpacing = "binSpacing"
        case color = "color"
        case continuousBandSize = "continuousBandSize"
        case cursor = "cursor"
        case discreteBandSize = "discreteBandSize"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case filled = "filled"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
    }
}

// MARK: BarConfig convenience initializers and mutators

extension BarConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BarConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        binSpacing: Double?? = nil,
        color: String?? = nil,
        continuousBandSize: Double?? = nil,
        cursor: Cursor?? = nil,
        discreteBandSize: Double?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        filled: Bool?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil
    ) -> BarConfig {
        return BarConfig(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            binSpacing: binSpacing ?? self.binSpacing,
            color: color ?? self.color,
            continuousBandSize: continuousBandSize ?? self.continuousBandSize,
            cursor: cursor ?? self.cursor,
            discreteBandSize: discreteBandSize ?? self.discreteBandSize,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            filled: filled ?? self.filled,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Defines how Vega-Lite generates title for fields.  There are three possible styles:
///
/// - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
/// "Year-month of date", "field (binned)").
/// - `"function"` - displays function using parentheses and capitalized texts (e.g.,
/// "SUM(field)", "YEARMONTH(date)", "BIN(field)").
/// - `"plain"` - displays only the field name without functions (e.g., "field", "date",
/// "field").
enum FieldTitle: String, Codable {
    case verbal = "verbal"
    case functional = "functional"
    case plain = "plain"
}

/// Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
/// - If set to `"filter"` (default), all data items with null values are filtered.
/// - If `null`, all data items are included. In this case, invalid values will be
/// interpreted as zeroes.
enum InvalidValues: String, Codable {
    case filter = "filter"
}

/// Legend configuration, which determines default properties for all [legends](legend.html).
/// For a full list of legend configuration options, please see the [corresponding section of
/// in the legend documentation](legend.html#config).
// MARK: - LegendConfig
struct LegendConfig: Codable {
    /// Corner radius for the full legend.
    let cornerRadius: Double?
    /// Padding (in pixels) between legend entries in a symbol legend.
    let entryPadding: Double?
    /// Background fill color for the full legend.
    let fillColor: String?
    /// The height of the gradient, in pixels.
    let gradientHeight: Double?
    /// Text baseline for color ramp gradient labels.
    let gradientLabelBaseline: String?
    /// The maximum allowed length in pixels of color ramp gradient labels.
    let gradientLabelLimit: Double?
    /// Vertical offset in pixels for color ramp gradient labels.
    let gradientLabelOffset: Double?
    /// The color of the gradient stroke, can be in hex color code or regular color name.
    let gradientStrokeColor: String?
    /// The width of the gradient stroke, in pixels.
    let gradientStrokeWidth: Double?
    /// The width of the gradient, in pixels.
    let gradientWidth: Double?
    /// The alignment of the legend label, can be left, middle or right.
    let labelAlign: String?
    /// The position of the baseline of legend label, can be top, middle or bottom.
    let labelBaseline: String?
    /// The color of the legend label, can be in hex color code or regular color name.
    let labelColor: String?
    /// The font of the legend label.
    let labelFont: String?
    /// The font size of legend label.
    ///
    /// __Default value:__ `10`.
    let labelFontSize: Double?
    /// Maximum allowed pixel width of axis tick labels.
    let labelLimit: Double?
    /// The offset of the legend label.
    let labelOffset: Double?
    /// The offset, in pixels, by which to displace the legend from the edge of the enclosing
    /// group or data rectangle.
    ///
    /// __Default value:__  `0`
    let offset: Double?
    /// The orientation of the legend, which determines how the legend is positioned within the
    /// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    /// "none".
    ///
    /// __Default value:__ `"right"`
    let orient: LegendOrient?
    /// The padding, in pixels, between the legend and axis.
    let padding: Double?
    /// Whether month names and weekday names should be abbreviated.
    ///
    /// __Default value:__  `false`
    let shortTimeLabels: Bool?
    /// Border stroke color for the full legend.
    let strokeColor: String?
    /// Border stroke dash pattern for the full legend.
    let strokeDash: [Double]?
    /// Border stroke width for the full legend.
    let strokeWidth: Double?
    /// The color of the legend symbol,
    let symbolColor: String?
    /// The size of the legend symbol, in pixels.
    let symbolSize: Double?
    /// The width of the symbol's stroke.
    let symbolStrokeWidth: Double?
    /// Default shape type (such as "circle") for legend symbols.
    let symbolType: String?
    /// Horizontal text alignment for legend titles.
    let titleAlign: String?
    /// Vertical text baseline for legend titles.
    let titleBaseline: String?
    /// The color of the legend title, can be in hex color code or regular color name.
    let titleColor: String?
    /// The font of the legend title.
    let titleFont: String?
    /// The font size of the legend title.
    let titleFontSize: Double?
    /// The font weight of the legend title.
    let titleFontWeight: TitleFontWeight?
    /// Maximum allowed pixel width of axis titles.
    let titleLimit: Double?
    /// The padding, in pixels, between title and legend.
    let titlePadding: Double?

    enum CodingKeys: String, CodingKey {
        case cornerRadius = "cornerRadius"
        case entryPadding = "entryPadding"
        case fillColor = "fillColor"
        case gradientHeight = "gradientHeight"
        case gradientLabelBaseline = "gradientLabelBaseline"
        case gradientLabelLimit = "gradientLabelLimit"
        case gradientLabelOffset = "gradientLabelOffset"
        case gradientStrokeColor = "gradientStrokeColor"
        case gradientStrokeWidth = "gradientStrokeWidth"
        case gradientWidth = "gradientWidth"
        case labelAlign = "labelAlign"
        case labelBaseline = "labelBaseline"
        case labelColor = "labelColor"
        case labelFont = "labelFont"
        case labelFontSize = "labelFontSize"
        case labelLimit = "labelLimit"
        case labelOffset = "labelOffset"
        case offset = "offset"
        case orient = "orient"
        case padding = "padding"
        case shortTimeLabels = "shortTimeLabels"
        case strokeColor = "strokeColor"
        case strokeDash = "strokeDash"
        case strokeWidth = "strokeWidth"
        case symbolColor = "symbolColor"
        case symbolSize = "symbolSize"
        case symbolStrokeWidth = "symbolStrokeWidth"
        case symbolType = "symbolType"
        case titleAlign = "titleAlign"
        case titleBaseline = "titleBaseline"
        case titleColor = "titleColor"
        case titleFont = "titleFont"
        case titleFontSize = "titleFontSize"
        case titleFontWeight = "titleFontWeight"
        case titleLimit = "titleLimit"
        case titlePadding = "titlePadding"
    }
}

// MARK: LegendConfig convenience initializers and mutators

extension LegendConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LegendConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        cornerRadius: Double?? = nil,
        entryPadding: Double?? = nil,
        fillColor: String?? = nil,
        gradientHeight: Double?? = nil,
        gradientLabelBaseline: String?? = nil,
        gradientLabelLimit: Double?? = nil,
        gradientLabelOffset: Double?? = nil,
        gradientStrokeColor: String?? = nil,
        gradientStrokeWidth: Double?? = nil,
        gradientWidth: Double?? = nil,
        labelAlign: String?? = nil,
        labelBaseline: String?? = nil,
        labelColor: String?? = nil,
        labelFont: String?? = nil,
        labelFontSize: Double?? = nil,
        labelLimit: Double?? = nil,
        labelOffset: Double?? = nil,
        offset: Double?? = nil,
        orient: LegendOrient?? = nil,
        padding: Double?? = nil,
        shortTimeLabels: Bool?? = nil,
        strokeColor: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeWidth: Double?? = nil,
        symbolColor: String?? = nil,
        symbolSize: Double?? = nil,
        symbolStrokeWidth: Double?? = nil,
        symbolType: String?? = nil,
        titleAlign: String?? = nil,
        titleBaseline: String?? = nil,
        titleColor: String?? = nil,
        titleFont: String?? = nil,
        titleFontSize: Double?? = nil,
        titleFontWeight: TitleFontWeight?? = nil,
        titleLimit: Double?? = nil,
        titlePadding: Double?? = nil
    ) -> LegendConfig {
        return LegendConfig(
            cornerRadius: cornerRadius ?? self.cornerRadius,
            entryPadding: entryPadding ?? self.entryPadding,
            fillColor: fillColor ?? self.fillColor,
            gradientHeight: gradientHeight ?? self.gradientHeight,
            gradientLabelBaseline: gradientLabelBaseline ?? self.gradientLabelBaseline,
            gradientLabelLimit: gradientLabelLimit ?? self.gradientLabelLimit,
            gradientLabelOffset: gradientLabelOffset ?? self.gradientLabelOffset,
            gradientStrokeColor: gradientStrokeColor ?? self.gradientStrokeColor,
            gradientStrokeWidth: gradientStrokeWidth ?? self.gradientStrokeWidth,
            gradientWidth: gradientWidth ?? self.gradientWidth,
            labelAlign: labelAlign ?? self.labelAlign,
            labelBaseline: labelBaseline ?? self.labelBaseline,
            labelColor: labelColor ?? self.labelColor,
            labelFont: labelFont ?? self.labelFont,
            labelFontSize: labelFontSize ?? self.labelFontSize,
            labelLimit: labelLimit ?? self.labelLimit,
            labelOffset: labelOffset ?? self.labelOffset,
            offset: offset ?? self.offset,
            orient: orient ?? self.orient,
            padding: padding ?? self.padding,
            shortTimeLabels: shortTimeLabels ?? self.shortTimeLabels,
            strokeColor: strokeColor ?? self.strokeColor,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            symbolColor: symbolColor ?? self.symbolColor,
            symbolSize: symbolSize ?? self.symbolSize,
            symbolStrokeWidth: symbolStrokeWidth ?? self.symbolStrokeWidth,
            symbolType: symbolType ?? self.symbolType,
            titleAlign: titleAlign ?? self.titleAlign,
            titleBaseline: titleBaseline ?? self.titleBaseline,
            titleColor: titleColor ?? self.titleColor,
            titleFont: titleFont ?? self.titleFont,
            titleFontSize: titleFontSize ?? self.titleFontSize,
            titleFontWeight: titleFontWeight ?? self.titleFontWeight,
            titleLimit: titleLimit ?? self.titleLimit,
            titlePadding: titlePadding ?? self.titlePadding
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The orientation of the legend, which determines how the legend is positioned within the
/// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
/// "none".
///
/// __Default value:__ `"right"`
enum LegendOrient: String, Codable {
    case legendOrientLeft = "left"
    case legendOrientRight = "right"
    case topLeft = "top-left"
    case topRight = "top-right"
    case bottomLeft = "bottom-left"
    case bottomRight = "bottom-right"
    case none = "none"
}

/// The default visualization padding, in pixels, from the edge of the visualization canvas
/// to the data rectangle.  If a number, specifies padding for all sides.
/// If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
/// "bottom": 5}` to specify padding for each side of the visualization.
///
/// __Default value__: `5`
enum Padding: Codable {
    case double(Double)
    case paddingClass(PaddingClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(PaddingClass.self) {
            self = .paddingClass(x)
            return
        }
        throw DecodingError.typeMismatch(Padding.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Padding"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .paddingClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PaddingClass
struct PaddingClass: Codable {
    let bottom: Double?
    let paddingLeft: Double?
    let paddingRight: Double?
    let top: Double?

    enum CodingKeys: String, CodingKey {
        case bottom = "bottom"
        case paddingLeft = "left"
        case paddingRight = "right"
        case top = "top"
    }
}

// MARK: PaddingClass convenience initializers and mutators

extension PaddingClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PaddingClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bottom: Double?? = nil,
        paddingLeft: Double?? = nil,
        paddingRight: Double?? = nil,
        top: Double?? = nil
    ) -> PaddingClass {
        return PaddingClass(
            bottom: bottom ?? self.bottom,
            paddingLeft: paddingLeft ?? self.paddingLeft,
            paddingRight: paddingRight ?? self.paddingRight,
            top: top ?? self.top
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Projection configuration, which determines default properties for all
/// [projections](projection.html). For a full list of projection configuration options,
/// please see the [corresponding section of the projection
/// documentation](projection.html#config).
///
/// Any property of Projection can be in config
// MARK: - ProjectionConfig
struct ProjectionConfig: Codable {
    /// Sets the projection’s center to the specified center, a two-element array of longitude
    /// and latitude in degrees.
    ///
    /// __Default value:__ `[0, 0]`
    let center: [Double]?
    /// Sets the projection’s clipping circle radius to the specified angle in degrees. If
    /// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    /// than small-circle clipping.
    let clipAngle: Double?
    /// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    /// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    /// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    /// viewport clipping is performed.
    let clipExtent: [[Double]]?
    let coefficient: Double?
    let distance: Double?
    let fraction: Double?
    let lobes: Double?
    let parallel: Double?
    /// Sets the threshold for the projection’s [adaptive
    /// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    /// value corresponds to the [Douglas–Peucker
    /// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    /// If precision is not specified, returns the projection’s current resampling precision
    /// which defaults to `√0.5 ≅ 0.70710…`.
    let precision: [String: TitleFontWeight]?
    let radius: Double?
    let ratio: Double?
    /// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    /// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    /// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    /// __Default value:__ `[0, 0, 0]`
    let rotate: [Double]?
    let spacing: Double?
    let tilt: Double?
    /// The cartographic projection to use. This value is case-insensitive, for example
    /// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    /// projection types [in the
    /// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    /// __Default value:__ `mercator`
    let type: VGProjectionType?

    enum CodingKeys: String, CodingKey {
        case center = "center"
        case clipAngle = "clipAngle"
        case clipExtent = "clipExtent"
        case coefficient = "coefficient"
        case distance = "distance"
        case fraction = "fraction"
        case lobes = "lobes"
        case parallel = "parallel"
        case precision = "precision"
        case radius = "radius"
        case ratio = "ratio"
        case rotate = "rotate"
        case spacing = "spacing"
        case tilt = "tilt"
        case type = "type"
    }
}

// MARK: ProjectionConfig convenience initializers and mutators

extension ProjectionConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProjectionConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        center: [Double]?? = nil,
        clipAngle: Double?? = nil,
        clipExtent: [[Double]]?? = nil,
        coefficient: Double?? = nil,
        distance: Double?? = nil,
        fraction: Double?? = nil,
        lobes: Double?? = nil,
        parallel: Double?? = nil,
        precision: [String: TitleFontWeight]?? = nil,
        radius: Double?? = nil,
        ratio: Double?? = nil,
        rotate: [Double]?? = nil,
        spacing: Double?? = nil,
        tilt: Double?? = nil,
        type: VGProjectionType?? = nil
    ) -> ProjectionConfig {
        return ProjectionConfig(
            center: center ?? self.center,
            clipAngle: clipAngle ?? self.clipAngle,
            clipExtent: clipExtent ?? self.clipExtent,
            coefficient: coefficient ?? self.coefficient,
            distance: distance ?? self.distance,
            fraction: fraction ?? self.fraction,
            lobes: lobes ?? self.lobes,
            parallel: parallel ?? self.parallel,
            precision: precision ?? self.precision,
            radius: radius ?? self.radius,
            ratio: ratio ?? self.ratio,
            rotate: rotate ?? self.rotate,
            spacing: spacing ?? self.spacing,
            tilt: tilt ?? self.tilt,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The cartographic projection to use. This value is case-insensitive, for example
/// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
/// projection types [in the
/// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
///
/// __Default value:__ `mercator`
enum VGProjectionType: String, Codable {
    case albers = "albers"
    case albersUsa = "albersUsa"
    case azimuthalEqualArea = "azimuthalEqualArea"
    case azimuthalEquidistant = "azimuthalEquidistant"
    case conicConformal = "conicConformal"
    case conicEqualArea = "conicEqualArea"
    case conicEquidistant = "conicEquidistant"
    case equirectangular = "equirectangular"
    case gnomonic = "gnomonic"
    case mercator = "mercator"
    case orthographic = "orthographic"
    case stereographic = "stereographic"
    case transverseMercator = "transverseMercator"
}

enum RangeConfigValue: Codable {
    case unionArray([TitleFontWeight])
    case vgScheme(VGScheme)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([TitleFontWeight].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(VGScheme.self) {
            self = .vgScheme(x)
            return
        }
        throw DecodingError.typeMismatch(RangeConfigValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RangeConfigValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .unionArray(let x):
            try container.encode(x)
        case .vgScheme(let x):
            try container.encode(x)
        }
    }
}

// MARK: - VGScheme
struct VGScheme: Codable {
    let count: Double?
    let extent: [Double]?
    let scheme: String?
    let step: Double?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case extent = "extent"
        case scheme = "scheme"
        case step = "step"
    }
}

// MARK: VGScheme convenience initializers and mutators

extension VGScheme {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VGScheme.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        count: Double?? = nil,
        extent: [Double]?? = nil,
        scheme: String?? = nil,
        step: Double?? = nil
    ) -> VGScheme {
        return VGScheme(
            count: count ?? self.count,
            extent: extent ?? self.extent,
            scheme: scheme ?? self.scheme,
            step: step ?? self.step
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Scale configuration determines default properties for all [scales](scale.html). For a
/// full list of scale configuration options, please see the [corresponding section of the
/// scale documentation](scale.html#config).
// MARK: - ScaleConfig
struct ScaleConfig: Codable {
    /// Default inner padding for `x` and `y` band-ordinal scales.
    ///
    /// __Default value:__ `0.1`
    let bandPaddingInner: Double?
    /// Default outer padding for `x` and `y` band-ordinal scales.
    /// If not specified, by default, band scale's paddingOuter is paddingInner/2.
    let bandPaddingOuter: Double?
    /// If true, values that exceed the data domain are clamped to either the minimum or maximum
    /// range value
    let clamp: Bool?
    /// Default padding for continuous scales.
    ///
    /// __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
    /// horizontal bar.; `0` otherwise.
    let continuousPadding: Double?
    /// The default max value for mapping quantitative fields to bar's size/bandSize.
    ///
    /// If undefined (default), we will use the scale's `rangeStep` - 1.
    let maxBandSize: Double?
    /// The default max value for mapping quantitative fields to text's size/fontSize.
    ///
    /// __Default value:__ `40`
    let maxFontSize: Double?
    /// Default max opacity for mapping a field to opacity.
    ///
    /// __Default value:__ `0.8`
    let maxOpacity: Double?
    /// Default max value for point size scale.
    let maxSize: Double?
    /// Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
    ///
    /// __Default value:__ `4`
    let maxStrokeWidth: Double?
    /// The default min value for mapping quantitative fields to bar and tick's size/bandSize
    /// scale with zero=false.
    ///
    /// __Default value:__ `2`
    let minBandSize: Double?
    /// The default min value for mapping quantitative fields to tick's size/fontSize scale with
    /// zero=false
    ///
    /// __Default value:__ `8`
    let minFontSize: Double?
    /// Default minimum opacity for mapping a field to opacity.
    ///
    /// __Default value:__ `0.3`
    let minOpacity: Double?
    /// Default minimum value for point size scale with zero=false.
    ///
    /// __Default value:__ `9`
    let minSize: Double?
    /// Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
    ///
    /// __Default value:__ `1`
    let minStrokeWidth: Double?
    /// Default outer padding for `x` and `y` point-ordinal scales.
    ///
    /// __Default value:__ `0.5`
    let pointPadding: Double?
    /// Default range step for band and point scales of (1) the `y` channel
    /// and (2) the `x` channel when the mark is not `text`.
    ///
    /// __Default value:__ `21`
    let rangeStep: Double?
    /// If true, rounds numeric output values to integers.
    /// This can be helpful for snapping to the pixel grid.
    /// (Only available for `x`, `y`, and `size` scales.)
    let round: Bool?
    /// Default range step for `x` band and point scales of text marks.
    ///
    /// __Default value:__ `90`
    let textXRangeStep: Double?
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
    let useUnaggregatedDomain: Bool?

    enum CodingKeys: String, CodingKey {
        case bandPaddingInner = "bandPaddingInner"
        case bandPaddingOuter = "bandPaddingOuter"
        case clamp = "clamp"
        case continuousPadding = "continuousPadding"
        case maxBandSize = "maxBandSize"
        case maxFontSize = "maxFontSize"
        case maxOpacity = "maxOpacity"
        case maxSize = "maxSize"
        case maxStrokeWidth = "maxStrokeWidth"
        case minBandSize = "minBandSize"
        case minFontSize = "minFontSize"
        case minOpacity = "minOpacity"
        case minSize = "minSize"
        case minStrokeWidth = "minStrokeWidth"
        case pointPadding = "pointPadding"
        case rangeStep = "rangeStep"
        case round = "round"
        case textXRangeStep = "textXRangeStep"
        case useUnaggregatedDomain = "useUnaggregatedDomain"
    }
}

// MARK: ScaleConfig convenience initializers and mutators

extension ScaleConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ScaleConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bandPaddingInner: Double?? = nil,
        bandPaddingOuter: Double?? = nil,
        clamp: Bool?? = nil,
        continuousPadding: Double?? = nil,
        maxBandSize: Double?? = nil,
        maxFontSize: Double?? = nil,
        maxOpacity: Double?? = nil,
        maxSize: Double?? = nil,
        maxStrokeWidth: Double?? = nil,
        minBandSize: Double?? = nil,
        minFontSize: Double?? = nil,
        minOpacity: Double?? = nil,
        minSize: Double?? = nil,
        minStrokeWidth: Double?? = nil,
        pointPadding: Double?? = nil,
        rangeStep: Double?? = nil,
        round: Bool?? = nil,
        textXRangeStep: Double?? = nil,
        useUnaggregatedDomain: Bool?? = nil
    ) -> ScaleConfig {
        return ScaleConfig(
            bandPaddingInner: bandPaddingInner ?? self.bandPaddingInner,
            bandPaddingOuter: bandPaddingOuter ?? self.bandPaddingOuter,
            clamp: clamp ?? self.clamp,
            continuousPadding: continuousPadding ?? self.continuousPadding,
            maxBandSize: maxBandSize ?? self.maxBandSize,
            maxFontSize: maxFontSize ?? self.maxFontSize,
            maxOpacity: maxOpacity ?? self.maxOpacity,
            maxSize: maxSize ?? self.maxSize,
            maxStrokeWidth: maxStrokeWidth ?? self.maxStrokeWidth,
            minBandSize: minBandSize ?? self.minBandSize,
            minFontSize: minFontSize ?? self.minFontSize,
            minOpacity: minOpacity ?? self.minOpacity,
            minSize: minSize ?? self.minSize,
            minStrokeWidth: minStrokeWidth ?? self.minStrokeWidth,
            pointPadding: pointPadding ?? self.pointPadding,
            rangeStep: rangeStep ?? self.rangeStep,
            round: round ?? self.round,
            textXRangeStep: textXRangeStep ?? self.textXRangeStep,
            useUnaggregatedDomain: useUnaggregatedDomain ?? self.useUnaggregatedDomain
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object hash for defining default properties for each type of selections.
// MARK: - SelectionConfig
struct SelectionConfig: Codable {
    /// The default definition for an [`interval`](selection.html#type) selection. All properties
    /// and transformations
    /// for an interval selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `interval` to `{"translate": false}` disables the ability to move
    /// interval selections by default.
    let interval: IntervalSelectionConfig?
    /// The default definition for a [`multi`](selection.html#type) selection. All properties and
    /// transformations
    /// for a multi selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
    /// multi selections when clicking with the alt-key pressed by default.
    let multi: MultiSelectionConfig?
    /// The default definition for a [`single`](selection.html#type) selection. All properties
    /// and transformations
    /// for a single selection definition (except `type`) may be specified here.
    ///
    /// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
    /// double-click by default.
    let single: SingleSelectionConfig?

    enum CodingKeys: String, CodingKey {
        case interval = "interval"
        case multi = "multi"
        case single = "single"
    }
}

// MARK: SelectionConfig convenience initializers and mutators

extension SelectionConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SelectionConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        interval: IntervalSelectionConfig?? = nil,
        multi: MultiSelectionConfig?? = nil,
        single: SingleSelectionConfig?? = nil
    ) -> SelectionConfig {
        return SelectionConfig(
            interval: interval ?? self.interval,
            multi: multi ?? self.multi,
            single: single ?? self.single
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The default definition for an [`interval`](selection.html#type) selection. All properties
/// and transformations
/// for an interval selection definition (except `type`) may be specified here.
///
/// For instance, setting `interval` to `{"translate": false}` disables the ability to move
/// interval selections by default.
// MARK: - IntervalSelectionConfig
struct IntervalSelectionConfig: Codable {
    /// Establishes a two-way binding between the interval selection and the scales
    /// used within the same view. This allows a user to interactively pan and
    /// zoom the view.
    let bind: BindEnum?
    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    let empty: Empty?
    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    let encodings: [SingleDefChannel]?
    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    let fields: [String]?
    /// An interval selection also adds a rectangle mark to depict the
    /// extents of the interval. The `mark` property can be used to customize the
    /// appearance of the mark.
    let mark: BrushConfig?
    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    let on: JSONAny?
    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    let resolve: SelectionResolution?
    /// When truthy, allows a user to interactively move an interval selection
    /// back-and-forth. Can be `true`, `false` (to disable panning), or a
    /// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    /// which must include a start and end event to trigger continuous panning.
    ///
    /// __Default value:__ `true`, which corresponds to
    /// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    /// clicks and dragging within an interval selection to reposition it.
    let translate: Translate?
    /// When truthy, allows a user to interactively resize an interval selection.
    /// Can be `true`, `false` (to disable zooming), or a [Vega event stream
    /// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    /// only `wheel` events are supported.
    ///
    ///
    /// __Default value:__ `true`, which corresponds to `wheel!`.
    let zoom: Translate?

    enum CodingKeys: String, CodingKey {
        case bind = "bind"
        case empty = "empty"
        case encodings = "encodings"
        case fields = "fields"
        case mark = "mark"
        case on = "on"
        case resolve = "resolve"
        case translate = "translate"
        case zoom = "zoom"
    }
}

// MARK: IntervalSelectionConfig convenience initializers and mutators

extension IntervalSelectionConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntervalSelectionConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bind: BindEnum?? = nil,
        empty: Empty?? = nil,
        encodings: [SingleDefChannel]?? = nil,
        fields: [String]?? = nil,
        mark: BrushConfig?? = nil,
        on: JSONAny?? = nil,
        resolve: SelectionResolution?? = nil,
        translate: Translate?? = nil,
        zoom: Translate?? = nil
    ) -> IntervalSelectionConfig {
        return IntervalSelectionConfig(
            bind: bind ?? self.bind,
            empty: empty ?? self.empty,
            encodings: encodings ?? self.encodings,
            fields: fields ?? self.fields,
            mark: mark ?? self.mark,
            on: on ?? self.on,
            resolve: resolve ?? self.resolve,
            translate: translate ?? self.translate,
            zoom: zoom ?? self.zoom
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Establishes a two-way binding between the interval selection and the scales
/// used within the same view. This allows a user to interactively pan and
/// zoom the view.
enum BindEnum: String, Codable {
    case scales = "scales"
}

/// By default, all data values are considered to lie within an empty selection.
/// When set to `none`, empty selections contain no data values.
enum Empty: String, Codable {
    case all = "all"
    case none = "none"
}

enum SingleDefChannel: String, Codable {
    case x = "x"
    case y = "y"
    case x2 = "x2"
    case y2 = "y2"
    case row = "row"
    case column = "column"
    case size = "size"
    case shape = "shape"
    case color = "color"
    case opacity = "opacity"
    case text = "text"
    case tooltip = "tooltip"
    case href = "href"
}

/// An interval selection also adds a rectangle mark to depict the
/// extents of the interval. The `mark` property can be used to customize the
/// appearance of the mark.
// MARK: - BrushConfig
struct BrushConfig: Codable {
    /// The fill color of the interval mark.
    ///
    /// __Default value:__ `#333333`
    let fill: String?
    /// The fill opacity of the interval mark (a value between 0 and 1).
    ///
    /// __Default value:__ `0.125`
    let fillOpacity: Double?
    /// The stroke color of the interval mark.
    ///
    /// __Default value:__ `#ffffff`
    let stroke: String?
    /// An array of alternating stroke and space lengths,
    /// for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) with which to begin drawing the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity of the interval mark (a value between 0 and 1).
    let strokeOpacity: Double?
    /// The stroke width of the interval mark.
    let strokeWidth: Double?

    enum CodingKeys: String, CodingKey {
        case fill = "fill"
        case fillOpacity = "fillOpacity"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
    }
}

// MARK: BrushConfig convenience initializers and mutators

extension BrushConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BrushConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fill: String?? = nil,
        fillOpacity: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil
    ) -> BrushConfig {
        return BrushConfig(
            fill: fill ?? self.fill,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// With layered and multi-view displays, a strategy that determines how
/// selections' data queries are resolved when applied in a filter transform,
/// conditional encoding rule, or scale domain.
enum SelectionResolution: String, Codable {
    case global = "global"
    case union = "union"
    case intersect = "intersect"
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
enum Translate: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Translate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Translate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// The default definition for a [`multi`](selection.html#type) selection. All properties and
/// transformations
/// for a multi selection definition (except `type`) may be specified here.
///
/// For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
/// multi selections when clicking with the alt-key pressed by default.
// MARK: - MultiSelectionConfig
struct MultiSelectionConfig: Codable {
    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    let empty: Empty?
    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    let encodings: [SingleDefChannel]?
    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    let fields: [String]?
    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    let nearest: Bool?
    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    let on: JSONAny?
    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    let resolve: SelectionResolution?
    /// Controls whether data values should be toggled or only ever inserted into
    /// multi selections. Can be `true`, `false` (for insertion only), or a
    /// [Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    /// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    /// data values are toggled when a user interacts with the shift-key pressed).
    ///
    /// See the [toggle transform](toggle.html) documentation for more information.
    let toggle: Translate?

    enum CodingKeys: String, CodingKey {
        case empty = "empty"
        case encodings = "encodings"
        case fields = "fields"
        case nearest = "nearest"
        case on = "on"
        case resolve = "resolve"
        case toggle = "toggle"
    }
}

// MARK: MultiSelectionConfig convenience initializers and mutators

extension MultiSelectionConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MultiSelectionConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        empty: Empty?? = nil,
        encodings: [SingleDefChannel]?? = nil,
        fields: [String]?? = nil,
        nearest: Bool?? = nil,
        on: JSONAny?? = nil,
        resolve: SelectionResolution?? = nil,
        toggle: Translate?? = nil
    ) -> MultiSelectionConfig {
        return MultiSelectionConfig(
            empty: empty ?? self.empty,
            encodings: encodings ?? self.encodings,
            fields: fields ?? self.fields,
            nearest: nearest ?? self.nearest,
            on: on ?? self.on,
            resolve: resolve ?? self.resolve,
            toggle: toggle ?? self.toggle
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The default definition for a [`single`](selection.html#type) selection. All properties
/// and transformations
/// for a single selection definition (except `type`) may be specified here.
///
/// For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
/// double-click by default.
// MARK: - SingleSelectionConfig
struct SingleSelectionConfig: Codable {
    /// Establish a two-way binding between a single selection and input elements
    /// (also known as dynamic query widgets). A binding takes the form of
    /// Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    /// or can be a mapping between projected field/encodings and binding definitions.
    ///
    /// See the [bind transform](bind.html) documentation for more information.
    let bind: [String: VGBinding]?
    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    let empty: Empty?
    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    let encodings: [SingleDefChannel]?
    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    let fields: [String]?
    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    let nearest: Bool?
    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    let on: JSONAny?
    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    let resolve: SelectionResolution?

    enum CodingKeys: String, CodingKey {
        case bind = "bind"
        case empty = "empty"
        case encodings = "encodings"
        case fields = "fields"
        case nearest = "nearest"
        case on = "on"
        case resolve = "resolve"
    }
}

// MARK: SingleSelectionConfig convenience initializers and mutators

extension SingleSelectionConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SingleSelectionConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bind: [String: VGBinding]?? = nil,
        empty: Empty?? = nil,
        encodings: [SingleDefChannel]?? = nil,
        fields: [String]?? = nil,
        nearest: Bool?? = nil,
        on: JSONAny?? = nil,
        resolve: SelectionResolution?? = nil
    ) -> SingleSelectionConfig {
        return SingleSelectionConfig(
            bind: bind ?? self.bind,
            empty: empty ?? self.empty,
            encodings: encodings ?? self.encodings,
            fields: fields ?? self.fields,
            nearest: nearest ?? self.nearest,
            on: on ?? self.on,
            resolve: resolve ?? self.resolve
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - VGBinding
struct VGBinding: Codable {
    let element: String?
    let input: String
    let options: [String]?
    let max: Double?
    let min: Double?
    let step: Double?

    enum CodingKeys: String, CodingKey {
        case element = "element"
        case input = "input"
        case options = "options"
        case max = "max"
        case min = "min"
        case step = "step"
    }
}

// MARK: VGBinding convenience initializers and mutators

extension VGBinding {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VGBinding.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        element: String?? = nil,
        input: String? = nil,
        options: [String]?? = nil,
        max: Double?? = nil,
        min: Double?? = nil,
        step: Double?? = nil
    ) -> VGBinding {
        return VGBinding(
            element: element ?? self.element,
            input: input ?? self.input,
            options: options ?? self.options,
            max: max ?? self.max,
            min: min ?? self.min,
            step: step ?? self.step
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Default stack offset for stackable mark.
enum StackOffset: String, Codable {
    case zero = "zero"
    case center = "center"
    case normalize = "normalize"
}

// MARK: - VGMarkConfig
struct VGMarkConfig: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case baseline = "baseline"
        case cursor = "cursor"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
    }
}

// MARK: VGMarkConfig convenience initializers and mutators

extension VGMarkConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VGMarkConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        cursor: Cursor?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil
    ) -> VGMarkConfig {
        return VGMarkConfig(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            cursor: cursor ?? self.cursor,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Text-Specific Config
// MARK: - TextConfig
struct TextConfig: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let color: String?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let filled: Bool?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// Whether month names and weekday names should be abbreviated.
    let shortTimeLabels: Bool?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case baseline = "baseline"
        case color = "color"
        case cursor = "cursor"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case filled = "filled"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case shortTimeLabels = "shortTimeLabels"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
    }
}

// MARK: TextConfig convenience initializers and mutators

extension TextConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TextConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        color: String?? = nil,
        cursor: Cursor?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        filled: Bool?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        shortTimeLabels: Bool?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil
    ) -> TextConfig {
        return TextConfig(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            color: color ?? self.color,
            cursor: cursor ?? self.cursor,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            filled: filled ?? self.filled,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            shortTimeLabels: shortTimeLabels ?? self.shortTimeLabels,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Tick-Specific Config
// MARK: - TickConfig
struct TickConfig: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The width of the ticks.
    ///
    /// __Default value:__  2/3 of rangeStep.
    let bandSize: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let color: String?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let filled: Bool?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?
    /// Thickness of the tick mark.
    ///
    /// __Default value:__  `1`
    let thickness: Double?

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case bandSize = "bandSize"
        case baseline = "baseline"
        case color = "color"
        case cursor = "cursor"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case filled = "filled"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
        case thickness = "thickness"
    }
}

// MARK: TickConfig convenience initializers and mutators

extension TickConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TickConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        bandSize: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        color: String?? = nil,
        cursor: Cursor?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        filled: Bool?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil,
        thickness: Double?? = nil
    ) -> TickConfig {
        return TickConfig(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            bandSize: bandSize ?? self.bandSize,
            baseline: baseline ?? self.baseline,
            color: color ?? self.color,
            cursor: cursor ?? self.cursor,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            filled: filled ?? self.filled,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta,
            thickness: thickness ?? self.thickness
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Title configuration, which determines default properties for all [titles](title.html).
/// For a full list of title configuration options, please see the [corresponding section of
/// the title documentation](title.html#config).
// MARK: - VGTitleConfig
struct VGTitleConfig: Codable {
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
    let anchor: Anchor?
    /// Angle in degrees of title text.
    let angle: Double?
    /// Vertical text baseline for title text.
    let baseline: VerticalAlign?
    /// Text color for title text.
    let color: String?
    /// Font name for title text.
    let font: String?
    /// Font size in pixels for title text.
    ///
    /// __Default value:__ `10`.
    let fontSize: Double?
    /// Font weight for title text.
    let fontWeight: FontWeightUnion?
    /// The maximum allowed length in pixels of legend labels.
    let limit: Double?
    /// Offset in pixels of the title from the chart body and axes.
    let offset: Double?
    /// Default title orientation ("top", "bottom", "left", or "right")
    let orient: TitleOrient?

    enum CodingKeys: String, CodingKey {
        case anchor = "anchor"
        case angle = "angle"
        case baseline = "baseline"
        case color = "color"
        case font = "font"
        case fontSize = "fontSize"
        case fontWeight = "fontWeight"
        case limit = "limit"
        case offset = "offset"
        case orient = "orient"
    }
}

// MARK: VGTitleConfig convenience initializers and mutators

extension VGTitleConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VGTitleConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        anchor: Anchor?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        color: String?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        limit: Double?? = nil,
        offset: Double?? = nil,
        orient: TitleOrient?? = nil
    ) -> VGTitleConfig {
        return VGTitleConfig(
            anchor: anchor ?? self.anchor,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            color: color ?? self.color,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontWeight: fontWeight ?? self.fontWeight,
            limit: limit ?? self.limit,
            offset: offset ?? self.offset,
            orient: orient ?? self.orient
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum Anchor: String, Codable {
    case start = "start"
    case middle = "middle"
    case end = "end"
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
enum TitleOrient: String, Codable {
    case top = "top"
    case bottom = "bottom"
    case orientLeft = "left"
    case orientRight = "right"
}

/// Default properties for [single view plots](spec.html#single).
// MARK: - ViewConfig
struct ViewConfig: Codable {
    /// Whether the view should be clipped.
    let clip: Bool?
    /// The fill color.
    ///
    /// __Default value:__ (none)
    let fill: String?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ (none)
    let fillOpacity: Double?
    /// The default height of the single plot or each plot in a trellis plot when the
    /// visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
    ///
    /// __Default value:__ `200`
    let height: Double?
    /// The stroke color.
    ///
    /// __Default value:__ (none)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    ///
    /// __Default value:__ (none)
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    ///
    /// __Default value:__ (none)
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ (none)
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    ///
    /// __Default value:__ (none)
    let strokeWidth: Double?
    /// The default width of the single plot or each plot in a trellis plot when the
    /// visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
    /// = `null`.
    ///
    /// __Default value:__ `200`
    let width: Double?

    enum CodingKeys: String, CodingKey {
        case clip = "clip"
        case fill = "fill"
        case fillOpacity = "fillOpacity"
        case height = "height"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case width = "width"
    }
}

// MARK: ViewConfig convenience initializers and mutators

extension ViewConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ViewConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        clip: Bool?? = nil,
        fill: String?? = nil,
        fillOpacity: Double?? = nil,
        height: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        width: Double?? = nil
    ) -> ViewConfig {
        return ViewConfig(
            clip: clip ?? self.clip,
            fill: fill ?? self.fill,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            height: height ?? self.height,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object describing the data source
///
/// Secondary data source to lookup in.
// MARK: - DataClass
struct DataClass: Codable {
    /// An object that specifies the format for parsing the data file.
    ///
    /// An object that specifies the format for parsing the data values.
    ///
    /// An object that specifies the format for parsing the data.
    let format: DataFormat?
    /// An URL from which to load the data set. Use the `format.type` property
    /// to ensure the loaded data is correctly parsed.
    let url: String?
    /// The full data set, included inline. This can be an array of objects or primitive values
    /// or a string.
    /// Arrays of primitive values are ingested as objects with a `data` property. Strings are
    /// parsed according to the specified format type.
    let values: Values?
    /// Provide a placeholder name and bind data at runtime.
    let name: String?

    enum CodingKeys: String, CodingKey {
        case format = "format"
        case url = "url"
        case values = "values"
        case name = "name"
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        format: DataFormat?? = nil,
        url: String?? = nil,
        values: Values?? = nil,
        name: String?? = nil
    ) -> DataClass {
        return DataClass(
            format: format ?? self.format,
            url: url ?? self.url,
            values: values ?? self.values,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object that specifies the format for parsing the data file.
///
/// An object that specifies the format for parsing the data values.
///
/// An object that specifies the format for parsing the data.
// MARK: - DataFormat
struct DataFormat: Codable {
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
    let parse: ParseUnion?
    /// Type of input data: `"json"`, `"csv"`, `"tsv"`.
    /// The default format type is determined by the extension of the file URL.
    /// If no extension is detected, `"json"` will be used by default.
    let type: DataFormatType?
    /// The JSON property containing the desired data.
    /// This parameter can be used when the loaded JSON file may have surrounding structure or
    /// meta-data.
    /// For example `"property": "values.features"` is equivalent to retrieving
    /// `json.values.features`
    /// from the loaded JSON object.
    let property: String?
    /// The name of the TopoJSON object set to convert to a GeoJSON feature collection.
    /// For example, in a map of the world, there may be an object set named `"countries"`.
    /// Using the feature property, we can extract this set and generate a GeoJSON feature object
    /// for each country.
    let feature: String?
    /// The name of the TopoJSON object set to convert to mesh.
    /// Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
    /// Unlike the `feature` option, the corresponding geo data is returned as a single, unified
    /// mesh instance, not as individual GeoJSON features.
    /// Extracting a mesh is useful for more efficiently drawing borders or other geographic
    /// elements that you do not need to associate with specific regions such as individual
    /// countries, states or counties.
    let mesh: String?

    enum CodingKeys: String, CodingKey {
        case parse = "parse"
        case type = "type"
        case property = "property"
        case feature = "feature"
        case mesh = "mesh"
    }
}

// MARK: DataFormat convenience initializers and mutators

extension DataFormat {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataFormat.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        parse: ParseUnion?? = nil,
        type: DataFormatType?? = nil,
        property: String?? = nil,
        feature: String?? = nil,
        mesh: String?? = nil
    ) -> DataFormat {
        return DataFormat(
            parse: parse ?? self.parse,
            type: type ?? self.type,
            property: property ?? self.property,
            feature: feature ?? self.feature,
            mesh: mesh ?? self.mesh
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ParseUnion: Codable {
    case anythingMap([String: JSONAny])
    case enumeration(ParseEnum)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(ParseEnum.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode([String: JSONAny].self) {
            self = .anythingMap(x)
            return
        }
        throw DecodingError.typeMismatch(ParseUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ParseUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingMap(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

enum ParseEnum: String, Codable {
    case auto = "auto"
}

/// Type of input data: `"json"`, `"csv"`, `"tsv"`.
/// The default format type is determined by the extension of the file URL.
/// If no extension is detected, `"json"` will be used by default.
enum DataFormatType: String, Codable {
    case csv = "csv"
    case tsv = "tsv"
    case json = "json"
    case topojson = "topojson"
}

/// The full data set, included inline. This can be an array of objects or primitive values
/// or a string.
/// Arrays of primitive values are ingested as objects with a `data` property. Strings are
/// parsed according to the specified format type.
enum Values: Codable {
    case anythingMap([String: JSONAny])
    case string(String)
    case unionArray([ValuesValue])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ValuesValue].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode([String: JSONAny].self) {
            self = .anythingMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Values.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Values"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingMap(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum ValuesValue: Codable {
    case anythingMap([String: JSONAny])
    case bool(Bool)
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: JSONAny].self) {
            self = .anythingMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ValuesValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValuesValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingMap(let x):
            try container.encode(x)
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// A key-value mapping between encoding channels and definition of fields.
// MARK: - EncodingWithFacet
struct EncodingWithFacet: Codable {
    /// Color of the marks – either fill or stroke color based on mark type.
    /// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    /// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    /// __Default value:__ If undefined, the default color depends on [mark
    /// config](config.html#mark)'s `color` property.
    ///
    /// _Note:_ See the scale documentation for more information about customizing [color
    /// scheme](scale.html#scheme).
    let color: MarkPropDefWithCondition?
    /// Horizontal facets for trellis plots.
    let column: FacetFieldDef?
    /// Additional levels of detail for grouping data in aggregate views and
    /// in line and area marks without mapping data to a specific visual channel.
    let detail: Detail?
    /// A URL to load upon mouse click.
    let href: DefWithCondition?
    /// Opacity of the marks – either can be a value or a range.
    ///
    /// __Default value:__ If undefined, the default opacity depends on [mark
    /// config](config.html#mark)'s `opacity` property.
    let opacity: MarkPropDefWithCondition?
    /// Stack order for stacked marks or order of data points in line marks for connected scatter
    /// plots.
    ///
    /// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    /// additional aggregation grouping.
    let order: Order?
    /// Vertical facets for trellis plots.
    let row: FacetFieldDef?
    /// For `point` marks the supported values are
    /// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    /// or `"triangle-down"`, or else a custom SVG path string.
    /// For `geoshape` marks it should be a field definition of the geojson data
    ///
    /// __Default value:__ If undefined, the default shape depends on [mark
    /// config](config.html#point-config)'s `shape` property.
    let shape: MarkPropDefWithCondition?
    /// Size of the mark.
    /// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    /// - For `"bar"` and `"tick"` – the bar and tick's size.
    /// - For `"text"` – the text's font size.
    /// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    let size: MarkPropDefWithCondition?
    /// Text of the `text` mark.
    let text: TextDefWithCondition?
    /// The tooltip text to show upon mouse hover.
    let tooltip: TextDefWithCondition?
    /// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    let x: XClass?
    /// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    let x2: X2Class?
    /// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    let y: XClass?
    /// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    let y2: X2Class?

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case column = "column"
        case detail = "detail"
        case href = "href"
        case opacity = "opacity"
        case order = "order"
        case row = "row"
        case shape = "shape"
        case size = "size"
        case text = "text"
        case tooltip = "tooltip"
        case x = "x"
        case x2 = "x2"
        case y = "y"
        case y2 = "y2"
    }
}

// MARK: EncodingWithFacet convenience initializers and mutators

extension EncodingWithFacet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EncodingWithFacet.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: MarkPropDefWithCondition?? = nil,
        column: FacetFieldDef?? = nil,
        detail: Detail?? = nil,
        href: DefWithCondition?? = nil,
        opacity: MarkPropDefWithCondition?? = nil,
        order: Order?? = nil,
        row: FacetFieldDef?? = nil,
        shape: MarkPropDefWithCondition?? = nil,
        size: MarkPropDefWithCondition?? = nil,
        text: TextDefWithCondition?? = nil,
        tooltip: TextDefWithCondition?? = nil,
        x: XClass?? = nil,
        x2: X2Class?? = nil,
        y: XClass?? = nil,
        y2: X2Class?? = nil
    ) -> EncodingWithFacet {
        return EncodingWithFacet(
            color: color ?? self.color,
            column: column ?? self.column,
            detail: detail ?? self.detail,
            href: href ?? self.href,
            opacity: opacity ?? self.opacity,
            order: order ?? self.order,
            row: row ?? self.row,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            text: text ?? self.text,
            tooltip: tooltip ?? self.tooltip,
            x: x ?? self.x,
            x2: x2 ?? self.x2,
            y: y ?? self.y,
            y2: y2 ?? self.y2
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
// MARK: - MarkPropDefWithCondition
struct MarkPropDefWithCondition: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    let condition: ColorCondition?
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
    let field: Field?
    /// An object defining properties of the legend.
    /// If `null`, the legend for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    let legend: Legend?
    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    let scale: Scale?
    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    let sort: SortUnion?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?
    /// A constant value in visual domain.
    let value: ConditionalValueDefValue?

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case condition = "condition"
        case field = "field"
        case legend = "legend"
        case scale = "scale"
        case sort = "sort"
        case timeUnit = "timeUnit"
        case type = "type"
        case value = "value"
    }
}

// MARK: MarkPropDefWithCondition convenience initializers and mutators

extension MarkPropDefWithCondition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarkPropDefWithCondition.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        condition: ColorCondition?? = nil,
        field: Field?? = nil,
        legend: Legend?? = nil,
        scale: Scale?? = nil,
        sort: SortUnion?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil,
        value: ConditionalValueDefValue?? = nil
    ) -> MarkPropDefWithCondition {
        return MarkPropDefWithCondition(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            condition: condition ?? self.condition,
            field: field ?? self.field,
            legend: legend ?? self.legend,
            scale: scale ?? self.scale,
            sort: sort ?? self.sort,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum AggregateOp: String, Codable {
    case argmax = "argmax"
    case argmin = "argmin"
    case average = "average"
    case count = "count"
    case distinct = "distinct"
    case max = "max"
    case mean = "mean"
    case median = "median"
    case min = "min"
    case missing = "missing"
    case q1 = "q1"
    case q3 = "q3"
    case ci0 = "ci0"
    case ci1 = "ci1"
    case stdev = "stdev"
    case stdevp = "stdevp"
    case sum = "sum"
    case valid = "valid"
    case values = "values"
    case variance = "variance"
    case variancep = "variancep"
}

enum Bin: Codable {
    case binParams(BinParams)
    case bool(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(BinParams.self) {
            self = .binParams(x)
            return
        }
        throw DecodingError.typeMismatch(Bin.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Bin"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .binParams(let x):
            try container.encode(x)
        case .bool(let x):
            try container.encode(x)
        }
    }
}

/// Binning properties or boolean flag for determining whether to bin data or not.
// MARK: - BinParams
struct BinParams: Codable {
    /// The number base to use for automatic bin determination (default is base 10).
    ///
    /// __Default value:__ `10`
    let base: Double?
    /// Scale factors indicating allowable subdivisions. The default value is [5, 2], which
    /// indicates that for base 10 numbers (the default base), the method may consider dividing
    /// bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
    /// check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
    /// given constraints.
    ///
    /// __Default value:__ `[5, 2]`
    let divide: [Double]?
    /// A two-element (`[min, max]`) array indicating the range of desired bin values.
    let extent: [Double]?
    /// Maximum number of bins.
    ///
    /// __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
    let maxbins: Double?
    /// A minimum allowable step size (particularly useful for integer values).
    let minstep: Double?
    /// If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
    /// such as multiples of ten.
    let nice: Bool?
    /// An exact step size to use between bins.
    ///
    /// __Note:__ If provided, options such as maxbins will be ignored.
    let step: Double?
    /// An array of allowable step sizes to choose from.
    let steps: [Double]?

    enum CodingKeys: String, CodingKey {
        case base = "base"
        case divide = "divide"
        case extent = "extent"
        case maxbins = "maxbins"
        case minstep = "minstep"
        case nice = "nice"
        case step = "step"
        case steps = "steps"
    }
}

// MARK: BinParams convenience initializers and mutators

extension BinParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BinParams.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        base: Double?? = nil,
        divide: [Double]?? = nil,
        extent: [Double]?? = nil,
        maxbins: Double?? = nil,
        minstep: Double?? = nil,
        nice: Bool?? = nil,
        step: Double?? = nil,
        steps: [Double]?? = nil
    ) -> BinParams {
        return BinParams(
            base: base ?? self.base,
            divide: divide ?? self.divide,
            extent: extent ?? self.extent,
            maxbins: maxbins ?? self.maxbins,
            minstep: minstep ?? self.minstep,
            nice: nice ?? self.nice,
            step: step ?? self.step,
            steps: steps ?? self.steps
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ColorCondition: Codable {
    case conditionalPredicateMarkPropFieldDefClass(ConditionalPredicateMarkPropFieldDefClass)
    case conditionalValueDefArray([ConditionalValueDef])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ConditionalValueDef].self) {
            self = .conditionalValueDefArray(x)
            return
        }
        if let x = try? container.decode(ConditionalPredicateMarkPropFieldDefClass.self) {
            self = .conditionalPredicateMarkPropFieldDefClass(x)
            return
        }
        throw DecodingError.typeMismatch(ColorCondition.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ColorCondition"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .conditionalPredicateMarkPropFieldDefClass(let x):
            try container.encode(x)
        case .conditionalValueDefArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ConditionalValueDef
struct ConditionalValueDef: Codable {
    let test: LogicalOperandPredicate?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue
    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    let selection: SelectionOperand?

    enum CodingKeys: String, CodingKey {
        case test = "test"
        case value = "value"
        case selection = "selection"
    }
}

// MARK: ConditionalValueDef convenience initializers and mutators

extension ConditionalValueDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConditionalValueDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        test: LogicalOperandPredicate?? = nil,
        value: ConditionalValueDefValue? = nil,
        selection: SelectionOperand?? = nil
    ) -> ConditionalValueDef {
        return ConditionalValueDef(
            test: test ?? self.test,
            value: value ?? self.value,
            selection: selection ?? self.selection
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Selection
struct Selection: Codable {
    let not: SelectionOperand?
    let and: [SelectionOperand]?
    let or: [SelectionOperand]?

    enum CodingKeys: String, CodingKey {
        case not = "not"
        case and = "and"
        case or = "or"
    }
}

// MARK: Selection convenience initializers and mutators

extension Selection {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Selection.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        not: SelectionOperand?? = nil,
        and: [SelectionOperand]?? = nil,
        or: [SelectionOperand]?? = nil
    ) -> Selection {
        return Selection(
            not: not ?? self.not,
            and: and ?? self.and,
            or: or ?? self.or
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Filter using a selection name.
///
/// A [selection name](selection.html), or a series of [composed
/// selections](selection.html#compose).
indirect enum SelectionOperand: Codable {
    case selection(Selection)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Selection.self) {
            self = .selection(x)
            return
        }
        throw DecodingError.typeMismatch(SelectionOperand.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SelectionOperand"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .selection(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Predicate
struct Predicate: Codable {
    let not: LogicalOperandPredicate?
    let and: [LogicalOperandPredicate]?
    let or: [LogicalOperandPredicate]?
    /// The value that the field should be equal to.
    let equal: Equal?
    /// Field to be filtered.
    ///
    /// Field to be filtered
    let field: String?
    /// Time unit for the field to be filtered.
    ///
    /// time unit for the field to be filtered.
    let timeUnit: TimeUnit?
    /// An array of inclusive minimum and maximum values
    /// for a field value of a data item to be included in the filtered data.
    let range: [RangeElement]?
    /// A set of values that the `field`'s value should be a member of,
    /// for a data item included in the filtered data.
    let oneOf: [Equal]?
    /// Filter using a selection name.
    let selection: SelectionOperand?

    enum CodingKeys: String, CodingKey {
        case not = "not"
        case and = "and"
        case or = "or"
        case equal = "equal"
        case field = "field"
        case timeUnit = "timeUnit"
        case range = "range"
        case oneOf = "oneOf"
        case selection = "selection"
    }
}

// MARK: Predicate convenience initializers and mutators

extension Predicate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Predicate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        not: LogicalOperandPredicate?? = nil,
        and: [LogicalOperandPredicate]?? = nil,
        or: [LogicalOperandPredicate]?? = nil,
        equal: Equal?? = nil,
        field: String?? = nil,
        timeUnit: TimeUnit?? = nil,
        range: [RangeElement]?? = nil,
        oneOf: [Equal]?? = nil,
        selection: SelectionOperand?? = nil
    ) -> Predicate {
        return Predicate(
            not: not ?? self.not,
            and: and ?? self.and,
            or: or ?? self.or,
            equal: equal ?? self.equal,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            range: range ?? self.range,
            oneOf: oneOf ?? self.oneOf,
            selection: selection ?? self.selection
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The `filter` property must be one of the predicate definitions:
/// (1) an [expression](types.html#expression) string,
/// where `datum` can be used to refer to the current data object;
/// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
/// [range predicate](filter.html#range-predicate), [one-of
/// predicate](filter.html#one-of-predicate);
/// (3) a [selection predicate](filter.html#selection-predicate);
/// or (4) a logical operand that combines (1), (2), or (3).
indirect enum LogicalOperandPredicate: Codable {
    case predicate(Predicate)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Predicate.self) {
            self = .predicate(x)
            return
        }
        throw DecodingError.typeMismatch(LogicalOperandPredicate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LogicalOperandPredicate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .predicate(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// The value that the field should be equal to.
enum Equal: Codable {
    case bool(Bool)
    case dateTime(DateTime)
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(DateTime.self) {
            self = .dateTime(x)
            return
        }
        throw DecodingError.typeMismatch(Equal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Equal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// Object for defining datetime in Vega-Lite Filter.
/// If both month and quarter are provided, month has higher precedence.
/// `day` cannot be combined with other date.
/// We accept string for month and day names.
// MARK: - DateTime
struct DateTime: Codable {
    /// Integer value representing the date from 1-31.
    let date: Double?
    /// Value representing the day of a week.  This can be one of: (1) integer value -- `1`
    /// represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
    /// case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
    /// DateTime definition object with `day`** should not be combined with `year`, `quarter`,
    /// `month`, or `date`.
    let day: Day?
    /// Integer value representing the hour of a day from 0-23.
    let hours: Double?
    /// Integer value representing the millisecond segment of time.
    let milliseconds: Double?
    /// Integer value representing the minute segment of time from 0-59.
    let minutes: Double?
    /// One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
    /// (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
    /// short month name (e.g., `"Jan"`).
    let month: Month?
    /// Integer value representing the quarter of the year (from 1-4).
    let quarter: Double?
    /// Integer value representing the second segment (0-59) of a time value
    let seconds: Double?
    /// A boolean flag indicating if date time is in utc time. If false, the date time is in
    /// local time
    let utc: Bool?
    /// Integer value representing the year.
    let year: Double?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case hours = "hours"
        case milliseconds = "milliseconds"
        case minutes = "minutes"
        case month = "month"
        case quarter = "quarter"
        case seconds = "seconds"
        case utc = "utc"
        case year = "year"
    }
}

// MARK: DateTime convenience initializers and mutators

extension DateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        date: Double?? = nil,
        day: Day?? = nil,
        hours: Double?? = nil,
        milliseconds: Double?? = nil,
        minutes: Double?? = nil,
        month: Month?? = nil,
        quarter: Double?? = nil,
        seconds: Double?? = nil,
        utc: Bool?? = nil,
        year: Double?? = nil
    ) -> DateTime {
        return DateTime(
            date: date ?? self.date,
            day: day ?? self.day,
            hours: hours ?? self.hours,
            milliseconds: milliseconds ?? self.milliseconds,
            minutes: minutes ?? self.minutes,
            month: month ?? self.month,
            quarter: quarter ?? self.quarter,
            seconds: seconds ?? self.seconds,
            utc: utc ?? self.utc,
            year: year ?? self.year
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Value representing the day of a week.  This can be one of: (1) integer value -- `1`
/// represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
/// case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
/// DateTime definition object with `day`** should not be combined with `year`, `quarter`,
/// `month`, or `date`.
enum Day: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Day.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Day"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
/// (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
/// short month name (e.g., `"Jan"`).
enum Month: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Month.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Month"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum RangeElement: Codable {
    case dateTime(DateTime)
    case double(Double)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateTime.self) {
            self = .dateTime(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(RangeElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RangeElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
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
enum TimeUnit: String, Codable {
    case year = "year"
    case quarter = "quarter"
    case month = "month"
    case day = "day"
    case date = "date"
    case hours = "hours"
    case minutes = "minutes"
    case seconds = "seconds"
    case milliseconds = "milliseconds"
    case utcyear = "utcyear"
    case utcquarter = "utcquarter"
    case utcmonth = "utcmonth"
    case utcday = "utcday"
    case utcdate = "utcdate"
    case utchours = "utchours"
    case utcminutes = "utcminutes"
    case utcseconds = "utcseconds"
    case utcmilliseconds = "utcmilliseconds"
    case yearquarter = "yearquarter"
    case yearquartermonth = "yearquartermonth"
    case yearmonth = "yearmonth"
    case yearmonthdate = "yearmonthdate"
    case yearmonthdatehours = "yearmonthdatehours"
    case yearmonthdatehoursminutes = "yearmonthdatehoursminutes"
    case yearmonthdatehoursminutesseconds = "yearmonthdatehoursminutesseconds"
    case quartermonth = "quartermonth"
    case monthdate = "monthdate"
    case hoursminutes = "hoursminutes"
    case hoursminutesseconds = "hoursminutesseconds"
    case minutesseconds = "minutesseconds"
    case secondsmilliseconds = "secondsmilliseconds"
    case utcyearquarter = "utcyearquarter"
    case utcyearquartermonth = "utcyearquartermonth"
    case utcyearmonth = "utcyearmonth"
    case utcyearmonthdate = "utcyearmonthdate"
    case utcyearmonthdatehours = "utcyearmonthdatehours"
    case utcyearmonthdatehoursminutes = "utcyearmonthdatehoursminutes"
    case utcyearmonthdatehoursminutesseconds = "utcyearmonthdatehoursminutesseconds"
    case utcquartermonth = "utcquartermonth"
    case utcmonthdate = "utcmonthdate"
    case utchoursminutes = "utchoursminutes"
    case utchoursminutesseconds = "utchoursminutesseconds"
    case utcminutesseconds = "utcminutesseconds"
    case utcsecondsmilliseconds = "utcsecondsmilliseconds"
}

/// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
/// `0` to `1` for opacity).
///
/// A constant value in visual domain.
enum ConditionalValueDefValue: Codable {
    case bool(Bool)
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ConditionalValueDefValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ConditionalValueDefValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ConditionalPredicateMarkPropFieldDefClass
struct ConditionalPredicateMarkPropFieldDefClass: Codable {
    let test: LogicalOperandPredicate?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue?
    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    let selection: SelectionOperand?
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// An object defining properties of the legend.
    /// If `null`, the legend for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    let legend: Legend?
    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    let scale: Scale?
    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    let sort: SortUnion?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?

    enum CodingKeys: String, CodingKey {
        case test = "test"
        case value = "value"
        case selection = "selection"
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case legend = "legend"
        case scale = "scale"
        case sort = "sort"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: ConditionalPredicateMarkPropFieldDefClass convenience initializers and mutators

extension ConditionalPredicateMarkPropFieldDefClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConditionalPredicateMarkPropFieldDefClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        test: LogicalOperandPredicate?? = nil,
        value: ConditionalValueDefValue?? = nil,
        selection: SelectionOperand?? = nil,
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        legend: Legend?? = nil,
        scale: Scale?? = nil,
        sort: SortUnion?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil
    ) -> ConditionalPredicateMarkPropFieldDefClass {
        return ConditionalPredicateMarkPropFieldDefClass(
            test: test ?? self.test,
            value: value ?? self.value,
            selection: selection ?? self.selection,
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            legend: legend ?? self.legend,
            scale: scale ?? self.scale,
            sort: sort ?? self.sort,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Field: Codable {
    case repeatRef(RepeatRef)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RepeatRef.self) {
            self = .repeatRef(x)
            return
        }
        throw DecodingError.typeMismatch(Field.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Field"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .repeatRef(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// Reference to a repeated value.
// MARK: - RepeatRef
struct RepeatRef: Codable {
    let repeatRefRepeat: RepeatEnum

    enum CodingKeys: String, CodingKey {
        case repeatRefRepeat = "repeat"
    }
}

// MARK: RepeatRef convenience initializers and mutators

extension RepeatRef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RepeatRef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        repeatRefRepeat: RepeatEnum? = nil
    ) -> RepeatRef {
        return RepeatRef(
            repeatRefRepeat: repeatRefRepeat ?? self.repeatRefRepeat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum RepeatEnum: String, Codable {
    case row = "row"
    case column = "column"
}

/// Properties of a legend or boolean flag for determining whether to show it.
// MARK: - Legend
struct Legend: Codable {
    /// Padding (in pixels) between legend entries in a symbol legend.
    let entryPadding: Double?
    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    let format: String?
    /// The offset, in pixels, by which to displace the legend from the edge of the enclosing
    /// group or data rectangle.
    ///
    /// __Default value:__  `0`
    let offset: Double?
    /// The orientation of the legend, which determines how the legend is positioned within the
    /// scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    /// "none".
    ///
    /// __Default value:__ `"right"`
    let orient: LegendOrient?
    /// The padding, in pixels, between the legend and axis.
    let padding: Double?
    /// The desired number of tick values for quantitative legends.
    let tickCount: Double?
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
    let title: String?
    /// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
    /// continuous color gradient.
    ///
    /// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
    /// `"symbol"` otherwise.
    let type: LegendType?
    /// Explicitly set the visible legend values.
    let values: [LegendValue]?
    /// A non-positive integer indicating z-index of the legend.
    /// If zindex is 0, legend should be drawn behind all chart elements.
    /// To put them in front, use zindex = 1.
    let zindex: Double?

    enum CodingKeys: String, CodingKey {
        case entryPadding = "entryPadding"
        case format = "format"
        case offset = "offset"
        case orient = "orient"
        case padding = "padding"
        case tickCount = "tickCount"
        case title = "title"
        case type = "type"
        case values = "values"
        case zindex = "zindex"
    }
}

// MARK: Legend convenience initializers and mutators

extension Legend {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Legend.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        entryPadding: Double?? = nil,
        format: String?? = nil,
        offset: Double?? = nil,
        orient: LegendOrient?? = nil,
        padding: Double?? = nil,
        tickCount: Double?? = nil,
        title: String?? = nil,
        type: LegendType?? = nil,
        values: [LegendValue]?? = nil,
        zindex: Double?? = nil
    ) -> Legend {
        return Legend(
            entryPadding: entryPadding ?? self.entryPadding,
            format: format ?? self.format,
            offset: offset ?? self.offset,
            orient: orient ?? self.orient,
            padding: padding ?? self.padding,
            tickCount: tickCount ?? self.tickCount,
            title: title ?? self.title,
            type: type ?? self.type,
            values: values ?? self.values,
            zindex: zindex ?? self.zindex
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
/// continuous color gradient.
///
/// __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
/// `"symbol"` otherwise.
enum LegendType: String, Codable {
    case symbol = "symbol"
    case gradient = "gradient"
}

enum LegendValue: Codable {
    case dateTime(DateTime)
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(DateTime.self) {
            self = .dateTime(x)
            return
        }
        throw DecodingError.typeMismatch(LegendValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LegendValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

/// An object defining properties of the channel's scale, which is the function that
/// transforms values in the data domain (numbers, dates, strings, etc) to visual values
/// (pixels, colors, sizes) of the encoding channels.
///
/// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
// MARK: - Scale
struct Scale: Codable {
    /// The logarithm base of the `log` scale (default `10`).
    let base: Double?
    /// If `true`, values that exceed the data domain are clamped to either the minimum or
    /// maximum range value
    ///
    /// __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
    /// (`true` by default).
    let clamp: Bool?
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
    let domain: DomainUnion?
    /// The exponent of the `pow` scale.
    let exponent: Double?
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
    let interpolate: InterpolateUnion?
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
    let nice: NiceUnion?
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
    let padding: Double?
    /// The inner padding (spacing) within each band step of band scales, as a fraction of the
    /// step size. This value must lie in the range [0,1].
    ///
    /// For point scale, this property is invalid as point scales do not have internal band
    /// widths (only step sizes between bands).
    ///
    /// __Default value:__ derived from the [scale config](scale.html#config)'s
    /// `bandPaddingInner`.
    let paddingInner: Double?
    /// The outer padding (spacing) at the ends of the range of band and point scales,
    /// as a fraction of the step size. This value must lie in the range [0,1].
    ///
    /// __Default value:__ derived from the [scale config](scale.html#config)'s
    /// `bandPaddingOuter` for band scales and `pointPadding` for point scales.
    let paddingOuter: Double?
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
    let range: ScaleRange?
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
    let rangeStep: Double?
    /// If `true`, rounds numeric output values to integers. This can be helpful for snapping to
    /// the pixel grid.
    ///
    /// __Default value:__ `false`.
    let round: Bool?
    /// A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
    /// `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
    ///
    /// Discrete color schemes may be used with [discrete](scale.html#discrete) or
    /// [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
    /// use with [sequential](scales.html#sequential) scales.
    ///
    /// For the full list of supported scheme, please refer to the [Vega
    /// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    let scheme: Scheme?
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
    let type: ScaleType?
    /// If `true`, ensures that a zero baseline value is included in the scale domain.
    ///
    /// __Default value:__ `true` for x and y channels if the quantitative field is not binned
    /// and no custom `domain` is provided; `false` otherwise.
    ///
    /// __Note:__ Log, time, and utc scales do not support `zero`.
    let zero: Bool?

    enum CodingKeys: String, CodingKey {
        case base = "base"
        case clamp = "clamp"
        case domain = "domain"
        case exponent = "exponent"
        case interpolate = "interpolate"
        case nice = "nice"
        case padding = "padding"
        case paddingInner = "paddingInner"
        case paddingOuter = "paddingOuter"
        case range = "range"
        case rangeStep = "rangeStep"
        case round = "round"
        case scheme = "scheme"
        case type = "type"
        case zero = "zero"
    }
}

// MARK: Scale convenience initializers and mutators

extension Scale {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Scale.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        base: Double?? = nil,
        clamp: Bool?? = nil,
        domain: DomainUnion?? = nil,
        exponent: Double?? = nil,
        interpolate: InterpolateUnion?? = nil,
        nice: NiceUnion?? = nil,
        padding: Double?? = nil,
        paddingInner: Double?? = nil,
        paddingOuter: Double?? = nil,
        range: ScaleRange?? = nil,
        rangeStep: Double?? = nil,
        round: Bool?? = nil,
        scheme: Scheme?? = nil,
        type: ScaleType?? = nil,
        zero: Bool?? = nil
    ) -> Scale {
        return Scale(
            base: base ?? self.base,
            clamp: clamp ?? self.clamp,
            domain: domain ?? self.domain,
            exponent: exponent ?? self.exponent,
            interpolate: interpolate ?? self.interpolate,
            nice: nice ?? self.nice,
            padding: padding ?? self.padding,
            paddingInner: paddingInner ?? self.paddingInner,
            paddingOuter: paddingOuter ?? self.paddingOuter,
            range: range ?? self.range,
            rangeStep: rangeStep ?? self.rangeStep,
            round: round ?? self.round,
            scheme: scheme ?? self.scheme,
            type: type ?? self.type,
            zero: zero ?? self.zero
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum DomainUnion: Codable {
    case domainClass(DomainClass)
    case enumeration(Domain)
    case unionArray([Equal])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Equal].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(Domain.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(DomainClass.self) {
            self = .domainClass(x)
            return
        }
        throw DecodingError.typeMismatch(DomainUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DomainUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .domainClass(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DomainClass
struct DomainClass: Codable {
    /// The field name to extract selected values for, when a selection is
    /// [projected](project.html)
    /// over multiple fields or encodings.
    let field: String?
    /// The name of a selection.
    let selection: String
    /// The encoding channel to extract selected values for, when a selection is
    /// [projected](project.html)
    /// over multiple fields or encodings.
    let encoding: String?

    enum CodingKeys: String, CodingKey {
        case field = "field"
        case selection = "selection"
        case encoding = "encoding"
    }
}

// MARK: DomainClass convenience initializers and mutators

extension DomainClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DomainClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        field: String?? = nil,
        selection: String? = nil,
        encoding: String?? = nil
    ) -> DomainClass {
        return DomainClass(
            field: field ?? self.field,
            selection: selection ?? self.selection,
            encoding: encoding ?? self.encoding
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Domain: String, Codable {
    case unaggregated = "unaggregated"
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
enum InterpolateUnion: Codable {
    case enumeration(Interpolate)
    case interpolateParams(InterpolateParams)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Interpolate.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(InterpolateParams.self) {
            self = .interpolateParams(x)
            return
        }
        throw DecodingError.typeMismatch(InterpolateUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for InterpolateUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .interpolateParams(let x):
            try container.encode(x)
        }
    }
}

// MARK: - InterpolateParams
struct InterpolateParams: Codable {
    let gamma: Double?
    let type: InterpolateParamsType

    enum CodingKeys: String, CodingKey {
        case gamma = "gamma"
        case type = "type"
    }
}

// MARK: InterpolateParams convenience initializers and mutators

extension InterpolateParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InterpolateParams.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        gamma: Double?? = nil,
        type: InterpolateParamsType? = nil
    ) -> InterpolateParams {
        return InterpolateParams(
            gamma: gamma ?? self.gamma,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum InterpolateParamsType: String, Codable {
    case rgb = "rgb"
    case cubehelix = "cubehelix"
    case cubehelixLong = "cubehelix-long"
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
enum NiceUnion: Codable {
    case bool(Bool)
    case double(Double)
    case enumeration(NiceTime)
    case niceClass(NiceClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(NiceTime.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(NiceClass.self) {
            self = .niceClass(x)
            return
        }
        throw DecodingError.typeMismatch(NiceUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for NiceUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        case .niceClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - NiceClass
struct NiceClass: Codable {
    let interval: String
    let step: Double

    enum CodingKeys: String, CodingKey {
        case interval = "interval"
        case step = "step"
    }
}

// MARK: NiceClass convenience initializers and mutators

extension NiceClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NiceClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        interval: String? = nil,
        step: Double? = nil
    ) -> NiceClass {
        return NiceClass(
            interval: interval ?? self.interval,
            step: step ?? self.step
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum NiceTime: String, Codable {
    case second = "second"
    case minute = "minute"
    case hour = "hour"
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
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
enum ScaleRange: Codable {
    case string(String)
    case unionArray([TitleFontWeight])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([TitleFontWeight].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ScaleRange.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ScaleRange"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
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
enum Scheme: Codable {
    case schemeParams(SchemeParams)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(SchemeParams.self) {
            self = .schemeParams(x)
            return
        }
        throw DecodingError.typeMismatch(Scheme.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Scheme"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .schemeParams(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SchemeParams
struct SchemeParams: Codable {
    /// For sequential and diverging schemes only, determines the extent of the color range to
    /// use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
    /// range _[0, 0.2)_ are excluded from the scheme.
    let extent: [Double]?
    /// A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
    ///
    /// For the full list of supported scheme, please refer to the [Vega
    /// Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    let name: String

    enum CodingKeys: String, CodingKey {
        case extent = "extent"
        case name = "name"
    }
}

// MARK: SchemeParams convenience initializers and mutators

extension SchemeParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SchemeParams.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        extent: [Double]?? = nil,
        name: String? = nil
    ) -> SchemeParams {
        return SchemeParams(
            extent: extent ?? self.extent,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum ScaleType: String, Codable {
    case linear = "linear"
    case binLinear = "bin-linear"
    case log = "log"
    case pow = "pow"
    case sqrt = "sqrt"
    case time = "time"
    case utc = "utc"
    case sequential = "sequential"
    case ordinal = "ordinal"
    case binOrdinal = "bin-ordinal"
    case point = "point"
    case band = "band"
}

enum SortUnion: Codable {
    case enumeration(SortEnum)
    case sortField(SortField)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(SortEnum.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(SortField.self) {
            self = .sortField(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(SortUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SortUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .sortField(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - SortField
struct SortField: Codable {
    /// The data [field](field.html) to sort by.
    ///
    /// __Default value:__ If unspecified, defaults to the field specified in the outer data
    /// reference.
    let field: Field?
    /// An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
    /// (e.g., `"count"`, `"mean"` and `"median"`).
    /// This property is required in cases where the sort field and the data reference field do
    /// not match.
    /// The input data objects will be aggregated, grouped by the encoded data field.
    ///
    /// For a full list of operations, please see the documentation for
    /// [aggregate](aggregate.html#ops).
    let op: AggregateOp
    /// The sort order. One of `"ascending"` (default) or `"descending"`.
    let order: SortEnum?

    enum CodingKeys: String, CodingKey {
        case field = "field"
        case op = "op"
        case order = "order"
    }
}

// MARK: SortField convenience initializers and mutators

extension SortField {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SortField.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        field: Field?? = nil,
        op: AggregateOp? = nil,
        order: SortEnum?? = nil
    ) -> SortField {
        return SortField(
            field: field ?? self.field,
            op: op ?? self.op,
            order: order ?? self.order
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum SortEnum: String, Codable {
    case ascending = "ascending"
    case descending = "descending"
}

/// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
/// `"nominal"`).
/// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
/// [geographic projection](projection.html) is applied.
///
/// Constants and utilities for data type
/// Data type based on level of measurement
enum ConditionalPredicateValueDefType: String, Codable {
    case quantitative = "quantitative"
    case ordinal = "ordinal"
    case temporal = "temporal"
    case nominal = "nominal"
    case latitude = "latitude"
    case longitude = "longitude"
    case geojson = "geojson"
}

/// Horizontal facets for trellis plots.
///
/// Vertical facets for trellis plots.
// MARK: - FacetFieldDef
struct FacetFieldDef: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// An object defining properties of a facet's header.
    let header: Header?
    /// Sort order for a facet field.
    /// This can be `"ascending"`, `"descending"`.
    let sort: SortEnum?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case header = "header"
        case sort = "sort"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: FacetFieldDef convenience initializers and mutators

extension FacetFieldDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FacetFieldDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        header: Header?? = nil,
        sort: SortEnum?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType? = nil
    ) -> FacetFieldDef {
        return FacetFieldDef(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            header: header ?? self.header,
            sort: sort ?? self.sort,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object defining properties of a facet's header.
///
/// Headers of row / column channels for faceted plots.
// MARK: - Header
struct Header: Codable {
    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    let format: String?
    /// The rotation angle of the header labels.
    ///
    /// __Default value:__ `0`.
    let labelAngle: Double?
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
    let title: String?

    enum CodingKeys: String, CodingKey {
        case format = "format"
        case labelAngle = "labelAngle"
        case title = "title"
    }
}

// MARK: Header convenience initializers and mutators

extension Header {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Header.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        format: String?? = nil,
        labelAngle: Double?? = nil,
        title: String?? = nil
    ) -> Header {
        return Header(
            format: format ?? self.format,
            labelAngle: labelAngle ?? self.labelAngle,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Detail: Codable {
    case fieldDef(FieldDef)
    case fieldDefArray([FieldDef])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([FieldDef].self) {
            self = .fieldDefArray(x)
            return
        }
        if let x = try? container.decode(FieldDef.self) {
            self = .fieldDef(x)
            return
        }
        throw DecodingError.typeMismatch(Detail.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Detail"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fieldDef(let x):
            try container.encode(x)
        case .fieldDefArray(let x):
            try container.encode(x)
        }
    }
}

/// Definition object for a data field, its type and transformation of an encoding channel.
// MARK: - FieldDef
struct FieldDef: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: FieldDef convenience initializers and mutators

extension FieldDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FieldDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType? = nil
    ) -> FieldDef {
        return FieldDef(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
// MARK: - DefWithCondition
struct DefWithCondition: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    let condition: HrefCondition?
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
    let field: Field?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?
    /// A constant value in visual domain.
    let value: ConditionalValueDefValue?

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case condition = "condition"
        case field = "field"
        case timeUnit = "timeUnit"
        case type = "type"
        case value = "value"
    }
}

// MARK: DefWithCondition convenience initializers and mutators

extension DefWithCondition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DefWithCondition.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        condition: HrefCondition?? = nil,
        field: Field?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil,
        value: ConditionalValueDefValue?? = nil
    ) -> DefWithCondition {
        return DefWithCondition(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            condition: condition ?? self.condition,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum HrefCondition: Codable {
    case conditionalPredicateFieldDefClass(ConditionalPredicateFieldDefClass)
    case conditionalValueDefArray([ConditionalValueDef])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ConditionalValueDef].self) {
            self = .conditionalValueDefArray(x)
            return
        }
        if let x = try? container.decode(ConditionalPredicateFieldDefClass.self) {
            self = .conditionalPredicateFieldDefClass(x)
            return
        }
        throw DecodingError.typeMismatch(HrefCondition.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HrefCondition"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .conditionalPredicateFieldDefClass(let x):
            try container.encode(x)
        case .conditionalValueDefArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ConditionalPredicateFieldDefClass
struct ConditionalPredicateFieldDefClass: Codable {
    let test: LogicalOperandPredicate?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue?
    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    let selection: SelectionOperand?
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?

    enum CodingKeys: String, CodingKey {
        case test = "test"
        case value = "value"
        case selection = "selection"
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: ConditionalPredicateFieldDefClass convenience initializers and mutators

extension ConditionalPredicateFieldDefClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConditionalPredicateFieldDefClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        test: LogicalOperandPredicate?? = nil,
        value: ConditionalValueDefValue?? = nil,
        selection: SelectionOperand?? = nil,
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil
    ) -> ConditionalPredicateFieldDefClass {
        return ConditionalPredicateFieldDefClass(
            test: test ?? self.test,
            value: value ?? self.value,
            selection: selection ?? self.selection,
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Order: Codable {
    case orderFieldDef(OrderFieldDef)
    case orderFieldDefArray([OrderFieldDef])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([OrderFieldDef].self) {
            self = .orderFieldDefArray(x)
            return
        }
        if let x = try? container.decode(OrderFieldDef.self) {
            self = .orderFieldDef(x)
            return
        }
        throw DecodingError.typeMismatch(Order.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Order"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .orderFieldDef(let x):
            try container.encode(x)
        case .orderFieldDefArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - OrderFieldDef
struct OrderFieldDef: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// The sort order. One of `"ascending"` (default) or `"descending"`.
    let sort: SortEnum?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case sort = "sort"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: OrderFieldDef convenience initializers and mutators

extension OrderFieldDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OrderFieldDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        sort: SortEnum?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType? = nil
    ) -> OrderFieldDef {
        return OrderFieldDef(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            sort: sort ?? self.sort,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
// MARK: - TextDefWithCondition
struct TextDefWithCondition: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
    /// One or more value definition(s) with a selection predicate.
    ///
    /// __Note:__ A field definition's `condition` property can only contain [value
    /// definitions](encoding.html#value-def)
    /// since Vega-Lite only allows at most one encoded field per encoding channel.
    ///
    /// A field definition or one or more value definition(s) with a selection predicate.
    let condition: TextCondition?
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
    let field: Field?
    /// The [formatting pattern](format.html) for a text field. If not defined, this will be
    /// determined automatically.
    let format: String?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?
    /// A constant value in visual domain.
    let value: ConditionalValueDefValue?

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case condition = "condition"
        case field = "field"
        case format = "format"
        case timeUnit = "timeUnit"
        case type = "type"
        case value = "value"
    }
}

// MARK: TextDefWithCondition convenience initializers and mutators

extension TextDefWithCondition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TextDefWithCondition.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        condition: TextCondition?? = nil,
        field: Field?? = nil,
        format: String?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil,
        value: ConditionalValueDefValue?? = nil
    ) -> TextDefWithCondition {
        return TextDefWithCondition(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            condition: condition ?? self.condition,
            field: field ?? self.field,
            format: format ?? self.format,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TextCondition: Codable {
    case conditionalPredicateTextFieldDefClass(ConditionalPredicateTextFieldDefClass)
    case conditionalValueDefArray([ConditionalValueDef])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ConditionalValueDef].self) {
            self = .conditionalValueDefArray(x)
            return
        }
        if let x = try? container.decode(ConditionalPredicateTextFieldDefClass.self) {
            self = .conditionalPredicateTextFieldDefClass(x)
            return
        }
        throw DecodingError.typeMismatch(TextCondition.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TextCondition"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .conditionalPredicateTextFieldDefClass(let x):
            try container.encode(x)
        case .conditionalValueDefArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ConditionalPredicateTextFieldDefClass
struct ConditionalPredicateTextFieldDefClass: Codable {
    let test: LogicalOperandPredicate?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue?
    /// A [selection name](selection.html), or a series of [composed
    /// selections](selection.html#compose).
    let selection: SelectionOperand?
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// The [formatting pattern](format.html) for a text field. If not defined, this will be
    /// determined automatically.
    let format: String?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?

    enum CodingKeys: String, CodingKey {
        case test = "test"
        case value = "value"
        case selection = "selection"
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case format = "format"
        case timeUnit = "timeUnit"
        case type = "type"
    }
}

// MARK: ConditionalPredicateTextFieldDefClass convenience initializers and mutators

extension ConditionalPredicateTextFieldDefClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConditionalPredicateTextFieldDefClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        test: LogicalOperandPredicate?? = nil,
        value: ConditionalValueDefValue?? = nil,
        selection: SelectionOperand?? = nil,
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        format: String?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil
    ) -> ConditionalPredicateTextFieldDefClass {
        return ConditionalPredicateTextFieldDefClass(
            test: test ?? self.test,
            value: value ?? self.value,
            selection: selection ?? self.selection,
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            format: format ?? self.format,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
///
/// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
///
/// Definition object for a constant value of an encoding channel.
// MARK: - XClass
struct XClass: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// An object defining properties of axis's gridlines, ticks and labels.
    /// If `null`, the axis for the encoding channel will be removed.
    ///
    /// __Default value:__ If undefined, default [axis properties](axis.html) are applied.
    let axis: Axis?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// An object defining properties of the channel's scale, which is the function that
    /// transforms values in the data domain (numbers, dates, strings, etc) to visual values
    /// (pixels, colors, sizes) of the encoding channels.
    ///
    /// __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    let scale: Scale?
    /// Sort order for the encoded field.
    /// Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    /// For fields with discrete domains, `sort` can also be a [sort field definition
    /// object](sort.html#sort-field).
    ///
    /// __Default value:__ `"ascending"`
    let sort: SortUnion?
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
    let stack: StackOffset?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue?

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case axis = "axis"
        case bin = "bin"
        case field = "field"
        case scale = "scale"
        case sort = "sort"
        case stack = "stack"
        case timeUnit = "timeUnit"
        case type = "type"
        case value = "value"
    }
}

// MARK: XClass convenience initializers and mutators

extension XClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(XClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        axis: Axis?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        scale: Scale?? = nil,
        sort: SortUnion?? = nil,
        stack: StackOffset?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil,
        value: ConditionalValueDefValue?? = nil
    ) -> XClass {
        return XClass(
            aggregate: aggregate ?? self.aggregate,
            axis: axis ?? self.axis,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            scale: scale ?? self.scale,
            sort: sort ?? self.sort,
            stack: stack ?? self.stack,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Axis
struct Axis: Codable {
    /// A boolean flag indicating if the domain (the axis baseline) should be included as part of
    /// the axis.
    ///
    /// __Default value:__ `true`
    let domain: Bool?
    /// The formatting pattern for labels. This is D3's [number format
    /// pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    /// [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    /// field.
    ///
    /// See the [format documentation](format.html) for more information.
    ///
    /// __Default value:__  derived from [numberFormat](config.html#format) config for
    /// quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    let format: String?
    /// A boolean flag indicating if grid lines should be included as part of the axis
    ///
    /// __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    /// binned; otherwise, `false`.
    let grid: Bool?
    /// The rotation angle of the axis labels.
    ///
    /// __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    let labelAngle: Double?
    /// Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    /// default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    /// they exceed the axis range by more than 1 pixel. If this property is a number, it
    /// specifies the pixel tolerance: the maximum amount by which a label bounding box may
    /// exceed the axis range.
    ///
    /// __Default value:__ `false`.
    let labelBound: Label?
    /// Indicates if the first and last axis labels should be aligned flush with the scale range.
    /// Flush alignment for a horizontal axis will left-align the first label and right-align the
    /// last label. For vertical axes, bottom and top text baselines are applied instead. If this
    /// property is a number, it also indicates the number of pixels by which to offset the first
    /// and last labels; for example, a value of 2 will flush-align the first and last labels and
    /// also push them 2 pixels outward from the center of the axis. The additional adjustment
    /// can sometimes help the labels better visually group with corresponding axis ticks.
    ///
    /// __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    let labelFlush: Label?
    /// The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    /// overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    /// every other label is used (this works well for standard linear axes). If set to
    /// `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    /// with the last visible label (this often works better for log-scaled axes).
    ///
    /// __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    /// scales; otherwise `false`.
    let labelOverlap: LabelOverlapUnion?
    /// The padding, in pixels, between axis and text labels.
    let labelPadding: Double?
    /// A boolean flag indicating if labels should be included as part of the axis.
    ///
    /// __Default value:__  `true`.
    let labels: Bool?
    /// The maximum extent in pixels that axis ticks and labels should use. This determines a
    /// maximum offset value for axis titles.
    ///
    /// __Default value:__ `undefined`.
    let maxExtent: Double?
    /// The minimum extent in pixels that axis ticks and labels should use. This determines a
    /// minimum offset value for axis titles.
    ///
    /// __Default value:__ `30` for y-axis; `undefined` for x-axis.
    let minExtent: Double?
    /// The offset, in pixels, by which to displace the axis from the edge of the enclosing group
    /// or data rectangle.
    ///
    /// __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
    /// `offset` (`0` by default)
    let offset: Double?
    /// The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
    /// orientation can be used to further specialize the axis type (e.g., a y axis oriented for
    /// the right edge of the chart).
    ///
    /// __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
    let orient: TitleOrient?
    /// The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
    /// this sets the axis group x coordinate. For y-axis with left or right orientation, this
    /// sets the axis group y coordinate.
    ///
    /// __Default value__: `0`
    let position: Double?
    /// A desired number of ticks, for axes visualizing quantitative scales. The resulting number
    /// may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
    /// underlying scale's range.
    let tickCount: Double?
    /// Boolean value that determines whether the axis should include ticks.
    let ticks: Bool?
    /// The size in pixels of axis ticks.
    let tickSize: Double?
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
    let title: String?
    /// Max length for axis title if the title is automatically generated from the field's
    /// description.
    let titleMaxLength: Double?
    /// The padding, in pixels, between title and axis.
    let titlePadding: Double?
    /// Explicitly set the visible axis tick values.
    let values: [AxisValue]?
    /// A non-positive integer indicating z-index of the axis.
    /// If zindex is 0, axes should be drawn behind all chart elements.
    /// To put them in front, use `"zindex = 1"`.
    ///
    /// __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
    /// for grids.
    let zindex: Double?

    enum CodingKeys: String, CodingKey {
        case domain = "domain"
        case format = "format"
        case grid = "grid"
        case labelAngle = "labelAngle"
        case labelBound = "labelBound"
        case labelFlush = "labelFlush"
        case labelOverlap = "labelOverlap"
        case labelPadding = "labelPadding"
        case labels = "labels"
        case maxExtent = "maxExtent"
        case minExtent = "minExtent"
        case offset = "offset"
        case orient = "orient"
        case position = "position"
        case tickCount = "tickCount"
        case ticks = "ticks"
        case tickSize = "tickSize"
        case title = "title"
        case titleMaxLength = "titleMaxLength"
        case titlePadding = "titlePadding"
        case values = "values"
        case zindex = "zindex"
    }
}

// MARK: Axis convenience initializers and mutators

extension Axis {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Axis.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        domain: Bool?? = nil,
        format: String?? = nil,
        grid: Bool?? = nil,
        labelAngle: Double?? = nil,
        labelBound: Label?? = nil,
        labelFlush: Label?? = nil,
        labelOverlap: LabelOverlapUnion?? = nil,
        labelPadding: Double?? = nil,
        labels: Bool?? = nil,
        maxExtent: Double?? = nil,
        minExtent: Double?? = nil,
        offset: Double?? = nil,
        orient: TitleOrient?? = nil,
        position: Double?? = nil,
        tickCount: Double?? = nil,
        ticks: Bool?? = nil,
        tickSize: Double?? = nil,
        title: String?? = nil,
        titleMaxLength: Double?? = nil,
        titlePadding: Double?? = nil,
        values: [AxisValue]?? = nil,
        zindex: Double?? = nil
    ) -> Axis {
        return Axis(
            domain: domain ?? self.domain,
            format: format ?? self.format,
            grid: grid ?? self.grid,
            labelAngle: labelAngle ?? self.labelAngle,
            labelBound: labelBound ?? self.labelBound,
            labelFlush: labelFlush ?? self.labelFlush,
            labelOverlap: labelOverlap ?? self.labelOverlap,
            labelPadding: labelPadding ?? self.labelPadding,
            labels: labels ?? self.labels,
            maxExtent: maxExtent ?? self.maxExtent,
            minExtent: minExtent ?? self.minExtent,
            offset: offset ?? self.offset,
            orient: orient ?? self.orient,
            position: position ?? self.position,
            tickCount: tickCount ?? self.tickCount,
            ticks: ticks ?? self.ticks,
            tickSize: tickSize ?? self.tickSize,
            title: title ?? self.title,
            titleMaxLength: titleMaxLength ?? self.titleMaxLength,
            titlePadding: titlePadding ?? self.titlePadding,
            values: values ?? self.values,
            zindex: zindex ?? self.zindex
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum AxisValue: Codable {
    case dateTime(DateTime)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(DateTime.self) {
            self = .dateTime(x)
            return
        }
        throw DecodingError.typeMismatch(AxisValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AxisValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}

/// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
///
/// Definition object for a data field, its type and transformation of an encoding channel.
///
/// Definition object for a constant value of an encoding channel.
// MARK: - X2Class
struct X2Class: Codable {
    /// Aggregation function for the field
    /// (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    ///
    /// __Default value:__ `undefined` (None)
    let aggregate: AggregateOp?
    /// A flag for binning a `quantitative` field, or [an object defining binning
    /// parameters](bin.html#params).
    /// If `true`, default [binning parameters](bin.html) will be applied.
    ///
    /// __Default value:__ `false`
    let bin: Bin?
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
    let field: Field?
    /// Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    /// or [a temporal field that gets casted as ordinal](type.html#cast).
    ///
    /// __Default value:__ `undefined` (None)
    let timeUnit: TimeUnit?
    /// The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    /// `"nominal"`).
    /// It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    /// [geographic projection](projection.html) is applied.
    let type: ConditionalPredicateValueDefType?
    /// A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    /// `0` to `1` for opacity).
    let value: ConditionalValueDefValue?

    enum CodingKeys: String, CodingKey {
        case aggregate = "aggregate"
        case bin = "bin"
        case field = "field"
        case timeUnit = "timeUnit"
        case type = "type"
        case value = "value"
    }
}

// MARK: X2Class convenience initializers and mutators

extension X2Class {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(X2Class.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregate: AggregateOp?? = nil,
        bin: Bin?? = nil,
        field: Field?? = nil,
        timeUnit: TimeUnit?? = nil,
        type: ConditionalPredicateValueDefType?? = nil,
        value: ConditionalValueDefValue?? = nil
    ) -> X2Class {
        return X2Class(
            aggregate: aggregate ?? self.aggregate,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            type: type ?? self.type,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object that describes mappings between `row` and `column` channels and their field
/// definitions.
// MARK: - FacetMapping
struct FacetMapping: Codable {
    /// Horizontal facets for trellis plots.
    let column: FacetFieldDef?
    /// Vertical facets for trellis plots.
    let row: FacetFieldDef?

    enum CodingKeys: String, CodingKey {
        case column = "column"
        case row = "row"
    }
}

// MARK: FacetMapping convenience initializers and mutators

extension FacetMapping {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FacetMapping.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        column: FacetFieldDef?? = nil,
        row: FacetFieldDef?? = nil
    ) -> FacetMapping {
        return FacetMapping(
            column: column ?? self.column,
            row: row ?? self.row
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Unit spec that can have a composite mark.
// MARK: - Spec
class Spec: Codable {
    /// An object describing the data source
    let data: DataClass?
    /// Description of this mark for commenting purpose.
    let description: String?
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
    let height: Double?
    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    let layer: [LayerSpec]?
    /// Name of the visualization for later reference.
    let name: String?
    /// Scale, axis, and legend resolutions for layers.
    ///
    /// Scale, axis, and legend resolutions for facets.
    ///
    /// Scale and legend resolutions for repeated charts.
    ///
    /// Scale, axis, and legend resolutions for vertically concatenated charts.
    ///
    /// Scale, axis, and legend resolutions for horizontally concatenated charts.
    let resolve: Resolve?
    /// Title for the plot.
    let title: Title?
    /// An array of data transformations such as filter and new field calculation.
    let transform: [Transform]?
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
    let width: Double?
    /// A key-value mapping between encoding channels and definition of fields.
    let encoding: Encoding?
    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    let mark: AnyMark?
    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    let projection: Projection?
    /// A key-value mapping between selection names and definitions.
    let selection: [String: SelectionDef]?
    /// An object that describes mappings between `row` and `column` channels and their field
    /// definitions.
    let facet: FacetMapping?
    /// A specification of the view that gets faceted.
    let spec: Spec?
    /// An object that describes what fields should be repeated into views that are laid out as a
    /// `row` or `column`.
    let specRepeat: Repeat?
    /// A list of views that should be concatenated and put into a column.
    let vconcat: [Spec]?
    /// A list of views that should be concatenated and put into a row.
    let hconcat: [Spec]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case description = "description"
        case height = "height"
        case layer = "layer"
        case name = "name"
        case resolve = "resolve"
        case title = "title"
        case transform = "transform"
        case width = "width"
        case encoding = "encoding"
        case mark = "mark"
        case projection = "projection"
        case selection = "selection"
        case facet = "facet"
        case spec = "spec"
        case specRepeat = "repeat"
        case vconcat = "vconcat"
        case hconcat = "hconcat"
    }

    init(data: DataClass?, description: String?, height: Double?, layer: [LayerSpec]?, name: String?, resolve: Resolve?, title: Title?, transform: [Transform]?, width: Double?, encoding: Encoding?, mark: AnyMark?, projection: Projection?, selection: [String: SelectionDef]?, facet: FacetMapping?, spec: Spec?, specRepeat: Repeat?, vconcat: [Spec]?, hconcat: [Spec]?) {
        self.data = data
        self.description = description
        self.height = height
        self.layer = layer
        self.name = name
        self.resolve = resolve
        self.title = title
        self.transform = transform
        self.width = width
        self.encoding = encoding
        self.mark = mark
        self.projection = projection
        self.selection = selection
        self.facet = facet
        self.spec = spec
        self.specRepeat = specRepeat
        self.vconcat = vconcat
        self.hconcat = hconcat
    }
}

// MARK: Spec convenience initializers and mutators

extension Spec {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Spec.self, from: data)
        self.init(data: me.data, description: me.description, height: me.height, layer: me.layer, name: me.name, resolve: me.resolve, title: me.title, transform: me.transform, width: me.width, encoding: me.encoding, mark: me.mark, projection: me.projection, selection: me.selection, facet: me.facet, spec: me.spec, specRepeat: me.specRepeat, vconcat: me.vconcat, hconcat: me.hconcat)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: DataClass?? = nil,
        description: String?? = nil,
        height: Double?? = nil,
        layer: [LayerSpec]?? = nil,
        name: String?? = nil,
        resolve: Resolve?? = nil,
        title: Title?? = nil,
        transform: [Transform]?? = nil,
        width: Double?? = nil,
        encoding: Encoding?? = nil,
        mark: AnyMark?? = nil,
        projection: Projection?? = nil,
        selection: [String: SelectionDef]?? = nil,
        facet: FacetMapping?? = nil,
        spec: Spec?? = nil,
        specRepeat: Repeat?? = nil,
        vconcat: [Spec]?? = nil,
        hconcat: [Spec]?? = nil
    ) -> Spec {
        return Spec(
            data: data ?? self.data,
            description: description ?? self.description,
            height: height ?? self.height,
            layer: layer ?? self.layer,
            name: name ?? self.name,
            resolve: resolve ?? self.resolve,
            title: title ?? self.title,
            transform: transform ?? self.transform,
            width: width ?? self.width,
            encoding: encoding ?? self.encoding,
            mark: mark ?? self.mark,
            projection: projection ?? self.projection,
            selection: selection ?? self.selection,
            facet: facet ?? self.facet,
            spec: spec ?? self.spec,
            specRepeat: specRepeat ?? self.specRepeat,
            vconcat: vconcat ?? self.vconcat,
            hconcat: hconcat ?? self.hconcat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// A key-value mapping between encoding channels and definition of fields.
// MARK: - Encoding
struct Encoding: Codable {
    /// Color of the marks – either fill or stroke color based on mark type.
    /// By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    /// `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    ///
    /// __Default value:__ If undefined, the default color depends on [mark
    /// config](config.html#mark)'s `color` property.
    ///
    /// _Note:_ See the scale documentation for more information about customizing [color
    /// scheme](scale.html#scheme).
    let color: MarkPropDefWithCondition?
    /// Additional levels of detail for grouping data in aggregate views and
    /// in line and area marks without mapping data to a specific visual channel.
    let detail: Detail?
    /// A URL to load upon mouse click.
    let href: DefWithCondition?
    /// Opacity of the marks – either can be a value or a range.
    ///
    /// __Default value:__ If undefined, the default opacity depends on [mark
    /// config](config.html#mark)'s `opacity` property.
    let opacity: MarkPropDefWithCondition?
    /// Stack order for stacked marks or order of data points in line marks for connected scatter
    /// plots.
    ///
    /// __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    /// additional aggregation grouping.
    let order: Order?
    /// For `point` marks the supported values are
    /// `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    /// or `"triangle-down"`, or else a custom SVG path string.
    /// For `geoshape` marks it should be a field definition of the geojson data
    ///
    /// __Default value:__ If undefined, the default shape depends on [mark
    /// config](config.html#point-config)'s `shape` property.
    let shape: MarkPropDefWithCondition?
    /// Size of the mark.
    /// - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    /// - For `"bar"` and `"tick"` – the bar and tick's size.
    /// - For `"text"` – the text's font size.
    /// - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    let size: MarkPropDefWithCondition?
    /// Text of the `text` mark.
    let text: TextDefWithCondition?
    /// The tooltip text to show upon mouse hover.
    let tooltip: TextDefWithCondition?
    /// X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    let x: XClass?
    /// X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    let x2: X2Class?
    /// Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    let y: XClass?
    /// Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    let y2: X2Class?

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case detail = "detail"
        case href = "href"
        case opacity = "opacity"
        case order = "order"
        case shape = "shape"
        case size = "size"
        case text = "text"
        case tooltip = "tooltip"
        case x = "x"
        case x2 = "x2"
        case y = "y"
        case y2 = "y2"
    }
}

// MARK: Encoding convenience initializers and mutators

extension Encoding {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Encoding.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: MarkPropDefWithCondition?? = nil,
        detail: Detail?? = nil,
        href: DefWithCondition?? = nil,
        opacity: MarkPropDefWithCondition?? = nil,
        order: Order?? = nil,
        shape: MarkPropDefWithCondition?? = nil,
        size: MarkPropDefWithCondition?? = nil,
        text: TextDefWithCondition?? = nil,
        tooltip: TextDefWithCondition?? = nil,
        x: XClass?? = nil,
        x2: X2Class?? = nil,
        y: XClass?? = nil,
        y2: X2Class?? = nil
    ) -> Encoding {
        return Encoding(
            color: color ?? self.color,
            detail: detail ?? self.detail,
            href: href ?? self.href,
            opacity: opacity ?? self.opacity,
            order: order ?? self.order,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            text: text ?? self.text,
            tooltip: tooltip ?? self.tooltip,
            x: x ?? self.x,
            x2: x2 ?? self.x2,
            y: y ?? self.y,
            y2: y2 ?? self.y2
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Unit spec that can have a composite mark.
// MARK: - LayerSpec
struct LayerSpec: Codable {
    /// An object describing the data source
    let data: DataClass?
    /// Description of this mark for commenting purpose.
    let description: String?
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
    let height: Double?
    /// Layer or single view specifications to be layered.
    ///
    /// __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    /// layering facet specifications is not allowed.
    let layer: [LayerSpec]?
    /// Name of the visualization for later reference.
    let name: String?
    /// Scale, axis, and legend resolutions for layers.
    let resolve: Resolve?
    /// Title for the plot.
    let title: Title?
    /// An array of data transformations such as filter and new field calculation.
    let transform: [Transform]?
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
    let width: Double?
    /// A key-value mapping between encoding channels and definition of fields.
    let encoding: Encoding?
    /// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    /// `"line"`,
    /// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    /// object](mark.html#mark-def).
    let mark: AnyMark?
    /// An object defining properties of geographic projection.
    ///
    /// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    /// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    let projection: Projection?
    /// A key-value mapping between selection names and definitions.
    let selection: [String: SelectionDef]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case description = "description"
        case height = "height"
        case layer = "layer"
        case name = "name"
        case resolve = "resolve"
        case title = "title"
        case transform = "transform"
        case width = "width"
        case encoding = "encoding"
        case mark = "mark"
        case projection = "projection"
        case selection = "selection"
    }
}

// MARK: LayerSpec convenience initializers and mutators

extension LayerSpec {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LayerSpec.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: DataClass?? = nil,
        description: String?? = nil,
        height: Double?? = nil,
        layer: [LayerSpec]?? = nil,
        name: String?? = nil,
        resolve: Resolve?? = nil,
        title: Title?? = nil,
        transform: [Transform]?? = nil,
        width: Double?? = nil,
        encoding: Encoding?? = nil,
        mark: AnyMark?? = nil,
        projection: Projection?? = nil,
        selection: [String: SelectionDef]?? = nil
    ) -> LayerSpec {
        return LayerSpec(
            data: data ?? self.data,
            description: description ?? self.description,
            height: height ?? self.height,
            layer: layer ?? self.layer,
            name: name ?? self.name,
            resolve: resolve ?? self.resolve,
            title: title ?? self.title,
            transform: transform ?? self.transform,
            width: width ?? self.width,
            encoding: encoding ?? self.encoding,
            mark: mark ?? self.mark,
            projection: projection ?? self.projection,
            selection: selection ?? self.selection
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
/// `"line"`,
/// * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
/// object](mark.html#mark-def).
enum AnyMark: Codable {
    case enumeration(Mark)
    case markDef(MarkDef)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Mark.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(MarkDef.self) {
            self = .markDef(x)
            return
        }
        throw DecodingError.typeMismatch(AnyMark.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnyMark"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .markDef(let x):
            try container.encode(x)
        }
    }
}

// MARK: - MarkDef
struct MarkDef: Codable {
    /// The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
    let align: HorizontalAlign?
    /// The rotation angle of the text, in degrees.
    let angle: Double?
    /// The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    ///
    /// __Default value:__ `"middle"`
    let baseline: VerticalAlign?
    /// Whether a mark be clipped to the enclosing group’s width and height.
    let clip: Bool?
    /// Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    /// will override `color`.
    ///
    /// __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let color: String?
    /// The mouse cursor used over the mark. Any valid [CSS cursor
    /// type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    let cursor: Cursor?
    /// The horizontal offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dx: Double?
    /// The vertical offset, in pixels, between the text label and its anchor point. The offset
    /// is applied after rotation by the _angle_ property.
    let dy: Double?
    /// Default Fill Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let fill: String?
    /// Whether the mark's color should be used as fill color instead of stroke color.
    ///
    /// __Default value:__ `true` for all marks except `point` and `false` for `point`.
    ///
    /// __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    ///
    /// __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    let filled: Bool?
    /// The fill opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let fillOpacity: Double?
    /// The typeface to set the text in (e.g., `"Helvetica Neue"`).
    let font: String?
    /// The font size, in pixels.
    let fontSize: Double?
    /// The font style (e.g., `"italic"`).
    let fontStyle: FontStyle?
    /// The font weight (e.g., `"bold"`).
    let fontWeight: FontWeightUnion?
    /// A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
    let href: String?
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
    let interpolate: Interpolate?
    /// The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    /// value will be automatically truncated if the rendered size exceeds the limit.
    let limit: Double?
    /// The overall opacity (value between [0,1]).
    ///
    /// __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    /// `square` marks or layered `bar` charts and `1` otherwise.
    let opacity: Double?
    /// The orientation of a non-stacked bar, tick, area, and line charts.
    /// The value is either horizontal (default) or vertical.
    /// - For bar, rule and tick, this determines whether the size of the bar and tick
    /// should be applied to x or y dimension.
    /// - For area, this property determines the orient property of the Vega output.
    /// - For line, this property determines the sort order of the points in the line
    /// if `config.sortLineBy` is not specified.
    /// For stacked charts, this is always determined by the orientation of the stack;
    /// therefore explicitly specified value will be ignored.
    let orient: Orient?
    /// Polar coordinate radial offset, in pixels, of the text label from the origin determined
    /// by the `x` and `y` properties.
    let radius: Double?
    /// The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    /// `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    ///
    /// __Default value:__ `"circle"`
    let shape: String?
    /// The pixel area each the point/circle/square.
    /// For example: in the case of circles, the radius is determined in part by the square root
    /// of the size value.
    ///
    /// __Default value:__ `30`
    let size: Double?
    /// Default Stroke Color.  This has higher precedence than config.color
    ///
    /// __Default value:__ (None)
    let stroke: String?
    /// An array of alternating stroke, space lengths for creating dashed or dotted lines.
    let strokeDash: [Double]?
    /// The offset (in pixels) into which to begin drawing with the stroke dash array.
    let strokeDashOffset: Double?
    /// The stroke opacity (value between [0,1]).
    ///
    /// __Default value:__ `1`
    let strokeOpacity: Double?
    /// The stroke width, in pixels.
    let strokeWidth: Double?
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
    let style: Style?
    /// Depending on the interpolation type, sets the tension parameter (for line and area marks).
    let tension: Double?
    /// Placeholder text if the `text` channel is not specified
    let text: String?
    /// Polar coordinate angle, in radians, of the text label from the origin determined by the
    /// `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    /// `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    /// indicating "north".
    let theta: Double?
    /// The mark type.
    /// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
    /// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
    let type: Mark

    enum CodingKeys: String, CodingKey {
        case align = "align"
        case angle = "angle"
        case baseline = "baseline"
        case clip = "clip"
        case color = "color"
        case cursor = "cursor"
        case dx = "dx"
        case dy = "dy"
        case fill = "fill"
        case filled = "filled"
        case fillOpacity = "fillOpacity"
        case font = "font"
        case fontSize = "fontSize"
        case fontStyle = "fontStyle"
        case fontWeight = "fontWeight"
        case href = "href"
        case interpolate = "interpolate"
        case limit = "limit"
        case opacity = "opacity"
        case orient = "orient"
        case radius = "radius"
        case shape = "shape"
        case size = "size"
        case stroke = "stroke"
        case strokeDash = "strokeDash"
        case strokeDashOffset = "strokeDashOffset"
        case strokeOpacity = "strokeOpacity"
        case strokeWidth = "strokeWidth"
        case style = "style"
        case tension = "tension"
        case text = "text"
        case theta = "theta"
        case type = "type"
    }
}

// MARK: MarkDef convenience initializers and mutators

extension MarkDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarkDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        align: HorizontalAlign?? = nil,
        angle: Double?? = nil,
        baseline: VerticalAlign?? = nil,
        clip: Bool?? = nil,
        color: String?? = nil,
        cursor: Cursor?? = nil,
        dx: Double?? = nil,
        dy: Double?? = nil,
        fill: String?? = nil,
        filled: Bool?? = nil,
        fillOpacity: Double?? = nil,
        font: String?? = nil,
        fontSize: Double?? = nil,
        fontStyle: FontStyle?? = nil,
        fontWeight: FontWeightUnion?? = nil,
        href: String?? = nil,
        interpolate: Interpolate?? = nil,
        limit: Double?? = nil,
        opacity: Double?? = nil,
        orient: Orient?? = nil,
        radius: Double?? = nil,
        shape: String?? = nil,
        size: Double?? = nil,
        stroke: String?? = nil,
        strokeDash: [Double]?? = nil,
        strokeDashOffset: Double?? = nil,
        strokeOpacity: Double?? = nil,
        strokeWidth: Double?? = nil,
        style: Style?? = nil,
        tension: Double?? = nil,
        text: String?? = nil,
        theta: Double?? = nil,
        type: Mark? = nil
    ) -> MarkDef {
        return MarkDef(
            align: align ?? self.align,
            angle: angle ?? self.angle,
            baseline: baseline ?? self.baseline,
            clip: clip ?? self.clip,
            color: color ?? self.color,
            cursor: cursor ?? self.cursor,
            dx: dx ?? self.dx,
            dy: dy ?? self.dy,
            fill: fill ?? self.fill,
            filled: filled ?? self.filled,
            fillOpacity: fillOpacity ?? self.fillOpacity,
            font: font ?? self.font,
            fontSize: fontSize ?? self.fontSize,
            fontStyle: fontStyle ?? self.fontStyle,
            fontWeight: fontWeight ?? self.fontWeight,
            href: href ?? self.href,
            interpolate: interpolate ?? self.interpolate,
            limit: limit ?? self.limit,
            opacity: opacity ?? self.opacity,
            orient: orient ?? self.orient,
            radius: radius ?? self.radius,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            stroke: stroke ?? self.stroke,
            strokeDash: strokeDash ?? self.strokeDash,
            strokeDashOffset: strokeDashOffset ?? self.strokeDashOffset,
            strokeOpacity: strokeOpacity ?? self.strokeOpacity,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            style: style ?? self.style,
            tension: tension ?? self.tension,
            text: text ?? self.text,
            theta: theta ?? self.theta,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
enum Style: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Style.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Style"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

/// All types of primitive marks.
///
/// The mark type.
/// One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
/// `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
enum Mark: String, Codable {
    case area = "area"
    case bar = "bar"
    case line = "line"
    case point = "point"
    case text = "text"
    case tick = "tick"
    case rect = "rect"
    case rule = "rule"
    case circle = "circle"
    case square = "square"
    case geoshape = "geoshape"
}

/// An object defining properties of geographic projection.
///
/// Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
/// more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
// MARK: - Projection
struct Projection: Codable {
    /// Sets the projection’s center to the specified center, a two-element array of longitude
    /// and latitude in degrees.
    ///
    /// __Default value:__ `[0, 0]`
    let center: [Double]?
    /// Sets the projection’s clipping circle radius to the specified angle in degrees. If
    /// `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    /// than small-circle clipping.
    let clipAngle: Double?
    /// Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    /// bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    /// the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    /// viewport clipping is performed.
    let clipExtent: [[Double]]?
    let coefficient: Double?
    let distance: Double?
    let fraction: Double?
    let lobes: Double?
    let parallel: Double?
    /// Sets the threshold for the projection’s [adaptive
    /// resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    /// value corresponds to the [Douglas–Peucker
    /// distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    /// If precision is not specified, returns the projection’s current resampling precision
    /// which defaults to `√0.5 ≅ 0.70710…`.
    let precision: [String: TitleFontWeight]?
    let radius: Double?
    let ratio: Double?
    /// Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    /// or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    /// angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    ///
    /// __Default value:__ `[0, 0, 0]`
    let rotate: [Double]?
    let spacing: Double?
    let tilt: Double?
    /// The cartographic projection to use. This value is case-insensitive, for example
    /// `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    /// projection types [in the
    /// documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    ///
    /// __Default value:__ `mercator`
    let type: VGProjectionType?

    enum CodingKeys: String, CodingKey {
        case center = "center"
        case clipAngle = "clipAngle"
        case clipExtent = "clipExtent"
        case coefficient = "coefficient"
        case distance = "distance"
        case fraction = "fraction"
        case lobes = "lobes"
        case parallel = "parallel"
        case precision = "precision"
        case radius = "radius"
        case ratio = "ratio"
        case rotate = "rotate"
        case spacing = "spacing"
        case tilt = "tilt"
        case type = "type"
    }
}

// MARK: Projection convenience initializers and mutators

extension Projection {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Projection.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        center: [Double]?? = nil,
        clipAngle: Double?? = nil,
        clipExtent: [[Double]]?? = nil,
        coefficient: Double?? = nil,
        distance: Double?? = nil,
        fraction: Double?? = nil,
        lobes: Double?? = nil,
        parallel: Double?? = nil,
        precision: [String: TitleFontWeight]?? = nil,
        radius: Double?? = nil,
        ratio: Double?? = nil,
        rotate: [Double]?? = nil,
        spacing: Double?? = nil,
        tilt: Double?? = nil,
        type: VGProjectionType?? = nil
    ) -> Projection {
        return Projection(
            center: center ?? self.center,
            clipAngle: clipAngle ?? self.clipAngle,
            clipExtent: clipExtent ?? self.clipExtent,
            coefficient: coefficient ?? self.coefficient,
            distance: distance ?? self.distance,
            fraction: fraction ?? self.fraction,
            lobes: lobes ?? self.lobes,
            parallel: parallel ?? self.parallel,
            precision: precision ?? self.precision,
            radius: radius ?? self.radius,
            ratio: ratio ?? self.ratio,
            rotate: rotate ?? self.rotate,
            spacing: spacing ?? self.spacing,
            tilt: tilt ?? self.tilt,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
// MARK: - Resolve
struct Resolve: Codable {
    let axis: AxisResolveMap?
    let legend: LegendResolveMap?
    let scale: ScaleResolveMap?

    enum CodingKeys: String, CodingKey {
        case axis = "axis"
        case legend = "legend"
        case scale = "scale"
    }
}

// MARK: Resolve convenience initializers and mutators

extension Resolve {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Resolve.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        axis: AxisResolveMap?? = nil,
        legend: LegendResolveMap?? = nil,
        scale: ScaleResolveMap?? = nil
    ) -> Resolve {
        return Resolve(
            axis: axis ?? self.axis,
            legend: legend ?? self.legend,
            scale: scale ?? self.scale
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AxisResolveMap
struct AxisResolveMap: Codable {
    let x: ResolveMode?
    let y: ResolveMode?

    enum CodingKeys: String, CodingKey {
        case x = "x"
        case y = "y"
    }
}

// MARK: AxisResolveMap convenience initializers and mutators

extension AxisResolveMap {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AxisResolveMap.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        x: ResolveMode?? = nil,
        y: ResolveMode?? = nil
    ) -> AxisResolveMap {
        return AxisResolveMap(
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum ResolveMode: String, Codable {
    case independent = "independent"
    case shared = "shared"
}

// MARK: - LegendResolveMap
struct LegendResolveMap: Codable {
    let color: ResolveMode?
    let opacity: ResolveMode?
    let shape: ResolveMode?
    let size: ResolveMode?

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case opacity = "opacity"
        case shape = "shape"
        case size = "size"
    }
}

// MARK: LegendResolveMap convenience initializers and mutators

extension LegendResolveMap {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LegendResolveMap.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: ResolveMode?? = nil,
        opacity: ResolveMode?? = nil,
        shape: ResolveMode?? = nil,
        size: ResolveMode?? = nil
    ) -> LegendResolveMap {
        return LegendResolveMap(
            color: color ?? self.color,
            opacity: opacity ?? self.opacity,
            shape: shape ?? self.shape,
            size: size ?? self.size
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ScaleResolveMap
struct ScaleResolveMap: Codable {
    let color: ResolveMode?
    let opacity: ResolveMode?
    let shape: ResolveMode?
    let size: ResolveMode?
    let x: ResolveMode?
    let y: ResolveMode?

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case opacity = "opacity"
        case shape = "shape"
        case size = "size"
        case x = "x"
        case y = "y"
    }
}

// MARK: ScaleResolveMap convenience initializers and mutators

extension ScaleResolveMap {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ScaleResolveMap.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: ResolveMode?? = nil,
        opacity: ResolveMode?? = nil,
        shape: ResolveMode?? = nil,
        size: ResolveMode?? = nil,
        x: ResolveMode?? = nil,
        y: ResolveMode?? = nil
    ) -> ScaleResolveMap {
        return ScaleResolveMap(
            color: color ?? self.color,
            opacity: opacity ?? self.opacity,
            shape: shape ?? self.shape,
            size: size ?? self.size,
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SelectionDef
struct SelectionDef: Codable {
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
    let bind: BindUnion?
    /// By default, all data values are considered to lie within an empty selection.
    /// When set to `none`, empty selections contain no data values.
    let empty: Empty?
    /// An array of encoding channels. The corresponding data field values
    /// must match for a data tuple to fall within the selection.
    let encodings: [SingleDefChannel]?
    /// An array of field names whose values must match for a data tuple to
    /// fall within the selection.
    let fields: [String]?
    /// When true, an invisible voronoi diagram is computed to accelerate discrete
    /// selection. The data value _nearest_ the mouse cursor is added to the selection.
    ///
    /// See the [nearest transform](nearest.html) documentation for more information.
    let nearest: Bool?
    /// A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    /// selector) that triggers the selection.
    /// For interval selections, the event stream must specify a [start and
    /// end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    let on: JSONAny?
    /// With layered and multi-view displays, a strategy that determines how
    /// selections' data queries are resolved when applied in a filter transform,
    /// conditional encoding rule, or scale domain.
    let resolve: SelectionResolution?
    let type: SelectionDefType
    /// Controls whether data values should be toggled or only ever inserted into
    /// multi selections. Can be `true`, `false` (for insertion only), or a
    /// [Vega expression](https://vega.github.io/vega/docs/expressions/).
    ///
    /// __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    /// data values are toggled when a user interacts with the shift-key pressed).
    ///
    /// See the [toggle transform](toggle.html) documentation for more information.
    let toggle: Translate?
    /// An interval selection also adds a rectangle mark to depict the
    /// extents of the interval. The `mark` property can be used to customize the
    /// appearance of the mark.
    let mark: BrushConfig?
    /// When truthy, allows a user to interactively move an interval selection
    /// back-and-forth. Can be `true`, `false` (to disable panning), or a
    /// [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    /// which must include a start and end event to trigger continuous panning.
    ///
    /// __Default value:__ `true`, which corresponds to
    /// `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    /// clicks and dragging within an interval selection to reposition it.
    let translate: Translate?
    /// When truthy, allows a user to interactively resize an interval selection.
    /// Can be `true`, `false` (to disable zooming), or a [Vega event stream
    /// definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    /// only `wheel` events are supported.
    ///
    ///
    /// __Default value:__ `true`, which corresponds to `wheel!`.
    let zoom: Translate?

    enum CodingKeys: String, CodingKey {
        case bind = "bind"
        case empty = "empty"
        case encodings = "encodings"
        case fields = "fields"
        case nearest = "nearest"
        case on = "on"
        case resolve = "resolve"
        case type = "type"
        case toggle = "toggle"
        case mark = "mark"
        case translate = "translate"
        case zoom = "zoom"
    }
}

// MARK: SelectionDef convenience initializers and mutators

extension SelectionDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SelectionDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bind: BindUnion?? = nil,
        empty: Empty?? = nil,
        encodings: [SingleDefChannel]?? = nil,
        fields: [String]?? = nil,
        nearest: Bool?? = nil,
        on: JSONAny?? = nil,
        resolve: SelectionResolution?? = nil,
        type: SelectionDefType? = nil,
        toggle: Translate?? = nil,
        mark: BrushConfig?? = nil,
        translate: Translate?? = nil,
        zoom: Translate?? = nil
    ) -> SelectionDef {
        return SelectionDef(
            bind: bind ?? self.bind,
            empty: empty ?? self.empty,
            encodings: encodings ?? self.encodings,
            fields: fields ?? self.fields,
            nearest: nearest ?? self.nearest,
            on: on ?? self.on,
            resolve: resolve ?? self.resolve,
            type: type ?? self.type,
            toggle: toggle ?? self.toggle,
            mark: mark ?? self.mark,
            translate: translate ?? self.translate,
            zoom: zoom ?? self.zoom
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum BindUnion: Codable {
    case enumeration(BindEnum)
    case vgBindingMap([String: VGBinding])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(BindEnum.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode([String: VGBinding].self) {
            self = .vgBindingMap(x)
            return
        }
        throw DecodingError.typeMismatch(BindUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BindUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .vgBindingMap(let x):
            try container.encode(x)
        }
    }
}

enum SelectionDefType: String, Codable {
    case single = "single"
    case multi = "multi"
    case interval = "interval"
}

enum Title: Codable {
    case string(String)
    case titleParams(TitleParams)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(TitleParams.self) {
            self = .titleParams(x)
            return
        }
        throw DecodingError.typeMismatch(Title.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Title"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .titleParams(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TitleParams
struct TitleParams: Codable {
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
    let anchor: Anchor?
    /// The orthogonal offset in pixels by which to displace the title from its position along
    /// the edge of the chart.
    let offset: Double?
    /// The orientation of the title relative to the chart. One of `"top"` (the default),
    /// `"bottom"`, `"left"`, or `"right"`.
    let orient: TitleOrient?
    /// A [mark style property](config.html#style) to apply to the title text mark.
    ///
    /// __Default value:__ `"group-title"`.
    let style: Style?
    /// The title text.
    let text: String

    enum CodingKeys: String, CodingKey {
        case anchor = "anchor"
        case offset = "offset"
        case orient = "orient"
        case style = "style"
        case text = "text"
    }
}

// MARK: TitleParams convenience initializers and mutators

extension TitleParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TitleParams.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        anchor: Anchor?? = nil,
        offset: Double?? = nil,
        orient: TitleOrient?? = nil,
        style: Style?? = nil,
        text: String? = nil
    ) -> TitleParams {
        return TitleParams(
            anchor: anchor ?? self.anchor,
            offset: offset ?? self.offset,
            orient: orient ?? self.orient,
            style: style ?? self.style,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Transform
struct Transform: Codable {
    /// The `filter` property must be one of the predicate definitions:
    /// (1) an [expression](types.html#expression) string,
    /// where `datum` can be used to refer to the current data object;
    /// (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
    /// [range predicate](filter.html#range-predicate), [one-of
    /// predicate](filter.html#one-of-predicate);
    /// (3) a [selection predicate](filter.html#selection-predicate);
    /// or (4) a logical operand that combines (1), (2), or (3).
    let filter: LogicalOperandPredicate?
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
    let transformAs: Style?
    /// A [expression](types.html#expression) string. Use the variable `datum` to refer to the
    /// current data object.
    let calculate: String?
    /// The default value to use if lookup fails.
    ///
    /// __Default value:__ `null`
    let transformDefault: String?
    /// Secondary data reference.
    let from: LookupData?
    /// Key in primary data source.
    let lookup: String?
    /// An object indicating bin properties, or simply `true` for using default bin parameters.
    let bin: Bin?
    /// The data field to bin.
    ///
    /// The data field to apply time unit.
    let field: String?
    /// The timeUnit.
    let timeUnit: TimeUnit?
    /// Array of objects that define fields to aggregate.
    let aggregate: [AggregatedFieldDef]?
    /// The data fields to group by. If not specified, a single group containing all data objects
    /// will be used.
    let groupby: [String]?

    enum CodingKeys: String, CodingKey {
        case filter = "filter"
        case transformAs = "as"
        case calculate = "calculate"
        case transformDefault = "default"
        case from = "from"
        case lookup = "lookup"
        case bin = "bin"
        case field = "field"
        case timeUnit = "timeUnit"
        case aggregate = "aggregate"
        case groupby = "groupby"
    }
}

// MARK: Transform convenience initializers and mutators

extension Transform {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Transform.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        filter: LogicalOperandPredicate?? = nil,
        transformAs: Style?? = nil,
        calculate: String?? = nil,
        transformDefault: String?? = nil,
        from: LookupData?? = nil,
        lookup: String?? = nil,
        bin: Bin?? = nil,
        field: String?? = nil,
        timeUnit: TimeUnit?? = nil,
        aggregate: [AggregatedFieldDef]?? = nil,
        groupby: [String]?? = nil
    ) -> Transform {
        return Transform(
            filter: filter ?? self.filter,
            transformAs: transformAs ?? self.transformAs,
            calculate: calculate ?? self.calculate,
            transformDefault: transformDefault ?? self.transformDefault,
            from: from ?? self.from,
            lookup: lookup ?? self.lookup,
            bin: bin ?? self.bin,
            field: field ?? self.field,
            timeUnit: timeUnit ?? self.timeUnit,
            aggregate: aggregate ?? self.aggregate,
            groupby: groupby ?? self.groupby
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AggregatedFieldDef
struct AggregatedFieldDef: Codable {
    /// The output field names to use for each aggregated field.
    let aggregatedFieldDefAs: String
    /// The data field for which to compute aggregate function.
    let field: String
    /// The aggregation operations to apply to the fields, such as sum, average or count.
    /// See the [full list of supported aggregation
    /// operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
    /// for more information.
    let op: AggregateOp

    enum CodingKeys: String, CodingKey {
        case aggregatedFieldDefAs = "as"
        case field = "field"
        case op = "op"
    }
}

// MARK: AggregatedFieldDef convenience initializers and mutators

extension AggregatedFieldDef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AggregatedFieldDef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        aggregatedFieldDefAs: String? = nil,
        field: String? = nil,
        op: AggregateOp? = nil
    ) -> AggregatedFieldDef {
        return AggregatedFieldDef(
            aggregatedFieldDefAs: aggregatedFieldDefAs ?? self.aggregatedFieldDefAs,
            field: field ?? self.field,
            op: op ?? self.op
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Secondary data reference.
// MARK: - LookupData
struct LookupData: Codable {
    /// Secondary data source to lookup in.
    let data: DataClass
    /// Fields in foreign data to lookup.
    /// If not specified, the entire object is queried.
    let fields: [String]?
    /// Key in data to lookup.
    let key: String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case fields = "fields"
        case key = "key"
    }
}

// MARK: LookupData convenience initializers and mutators

extension LookupData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LookupData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: DataClass? = nil,
        fields: [String]?? = nil,
        key: String? = nil
    ) -> LookupData {
        return LookupData(
            data: data ?? self.data,
            fields: fields ?? self.fields,
            key: key ?? self.key
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// An object that describes what fields should be repeated into views that are laid out as a
/// `row` or `column`.
// MARK: - Repeat
struct Repeat: Codable {
    /// Horizontal repeated views.
    let column: [String]?
    /// Vertical repeated views.
    let row: [String]?

    enum CodingKeys: String, CodingKey {
        case column = "column"
        case row = "row"
    }
}

// MARK: Repeat convenience initializers and mutators

extension Repeat {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repeat.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        column: [String]?? = nil,
        row: [String]?? = nil
    ) -> Repeat {
        return Repeat(
            column: column ?? self.column,
            row: row ?? self.row
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
    })
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    encoder.dateEncodingStrategy = .formatted(formatter)
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
