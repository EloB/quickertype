package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<TotalPopulation> totalPopulation;

    @JsonProperty("total_population")
    public List<TotalPopulation> getTotalPopulation() { return totalPopulation; }
    @JsonProperty("total_population")
    public void setTotalPopulation(List<TotalPopulation> value) { this.totalPopulation = value; }
}
