package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ToDict {
    private long toDict;

    @JsonProperty("to_dict")
    public long getToDict() { return toDict; }
    @JsonProperty("to_dict")
    public void setToDict(long value) { this.toDict = value; }
}
