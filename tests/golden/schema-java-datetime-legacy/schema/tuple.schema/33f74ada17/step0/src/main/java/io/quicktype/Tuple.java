package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Tuple.Deserializer.class)
@JsonSerialize(using = Tuple.Serializer.class)
public class Tuple {
    public Long integerValue;
    public Boolean boolValue;

    static class Deserializer extends JsonDeserializer<Tuple> {
        @Override
        public Tuple deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Tuple value = new Tuple();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Tuple");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Tuple> {
        @Override
        public void serialize(Tuple obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            throw new IOException("Tuple must not be null");
        }
    }
}
