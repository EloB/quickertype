package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNSString.Deserializer.class)
@JsonSerialize(using = UnionNSString.Serializer.class)
public class UnionNSString {
    public Double doubleValue;
    public NSString nsStringValue;

    static class Deserializer extends JsonDeserializer<UnionNSString> {
        @Override
        public UnionNSString deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNSString value = new UnionNSString();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nsStringValue = jsonParser.readValueAs(NSString.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNSString");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNSString> {
        @Override
        public void serialize(UnionNSString obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nsStringValue != null) {
                jsonGenerator.writeObject(obj.nsStringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
