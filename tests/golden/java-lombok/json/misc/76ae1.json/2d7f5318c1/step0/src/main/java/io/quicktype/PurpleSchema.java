package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurpleSchema {
    private ItemsClass items;
    private SchemaType type;

    @JsonProperty("items")
    public ItemsClass getItems() { return items; }
    @JsonProperty("items")
    public void setItems(ItemsClass value) { this.items = value; }

    @JsonProperty("type")
    public SchemaType getType() { return type; }
    @JsonProperty("type")
    public void setType(SchemaType value) { this.type = value; }
}
