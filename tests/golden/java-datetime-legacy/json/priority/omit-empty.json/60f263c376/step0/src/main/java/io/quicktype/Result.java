package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Result {
    private long age;
    private Object name;

    @JsonProperty("age")
    public long getAge() { return age; }
    @JsonProperty("age")
    public void setAge(long value) { this.age = value; }

    @JsonProperty("name")
    public Object getName() { return name; }
    @JsonProperty("name")
    public void setName(Object value) { this.name = value; }
}
