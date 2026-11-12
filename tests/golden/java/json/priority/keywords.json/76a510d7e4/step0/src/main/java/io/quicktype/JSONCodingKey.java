package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONCodingKey {
    private long jsonCodingKey;

    @JsonProperty("JSONCodingKey")
    public long getJSONCodingKey() { return jsonCodingKey; }
    @JsonProperty("JSONCodingKey")
    public void setJSONCodingKey(long value) { this.jsonCodingKey = value; }
}
