package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CustomFields {
    private AdditionalResources additionalResources;
    private CommonCore commonCore;
    private DatasetInformation datasetInformation;
    private DatasetSummary datasetSummary;
    private Notes notes;

    @JsonProperty("Additional Resources")
    public AdditionalResources getAdditionalResources() { return additionalResources; }
    @JsonProperty("Additional Resources")
    public void setAdditionalResources(AdditionalResources value) { this.additionalResources = value; }

    @JsonProperty("Common Core")
    public CommonCore getCommonCore() { return commonCore; }
    @JsonProperty("Common Core")
    public void setCommonCore(CommonCore value) { this.commonCore = value; }

    @JsonProperty("Dataset Information")
    public DatasetInformation getDatasetInformation() { return datasetInformation; }
    @JsonProperty("Dataset Information")
    public void setDatasetInformation(DatasetInformation value) { this.datasetInformation = value; }

    @JsonProperty("Dataset Summary")
    public DatasetSummary getDatasetSummary() { return datasetSummary; }
    @JsonProperty("Dataset Summary")
    public void setDatasetSummary(DatasetSummary value) { this.datasetSummary = value; }

    @JsonProperty("Notes")
    public Notes getNotes() { return notes; }
    @JsonProperty("Notes")
    public void setNotes(Notes value) { this.notes = value; }
}
