package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONToken {
    private long jsonToken;

    @JsonProperty("json_token")
    public long getJSONToken() { return jsonToken; }
    @JsonProperty("json_token")
    public void setJSONToken(long value) { this.jsonToken = value; }
}
