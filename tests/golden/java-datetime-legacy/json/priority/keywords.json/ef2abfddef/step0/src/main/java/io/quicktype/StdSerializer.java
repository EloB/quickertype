package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StdSerializer {
    private long stdSerializer;

    @JsonProperty("StdSerializer")
    public long getStdSerializer() { return stdSerializer; }
    @JsonProperty("StdSerializer")
    public void setStdSerializer(long value) { this.stdSerializer = value; }
}
