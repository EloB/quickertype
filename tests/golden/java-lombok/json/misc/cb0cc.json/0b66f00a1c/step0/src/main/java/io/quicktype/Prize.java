package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Prize {
    private Category category;
    private List<Laureate> laureates;
    private String overallMotivation;
    private String year;

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }

    @JsonProperty("laureates")
    public List<Laureate> getLaureates() { return laureates; }
    @JsonProperty("laureates")
    public void setLaureates(List<Laureate> value) { this.laureates = value; }

    @JsonProperty("overallMotivation")
    public String getOverallMotivation() { return overallMotivation; }
    @JsonProperty("overallMotivation")
    public void setOverallMotivation(String value) { this.overallMotivation = value; }

    @JsonProperty("year")
    public String getYear() { return year; }
    @JsonProperty("year")
    public void setYear(String value) { this.year = value; }
}
