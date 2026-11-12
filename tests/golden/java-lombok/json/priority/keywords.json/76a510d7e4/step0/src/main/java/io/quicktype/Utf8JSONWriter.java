package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Utf8JSONWriter {
    private long utf8JSONWriter;

    @JsonProperty("Utf8JsonWriter")
    public long getUtf8JSONWriter() { return utf8JSONWriter; }
    @JsonProperty("Utf8JsonWriter")
    public void setUtf8JSONWriter(long value) { this.utf8JSONWriter = value; }
}
