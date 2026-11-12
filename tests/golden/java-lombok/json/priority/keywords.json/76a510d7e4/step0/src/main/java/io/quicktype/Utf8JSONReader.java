package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Utf8JSONReader {
    private long utf8JSONReader;

    @JsonProperty("Utf8JsonReader")
    public long getUtf8JSONReader() { return utf8JSONReader; }
    @JsonProperty("Utf8JsonReader")
    public void setUtf8JSONReader(long value) { this.utf8JSONReader = value; }
}
