package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;

public class Person {
    private String bioguideid;
    private LocalDate birthday;
    private long cspanid;
    private String firstname;
    private Gender gender;
    private GenderLabel genderLabel;
    private long id;
    private String lastname;
    private String link;
    private String middlename;
    private String name;
    private Namemod namemod;
    private String nickname;
    private String osid;
    private String pvsid;
    private String sortname;
    private String twitterid;
    private String youtubeid;

    @JsonProperty("bioguideid")
    public String getBioguideid() { return bioguideid; }
    @JsonProperty("bioguideid")
    public void setBioguideid(String value) { this.bioguideid = value; }

    @JsonProperty("birthday")
    public LocalDate getBirthday() { return birthday; }
    @JsonProperty("birthday")
    public void setBirthday(LocalDate value) { this.birthday = value; }

    @JsonProperty("cspanid")
    public long getCspanid() { return cspanid; }
    @JsonProperty("cspanid")
    public void setCspanid(long value) { this.cspanid = value; }

    @JsonProperty("firstname")
    public String getFirstname() { return firstname; }
    @JsonProperty("firstname")
    public void setFirstname(String value) { this.firstname = value; }

    @JsonProperty("gender")
    public Gender getGender() { return gender; }
    @JsonProperty("gender")
    public void setGender(Gender value) { this.gender = value; }

    @JsonProperty("gender_label")
    public GenderLabel getGenderLabel() { return genderLabel; }
    @JsonProperty("gender_label")
    public void setGenderLabel(GenderLabel value) { this.genderLabel = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("lastname")
    public String getLastname() { return lastname; }
    @JsonProperty("lastname")
    public void setLastname(String value) { this.lastname = value; }

    @JsonProperty("link")
    public String getLink() { return link; }
    @JsonProperty("link")
    public void setLink(String value) { this.link = value; }

    @JsonProperty("middlename")
    public String getMiddlename() { return middlename; }
    @JsonProperty("middlename")
    public void setMiddlename(String value) { this.middlename = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("namemod")
    public Namemod getNamemod() { return namemod; }
    @JsonProperty("namemod")
    public void setNamemod(Namemod value) { this.namemod = value; }

    @JsonProperty("nickname")
    public String getNickname() { return nickname; }
    @JsonProperty("nickname")
    public void setNickname(String value) { this.nickname = value; }

    @JsonProperty("osid")
    public String getOsid() { return osid; }
    @JsonProperty("osid")
    public void setOsid(String value) { this.osid = value; }

    @JsonProperty("pvsid")
    public String getPvsid() { return pvsid; }
    @JsonProperty("pvsid")
    public void setPvsid(String value) { this.pvsid = value; }

    @JsonProperty("sortname")
    public String getSortname() { return sortname; }
    @JsonProperty("sortname")
    public void setSortname(String value) { this.sortname = value; }

    @JsonProperty("twitterid")
    public String getTwitterid() { return twitterid; }
    @JsonProperty("twitterid")
    public void setTwitterid(String value) { this.twitterid = value; }

    @JsonProperty("youtubeid")
    public String getYoutubeid() { return youtubeid; }
    @JsonProperty("youtubeid")
    public void setYoutubeid(String value) { this.youtubeid = value; }
}
