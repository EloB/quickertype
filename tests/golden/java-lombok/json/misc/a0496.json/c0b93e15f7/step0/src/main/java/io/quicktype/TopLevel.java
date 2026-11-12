package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

public class TopLevel {
    private String code;
    private List<String> columnNames;
    private List<List<Datum>> data;
    private String description;
    private String displayURL;
    private Errors errors;
    private String frequency;
    private LocalDate fromDate;
    private long id;
    private String name;
    private boolean premium;
    private String sourceCode;
    private String sourceName;
    private LocalDate toDate;
    private String type;
    private OffsetDateTime updatedAt;
    private String urlizeName;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("column_names")
    public List<String> getColumnNames() { return columnNames; }
    @JsonProperty("column_names")
    public void setColumnNames(List<String> value) { this.columnNames = value; }

    @JsonProperty("data")
    public List<List<Datum>> getData() { return data; }
    @JsonProperty("data")
    public void setData(List<List<Datum>> value) { this.data = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("display_url")
    public String getDisplayURL() { return displayURL; }
    @JsonProperty("display_url")
    public void setDisplayURL(String value) { this.displayURL = value; }

    @JsonProperty("errors")
    public Errors getErrors() { return errors; }
    @JsonProperty("errors")
    public void setErrors(Errors value) { this.errors = value; }

    @JsonProperty("frequency")
    public String getFrequency() { return frequency; }
    @JsonProperty("frequency")
    public void setFrequency(String value) { this.frequency = value; }

    @JsonProperty("from_date")
    public LocalDate getFromDate() { return fromDate; }
    @JsonProperty("from_date")
    public void setFromDate(LocalDate value) { this.fromDate = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("premium")
    public boolean getPremium() { return premium; }
    @JsonProperty("premium")
    public void setPremium(boolean value) { this.premium = value; }

    @JsonProperty("source_code")
    public String getSourceCode() { return sourceCode; }
    @JsonProperty("source_code")
    public void setSourceCode(String value) { this.sourceCode = value; }

    @JsonProperty("source_name")
    public String getSourceName() { return sourceName; }
    @JsonProperty("source_name")
    public void setSourceName(String value) { this.sourceName = value; }

    @JsonProperty("to_date")
    public LocalDate getToDate() { return toDate; }
    @JsonProperty("to_date")
    public void setToDate(LocalDate value) { this.toDate = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("urlize_name")
    public String getUrlizeName() { return urlizeName; }
    @JsonProperty("urlize_name")
    public void setUrlizeName(String value) { this.urlizeName = value; }
}
