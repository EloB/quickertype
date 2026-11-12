package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Obj1Class {
    private long classClass;

    @JsonProperty("class")
    public long getClassClass() { return classClass; }
    @JsonProperty("class")
    public void setClassClass(long value) { this.classClass = value; }
}
