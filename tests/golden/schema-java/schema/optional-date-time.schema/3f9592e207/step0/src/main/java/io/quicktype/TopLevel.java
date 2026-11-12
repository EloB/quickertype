package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.OffsetTime;

public class TopLevel {
    private LocalDate optionalDate;
    private OffsetDateTime optionalDateTime;
    private OffsetTime optionalTime;
    private LocalDate requiredDate;
    private OffsetDateTime requiredDateTime;
    private OffsetTime requiredTime;

    @JsonProperty("optional-date")
    public LocalDate getOptionalDate() { return optionalDate; }
    @JsonProperty("optional-date")
    public void setOptionalDate(LocalDate value) { this.optionalDate = value; }

    @JsonProperty("optional-date-time")
    public OffsetDateTime getOptionalDateTime() { return optionalDateTime; }
    @JsonProperty("optional-date-time")
    public void setOptionalDateTime(OffsetDateTime value) { this.optionalDateTime = value; }

    @JsonProperty("optional-time")
    public OffsetTime getOptionalTime() { return optionalTime; }
    @JsonProperty("optional-time")
    public void setOptionalTime(OffsetTime value) { this.optionalTime = value; }

    @JsonProperty("required-date")
    public LocalDate getRequiredDate() { return requiredDate; }
    @JsonProperty("required-date")
    public void setRequiredDate(LocalDate value) { this.requiredDate = value; }

    @JsonProperty("required-date-time")
    public OffsetDateTime getRequiredDateTime() { return requiredDateTime; }
    @JsonProperty("required-date-time")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setRequiredDateTime(OffsetDateTime value) { this.requiredDateTime = value; }

    @JsonProperty("required-time")
    public OffsetTime getRequiredTime() { return requiredTime; }
    @JsonProperty("required-time")
    public void setRequiredTime(OffsetTime value) { this.requiredTime = value; }
}
