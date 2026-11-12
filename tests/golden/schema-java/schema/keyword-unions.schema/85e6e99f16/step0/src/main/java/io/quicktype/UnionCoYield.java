package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCoYield.Deserializer.class)
@JsonSerialize(using = UnionCoYield.Serializer.class)
public class UnionCoYield {
    public Double doubleValue;
    public CoYield coYieldValue;

    static class Deserializer extends JsonDeserializer<UnionCoYield> {
        @Override
        public UnionCoYield deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCoYield value = new UnionCoYield();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.coYieldValue = jsonParser.readValueAs(CoYield.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCoYield");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCoYield> {
        @Override
        public void serialize(UnionCoYield obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.coYieldValue != null) {
                jsonGenerator.writeObject(obj.coYieldValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
