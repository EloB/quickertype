package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Convert {
    private long convert;

    @JsonProperty("convert")
    public long getConvert() { return convert; }
    @JsonProperty("convert")
    public void setConvert(long value) { this.convert = value; }
}
