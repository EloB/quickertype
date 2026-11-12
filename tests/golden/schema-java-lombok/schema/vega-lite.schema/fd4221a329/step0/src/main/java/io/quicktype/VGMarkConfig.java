package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class VGMarkConfig {
    private HorizontalAlign align;
    private Double angle;
    private VerticalAlign baseline;
    private Cursor cursor;
    private Double dx;
    private Double dy;
    private String fill;
    private Double fillOpacity;
    private String font;
    private Double fontSize;
    private FontStyle fontStyle;
    private FontWeightUnion fontWeight;
    private String href;
    private Interpolate interpolate;
    private Double limit;
    private Double opacity;
    private Orient orient;
    private Double radius;
    private String shape;
    private Double size;
    private String stroke;
    private List<Double> strokeDash;
    private Double strokeDashOffset;
    private Double strokeOpacity;
    private Double strokeWidth;
    private Double tension;
    private String text;
    private Double theta;

    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    @JsonProperty("align")
    public HorizontalAlign getAlign() { return align; }
    @JsonProperty("align")
    public void setAlign(HorizontalAlign value) { this.align = value; }

    /**
     * The rotation angle of the text, in degrees.
     */
    @JsonProperty("angle")
    public Double getAngle() { return angle; }
    @JsonProperty("angle")
    public void setAngle(Double value) { this.angle = value; }

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     */
    @JsonProperty("baseline")
    public VerticalAlign getBaseline() { return baseline; }
    @JsonProperty("baseline")
    public void setBaseline(VerticalAlign value) { this.baseline = value; }

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    @JsonProperty("cursor")
    public Cursor getCursor() { return cursor; }
    @JsonProperty("cursor")
    public void setCursor(Cursor value) { this.cursor = value; }

    /**
     * The horizontal offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    @JsonProperty("dx")
    public Double getDx() { return dx; }
    @JsonProperty("dx")
    public void setDx(Double value) { this.dx = value; }

    /**
     * The vertical offset, in pixels, between the text label and its anchor point. The offset
     * is applied after rotation by the _angle_ property.
     */
    @JsonProperty("dy")
    public Double getDy() { return dy; }
    @JsonProperty("dy")
    public void setDy(Double value) { this.dy = value; }

    /**
     * Default Fill Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    @JsonProperty("fill")
    public String getFill() { return fill; }
    @JsonProperty("fill")
    public void setFill(String value) { this.fill = value; }

    /**
     * The fill opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    @JsonProperty("fillOpacity")
    public Double getFillOpacity() { return fillOpacity; }
    @JsonProperty("fillOpacity")
    public void setFillOpacity(Double value) { this.fillOpacity = value; }

    /**
     * The typeface to set the text in (e.g., `"Helvetica Neue"`).
     */
    @JsonProperty("font")
    public String getFont() { return font; }
    @JsonProperty("font")
    public void setFont(String value) { this.font = value; }

    /**
     * The font size, in pixels.
     */
    @JsonProperty("fontSize")
    public Double getFontSize() { return fontSize; }
    @JsonProperty("fontSize")
    public void setFontSize(Double value) { this.fontSize = value; }

    /**
     * The font style (e.g., `"italic"`).
     */
    @JsonProperty("fontStyle")
    public FontStyle getFontStyle() { return fontStyle; }
    @JsonProperty("fontStyle")
    public void setFontStyle(FontStyle value) { this.fontStyle = value; }

    /**
     * The font weight (e.g., `"bold"`).
     */
    @JsonProperty("fontWeight")
    public FontWeightUnion getFontWeight() { return fontWeight; }
    @JsonProperty("fontWeight")
    public void setFontWeight(FontWeightUnion value) { this.fontWeight = value; }

    /**
     * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
     */
    @JsonProperty("href")
    public String getHref() { return href; }
    @JsonProperty("href")
    public void setHref(String value) { this.href = value; }

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    @JsonProperty("interpolate")
    public Interpolate getInterpolate() { return interpolate; }
    @JsonProperty("interpolate")
    public void setInterpolate(Interpolate value) { this.interpolate = value; }

    /**
     * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
     * value will be automatically truncated if the rendered size exceeds the limit.
     */
    @JsonProperty("limit")
    public Double getLimit() { return limit; }
    @JsonProperty("limit")
    public void setLimit(Double value) { this.limit = value; }

    /**
     * The overall opacity (value between [0,1]).
     *
     * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
     * `square` marks or layered `bar` charts and `1` otherwise.
     */
    @JsonProperty("opacity")
    public Double getOpacity() { return opacity; }
    @JsonProperty("opacity")
    public void setOpacity(Double value) { this.opacity = value; }

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    @JsonProperty("orient")
    public Orient getOrient() { return orient; }
    @JsonProperty("orient")
    public void setOrient(Orient value) { this.orient = value; }

    /**
     * Polar coordinate radial offset, in pixels, of the text label from the origin determined
     * by the `x` and `y` properties.
     */
    @JsonProperty("radius")
    public Double getRadius() { return radius; }
    @JsonProperty("radius")
    public void setRadius(Double value) { this.radius = value; }

    /**
     * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
     * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
     *
     * __Default value:__ `"circle"`
     */
    @JsonProperty("shape")
    public String getShape() { return shape; }
    @JsonProperty("shape")
    public void setShape(String value) { this.shape = value; }

    /**
     * The pixel area each the point/circle/square.
     * For example: in the case of circles, the radius is determined in part by the square root
     * of the size value.
     *
     * __Default value:__ `30`
     */
    @JsonProperty("size")
    public Double getSize() { return size; }
    @JsonProperty("size")
    public void setSize(Double value) { this.size = value; }

    /**
     * Default Stroke Color.  This has higher precedence than config.color
     *
     * __Default value:__ (None)
     */
    @JsonProperty("stroke")
    public String getStroke() { return stroke; }
    @JsonProperty("stroke")
    public void setStroke(String value) { this.stroke = value; }

    /**
     * An array of alternating stroke, space lengths for creating dashed or dotted lines.
     */
    @JsonProperty("strokeDash")
    public List<Double> getStrokeDash() { return strokeDash; }
    @JsonProperty("strokeDash")
    public void setStrokeDash(List<Double> value) { this.strokeDash = value; }

    /**
     * The offset (in pixels) into which to begin drawing with the stroke dash array.
     */
    @JsonProperty("strokeDashOffset")
    public Double getStrokeDashOffset() { return strokeDashOffset; }
    @JsonProperty("strokeDashOffset")
    public void setStrokeDashOffset(Double value) { this.strokeDashOffset = value; }

    /**
     * The stroke opacity (value between [0,1]).
     *
     * __Default value:__ `1`
     */
    @JsonProperty("strokeOpacity")
    public Double getStrokeOpacity() { return strokeOpacity; }
    @JsonProperty("strokeOpacity")
    public void setStrokeOpacity(Double value) { this.strokeOpacity = value; }

    /**
     * The stroke width, in pixels.
     */
    @JsonProperty("strokeWidth")
    public Double getStrokeWidth() { return strokeWidth; }
    @JsonProperty("strokeWidth")
    public void setStrokeWidth(Double value) { this.strokeWidth = value; }

    /**
     * Depending on the interpolation type, sets the tension parameter (for line and area marks).
     */
    @JsonProperty("tension")
    public Double getTension() { return tension; }
    @JsonProperty("tension")
    public void setTension(Double value) { this.tension = value; }

    /**
     * Placeholder text if the `text` channel is not specified
     */
    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }

    /**
     * Polar coordinate angle, in radians, of the text label from the origin determined by the
     * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
     * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
     * indicating "north".
     */
    @JsonProperty("theta")
    public Double getTheta() { return theta; }
    @JsonProperty("theta")
    public void setTheta(Double value) { this.theta = value; }
}
