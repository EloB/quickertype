package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CommonCore {
    private String contactEmail;
    private String contactName;
    private String publisher;

    @JsonProperty("Contact Email")
    public String getContactEmail() { return contactEmail; }
    @JsonProperty("Contact Email")
    public void setContactEmail(String value) { this.contactEmail = value; }

    @JsonProperty("Contact Name")
    public String getContactName() { return contactName; }
    @JsonProperty("Contact Name")
    public void setContactName(String value) { this.contactName = value; }

    @JsonProperty("Publisher")
    public String getPublisher() { return publisher; }
    @JsonProperty("Publisher")
    public void setPublisher(String value) { this.publisher = value; }
}
