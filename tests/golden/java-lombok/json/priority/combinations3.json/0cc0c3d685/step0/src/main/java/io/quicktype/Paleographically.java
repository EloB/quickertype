package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Paleographically.Deserializer.class)
@JsonSerialize(using = Paleographically.Serializer.class)
public class Paleographically {
    public Double doubleValue;
    public Map<String, Long> unionMapValue;

    static class Deserializer extends JsonDeserializer<Paleographically> {
        @Override
        public Paleographically deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Paleographically value = new Paleographically();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Paleographically");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Paleographically> {
        @Override
        public void serialize(Paleographically obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            throw new IOException("Paleographically must not be null");
        }
    }
}
