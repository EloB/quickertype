package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionByte.Deserializer.class)
@JsonSerialize(using = UnionByte.Serializer.class)
public class UnionByte {
    public Double doubleValue;
    public Byte byteValue;

    static class Deserializer extends JsonDeserializer<UnionByte> {
        @Override
        public UnionByte deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionByte value = new UnionByte();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.byteValue = jsonParser.readValueAs(Byte.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionByte");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionByte> {
        @Override
        public void serialize(UnionByte obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.byteValue != null) {
                jsonGenerator.writeObject(obj.byteValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
