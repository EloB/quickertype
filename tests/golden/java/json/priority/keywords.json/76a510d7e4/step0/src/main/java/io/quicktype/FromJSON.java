package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FromJSON {
    private long fromJSON;

    @JsonProperty("from_json")
    public long getFromJSON() { return fromJSON; }
    @JsonProperty("from_json")
    public void setFromJSON(long value) { this.fromJSON = value; }
}
