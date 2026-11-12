package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ReportProperties {
    private Property countries;
    private Property description;
    private Property expirationDate;
    private Property id;
    private Property industries;
    private Property itaIndustries;
    private Property reportType;
    private Property title;
    private Property url;

    @JsonProperty("countries")
    public Property getCountries() { return countries; }
    @JsonProperty("countries")
    public void setCountries(Property value) { this.countries = value; }

    @JsonProperty("description")
    public Property getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(Property value) { this.description = value; }

    @JsonProperty("expiration_date")
    public Property getExpirationDate() { return expirationDate; }
    @JsonProperty("expiration_date")
    public void setExpirationDate(Property value) { this.expirationDate = value; }

    @JsonProperty("id")
    public Property getID() { return id; }
    @JsonProperty("id")
    public void setID(Property value) { this.id = value; }

    @JsonProperty("industries")
    public Property getIndustries() { return industries; }
    @JsonProperty("industries")
    public void setIndustries(Property value) { this.industries = value; }

    @JsonProperty("ita_industries")
    public Property getItaIndustries() { return itaIndustries; }
    @JsonProperty("ita_industries")
    public void setItaIndustries(Property value) { this.itaIndustries = value; }

    @JsonProperty("report_type")
    public Property getReportType() { return reportType; }
    @JsonProperty("report_type")
    public void setReportType(Property value) { this.reportType = value; }

    @JsonProperty("title")
    public Property getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(Property value) { this.title = value; }

    @JsonProperty("url")
    public Property getURL() { return url; }
    @JsonProperty("url")
    public void setURL(Property value) { this.url = value; }
}
