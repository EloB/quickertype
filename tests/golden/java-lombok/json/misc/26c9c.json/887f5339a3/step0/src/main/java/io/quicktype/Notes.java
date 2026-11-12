package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Notes {
    private String notes;

    @JsonProperty("Notes")
    public String getNotes() { return notes; }
    @JsonProperty("Notes")
    public void setNotes(String value) { this.notes = value; }
}
