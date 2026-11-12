package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBitand.Deserializer.class)
@JsonSerialize(using = UnionBitand.Serializer.class)
public class UnionBitand {
    public Double doubleValue;
    public Bitand bitandValue;

    static class Deserializer extends JsonDeserializer<UnionBitand> {
        @Override
        public UnionBitand deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBitand value = new UnionBitand();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.bitandValue = jsonParser.readValueAs(Bitand.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBitand");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBitand> {
        @Override
        public void serialize(UnionBitand obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.bitandValue != null) {
                jsonGenerator.writeObject(obj.bitandValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
