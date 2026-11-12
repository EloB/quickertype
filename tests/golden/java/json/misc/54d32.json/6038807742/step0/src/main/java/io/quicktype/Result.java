package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class Result {
    private OffsetDateTime createdAt;
    private String id;
    private String personID;
    private String representativeID;
    private Status status;
    private OffsetDateTime updatedAt;

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("person_id")
    public String getPersonID() { return personID; }
    @JsonProperty("person_id")
    public void setPersonID(String value) { this.personID = value; }

    @JsonProperty("representative_id")
    public String getRepresentativeID() { return representativeID; }
    @JsonProperty("representative_id")
    public void setRepresentativeID(String value) { this.representativeID = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }
}
