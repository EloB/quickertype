package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long id;
    private String name;
    private String notes;

    @JsonProperty("ID")
    public long getID() { return id; }
    @JsonProperty("ID")
    public void setID(long value) { this.id = value; }

    @JsonProperty("Name")
    public String getName() { return name; }
    @JsonProperty("Name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("Notes")
    public String getNotes() { return notes; }
    @JsonProperty("Notes")
    public void setNotes(String value) { this.notes = value; }
}
