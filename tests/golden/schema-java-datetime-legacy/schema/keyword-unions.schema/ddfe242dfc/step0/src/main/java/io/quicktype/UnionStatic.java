package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStatic.Deserializer.class)
@JsonSerialize(using = UnionStatic.Serializer.class)
public class UnionStatic {
    public Double doubleValue;
    public Static staticValue;

    static class Deserializer extends JsonDeserializer<UnionStatic> {
        @Override
        public UnionStatic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStatic value = new UnionStatic();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.staticValue = jsonParser.readValueAs(Static.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStatic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStatic> {
        @Override
        public void serialize(UnionStatic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.staticValue != null) {
                jsonGenerator.writeObject(obj.staticValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
