package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class DateTime {
    private Date dateTime;

    @JsonProperty("DateTime")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getDateTime() { return dateTime; }
    @JsonProperty("DateTime")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setDateTime(Date value) { this.dateTime = value; }
}
