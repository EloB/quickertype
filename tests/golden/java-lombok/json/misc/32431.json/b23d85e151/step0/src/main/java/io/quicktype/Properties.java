package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Properties {
    private Object alert;
    private Object cdi;
    private String code;
    private String detail;
    private Double dmin;
    private Object felt;
    private Long gap;
    private String ids;
    private double mag;
    private MagType magType;
    private Object mmi;
    private String net;
    private Long nst;
    private String place;
    private double rms;
    private long sig;
    private String sources;
    private Status status;
    private long time;
    private String title;
    private long tsunami;
    private PropertiesType type;
    private String types;
    private long tz;
    private long updated;
    private String url;

    @JsonProperty("alert")
    public Object getAlert() { return alert; }
    @JsonProperty("alert")
    public void setAlert(Object value) { this.alert = value; }

    @JsonProperty("cdi")
    public Object getCdi() { return cdi; }
    @JsonProperty("cdi")
    public void setCdi(Object value) { this.cdi = value; }

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("detail")
    public String getDetail() { return detail; }
    @JsonProperty("detail")
    public void setDetail(String value) { this.detail = value; }

    @JsonProperty("dmin")
    public Double getDmin() { return dmin; }
    @JsonProperty("dmin")
    public void setDmin(Double value) { this.dmin = value; }

    @JsonProperty("felt")
    public Object getFelt() { return felt; }
    @JsonProperty("felt")
    public void setFelt(Object value) { this.felt = value; }

    @JsonProperty("gap")
    public Long getGap() { return gap; }
    @JsonProperty("gap")
    public void setGap(Long value) { this.gap = value; }

    @JsonProperty("ids")
    public String getIDS() { return ids; }
    @JsonProperty("ids")
    public void setIDS(String value) { this.ids = value; }

    @JsonProperty("mag")
    public double getMag() { return mag; }
    @JsonProperty("mag")
    public void setMag(double value) { this.mag = value; }

    @JsonProperty("magType")
    public MagType getMagType() { return magType; }
    @JsonProperty("magType")
    public void setMagType(MagType value) { this.magType = value; }

    @JsonProperty("mmi")
    public Object getMMI() { return mmi; }
    @JsonProperty("mmi")
    public void setMMI(Object value) { this.mmi = value; }

    @JsonProperty("net")
    public String getNet() { return net; }
    @JsonProperty("net")
    public void setNet(String value) { this.net = value; }

    @JsonProperty("nst")
    public Long getNst() { return nst; }
    @JsonProperty("nst")
    public void setNst(Long value) { this.nst = value; }

    @JsonProperty("place")
    public String getPlace() { return place; }
    @JsonProperty("place")
    public void setPlace(String value) { this.place = value; }

    @JsonProperty("rms")
    public double getRMS() { return rms; }
    @JsonProperty("rms")
    public void setRMS(double value) { this.rms = value; }

    @JsonProperty("sig")
    public long getSig() { return sig; }
    @JsonProperty("sig")
    public void setSig(long value) { this.sig = value; }

    @JsonProperty("sources")
    public String getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(String value) { this.sources = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("time")
    public long getTime() { return time; }
    @JsonProperty("time")
    public void setTime(long value) { this.time = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("tsunami")
    public long getTsunami() { return tsunami; }
    @JsonProperty("tsunami")
    public void setTsunami(long value) { this.tsunami = value; }

    @JsonProperty("type")
    public PropertiesType getType() { return type; }
    @JsonProperty("type")
    public void setType(PropertiesType value) { this.type = value; }

    @JsonProperty("types")
    public String getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(String value) { this.types = value; }

    @JsonProperty("tz")
    public long getTz() { return tz; }
    @JsonProperty("tz")
    public void setTz(long value) { this.tz = value; }

    @JsonProperty("updated")
    public long getUpdated() { return updated; }
    @JsonProperty("updated")
    public void setUpdated(long value) { this.updated = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
