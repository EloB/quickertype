package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnsafe.Deserializer.class)
@JsonSerialize(using = UnionUnsafe.Serializer.class)
public class UnionUnsafe {
    public Double doubleValue;
    public Unsafe unsafeValue;

    static class Deserializer extends JsonDeserializer<UnionUnsafe> {
        @Override
        public UnionUnsafe deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnsafe value = new UnionUnsafe();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unsafeValue = jsonParser.readValueAs(Unsafe.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnsafe");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnsafe> {
        @Override
        public void serialize(UnionUnsafe obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unsafeValue != null) {
                jsonGenerator.writeObject(obj.unsafeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
