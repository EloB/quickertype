package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Fluffy200 {
    private String description;
    private PurpleSchema schema;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("schema")
    public PurpleSchema getSchema() { return schema; }
    @JsonProperty("schema")
    public void setSchema(PurpleSchema value) { this.schema = value; }
}
