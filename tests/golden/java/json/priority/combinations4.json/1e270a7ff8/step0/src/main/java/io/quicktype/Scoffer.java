package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

@JsonDeserialize(using = Scoffer.Deserializer.class)
@JsonSerialize(using = Scoffer.Serializer.class)
public class Scoffer {
    public List<Object> nullArrayValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Scoffer> {
        @Override
        public Scoffer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Scoffer value = new Scoffer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Scoffer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Scoffer> {
        @Override
        public void serialize(Scoffer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
