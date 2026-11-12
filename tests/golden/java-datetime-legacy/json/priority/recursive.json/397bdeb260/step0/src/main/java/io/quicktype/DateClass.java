package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateClass {
    private long day;
    private Eonandyear eonandyear;
    private long hour;
    private long millisecond;
    private long minute;
    private long month;
    private long second;
    private long timezone;
    private boolean valid;
    private Xmlschematype xmlschematype;
    private long year;

    @JsonProperty("day")
    public long getDay() { return day; }
    @JsonProperty("day")
    public void setDay(long value) { this.day = value; }

    @JsonProperty("eonandyear")
    public Eonandyear getEonandyear() { return eonandyear; }
    @JsonProperty("eonandyear")
    public void setEonandyear(Eonandyear value) { this.eonandyear = value; }

    @JsonProperty("hour")
    public long getHour() { return hour; }
    @JsonProperty("hour")
    public void setHour(long value) { this.hour = value; }

    @JsonProperty("millisecond")
    public long getMillisecond() { return millisecond; }
    @JsonProperty("millisecond")
    public void setMillisecond(long value) { this.millisecond = value; }

    @JsonProperty("minute")
    public long getMinute() { return minute; }
    @JsonProperty("minute")
    public void setMinute(long value) { this.minute = value; }

    @JsonProperty("month")
    public long getMonth() { return month; }
    @JsonProperty("month")
    public void setMonth(long value) { this.month = value; }

    @JsonProperty("second")
    public long getSecond() { return second; }
    @JsonProperty("second")
    public void setSecond(long value) { this.second = value; }

    @JsonProperty("timezone")
    public long getTimezone() { return timezone; }
    @JsonProperty("timezone")
    public void setTimezone(long value) { this.timezone = value; }

    @JsonProperty("valid")
    public boolean getValid() { return valid; }
    @JsonProperty("valid")
    public void setValid(boolean value) { this.valid = value; }

    @JsonProperty("xmlschematype")
    public Xmlschematype getXmlschematype() { return xmlschematype; }
    @JsonProperty("xmlschematype")
    public void setXmlschematype(Xmlschematype value) { this.xmlschematype = value; }

    @JsonProperty("year")
    public long getYear() { return year; }
    @JsonProperty("year")
    public void setYear(long value) { this.year = value; }
}
