package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONDecoder {
    private long jsonDecoder;

    @JsonProperty("JSONDecoder")
    public long getJSONDecoder() { return jsonDecoder; }
    @JsonProperty("JSONDecoder")
    public void setJSONDecoder(long value) { this.jsonDecoder = value; }
}
