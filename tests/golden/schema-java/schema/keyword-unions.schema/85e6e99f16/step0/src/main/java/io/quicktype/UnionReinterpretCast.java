package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionReinterpretCast.Deserializer.class)
@JsonSerialize(using = UnionReinterpretCast.Serializer.class)
public class UnionReinterpretCast {
    public Double doubleValue;
    public ReinterpretCast reinterpretCastValue;

    static class Deserializer extends JsonDeserializer<UnionReinterpretCast> {
        @Override
        public UnionReinterpretCast deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionReinterpretCast value = new UnionReinterpretCast();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.reinterpretCastValue = jsonParser.readValueAs(ReinterpretCast.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionReinterpretCast");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionReinterpretCast> {
        @Override
        public void serialize(UnionReinterpretCast obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.reinterpretCastValue != null) {
                jsonGenerator.writeObject(obj.reinterpretCastValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
