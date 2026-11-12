package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, MapValue> map;

    @JsonProperty("map")
    public Map<String, MapValue> getMap() { return map; }
    @JsonProperty("map")
    public void setMap(Map<String, MapValue> value) { this.map = value; }
}
