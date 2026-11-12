package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CodingKey {
    private long codingKey;

    @JsonProperty("CodingKey")
    public long getCodingKey() { return codingKey; }
    @JsonProperty("CodingKey")
    public void setCodingKey(long value) { this.codingKey = value; }
}
