package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionContinue.Deserializer.class)
@JsonSerialize(using = UnionContinue.Serializer.class)
public class UnionContinue {
    public Double doubleValue;
    public Continue continueValue;

    static class Deserializer extends JsonDeserializer<UnionContinue> {
        @Override
        public UnionContinue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionContinue value = new UnionContinue();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.continueValue = jsonParser.readValueAs(Continue.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionContinue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionContinue> {
        @Override
        public void serialize(UnionContinue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.continueValue != null) {
                jsonGenerator.writeObject(obj.continueValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
