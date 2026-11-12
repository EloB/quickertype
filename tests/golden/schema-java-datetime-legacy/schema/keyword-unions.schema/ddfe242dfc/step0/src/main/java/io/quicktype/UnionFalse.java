package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFalse.Deserializer.class)
@JsonSerialize(using = UnionFalse.Serializer.class)
public class UnionFalse {
    public Double doubleValue;
    public False falseValue;

    static class Deserializer extends JsonDeserializer<UnionFalse> {
        @Override
        public UnionFalse deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFalse value = new UnionFalse();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.falseValue = jsonParser.readValueAs(False.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFalse");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFalse> {
        @Override
        public void serialize(UnionFalse obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.falseValue != null) {
                jsonGenerator.writeObject(obj.falseValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
