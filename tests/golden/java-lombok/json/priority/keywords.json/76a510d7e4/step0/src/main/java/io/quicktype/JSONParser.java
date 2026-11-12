package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONParser {
    private long jsonParser;

    @JsonProperty("JsonParser")
    public long getJSONParser() { return jsonParser; }
    @JsonProperty("JsonParser")
    public void setJSONParser(long value) { this.jsonParser = value; }
}
