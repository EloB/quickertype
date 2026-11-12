package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private String designation;
    private OffsetDateTime discoveryDate;
    private String hMag;
    private String iDeg;
    private String moidAu;
    private OrbitClass orbitClass;
    private String periodYr;
    private Pha pha;
    private String qAu1;
    private String qAu2;

    @JsonProperty("designation")
    public String getDesignation() { return designation; }
    @JsonProperty("designation")
    public void setDesignation(String value) { this.designation = value; }

    @JsonProperty("discovery_date")
    public OffsetDateTime getDiscoveryDate() { return discoveryDate; }
    @JsonProperty("discovery_date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setDiscoveryDate(OffsetDateTime value) { this.discoveryDate = value; }

    @JsonProperty("h_mag")
    public String getHMag() { return hMag; }
    @JsonProperty("h_mag")
    public void setHMag(String value) { this.hMag = value; }

    @JsonProperty("i_deg")
    public String getIDeg() { return iDeg; }
    @JsonProperty("i_deg")
    public void setIDeg(String value) { this.iDeg = value; }

    @JsonProperty("moid_au")
    public String getMoidAu() { return moidAu; }
    @JsonProperty("moid_au")
    public void setMoidAu(String value) { this.moidAu = value; }

    @JsonProperty("orbit_class")
    public OrbitClass getOrbitClass() { return orbitClass; }
    @JsonProperty("orbit_class")
    public void setOrbitClass(OrbitClass value) { this.orbitClass = value; }

    @JsonProperty("period_yr")
    public String getPeriodYr() { return periodYr; }
    @JsonProperty("period_yr")
    public void setPeriodYr(String value) { this.periodYr = value; }

    @JsonProperty("pha")
    public Pha getPha() { return pha; }
    @JsonProperty("pha")
    public void setPha(Pha value) { this.pha = value; }

    @JsonProperty("q_au_1")
    public String getQAu1() { return qAu1; }
    @JsonProperty("q_au_1")
    public void setQAu1(String value) { this.qAu1 = value; }

    @JsonProperty("q_au_2")
    public String getQAu2() { return qAu2; }
    @JsonProperty("q_au_2")
    public void setQAu2(String value) { this.qAu2 = value; }
}
