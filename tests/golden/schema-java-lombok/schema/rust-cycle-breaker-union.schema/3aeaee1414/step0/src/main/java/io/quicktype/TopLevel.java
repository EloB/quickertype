package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Next next;
    private String value;

    @JsonProperty("next")
    public Next getNext() { return next; }
    @JsonProperty("next")
    public void setNext(Next value) { this.next = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
