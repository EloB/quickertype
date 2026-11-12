package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long directorateID;
    private long id;
    private String name;

    @JsonProperty("DirectorateID")
    public long getDirectorateID() { return directorateID; }
    @JsonProperty("DirectorateID")
    public void setDirectorateID(long value) { this.directorateID = value; }

    @JsonProperty("Id")
    public long getID() { return id; }
    @JsonProperty("Id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("Name")
    public String getName() { return name; }
    @JsonProperty("Name")
    public void setName(String value) { this.name = value; }
}
