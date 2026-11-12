package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Berry {
    private Color color;
    private String name;
    private List<Shape> shapes;

    @JsonProperty("color")
    public Color getColor() { return color; }
    @JsonProperty("color")
    public void setColor(Color value) { this.color = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("shapes")
    public List<Shape> getShapes() { return shapes; }
    @JsonProperty("shapes")
    public void setShapes(List<Shape> value) { this.shapes = value; }
}
