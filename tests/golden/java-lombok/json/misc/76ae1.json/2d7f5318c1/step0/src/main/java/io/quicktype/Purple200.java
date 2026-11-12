package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Purple200 {
    private String description;
    private ItemsClass schema;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("schema")
    public ItemsClass getSchema() { return schema; }
    @JsonProperty("schema")
    public void setSchema(ItemsClass value) { this.schema = value; }
}
