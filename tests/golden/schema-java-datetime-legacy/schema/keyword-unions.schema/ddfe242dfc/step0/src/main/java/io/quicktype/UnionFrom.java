package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFrom.Deserializer.class)
@JsonSerialize(using = UnionFrom.Serializer.class)
public class UnionFrom {
    public Double doubleValue;
    public From fromValue;

    static class Deserializer extends JsonDeserializer<UnionFrom> {
        @Override
        public UnionFrom deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFrom value = new UnionFrom();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fromValue = jsonParser.readValueAs(From.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFrom");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFrom> {
        @Override
        public void serialize(UnionFrom obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fromValue != null) {
                jsonGenerator.writeObject(obj.fromValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
