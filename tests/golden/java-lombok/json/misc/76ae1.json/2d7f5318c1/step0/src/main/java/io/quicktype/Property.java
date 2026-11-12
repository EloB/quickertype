package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Property {
    private String description;
    private FormatEnum type;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("type")
    public FormatEnum getType() { return type; }
    @JsonProperty("type")
    public void setType(FormatEnum value) { this.type = value; }
}
