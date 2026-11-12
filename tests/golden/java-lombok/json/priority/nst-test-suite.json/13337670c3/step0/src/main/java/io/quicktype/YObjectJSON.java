package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectJSON {
    private String asd;
    private String dfg;

    @JsonProperty("asd")
    public String getAsd() { return asd; }
    @JsonProperty("asd")
    public void setAsd(String value) { this.asd = value; }

    @JsonProperty("dfg")
    public String getDfg() { return dfg; }
    @JsonProperty("dfg")
    public void setDfg(String value) { this.dfg = value; }
}
