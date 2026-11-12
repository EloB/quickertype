package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Evolution {
    private String name;
    private String num;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("num")
    public String getNum() { return num; }
    @JsonProperty("num")
    public void setNum(String value) { this.num = value; }
}
