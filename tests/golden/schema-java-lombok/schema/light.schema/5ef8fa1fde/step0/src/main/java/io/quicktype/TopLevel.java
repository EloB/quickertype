package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private LightParams lightParams;

    @JsonProperty("LightParams")
    public LightParams getLightParams() { return lightParams; }
    @JsonProperty("LightParams")
    public void setLightParams(LightParams value) { this.lightParams = value; }
}
