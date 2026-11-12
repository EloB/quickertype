package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Weather {
    private Meta meta;
    private String temp;
    private double visibility;
    private String weather;
    private String wind;

    @JsonProperty("meta")
    public Meta getMeta() { return meta; }
    @JsonProperty("meta")
    public void setMeta(Meta value) { this.meta = value; }

    @JsonProperty("temp")
    public String getTemp() { return temp; }
    @JsonProperty("temp")
    public void setTemp(String value) { this.temp = value; }

    @JsonProperty("visibility")
    public double getVisibility() { return visibility; }
    @JsonProperty("visibility")
    public void setVisibility(double value) { this.visibility = value; }

    @JsonProperty("weather")
    public String getWeather() { return weather; }
    @JsonProperty("weather")
    public void setWeather(String value) { this.weather = value; }

    @JsonProperty("wind")
    public String getWind() { return wind; }
    @JsonProperty("wind")
    public void setWind(String value) { this.wind = value; }
}
