package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class TopLevel {
    private String schema;
    private Autosize autosize;
    private String background;
    private Config config;
    private Data data;
    private String description;
    private EncodingWithFacet encoding;
    private Double height;
    private AnyMark mark;
    private String name;
    private Padding padding;
    private Projection projection;
    private Map<String, SelectionDef> selection;
    private Title title;
    private List<Transform> transform;
    private Double width;
    private List<LayerSpec> layer;
    private Resolve resolve;
    private FacetMapping facet;
    private Spec spec;
    private Repeat repeat;
    private List<Spec> vconcat;
    private List<Spec> hconcat;

    /**
     * URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
     * have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
     * Setting the `$schema` property allows automatic validation and autocomplete in editors
     * that support JSON schema.
     */
    @JsonProperty("$schema")
    public String getSchema() { return schema; }
    @JsonProperty("$schema")
    public void setSchema(String value) { this.schema = value; }

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
     * CSS color property to use as the background of visualization.
     *
     * __Default value:__ none (transparent)
     */
    @JsonProperty("background")
    public String getBackground() { return background; }
    @JsonProperty("background")
    public void setBackground(String value) { this.background = value; }

    /**
     * Vega-Lite configuration object.  This property can only be defined at the top-level of a
     * specification.
     */
    @JsonProperty("config")
    public Config getConfig() { return config; }
    @JsonProperty("config")
    public void setConfig(Config value) { this.config = value; }

    /**
     * An object describing the data source
     */
    @JsonProperty("data")
    public Data getData() { return data; }
    @JsonProperty("data")
    public void setData(Data value) { this.data = value; }

    /**
     * Description of this mark for commenting purpose.
     */
    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    @JsonProperty("encoding")
    public EncodingWithFacet getEncoding() { return encoding; }
    @JsonProperty("encoding")
    public void setEncoding(EncodingWithFacet value) { this.encoding = value; }

    /**
     * The height of a visualization.
     *
     * __Default value:__
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
     * [continuous scale](scale.html#continuous), the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the height is [determined by the range step, paddings, and the
     * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
     * `rangeStep` is `null`, the height will be the value of
     * [`config.view.height`](spec.html#config).
     * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
     *
     * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the height of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    @JsonProperty("height")
    public Double getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(Double value) { this.height = value; }

    /**
     * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
     * `"line"`,
     * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
     * object](mark.html#mark-def).
     */
    @JsonProperty("mark")
    public AnyMark getMark() { return mark; }
    @JsonProperty("mark")
    public void setMark(AnyMark value) { this.mark = value; }

    /**
     * Name of the visualization for later reference.
     */
    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

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
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    @JsonProperty("projection")
    public Projection getProjection() { return projection; }
    @JsonProperty("projection")
    public void setProjection(Projection value) { this.projection = value; }

    /**
     * A key-value mapping between selection names and definitions.
     */
    @JsonProperty("selection")
    public Map<String, SelectionDef> getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(Map<String, SelectionDef> value) { this.selection = value; }

    /**
     * Title for the plot.
     */
    @JsonProperty("title")
    public Title getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(Title value) { this.title = value; }

    /**
     * An array of data transformations such as filter and new field calculation.
     */
    @JsonProperty("transform")
    public List<Transform> getTransform() { return transform; }
    @JsonProperty("transform")
    public void setTransform(List<Transform> value) { this.transform = value; }

    /**
     * The width of a visualization.
     *
     * __Default value:__ This will be determined by the following rules:
     *
     * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
     * [continuous scale](scale.html#continuous), the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
     * value or unspecified, the width is [determined by the range step, paddings, and the
     * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
     * `rangeStep` is `null`, the width will be the value of
     * [`config.view.width`](spec.html#config).
     * - If no field is mapped to `x` channel, the `width` will be the value of
     * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
     * the value of `rangeStep` for other marks.
     *
     * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
     * represents the width of a single view.
     *
     * __See also:__ The documentation for [width and height](size.html) contains more examples.
     */
    @JsonProperty("width")
    public Double getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Double value) { this.width = value; }

    /**
     * Layer or single view specifications to be layered.
     *
     * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
     * layering facet specifications is not allowed.
     */
    @JsonProperty("layer")
    public List<LayerSpec> getLayer() { return layer; }
    @JsonProperty("layer")
    public void setLayer(List<LayerSpec> value) { this.layer = value; }

    /**
     * Scale, axis, and legend resolutions for layers.
     *
     * Scale, axis, and legend resolutions for facets.
     *
     * Scale and legend resolutions for repeated charts.
     *
     * Scale, axis, and legend resolutions for vertically concatenated charts.
     *
     * Scale, axis, and legend resolutions for horizontally concatenated charts.
     */
    @JsonProperty("resolve")
    public Resolve getResolve() { return resolve; }
    @JsonProperty("resolve")
    public void setResolve(Resolve value) { this.resolve = value; }

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    @JsonProperty("facet")
    public FacetMapping getFacet() { return facet; }
    @JsonProperty("facet")
    public void setFacet(FacetMapping value) { this.facet = value; }

    /**
     * A specification of the view that gets faceted.
     */
    @JsonProperty("spec")
    public Spec getSpec() { return spec; }
    @JsonProperty("spec")
    public void setSpec(Spec value) { this.spec = value; }

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    @JsonProperty("repeat")
    public Repeat getRepeat() { return repeat; }
    @JsonProperty("repeat")
    public void setRepeat(Repeat value) { this.repeat = value; }

    /**
     * A list of views that should be concatenated and put into a column.
     */
    @JsonProperty("vconcat")
    public List<Spec> getVconcat() { return vconcat; }
    @JsonProperty("vconcat")
    public void setVconcat(List<Spec> value) { this.vconcat = value; }

    /**
     * A list of views that should be concatenated and put into a row.
     */
    @JsonProperty("hconcat")
    public List<Spec> getHconcat() { return hconcat; }
    @JsonProperty("hconcat")
    public void setHconcat(List<Spec> value) { this.hconcat = value; }
}
