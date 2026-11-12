package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Prize {
    private List<AffiliationElement> affiliations;
    private Category category;
    private String motivation;
    private String overallMotivation;
    private String share;
    private String year;

    @JsonProperty("affiliations")
    public List<AffiliationElement> getAffiliations() { return affiliations; }
    @JsonProperty("affiliations")
    public void setAffiliations(List<AffiliationElement> value) { this.affiliations = value; }

    @JsonProperty("category")
    public Category getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(Category value) { this.category = value; }

    @JsonProperty("motivation")
    public String getMotivation() { return motivation; }
    @JsonProperty("motivation")
    public void setMotivation(String value) { this.motivation = value; }

    @JsonProperty("overallMotivation")
    public String getOverallMotivation() { return overallMotivation; }
    @JsonProperty("overallMotivation")
    public void setOverallMotivation(String value) { this.overallMotivation = value; }

    @JsonProperty("share")
    public String getShare() { return share; }
    @JsonProperty("share")
    public void setShare(String value) { this.share = value; }

    @JsonProperty("year")
    public String getYear() { return year; }
    @JsonProperty("year")
    public void setYear(String value) { this.year = value; }
}
