package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IntNode {
    private long intNode;

    @JsonProperty("IntNode")
    public long getIntNode() { return intNode; }
    @JsonProperty("IntNode")
    public void setIntNode(long value) { this.intNode = value; }
}
