package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionChar.Deserializer.class)
@JsonSerialize(using = UnionChar.Serializer.class)
public class UnionChar {
    public Double doubleValue;
    public Char charValue;

    static class Deserializer extends JsonDeserializer<UnionChar> {
        @Override
        public UnionChar deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionChar value = new UnionChar();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.charValue = jsonParser.readValueAs(Char.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionChar");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionChar> {
        @Override
        public void serialize(UnionChar obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.charValue != null) {
                jsonGenerator.writeObject(obj.charValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
