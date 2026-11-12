package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NotEq {
    private long notEq;

    @JsonProperty("not_eq")
    public long getNotEq() { return notEq; }
    @JsonProperty("not_eq")
    public void setNotEq(long value) { this.notEq = value; }
}
