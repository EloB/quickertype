package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Stagmometer.Deserializer.class)
@JsonSerialize(using = Stagmometer.Serializer.class)
public class Stagmometer {
    public List<Long> unionArrayValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Stagmometer> {
        @Override
        public Stagmometer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Stagmometer value = new Stagmometer();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Stagmometer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Stagmometer> {
        @Override
        public void serialize(Stagmometer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Stagmometer must not be null");
        }
    }
}
