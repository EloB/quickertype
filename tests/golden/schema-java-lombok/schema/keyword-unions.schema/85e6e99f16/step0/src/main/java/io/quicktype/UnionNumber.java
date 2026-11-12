package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNumber.Deserializer.class)
@JsonSerialize(using = UnionNumber.Serializer.class)
public class UnionNumber {
    public Double doubleValue;
    public Number numberValue;

    static class Deserializer extends JsonDeserializer<UnionNumber> {
        @Override
        public UnionNumber deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNumber value = new UnionNumber();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.numberValue = jsonParser.readValueAs(Number.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNumber");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNumber> {
        @Override
        public void serialize(UnionNumber obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.numberValue != null) {
                jsonGenerator.writeObject(obj.numberValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
