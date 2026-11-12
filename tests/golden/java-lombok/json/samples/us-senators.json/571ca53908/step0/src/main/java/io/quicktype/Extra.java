package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Extra {
    private String address;
    private String contactForm;
    private String fax;
    private String office;
    private String rssURL;

    @JsonProperty("address")
    public String getAddress() { return address; }
    @JsonProperty("address")
    public void setAddress(String value) { this.address = value; }

    @JsonProperty("contact_form")
    public String getContactForm() { return contactForm; }
    @JsonProperty("contact_form")
    public void setContactForm(String value) { this.contactForm = value; }

    @JsonProperty("fax")
    public String getFax() { return fax; }
    @JsonProperty("fax")
    public void setFax(String value) { this.fax = value; }

    @JsonProperty("office")
    public String getOffice() { return office; }
    @JsonProperty("office")
    public void setOffice(String value) { this.office = value; }

    @JsonProperty("rss_url")
    public String getRSSURL() { return rssURL; }
    @JsonProperty("rss_url")
    public void setRSSURL(String value) { this.rssURL = value; }
}
