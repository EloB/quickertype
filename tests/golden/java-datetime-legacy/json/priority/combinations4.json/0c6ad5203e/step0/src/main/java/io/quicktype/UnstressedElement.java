package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = UnstressedElement.Deserializer.class)
@JsonSerialize(using = UnstressedElement.Serializer.class)
public class UnstressedElement {
    public Boolean boolValue;
    public UnstressedClass unstressedClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<UnstressedElement> {
        @Override
        public UnstressedElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnstressedElement value = new UnstressedElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.unstressedClassValue = jsonParser.readValueAs(UnstressedClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnstressedElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnstressedElement> {
        @Override
        public void serialize(UnstressedElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.unstressedClassValue != null) {
                jsonGenerator.writeObject(obj.unstressedClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("UnstressedElement must not be null");
        }
    }
}
