package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<String> arrNullable;
    private List<String> arrOne;
    private String nullable;
    private String one;
    private String optional;
    private UnionWithBool unionWithBool;
    private UnionWithBool unionWithBoolAndEnum;

    @JsonProperty("arrNullable")
    public List<String> getArrNullable() { return arrNullable; }
    @JsonProperty("arrNullable")
    public void setArrNullable(List<String> value) { this.arrNullable = value; }

    @JsonProperty("arrOne")
    public List<String> getArrOne() { return arrOne; }
    @JsonProperty("arrOne")
    public void setArrOne(List<String> value) { this.arrOne = value; }

    @JsonProperty("nullable")
    public String getNullable() { return nullable; }
    @JsonProperty("nullable")
    public void setNullable(String value) { this.nullable = value; }

    @JsonProperty("one")
    public String getOne() { return one; }
    @JsonProperty("one")
    public void setOne(String value) { this.one = value; }

    @JsonProperty("optional")
    public String getOptional() { return optional; }
    @JsonProperty("optional")
    public void setOptional(String value) { this.optional = value; }

    @JsonProperty("unionWithBool")
    public UnionWithBool getUnionWithBool() { return unionWithBool; }
    @JsonProperty("unionWithBool")
    public void setUnionWithBool(UnionWithBool value) { this.unionWithBool = value; }

    @JsonProperty("unionWithBoolAndEnum")
    public UnionWithBool getUnionWithBoolAndEnum() { return unionWithBoolAndEnum; }
    @JsonProperty("unionWithBoolAndEnum")
    public void setUnionWithBoolAndEnum(UnionWithBool value) { this.unionWithBoolAndEnum = value; }
}
