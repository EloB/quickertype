package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ClassClass {
    private long classClass;

    @JsonProperty("Class")
    public long getClassClass() { return classClass; }
    @JsonProperty("Class")
    public void setClassClass(long value) { this.classClass = value; }
}
