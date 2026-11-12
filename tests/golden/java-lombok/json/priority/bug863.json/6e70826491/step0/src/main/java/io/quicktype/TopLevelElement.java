package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevelElement {
    private long alienlevel;
    private Breed breed;
    private long charDimension;
    private long charInstance;
    private String defenderRankTitle;
    private Firstname firstname;
    private long headid;
    private Lastname lastname;
    private long levelx;
    private String name;
    private String prof;
    private String profTitle;
    private long pvprating;
    private Pvptitle pvptitle;
    private long rank;
    private RankTitle rankTitle;
    private Sex sex;

    @JsonProperty("ALIENLEVEL")
    public long getAlienlevel() { return alienlevel; }
    @JsonProperty("ALIENLEVEL")
    public void setAlienlevel(long value) { this.alienlevel = value; }

    @JsonProperty("BREED")
    public Breed getBreed() { return breed; }
    @JsonProperty("BREED")
    public void setBreed(Breed value) { this.breed = value; }

    @JsonProperty("CHAR_DIMENSION")
    public long getCharDimension() { return charDimension; }
    @JsonProperty("CHAR_DIMENSION")
    public void setCharDimension(long value) { this.charDimension = value; }

    @JsonProperty("CHAR_INSTANCE")
    public long getCharInstance() { return charInstance; }
    @JsonProperty("CHAR_INSTANCE")
    public void setCharInstance(long value) { this.charInstance = value; }

    @JsonProperty("DEFENDER_RANK_TITLE")
    public String getDefenderRankTitle() { return defenderRankTitle; }
    @JsonProperty("DEFENDER_RANK_TITLE")
    public void setDefenderRankTitle(String value) { this.defenderRankTitle = value; }

    @JsonProperty("FIRSTNAME")
    public Firstname getFirstname() { return firstname; }
    @JsonProperty("FIRSTNAME")
    public void setFirstname(Firstname value) { this.firstname = value; }

    @JsonProperty("HEADID")
    public long getHeadid() { return headid; }
    @JsonProperty("HEADID")
    public void setHeadid(long value) { this.headid = value; }

    @JsonProperty("LASTNAME")
    public Lastname getLastname() { return lastname; }
    @JsonProperty("LASTNAME")
    public void setLastname(Lastname value) { this.lastname = value; }

    @JsonProperty("LEVELX")
    public long getLevelx() { return levelx; }
    @JsonProperty("LEVELX")
    public void setLevelx(long value) { this.levelx = value; }

    @JsonProperty("NAME")
    public String getName() { return name; }
    @JsonProperty("NAME")
    public void setName(String value) { this.name = value; }

    @JsonProperty("PROF")
    public String getProf() { return prof; }
    @JsonProperty("PROF")
    public void setProf(String value) { this.prof = value; }

    @JsonProperty("PROF_TITLE")
    public String getProfTitle() { return profTitle; }
    @JsonProperty("PROF_TITLE")
    public void setProfTitle(String value) { this.profTitle = value; }

    @JsonProperty("PVPRATING")
    public long getPvprating() { return pvprating; }
    @JsonProperty("PVPRATING")
    public void setPvprating(long value) { this.pvprating = value; }

    @JsonProperty("PVPTITLE")
    public Pvptitle getPvptitle() { return pvptitle; }
    @JsonProperty("PVPTITLE")
    public void setPvptitle(Pvptitle value) { this.pvptitle = value; }

    @JsonProperty("RANK")
    public long getRank() { return rank; }
    @JsonProperty("RANK")
    public void setRank(long value) { this.rank = value; }

    @JsonProperty("RANK_TITLE")
    public RankTitle getRankTitle() { return rankTitle; }
    @JsonProperty("RANK_TITLE")
    public void setRankTitle(RankTitle value) { this.rankTitle = value; }

    @JsonProperty("SEX")
    public Sex getSex() { return sex; }
    @JsonProperty("SEX")
    public void setSex(Sex value) { this.sex = value; }
}
