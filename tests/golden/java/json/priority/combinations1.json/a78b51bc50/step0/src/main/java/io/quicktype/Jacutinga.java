package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;
import java.util.Map;

@JsonDeserialize(using = Jacutinga.Deserializer.class)
@JsonSerialize(using = Jacutinga.Serializer.class)
public class Jacutinga {
    public List<Long> integerArrayValue;
    public Map<String, Long> unionMapValue;

    static class Deserializer extends JsonDeserializer<Jacutinga> {
        @Override
        public Jacutinga deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Jacutinga value = new Jacutinga();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Jacutinga");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Jacutinga> {
        @Override
        public void serialize(Jacutinga obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            throw new IOException("Jacutinga must not be null");
        }
    }
}
