package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Meta {
    private String credit;
    private String updated;
    private String url;

    @JsonProperty("credit")
    public String getCredit() { return credit; }
    @JsonProperty("credit")
    public void setCredit(String value) { this.credit = value; }

    @JsonProperty("updated")
    public String getUpdated() { return updated; }
    @JsonProperty("updated")
    public void setUpdated(String value) { this.updated = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
