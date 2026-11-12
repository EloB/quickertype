package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TitleParams {
    private Anchor anchor;
    private Double offset;
    private TitleOrient orient;
    private Style style;
    private String text;

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
     * The orthogonal offset in pixels by which to displace the title from its position along
     * the edge of the chart.
     */
    @JsonProperty("offset")
    public Double getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(Double value) { this.offset = value; }

    /**
     * The orientation of the title relative to the chart. One of `"top"` (the default),
     * `"bottom"`, `"left"`, or `"right"`.
     */
    @JsonProperty("orient")
    public TitleOrient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(TitleOrient value) { this.orient = value; }

    /**
     * A [mark style property](config.html#style) to apply to the title text mark.
     *
     * __Default value:__ `"group-title"`.
     */
    @JsonProperty("style")
    public Style getStyle() { return style; }
    @JsonProperty("style")
    public void setStyle(Style value) { this.style = value; }

    /**
     * The title text.
     */
    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
