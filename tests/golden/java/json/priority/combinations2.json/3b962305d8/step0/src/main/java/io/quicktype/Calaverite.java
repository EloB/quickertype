package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Calaverite.Deserializer.class)
@JsonSerialize(using = Calaverite.Serializer.class)
public class Calaverite {
    public List<Long> integerArrayValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Calaverite> {
        @Override
        public Calaverite deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Calaverite value = new Calaverite();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Calaverite");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Calaverite> {
        @Override
        public void serialize(Calaverite obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Calaverite must not be null");
        }
    }
}
