package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONGenerator {
    private long jsonGenerator;

    @JsonProperty("JsonGenerator")
    public long getJSONGenerator() { return jsonGenerator; }
    @JsonProperty("JsonGenerator")
    public void setJSONGenerator(long value) { this.jsonGenerator = value; }
}
