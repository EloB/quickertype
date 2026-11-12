package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Color {
    private Double rgb;

    @JsonProperty("rgb")
    public Double getRGB() { return rgb; }
    @JsonProperty("rgb")
    public void setRGB(Double value) { this.rgb = value; }
}
