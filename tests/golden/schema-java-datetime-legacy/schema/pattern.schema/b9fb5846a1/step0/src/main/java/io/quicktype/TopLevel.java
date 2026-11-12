package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String pattern1;
    private String pattern2;
    private RegExp regExp;
    private String union;

    @JsonProperty("pattern1")
    public String getPattern1() { return pattern1; }
    @JsonProperty("pattern1")
    public void setPattern1(String value) { this.pattern1 = value; }

    @JsonProperty("pattern2")
    public String getPattern2() { return pattern2; }
    @JsonProperty("pattern2")
    public void setPattern2(String value) { this.pattern2 = value; }

    @JsonProperty("RegExp")
    public RegExp getRegExp() { return regExp; }
    @JsonProperty("RegExp")
    public void setRegExp(RegExp value) { this.regExp = value; }

    @JsonProperty("union")
    public String getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(String value) { this.union = value; }
}
