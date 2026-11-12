package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class KSerializer {
    private long kSerializer;

    @JsonProperty("KSerializer")
    public long getKSerializer() { return kSerializer; }
    @JsonProperty("KSerializer")
    public void setKSerializer(long value) { this.kSerializer = value; }
}
