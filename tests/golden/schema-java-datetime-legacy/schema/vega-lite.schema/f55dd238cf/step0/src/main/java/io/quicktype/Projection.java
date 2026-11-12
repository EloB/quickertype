package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * An object defining properties of geographic projection.
 *
 * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
 * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
 */
public class Projection {
    private List<Double> center;
    private Double clipAngle;
    private List<List<Double>> clipExtent;
    private Double coefficient;
    private Double distance;
    private Double fraction;
    private Double lobes;
    private Double parallel;
    private Map<String, PrecisionValue> precision;
    private Double radius;
    private Double ratio;
    private List<Double> rotate;
    private Double spacing;
    private Double tilt;
    private VGProjectionType type;

    /**
     * Sets the projection’s center to the specified center, a two-element array of longitude
     * and latitude in degrees.
     *
     * __Default value:__ `[0, 0]`
     */
    @JsonProperty("center")
    public List<Double> getCenter() { return center; }
    @JsonProperty("center")
    public void setCenter(List<Double> value) { this.center = value; }

    /**
     * Sets the projection’s clipping circle radius to the specified angle in degrees. If
     * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
     * than small-circle clipping.
     */
    @JsonProperty("clipAngle")
    public Double getClipAngle() { return clipAngle; }
    @JsonProperty("clipAngle")
    public void setClipAngle(Double value) { this.clipAngle = value; }

    /**
     * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
     * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
     * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
     * viewport clipping is performed.
     */
    @JsonProperty("clipExtent")
    public List<List<Double>> getClipExtent() { return clipExtent; }
    @JsonProperty("clipExtent")
    public void setClipExtent(List<List<Double>> value) { this.clipExtent = value; }

    @JsonProperty("coefficient")
    public Double getCoefficient() { return coefficient; }
    @JsonProperty("coefficient")
    public void setCoefficient(Double value) { this.coefficient = value; }

    @JsonProperty("distance")
    public Double getDistance() { return distance; }
    @JsonProperty("distance")
    public void setDistance(Double value) { this.distance = value; }

    @JsonProperty("fraction")
    public Double getFraction() { return fraction; }
    @JsonProperty("fraction")
    public void setFraction(Double value) { this.fraction = value; }

    @JsonProperty("lobes")
    public Double getLobes() { return lobes; }
    @JsonProperty("lobes")
    public void setLobes(Double value) { this.lobes = value; }

    @JsonProperty("parallel")
    public Double getParallel() { return parallel; }
    @JsonProperty("parallel")
    public void setParallel(Double value) { this.parallel = value; }

    /**
     * Sets the threshold for the projection’s [adaptive
     * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
     * value corresponds to the [Douglas–Peucker
     * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
     * If precision is not specified, returns the projection’s current resampling precision
     * which defaults to `√0.5 ≅ 0.70710…`.
     */
    @JsonProperty("precision")
    public Map<String, PrecisionValue> getPrecision() { return precision; }
    @JsonProperty("precision")
    public void setPrecision(Map<String, PrecisionValue> value) { this.precision = value; }

    @JsonProperty("radius")
    public Double getRadius() { return radius; }
    @JsonProperty("radius")
    public void setRadius(Double value) { this.radius = value; }

    @JsonProperty("ratio")
    public Double getRatio() { return ratio; }
    @JsonProperty("ratio")
    public void setRatio(Double value) { this.ratio = value; }

    /**
     * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
     * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
     * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
     *
     * __Default value:__ `[0, 0, 0]`
     */
    @JsonProperty("rotate")
    public List<Double> getRotate() { return rotate; }
    @JsonProperty("rotate")
    public void setRotate(List<Double> value) { this.rotate = value; }

    @JsonProperty("spacing")
    public Double getSpacing() { return spacing; }
    @JsonProperty("spacing")
    public void setSpacing(Double value) { this.spacing = value; }

    @JsonProperty("tilt")
    public Double getTilt() { return tilt; }
    @JsonProperty("tilt")
    public void setTilt(Double value) { this.tilt = value; }

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    @JsonProperty("type")
    public VGProjectionType getType() { return type; }
    @JsonProperty("type")
    public void setType(VGProjectionType value) { this.type = value; }
}
