package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FromDict {
    private long fromDict;

    @JsonProperty("from_dict")
    public long getFromDict() { return fromDict; }
    @JsonProperty("from_dict")
    public void setFromDict(long value) { this.fromDict = value; }
}
