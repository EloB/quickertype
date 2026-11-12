package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TentacledComment {
    private String shortText;
    private String text;

    @JsonProperty("shortText")
    public String getShortText() { return shortText; }
    @JsonProperty("shortText")
    public void setShortText(String value) { this.shortText = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
