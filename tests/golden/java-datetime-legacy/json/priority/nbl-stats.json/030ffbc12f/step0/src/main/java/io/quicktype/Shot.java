package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Shot {
    private ActionType actionType;
    private long p;
    private long per;
    private PerType perType;
    private String player;
    private long pno;
    private long r;
    private String shirtNumber;
    private SubType subType;
    private long tno;
    private long x;
    private long y;

    @JsonProperty("actionType")
    public ActionType getActionType() { return actionType; }
    @JsonProperty("actionType")
    public void setActionType(ActionType value) { this.actionType = value; }

    @JsonProperty("p")
    public long getP() { return p; }
    @JsonProperty("p")
    public void setP(long value) { this.p = value; }

    @JsonProperty("per")
    public long getPer() { return per; }
    @JsonProperty("per")
    public void setPer(long value) { this.per = value; }

    @JsonProperty("perType")
    public PerType getPerType() { return perType; }
    @JsonProperty("perType")
    public void setPerType(PerType value) { this.perType = value; }

    @JsonProperty("player")
    public String getPlayer() { return player; }
    @JsonProperty("player")
    public void setPlayer(String value) { this.player = value; }

    @JsonProperty("pno")
    public long getPno() { return pno; }
    @JsonProperty("pno")
    public void setPno(long value) { this.pno = value; }

    @JsonProperty("r")
    public long getR() { return r; }
    @JsonProperty("r")
    public void setR(long value) { this.r = value; }

    @JsonProperty("shirtNumber")
    public String getShirtNumber() { return shirtNumber; }
    @JsonProperty("shirtNumber")
    public void setShirtNumber(String value) { this.shirtNumber = value; }

    @JsonProperty("subType")
    public SubType getSubType() { return subType; }
    @JsonProperty("subType")
    public void setSubType(SubType value) { this.subType = value; }

    @JsonProperty("tno")
    public long getTno() { return tno; }
    @JsonProperty("tno")
    public void setTno(long value) { this.tno = value; }

    @JsonProperty("x")
    public long getX() { return x; }
    @JsonProperty("x")
    public void setX(long value) { this.x = value; }

    @JsonProperty("y")
    public long getY() { return y; }
    @JsonProperty("y")
    public void setY(long value) { this.y = value; }
}
