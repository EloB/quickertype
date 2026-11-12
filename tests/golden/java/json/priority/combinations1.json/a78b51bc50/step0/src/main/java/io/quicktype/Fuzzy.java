package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Fuzzy.Deserializer.class)
@JsonSerialize(using = Fuzzy.Serializer.class)
public class Fuzzy {
    public Long integerValue;
    public Map<String, Long> unionMapValue;

    static class Deserializer extends JsonDeserializer<Fuzzy> {
        @Override
        public Fuzzy deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Fuzzy value = new Fuzzy();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Fuzzy");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Fuzzy> {
        @Override
        public void serialize(Fuzzy obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            throw new IOException("Fuzzy must not be null");
        }
    }
}
