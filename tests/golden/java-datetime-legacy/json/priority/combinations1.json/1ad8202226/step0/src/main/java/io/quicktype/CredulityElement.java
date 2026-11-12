package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = CredulityElement.Deserializer.class)
@JsonSerialize(using = CredulityElement.Serializer.class)
public class CredulityElement {
    public CredulityClass credulityClassValue;
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<CredulityElement> {
        @Override
        public CredulityElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            CredulityElement value = new CredulityElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.credulityClassValue = jsonParser.readValueAs(CredulityClass.class);
                    break;
                default: throw new IOException("Cannot deserialize CredulityElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<CredulityElement> {
        @Override
        public void serialize(CredulityElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.credulityClassValue != null) {
                jsonGenerator.writeObject(obj.credulityClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("CredulityElement must not be null");
        }
    }
}
