package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private TariffRatesSearch tariffRatesSearch;

    @JsonProperty("/tariff_rates/search")
    public TariffRatesSearch getTariffRatesSearch() { return tariffRatesSearch; }
    @JsonProperty("/tariff_rates/search")
    public void setTariffRatesSearch(TariffRatesSearch value) { this.tariffRatesSearch = value; }
}
