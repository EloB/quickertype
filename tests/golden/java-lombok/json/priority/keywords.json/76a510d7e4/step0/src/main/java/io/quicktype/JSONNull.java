package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONNull {
    private long jsonNull;

    @JsonProperty("JSONNull")
    public long getJSONNull() { return jsonNull; }
    @JsonProperty("JSONNull")
    public void setJSONNull(long value) { this.jsonNull = value; }
}
