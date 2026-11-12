package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionChar16T.Deserializer.class)
@JsonSerialize(using = UnionChar16T.Serializer.class)
public class UnionChar16T {
    public Double doubleValue;
    public Char16T char16TValue;

    static class Deserializer extends JsonDeserializer<UnionChar16T> {
        @Override
        public UnionChar16T deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionChar16T value = new UnionChar16T();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.char16TValue = jsonParser.readValueAs(Char16T.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionChar16T");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionChar16T> {
        @Override
        public void serialize(UnionChar16T obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.char16TValue != null) {
                jsonGenerator.writeObject(obj.char16TValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
