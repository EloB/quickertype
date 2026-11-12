package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Scale configuration determines default properties for all [scales](scale.html). For a
 * full list of scale configuration options, please see the [corresponding section of the
 * scale documentation](scale.html#config).
 */
public class ScaleConfig {
    private Double bandPaddingInner;
    private Double bandPaddingOuter;
    private Boolean clamp;
    private Double continuousPadding;
    private Double maxBandSize;
    private Double maxFontSize;
    private Double maxOpacity;
    private Double maxSize;
    private Double maxStrokeWidth;
    private Double minBandSize;
    private Double minFontSize;
    private Double minOpacity;
    private Double minSize;
    private Double minStrokeWidth;
    private Double pointPadding;
    private Double rangeStep;
    private Boolean round;
    private Double textXRangeStep;
    private Boolean useUnaggregatedDomain;

    /**
     * Default inner padding for `x` and `y` band-ordinal scales.
     *
     * __Default value:__ `0.1`
     */
    @JsonProperty("bandPaddingInner")
    public Double getBandPaddingInner() { return bandPaddingInner; }
    @JsonProperty("bandPaddingInner")
    public void setBandPaddingInner(Double value) { this.bandPaddingInner = value; }

    /**
     * Default outer padding for `x` and `y` band-ordinal scales.
     * If not specified, by default, band scale's paddingOuter is paddingInner/2.
     */
    @JsonProperty("bandPaddingOuter")
    public Double getBandPaddingOuter() { return bandPaddingOuter; }
    @JsonProperty("bandPaddingOuter")
    public void setBandPaddingOuter(Double value) { this.bandPaddingOuter = value; }

    /**
     * If true, values that exceed the data domain are clamped to either the minimum or maximum
     * range value
     */
    @JsonProperty("clamp")
    public Boolean getClamp() { return clamp; }
    @JsonProperty("clamp")
    public void setClamp(Boolean value) { this.clamp = value; }

    /**
     * Default padding for continuous scales.
     *
     * __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
     * horizontal bar.; `0` otherwise.
     */
    @JsonProperty("continuousPadding")
    public Double getContinuousPadding() { return continuousPadding; }
    @JsonProperty("continuousPadding")
    public void setContinuousPadding(Double value) { this.continuousPadding = value; }

    /**
     * The default max value for mapping quantitative fields to bar's size/bandSize.
     *
     * If undefined (default), we will use the scale's `rangeStep` - 1.
     */
    @JsonProperty("maxBandSize")
    public Double getMaxBandSize() { return maxBandSize; }
    @JsonProperty("maxBandSize")
    public void setMaxBandSize(Double value) { this.maxBandSize = value; }

    /**
     * The default max value for mapping quantitative fields to text's size/fontSize.
     *
     * __Default value:__ `40`
     */
    @JsonProperty("maxFontSize")
    public Double getMaxFontSize() { return maxFontSize; }
    @JsonProperty("maxFontSize")
    public void setMaxFontSize(Double value) { this.maxFontSize = value; }

    /**
     * Default max opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.8`
     */
    @JsonProperty("maxOpacity")
    public Double getMaxOpacity() { return maxOpacity; }
    @JsonProperty("maxOpacity")
    public void setMaxOpacity(Double value) { this.maxOpacity = value; }

    /**
     * Default max value for point size scale.
     */
    @JsonProperty("maxSize")
    public Double getMaxSize() { return maxSize; }
    @JsonProperty("maxSize")
    public void setMaxSize(Double value) { this.maxSize = value; }

    /**
     * Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
     *
     * __Default value:__ `4`
     */
    @JsonProperty("maxStrokeWidth")
    public Double getMaxStrokeWidth() { return maxStrokeWidth; }
    @JsonProperty("maxStrokeWidth")
    public void setMaxStrokeWidth(Double value) { this.maxStrokeWidth = value; }

    /**
     * The default min value for mapping quantitative fields to bar and tick's size/bandSize
     * scale with zero=false.
     *
     * __Default value:__ `2`
     */
    @JsonProperty("minBandSize")
    public Double getMinBandSize() { return minBandSize; }
    @JsonProperty("minBandSize")
    public void setMinBandSize(Double value) { this.minBandSize = value; }

    /**
     * The default min value for mapping quantitative fields to tick's size/fontSize scale with
     * zero=false
     *
     * __Default value:__ `8`
     */
    @JsonProperty("minFontSize")
    public Double getMinFontSize() { return minFontSize; }
    @JsonProperty("minFontSize")
    public void setMinFontSize(Double value) { this.minFontSize = value; }

    /**
     * Default minimum opacity for mapping a field to opacity.
     *
     * __Default value:__ `0.3`
     */
    @JsonProperty("minOpacity")
    public Double getMinOpacity() { return minOpacity; }
    @JsonProperty("minOpacity")
    public void setMinOpacity(Double value) { this.minOpacity = value; }

    /**
     * Default minimum value for point size scale with zero=false.
     *
     * __Default value:__ `9`
     */
    @JsonProperty("minSize")
    public Double getMinSize() { return minSize; }
    @JsonProperty("minSize")
    public void setMinSize(Double value) { this.minSize = value; }

    /**
     * Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
     *
     * __Default value:__ `1`
     */
    @JsonProperty("minStrokeWidth")
    public Double getMinStrokeWidth() { return minStrokeWidth; }
    @JsonProperty("minStrokeWidth")
    public void setMinStrokeWidth(Double value) { this.minStrokeWidth = value; }

    /**
     * Default outer padding for `x` and `y` point-ordinal scales.
     *
     * __Default value:__ `0.5`
     */
    @JsonProperty("pointPadding")
    public Double getPointPadding() { return pointPadding; }
    @JsonProperty("pointPadding")
    public void setPointPadding(Double value) { this.pointPadding = value; }

    /**
     * Default range step for band and point scales of (1) the `y` channel
     * and (2) the `x` channel when the mark is not `text`.
     *
     * __Default value:__ `21`
     */
    @JsonProperty("rangeStep")
    public Double getRangeStep() { return rangeStep; }
    @JsonProperty("rangeStep")
    public void setRangeStep(Double value) { this.rangeStep = value; }

    /**
     * If true, rounds numeric output values to integers.
     * This can be helpful for snapping to the pixel grid.
     * (Only available for `x`, `y`, and `size` scales.)
     */
    @JsonProperty("round")
    public Boolean getRound() { return round; }
    @JsonProperty("round")
    public void setRound(Boolean value) { this.round = value; }

    /**
     * Default range step for `x` band and point scales of text marks.
     *
     * __Default value:__ `90`
     */
    @JsonProperty("textXRangeStep")
    public Double getTextXRangeStep() { return textXRangeStep; }
    @JsonProperty("textXRangeStep")
    public void setTextXRangeStep(Double value) { this.textXRangeStep = value; }

    /**
     * Use the source data range before aggregation as scale domain instead of aggregated data
     * for aggregate axis.
     *
     * This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
     * fields by default.
     *
     * This property only works with aggregate functions that produce values within the raw data
     * domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
     * aggregations that produce values outside of the raw data domain (e.g. `"count"`,
     * `"sum"`), this property is ignored.
     *
     * __Default value:__ `false`
     */
    @JsonProperty("useUnaggregatedDomain")
    public Boolean getUseUnaggregatedDomain() { return useUnaggregatedDomain; }
    @JsonProperty("useUnaggregatedDomain")
    public void setUseUnaggregatedDomain(Boolean value) { this.useUnaggregatedDomain = value; }
}
