package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = ZElement.Deserializer.class)
@JsonSerialize(using = ZElement.Serializer.class)
public class ZElement {
    public List<Long> integerArrayValue;
    public ZClass zClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<ZElement> {
        @Override
        public ZElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ZElement value = new ZElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.zClassValue = jsonParser.readValueAs(ZClass.class);
                    break;
                default: throw new IOException("Cannot deserialize ZElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ZElement> {
        @Override
        public void serialize(ZElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.zClassValue != null) {
                jsonGenerator.writeObject(obj.zClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("ZElement must not be null");
        }
    }
}
