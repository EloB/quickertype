package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Number.Deserializer.class)
@JsonSerialize(using = Number.Serializer.class)
public class Number {
    public Long integerValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Number> {
        @Override
        public Number deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Number value = new Number();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                default: throw new IOException("Cannot deserialize Number");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Number> {
        @Override
        public void serialize(Number obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Number must not be null");
        }
    }
}
