package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCodable.Deserializer.class)
@JsonSerialize(using = UnionCodable.Serializer.class)
public class UnionCodable {
    public Double doubleValue;
    public Codable codableValue;

    static class Deserializer extends JsonDeserializer<UnionCodable> {
        @Override
        public UnionCodable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCodable value = new UnionCodable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.codableValue = jsonParser.readValueAs(Codable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCodable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCodable> {
        @Override
        public void serialize(UnionCodable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.codableValue != null) {
                jsonGenerator.writeObject(obj.codableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
