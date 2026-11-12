package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Package {
    private long packagePackage;

    @JsonProperty("package")
    public long getPackagePackage() { return packagePackage; }
    @JsonProperty("package")
    public void setPackagePackage(long value) { this.packagePackage = value; }
}
