package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = TruantcyElement.Deserializer.class)
@JsonSerialize(using = TruantcyElement.Serializer.class)
public class TruantcyElement {
    public Boolean boolValue;
    public TruantcyClass truantcyClassValue;

    static class Deserializer extends JsonDeserializer<TruantcyElement> {
        @Override
        public TruantcyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TruantcyElement value = new TruantcyElement();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.truantcyClassValue = jsonParser.readValueAs(TruantcyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize TruantcyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TruantcyElement> {
        @Override
        public void serialize(TruantcyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.truantcyClassValue != null) {
                jsonGenerator.writeObject(obj.truantcyClassValue);
                return;
            }
            throw new IOException("TruantcyElement must not be null");
        }
    }
}
