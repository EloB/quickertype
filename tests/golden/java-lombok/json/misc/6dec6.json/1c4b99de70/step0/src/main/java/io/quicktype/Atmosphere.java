package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Atmosphere {
    private String humidity;
    private String pressure;
    private String rising;
    private String visibility;

    @JsonProperty("humidity")
    public String getHumidity() { return humidity; }
    @JsonProperty("humidity")
    public void setHumidity(String value) { this.humidity = value; }

    @JsonProperty("pressure")
    public String getPressure() { return pressure; }
    @JsonProperty("pressure")
    public void setPressure(String value) { this.pressure = value; }

    @JsonProperty("rising")
    public String getRising() { return rising; }
    @JsonProperty("rising")
    public void setRising(String value) { this.rising = value; }

    @JsonProperty("visibility")
    public String getVisibility() { return visibility; }
    @JsonProperty("visibility")
    public void setVisibility(String value) { this.visibility = value; }
}
