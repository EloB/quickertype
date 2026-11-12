package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long item;

    @JsonProperty("item")
    public long getItem() { return item; }
    @JsonProperty("item")
    public void setItem(long value) { this.item = value; }
}
