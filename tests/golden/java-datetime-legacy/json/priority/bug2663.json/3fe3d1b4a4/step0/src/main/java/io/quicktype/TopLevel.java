package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class TopLevel {
    private Date birthday;
    private Date lastSeen;
    private String name;

    @JsonProperty("birthday")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getBirthday() { return birthday; }
    @JsonProperty("birthday")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public void setBirthday(Date value) { this.birthday = value; }

    @JsonProperty("lastSeen")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getLastSeen() { return lastSeen; }
    @JsonProperty("lastSeen")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setLastSeen(Date value) { this.lastSeen = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
