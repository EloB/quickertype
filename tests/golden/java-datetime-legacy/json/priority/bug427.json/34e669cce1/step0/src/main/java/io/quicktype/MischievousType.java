package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MischievousType {
    private Long id;
    private Name name;
    private String operator;
    private ElementType target;
    private String type;

    @JsonProperty("id")
    public Long getID() { return id; }
    @JsonProperty("id")
    public void setID(Long value) { this.id = value; }

    @JsonProperty("name")
    public Name getName() { return name; }
    @JsonProperty("name")
    public void setName(Name value) { this.name = value; }

    @JsonProperty("operator")
    public String getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(String value) { this.operator = value; }

    @JsonProperty("target")
    public ElementType getTarget() { return target; }
    @JsonProperty("target")
    public void setTarget(ElementType value) { this.target = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
