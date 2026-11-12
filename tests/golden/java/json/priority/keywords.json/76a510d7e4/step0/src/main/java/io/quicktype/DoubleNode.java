package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DoubleNode {
    private long doubleNode;

    @JsonProperty("DoubleNode")
    public long getDoubleNode() { return doubleNode; }
    @JsonProperty("DoubleNode")
    public void setDoubleNode(long value) { this.doubleNode = value; }
}
