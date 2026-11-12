package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private long averageRating;
    private String category;
    private long createdAt;
    private String description;
    private DisplayType displayType;
    private long downloadCount;
    private List<TopLevelFlag> flags;
    private List<Grant> grants;
    private boolean hideFromCatalog;
    private boolean hideFromDataJSON;
    private String id;
    private Long indexUpdatedAt;
    private String locale;
    private TopLevelMetadata metadata;
    private Boolean moderationStatus;
    private ModifyingViewUid modifyingViewUid;
    private String name;
    private boolean newBackend;
    private long numberOfComments;
    private long oid;
    private Owner owner;
    private Provenance provenance;
    private boolean publicationAppendEnabled;
    private Long publicationDate;
    private long publicationGroup;
    private PublicationStage publicationStage;
    private Ratings ratings;
    private String resourceName;
    private List<Right> rights;
    private String rowClass;
    private Long rowIdentifierColumnID;
    private Long rowsUpdatedAt;
    private RowsUpdatedBy rowsUpdatedBy;
    private TableAuthor tableAuthor;
    private long tableID;
    private List<String> tags;
    private long totalTimesRated;
    private long viewCount;
    private long viewLastModified;
    private ViewType viewType;

    @JsonProperty("averageRating")
    public long getAverageRating() { return averageRating; }
    @JsonProperty("averageRating")
    public void setAverageRating(long value) { this.averageRating = value; }

    @JsonProperty("category")
    public String getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(String value) { this.category = value; }

    @JsonProperty("createdAt")
    public long getCreatedAt() { return createdAt; }
    @JsonProperty("createdAt")
    public void setCreatedAt(long value) { this.createdAt = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("displayType")
    public DisplayType getDisplayType() { return displayType; }
    @JsonProperty("displayType")
    public void setDisplayType(DisplayType value) { this.displayType = value; }

    @JsonProperty("downloadCount")
    public long getDownloadCount() { return downloadCount; }
    @JsonProperty("downloadCount")
    public void setDownloadCount(long value) { this.downloadCount = value; }

    @JsonProperty("flags")
    public List<TopLevelFlag> getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(List<TopLevelFlag> value) { this.flags = value; }

    @JsonProperty("grants")
    public List<Grant> getGrants() { return grants; }
    @JsonProperty("grants")
    public void setGrants(List<Grant> value) { this.grants = value; }

    @JsonProperty("hideFromCatalog")
    public boolean getHideFromCatalog() { return hideFromCatalog; }
    @JsonProperty("hideFromCatalog")
    public void setHideFromCatalog(boolean value) { this.hideFromCatalog = value; }

    @JsonProperty("hideFromDataJson")
    public boolean getHideFromDataJSON() { return hideFromDataJSON; }
    @JsonProperty("hideFromDataJson")
    public void setHideFromDataJSON(boolean value) { this.hideFromDataJSON = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("indexUpdatedAt")
    public Long getIndexUpdatedAt() { return indexUpdatedAt; }
    @JsonProperty("indexUpdatedAt")
    public void setIndexUpdatedAt(Long value) { this.indexUpdatedAt = value; }

    @JsonProperty("locale")
    public String getLocale() { return locale; }
    @JsonProperty("locale")
    public void setLocale(String value) { this.locale = value; }

    @JsonProperty("metadata")
    public TopLevelMetadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(TopLevelMetadata value) { this.metadata = value; }

    @JsonProperty("moderationStatus")
    public Boolean getModerationStatus() { return moderationStatus; }
    @JsonProperty("moderationStatus")
    public void setModerationStatus(Boolean value) { this.moderationStatus = value; }

    @JsonProperty("modifyingViewUid")
    public ModifyingViewUid getModifyingViewUid() { return modifyingViewUid; }
    @JsonProperty("modifyingViewUid")
    public void setModifyingViewUid(ModifyingViewUid value) { this.modifyingViewUid = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("newBackend")
    public boolean getNewBackend() { return newBackend; }
    @JsonProperty("newBackend")
    public void setNewBackend(boolean value) { this.newBackend = value; }

    @JsonProperty("numberOfComments")
    public long getNumberOfComments() { return numberOfComments; }
    @JsonProperty("numberOfComments")
    public void setNumberOfComments(long value) { this.numberOfComments = value; }

    @JsonProperty("oid")
    public long getOID() { return oid; }
    @JsonProperty("oid")
    public void setOID(long value) { this.oid = value; }

    @JsonProperty("owner")
    public Owner getOwner() { return owner; }
    @JsonProperty("owner")
    public void setOwner(Owner value) { this.owner = value; }

    @JsonProperty("provenance")
    public Provenance getProvenance() { return provenance; }
    @JsonProperty("provenance")
    public void setProvenance(Provenance value) { this.provenance = value; }

    @JsonProperty("publicationAppendEnabled")
    public boolean getPublicationAppendEnabled() { return publicationAppendEnabled; }
    @JsonProperty("publicationAppendEnabled")
    public void setPublicationAppendEnabled(boolean value) { this.publicationAppendEnabled = value; }

    @JsonProperty("publicationDate")
    public Long getPublicationDate() { return publicationDate; }
    @JsonProperty("publicationDate")
    public void setPublicationDate(Long value) { this.publicationDate = value; }

    @JsonProperty("publicationGroup")
    public long getPublicationGroup() { return publicationGroup; }
    @JsonProperty("publicationGroup")
    public void setPublicationGroup(long value) { this.publicationGroup = value; }

    @JsonProperty("publicationStage")
    public PublicationStage getPublicationStage() { return publicationStage; }
    @JsonProperty("publicationStage")
    public void setPublicationStage(PublicationStage value) { this.publicationStage = value; }

    @JsonProperty("ratings")
    public Ratings getRatings() { return ratings; }
    @JsonProperty("ratings")
    public void setRatings(Ratings value) { this.ratings = value; }

    @JsonProperty("resourceName")
    public String getResourceName() { return resourceName; }
    @JsonProperty("resourceName")
    public void setResourceName(String value) { this.resourceName = value; }

    @JsonProperty("rights")
    public List<Right> getRights() { return rights; }
    @JsonProperty("rights")
    public void setRights(List<Right> value) { this.rights = value; }

    @JsonProperty("rowClass")
    public String getRowClass() { return rowClass; }
    @JsonProperty("rowClass")
    public void setRowClass(String value) { this.rowClass = value; }

    @JsonProperty("rowIdentifierColumnId")
    public Long getRowIdentifierColumnID() { return rowIdentifierColumnID; }
    @JsonProperty("rowIdentifierColumnId")
    public void setRowIdentifierColumnID(Long value) { this.rowIdentifierColumnID = value; }

    @JsonProperty("rowsUpdatedAt")
    public Long getRowsUpdatedAt() { return rowsUpdatedAt; }
    @JsonProperty("rowsUpdatedAt")
    public void setRowsUpdatedAt(Long value) { this.rowsUpdatedAt = value; }

    @JsonProperty("rowsUpdatedBy")
    public RowsUpdatedBy getRowsUpdatedBy() { return rowsUpdatedBy; }
    @JsonProperty("rowsUpdatedBy")
    public void setRowsUpdatedBy(RowsUpdatedBy value) { this.rowsUpdatedBy = value; }

    @JsonProperty("tableAuthor")
    public TableAuthor getTableAuthor() { return tableAuthor; }
    @JsonProperty("tableAuthor")
    public void setTableAuthor(TableAuthor value) { this.tableAuthor = value; }

    @JsonProperty("tableId")
    public long getTableID() { return tableID; }
    @JsonProperty("tableId")
    public void setTableID(long value) { this.tableID = value; }

    @JsonProperty("tags")
    public List<String> getTags() { return tags; }
    @JsonProperty("tags")
    public void setTags(List<String> value) { this.tags = value; }

    @JsonProperty("totalTimesRated")
    public long getTotalTimesRated() { return totalTimesRated; }
    @JsonProperty("totalTimesRated")
    public void setTotalTimesRated(long value) { this.totalTimesRated = value; }

    @JsonProperty("viewCount")
    public long getViewCount() { return viewCount; }
    @JsonProperty("viewCount")
    public void setViewCount(long value) { this.viewCount = value; }

    @JsonProperty("viewLastModified")
    public long getViewLastModified() { return viewLastModified; }
    @JsonProperty("viewLastModified")
    public void setViewLastModified(long value) { this.viewLastModified = value; }

    @JsonProperty("viewType")
    public ViewType getViewType() { return viewType; }
    @JsonProperty("viewType")
    public void setViewType(ViewType value) { this.viewType = value; }
}
