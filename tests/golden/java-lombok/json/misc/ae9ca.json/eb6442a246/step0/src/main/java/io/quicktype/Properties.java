package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Properties {
    private String area;
    private String centralAssetID;
    private String featureLocation;
    private String lat;
    private MaintainingAuthority maintainingAuthority;
    private String number;
    private ClassEnum propertiesClass;
    private String propertiesLong;
    private String siteName;
    private Ward ward;

    @JsonProperty("Area")
    public String getArea() { return area; }
    @JsonProperty("Area")
    public void setArea(String value) { this.area = value; }

    @JsonProperty("Central Asset ID")
    public String getCentralAssetID() { return centralAssetID; }
    @JsonProperty("Central Asset ID")
    public void setCentralAssetID(String value) { this.centralAssetID = value; }

    @JsonProperty("Feature Location")
    public String getFeatureLocation() { return featureLocation; }
    @JsonProperty("Feature Location")
    public void setFeatureLocation(String value) { this.featureLocation = value; }

    @JsonProperty("lat")
    public String getLat() { return lat; }
    @JsonProperty("lat")
    public void setLat(String value) { this.lat = value; }

    @JsonProperty("Maintaining Authority")
    public MaintainingAuthority getMaintainingAuthority() { return maintainingAuthority; }
    @JsonProperty("Maintaining Authority")
    public void setMaintainingAuthority(MaintainingAuthority value) { this.maintainingAuthority = value; }

    @JsonProperty("Number")
    public String getNumber() { return number; }
    @JsonProperty("Number")
    public void setNumber(String value) { this.number = value; }

    @JsonProperty("Class")
    public ClassEnum getPropertiesClass() { return propertiesClass; }
    @JsonProperty("Class")
    public void setPropertiesClass(ClassEnum value) { this.propertiesClass = value; }

    @JsonProperty("long")
    public String getPropertiesLong() { return propertiesLong; }
    @JsonProperty("long")
    public void setPropertiesLong(String value) { this.propertiesLong = value; }

    @JsonProperty("Site Name")
    public String getSiteName() { return siteName; }
    @JsonProperty("Site Name")
    public void setSiteName(String value) { this.siteName = value; }

    @JsonProperty("Ward")
    public Ward getWard() { return ward; }
    @JsonProperty("Ward")
    public void setWard(Ward value) { this.ward = value; }
}
