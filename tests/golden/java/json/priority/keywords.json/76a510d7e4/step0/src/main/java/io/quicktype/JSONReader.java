package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONReader {
    private long jsonReader;

    @JsonProperty("JsonReader")
    public long getJSONReader() { return jsonReader; }
    @JsonProperty("JsonReader")
    public void setJSONReader(long value) { this.jsonReader = value; }
}
