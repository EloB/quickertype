package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * Default properties for [single view plots](spec.html#single).
 */
public class ViewConfig {
    private Boolean clip;
    private String fill;
    private Double fillOpacity;
    private Double height;
    private String stroke;
    private List<Double> strokeDash;
    private Double strokeDashOffset;
    private Double strokeOpacity;
    private Double strokeWidth;
    private Double width;

    /**
     * Whether the view should be clipped.
     */
    @JsonProperty("clip")
    public Boolean getClip() { return clip; }
    @JsonProperty("clip")
    public void setClip(Boolean value) { this.clip = value; }

    /**
     * The fill color.
     *
     * __Default value:__ (none)
     */
    @JsonProperty("fill")
    public String getFill() { return fill; }
    @JsonProperty("fill")
    public void setFill(String value) { this.fill = value; }

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    @JsonProperty("fillOpacity")
    public Double getFillOpacity() { return fillOpacity; }
    @JsonProperty("fillOpacity")
    public void setFillOpacity(Double value) { this.fillOpacity = value; }

    /**
     * The default height of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
     *
     * __Default value:__ `200`
     */
    @JsonProperty("height")
    public Double getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(Double value) { this.height = value; }

    /**
     * The stroke color.
     *
     * __Default value:__ (none)
     */
    @JsonProperty("stroke")
    public String getStroke() { return stroke; }
    @JsonProperty("stroke")
    public void setStroke(String value) { this.stroke = value; }

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     *
     * __Default value:__ (none)
     */
    @JsonProperty("strokeDash")
    public List<Double> getStrokeDash() { return strokeDash; }
    @JsonProperty("strokeDash")
    public void setStrokeDash(List<Double> value) { this.strokeDash = value; }

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     *
     * __Default value:__ (none)
     */
    @JsonProperty("strokeDashOffset")
    public Double getStrokeDashOffset() { return strokeDashOffset; }
    @JsonProperty("strokeDashOffset")
    public void setStrokeDashOffset(Double value) { this.strokeDashOffset = value; }

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ (none)
     */
    @JsonProperty("strokeOpacity")
    public Double getStrokeOpacity() { return strokeOpacity; }
    @JsonProperty("strokeOpacity")
    public void setStrokeOpacity(Double value) { this.strokeOpacity = value; }

    /**
     * The stroke width, in pixels.
     *
     * __Default value:__ (none)
     */
    @JsonProperty("strokeWidth")
    public Double getStrokeWidth() { return strokeWidth; }
    @JsonProperty("strokeWidth")
    public void setStrokeWidth(Double value) { this.strokeWidth = value; }

    /**
     * The default width of the single plot or each plot in a trellis plot when the
     * visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
     * = `null`.
     *
     * __Default value:__ `200`
     */
    @JsonProperty("width")
    public Double getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Double value) { this.width = value; }
}
