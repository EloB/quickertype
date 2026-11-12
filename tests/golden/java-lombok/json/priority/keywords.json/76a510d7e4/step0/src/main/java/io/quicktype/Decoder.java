package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Decoder {
    private long decoder;

    @JsonProperty("Decoder")
    public long getDecoder() { return decoder; }
    @JsonProperty("Decoder")
    public void setDecoder(long value) { this.decoder = value; }
}
