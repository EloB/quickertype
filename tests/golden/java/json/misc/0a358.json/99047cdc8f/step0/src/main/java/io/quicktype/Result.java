package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class Result {
    private String code;
    private OffsetDateTime createdAt;
    private long id;
    private String name;
    private OffsetDateTime updatedAt;
    private String uri;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("uri")
    public String getURI() { return uri; }
    @JsonProperty("uri")
    public void setURI(String value) { this.uri = value; }
}
