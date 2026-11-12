package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNSObject.Deserializer.class)
@JsonSerialize(using = UnionNSObject.Serializer.class)
public class UnionNSObject {
    public Double doubleValue;
    public NSObject nsObjectValue;

    static class Deserializer extends JsonDeserializer<UnionNSObject> {
        @Override
        public UnionNSObject deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNSObject value = new UnionNSObject();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nsObjectValue = jsonParser.readValueAs(NSObject.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNSObject");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNSObject> {
        @Override
        public void serialize(UnionNSObject obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nsObjectValue != null) {
                jsonGenerator.writeObject(obj.nsObjectValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
