package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class Result {
    private String acronym;
    private String activityConsultCommittees;
    private String activityEuLegislative;
    private String activityExpertGroups;
    private String activityHighLevelGroups;
    private String activityIndustryForums;
    private String activityInterGroups;
    private String activityOther;
    private String activityRelevantComm;
    private String beOfficeCountry;
    private Double beOfficeLat;
    private Double beOfficeLon;
    private String beOfficePhone;
    private String beOfficePostCode;
    private String beOfficePostbox;
    private String beOfficeStreet;
    private String beOfficeTown;
    private String codeOfConduct;
    private long contactCountry;
    private OffsetDateTime createdAt;
    private String entity;
    private String goals;
    private String head;
    private String headOfficeCountry;
    private Double headOfficeLat;
    private Double headOfficeLon;
    private String headOfficePhone;
    private String headOfficePostCode;
    private String headOfficePostbox;
    private String headOfficeStreet;
    private String headOfficeTown;
    private String id;
    private String identificationCode;
    private String infoMembers;
    private OffsetDateTime lastUpdateDate;
    private String legal;
    private String legalStatus;
    private long mainCategory;
    private String mainCategoryTitle;
    private long members;
    private Long members100;
    private Long members25;
    private Long members50;
    private Long members75;
    private double membersFte;
    private String name;
    private Object nativeName;
    private String networking;
    private Long numberOfNaturalPersons;
    private String otherCodeOfConduct;
    private OffsetDateTime registrationDate;
    private Status status;
    private String structureMembers;
    private long subCategory;
    private String subCategoryTitle;
    private OffsetDateTime updatedAt;
    private String uri;
    private String webSiteURL;

    @JsonProperty("acronym")
    public String getAcronym() { return acronym; }
    @JsonProperty("acronym")
    public void setAcronym(String value) { this.acronym = value; }

    @JsonProperty("activity_consult_committees")
    public String getActivityConsultCommittees() { return activityConsultCommittees; }
    @JsonProperty("activity_consult_committees")
    public void setActivityConsultCommittees(String value) { this.activityConsultCommittees = value; }

    @JsonProperty("activity_eu_legislative")
    public String getActivityEuLegislative() { return activityEuLegislative; }
    @JsonProperty("activity_eu_legislative")
    public void setActivityEuLegislative(String value) { this.activityEuLegislative = value; }

    @JsonProperty("activity_expert_groups")
    public String getActivityExpertGroups() { return activityExpertGroups; }
    @JsonProperty("activity_expert_groups")
    public void setActivityExpertGroups(String value) { this.activityExpertGroups = value; }

    @JsonProperty("activity_high_level_groups")
    public String getActivityHighLevelGroups() { return activityHighLevelGroups; }
    @JsonProperty("activity_high_level_groups")
    public void setActivityHighLevelGroups(String value) { this.activityHighLevelGroups = value; }

    @JsonProperty("activity_industry_forums")
    public String getActivityIndustryForums() { return activityIndustryForums; }
    @JsonProperty("activity_industry_forums")
    public void setActivityIndustryForums(String value) { this.activityIndustryForums = value; }

    @JsonProperty("activity_inter_groups")
    public String getActivityInterGroups() { return activityInterGroups; }
    @JsonProperty("activity_inter_groups")
    public void setActivityInterGroups(String value) { this.activityInterGroups = value; }

    @JsonProperty("activity_other")
    public String getActivityOther() { return activityOther; }
    @JsonProperty("activity_other")
    public void setActivityOther(String value) { this.activityOther = value; }

    @JsonProperty("activity_relevant_comm")
    public String getActivityRelevantComm() { return activityRelevantComm; }
    @JsonProperty("activity_relevant_comm")
    public void setActivityRelevantComm(String value) { this.activityRelevantComm = value; }

    @JsonProperty("be_office_country")
    public String getBeOfficeCountry() { return beOfficeCountry; }
    @JsonProperty("be_office_country")
    public void setBeOfficeCountry(String value) { this.beOfficeCountry = value; }

    @JsonProperty("be_office_lat")
    public Double getBeOfficeLat() { return beOfficeLat; }
    @JsonProperty("be_office_lat")
    public void setBeOfficeLat(Double value) { this.beOfficeLat = value; }

    @JsonProperty("be_office_lon")
    public Double getBeOfficeLon() { return beOfficeLon; }
    @JsonProperty("be_office_lon")
    public void setBeOfficeLon(Double value) { this.beOfficeLon = value; }

    @JsonProperty("be_office_phone")
    public String getBeOfficePhone() { return beOfficePhone; }
    @JsonProperty("be_office_phone")
    public void setBeOfficePhone(String value) { this.beOfficePhone = value; }

    @JsonProperty("be_office_post_code")
    public String getBeOfficePostCode() { return beOfficePostCode; }
    @JsonProperty("be_office_post_code")
    public void setBeOfficePostCode(String value) { this.beOfficePostCode = value; }

    @JsonProperty("be_office_postbox")
    public String getBeOfficePostbox() { return beOfficePostbox; }
    @JsonProperty("be_office_postbox")
    public void setBeOfficePostbox(String value) { this.beOfficePostbox = value; }

    @JsonProperty("be_office_street")
    public String getBeOfficeStreet() { return beOfficeStreet; }
    @JsonProperty("be_office_street")
    public void setBeOfficeStreet(String value) { this.beOfficeStreet = value; }

    @JsonProperty("be_office_town")
    public String getBeOfficeTown() { return beOfficeTown; }
    @JsonProperty("be_office_town")
    public void setBeOfficeTown(String value) { this.beOfficeTown = value; }

    @JsonProperty("code_of_conduct")
    public String getCodeOfConduct() { return codeOfConduct; }
    @JsonProperty("code_of_conduct")
    public void setCodeOfConduct(String value) { this.codeOfConduct = value; }

    @JsonProperty("contact_country")
    public long getContactCountry() { return contactCountry; }
    @JsonProperty("contact_country")
    public void setContactCountry(long value) { this.contactCountry = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("entity")
    public String getEntity() { return entity; }
    @JsonProperty("entity")
    public void setEntity(String value) { this.entity = value; }

    @JsonProperty("goals")
    public String getGoals() { return goals; }
    @JsonProperty("goals")
    public void setGoals(String value) { this.goals = value; }

    @JsonProperty("head")
    public String getHead() { return head; }
    @JsonProperty("head")
    public void setHead(String value) { this.head = value; }

    @JsonProperty("head_office_country")
    public String getHeadOfficeCountry() { return headOfficeCountry; }
    @JsonProperty("head_office_country")
    public void setHeadOfficeCountry(String value) { this.headOfficeCountry = value; }

    @JsonProperty("head_office_lat")
    public Double getHeadOfficeLat() { return headOfficeLat; }
    @JsonProperty("head_office_lat")
    public void setHeadOfficeLat(Double value) { this.headOfficeLat = value; }

    @JsonProperty("head_office_lon")
    public Double getHeadOfficeLon() { return headOfficeLon; }
    @JsonProperty("head_office_lon")
    public void setHeadOfficeLon(Double value) { this.headOfficeLon = value; }

    @JsonProperty("head_office_phone")
    public String getHeadOfficePhone() { return headOfficePhone; }
    @JsonProperty("head_office_phone")
    public void setHeadOfficePhone(String value) { this.headOfficePhone = value; }

    @JsonProperty("head_office_post_code")
    public String getHeadOfficePostCode() { return headOfficePostCode; }
    @JsonProperty("head_office_post_code")
    public void setHeadOfficePostCode(String value) { this.headOfficePostCode = value; }

    @JsonProperty("head_office_postbox")
    public String getHeadOfficePostbox() { return headOfficePostbox; }
    @JsonProperty("head_office_postbox")
    public void setHeadOfficePostbox(String value) { this.headOfficePostbox = value; }

    @JsonProperty("head_office_street")
    public String getHeadOfficeStreet() { return headOfficeStreet; }
    @JsonProperty("head_office_street")
    public void setHeadOfficeStreet(String value) { this.headOfficeStreet = value; }

    @JsonProperty("head_office_town")
    public String getHeadOfficeTown() { return headOfficeTown; }
    @JsonProperty("head_office_town")
    public void setHeadOfficeTown(String value) { this.headOfficeTown = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("identification_code")
    public String getIdentificationCode() { return identificationCode; }
    @JsonProperty("identification_code")
    public void setIdentificationCode(String value) { this.identificationCode = value; }

    @JsonProperty("info_members")
    public String getInfoMembers() { return infoMembers; }
    @JsonProperty("info_members")
    public void setInfoMembers(String value) { this.infoMembers = value; }

    @JsonProperty("last_update_date")
    public OffsetDateTime getLastUpdateDate() { return lastUpdateDate; }
    @JsonProperty("last_update_date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setLastUpdateDate(OffsetDateTime value) { this.lastUpdateDate = value; }

    @JsonProperty("legal")
    public String getLegal() { return legal; }
    @JsonProperty("legal")
    public void setLegal(String value) { this.legal = value; }

    @JsonProperty("legal_status")
    public String getLegalStatus() { return legalStatus; }
    @JsonProperty("legal_status")
    public void setLegalStatus(String value) { this.legalStatus = value; }

    @JsonProperty("main_category")
    public long getMainCategory() { return mainCategory; }
    @JsonProperty("main_category")
    public void setMainCategory(long value) { this.mainCategory = value; }

    @JsonProperty("main_category_title")
    public String getMainCategoryTitle() { return mainCategoryTitle; }
    @JsonProperty("main_category_title")
    public void setMainCategoryTitle(String value) { this.mainCategoryTitle = value; }

    @JsonProperty("members")
    public long getMembers() { return members; }
    @JsonProperty("members")
    public void setMembers(long value) { this.members = value; }

    @JsonProperty("members_100")
    public Long getMembers100() { return members100; }
    @JsonProperty("members_100")
    public void setMembers100(Long value) { this.members100 = value; }

    @JsonProperty("members_25")
    public Long getMembers25() { return members25; }
    @JsonProperty("members_25")
    public void setMembers25(Long value) { this.members25 = value; }

    @JsonProperty("members_50")
    public Long getMembers50() { return members50; }
    @JsonProperty("members_50")
    public void setMembers50(Long value) { this.members50 = value; }

    @JsonProperty("members_75")
    public Long getMembers75() { return members75; }
    @JsonProperty("members_75")
    public void setMembers75(Long value) { this.members75 = value; }

    @JsonProperty("members_fte")
    public double getMembersFte() { return membersFte; }
    @JsonProperty("members_fte")
    public void setMembersFte(double value) { this.membersFte = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("native_name")
    public Object getNativeName() { return nativeName; }
    @JsonProperty("native_name")
    public void setNativeName(Object value) { this.nativeName = value; }

    @JsonProperty("networking")
    public String getNetworking() { return networking; }
    @JsonProperty("networking")
    public void setNetworking(String value) { this.networking = value; }

    @JsonProperty("number_of_natural_persons")
    public Long getNumberOfNaturalPersons() { return numberOfNaturalPersons; }
    @JsonProperty("number_of_natural_persons")
    public void setNumberOfNaturalPersons(Long value) { this.numberOfNaturalPersons = value; }

    @JsonProperty("other_code_of_conduct")
    public String getOtherCodeOfConduct() { return otherCodeOfConduct; }
    @JsonProperty("other_code_of_conduct")
    public void setOtherCodeOfConduct(String value) { this.otherCodeOfConduct = value; }

    @JsonProperty("registration_date")
    public OffsetDateTime getRegistrationDate() { return registrationDate; }
    @JsonProperty("registration_date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setRegistrationDate(OffsetDateTime value) { this.registrationDate = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("structure_members")
    public String getStructureMembers() { return structureMembers; }
    @JsonProperty("structure_members")
    public void setStructureMembers(String value) { this.structureMembers = value; }

    @JsonProperty("sub_category")
    public long getSubCategory() { return subCategory; }
    @JsonProperty("sub_category")
    public void setSubCategory(long value) { this.subCategory = value; }

    @JsonProperty("sub_category_title")
    public String getSubCategoryTitle() { return subCategoryTitle; }
    @JsonProperty("sub_category_title")
    public void setSubCategoryTitle(String value) { this.subCategoryTitle = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("uri")
    public String getURI() { return uri; }
    @JsonProperty("uri")
    public void setURI(String value) { this.uri = value; }

    @JsonProperty("web_site_url")
    public String getWebSiteURL() { return webSiteURL; }
    @JsonProperty("web_site_url")
    public void setWebSiteURL(String value) { this.webSiteURL = value; }
}
