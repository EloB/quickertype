package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * Unit spec that can have a composite mark.
 */
public class LayerSpec {
    private Data data;
    private String description;
    private Double height;
    private List<LayerSpec> layer;
    private String name;
    private Resolve resolve;
    private Title title;
    private List<Transform> transform;
    private Double width;
    private Encoding encoding;
    private AnyMark mark;
    private Projection projection;
    private Map<String, SelectionDef> selection;

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
     * Name of the visualization for later reference.
     */
    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    /**
     * Scale, axis, and legend resolutions for layers.
     */
    @JsonProperty("resolve")
    public Resolve getResolve() { return resolve; }
    @JsonProperty("resolve")
    public void setResolve(Resolve value) { this.resolve = value; }

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
     * A key-value mapping between encoding channels and definition of fields.
     */
    @JsonProperty("encoding")
    public Encoding getEncoding() { return encoding; }
    @JsonProperty("encoding")
    public void setEncoding(Encoding value) { this.encoding = value; }

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
}
