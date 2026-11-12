package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Do {
    private long doDo;

    @JsonProperty("do")
    public long getDoDo() { return doDo; }
    @JsonProperty("do")
    public void setDoDo(long value) { this.doDo = value; }
}
