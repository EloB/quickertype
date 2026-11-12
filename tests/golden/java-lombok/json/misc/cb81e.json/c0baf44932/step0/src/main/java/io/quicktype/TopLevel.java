package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, String> data;
    private Description description;

    @JsonProperty("data")
    public Map<String, String> getData() { return data; }
    @JsonProperty("data")
    public void setData(Map<String, String> value) { this.data = value; }

    @JsonProperty("description")
    public Description getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(Description value) { this.description = value; }
}
