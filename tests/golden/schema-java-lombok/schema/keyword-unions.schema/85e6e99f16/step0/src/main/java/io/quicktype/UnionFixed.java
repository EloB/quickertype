package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFixed.Deserializer.class)
@JsonSerialize(using = UnionFixed.Serializer.class)
public class UnionFixed {
    public Double doubleValue;
    public Fixed fixedValue;

    static class Deserializer extends JsonDeserializer<UnionFixed> {
        @Override
        public UnionFixed deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFixed value = new UnionFixed();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fixedValue = jsonParser.readValueAs(Fixed.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFixed");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFixed> {
        @Override
        public void serialize(UnionFixed obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fixedValue != null) {
                jsonGenerator.writeObject(obj.fixedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
