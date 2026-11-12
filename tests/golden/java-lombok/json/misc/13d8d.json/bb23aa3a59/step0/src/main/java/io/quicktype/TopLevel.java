package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String category;
    private String context;
    private long id;
    private Location location;
    private String locationSubtype;
    private String locationType;
    private String month;
    private OutcomeStatus outcomeStatus;
    private String persistentID;

    @JsonProperty("category")
    public String getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(String value) { this.category = value; }

    @JsonProperty("context")
    public String getContext() { return context; }
    @JsonProperty("context")
    public void setContext(String value) { this.context = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("location")
    public Location getLocation() { return location; }
    @JsonProperty("location")
    public void setLocation(Location value) { this.location = value; }

    @JsonProperty("location_subtype")
    public String getLocationSubtype() { return locationSubtype; }
    @JsonProperty("location_subtype")
    public void setLocationSubtype(String value) { this.locationSubtype = value; }

    @JsonProperty("location_type")
    public String getLocationType() { return locationType; }
    @JsonProperty("location_type")
    public void setLocationType(String value) { this.locationType = value; }

    @JsonProperty("month")
    public String getMonth() { return month; }
    @JsonProperty("month")
    public void setMonth(String value) { this.month = value; }

    @JsonProperty("outcome_status")
    public OutcomeStatus getOutcomeStatus() { return outcomeStatus; }
    @JsonProperty("outcome_status")
    public void setOutcomeStatus(OutcomeStatus value) { this.outcomeStatus = value; }

    @JsonProperty("persistent_id")
    public String getPersistentID() { return persistentID; }
    @JsonProperty("persistent_id")
    public void setPersistentID(String value) { this.persistentID = value; }
}
