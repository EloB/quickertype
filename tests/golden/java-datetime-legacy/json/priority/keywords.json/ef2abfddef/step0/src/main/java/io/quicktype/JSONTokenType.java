package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONTokenType {
    private long jsonTokenType;

    @JsonProperty("JsonTokenType")
    public long getJSONTokenType() { return jsonTokenType; }
    @JsonProperty("JsonTokenType")
    public void setJSONTokenType(long value) { this.jsonTokenType = value; }
}
