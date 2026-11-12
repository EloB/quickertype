package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSbyte.Deserializer.class)
@JsonSerialize(using = UnionSbyte.Serializer.class)
public class UnionSbyte {
    public Double doubleValue;
    public Sbyte sbyteValue;

    static class Deserializer extends JsonDeserializer<UnionSbyte> {
        @Override
        public UnionSbyte deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSbyte value = new UnionSbyte();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.sbyteValue = jsonParser.readValueAs(Sbyte.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSbyte");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSbyte> {
        @Override
        public void serialize(UnionSbyte obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.sbyteValue != null) {
                jsonGenerator.writeObject(obj.sbyteValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
