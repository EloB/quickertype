package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSON {
    private long json;

    @JsonProperty("json")
    public long getJSON() { return json; }
    @JsonProperty("json")
    public void setJSON(long value) { this.json = value; }
}
