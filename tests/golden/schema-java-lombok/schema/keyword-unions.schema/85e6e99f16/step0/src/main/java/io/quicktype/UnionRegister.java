package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRegister.Deserializer.class)
@JsonSerialize(using = UnionRegister.Serializer.class)
public class UnionRegister {
    public Double doubleValue;
    public Register registerValue;

    static class Deserializer extends JsonDeserializer<UnionRegister> {
        @Override
        public UnionRegister deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRegister value = new UnionRegister();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.registerValue = jsonParser.readValueAs(Register.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRegister");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRegister> {
        @Override
        public void serialize(UnionRegister obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.registerValue != null) {
                jsonGenerator.writeObject(obj.registerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
