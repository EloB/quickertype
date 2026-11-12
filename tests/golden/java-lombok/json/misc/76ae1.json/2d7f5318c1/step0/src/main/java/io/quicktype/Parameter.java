package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Parameter {
    private String description;
    private FormatEnum format;
    private In in;
    private String name;
    private boolean required;
    private FormatEnum type;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("format")
    public FormatEnum getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(FormatEnum value) { this.format = value; }

    @JsonProperty("in")
    public In getIn() { return in; }
    @JsonProperty("in")
    public void setIn(In value) { this.in = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("required")
    public boolean getRequired() { return required; }
    @JsonProperty("required")
    public void setRequired(boolean value) { this.required = value; }

    @JsonProperty("type")
    public FormatEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(FormatEnum value) { this.type = value; }
}
