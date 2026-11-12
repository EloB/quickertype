package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

@JsonDeserialize(using = Acquirable.Deserializer.class)
@JsonSerialize(using = Acquirable.Serializer.class)
public class Acquirable {
    public List<Long> unionArrayValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Acquirable> {
        @Override
        public Acquirable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Acquirable value = new Acquirable();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Acquirable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Acquirable> {
        @Override
        public void serialize(Acquirable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Acquirable must not be null");
        }
    }
}
