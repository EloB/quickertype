package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurpleComment {
    private String shortText;

    @JsonProperty("shortText")
    public String getShortText() { return shortText; }
    @JsonProperty("shortText")
    public void setShortText(String value) { this.shortText = value; }
}
