package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = LaviniaElement.Deserializer.class)
@JsonSerialize(using = LaviniaElement.Serializer.class)
public class LaviniaElement {
    public LaviniaClass laviniaClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<LaviniaElement> {
        @Override
        public LaviniaElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LaviniaElement value = new LaviniaElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.laviniaClassValue = jsonParser.readValueAs(LaviniaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize LaviniaElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LaviniaElement> {
        @Override
        public void serialize(LaviniaElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.laviniaClassValue != null) {
                jsonGenerator.writeObject(obj.laviniaClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("LaviniaElement must not be null");
        }
    }
}
