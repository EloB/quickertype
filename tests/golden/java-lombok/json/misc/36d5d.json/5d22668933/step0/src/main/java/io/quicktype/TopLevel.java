package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String city;
    private String delay;
    private String iata;
    private String icao;
    private String name;
    private String state;
    private Status status;
    private Weather weather;

    @JsonProperty("city")
    public String getCity() { return city; }
    @JsonProperty("city")
    public void setCity(String value) { this.city = value; }

    @JsonProperty("delay")
    public String getDelay() { return delay; }
    @JsonProperty("delay")
    public void setDelay(String value) { this.delay = value; }

    @JsonProperty("IATA")
    public String getIata() { return iata; }
    @JsonProperty("IATA")
    public void setIata(String value) { this.iata = value; }

    @JsonProperty("ICAO")
    public String getIcao() { return icao; }
    @JsonProperty("ICAO")
    public void setIcao(String value) { this.icao = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("state")
    public String getState() { return state; }
    @JsonProperty("state")
    public void setState(String value) { this.state = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("weather")
    public Weather getWeather() { return weather; }
    @JsonProperty("weather")
    public void setWeather(Weather value) { this.weather = value; }
}
