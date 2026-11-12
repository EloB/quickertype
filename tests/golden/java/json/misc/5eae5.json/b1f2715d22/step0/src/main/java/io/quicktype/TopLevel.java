package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private OffsetDateTime date;
    private long id;
    private String sponsor;
    private String title;

    @JsonProperty("Date")
    public OffsetDateTime getDate() { return date; }
    @JsonProperty("Date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setDate(OffsetDateTime value) { this.date = value; }

    @JsonProperty("ID")
    public long getID() { return id; }
    @JsonProperty("ID")
    public void setID(long value) { this.id = value; }

    @JsonProperty("Sponsor")
    public String getSponsor() { return sponsor; }
    @JsonProperty("Sponsor")
    public void setSponsor(String value) { this.sponsor = value; }

    @JsonProperty("Title")
    public String getTitle() { return title; }
    @JsonProperty("Title")
    public void setTitle(String value) { this.title = value; }
}
