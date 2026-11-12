package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionItem.Deserializer.class)
@JsonSerialize(using = UnionItem.Serializer.class)
public class UnionItem {
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<UnionItem> {
        @Override
        public UnionItem deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionItem value = new UnionItem();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize UnionItem");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionItem> {
        @Override
        public void serialize(UnionItem obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("UnionItem must not be null");
        }
    }
}
