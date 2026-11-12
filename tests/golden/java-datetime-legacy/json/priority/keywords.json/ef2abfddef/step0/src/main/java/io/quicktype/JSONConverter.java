package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONConverter {
    private long jsonConverter;

    @JsonProperty("json_converter")
    public long getJSONConverter() { return jsonConverter; }
    @JsonProperty("json_converter")
    public void setJSONConverter(long value) { this.jsonConverter = value; }
}
