package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = HemocoeleElement.Deserializer.class)
@JsonSerialize(using = HemocoeleElement.Serializer.class)
public class HemocoeleElement {
    public long[] integerArrayValue;
    public HemocoeleClass hemocoeleClassValue;

    static class Deserializer extends JsonDeserializer<HemocoeleElement> {
        @Override
        public HemocoeleElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            HemocoeleElement value = new HemocoeleElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.hemocoeleClassValue = jsonParser.readValueAs(HemocoeleClass.class);
                    break;
                default: throw new IOException("Cannot deserialize HemocoeleElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<HemocoeleElement> {
        @Override
        public void serialize(HemocoeleElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.hemocoeleClassValue != null) {
                jsonGenerator.writeObject(obj.hemocoeleClassValue);
                return;
            }
            throw new IOException("HemocoeleElement must not be null");
        }
    }
}
