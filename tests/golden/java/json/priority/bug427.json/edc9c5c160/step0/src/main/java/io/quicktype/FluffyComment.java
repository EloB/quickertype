package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FluffyComment {
    private String text;

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
