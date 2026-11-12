package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * Vega-Lite configuration object.  This property can only be defined at the top-level of a
 * specification.
 */
public class Config {
    private MarkConfig area;
    private Autosize autosize;
    private AxisConfig axis;
    private VGAxisConfig axisBand;
    private VGAxisConfig axisBottom;
    private VGAxisConfig axisLeft;
    private VGAxisConfig axisRight;
    private VGAxisConfig axisTop;
    private VGAxisConfig axisX;
    private VGAxisConfig axisY;
    private String background;
    private BarConfig bar;
    private MarkConfig circle;
    private String countTitle;
    private FieldTitle fieldTitle;
    private MarkConfig geoshape;
    private InvalidValues invalidValues;
    private LegendConfig legend;
    private MarkConfig line;
    private MarkConfig mark;
    private String numberFormat;
    private Padding padding;
    private MarkConfig point;
    private ProjectionConfig projection;
    private Map<String, RangeConfigValue> range;
    private MarkConfig rect;
    private MarkConfig rule;
    private ScaleConfig scale;
    private SelectionConfig selection;
    private MarkConfig square;
    private StackOffset stack;
    private Map<String, VGMarkConfig> style;
    private TextConfig text;
    private TickConfig tick;
    private String timeFormat;
    private VGTitleConfig title;
    private ViewConfig view;

    /**
     * Area-Specific Config
     */
    @JsonProperty("area")
    public MarkConfig getArea() { return area; }
    @JsonProperty("area")
    public void setArea(MarkConfig value) { this.area = value; }

    /**
     * Sets how the visualization size should be determined. If a string, should be one of
     * `"pad"`, `"fit"` or `"none"`.
     * Object values can additionally specify parameters for content sizing and automatic
     * resizing.
     * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
     *
     * __Default value__: `pad`
     */
    @JsonProperty("autosize")
    public Autosize getAutosize() { return autosize; }
    @JsonProperty("autosize")
    public void setAutosize(Autosize value) { this.autosize = value; }

    /**
     * Axis configuration, which determines default properties for all `x` and `y`
     * [axes](axis.html). For a full list of axis configuration options, please see the
     * [corresponding section of the axis documentation](axis.html#config).
     */
    @JsonProperty("axis")
    public AxisConfig getAxis() { return axis; }
    @JsonProperty("axis")
    public void setAxis(AxisConfig value) { this.axis = value; }

    /**
     * Specific axis config for axes with "band" scales.
     */
    @JsonProperty("axisBand")
    public VGAxisConfig getAxisBand() { return axisBand; }
    @JsonProperty("axisBand")
    public void setAxisBand(VGAxisConfig value) { this.axisBand = value; }

    /**
     * Specific axis config for x-axis along the bottom edge of the chart.
     */
    @JsonProperty("axisBottom")
    public VGAxisConfig getAxisBottom() { return axisBottom; }
    @JsonProperty("axisBottom")
    public void setAxisBottom(VGAxisConfig value) { this.axisBottom = value; }

    /**
     * Specific axis config for y-axis along the left edge of the chart.
     */
    @JsonProperty("axisLeft")
    public VGAxisConfig getAxisLeft() { return axisLeft; }
    @JsonProperty("axisLeft")
    public void setAxisLeft(VGAxisConfig value) { this.axisLeft = value; }

    /**
     * Specific axis config for y-axis along the right edge of the chart.
     */
    @JsonProperty("axisRight")
    public VGAxisConfig getAxisRight() { return axisRight; }
    @JsonProperty("axisRight")
    public void setAxisRight(VGAxisConfig value) { this.axisRight = value; }

    /**
     * Specific axis config for x-axis along the top edge of the chart.
     */
    @JsonProperty("axisTop")
    public VGAxisConfig getAxisTop() { return axisTop; }
    @JsonProperty("axisTop")
    public void setAxisTop(VGAxisConfig value) { this.axisTop = value; }

    /**
     * X-axis specific config.
     */
    @JsonProperty("axisX")
    public VGAxisConfig getAxisX() { return axisX; }
    @JsonProperty("axisX")
    public void setAxisX(VGAxisConfig value) { this.axisX = value; }

    /**
     * Y-axis specific config.
     */
    @JsonProperty("axisY")
    public VGAxisConfig getAxisY() { return axisY; }
    @JsonProperty("axisY")
    public void setAxisY(VGAxisConfig value) { this.axisY = value; }

    /**
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    @JsonProperty("background")
    public String getBackground() { return background; }
    @JsonProperty("background")
    public void setBackground(String value) { this.background = value; }

    /**
     * Bar-Specific Config
     */
    @JsonProperty("bar")
    public BarConfig getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(BarConfig value) { this.bar = value; }

    /**
     * Circle-Specific Config
     */
    @JsonProperty("circle")
    public MarkConfig getCircle() { return circle; }
    @JsonProperty("circle")
    public void setCircle(MarkConfig value) { this.circle = value; }

    /**
     * Default axis and legend title for count fields.
     *
     * __Default value:__ `'Number of Records'`.
     */
    @JsonProperty("countTitle")
    public String getCountTitle() { return countTitle; }
    @JsonProperty("countTitle")
    public void setCountTitle(String value) { this.countTitle = value; }

    /**
     * Defines how Vega-Lite generates title for fields.  There are three possible styles:
     *
     * - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
     * "Year-month of date", "field (binned)").
     * - `"function"` - displays function using parentheses and capitalized texts (e.g.,
     * "SUM(field)", "YEARMONTH(date)", "BIN(field)").
     * - `"plain"` - displays only the field name without functions (e.g., "field", "date",
     * "field").
     */
    @JsonProperty("fieldTitle")
    public FieldTitle getFieldTitle() { return fieldTitle; }
    @JsonProperty("fieldTitle")
    public void setFieldTitle(FieldTitle value) { this.fieldTitle = value; }

    /**
     * Geoshape-Specific Config
     */
    @JsonProperty("geoshape")
    public MarkConfig getGeoshape() { return geoshape; }
    @JsonProperty("geoshape")
    public void setGeoshape(MarkConfig value) { this.geoshape = value; }

    /**
     * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
     * - If set to `"filter"` (default), all data items with null values are filtered.
     * - If `null`, all data items are included. In this case, invalid values will be
     * interpreted as zeroes.
     */
    @JsonProperty("invalidValues")
    public InvalidValues getInvalidValues() { return invalidValues; }
    @JsonProperty("invalidValues")
    public void setInvalidValues(InvalidValues value) { this.invalidValues = value; }

    /**
     * Legend configuration, which determines default properties for all [legends](legend.html).
     * For a full list of legend configuration options, please see the [corresponding section of
     * in the legend documentation](legend.html#config).
     */
    @JsonProperty("legend")
    public LegendConfig getLegend() { return legend; }
    @JsonProperty("legend")
    public void setLegend(LegendConfig value) { this.legend = value; }

    /**
     * Line-Specific Config
     */
    @JsonProperty("line")
    public MarkConfig getLine() { return line; }
    @JsonProperty("line")
    public void setLine(MarkConfig value) { this.line = value; }

    /**
     * Mark Config
     */
    @JsonProperty("mark")
    public MarkConfig getMark() { return mark; }
    @JsonProperty("mark")
    public void setMark(MarkConfig value) { this.mark = value; }

    /**
     * D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
     * number format pattern](https://github.com/d3/d3-format#locale_format).
     */
    @JsonProperty("numberFormat")
    public String getNumberFormat() { return numberFormat; }
    @JsonProperty("numberFormat")
    public void setNumberFormat(String value) { this.numberFormat = value; }

    /**
     * The default visualization padding, in pixels, from the edge of the visualization canvas
     * to the data rectangle.  If a number, specifies padding for all sides.
     * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
     * "bottom": 5}` to specify padding for each side of the visualization.
     *
     * __Default value__: `5`
     */
    @JsonProperty("padding")
    public Padding getPadding() { return padding; }
    @JsonProperty("padding")
    public void setPadding(Padding value) { this.padding = value; }

    /**
     * Point-Specific Config
     */
    @JsonProperty("point")
    public MarkConfig getPoint() { return point; }
    @JsonProperty("point")
    public void setPoint(MarkConfig value) { this.point = value; }

    /**
     * Projection configuration, which determines default properties for all
     * [projections](projection.html). For a full list of projection configuration options,
     * please see the [corresponding section of the projection
     * documentation](projection.html#config).
     */
    @JsonProperty("projection")
    public ProjectionConfig getProjection() { return projection; }
    @JsonProperty("projection")
    public void setProjection(ProjectionConfig value) { this.projection = value; }

    /**
     * An object hash that defines default range arrays or schemes for using with scales.
     * For a full list of scale range configuration options, please see the [corresponding
     * section of the scale documentation](scale.html#config).
     */
    @JsonProperty("range")
    public Map<String, RangeConfigValue> getRange() { return range; }
    @JsonProperty("range")
    public void setRange(Map<String, RangeConfigValue> value) { this.range = value; }

    /**
     * Rect-Specific Config
     */
    @JsonProperty("rect")
    public MarkConfig getRect() { return rect; }
    @JsonProperty("rect")
    public void setRect(MarkConfig value) { this.rect = value; }

    /**
     * Rule-Specific Config
     */
    @JsonProperty("rule")
    public MarkConfig getRule() { return rule; }
    @JsonProperty("rule")
    public void setRule(MarkConfig value) { this.rule = value; }

    /**
     * Scale configuration determines default properties for all [scales](scale.html). For a
     * full list of scale configuration options, please see the [corresponding section of the
     * scale documentation](scale.html#config).
     */
    @JsonProperty("scale")
    public ScaleConfig getScale() { return scale; }
    @JsonProperty("scale")
    public void setScale(ScaleConfig value) { this.scale = value; }

    /**
     * An object hash for defining default properties for each type of selections.
     */
    @JsonProperty("selection")
    public SelectionConfig getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(SelectionConfig value) { this.selection = value; }

    /**
     * Square-Specific Config
     */
    @JsonProperty("square")
    public MarkConfig getSquare() { return square; }
    @JsonProperty("square")
    public void setSquare(MarkConfig value) { this.square = value; }

    /**
     * Default stack offset for stackable mark.
     */
    @JsonProperty("stack")
    public StackOffset getStack() { return stack; }
    @JsonProperty("stack")
    public void setStack(StackOffset value) { this.stack = value; }

    /**
     * An object hash that defines key-value mappings to determine default properties for marks
     * with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
     * valid [mark configuration objects](mark.html#config).
     */
    @JsonProperty("style")
    public Map<String, VGMarkConfig> getStyle() { return style; }
    @JsonProperty("style")
    public void setStyle(Map<String, VGMarkConfig> value) { this.style = value; }

    /**
     * Text-Specific Config
     */
    @JsonProperty("text")
    public TextConfig getText() { return text; }
    @JsonProperty("text")
    public void setText(TextConfig value) { this.text = value; }

    /**
     * Tick-Specific Config
     */
    @JsonProperty("tick")
    public TickConfig getTick() { return tick; }
    @JsonProperty("tick")
    public void setTick(TickConfig value) { this.tick = value; }

    /**
     * Default datetime format for axis and legend labels. The format can be set directly on
     * each axis and legend. Use [D3's time format
     * pattern](https://github.com/d3/d3-time-format#locale_format).
     *
     * __Default value:__ `'%b %d, %Y'`.
     */
    @JsonProperty("timeFormat")
    public String getTimeFormat() { return timeFormat; }
    @JsonProperty("timeFormat")
    public void setTimeFormat(String value) { this.timeFormat = value; }

    /**
     * Title configuration, which determines default properties for all [titles](title.html).
     * For a full list of title configuration options, please see the [corresponding section of
     * the title documentation](title.html#config).
     */
    @JsonProperty("title")
    public VGTitleConfig getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(VGTitleConfig value) { this.title = value; }

    /**
     * Default properties for [single view plots](spec.html#single).
     */
    @JsonProperty("view")
    public ViewConfig getView() { return view; }
    @JsonProperty("view")
    public void setView(ViewConfig value) { this.view = value; }
}
