package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Imaginery {
    private long imaginery;

    @JsonProperty("_Imaginery")
    public long getImaginery() { return imaginery; }
    @JsonProperty("_Imaginery")
    public void setImaginery(long value) { this.imaginery = value; }
}
