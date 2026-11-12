package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MapEntry {
    private long mapEntry;

    @JsonProperty("MapEntry")
    public long getMapEntry() { return mapEntry; }
    @JsonProperty("MapEntry")
    public void setMapEntry(long value) { this.mapEntry = value; }
}
