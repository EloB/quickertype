package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Codable {
    private long codable;

    @JsonProperty("Codable")
    public long getCodable() { return codable; }
    @JsonProperty("Codable")
    public void setCodable(long value) { this.codable = value; }
}
