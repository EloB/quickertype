package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OtherName {
    private String name;
    private String note;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("note")
    public String getNote() { return note; }
    @JsonProperty("note")
    public void setNote(String value) { this.note = value; }
}
