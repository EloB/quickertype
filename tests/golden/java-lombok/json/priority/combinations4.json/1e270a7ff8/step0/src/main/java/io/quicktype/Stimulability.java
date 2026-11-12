package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Stimulability.Deserializer.class)
@JsonSerialize(using = Stimulability.Serializer.class)
public class Stimulability {
    public Boolean boolValue;
    public Long integerValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Stimulability> {
        @Override
        public Stimulability deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Stimulability value = new Stimulability();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Stimulability");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Stimulability> {
        @Override
        public void serialize(Stimulability obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Stimulability must not be null");
        }
    }
}
