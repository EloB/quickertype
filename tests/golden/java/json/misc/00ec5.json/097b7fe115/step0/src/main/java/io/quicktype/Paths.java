package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private BusinessServiceProvidersSearch businessServiceProvidersSearch;

    @JsonProperty("/business_service_providers/search")
    public BusinessServiceProvidersSearch getBusinessServiceProvidersSearch() { return businessServiceProvidersSearch; }
    @JsonProperty("/business_service_providers/search")
    public void setBusinessServiceProvidersSearch(BusinessServiceProvidersSearch value) { this.businessServiceProvidersSearch = value; }
}
