package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.util.List;

public class ObjectElement {
    private Party caucus;
    private List<Long> congressNumbers;
    private boolean current;
    private String description;
    private Object district;
    private LocalDate enddate;
    private Extra extra;
    private String leadershipTitle;
    private Party party;
    private Person person;
    private String phone;
    private RoleType roleType;
    private RoleTypeLabel roleTypeLabel;
    private SenatorClass senatorClass;
    private SenatorClassLabel senatorClassLabel;
    private SenatorRank senatorRank;
    private SenatorRankLabel senatorRankLabel;
    private LocalDate startdate;
    private String state;
    private Title title;
    private RoleTypeLabel titleLong;
    private String website;

    @JsonProperty("caucus")
    public Party getCaucus() { return caucus; }
    @JsonProperty("caucus")
    public void setCaucus(Party value) { this.caucus = value; }

    @JsonProperty("congress_numbers")
    public List<Long> getCongressNumbers() { return congressNumbers; }
    @JsonProperty("congress_numbers")
    public void setCongressNumbers(List<Long> value) { this.congressNumbers = value; }

    @JsonProperty("current")
    public boolean getCurrent() { return current; }
    @JsonProperty("current")
    public void setCurrent(boolean value) { this.current = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("district")
    public Object getDistrict() { return district; }
    @JsonProperty("district")
    public void setDistrict(Object value) { this.district = value; }

    @JsonProperty("enddate")
    public LocalDate getEnddate() { return enddate; }
    @JsonProperty("enddate")
    public void setEnddate(LocalDate value) { this.enddate = value; }

    @JsonProperty("extra")
    public Extra getExtra() { return extra; }
    @JsonProperty("extra")
    public void setExtra(Extra value) { this.extra = value; }

    @JsonProperty("leadership_title")
    public String getLeadershipTitle() { return leadershipTitle; }
    @JsonProperty("leadership_title")
    public void setLeadershipTitle(String value) { this.leadershipTitle = value; }

    @JsonProperty("party")
    public Party getParty() { return party; }
    @JsonProperty("party")
    public void setParty(Party value) { this.party = value; }

    @JsonProperty("person")
    public Person getPerson() { return person; }
    @JsonProperty("person")
    public void setPerson(Person value) { this.person = value; }

    @JsonProperty("phone")
    public String getPhone() { return phone; }
    @JsonProperty("phone")
    public void setPhone(String value) { this.phone = value; }

    @JsonProperty("role_type")
    public RoleType getRoleType() { return roleType; }
    @JsonProperty("role_type")
    public void setRoleType(RoleType value) { this.roleType = value; }

    @JsonProperty("role_type_label")
    public RoleTypeLabel getRoleTypeLabel() { return roleTypeLabel; }
    @JsonProperty("role_type_label")
    public void setRoleTypeLabel(RoleTypeLabel value) { this.roleTypeLabel = value; }

    @JsonProperty("senator_class")
    public SenatorClass getSenatorClass() { return senatorClass; }
    @JsonProperty("senator_class")
    public void setSenatorClass(SenatorClass value) { this.senatorClass = value; }

    @JsonProperty("senator_class_label")
    public SenatorClassLabel getSenatorClassLabel() { return senatorClassLabel; }
    @JsonProperty("senator_class_label")
    public void setSenatorClassLabel(SenatorClassLabel value) { this.senatorClassLabel = value; }

    @JsonProperty("senator_rank")
    public SenatorRank getSenatorRank() { return senatorRank; }
    @JsonProperty("senator_rank")
    public void setSenatorRank(SenatorRank value) { this.senatorRank = value; }

    @JsonProperty("senator_rank_label")
    public SenatorRankLabel getSenatorRankLabel() { return senatorRankLabel; }
    @JsonProperty("senator_rank_label")
    public void setSenatorRankLabel(SenatorRankLabel value) { this.senatorRankLabel = value; }

    @JsonProperty("startdate")
    public LocalDate getStartdate() { return startdate; }
    @JsonProperty("startdate")
    public void setStartdate(LocalDate value) { this.startdate = value; }

    @JsonProperty("state")
    public String getState() { return state; }
    @JsonProperty("state")
    public void setState(String value) { this.state = value; }

    @JsonProperty("title")
    public Title getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(Title value) { this.title = value; }

    @JsonProperty("title_long")
    public RoleTypeLabel getTitleLong() { return titleLong; }
    @JsonProperty("title_long")
    public void setTitleLong(RoleTypeLabel value) { this.titleLong = value; }

    @JsonProperty("website")
    public String getWebsite() { return website; }
    @JsonProperty("website")
    public void setWebsite(String value) { this.website = value; }
}
