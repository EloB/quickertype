package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DeMinimisProperties {
    private Property countries;
    private Property country;
    private Property deMinimisCurrency;
    private Property deMinimisValue;
    private Property notes;
    private Property vatAmount;
    private Property vatCurrency;

    @JsonProperty("countries")
    public Property getCountries() { return countries; }
    @JsonProperty("countries")
    public void setCountries(Property value) { this.countries = value; }

    @JsonProperty("country")
    public Property getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(Property value) { this.country = value; }

    @JsonProperty("de_minimis_currency")
    public Property getDeMinimisCurrency() { return deMinimisCurrency; }
    @JsonProperty("de_minimis_currency")
    public void setDeMinimisCurrency(Property value) { this.deMinimisCurrency = value; }

    @JsonProperty("de_minimis_value")
    public Property getDeMinimisValue() { return deMinimisValue; }
    @JsonProperty("de_minimis_value")
    public void setDeMinimisValue(Property value) { this.deMinimisValue = value; }

    @JsonProperty("notes")
    public Property getNotes() { return notes; }
    @JsonProperty("notes")
    public void setNotes(Property value) { this.notes = value; }

    @JsonProperty("vat_amount")
    public Property getVatAmount() { return vatAmount; }
    @JsonProperty("vat_amount")
    public void setVatAmount(Property value) { this.vatAmount = value; }

    @JsonProperty("vat_currency")
    public Property getVatCurrency() { return vatCurrency; }
    @JsonProperty("vat_currency")
    public void setVatCurrency(Property value) { this.vatCurrency = value; }
}
