package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = JurorElement.Deserializer.class)
@JsonSerialize(using = JurorElement.Serializer.class)
public class JurorElement {
    public Boolean boolValue;
    public JurorClass jurorClassValue;

    static class Deserializer extends JsonDeserializer<JurorElement> {
        @Override
        public JurorElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            JurorElement value = new JurorElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.jurorClassValue = jsonParser.readValueAs(JurorClass.class);
                    break;
                default: throw new IOException("Cannot deserialize JurorElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<JurorElement> {
        @Override
        public void serialize(JurorElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.jurorClassValue != null) {
                jsonGenerator.writeObject(obj.jurorClassValue);
                return;
            }
            throw new IOException("JurorElement must not be null");
        }
    }
}
