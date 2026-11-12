package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Link {
    private Note note;
    private String url;

    @JsonProperty("note")
    public Note getNote() { return note; }
    @JsonProperty("note")
    public void setNote(Note value) { this.note = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
