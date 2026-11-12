package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

@JsonDeserialize(using = Bocking.Deserializer.class)
@JsonSerialize(using = Bocking.Serializer.class)
public class Bocking {
    public List<Long> integerArrayValue;
    public Boolean boolValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Bocking> {
        @Override
        public Bocking deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Bocking value = new Bocking();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Bocking");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Bocking> {
        @Override
        public void serialize(Bocking obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Bocking must not be null");
        }
    }
}
