package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CodingKeys {
    private long codingKeys;

    @JsonProperty("CodingKeys")
    public long getCodingKeys() { return codingKeys; }
    @JsonProperty("CodingKeys")
    public void setCodingKeys(long value) { this.codingKeys = value; }
}
