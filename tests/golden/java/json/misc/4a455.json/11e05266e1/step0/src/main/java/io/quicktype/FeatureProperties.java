package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FeatureProperties {
    private String facebookaccount;
    private String frequencyfinderurl;
    private String name;
    private String siteurl;
    private String streetaddress;
    private String twitteraccount;

    @JsonProperty("facebookaccount")
    public String getFacebookaccount() { return facebookaccount; }
    @JsonProperty("facebookaccount")
    public void setFacebookaccount(String value) { this.facebookaccount = value; }

    @JsonProperty("frequencyfinderurl")
    public String getFrequencyfinderurl() { return frequencyfinderurl; }
    @JsonProperty("frequencyfinderurl")
    public void setFrequencyfinderurl(String value) { this.frequencyfinderurl = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("siteurl")
    public String getSiteurl() { return siteurl; }
    @JsonProperty("siteurl")
    public void setSiteurl(String value) { this.siteurl = value; }

    @JsonProperty("streetaddress")
    public String getStreetaddress() { return streetaddress; }
    @JsonProperty("streetaddress")
    public void setStreetaddress(String value) { this.streetaddress = value; }

    @JsonProperty("twitteraccount")
    public String getTwitteraccount() { return twitteraccount; }
    @JsonProperty("twitteraccount")
    public void setTwitteraccount(String value) { this.twitteraccount = value; }
}
