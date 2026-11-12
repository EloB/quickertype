package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Attachment {
    private String assetID;
    private String blobID;
    private String filename;
    private String name;

    @JsonProperty("assetId")
    public String getAssetID() { return assetID; }
    @JsonProperty("assetId")
    public void setAssetID(String value) { this.assetID = value; }

    @JsonProperty("blobId")
    public String getBlobID() { return blobID; }
    @JsonProperty("blobId")
    public void setBlobID(String value) { this.blobID = value; }

    @JsonProperty("filename")
    public String getFilename() { return filename; }
    @JsonProperty("filename")
    public void setFilename(String value) { this.filename = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
