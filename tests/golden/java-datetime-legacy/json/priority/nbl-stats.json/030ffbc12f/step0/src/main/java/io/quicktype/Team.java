package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Team {
    private String teamCode;
    private String teamCodeInternational;
    private String teamName;
    private String teamNameInternational;

    @JsonProperty("teamCode")
    public String getTeamCode() { return teamCode; }
    @JsonProperty("teamCode")
    public void setTeamCode(String value) { this.teamCode = value; }

    @JsonProperty("teamCodeInternational")
    public String getTeamCodeInternational() { return teamCodeInternational; }
    @JsonProperty("teamCodeInternational")
    public void setTeamCodeInternational(String value) { this.teamCodeInternational = value; }

    @JsonProperty("teamName")
    public String getTeamName() { return teamName; }
    @JsonProperty("teamName")
    public void setTeamName(String value) { this.teamName = value; }

    @JsonProperty("teamNameInternational")
    public String getTeamNameInternational() { return teamNameInternational; }
    @JsonProperty("teamNameInternational")
    public void setTeamNameInternational(String value) { this.teamNameInternational = value; }
}
