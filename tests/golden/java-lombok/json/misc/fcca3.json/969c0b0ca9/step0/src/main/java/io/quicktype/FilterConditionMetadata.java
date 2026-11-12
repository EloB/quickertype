package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FilterConditionMetadata {
    private boolean advanced;
    private long unifiedVersion;

    @JsonProperty("advanced")
    public boolean getAdvanced() { return advanced; }
    @JsonProperty("advanced")
    public void setAdvanced(boolean value) { this.advanced = value; }

    @JsonProperty("unifiedVersion")
    public long getUnifiedVersion() { return unifiedVersion; }
    @JsonProperty("unifiedVersion")
    public void setUnifiedVersion(long value) { this.unifiedVersion = value; }
}
