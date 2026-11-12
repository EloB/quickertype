package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Group {
    private Code code;
    private English english;
    private Thai thai;
    private String website;

    @JsonProperty("code")
    public Code getCode() { return code; }
    @JsonProperty("code")
    public void setCode(Code value) { this.code = value; }

    @JsonProperty("english")
    public English getEnglish() { return english; }
    @JsonProperty("english")
    public void setEnglish(English value) { this.english = value; }

    @JsonProperty("thai")
    public Thai getThai() { return thai; }
    @JsonProperty("thai")
    public void setThai(Thai value) { this.thai = value; }

    @JsonProperty("website")
    public String getWebsite() { return website; }
    @JsonProperty("website")
    public void setWebsite(String value) { this.website = value; }
}
