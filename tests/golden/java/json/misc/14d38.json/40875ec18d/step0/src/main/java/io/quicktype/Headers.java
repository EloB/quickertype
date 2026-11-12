package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Headers {
    private String acceptEncoding;
    private String connection;
    private String host;
    private String userAgent;

    @JsonProperty("Accept-Encoding")
    public String getAcceptEncoding() { return acceptEncoding; }
    @JsonProperty("Accept-Encoding")
    public void setAcceptEncoding(String value) { this.acceptEncoding = value; }

    @JsonProperty("Connection")
    public String getConnection() { return connection; }
    @JsonProperty("Connection")
    public void setConnection(String value) { this.connection = value; }

    @JsonProperty("Host")
    public String getHost() { return host; }
    @JsonProperty("Host")
    public void setHost(String value) { this.host = value; }

    @JsonProperty("User-Agent")
    public String getUserAgent() { return userAgent; }
    @JsonProperty("User-Agent")
    public void setUserAgent(String value) { this.userAgent = value; }
}
