package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class TopLevel {
    private long attendance;
    private String clock;
    private long disableMatch;
    private long inOT;
    private List<List<LeaddatumElement>> leaddata;
    private String officialsReferee1;
    private String officialsReferee2;
    private String officialsReferee3;
    private List<Othermatch> othermatches;
    private List<Pbp> pbp;
    private long period;
    private long periodLengthOVERTIME;
    private long periodLengthREGULAR;
    private PerType periodType;
    private long periodsMax;
    private Map<String, List<Scorer>> scorers;
    private List<Object> timeline;
    private Map<String, Tm> tm;
    private long totalTimeAdded;
    private Totallds totallds;

    @JsonProperty("attendance")
    public long getAttendance() { return attendance; }
    @JsonProperty("attendance")
    public void setAttendance(long value) { this.attendance = value; }

    @JsonProperty("clock")
    public String getClock() { return clock; }
    @JsonProperty("clock")
    public void setClock(String value) { this.clock = value; }

    @JsonProperty("disableMatch")
    public long getDisableMatch() { return disableMatch; }
    @JsonProperty("disableMatch")
    public void setDisableMatch(long value) { this.disableMatch = value; }

    @JsonProperty("inOT")
    public long getInOT() { return inOT; }
    @JsonProperty("inOT")
    public void setInOT(long value) { this.inOT = value; }

    @JsonProperty("leaddata")
    public List<List<LeaddatumElement>> getLeaddata() { return leaddata; }
    @JsonProperty("leaddata")
    public void setLeaddata(List<List<LeaddatumElement>> value) { this.leaddata = value; }

    @JsonProperty("officials_referee1")
    public String getOfficialsReferee1() { return officialsReferee1; }
    @JsonProperty("officials_referee1")
    public void setOfficialsReferee1(String value) { this.officialsReferee1 = value; }

    @JsonProperty("officials_referee2")
    public String getOfficialsReferee2() { return officialsReferee2; }
    @JsonProperty("officials_referee2")
    public void setOfficialsReferee2(String value) { this.officialsReferee2 = value; }

    @JsonProperty("officials_referee3")
    public String getOfficialsReferee3() { return officialsReferee3; }
    @JsonProperty("officials_referee3")
    public void setOfficialsReferee3(String value) { this.officialsReferee3 = value; }

    @JsonProperty("othermatches")
    public List<Othermatch> getOthermatches() { return othermatches; }
    @JsonProperty("othermatches")
    public void setOthermatches(List<Othermatch> value) { this.othermatches = value; }

    @JsonProperty("pbp")
    public List<Pbp> getPbp() { return pbp; }
    @JsonProperty("pbp")
    public void setPbp(List<Pbp> value) { this.pbp = value; }

    @JsonProperty("period")
    public long getPeriod() { return period; }
    @JsonProperty("period")
    public void setPeriod(long value) { this.period = value; }

    @JsonProperty("periodLengthOVERTIME")
    public long getPeriodLengthOVERTIME() { return periodLengthOVERTIME; }
    @JsonProperty("periodLengthOVERTIME")
    public void setPeriodLengthOVERTIME(long value) { this.periodLengthOVERTIME = value; }

    @JsonProperty("periodLengthREGULAR")
    public long getPeriodLengthREGULAR() { return periodLengthREGULAR; }
    @JsonProperty("periodLengthREGULAR")
    public void setPeriodLengthREGULAR(long value) { this.periodLengthREGULAR = value; }

    @JsonProperty("periodType")
    public PerType getPeriodType() { return periodType; }
    @JsonProperty("periodType")
    public void setPeriodType(PerType value) { this.periodType = value; }

    @JsonProperty("periodsMax")
    public long getPeriodsMax() { return periodsMax; }
    @JsonProperty("periodsMax")
    public void setPeriodsMax(long value) { this.periodsMax = value; }

    @JsonProperty("scorers")
    public Map<String, List<Scorer>> getScorers() { return scorers; }
    @JsonProperty("scorers")
    public void setScorers(Map<String, List<Scorer>> value) { this.scorers = value; }

    @JsonProperty("timeline")
    public List<Object> getTimeline() { return timeline; }
    @JsonProperty("timeline")
    public void setTimeline(List<Object> value) { this.timeline = value; }

    @JsonProperty("tm")
    public Map<String, Tm> getTm() { return tm; }
    @JsonProperty("tm")
    public void setTm(Map<String, Tm> value) { this.tm = value; }

    @JsonProperty("totalTimeAdded")
    public long getTotalTimeAdded() { return totalTimeAdded; }
    @JsonProperty("totalTimeAdded")
    public void setTotalTimeAdded(long value) { this.totalTimeAdded = value; }

    @JsonProperty("totallds")
    public Totallds getTotallds() { return totallds; }
    @JsonProperty("totallds")
    public void setTotallds(Totallds value) { this.totallds = value; }
}
