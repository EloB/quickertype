package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Catallactic.Deserializer.class)
@JsonSerialize(using = Catallactic.Serializer.class)
public class Catallactic {
    public Object[] nullArrayValue;
    public Boolean boolValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Catallactic> {
        @Override
        public Catallactic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Catallactic value = new Catallactic();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Catallactic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Catallactic> {
        @Override
        public void serialize(Catallactic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
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
            throw new IOException("Catallactic must not be null");
        }
    }
}
