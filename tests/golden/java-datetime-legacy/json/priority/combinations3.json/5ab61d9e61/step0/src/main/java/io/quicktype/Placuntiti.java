package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Placuntiti.Deserializer.class)
@JsonSerialize(using = Placuntiti.Serializer.class)
public class Placuntiti {
    public Long integerValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Placuntiti> {
        @Override
        public Placuntiti deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Placuntiti value = new Placuntiti();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Placuntiti");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Placuntiti> {
        @Override
        public void serialize(Placuntiti obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Placuntiti must not be null");
        }
    }
}
