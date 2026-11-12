package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrimitiveKind.Deserializer.class)
@JsonSerialize(using = UnionPrimitiveKind.Serializer.class)
public class UnionPrimitiveKind {
    public Double doubleValue;
    public PrimitiveKind primitiveKindValue;

    static class Deserializer extends JsonDeserializer<UnionPrimitiveKind> {
        @Override
        public UnionPrimitiveKind deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrimitiveKind value = new UnionPrimitiveKind();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.primitiveKindValue = jsonParser.readValueAs(PrimitiveKind.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrimitiveKind");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrimitiveKind> {
        @Override
        public void serialize(UnionPrimitiveKind obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.primitiveKindValue != null) {
                jsonGenerator.writeObject(obj.primitiveKindValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
