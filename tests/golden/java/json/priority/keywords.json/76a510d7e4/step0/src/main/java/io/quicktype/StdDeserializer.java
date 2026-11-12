package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StdDeserializer {
    private long stdDeserializer;

    @JsonProperty("StdDeserializer")
    public long getStdDeserializer() { return stdDeserializer; }
    @JsonProperty("StdDeserializer")
    public void setStdDeserializer(long value) { this.stdDeserializer = value; }
}
