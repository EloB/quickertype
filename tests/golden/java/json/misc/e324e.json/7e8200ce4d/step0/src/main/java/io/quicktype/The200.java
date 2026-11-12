package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class The200 {
    private String description;
    private Schema schema;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("schema")
    public Schema getSchema() { return schema; }
    @JsonProperty("schema")
    public void setSchema(Schema value) { this.schema = value; }
}
