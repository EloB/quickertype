package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Encoder {
    private long encoder;

    @JsonProperty("Encoder")
    public long getEncoder() { return encoder; }
    @JsonProperty("Encoder")
    public void setEncoder(long value) { this.encoder = value; }
}
