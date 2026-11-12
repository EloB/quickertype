package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCodingKey.Deserializer.class)
@JsonSerialize(using = UnionCodingKey.Serializer.class)
public class UnionCodingKey {
    public Double doubleValue;
    public CodingKey codingKeyValue;

    static class Deserializer extends JsonDeserializer<UnionCodingKey> {
        @Override
        public UnionCodingKey deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCodingKey value = new UnionCodingKey();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.codingKeyValue = jsonParser.readValueAs(CodingKey.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCodingKey");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCodingKey> {
        @Override
        public void serialize(UnionCodingKey obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.codingKeyValue != null) {
                jsonGenerator.writeObject(obj.codingKeyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
