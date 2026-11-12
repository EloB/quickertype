package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, Datum> data;
    private Description description;

    @JsonProperty("data")
    public Map<String, Datum> getData() { return data; }
    @JsonProperty("data")
    public void setData(Map<String, Datum> value) { this.data = value; }

    @JsonProperty("description")
    public Description getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(Description value) { this.description = value; }
}
