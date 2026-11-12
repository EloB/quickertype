package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TextNode {
    private long textNode;

    @JsonProperty("TextNode")
    public long getTextNode() { return textNode; }
    @JsonProperty("TextNode")
    public void setTextNode(long value) { this.textNode = value; }
}
