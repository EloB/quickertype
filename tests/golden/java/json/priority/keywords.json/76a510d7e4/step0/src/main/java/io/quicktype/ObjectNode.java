package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectNode {
    private long objectNode;

    @JsonProperty("ObjectNode")
    public long getObjectNode() { return objectNode; }
    @JsonProperty("ObjectNode")
    public void setObjectNode(long value) { this.objectNode = value; }
}
