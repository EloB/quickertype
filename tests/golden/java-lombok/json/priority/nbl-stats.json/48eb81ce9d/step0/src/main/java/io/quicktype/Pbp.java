package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Pbp {
    private ActionType actionType;
    private String familyName;
    private FamilyNameInitial familyNameInitial;
    private String firstName;
    private FirstNameInitial firstNameInitial;
    private String gt;
    private String internationalFamilyName;
    private FamilyNameInitial internationalFamilyNameInitial;
    private String internationalFirstName;
    private FirstNameInitial internationalFirstNameInitial;
    private long lead;
    private long period;
    private PerType periodType;
    private String player;
    private long pno;
    private String qualifier;
    private long s1;
    private long s2;
    private ScoreboardName scoreboardName;
    private long scoring;
    private String shirtNumber;
    private String subType;
    private long success;
    private long tno;

    @JsonProperty("actionType")
    public ActionType getActionType() { return actionType; }
    @JsonProperty("actionType")
    public void setActionType(ActionType value) { this.actionType = value; }

    @JsonProperty("familyName")
    public String getFamilyName() { return familyName; }
    @JsonProperty("familyName")
    public void setFamilyName(String value) { this.familyName = value; }

    @JsonProperty("familyNameInitial")
    public FamilyNameInitial getFamilyNameInitial() { return familyNameInitial; }
    @JsonProperty("familyNameInitial")
    public void setFamilyNameInitial(FamilyNameInitial value) { this.familyNameInitial = value; }

    @JsonProperty("firstName")
    public String getFirstName() { return firstName; }
    @JsonProperty("firstName")
    public void setFirstName(String value) { this.firstName = value; }

    @JsonProperty("firstNameInitial")
    public FirstNameInitial getFirstNameInitial() { return firstNameInitial; }
    @JsonProperty("firstNameInitial")
    public void setFirstNameInitial(FirstNameInitial value) { this.firstNameInitial = value; }

    @JsonProperty("gt")
    public String getGt() { return gt; }
    @JsonProperty("gt")
    public void setGt(String value) { this.gt = value; }

    @JsonProperty("internationalFamilyName")
    public String getInternationalFamilyName() { return internationalFamilyName; }
    @JsonProperty("internationalFamilyName")
    public void setInternationalFamilyName(String value) { this.internationalFamilyName = value; }

    @JsonProperty("internationalFamilyNameInitial")
    public FamilyNameInitial getInternationalFamilyNameInitial() { return internationalFamilyNameInitial; }
    @JsonProperty("internationalFamilyNameInitial")
    public void setInternationalFamilyNameInitial(FamilyNameInitial value) { this.internationalFamilyNameInitial = value; }

    @JsonProperty("internationalFirstName")
    public String getInternationalFirstName() { return internationalFirstName; }
    @JsonProperty("internationalFirstName")
    public void setInternationalFirstName(String value) { this.internationalFirstName = value; }

    @JsonProperty("internationalFirstNameInitial")
    public FirstNameInitial getInternationalFirstNameInitial() { return internationalFirstNameInitial; }
    @JsonProperty("internationalFirstNameInitial")
    public void setInternationalFirstNameInitial(FirstNameInitial value) { this.internationalFirstNameInitial = value; }

    @JsonProperty("lead")
    public long getLead() { return lead; }
    @JsonProperty("lead")
    public void setLead(long value) { this.lead = value; }

    @JsonProperty("period")
    public long getPeriod() { return period; }
    @JsonProperty("period")
    public void setPeriod(long value) { this.period = value; }

    @JsonProperty("periodType")
    public PerType getPeriodType() { return periodType; }
    @JsonProperty("periodType")
    public void setPeriodType(PerType value) { this.periodType = value; }

    @JsonProperty("player")
    public String getPlayer() { return player; }
    @JsonProperty("player")
    public void setPlayer(String value) { this.player = value; }

    @JsonProperty("pno")
    public long getPno() { return pno; }
    @JsonProperty("pno")
    public void setPno(long value) { this.pno = value; }

    @JsonProperty("qualifier")
    public String getQualifier() { return qualifier; }
    @JsonProperty("qualifier")
    public void setQualifier(String value) { this.qualifier = value; }

    @JsonProperty("s1")
    public long getS1() { return s1; }
    @JsonProperty("s1")
    public void setS1(long value) { this.s1 = value; }

    @JsonProperty("s2")
    public long getS2() { return s2; }
    @JsonProperty("s2")
    public void setS2(long value) { this.s2 = value; }

    @JsonProperty("scoreboardName")
    public ScoreboardName getScoreboardName() { return scoreboardName; }
    @JsonProperty("scoreboardName")
    public void setScoreboardName(ScoreboardName value) { this.scoreboardName = value; }

    @JsonProperty("scoring")
    public long getScoring() { return scoring; }
    @JsonProperty("scoring")
    public void setScoring(long value) { this.scoring = value; }

    @JsonProperty("shirtNumber")
    public String getShirtNumber() { return shirtNumber; }
    @JsonProperty("shirtNumber")
    public void setShirtNumber(String value) { this.shirtNumber = value; }

    @JsonProperty("subType")
    public String getSubType() { return subType; }
    @JsonProperty("subType")
    public void setSubType(String value) { this.subType = value; }

    @JsonProperty("success")
    public long getSuccess() { return success; }
    @JsonProperty("success")
    public void setSuccess(long value) { this.success = value; }

    @JsonProperty("tno")
    public long getTno() { return tno; }
    @JsonProperty("tno")
    public void setTno(long value) { this.tno = value; }
}
