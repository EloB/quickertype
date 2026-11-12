package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private Actor actor;
    private OffsetDateTime createdAt;
    private String id;
    private Actor org;
    private Payload payload;
    private TopLevelRepo repo;
    private boolean topLevelPublic;
    private Type type;

    @JsonProperty("actor")
    public Actor getActor() { return actor; }
    @JsonProperty("actor")
    public void setActor(Actor value) { this.actor = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("org")
    public Actor getOrg() { return org; }
    @JsonProperty("org")
    public void setOrg(Actor value) { this.org = value; }

    @JsonProperty("payload")
    public Payload getPayload() { return payload; }
    @JsonProperty("payload")
    public void setPayload(Payload value) { this.payload = value; }

    @JsonProperty("repo")
    public TopLevelRepo getRepo() { return repo; }
    @JsonProperty("repo")
    public void setRepo(TopLevelRepo value) { this.repo = value; }

    @JsonProperty("public")
    public boolean getTopLevelPublic() { return topLevelPublic; }
    @JsonProperty("public")
    public void setTopLevelPublic(boolean value) { this.topLevelPublic = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }
}
