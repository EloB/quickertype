package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectWithNewlinesJSON {
    private String a;

    @JsonProperty("a")
    public String getA() { return a; }
    @JsonProperty("a")
    public void setA(String value) { this.a = value; }
}
