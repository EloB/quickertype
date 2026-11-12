package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Forecast {
    private String code;
    private String date;
    private String day;
    private String high;
    private String low;
    private String text;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("day")
    public String getDay() { return day; }
    @JsonProperty("day")
    public void setDay(String value) { this.day = value; }

    @JsonProperty("high")
    public String getHigh() { return high; }
    @JsonProperty("high")
    public void setHigh(String value) { this.high = value; }

    @JsonProperty("low")
    public String getLow() { return low; }
    @JsonProperty("low")
    public void setLow(String value) { this.low = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
