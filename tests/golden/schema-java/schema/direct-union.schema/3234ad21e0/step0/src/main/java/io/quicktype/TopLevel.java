package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private ArrayNode arrayNode;
    private BooleanNode booleanNode;
    private DoubleNode doubleNode;
    private IntNode intNode;
    private LongNode longNode;
    private NullNode nullNode;
    private ObjectNode objectNode;
    private Map<String, Thing> stuff;
    private TextNode textNode;

    @JsonProperty("arrayNode")
    public ArrayNode getArrayNode() { return arrayNode; }
    @JsonProperty("arrayNode")
    public void setArrayNode(ArrayNode value) { this.arrayNode = value; }

    @JsonProperty("booleanNode")
    public BooleanNode getBooleanNode() { return booleanNode; }
    @JsonProperty("booleanNode")
    public void setBooleanNode(BooleanNode value) { this.booleanNode = value; }

    @JsonProperty("doubleNode")
    public DoubleNode getDoubleNode() { return doubleNode; }
    @JsonProperty("doubleNode")
    public void setDoubleNode(DoubleNode value) { this.doubleNode = value; }

    @JsonProperty("intNode")
    public IntNode getIntNode() { return intNode; }
    @JsonProperty("intNode")
    public void setIntNode(IntNode value) { this.intNode = value; }

    @JsonProperty("longNode")
    public LongNode getLongNode() { return longNode; }
    @JsonProperty("longNode")
    public void setLongNode(LongNode value) { this.longNode = value; }

    @JsonProperty("nullNode")
    public NullNode getNullNode() { return nullNode; }
    @JsonProperty("nullNode")
    public void setNullNode(NullNode value) { this.nullNode = value; }

    @JsonProperty("objectNode")
    public ObjectNode getObjectNode() { return objectNode; }
    @JsonProperty("objectNode")
    public void setObjectNode(ObjectNode value) { this.objectNode = value; }

    @JsonProperty("stuff")
    public Map<String, Thing> getStuff() { return stuff; }
    @JsonProperty("stuff")
    public void setStuff(Map<String, Thing> value) { this.stuff = value; }

    @JsonProperty("textNode")
    public TextNode getTextNode() { return textNode; }
    @JsonProperty("textNode")
    public void setTextNode(TextNode value) { this.textNode = value; }
}
