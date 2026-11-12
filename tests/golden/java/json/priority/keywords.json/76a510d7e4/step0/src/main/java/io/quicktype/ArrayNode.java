package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ArrayNode {
    private long arrayNode;

    @JsonProperty("ArrayNode")
    public long getArrayNode() { return arrayNode; }
    @JsonProperty("ArrayNode")
    public void setArrayNode(long value) { this.arrayNode = value; }
}
