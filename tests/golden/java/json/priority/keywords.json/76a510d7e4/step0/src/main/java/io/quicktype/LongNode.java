package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LongNode {
    private long longNode;

    @JsonProperty("LongNode")
    public long getLongNode() { return longNode; }
    @JsonProperty("LongNode")
    public void setLongNode(long value) { this.longNode = value; }
}
