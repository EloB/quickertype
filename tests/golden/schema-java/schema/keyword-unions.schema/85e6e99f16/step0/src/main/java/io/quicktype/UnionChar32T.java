package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionChar32T.Deserializer.class)
@JsonSerialize(using = UnionChar32T.Serializer.class)
public class UnionChar32T {
    public Double doubleValue;
    public Char32T char32TValue;

    static class Deserializer extends JsonDeserializer<UnionChar32T> {
        @Override
        public UnionChar32T deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionChar32T value = new UnionChar32T();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.char32TValue = jsonParser.readValueAs(Char32T.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionChar32T");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionChar32T> {
        @Override
        public void serialize(UnionChar32T obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.char32TValue != null) {
                jsonGenerator.writeObject(obj.char32TValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
