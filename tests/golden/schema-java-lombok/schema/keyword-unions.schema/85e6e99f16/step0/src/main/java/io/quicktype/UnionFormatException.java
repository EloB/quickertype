package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFormatException.Deserializer.class)
@JsonSerialize(using = UnionFormatException.Serializer.class)
public class UnionFormatException {
    public Double doubleValue;
    public FormatException formatExceptionValue;

    static class Deserializer extends JsonDeserializer<UnionFormatException> {
        @Override
        public UnionFormatException deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFormatException value = new UnionFormatException();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.formatExceptionValue = jsonParser.readValueAs(FormatException.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFormatException");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFormatException> {
        @Override
        public void serialize(UnionFormatException obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.formatExceptionValue != null) {
                jsonGenerator.writeObject(obj.formatExceptionValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
