package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String barre;
    private Enum enumerification;
    private String Goo;
    private Union unionization;

    @JsonProperty("bar")
    public String getBarre() { return barre; }
    @JsonProperty("bar")
    public void setBarre(String value) { this.barre = value; }

    @JsonProperty("enum")
    public Enum getEnumerification() { return enumerification; }
    @JsonProperty("enum")
    public void setEnumerification(Enum value) { this.enumerification = value; }

    @JsonProperty("foo")
    public String getGoo() { return Goo; }
    @JsonProperty("foo")
    public void setGoo(String value) { this.Goo = value; }

    @JsonProperty("union")
    public Union getUnionization() { return unionization; }
    @JsonProperty("union")
    public void setUnionization(Union value) { this.unionization = value; }
}
