package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Ambassage.Deserializer.class)
@JsonSerialize(using = Ambassage.Serializer.class)
public class Ambassage {
    public Object[] nullArrayValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Ambassage> {
        @Override
        public Ambassage deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Ambassage value = new Ambassage();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                default: throw new IOException("Cannot deserialize Ambassage");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Ambassage> {
        @Override
        public void serialize(Ambassage obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Ambassage must not be null");
        }
    }
}
