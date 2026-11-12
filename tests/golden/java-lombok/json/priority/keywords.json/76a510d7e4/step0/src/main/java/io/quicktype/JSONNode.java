package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class JSONNode {
    private long jsonNode;

    @JsonProperty("JsonNode")
    public long getJSONNode() { return jsonNode; }
    @JsonProperty("JsonNode")
    public void setJSONNode(long value) { this.jsonNode = value; }
}
