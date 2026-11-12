package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevelElement {
    private Adminregion adminregion;
    private String capitalCity;
    private String id;
    private Adminregion incomeLevel;
    private String iso2Code;
    private String latitude;
    private Adminregion lendingType;
    private String longitude;
    private String name;
    private Adminregion region;

    @JsonProperty("adminregion")
    public Adminregion getAdminregion() { return adminregion; }
    @JsonProperty("adminregion")
    public void setAdminregion(Adminregion value) { this.adminregion = value; }

    @JsonProperty("capitalCity")
    public String getCapitalCity() { return capitalCity; }
    @JsonProperty("capitalCity")
    public void setCapitalCity(String value) { this.capitalCity = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("incomeLevel")
    public Adminregion getIncomeLevel() { return incomeLevel; }
    @JsonProperty("incomeLevel")
    public void setIncomeLevel(Adminregion value) { this.incomeLevel = value; }

    @JsonProperty("iso2Code")
    public String getIso2Code() { return iso2Code; }
    @JsonProperty("iso2Code")
    public void setIso2Code(String value) { this.iso2Code = value; }

    @JsonProperty("latitude")
    public String getLatitude() { return latitude; }
    @JsonProperty("latitude")
    public void setLatitude(String value) { this.latitude = value; }

    @JsonProperty("lendingType")
    public Adminregion getLendingType() { return lendingType; }
    @JsonProperty("lendingType")
    public void setLendingType(Adminregion value) { this.lendingType = value; }

    @JsonProperty("longitude")
    public String getLongitude() { return longitude; }
    @JsonProperty("longitude")
    public void setLongitude(String value) { this.longitude = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("region")
    public Adminregion getRegion() { return region; }
    @JsonProperty("region")
    public void setRegion(Adminregion value) { this.region = value; }
}
