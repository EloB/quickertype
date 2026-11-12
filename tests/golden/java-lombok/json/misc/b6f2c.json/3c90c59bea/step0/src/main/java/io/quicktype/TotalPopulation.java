package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;

public class TotalPopulation {
    private LocalDate date;
    private long population;

    @JsonProperty("date")
    public LocalDate getDate() { return date; }
    @JsonProperty("date")
    public void setDate(LocalDate value) { this.date = value; }

    @JsonProperty("population")
    public long getPopulation() { return population; }
    @JsonProperty("population")
    public void setPopulation(long value) { this.population = value; }
}
