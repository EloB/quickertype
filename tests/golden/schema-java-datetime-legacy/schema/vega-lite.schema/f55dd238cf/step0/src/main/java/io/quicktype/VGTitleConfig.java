package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Title configuration, which determines default properties for all [titles](title.html).
 * For a full list of title configuration options, please see the [corresponding section of
 * the title documentation](title.html#config).
 */
public class VGTitleConfig {
    private Anchor anchor;
    private Double angle;
    private VerticalAlign baseline;
    private String color;
    private String font;
    private Double fontSize;
    private FontWeightUnion fontWeight;
    private Double limit;
    private Double offset;
    private TitleOrient orient;

    /**
     * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
     * example, with an orientation of top these anchor positions map to a left-, center-, or
     * right-aligned title.
     *
     * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
     * `"start"` for other composite views.
     *
     * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
     * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
     * composite views, `anchor` is always `"start"`.
     */
    @JsonProperty("anchor")
    public Anchor getAnchor() { return anchor; }
    @JsonProperty("anchor")
    public void setAnchor(Anchor value) { this.anchor = value; }

    /**
     * Angle in degrees of title text.
     */
    @JsonProperty("angle")
    public Double getAngle() { return angle; }
    @JsonProperty("angle")
    public void setAngle(Double value) { this.angle = value; }

    /**
     * Vertical text baseline for title text.
     */
    @JsonProperty("baseline")
    public VerticalAlign getBaseline() { return baseline; }
    @JsonProperty("baseline")
    public void setBaseline(VerticalAlign value) { this.baseline = value; }

    /**
     * Text color for title text.
     */
    @JsonProperty("color")
    public String getColor() { return color; }
    @JsonProperty("color")
    public void setColor(String value) { this.color = value; }

    /**
     * Font name for title text.
     */
    @JsonProperty("font")
    public String getFont() { return font; }
    @JsonProperty("font")
    public void setFont(String value) { this.font = value; }

    /**
     * Font size in pixels for title text.
     *
     * __Default value:__ `10`.
     */
    @JsonProperty("fontSize")
    public Double getFontSize() { return fontSize; }
    @JsonProperty("fontSize")
    public void setFontSize(Double value) { this.fontSize = value; }

    /**
     * Font weight for title text.
     */
    @JsonProperty("fontWeight")
    public FontWeightUnion getFontWeight() { return fontWeight; }
    @JsonProperty("fontWeight")
    public void setFontWeight(FontWeightUnion value) { this.fontWeight = value; }

    /**
     * The maximum allowed length in pixels of legend labels.
     */
    @JsonProperty("limit")
    public Double getLimit() { return limit; }
    @JsonProperty("limit")
    public void setLimit(Double value) { this.limit = value; }

    /**
     * Offset in pixels of the title from the chart body and axes.
     */
    @JsonProperty("offset")
    public Double getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(Double value) { this.offset = value; }

    /**
     * Default title orientation ("top", "bottom", "left", or "right")
     */
    @JsonProperty("orient")
    public TitleOrient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(TitleOrient value) { this.orient = value; }
}
