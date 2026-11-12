package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Export {
    private long export;

    @JsonProperty("export")
    public long getExport() { return export; }
    @JsonProperty("export")
    public void setExport(long value) { this.export = value; }
}
