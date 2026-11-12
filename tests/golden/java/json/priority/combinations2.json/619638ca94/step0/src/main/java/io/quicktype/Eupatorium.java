package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import java.util.Map;

@JsonDeserialize(using = Eupatorium.Deserializer.class)
@JsonSerialize(using = Eupatorium.Serializer.class)
public class Eupatorium {
    public Object[] nullArrayValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Eupatorium> {
        @Override
        public Eupatorium deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Eupatorium value = new Eupatorium();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Eupatorium");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Eupatorium> {
        @Override
        public void serialize(Eupatorium obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            throw new IOException("Eupatorium must not be null");
        }
    }
}
