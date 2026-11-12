package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class View {
    private long averageRating;
    private String category;
    private List<Column> columns;
    private long createdAt;
    private String displayType;
    private long downloadCount;
    private List<String> flags;
    private List<Grant> grants;
    private boolean hideFromCatalog;
    private boolean hideFromDataJSON;
    private String id;
    private long indexUpdatedAt;
    private License license;
    private String licenseID;
    private String locale;
    private Metadata metadata;
    private String name;
    private boolean newBackend;
    private long numberOfComments;
    private long oid;
    private Owner owner;
    private String provenance;
    private boolean publicationAppendEnabled;
    private long publicationDate;
    private long publicationGroup;
    private String publicationStage;
    private Query query;
    private List<String> rights;
    private String rowClass;
    private long rowsUpdatedAt;
    private String rowsUpdatedBy;
    private Owner tableAuthor;
    private long tableID;
    private long totalTimesRated;
    private long viewCount;
    private long viewLastModified;
    private String viewType;

    @JsonProperty("averageRating")
    public long getAverageRating() { return averageRating; }
    @JsonProperty("averageRating")
    public void setAverageRating(long value) { this.averageRating = value; }

    @JsonProperty("category")
    public String getCategory() { return category; }
    @JsonProperty("category")
    public void setCategory(String value) { this.category = value; }

    @JsonProperty("columns")
    public List<Column> getColumns() { return columns; }
    @JsonProperty("columns")
    public void setColumns(List<Column> value) { this.columns = value; }

    @JsonProperty("createdAt")
    public long getCreatedAt() { return createdAt; }
    @JsonProperty("createdAt")
    public void setCreatedAt(long value) { this.createdAt = value; }

    @JsonProperty("displayType")
    public String getDisplayType() { return displayType; }
    @JsonProperty("displayType")
    public void setDisplayType(String value) { this.displayType = value; }

    @JsonProperty("downloadCount")
    public long getDownloadCount() { return downloadCount; }
    @JsonProperty("downloadCount")
    public void setDownloadCount(long value) { this.downloadCount = value; }

    @JsonProperty("flags")
    public List<String> getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(List<String> value) { this.flags = value; }

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
    public long getIndexUpdatedAt() { return indexUpdatedAt; }
    @JsonProperty("indexUpdatedAt")
    public void setIndexUpdatedAt(long value) { this.indexUpdatedAt = value; }

    @JsonProperty("license")
    public License getLicense() { return license; }
    @JsonProperty("license")
    public void setLicense(License value) { this.license = value; }

    @JsonProperty("licenseId")
    public String getLicenseID() { return licenseID; }
    @JsonProperty("licenseId")
    public void setLicenseID(String value) { this.licenseID = value; }

    @JsonProperty("locale")
    public String getLocale() { return locale; }
    @JsonProperty("locale")
    public void setLocale(String value) { this.locale = value; }

    @JsonProperty("metadata")
    public Metadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(Metadata value) { this.metadata = value; }

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
    public String getProvenance() { return provenance; }
    @JsonProperty("provenance")
    public void setProvenance(String value) { this.provenance = value; }

    @JsonProperty("publicationAppendEnabled")
    public boolean getPublicationAppendEnabled() { return publicationAppendEnabled; }
    @JsonProperty("publicationAppendEnabled")
    public void setPublicationAppendEnabled(boolean value) { this.publicationAppendEnabled = value; }

    @JsonProperty("publicationDate")
    public long getPublicationDate() { return publicationDate; }
    @JsonProperty("publicationDate")
    public void setPublicationDate(long value) { this.publicationDate = value; }

    @JsonProperty("publicationGroup")
    public long getPublicationGroup() { return publicationGroup; }
    @JsonProperty("publicationGroup")
    public void setPublicationGroup(long value) { this.publicationGroup = value; }

    @JsonProperty("publicationStage")
    public String getPublicationStage() { return publicationStage; }
    @JsonProperty("publicationStage")
    public void setPublicationStage(String value) { this.publicationStage = value; }

    @JsonProperty("query")
    public Query getQuery() { return query; }
    @JsonProperty("query")
    public void setQuery(Query value) { this.query = value; }

    @JsonProperty("rights")
    public List<String> getRights() { return rights; }
    @JsonProperty("rights")
    public void setRights(List<String> value) { this.rights = value; }

    @JsonProperty("rowClass")
    public String getRowClass() { return rowClass; }
    @JsonProperty("rowClass")
    public void setRowClass(String value) { this.rowClass = value; }

    @JsonProperty("rowsUpdatedAt")
    public long getRowsUpdatedAt() { return rowsUpdatedAt; }
    @JsonProperty("rowsUpdatedAt")
    public void setRowsUpdatedAt(long value) { this.rowsUpdatedAt = value; }

    @JsonProperty("rowsUpdatedBy")
    public String getRowsUpdatedBy() { return rowsUpdatedBy; }
    @JsonProperty("rowsUpdatedBy")
    public void setRowsUpdatedBy(String value) { this.rowsUpdatedBy = value; }

    @JsonProperty("tableAuthor")
    public Owner getTableAuthor() { return tableAuthor; }
    @JsonProperty("tableAuthor")
    public void setTableAuthor(Owner value) { this.tableAuthor = value; }

    @JsonProperty("tableId")
    public long getTableID() { return tableID; }
    @JsonProperty("tableId")
    public void setTableID(long value) { this.tableID = value; }

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
    public String getViewType() { return viewType; }
    @JsonProperty("viewType")
    public void setViewType(String value) { this.viewType = value; }
}
