package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IndigoComment {
    private String returns;
    private String shortText;

    @JsonProperty("returns")
    public String getReturns() { return returns; }
    @JsonProperty("returns")
    public void setReturns(String value) { this.returns = value; }

    @JsonProperty("shortText")
    public String getShortText() { return shortText; }
    @JsonProperty("shortText")
    public void setShortText(String value) { this.shortText = value; }
}
