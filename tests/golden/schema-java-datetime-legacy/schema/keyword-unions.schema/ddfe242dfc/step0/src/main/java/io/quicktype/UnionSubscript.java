package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSubscript.Deserializer.class)
@JsonSerialize(using = UnionSubscript.Serializer.class)
public class UnionSubscript {
    public Double doubleValue;
    public Subscript subscriptValue;

    static class Deserializer extends JsonDeserializer<UnionSubscript> {
        @Override
        public UnionSubscript deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSubscript value = new UnionSubscript();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.subscriptValue = jsonParser.readValueAs(Subscript.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSubscript");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSubscript> {
        @Override
        public void serialize(UnionSubscript obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.subscriptValue != null) {
                jsonGenerator.writeObject(obj.subscriptValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
