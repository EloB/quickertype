package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Scorer {
    private String familyName;
    private FamilyNameInitial familyNameInitial;
    private String firstName;
    private FirstNameInitial firstNameInitial;
    private String gt;
    private String internationalFamilyName;
    private FamilyNameInitial internationalFamilyNameInitial;
    private String internationalFirstName;
    private FirstNameInitial internationalFirstNameInitial;
    private String name;
    private Long per;
    private PerType perType;
    private String player;
    private long pno;
    private ScoreboardName scoreboardName;
    private String shirtNumber;
    private String summary;
    private List<Time> times;
    private long tno;
    private Long tot;

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

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("per")
    public Long getPer() { return per; }
    @JsonProperty("per")
    public void setPer(Long value) { this.per = value; }

    @JsonProperty("perType")
    public PerType getPerType() { return perType; }
    @JsonProperty("perType")
    public void setPerType(PerType value) { this.perType = value; }

    @JsonProperty("player")
    public String getPlayer() { return player; }
    @JsonProperty("player")
    public void setPlayer(String value) { this.player = value; }

    @JsonProperty("pno")
    public long getPno() { return pno; }
    @JsonProperty("pno")
    public void setPno(long value) { this.pno = value; }

    @JsonProperty("scoreboardName")
    public ScoreboardName getScoreboardName() { return scoreboardName; }
    @JsonProperty("scoreboardName")
    public void setScoreboardName(ScoreboardName value) { this.scoreboardName = value; }

    @JsonProperty("shirtNumber")
    public String getShirtNumber() { return shirtNumber; }
    @JsonProperty("shirtNumber")
    public void setShirtNumber(String value) { this.shirtNumber = value; }

    @JsonProperty("summary")
    public String getSummary() { return summary; }
    @JsonProperty("summary")
    public void setSummary(String value) { this.summary = value; }

    @JsonProperty("times")
    public List<Time> getTimes() { return times; }
    @JsonProperty("times")
    public void setTimes(List<Time> value) { this.times = value; }

    @JsonProperty("tno")
    public long getTno() { return tno; }
    @JsonProperty("tno")
    public void setTno(long value) { this.tno = value; }

    @JsonProperty("tot")
    public Long getTot() { return tot; }
    @JsonProperty("tot")
    public void setTot(Long value) { this.tot = value; }
}
