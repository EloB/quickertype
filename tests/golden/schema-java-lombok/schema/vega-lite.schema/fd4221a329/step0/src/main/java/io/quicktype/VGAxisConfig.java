package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Specific axis config for axes with "band" scales.
 *
 * Specific axis config for x-axis along the bottom edge of the chart.
 *
 * Specific axis config for y-axis along the left edge of the chart.
 *
 * Specific axis config for y-axis along the right edge of the chart.
 *
 * Specific axis config for x-axis along the top edge of the chart.
 *
 * X-axis specific config.
 *
 * Y-axis specific config.
 */
public class VGAxisConfig {
    private Double bandPosition;
    private Boolean domain;
    private String domainColor;
    private Double domainWidth;
    private Boolean grid;
    private String gridColor;
    private List<Double> gridDash;
    private Double gridOpacity;
    private Double gridWidth;
    private Double labelAngle;
    private Label labelBound;
    private String labelColor;
    private Label labelFlush;
    private String labelFont;
    private Double labelFontSize;
    private Double labelLimit;
    private LabelOverlapUnion labelOverlap;
    private Double labelPadding;
    private Boolean labels;
    private Double maxExtent;
    private Double minExtent;
    private String tickColor;
    private Boolean tickRound;
    private Boolean ticks;
    private Double tickSize;
    private Double tickWidth;
    private String titleAlign;
    private Double titleAngle;
    private String titleBaseline;
    private String titleColor;
    private String titleFont;
    private Double titleFontSize;
    private TitleFontWeightUnion titleFontWeight;
    private Double titleLimit;
    private Double titleMaxLength;
    private Double titlePadding;
    private Double titleX;
    private Double titleY;

    /**
     * An interpolation fraction indicating where, for `band` scales, axis ticks should be
     * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
     * places ticks in the middle of their bands.
     */
    @JsonProperty("bandPosition")
    public Double getBandPosition() { return bandPosition; }
    @JsonProperty("bandPosition")
    public void setBandPosition(Double value) { this.bandPosition = value; }

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
     * Color of axis domain line.
     *
     * __Default value:__  (none, using Vega default).
     */
    @JsonProperty("domainColor")
    public String getDomainColor() { return domainColor; }
    @JsonProperty("domainColor")
    public void setDomainColor(String value) { this.domainColor = value; }

    /**
     * Stroke width of axis domain line
     *
     * __Default value:__  (none, using Vega default).
     */
    @JsonProperty("domainWidth")
    public Double getDomainWidth() { return domainWidth; }
    @JsonProperty("domainWidth")
    public void setDomainWidth(Double value) { this.domainWidth = value; }

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
     * Color of gridlines.
     */
    @JsonProperty("gridColor")
    public String getGridColor() { return gridColor; }
    @JsonProperty("gridColor")
    public void setGridColor(String value) { this.gridColor = value; }

    /**
     * The offset (in pixels) into which to begin drawing with the grid dash array.
     */
    @JsonProperty("gridDash")
    public List<Double> getGridDash() { return gridDash; }
    @JsonProperty("gridDash")
    public void setGridDash(List<Double> value) { this.gridDash = value; }

    /**
     * The stroke opacity of grid (value between [0,1])
     *
     * __Default value:__ (`1` by default)
     */
    @JsonProperty("gridOpacity")
    public Double getGridOpacity() { return gridOpacity; }
    @JsonProperty("gridOpacity")
    public void setGridOpacity(Double value) { this.gridOpacity = value; }

    /**
     * The grid width, in pixels.
     */
    @JsonProperty("gridWidth")
    public Double getGridWidth() { return gridWidth; }
    @JsonProperty("gridWidth")
    public void setGridWidth(Double value) { this.gridWidth = value; }

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
     * The color of the tick label, can be in hex color code or regular color name.
     */
    @JsonProperty("labelColor")
    public String getLabelColor() { return labelColor; }
    @JsonProperty("labelColor")
    public void setLabelColor(String value) { this.labelColor = value; }

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
     * The font of the tick label.
     */
    @JsonProperty("labelFont")
    public String getLabelFont() { return labelFont; }
    @JsonProperty("labelFont")
    public void setLabelFont(String value) { this.labelFont = value; }

    /**
     * The font size of the label, in pixels.
     */
    @JsonProperty("labelFontSize")
    public Double getLabelFontSize() { return labelFontSize; }
    @JsonProperty("labelFontSize")
    public void setLabelFontSize(Double value) { this.labelFontSize = value; }

    /**
     * Maximum allowed pixel width of axis tick labels.
     */
    @JsonProperty("labelLimit")
    public Double getLabelLimit() { return labelLimit; }
    @JsonProperty("labelLimit")
    public void setLabelLimit(Double value) { this.labelLimit = value; }

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
     * The color of the axis's tick.
     */
    @JsonProperty("tickColor")
    public String getTickColor() { return tickColor; }
    @JsonProperty("tickColor")
    public void setTickColor(String value) { this.tickColor = value; }

    /**
     * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
     */
    @JsonProperty("tickRound")
    public Boolean getTickRound() { return tickRound; }
    @JsonProperty("tickRound")
    public void setTickRound(Boolean value) { this.tickRound = value; }

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
     * The width, in pixels, of ticks.
     */
    @JsonProperty("tickWidth")
    public Double getTickWidth() { return tickWidth; }
    @JsonProperty("tickWidth")
    public void setTickWidth(Double value) { this.tickWidth = value; }

    /**
     * Horizontal text alignment of axis titles.
     */
    @JsonProperty("titleAlign")
    public String getTitleAlign() { return titleAlign; }
    @JsonProperty("titleAlign")
    public void setTitleAlign(String value) { this.titleAlign = value; }

    /**
     * Angle in degrees of axis titles.
     */
    @JsonProperty("titleAngle")
    public Double getTitleAngle() { return titleAngle; }
    @JsonProperty("titleAngle")
    public void setTitleAngle(Double value) { this.titleAngle = value; }

    /**
     * Vertical text baseline for axis titles.
     */
    @JsonProperty("titleBaseline")
    public String getTitleBaseline() { return titleBaseline; }
    @JsonProperty("titleBaseline")
    public void setTitleBaseline(String value) { this.titleBaseline = value; }

    /**
     * Color of the title, can be in hex color code or regular color name.
     */
    @JsonProperty("titleColor")
    public String getTitleColor() { return titleColor; }
    @JsonProperty("titleColor")
    public void setTitleColor(String value) { this.titleColor = value; }

    /**
     * Font of the title. (e.g., `"Helvetica Neue"`).
     */
    @JsonProperty("titleFont")
    public String getTitleFont() { return titleFont; }
    @JsonProperty("titleFont")
    public void setTitleFont(String value) { this.titleFont = value; }

    /**
     * Font size of the title.
     */
    @JsonProperty("titleFontSize")
    public Double getTitleFontSize() { return titleFontSize; }
    @JsonProperty("titleFontSize")
    public void setTitleFontSize(Double value) { this.titleFontSize = value; }

    /**
     * Font weight of the title. (e.g., `"bold"`).
     */
    @JsonProperty("titleFontWeight")
    public TitleFontWeightUnion getTitleFontWeight() { return titleFontWeight; }
    @JsonProperty("titleFontWeight")
    public void setTitleFontWeight(TitleFontWeightUnion value) { this.titleFontWeight = value; }

    /**
     * Maximum allowed pixel width of axis titles.
     */
    @JsonProperty("titleLimit")
    public Double getTitleLimit() { return titleLimit; }
    @JsonProperty("titleLimit")
    public void setTitleLimit(Double value) { this.titleLimit = value; }

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
     * X-coordinate of the axis title relative to the axis group.
     */
    @JsonProperty("titleX")
    public Double getTitleX() { return titleX; }
    @JsonProperty("titleX")
    public void setTitleX(Double value) { this.titleX = value; }

    /**
     * Y-coordinate of the axis title relative to the axis group.
     */
    @JsonProperty("titleY")
    public Double getTitleY() { return titleY; }
    @JsonProperty("titleY")
    public void setTitleY(Double value) { this.titleY = value; }
}
