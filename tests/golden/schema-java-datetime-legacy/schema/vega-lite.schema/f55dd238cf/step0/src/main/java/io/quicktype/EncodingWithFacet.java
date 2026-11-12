package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * A key-value mapping between encoding channels and definition of fields.
 */
public class EncodingWithFacet {
    private MarkPropDefWithCondition color;
    private FacetFieldDef column;
    private Detail detail;
    private DefWithCondition href;
    private MarkPropDefWithCondition opacity;
    private Order order;
    private FacetFieldDef row;
    private MarkPropDefWithCondition shape;
    private MarkPropDefWithCondition size;
    private TextDefWithCondition text;
    private TextDefWithCondition tooltip;
    private XClass x;
    private X2Class x2;
    private XClass y;
    private X2Class y2;

    /**
     * Color of the marks – either fill or stroke color based on mark type.
     * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
     * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
     *
     * __Default value:__ If undefined, the default color depends on [mark
     * config](config.html#mark)'s `color` property.
     *
     * _Note:_ See the scale documentation for more information about customizing [color
     * scheme](scale.html#scheme).
     */
    @JsonProperty("color")
    public MarkPropDefWithCondition getColor() { return color; }
    @JsonProperty("color")
    public void setColor(MarkPropDefWithCondition value) { this.color = value; }

    /**
     * Horizontal facets for trellis plots.
     */
    @JsonProperty("column")
    public FacetFieldDef getColumn() { return column; }
    @JsonProperty("column")
    public void setColumn(FacetFieldDef value) { this.column = value; }

    /**
     * Additional levels of detail for grouping data in aggregate views and
     * in line and area marks without mapping data to a specific visual channel.
     */
    @JsonProperty("detail")
    public Detail getDetail() { return detail; }
    @JsonProperty("detail")
    public void setDetail(Detail value) { this.detail = value; }

    /**
     * A URL to load upon mouse click.
     */
    @JsonProperty("href")
    public DefWithCondition getHref() { return href; }
    @JsonProperty("href")
    public void setHref(DefWithCondition value) { this.href = value; }

    /**
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     */
    @JsonProperty("opacity")
    public MarkPropDefWithCondition getOpacity() { return opacity; }
    @JsonProperty("opacity")
    public void setOpacity(MarkPropDefWithCondition value) { this.opacity = value; }

    /**
     * Stack order for stacked marks or order of data points in line marks for connected scatter
     * plots.
     *
     * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
     * additional aggregation grouping.
     */
    @JsonProperty("order")
    public Order getOrder() { return order; }
    @JsonProperty("order")
    public void setOrder(Order value) { this.order = value; }

    /**
     * Vertical facets for trellis plots.
     */
    @JsonProperty("row")
    public FacetFieldDef getRow() { return row; }
    @JsonProperty("row")
    public void setRow(FacetFieldDef value) { this.row = value; }

    /**
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     */
    @JsonProperty("shape")
    public MarkPropDefWithCondition getShape() { return shape; }
    @JsonProperty("shape")
    public void setShape(MarkPropDefWithCondition value) { this.shape = value; }

    /**
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     */
    @JsonProperty("size")
    public MarkPropDefWithCondition getSize() { return size; }
    @JsonProperty("size")
    public void setSize(MarkPropDefWithCondition value) { this.size = value; }

    /**
     * Text of the `text` mark.
     */
    @JsonProperty("text")
    public TextDefWithCondition getText() { return text; }
    @JsonProperty("text")
    public void setText(TextDefWithCondition value) { this.text = value; }

    /**
     * The tooltip text to show upon mouse hover.
     */
    @JsonProperty("tooltip")
    public TextDefWithCondition getTooltip() { return tooltip; }
    @JsonProperty("tooltip")
    public void setTooltip(TextDefWithCondition value) { this.tooltip = value; }

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     */
    @JsonProperty("x")
    public XClass getX() { return x; }
    @JsonProperty("x")
    public void setX(XClass value) { this.x = value; }

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    @JsonProperty("x2")
    public X2Class getX2() { return x2; }
    @JsonProperty("x2")
    public void setX2(X2Class value) { this.x2 = value; }

    /**
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     */
    @JsonProperty("y")
    public XClass getY() { return y; }
    @JsonProperty("y")
    public void setY(XClass value) { this.y = value; }

    /**
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     */
    @JsonProperty("y2")
    public X2Class getY2() { return y2; }
    @JsonProperty("y2")
    public void setY2(X2Class value) { this.y2 = value; }
}
