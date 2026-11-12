package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OutcomeStatus {
    private String category;
    private String date;

    @JsonProperty("category")
    public String getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(String value) { this.category = value; }

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }
}
