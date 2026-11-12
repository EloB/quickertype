package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionYield.Deserializer.class)
@JsonSerialize(using = UnionYield.Serializer.class)
public class UnionYield {
    public Double doubleValue;
    public Yield yieldValue;

    static class Deserializer extends JsonDeserializer<UnionYield> {
        @Override
        public UnionYield deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionYield value = new UnionYield();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.yieldValue = jsonParser.readValueAs(Yield.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionYield");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionYield> {
        @Override
        public void serialize(UnionYield obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.yieldValue != null) {
                jsonGenerator.writeObject(obj.yieldValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
