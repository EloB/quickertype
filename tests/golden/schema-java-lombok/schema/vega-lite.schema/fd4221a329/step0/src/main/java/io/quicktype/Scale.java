package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * An object defining properties of the channel's scale, which is the function that
 * transforms values in the data domain (numbers, dates, strings, etc) to visual values
 * (pixels, colors, sizes) of the encoding channels.
 *
 * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
 */
public class Scale {
    private Double base;
    private Boolean clamp;
    private DomainUnion domain;
    private Double exponent;
    private InterpolateUnion interpolate;
    private NiceUnion nice;
    private Double padding;
    private Double paddingInner;
    private Double paddingOuter;
    private ScaleRange range;
    private Double rangeStep;
    private Boolean round;
    private Scheme scheme;
    private ScaleType type;
    private Boolean zero;

    /**
     * The logarithm base of the `log` scale (default `10`).
     */
    @JsonProperty("base")
    public Double getBase() { return base; }
    @JsonProperty("base")
    public void setBase(Double value) { this.base = value; }

    /**
     * If `true`, values that exceed the data domain are clamped to either the minimum or
     * maximum range value
     *
     * __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
     * (`true` by default).
     */
    @JsonProperty("clamp")
    public Boolean getClamp() { return clamp; }
    @JsonProperty("clamp")
    public void setClamp(Boolean value) { this.clamp = value; }

    /**
     * Customized domain values.
     *
     * For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
     * and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
     * a `domain` with more than two entries.
     * If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
     * indicating that the domain should include the raw data values prior to the aggregation.
     *
     * For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
     * the form of either timestamps or the [DateTime definition objects](types.html#datetime).
     *
     * For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
     * values.
     *
     * The `selection` property can be used to [interactively
     * determine](selection.html#scale-domains) the scale domain.
     */
    @JsonProperty("domain")
    public DomainUnion getDomain() { return domain; }
    @JsonProperty("domain")
    public void setDomain(DomainUnion value) { this.domain = value; }

    /**
     * The exponent of the `pow` scale.
     */
    @JsonProperty("exponent")
    public Double getExponent() { return exponent; }
    @JsonProperty("exponent")
    public void setExponent(Double value) { this.exponent = value; }

    /**
     * The interpolation method for range values. By default, a general interpolator for
     * numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
     * property allows interpolation in alternative color spaces. Legal values include `rgb`,
     * `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
     * variants use longer paths in polar coordinate spaces). If object-valued, this property
     * accepts an object with a string-valued _type_ property and an optional numeric _gamma_
     * property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
     * documentation](https://github.com/d3/d3-interpolate).
     *
     * __Note:__ Sequential scales do not support `interpolate` as they have a fixed
     * interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
     * you have to set the scale `type` to other quantitative scale type such as `"linear"` to
     * customize `interpolate`.
     */
    @JsonProperty("interpolate")
    public InterpolateUnion getInterpolate() { return interpolate; }
    @JsonProperty("interpolate")
    public void setInterpolate(InterpolateUnion value) { this.interpolate = value; }

    /**
     * Extending the domain so that it starts and ends on nice round values. This method
     * typically modifies the scale’s domain, and may only extend the bounds to the nearest
     * round value. Nicing is useful if the domain is computed from data and may be irregular.
     * For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
     * 1.0]_.
     *
     * For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
     * If `nice` is a number, it will represent a desired tick count. This allows greater
     * control over the step size used to extend the bounds, guaranteeing that the returned
     * ticks will exactly cover the domain.
     *
     * For temporal fields with time and utc scales, the `nice` value can be a string indicating
     * the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
     * `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
     * scales can accept an object-valued interval specifier of the form `{"interval": "month",
     * "step": 3}`, which includes a desired number of interval steps. Here, the domain would
     * snap to quarter (Jan, Apr, Jul, Oct) boundaries.
     *
     * __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
     */
    @JsonProperty("nice")
    public NiceUnion getNice() { return nice; }
    @JsonProperty("nice")
    public void setNice(NiceUnion value) { this.nice = value; }

    /**
     * For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
     * the specified number of pixels on each of the scale range. The scale range must represent
     * pixels for this parameter to function as intended. Padding adjustment is performed prior
     * to all other adjustments, including the effects of the zero, nice, domainMin, and
     * domainMax properties.
     *
     * For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
     * `paddingOuter` to the same value.
     *
     * For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
     *
     * __Default value:__ For _continuous_ scales, derived from the [scale
     * config](scale.html#config)'s `continuousPadding`.
     * For _band and point_ scales, see `paddingInner` and `paddingOuter`.
     */
    @JsonProperty("padding")
    public Double getPadding() { return padding; }
    @JsonProperty("padding")
    public void setPadding(Double value) { this.padding = value; }

    /**
     * The inner padding (spacing) within each band step of band scales, as a fraction of the
     * step size. This value must lie in the range [0,1].
     *
     * For point scale, this property is invalid as point scales do not have internal band
     * widths (only step sizes between bands).
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingInner`.
     */
    @JsonProperty("paddingInner")
    public Double getPaddingInner() { return paddingInner; }
    @JsonProperty("paddingInner")
    public void setPaddingInner(Double value) { this.paddingInner = value; }

    /**
     * The outer padding (spacing) at the ends of the range of band and point scales,
     * as a fraction of the step size. This value must lie in the range [0,1].
     *
     * __Default value:__ derived from the [scale config](scale.html#config)'s
     * `bandPaddingOuter` for band scales and `pointPadding` for point scales.
     */
    @JsonProperty("paddingOuter")
    public Double getPaddingOuter() { return paddingOuter; }
    @JsonProperty("paddingOuter")
    public void setPaddingOuter(Double value) { this.paddingOuter = value; }

    /**
     * The range of the scale. One of:
     *
     * - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
     * example, `"symbol"`, or `"diverging"`).
     *
     * - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
     * and maximum values, or an array with more than two entries for specifying a [piecewise
     * scale](scale.html#piecewise).
     *
     * - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
     * an array of desired output values.
     *
     * __Notes:__
     *
     * 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
     * discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
     * instead of `range`.
     *
     * 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
     * customized via the view's corresponding [size](size.html) (`width` and `height`) or via
     * [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
     * scales.
     */
    @JsonProperty("range")
    public ScaleRange getRange() { return range; }
    @JsonProperty("range")
    public void setRange(ScaleRange value) { this.range = value; }

    /**
     * The distance between the starts of adjacent bands or points in [band](scale.html#band)
     * and [point](scale.html#point) scales.
     *
     * If `rangeStep` is `null` or if the view contains the scale's corresponding
     * [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
     * be automatically determined to fit the size of the view.
     *
     * __Default value:__  derived the [scale config](config.html#scale-config)'s
     * `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
     * default) for x-scales of other marks and y-scales.
     *
     * __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
     * than `width` or `height`, the rangeStep might become less than one pixel and the mark
     * might not appear correctly.
     */
    @JsonProperty("rangeStep")
    public Double getRangeStep() { return rangeStep; }
    @JsonProperty("rangeStep")
    public void setRangeStep(Double value) { this.rangeStep = value; }

    /**
     * If `true`, rounds numeric output values to integers. This can be helpful for snapping to
     * the pixel grid.
     *
     * __Default value:__ `false`.
     */
    @JsonProperty("round")
    public Boolean getRound() { return round; }
    @JsonProperty("round")
    public void setRound(Boolean value) { this.round = value; }

    /**
     * A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
     * `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
     *
     * Discrete color schemes may be used with [discrete](scale.html#discrete) or
     * [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
     * use with [sequential](scales.html#sequential) scales.
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    @JsonProperty("scheme")
    public Scheme getScheme() { return scheme; }
    @JsonProperty("scheme")
    public void setScheme(Scheme value) { this.scheme = value; }

    /**
     * The type of scale.  Vega-Lite supports the following categories of scale types:
     *
     * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
     * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
     * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
     * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
     *
     * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
     * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
     * [`"point"`](scale.html#point)) output ranges.
     *
     * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
     * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
     * [`"bin-ordinal"`](scale.html#bin-ordinal)).
     *
     * __Default value:__ please see the [scale type table](scale.html#type).
     */
    @JsonProperty("type")
    public ScaleType getType() { return type; }
    @JsonProperty("type")
    public void setType(ScaleType value) { this.type = value; }

    /**
     * If `true`, ensures that a zero baseline value is included in the scale domain.
     *
     * __Default value:__ `true` for x and y channels if the quantitative field is not binned
     * and no custom `domain` is provided; `false` otherwise.
     *
     * __Note:__ Log, time, and utc scales do not support `zero`.
     */
    @JsonProperty("zero")
    public Boolean getZero() { return zero; }
    @JsonProperty("zero")
    public void setZero(Boolean value) { this.zero = value; }
}
