package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectBasicJSON {
    private String asd;

    @JsonProperty("asd")
    public String getAsd() { return asd; }
    @JsonProperty("asd")
    public void setAsd(String value) { this.asd = value; }
}
