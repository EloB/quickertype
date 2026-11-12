package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NullNode {
    private long nullNode;

    @JsonProperty("NullNode")
    public long getNullNode() { return nullNode; }
    @JsonProperty("NullNode")
    public void setNullNode(long value) { this.nullNode = value; }
}
