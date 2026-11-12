package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Union.Deserializer.class)
@JsonSerialize(using = Union.Serializer.class)
public class Union {
    public Boolean presenceValue;
    public Double amountValue;

    static class Deserializer extends JsonDeserializer<Union> {
        @Override
        public Union deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Union value = new Union();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.amountValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.presenceValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Union");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Union> {
        @Override
        public void serialize(Union obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.presenceValue != null) {
                jsonGenerator.writeObject(obj.presenceValue);
                return;
            }
            if (obj.amountValue != null) {
                jsonGenerator.writeObject(obj.amountValue);
                return;
            }
            throw new IOException("Union must not be null");
        }
    }
}
