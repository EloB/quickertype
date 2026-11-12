package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DatasetSummary {
    private String contactInformation;
    private String coverage;
    private String granularity;
    private String organization;
    private String postingFrequency;
    private String timePeriod;

    @JsonProperty("Contact Information")
    public String getContactInformation() { return contactInformation; }
    @JsonProperty("Contact Information")
    public void setContactInformation(String value) { this.contactInformation = value; }

    @JsonProperty("Coverage")
    public String getCoverage() { return coverage; }
    @JsonProperty("Coverage")
    public void setCoverage(String value) { this.coverage = value; }

    @JsonProperty("Granularity")
    public String getGranularity() { return granularity; }
    @JsonProperty("Granularity")
    public void setGranularity(String value) { this.granularity = value; }

    @JsonProperty("Organization")
    public String getOrganization() { return organization; }
    @JsonProperty("Organization")
    public void setOrganization(String value) { this.organization = value; }

    @JsonProperty("Posting Frequency")
    public String getPostingFrequency() { return postingFrequency; }
    @JsonProperty("Posting Frequency")
    public void setPostingFrequency(String value) { this.postingFrequency = value; }

    @JsonProperty("Time Period")
    public String getTimePeriod() { return timePeriod; }
    @JsonProperty("Time Period")
    public void setTimePeriod(String value) { this.timePeriod = value; }
}
