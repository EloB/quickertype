package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long age;
    private Country country;
    private long females;
    private long males;
    private long total;
    private long year;

    @JsonProperty("age")
    public long getAge() { return age; }
    @JsonProperty("age")
    public void setAge(long value) { this.age = value; }

    @JsonProperty("country")
    public Country getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(Country value) { this.country = value; }

    @JsonProperty("females")
    public long getFemales() { return females; }
    @JsonProperty("females")
    public void setFemales(long value) { this.females = value; }

    @JsonProperty("males")
    public long getMales() { return males; }
    @JsonProperty("males")
    public void setMales(long value) { this.males = value; }

    @JsonProperty("total")
    public long getTotal() { return total; }
    @JsonProperty("total")
    public void setTotal(long value) { this.total = value; }

    @JsonProperty("year")
    public long getYear() { return year; }
    @JsonProperty("year")
    public void setYear(long value) { this.year = value; }
}
