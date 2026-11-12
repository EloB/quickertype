package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FeatureProperties {
    private String division;
    private double fax;
    private FireBanR fireBanR;
    private double latitude;
    private String localGovt;
    private double longitude;
    private String no;
    private double phone;
    private long postcode;
    private String psa;
    private Region region;
    private String station;
    private String street;
    private String suburb;
    private PropertiesType type;

    @JsonProperty("division")
    public String getDivision() { return division; }
    @JsonProperty("division")
    public void setDivision(String value) { this.division = value; }

    @JsonProperty("fax")
    public double getFax() { return fax; }
    @JsonProperty("fax")
    public void setFax(double value) { this.fax = value; }

    @JsonProperty("fire_ban_r")
    public FireBanR getFireBanR() { return fireBanR; }
    @JsonProperty("fire_ban_r")
    public void setFireBanR(FireBanR value) { this.fireBanR = value; }

    @JsonProperty("latitude")
    public double getLatitude() { return latitude; }
    @JsonProperty("latitude")
    public void setLatitude(double value) { this.latitude = value; }

    @JsonProperty("local_govt")
    public String getLocalGovt() { return localGovt; }
    @JsonProperty("local_govt")
    public void setLocalGovt(String value) { this.localGovt = value; }

    @JsonProperty("longitude")
    public double getLongitude() { return longitude; }
    @JsonProperty("longitude")
    public void setLongitude(double value) { this.longitude = value; }

    @JsonProperty("no")
    public String getNo() { return no; }
    @JsonProperty("no")
    public void setNo(String value) { this.no = value; }

    @JsonProperty("phone")
    public double getPhone() { return phone; }
    @JsonProperty("phone")
    public void setPhone(double value) { this.phone = value; }

    @JsonProperty("postcode")
    public long getPostcode() { return postcode; }
    @JsonProperty("postcode")
    public void setPostcode(long value) { this.postcode = value; }

    @JsonProperty("psa")
    public String getPSA() { return psa; }
    @JsonProperty("psa")
    public void setPSA(String value) { this.psa = value; }

    @JsonProperty("region")
    public Region getRegion() { return region; }
    @JsonProperty("region")
    public void setRegion(Region value) { this.region = value; }

    @JsonProperty("station")
    public String getStation() { return station; }
    @JsonProperty("station")
    public void setStation(String value) { this.station = value; }

    @JsonProperty("street")
    public String getStreet() { return street; }
    @JsonProperty("street")
    public void setStreet(String value) { this.street = value; }

    @JsonProperty("suburb")
    public String getSuburb() { return suburb; }
    @JsonProperty("suburb")
    public void setSuburb(String value) { this.suburb = value; }

    @JsonProperty("type")
    public PropertiesType getType() { return type; }
    @JsonProperty("type")
    public void setType(PropertiesType value) { this.type = value; }
}
