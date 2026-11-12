package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Datum {
    private List<Footnote> footnotes;
    private String period;
    private String periodName;
    private String value;
    private String year;

    @JsonProperty("footnotes")
    public List<Footnote> getFootnotes() { return footnotes; }
    @JsonProperty("footnotes")
    public void setFootnotes(List<Footnote> value) { this.footnotes = value; }

    @JsonProperty("period")
    public String getPeriod() { return period; }
    @JsonProperty("period")
    public void setPeriod(String value) { this.period = value; }

    @JsonProperty("periodName")
    public String getPeriodName() { return periodName; }
    @JsonProperty("periodName")
    public void setPeriodName(String value) { this.periodName = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }

    @JsonProperty("year")
    public String getYear() { return year; }
    @JsonProperty("year")
    public void setYear(String value) { this.year = value; }
}
