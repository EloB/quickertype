package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Parameter {
    private String description;
    private String format;
    private String in;
    private String name;
    private boolean required;
    private String type;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("format")
    public String getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(String value) { this.format = value; }

    @JsonProperty("in")
    public String getIn() { return in; }
    @JsonProperty("in")
    public void setIn(String value) { this.in = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("required")
    public boolean getRequired() { return required; }
    @JsonProperty("required")
    public void setRequired(boolean value) { this.required = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
