package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Unreceptivity.Deserializer.class)
@JsonSerialize(using = Unreceptivity.Serializer.class)
public class Unreceptivity {
    public Object[] nullArrayValue;
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Unreceptivity> {
        @Override
        public Unreceptivity deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Unreceptivity value = new Unreceptivity();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                default: throw new IOException("Cannot deserialize Unreceptivity");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Unreceptivity> {
        @Override
        public void serialize(Unreceptivity obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("Unreceptivity must not be null");
        }
    }
}
