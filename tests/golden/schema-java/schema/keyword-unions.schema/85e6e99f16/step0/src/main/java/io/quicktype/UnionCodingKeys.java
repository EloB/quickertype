package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCodingKeys.Deserializer.class)
@JsonSerialize(using = UnionCodingKeys.Serializer.class)
public class UnionCodingKeys {
    public Double doubleValue;
    public CodingKeys codingKeysValue;

    static class Deserializer extends JsonDeserializer<UnionCodingKeys> {
        @Override
        public UnionCodingKeys deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCodingKeys value = new UnionCodingKeys();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.codingKeysValue = jsonParser.readValueAs(CodingKeys.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCodingKeys");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCodingKeys> {
        @Override
        public void serialize(UnionCodingKeys obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.codingKeysValue != null) {
                jsonGenerator.writeObject(obj.codingKeysValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
