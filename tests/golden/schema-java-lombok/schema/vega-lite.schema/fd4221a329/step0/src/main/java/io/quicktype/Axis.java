package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Axis {
    private Boolean domain;
    private String format;
    private Boolean grid;
    private Double labelAngle;
    private Label labelBound;
    private Label labelFlush;
    private LabelOverlapUnion labelOverlap;
    private Double labelPadding;
    private Boolean labels;
    private Double maxExtent;
    private Double minExtent;
    private Double offset;
    private TitleOrient orient;
    private Double position;
    private Double tickCount;
    private Boolean ticks;
    private Double tickSize;
    private String title;
    private Double titleMaxLength;
    private Double titlePadding;
    private List<AxisValue> values;
    private Double zindex;

    /**
     * A boolean flag indicating if the domain (the axis baseline) should be included as part of
     * the axis.
     *
     * __Default value:__ `true`
     */
    @JsonProperty("domain")
    public Boolean getDomain() { return domain; }
    @JsonProperty("domain")
    public void setDomain(Boolean value) { this.domain = value; }

    /**
     * The formatting pattern for labels. This is D3's [number format
     * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
     * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
     * field.
     *
     * See the [format documentation](format.html) for more information.
     *
     * __Default value:__  derived from [numberFormat](config.html#format) config for
     * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
     */
    @JsonProperty("format")
    public String getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(String value) { this.format = value; }

    /**
     * A boolean flag indicating if grid lines should be included as part of the axis
     *
     * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
     * binned; otherwise, `false`.
     */
    @JsonProperty("grid")
    public Boolean getGrid() { return grid; }
    @JsonProperty("grid")
    public void setGrid(Boolean value) { this.grid = value; }

    /**
     * The rotation angle of the axis labels.
     *
     * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
     */
    @JsonProperty("labelAngle")
    public Double getLabelAngle() { return labelAngle; }
    @JsonProperty("labelAngle")
    public void setLabelAngle(Double value) { this.labelAngle = value; }

    /**
     * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
     * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
     * they exceed the axis range by more than 1 pixel. If this property is a number, it
     * specifies the pixel tolerance: the maximum amount by which a label bounding box may
     * exceed the axis range.
     *
     * __Default value:__ `false`.
     */
    @JsonProperty("labelBound")
    public Label getLabelBound() { return labelBound; }
    @JsonProperty("labelBound")
    public void setLabelBound(Label value) { this.labelBound = value; }

    /**
     * Indicates if the first and last axis labels should be aligned flush with the scale range.
     * Flush alignment for a horizontal axis will left-align the first label and right-align the
     * last label. For vertical axes, bottom and top text baselines are applied instead. If this
     * property is a number, it also indicates the number of pixels by which to offset the first
     * and last labels; for example, a value of 2 will flush-align the first and last labels and
     * also push them 2 pixels outward from the center of the axis. The additional adjustment
     * can sometimes help the labels better visually group with corresponding axis ticks.
     *
     * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
     */
    @JsonProperty("labelFlush")
    public Label getLabelFlush() { return labelFlush; }
    @JsonProperty("labelFlush")
    public void setLabelFlush(Label value) { this.labelFlush = value; }

    /**
     * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
     * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
     * every other label is used (this works well for standard linear axes). If set to
     * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
     * with the last visible label (this often works better for log-scaled axes).
     *
     * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
     * scales; otherwise `false`.
     */
    @JsonProperty("labelOverlap")
    public LabelOverlapUnion getLabelOverlap() { return labelOverlap; }
    @JsonProperty("labelOverlap")
    public void setLabelOverlap(LabelOverlapUnion value) { this.labelOverlap = value; }

    /**
     * The padding, in pixels, between axis and text labels.
     */
    @JsonProperty("labelPadding")
    public Double getLabelPadding() { return labelPadding; }
    @JsonProperty("labelPadding")
    public void setLabelPadding(Double value) { this.labelPadding = value; }

    /**
     * A boolean flag indicating if labels should be included as part of the axis.
     *
     * __Default value:__  `true`.
     */
    @JsonProperty("labels")
    public Boolean getLabels() { return labels; }
    @JsonProperty("labels")
    public void setLabels(Boolean value) { this.labels = value; }

    /**
     * The maximum extent in pixels that axis ticks and labels should use. This determines a
     * maximum offset value for axis titles.
     *
     * __Default value:__ `undefined`.
     */
    @JsonProperty("maxExtent")
    public Double getMaxExtent() { return maxExtent; }
    @JsonProperty("maxExtent")
    public void setMaxExtent(Double value) { this.maxExtent = value; }

    /**
     * The minimum extent in pixels that axis ticks and labels should use. This determines a
     * minimum offset value for axis titles.
     *
     * __Default value:__ `30` for y-axis; `undefined` for x-axis.
     */
    @JsonProperty("minExtent")
    public Double getMinExtent() { return minExtent; }
    @JsonProperty("minExtent")
    public void setMinExtent(Double value) { this.minExtent = value; }

    /**
     * The offset, in pixels, by which to displace the axis from the edge of the enclosing group
     * or data rectangle.
     *
     * __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
     * `offset` (`0` by default)
     */
    @JsonProperty("offset")
    public Double getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(Double value) { this.offset = value; }

    /**
     * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
     * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
     * the right edge of the chart).
     *
     * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
     */
    @JsonProperty("orient")
    public TitleOrient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(TitleOrient value) { this.orient = value; }

    /**
     * The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
     * this sets the axis group x coordinate. For y-axis with left or right orientation, this
     * sets the axis group y coordinate.
     *
     * __Default value__: `0`
     */
    @JsonProperty("position")
    public Double getPosition() { return position; }
    @JsonProperty("position")
    public void setPosition(Double value) { this.position = value; }

    /**
     * A desired number of ticks, for axes visualizing quantitative scales. The resulting number
     * may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
     * underlying scale's range.
     */
    @JsonProperty("tickCount")
    public Double getTickCount() { return tickCount; }
    @JsonProperty("tickCount")
    public void setTickCount(Double value) { this.tickCount = value; }

    /**
     * Boolean value that determines whether the axis should include ticks.
     */
    @JsonProperty("ticks")
    public Boolean getTicks() { return ticks; }
    @JsonProperty("ticks")
    public void setTicks(Boolean value) { this.ticks = value; }

    /**
     * The size in pixels of axis ticks.
     */
    @JsonProperty("tickSize")
    public Double getTickSize() { return tickSize; }
    @JsonProperty("tickSize")
    public void setTickSize(Double value) { this.tickSize = value; }

    /**
     * A title for the field. If `null`, the title will be removed.
     *
     * __Default value:__  derived from the field's name and transformation function
     * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
     * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
     * binned or has a time unit applied, the applied function will be denoted in parentheses
     * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
     * simply the field name.
     *
     * __Note__: You can customize the default field title format by providing the [`fieldTitle`
     * property in the [config](config.html) or [`fieldTitle` function via the `compile`
     * function's options](compile.html#field-title).
     */
    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    /**
     * Max length for axis title if the title is automatically generated from the field's
     * description.
     */
    @JsonProperty("titleMaxLength")
    public Double getTitleMaxLength() { return titleMaxLength; }
    @JsonProperty("titleMaxLength")
    public void setTitleMaxLength(Double value) { this.titleMaxLength = value; }

    /**
     * The padding, in pixels, between title and axis.
     */
    @JsonProperty("titlePadding")
    public Double getTitlePadding() { return titlePadding; }
    @JsonProperty("titlePadding")
    public void setTitlePadding(Double value) { this.titlePadding = value; }

    /**
     * Explicitly set the visible axis tick values.
     */
    @JsonProperty("values")
    public List<AxisValue> getValues() { return values; }
    @JsonProperty("values")
    public void setValues(List<AxisValue> value) { this.values = value; }

    /**
     * A non-positive integer indicating z-index of the axis.
     * If zindex is 0, axes should be drawn behind all chart elements.
     * To put them in front, use `"zindex = 1"`.
     *
     * __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
     * for grids.
     */
    @JsonProperty("zindex")
    public Double getZindex() { return zindex; }
    @JsonProperty("zindex")
    public void setZindex(Double value) { this.zindex = value; }
}
