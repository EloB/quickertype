package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;

public class TopLevel {
    private LocalDate birthday;
    private OffsetDateTime lastSeen;
    private String name;

    @JsonProperty("birthday")
    public LocalDate getBirthday() { return birthday; }
    @JsonProperty("birthday")
    public void setBirthday(LocalDate value) { this.birthday = value; }

    @JsonProperty("lastSeen")
    public OffsetDateTime getLastSeen() { return lastSeen; }
    @JsonProperty("lastSeen")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setLastSeen(OffsetDateTime value) { this.lastSeen = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
