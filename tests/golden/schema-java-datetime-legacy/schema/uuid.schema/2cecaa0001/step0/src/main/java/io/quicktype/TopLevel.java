package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.UUID;

public class TopLevel {
    private List<UUID> arrNullable;
    private List<UUID> arrOne;
    private UUID nullable;
    private UUID one;
    private UUID optional;
    private UnionWithEnumUnion unionWithEnum;

    @JsonProperty("arrNullable")
    public List<UUID> getArrNullable() { return arrNullable; }
    @JsonProperty("arrNullable")
    public void setArrNullable(List<UUID> value) { this.arrNullable = value; }

    @JsonProperty("arrOne")
    public List<UUID> getArrOne() { return arrOne; }
    @JsonProperty("arrOne")
    public void setArrOne(List<UUID> value) { this.arrOne = value; }

    @JsonProperty("nullable")
    public UUID getNullable() { return nullable; }
    @JsonProperty("nullable")
    public void setNullable(UUID value) { this.nullable = value; }

    @JsonProperty("one")
    public UUID getOne() { return one; }
    @JsonProperty("one")
    public void setOne(UUID value) { this.one = value; }

    @JsonProperty("optional")
    public UUID getOptional() { return optional; }
    @JsonProperty("optional")
    public void setOptional(UUID value) { this.optional = value; }

    @JsonProperty("unionWithEnum")
    public UnionWithEnumUnion getUnionWithEnum() { return unionWithEnum; }
    @JsonProperty("unionWithEnum")
    public void setUnionWithEnum(UnionWithEnumUnion value) { this.unionWithEnum = value; }
}
