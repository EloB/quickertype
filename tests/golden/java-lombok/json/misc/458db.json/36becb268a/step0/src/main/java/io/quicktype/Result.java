package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.UUID;

public class Result {
    private List<Object> attachments;
    private String body;
    private String changed;
    private List<Component> component;
    private String created;
    private String date;
    private List<Object> image;
    private List<Object> teaser;
    private String title;
    private List<Object> topic;
    private String url;
    private UUID uuid;
    private UUID vuuid;

    @JsonProperty("attachments")
    public List<Object> getAttachments() { return attachments; }
    @JsonProperty("attachments")
    public void setAttachments(List<Object> value) { this.attachments = value; }

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }

    @JsonProperty("changed")
    public String getChanged() { return changed; }
    @JsonProperty("changed")
    public void setChanged(String value) { this.changed = value; }

    @JsonProperty("component")
    public List<Component> getComponent() { return component; }
    @JsonProperty("component")
    public void setComponent(List<Component> value) { this.component = value; }

    @JsonProperty("created")
    public String getCreated() { return created; }
    @JsonProperty("created")
    public void setCreated(String value) { this.created = value; }

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("image")
    public List<Object> getImage() { return image; }
    @JsonProperty("image")
    public void setImage(List<Object> value) { this.image = value; }

    @JsonProperty("teaser")
    public List<Object> getTeaser() { return teaser; }
    @JsonProperty("teaser")
    public void setTeaser(List<Object> value) { this.teaser = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("topic")
    public List<Object> getTopic() { return topic; }
    @JsonProperty("topic")
    public void setTopic(List<Object> value) { this.topic = value; }

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
