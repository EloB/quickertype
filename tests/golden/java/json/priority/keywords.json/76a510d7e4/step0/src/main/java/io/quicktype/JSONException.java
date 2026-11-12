package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONException {
    private long jsonException;

    @JsonProperty("JsonException")
    public long getJSONException() { return jsonException; }
    @JsonProperty("JsonException")
    public void setJSONException(long value) { this.jsonException = value; }
}
