package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Extension {
    private long extension;

    @JsonProperty("extension")
    public long getExtension() { return extension; }
    @JsonProperty("extension")
    public void setExtension(long value) { this.extension = value; }
}
