package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDecimal.Deserializer.class)
@JsonSerialize(using = UnionDecimal.Serializer.class)
public class UnionDecimal {
    public Double doubleValue;
    public Decimal decimalValue;

    static class Deserializer extends JsonDeserializer<UnionDecimal> {
        @Override
        public UnionDecimal deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDecimal value = new UnionDecimal();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.decimalValue = jsonParser.readValueAs(Decimal.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDecimal");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDecimal> {
        @Override
        public void serialize(UnionDecimal obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.decimalValue != null) {
                jsonGenerator.writeObject(obj.decimalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
