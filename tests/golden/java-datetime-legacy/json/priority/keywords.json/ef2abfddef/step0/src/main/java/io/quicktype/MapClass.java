package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MapClass {
    private long map;

    @JsonProperty("map")
    public long getMap() { return map; }
    @JsonProperty("map")
    public void setMap(long value) { this.map = value; }
}
