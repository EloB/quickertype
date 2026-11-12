package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.UUID;

@JsonDeserialize(using = UnionWithEnumUnion.Deserializer.class)
@JsonSerialize(using = UnionWithEnumUnion.Serializer.class)
public class UnionWithEnumUnion {
    public UnionWithEnumEnum enumValue;
    public UUID uuidValue;

    static class Deserializer extends JsonDeserializer<UnionWithEnumUnion> {
        @Override
        public UnionWithEnumUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWithEnumUnion value = new UnionWithEnumUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.uuidValue = UUID.fromString(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.enumValue = UnionWithEnumEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize UnionWithEnumUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWithEnumUnion> {
        @Override
        public void serialize(UnionWithEnumUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            if (obj.uuidValue != null) {
                jsonGenerator.writeObject(obj.uuidValue);
                return;
            }
            throw new IOException("UnionWithEnumUnion must not be null");
        }
    }
}
