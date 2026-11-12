package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Laureate {
    private String firstname;
    private String id;
    private String motivation;
    private String share;
    private String surname;

    @JsonProperty("firstname")
    public String getFirstname() { return firstname; }
    @JsonProperty("firstname")
    public void setFirstname(String value) { this.firstname = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("motivation")
    public String getMotivation() { return motivation; }
    @JsonProperty("motivation")
    public void setMotivation(String value) { this.motivation = value; }

    @JsonProperty("share")
    public String getShare() { return share; }
    @JsonProperty("share")
    public void setShare(String value) { this.share = value; }

    @JsonProperty("surname")
    public String getSurname() { return surname; }
    @JsonProperty("surname")
    public void setSurname(String value) { this.surname = value; }
}
