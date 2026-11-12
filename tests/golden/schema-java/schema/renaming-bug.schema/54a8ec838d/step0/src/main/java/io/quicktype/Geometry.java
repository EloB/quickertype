package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Geometry {
    private RectShape rectShape;
    private List<CircularShape> circularShape;

    @JsonProperty("rectShape")
    public RectShape getRectShape() { return rectShape; }
    @JsonProperty("rectShape")
    public void setRectShape(RectShape value) { this.rectShape = value; }

    @JsonProperty("circularShape")
    public List<CircularShape> getCircularShape() { return circularShape; }
    @JsonProperty("circularShape")
    public void setCircularShape(List<CircularShape> value) { this.circularShape = value; }
}
