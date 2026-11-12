package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Brawlingly.Deserializer.class)
@JsonSerialize(using = Brawlingly.Serializer.class)
public class Brawlingly {
    public Object[] nullArrayValue;
    public Map<String, Long> unionMapValue;

    static class Deserializer extends JsonDeserializer<Brawlingly> {
        @Override
        public Brawlingly deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Brawlingly value = new Brawlingly();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Brawlingly");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Brawlingly> {
        @Override
        public void serialize(Brawlingly obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            throw new IOException("Brawlingly must not be null");
        }
    }
}
