package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.UUID;

public class Result {
    private String aboutOffice;
    private String applicationProcess;
    private String body;
    private String changed;
    private String created;
    private Object deadline;
    private Object hiringOffice;
    private HiringOrg hiringOrg;
    private Object jobID;
    private String language;
    private Location location;
    private String numPositions;
    private String position;
    private String practiceArea;
    private String qualifications;
    private Object relocationExpenses;
    private String salary;
    private String title;
    private String travel;
    private String url;
    private UUID uuid;
    private UUID vuuid;

    @JsonProperty("about_office")
    public String getAboutOffice() { return aboutOffice; }
    @JsonProperty("about_office")
    public void setAboutOffice(String value) { this.aboutOffice = value; }

    @JsonProperty("application_process")
    public String getApplicationProcess() { return applicationProcess; }
    @JsonProperty("application_process")
    public void setApplicationProcess(String value) { this.applicationProcess = value; }

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }

    @JsonProperty("changed")
    public String getChanged() { return changed; }
    @JsonProperty("changed")
    public void setChanged(String value) { this.changed = value; }

    @JsonProperty("created")
    public String getCreated() { return created; }
    @JsonProperty("created")
    public void setCreated(String value) { this.created = value; }

    @JsonProperty("deadline")
    public Object getDeadline() { return deadline; }
    @JsonProperty("deadline")
    public void setDeadline(Object value) { this.deadline = value; }

    @JsonProperty("hiring_office")
    public Object getHiringOffice() { return hiringOffice; }
    @JsonProperty("hiring_office")
    public void setHiringOffice(Object value) { this.hiringOffice = value; }

    @JsonProperty("hiring_org")
    public HiringOrg getHiringOrg() { return hiringOrg; }
    @JsonProperty("hiring_org")
    public void setHiringOrg(HiringOrg value) { this.hiringOrg = value; }

    @JsonProperty("job_id")
    public Object getJobID() { return jobID; }
    @JsonProperty("job_id")
    public void setJobID(Object value) { this.jobID = value; }

    @JsonProperty("language")
    public String getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(String value) { this.language = value; }

    @JsonProperty("location")
    public Location getLocation() { return location; }
    @JsonProperty("location")
    public void setLocation(Location value) { this.location = value; }

    @JsonProperty("num_positions")
    public String getNumPositions() { return numPositions; }
    @JsonProperty("num_positions")
    public void setNumPositions(String value) { this.numPositions = value; }

    @JsonProperty("position")
    public String getPosition() { return position; }
    @JsonProperty("position")
    public void setPosition(String value) { this.position = value; }

    @JsonProperty("practice_area")
    public String getPracticeArea() { return practiceArea; }
    @JsonProperty("practice_area")
    public void setPracticeArea(String value) { this.practiceArea = value; }

    @JsonProperty("qualifications")
    public String getQualifications() { return qualifications; }
    @JsonProperty("qualifications")
    public void setQualifications(String value) { this.qualifications = value; }

    @JsonProperty("relocation_expenses")
    public Object getRelocationExpenses() { return relocationExpenses; }
    @JsonProperty("relocation_expenses")
    public void setRelocationExpenses(Object value) { this.relocationExpenses = value; }

    @JsonProperty("salary")
    public String getSalary() { return salary; }
    @JsonProperty("salary")
    public void setSalary(String value) { this.salary = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("travel")
    public String getTravel() { return travel; }
    @JsonProperty("travel")
    public void setTravel(String value) { this.travel = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("uuid")
    public UUID getUUID() { return uuid; }
    @JsonProperty("uuid")
    public void setUUID(UUID value) { this.uuid = value; }

    @JsonProperty("vuuid")
    public UUID getVuuid() { return vuuid; }
    @JsonProperty("vuuid")
    public void setVuuid(UUID value) { this.vuuid = value; }
}
