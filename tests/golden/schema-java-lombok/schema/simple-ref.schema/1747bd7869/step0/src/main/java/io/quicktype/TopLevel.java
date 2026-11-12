package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * A recursive class type
 */
public class TopLevel {
    private TopLevel next;

    @JsonProperty("next")
    public TopLevel getNext() { return next; }
    @JsonProperty("next")
    public void setNext(TopLevel value) { this.next = value; }
}
