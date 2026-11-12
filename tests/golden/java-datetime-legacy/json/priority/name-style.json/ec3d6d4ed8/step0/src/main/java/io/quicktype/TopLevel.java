package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long anEasyOne;
    private boolean isMNISTLetter;
    private String jsonString;
    private boolean prettyEasyToo;
    private String shouldKnowThatIDIsAnInitialism;
    private boolean spacesAreSeparatorsToo;
    private boolean zsrHhDemo3Delmatnr;

    @JsonProperty("anEasyOne")
    public long getAnEasyOne() { return anEasyOne; }
    @JsonProperty("anEasyOne")
    public void setAnEasyOne(long value) { this.anEasyOne = value; }

    @JsonProperty("isMNISTLetter")
    public boolean getIsMNISTLetter() { return isMNISTLetter; }
    @JsonProperty("isMNISTLetter")
    public void setIsMNISTLetter(boolean value) { this.isMNISTLetter = value; }

    @JsonProperty("JSONString")
    public String getJSONString() { return jsonString; }
    @JsonProperty("JSONString")
    public void setJSONString(String value) { this.jsonString = value; }

    @JsonProperty("PrettyEasyToo")
    public boolean getPrettyEasyToo() { return prettyEasyToo; }
    @JsonProperty("PrettyEasyToo")
    public void setPrettyEasyToo(boolean value) { this.prettyEasyToo = value; }

    @JsonProperty("should_know_that_id_is_an_initialism")
    public String getShouldKnowThatIDIsAnInitialism() { return shouldKnowThatIDIsAnInitialism; }
    @JsonProperty("should_know_that_id_is_an_initialism")
    public void setShouldKnowThatIDIsAnInitialism(String value) { this.shouldKnowThatIDIsAnInitialism = value; }

    @JsonProperty("   spaces are separators  too  ")
    public boolean getSpacesAreSeparatorsToo() { return spacesAreSeparatorsToo; }
    @JsonProperty("   spaces are separators  too  ")
    public void setSpacesAreSeparatorsToo(boolean value) { this.spacesAreSeparatorsToo = value; }

    @JsonProperty("ZSR_HH_DEMO3_DELMATNR")
    public boolean getZsrHhDemo3Delmatnr() { return zsrHhDemo3Delmatnr; }
    @JsonProperty("ZSR_HH_DEMO3_DELMATNR")
    public void setZsrHhDemo3Delmatnr(boolean value) { this.zsrHhDemo3Delmatnr = value; }
}
