package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private TopLevelBla bla;
    private Empty empty;
    private Foo foo;
    private ThisIsAToughOne thisIsAToughOne;
    private long topLevel;
    private EmptyClass topLevelEmpty;

    @JsonProperty("bla")
    public TopLevelBla getBla() { return bla; }
    @JsonProperty("bla")
    public void setBla(TopLevelBla value) { this.bla = value; }

    @JsonAnyGetter
    public java.util.Map<String, Object> getEmpty() { return java.util.Collections.<String, Object>singletonMap("", empty); }
    @JsonAnySetter
    public void setEmpty(String key, Empty value) { if (key.isEmpty()) this.empty = value; }

    @JsonProperty("foo")
    public Foo getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Foo value) { this.foo = value; }

    @JsonProperty("ThisIsA\ud83d\ude1cTough\"\n\nOne")
    public ThisIsAToughOne getThisIsAToughOne() { return thisIsAToughOne; }
    @JsonProperty("ThisIsA\ud83d\ude1cTough\"\n\nOne")
    public void setThisIsAToughOne(ThisIsAToughOne value) { this.thisIsAToughOne = value; }

    @JsonProperty("!")
    public long getTopLevel() { return topLevel; }
    @JsonProperty("!")
    public void setTopLevel(long value) { this.topLevel = value; }

    @JsonProperty("Empty")
    public EmptyClass getTopLevelEmpty() { return topLevelEmpty; }
    @JsonProperty("Empty")
    public void setTopLevelEmpty(EmptyClass value) { this.topLevelEmpty = value; }
}
