package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Xmlschematype {
    private String localpart;
    private String namespaceuri;
    private String prefix;

    @JsonProperty("localpart")
    public String getLocalpart() { return localpart; }
    @JsonProperty("localpart")
    public void setLocalpart(String value) { this.localpart = value; }

    @JsonProperty("namespaceuri")
    public String getNamespaceuri() { return namespaceuri; }
    @JsonProperty("namespaceuri")
    public void setNamespaceuri(String value) { this.namespaceuri = value; }

    @JsonProperty("prefix")
    public String getPrefix() { return prefix; }
    @JsonProperty("prefix")
    public void setPrefix(String value) { this.prefix = value; }
}
