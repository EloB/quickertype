package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * The top-level class.
 * Its description has two lines.
 */
public class TopLevel {
    private Boolean bar;
    private Enum topLevelEnum;
    private Double foo;
    private ObjectOrStringUnion objectOrString;
    private Union union;

    /**
     * A pretty boolean
     */
    @JsonProperty("bar")
    public Boolean getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(Boolean value) { this.bar = value; }

    /**
     * An enumeration
     */
    @JsonProperty("enum")
    public Enum getTopLevelEnum() { return topLevelEnum; }
    @JsonProperty("enum")
    public void setTopLevelEnum(Enum value) { this.topLevelEnum = value; }

    @JsonProperty("foo")
    public Double getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Double value) { this.foo = value; }

    @JsonProperty("object-or-string")
    public ObjectOrStringUnion getObjectOrString() { return objectOrString; }
    @JsonProperty("object-or-string")
    public void setObjectOrString(ObjectOrStringUnion value) { this.objectOrString = value; }

    /**
     * Either a number or a string
     */
    @JsonProperty("union")
    public Union getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(Union value) { this.union = value; }
}
