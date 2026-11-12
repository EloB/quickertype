package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionHashCode.Deserializer.class)
@JsonSerialize(using = UnionHashCode.Serializer.class)
public class UnionHashCode {
    public Double doubleValue;
    public HashCode hashCodeValue;

    static class Deserializer extends JsonDeserializer<UnionHashCode> {
        @Override
        public UnionHashCode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionHashCode value = new UnionHashCode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.hashCodeValue = jsonParser.readValueAs(HashCode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionHashCode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionHashCode> {
        @Override
        public void serialize(UnionHashCode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.hashCodeValue != null) {
                jsonGenerator.writeObject(obj.hashCodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
