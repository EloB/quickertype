package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Legend configuration, which determines default properties for all [legends](legend.html).
 * For a full list of legend configuration options, please see the [corresponding section of
 * in the legend documentation](legend.html#config).
 */
public class LegendConfig {
    private Double cornerRadius;
    private Double entryPadding;
    private String fillColor;
    private Double gradientHeight;
    private String gradientLabelBaseline;
    private Double gradientLabelLimit;
    private Double gradientLabelOffset;
    private String gradientStrokeColor;
    private Double gradientStrokeWidth;
    private Double gradientWidth;
    private String labelAlign;
    private String labelBaseline;
    private String labelColor;
    private String labelFont;
    private Double labelFontSize;
    private Double labelLimit;
    private Double labelOffset;
    private Double offset;
    private LegendOrient orient;
    private Double padding;
    private Boolean shortTimeLabels;
    private String strokeColor;
    private List<Double> strokeDash;
    private Double strokeWidth;
    private String symbolColor;
    private Double symbolSize;
    private Double symbolStrokeWidth;
    private String symbolType;
    private String titleAlign;
    private String titleBaseline;
    private String titleColor;
    private String titleFont;
    private Double titleFontSize;
    private TitleFontWeightUnion titleFontWeight;
    private Double titleLimit;
    private Double titlePadding;

    /**
     * Corner radius for the full legend.
     */
    @JsonProperty("cornerRadius")
    public Double getCornerRadius() { return cornerRadius; }
    @JsonProperty("cornerRadius")
    public void setCornerRadius(Double value) { this.cornerRadius = value; }

    /**
     * Padding (in pixels) between legend entries in a symbol legend.
     */
    @JsonProperty("entryPadding")
    public Double getEntryPadding() { return entryPadding; }
    @JsonProperty("entryPadding")
    public void setEntryPadding(Double value) { this.entryPadding = value; }

    /**
     * Background fill color for the full legend.
     */
    @JsonProperty("fillColor")
    public String getFillColor() { return fillColor; }
    @JsonProperty("fillColor")
    public void setFillColor(String value) { this.fillColor = value; }

    /**
     * The height of the gradient, in pixels.
     */
    @JsonProperty("gradientHeight")
    public Double getGradientHeight() { return gradientHeight; }
    @JsonProperty("gradientHeight")
    public void setGradientHeight(Double value) { this.gradientHeight = value; }

    /**
     * Text baseline for color ramp gradient labels.
     */
    @JsonProperty("gradientLabelBaseline")
    public String getGradientLabelBaseline() { return gradientLabelBaseline; }
    @JsonProperty("gradientLabelBaseline")
    public void setGradientLabelBaseline(String value) { this.gradientLabelBaseline = value; }

    /**
     * The maximum allowed length in pixels of color ramp gradient labels.
     */
    @JsonProperty("gradientLabelLimit")
    public Double getGradientLabelLimit() { return gradientLabelLimit; }
    @JsonProperty("gradientLabelLimit")
    public void setGradientLabelLimit(Double value) { this.gradientLabelLimit = value; }

    /**
     * Vertical offset in pixels for color ramp gradient labels.
     */
    @JsonProperty("gradientLabelOffset")
    public Double getGradientLabelOffset() { return gradientLabelOffset; }
    @JsonProperty("gradientLabelOffset")
    public void setGradientLabelOffset(Double value) { this.gradientLabelOffset = value; }

    /**
     * The color of the gradient stroke, can be in hex color code or regular color name.
     */
    @JsonProperty("gradientStrokeColor")
    public String getGradientStrokeColor() { return gradientStrokeColor; }
    @JsonProperty("gradientStrokeColor")
    public void setGradientStrokeColor(String value) { this.gradientStrokeColor = value; }

    /**
     * The width of the gradient stroke, in pixels.
     */
    @JsonProperty("gradientStrokeWidth")
    public Double getGradientStrokeWidth() { return gradientStrokeWidth; }
    @JsonProperty("gradientStrokeWidth")
    public void setGradientStrokeWidth(Double value) { this.gradientStrokeWidth = value; }

    /**
     * The width of the gradient, in pixels.
     */
    @JsonProperty("gradientWidth")
    public Double getGradientWidth() { return gradientWidth; }
    @JsonProperty("gradientWidth")
    public void setGradientWidth(Double value) { this.gradientWidth = value; }

    /**
     * The alignment of the legend label, can be left, middle or right.
     */
    @JsonProperty("labelAlign")
    public String getLabelAlign() { return labelAlign; }
    @JsonProperty("labelAlign")
    public void setLabelAlign(String value) { this.labelAlign = value; }

    /**
     * The position of the baseline of legend label, can be top, middle or bottom.
     */
    @JsonProperty("labelBaseline")
    public String getLabelBaseline() { return labelBaseline; }
    @JsonProperty("labelBaseline")
    public void setLabelBaseline(String value) { this.labelBaseline = value; }

    /**
     * The color of the legend label, can be in hex color code or regular color name.
     */
    @JsonProperty("labelColor")
    public String getLabelColor() { return labelColor; }
    @JsonProperty("labelColor")
    public void setLabelColor(String value) { this.labelColor = value; }

    /**
     * The font of the legend label.
     */
    @JsonProperty("labelFont")
    public String getLabelFont() { return labelFont; }
    @JsonProperty("labelFont")
    public void setLabelFont(String value) { this.labelFont = value; }

    /**
     * The font size of legend label.
     *
     * __Default value:__ `10`.
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
     * The offset of the legend label.
     */
    @JsonProperty("labelOffset")
    public Double getLabelOffset() { return labelOffset; }
    @JsonProperty("labelOffset")
    public void setLabelOffset(Double value) { this.labelOffset = value; }

    /**
     * The offset, in pixels, by which to displace the legend from the edge of the enclosing
     * group or data rectangle.
     *
     * __Default value:__  `0`
     */
    @JsonProperty("offset")
    public Double getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(Double value) { this.offset = value; }

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    @JsonProperty("orient")
    public LegendOrient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(LegendOrient value) { this.orient = value; }

    /**
     * The padding, in pixels, between the legend and axis.
     */
    @JsonProperty("padding")
    public Double getPadding() { return padding; }
    @JsonProperty("padding")
    public void setPadding(Double value) { this.padding = value; }

    /**
     * Whether month names and weekday names should be abbreviated.
     *
     * __Default value:__  `false`
     */
    @JsonProperty("shortTimeLabels")
    public Boolean getShortTimeLabels() { return shortTimeLabels; }
    @JsonProperty("shortTimeLabels")
    public void setShortTimeLabels(Boolean value) { this.shortTimeLabels = value; }

    /**
     * Border stroke color for the full legend.
     */
    @JsonProperty("strokeColor")
    public String getStrokeColor() { return strokeColor; }
    @JsonProperty("strokeColor")
    public void setStrokeColor(String value) { this.strokeColor = value; }

    /**
     * Border stroke dash pattern for the full legend.
     */
    @JsonProperty("strokeDash")
    public List<Double> getStrokeDash() { return strokeDash; }
    @JsonProperty("strokeDash")
    public void setStrokeDash(List<Double> value) { this.strokeDash = value; }

    /**
     * Border stroke width for the full legend.
     */
    @JsonProperty("strokeWidth")
    public Double getStrokeWidth() { return strokeWidth; }
    @JsonProperty("strokeWidth")
    public void setStrokeWidth(Double value) { this.strokeWidth = value; }

    /**
     * The color of the legend symbol,
     */
    @JsonProperty("symbolColor")
    public String getSymbolColor() { return symbolColor; }
    @JsonProperty("symbolColor")
    public void setSymbolColor(String value) { this.symbolColor = value; }

    /**
     * The size of the legend symbol, in pixels.
     */
    @JsonProperty("symbolSize")
    public Double getSymbolSize() { return symbolSize; }
    @JsonProperty("symbolSize")
    public void setSymbolSize(Double value) { this.symbolSize = value; }

    /**
     * The width of the symbol's stroke.
     */
    @JsonProperty("symbolStrokeWidth")
    public Double getSymbolStrokeWidth() { return symbolStrokeWidth; }
    @JsonProperty("symbolStrokeWidth")
    public void setSymbolStrokeWidth(Double value) { this.symbolStrokeWidth = value; }

    /**
     * Default shape type (such as "circle") for legend symbols.
     */
    @JsonProperty("symbolType")
    public String getSymbolType() { return symbolType; }
    @JsonProperty("symbolType")
    public void setSymbolType(String value) { this.symbolType = value; }

    /**
     * Horizontal text alignment for legend titles.
     */
    @JsonProperty("titleAlign")
    public String getTitleAlign() { return titleAlign; }
    @JsonProperty("titleAlign")
    public void setTitleAlign(String value) { this.titleAlign = value; }

    /**
     * Vertical text baseline for legend titles.
     */
    @JsonProperty("titleBaseline")
    public String getTitleBaseline() { return titleBaseline; }
    @JsonProperty("titleBaseline")
    public void setTitleBaseline(String value) { this.titleBaseline = value; }

    /**
     * The color of the legend title, can be in hex color code or regular color name.
     */
    @JsonProperty("titleColor")
    public String getTitleColor() { return titleColor; }
    @JsonProperty("titleColor")
    public void setTitleColor(String value) { this.titleColor = value; }

    /**
     * The font of the legend title.
     */
    @JsonProperty("titleFont")
    public String getTitleFont() { return titleFont; }
    @JsonProperty("titleFont")
    public void setTitleFont(String value) { this.titleFont = value; }

    /**
     * The font size of the legend title.
     */
    @JsonProperty("titleFontSize")
    public Double getTitleFontSize() { return titleFontSize; }
    @JsonProperty("titleFontSize")
    public void setTitleFontSize(Double value) { this.titleFontSize = value; }

    /**
     * The font weight of the legend title.
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
     * The padding, in pixels, between title and legend.
     */
    @JsonProperty("titlePadding")
    public Double getTitlePadding() { return titlePadding; }
    @JsonProperty("titlePadding")
    public void setTitlePadding(Double value) { this.titlePadding = value; }
}
