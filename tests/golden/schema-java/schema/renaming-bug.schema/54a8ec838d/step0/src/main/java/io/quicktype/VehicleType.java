package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class VehicleType {
    private Name name;
    private Axis width;
    private Axis length;

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("width")
    public Axis getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Axis value) { this.width = value; }

    @JsonProperty("length")
    public Axis getLength() { return length; }
    @JsonProperty("length")
    public void setLength(Axis value) { this.length = value; }
}
