package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UnionListClass {
    private UnionList next;

    @JsonProperty("next")
    public UnionList getNext() { return next; }
    @JsonProperty("next")
    public void setNext(UnionList value) { this.next = value; }
}
