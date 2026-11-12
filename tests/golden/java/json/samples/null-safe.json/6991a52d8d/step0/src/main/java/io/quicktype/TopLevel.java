package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Item> item;

    @JsonProperty("item")
    public List<Item> getItem() { return item; }
    @JsonProperty("item")
    public void setItem(List<Item> value) { this.item = value; }
}
