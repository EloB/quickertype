package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDecodeString.Deserializer.class)
@JsonSerialize(using = UnionDecodeString.Serializer.class)
public class UnionDecodeString {
    public Double doubleValue;
    public DecodeString decodeStringValue;

    static class Deserializer extends JsonDeserializer<UnionDecodeString> {
        @Override
        public UnionDecodeString deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDecodeString value = new UnionDecodeString();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.decodeStringValue = jsonParser.readValueAs(DecodeString.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDecodeString");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDecodeString> {
        @Override
        public void serialize(UnionDecodeString obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.decodeStringValue != null) {
                jsonGenerator.writeObject(obj.decodeStringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
