package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long data;
    private TopLevel next;

    @JsonProperty("data")
    public long getData() { return data; }
    @JsonProperty("data")
    public void setData(long value) { this.data = value; }

    @JsonProperty("next")
    public TopLevel getNext() { return next; }
    @JsonProperty("next")
    public void setNext(TopLevel value) { this.next = value; }
}
