package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ToJSON {
    private long toJSON;

    @JsonProperty("to_json")
    public long getToJSON() { return toJSON; }
    @JsonProperty("to_json")
    public void setToJSON(long value) { this.toJSON = value; }
}
