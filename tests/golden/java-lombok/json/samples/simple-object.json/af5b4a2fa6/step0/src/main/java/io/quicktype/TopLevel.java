package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long date;
    private String title;
    private boolean validity;

    @JsonProperty("date")
    public long getDate() { return date; }
    @JsonProperty("date")
    public void setDate(long value) { this.date = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("validity")
    public boolean getValidity() { return validity; }
    @JsonProperty("validity")
    public void setValidity(boolean value) { this.validity = value; }
}
