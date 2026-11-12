package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CustomFields {
    private CommonCore commonCore;
    private DatasetInformation datasetInformation;
    private DatasetSummary datasetSummary;
    private Disclaimers disclaimers;

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

    @JsonProperty("Disclaimers")
    public Disclaimers getDisclaimers() { return disclaimers; }
    @JsonProperty("Disclaimers")
    public void setDisclaimers(Disclaimers value) { this.disclaimers = value; }
}
