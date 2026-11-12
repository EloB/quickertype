package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Listener.Deserializer.class)
@JsonSerialize(using = Listener.Serializer.class)
public class Listener {
    public Object[] nullArrayValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Listener> {
        @Override
        public Listener deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Listener value = new Listener();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                default: throw new IOException("Cannot deserialize Listener");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Listener> {
        @Override
        public void serialize(Listener obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Listener must not be null");
        }
    }
}
