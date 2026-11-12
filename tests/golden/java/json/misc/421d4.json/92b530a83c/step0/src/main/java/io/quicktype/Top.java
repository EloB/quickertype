package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Top {
    private long count;
    private String item;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("item")
    public String getItem() { return item; }
    @JsonProperty("item")
    public void setItem(String value) { this.item = value; }
}
