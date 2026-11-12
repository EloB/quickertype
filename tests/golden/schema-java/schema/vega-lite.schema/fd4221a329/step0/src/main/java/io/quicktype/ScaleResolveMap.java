package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ScaleResolveMap {
    private ResolveMode color;
    private ResolveMode opacity;
    private ResolveMode shape;
    private ResolveMode size;
    private ResolveMode x;
    private ResolveMode y;

    @JsonProperty("color")
    public ResolveMode getColor() { return color; }
    @JsonProperty("color")
    public void setColor(ResolveMode value) { this.color = value; }

    @JsonProperty("opacity")
    public ResolveMode getOpacity() { return opacity; }
    @JsonProperty("opacity")
    public void setOpacity(ResolveMode value) { this.opacity = value; }

    @JsonProperty("shape")
    public ResolveMode getShape() { return shape; }
    @JsonProperty("shape")
    public void setShape(ResolveMode value) { this.shape = value; }

    @JsonProperty("size")
    public ResolveMode getSize() { return size; }
    @JsonProperty("size")
    public void setSize(ResolveMode value) { this.size = value; }

    @JsonProperty("x")
    public ResolveMode getX() { return x; }
    @JsonProperty("x")
    public void setX(ResolveMode value) { this.x = value; }

    @JsonProperty("y")
    public ResolveMode getY() { return y; }
    @JsonProperty("y")
    public void setY(ResolveMode value) { this.y = value; }
}
