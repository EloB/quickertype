package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CircularShape {
    private String shapeName;

    @JsonProperty("shapeName")
    public String getShapeName() { return shapeName; }
    @JsonProperty("shapeName")
    public void setShapeName(String value) { this.shapeName = value; }
}
