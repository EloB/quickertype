package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = MonotheisticallyElement.Deserializer.class)
@JsonSerialize(using = MonotheisticallyElement.Serializer.class)
public class MonotheisticallyElement {
    public Object[] nullArrayValue;
    public MonotheisticallyClass monotheisticallyClassValue;

    static class Deserializer extends JsonDeserializer<MonotheisticallyElement> {
        @Override
        public MonotheisticallyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            MonotheisticallyElement value = new MonotheisticallyElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.monotheisticallyClassValue = jsonParser.readValueAs(MonotheisticallyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize MonotheisticallyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<MonotheisticallyElement> {
        @Override
        public void serialize(MonotheisticallyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.monotheisticallyClassValue != null) {
                jsonGenerator.writeObject(obj.monotheisticallyClassValue);
                return;
            }
            throw new IOException("MonotheisticallyElement must not be null");
        }
    }
}
