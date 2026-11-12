package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.util.List;

public class Laureate {
    private BornUnion born;
    private String bornCity;
    private String bornCountry;
    private String bornCountryCode;
    private BornUnion died;
    private String diedCity;
    private String diedCountry;
    private String diedCountryCode;
    private String firstname;
    private Gender gender;
    private String id;
    private List<Prize> prizes;
    private String surname;

    @JsonProperty("born")
    public BornUnion getBorn() { return born; }
    @JsonProperty("born")
    public void setBorn(BornUnion value) { this.born = value; }

    @JsonProperty("bornCity")
    public String getBornCity() { return bornCity; }
    @JsonProperty("bornCity")
    public void setBornCity(String value) { this.bornCity = value; }

    @JsonProperty("bornCountry")
    public String getBornCountry() { return bornCountry; }
    @JsonProperty("bornCountry")
    public void setBornCountry(String value) { this.bornCountry = value; }

    @JsonProperty("bornCountryCode")
    public String getBornCountryCode() { return bornCountryCode; }
    @JsonProperty("bornCountryCode")
    public void setBornCountryCode(String value) { this.bornCountryCode = value; }

    @JsonProperty("died")
    public BornUnion getDied() { return died; }
    @JsonProperty("died")
    public void setDied(BornUnion value) { this.died = value; }

    @JsonProperty("diedCity")
    public String getDiedCity() { return diedCity; }
    @JsonProperty("diedCity")
    public void setDiedCity(String value) { this.diedCity = value; }

    @JsonProperty("diedCountry")
    public String getDiedCountry() { return diedCountry; }
    @JsonProperty("diedCountry")
    public void setDiedCountry(String value) { this.diedCountry = value; }

    @JsonProperty("diedCountryCode")
    public String getDiedCountryCode() { return diedCountryCode; }
    @JsonProperty("diedCountryCode")
    public void setDiedCountryCode(String value) { this.diedCountryCode = value; }

    @JsonProperty("firstname")
    public String getFirstname() { return firstname; }
    @JsonProperty("firstname")
    public void setFirstname(String value) { this.firstname = value; }

    @JsonProperty("gender")
    public Gender getGender() { return gender; }
    @JsonProperty("gender")
    public void setGender(Gender value) { this.gender = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("prizes")
    public List<Prize> getPrizes() { return prizes; }
    @JsonProperty("prizes")
    public void setPrizes(List<Prize> value) { this.prizes = value; }

    @JsonProperty("surname")
    public String getSurname() { return surname; }
    @JsonProperty("surname")
    public void setSurname(String value) { this.surname = value; }
}
