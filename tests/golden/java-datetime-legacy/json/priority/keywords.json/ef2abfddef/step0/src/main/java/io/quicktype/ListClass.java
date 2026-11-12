package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ListClass {
    private long list;

    @JsonProperty("list")
    public long getList() { return list; }
    @JsonProperty("list")
    public void setList(long value) { this.list = value; }
}
