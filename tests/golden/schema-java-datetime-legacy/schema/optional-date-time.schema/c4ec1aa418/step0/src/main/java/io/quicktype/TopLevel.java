package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class TopLevel {
    private Date optionalDate;
    private Date optionalDateTime;
    private Date optionalTime;
    private Date requiredDate;
    private Date requiredDateTime;
    private Date requiredTime;

    @JsonProperty("optional-date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getOptionalDate() { return optionalDate; }
    @JsonProperty("optional-date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public void setOptionalDate(Date value) { this.optionalDate = value; }

    @JsonProperty("optional-date-time")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getOptionalDateTime() { return optionalDateTime; }
    @JsonProperty("optional-date-time")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setOptionalDateTime(Date value) { this.optionalDateTime = value; }

    @JsonProperty("optional-time")
    @JsonFormat(pattern = "HH:mm:ssX", timezone = "UTC")
    public Date getOptionalTime() { return optionalTime; }
    @JsonProperty("optional-time")
    @JsonFormat(pattern = "HH:mm:ssX", timezone = "UTC")
    public void setOptionalTime(Date value) { this.optionalTime = value; }

    @JsonProperty("required-date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getRequiredDate() { return requiredDate; }
    @JsonProperty("required-date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public void setRequiredDate(Date value) { this.requiredDate = value; }

    @JsonProperty("required-date-time")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getRequiredDateTime() { return requiredDateTime; }
    @JsonProperty("required-date-time")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setRequiredDateTime(Date value) { this.requiredDateTime = value; }

    @JsonProperty("required-time")
    @JsonFormat(pattern = "HH:mm:ssX", timezone = "UTC")
    public Date getRequiredTime() { return requiredTime; }
    @JsonProperty("required-time")
    @JsonFormat(pattern = "HH:mm:ssX", timezone = "UTC")
    public void setRequiredTime(Date value) { this.requiredTime = value; }
}
