package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONEncoder {
    private long jsonEncoder;

    @JsonProperty("JSONEncoder")
    public long getJSONEncoder() { return jsonEncoder; }
    @JsonProperty("JSONEncoder")
    public void setJSONEncoder(long value) { this.jsonEncoder = value; }
}
