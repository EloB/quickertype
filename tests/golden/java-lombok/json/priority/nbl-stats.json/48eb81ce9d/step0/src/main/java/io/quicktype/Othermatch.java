package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Othermatch {
    private String clock;
    private String competitionName;
    private String id;
    private long period;
    private PerType periodType;
    private Team team1;
    private String team1Name;
    private long team1Score;
    private Team team2;
    private String team2Name;
    private long team2Score;

    @JsonProperty("clock")
    public String getClock() { return clock; }
    @JsonProperty("clock")
    public void setClock(String value) { this.clock = value; }

    @JsonProperty("competitionName")
    public String getCompetitionName() { return competitionName; }
    @JsonProperty("competitionName")
    public void setCompetitionName(String value) { this.competitionName = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("period")
    public long getPeriod() { return period; }
    @JsonProperty("period")
    public void setPeriod(long value) { this.period = value; }

    @JsonProperty("periodType")
    public PerType getPeriodType() { return periodType; }
    @JsonProperty("periodType")
    public void setPeriodType(PerType value) { this.periodType = value; }

    @JsonProperty("team1")
    public Team getTeam1() { return team1; }
    @JsonProperty("team1")
    public void setTeam1(Team value) { this.team1 = value; }

    @JsonProperty("team1Name")
    public String getTeam1Name() { return team1Name; }
    @JsonProperty("team1Name")
    public void setTeam1Name(String value) { this.team1Name = value; }

    @JsonProperty("team1Score")
    public long getTeam1Score() { return team1Score; }
    @JsonProperty("team1Score")
    public void setTeam1Score(long value) { this.team1Score = value; }

    @JsonProperty("team2")
    public Team getTeam2() { return team2; }
    @JsonProperty("team2")
    public void setTeam2(Team value) { this.team2 = value; }

    @JsonProperty("team2Name")
    public String getTeam2Name() { return team2Name; }
    @JsonProperty("team2Name")
    public void setTeam2Name(String value) { this.team2Name = value; }

    @JsonProperty("team2Score")
    public long getTeam2Score() { return team2Score; }
    @JsonProperty("team2Score")
    public void setTeam2Score(long value) { this.team2Score = value; }
}
