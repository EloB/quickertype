package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private ListClass list;

    @JsonProperty("List")
    public ListClass getList() { return list; }
    @JsonProperty("List")
    public void setList(ListClass value) { this.list = value; }
}
