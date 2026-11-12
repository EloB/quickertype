package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private OffsetDateTime birthDate;
    private boolean birthDateIsProtected;
    private long genderTypeID;
    private String notes;
    private String parliamentaryName;
    private long personID;
    private String photoURL;
    private String preferredName;

    @JsonProperty("BirthDate")
    public OffsetDateTime getBirthDate() { return birthDate; }
    @JsonProperty("BirthDate")
    public void setBirthDate(OffsetDateTime value) { this.birthDate = value; }

    @JsonProperty("BirthDateIsProtected")
    public boolean getBirthDateIsProtected() { return birthDateIsProtected; }
    @JsonProperty("BirthDateIsProtected")
    public void setBirthDateIsProtected(boolean value) { this.birthDateIsProtected = value; }

    @JsonProperty("GenderTypeID")
    public long getGenderTypeID() { return genderTypeID; }
    @JsonProperty("GenderTypeID")
    public void setGenderTypeID(long value) { this.genderTypeID = value; }

    @JsonProperty("Notes")
    public String getNotes() { return notes; }
    @JsonProperty("Notes")
    public void setNotes(String value) { this.notes = value; }

    @JsonProperty("ParliamentaryName")
    public String getParliamentaryName() { return parliamentaryName; }
    @JsonProperty("ParliamentaryName")
    public void setParliamentaryName(String value) { this.parliamentaryName = value; }

    @JsonProperty("PersonID")
    public long getPersonID() { return personID; }
    @JsonProperty("PersonID")
    public void setPersonID(long value) { this.personID = value; }

    @JsonProperty("PhotoURL")
    public String getPhotoURL() { return photoURL; }
    @JsonProperty("PhotoURL")
    public void setPhotoURL(String value) { this.photoURL = value; }

    @JsonProperty("PreferredName")
    public String getPreferredName() { return preferredName; }
    @JsonProperty("PreferredName")
    public void setPreferredName(String value) { this.preferredName = value; }
}
