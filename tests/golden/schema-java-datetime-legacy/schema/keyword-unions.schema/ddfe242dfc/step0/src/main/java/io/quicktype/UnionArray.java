package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionArray.Deserializer.class)
@JsonSerialize(using = UnionArray.Serializer.class)
public class UnionArray {
    public Double doubleValue;
    public Array arrayValue;

    static class Deserializer extends JsonDeserializer<UnionArray> {
        @Override
        public UnionArray deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionArray value = new UnionArray();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.arrayValue = jsonParser.readValueAs(Array.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionArray");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionArray> {
        @Override
        public void serialize(UnionArray obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.arrayValue != null) {
                jsonGenerator.writeObject(obj.arrayValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
