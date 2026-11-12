package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, Long> map;

    @JsonProperty("map")
    public Map<String, Long> getMap() { return map; }
    @JsonProperty("map")
    public void setMap(Map<String, Long> value) { this.map = value; }
}
