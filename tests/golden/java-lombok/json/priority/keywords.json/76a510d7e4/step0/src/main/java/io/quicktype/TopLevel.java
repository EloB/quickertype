package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long dummy;
    private Obj1 obj1;
    private Obj2 obj2;
    private Obj3 obj3;
    private Obj4 obj4;
    private Obj5 obj5;
    private Obj6 obj6;

    @JsonProperty("dummy")
    public long getDummy() { return dummy; }
    @JsonProperty("dummy")
    public void setDummy(long value) { this.dummy = value; }

    @JsonProperty("obj1")
    public Obj1 getObj1() { return obj1; }
    @JsonProperty("obj1")
    public void setObj1(Obj1 value) { this.obj1 = value; }

    @JsonProperty("obj2")
    public Obj2 getObj2() { return obj2; }
    @JsonProperty("obj2")
    public void setObj2(Obj2 value) { this.obj2 = value; }

    @JsonProperty("obj3")
    public Obj3 getObj3() { return obj3; }
    @JsonProperty("obj3")
    public void setObj3(Obj3 value) { this.obj3 = value; }

    @JsonProperty("obj4")
    public Obj4 getObj4() { return obj4; }
    @JsonProperty("obj4")
    public void setObj4(Obj4 value) { this.obj4 = value; }

    @JsonProperty("obj5")
    public Obj5 getObj5() { return obj5; }
    @JsonProperty("obj5")
    public void setObj5(Obj5 value) { this.obj5 = value; }

    @JsonProperty("obj6")
    public Obj6 getObj6() { return obj6; }
    @JsonProperty("obj6")
    public void setObj6(Obj6 value) { this.obj6 = value; }
}
