package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Brookie.Deserializer.class)
@JsonSerialize(using = Brookie.Serializer.class)
public class Brookie {
    public List<Long> integerArrayValue;
    public Rebecca rebeccaValue;

    static class Deserializer extends JsonDeserializer<Brookie> {
        @Override
        public Brookie deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Brookie value = new Brookie();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize Brookie");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Brookie> {
        @Override
        public void serialize(Brookie obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            throw new IOException("Brookie must not be null");
        }
    }
}
