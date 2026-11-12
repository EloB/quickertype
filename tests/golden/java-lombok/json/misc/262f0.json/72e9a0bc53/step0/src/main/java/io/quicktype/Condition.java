package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Condition {
    private String code;
    private String date;
    private String temp;
    private Text text;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("temp")
    public String getTemp() { return temp; }
    @JsonProperty("temp")
    public void setTemp(String value) { this.temp = value; }

    @JsonProperty("text")
    public Text getText() { return text; }
    @JsonProperty("text")
    public void setText(Text value) { this.text = value; }
}
