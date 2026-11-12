package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionToString.Deserializer.class)
@JsonSerialize(using = UnionToString.Serializer.class)
public class UnionToString {
    public Double doubleValue;
    public ToString toStringValue;

    static class Deserializer extends JsonDeserializer<UnionToString> {
        @Override
        public UnionToString deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionToString value = new UnionToString();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.toStringValue = jsonParser.readValueAs(ToString.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionToString");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionToString> {
        @Override
        public void serialize(UnionToString obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.toStringValue != null) {
                jsonGenerator.writeObject(obj.toStringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
