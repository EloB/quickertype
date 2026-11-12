package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class BooleanNode {
    private long booleanNode;

    @JsonProperty("BooleanNode")
    public long getBooleanNode() { return booleanNode; }
    @JsonProperty("BooleanNode")
    public void setBooleanNode(long value) { this.booleanNode = value; }
}
