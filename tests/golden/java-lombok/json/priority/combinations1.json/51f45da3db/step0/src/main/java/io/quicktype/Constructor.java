package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Constructor.Deserializer.class)
@JsonSerialize(using = Constructor.Serializer.class)
public class Constructor {
    public Boolean boolValue;
    public Map<String, Long> unionMapValue;

    static class Deserializer extends JsonDeserializer<Constructor> {
        @Override
        public Constructor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Constructor value = new Constructor();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Constructor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Constructor> {
        @Override
        public void serialize(Constructor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            throw new IOException("Constructor must not be null");
        }
    }
}
