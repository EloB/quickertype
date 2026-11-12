package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Properties {
    private ClickURL clickURL;
    private ClickURL country;
    private ClickURL description;
    private ClickURL expirationDate;
    private ClickURL id;
    private ClickURL industry;
    private ClickURL reportType;
    private ClickURL sourceIndustry;
    private ClickURL title;
    private ClickURL url;

    @JsonProperty("click_url")
    public ClickURL getClickURL() { return clickURL; }
    @JsonProperty("click_url")
    public void setClickURL(ClickURL value) { this.clickURL = value; }

    @JsonProperty("country")
    public ClickURL getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(ClickURL value) { this.country = value; }

    @JsonProperty("description")
    public ClickURL getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(ClickURL value) { this.description = value; }

    @JsonProperty("expiration_date")
    public ClickURL getExpirationDate() { return expirationDate; }
    @JsonProperty("expiration_date")
    public void setExpirationDate(ClickURL value) { this.expirationDate = value; }

    @JsonProperty("id")
    public ClickURL getID() { return id; }
    @JsonProperty("id")
    public void setID(ClickURL value) { this.id = value; }

    @JsonProperty("industry")
    public ClickURL getIndustry() { return industry; }
    @JsonProperty("industry")
    public void setIndustry(ClickURL value) { this.industry = value; }

    @JsonProperty("report_type")
    public ClickURL getReportType() { return reportType; }
    @JsonProperty("report_type")
    public void setReportType(ClickURL value) { this.reportType = value; }

    @JsonProperty("source_industry")
    public ClickURL getSourceIndustry() { return sourceIndustry; }
    @JsonProperty("source_industry")
    public void setSourceIndustry(ClickURL value) { this.sourceIndustry = value; }

    @JsonProperty("title")
    public ClickURL getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(ClickURL value) { this.title = value; }

    @JsonProperty("url")
    public ClickURL getURL() { return url; }
    @JsonProperty("url")
    public void setURL(ClickURL value) { this.url = value; }
}
