package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Koryak.Deserializer.class)
@JsonSerialize(using = Koryak.Serializer.class)
public class Koryak {
    public Map<String, Long> unionMapValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Koryak> {
        @Override
        public Koryak deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Koryak value = new Koryak();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.unionMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Koryak");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Koryak> {
        @Override
        public void serialize(Koryak obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionMapValue != null) {
                jsonGenerator.writeObject(obj.unionMapValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Koryak must not be null");
        }
    }
}
