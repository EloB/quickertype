package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private UnionList list;

    @JsonProperty("list")
    public UnionList getList() { return list; }
    @JsonProperty("list")
    public void setList(UnionList value) { this.list = value; }
}
