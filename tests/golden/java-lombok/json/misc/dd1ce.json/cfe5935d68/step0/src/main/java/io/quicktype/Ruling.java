package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;

public class Ruling {
    private LocalDate date;
    private String text;

    @JsonProperty("date")
    public LocalDate getDate() { return date; }
    @JsonProperty("date")
    public void setDate(LocalDate value) { this.date = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
