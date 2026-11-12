package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFinal.Deserializer.class)
@JsonSerialize(using = UnionFinal.Serializer.class)
public class UnionFinal {
    public Double doubleValue;
    public Final finalValue;

    static class Deserializer extends JsonDeserializer<UnionFinal> {
        @Override
        public UnionFinal deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFinal value = new UnionFinal();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.finalValue = jsonParser.readValueAs(Final.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFinal");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFinal> {
        @Override
        public void serialize(UnionFinal obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.finalValue != null) {
                jsonGenerator.writeObject(obj.finalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
