package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = SisteringElement.Deserializer.class)
@JsonSerialize(using = SisteringElement.Serializer.class)
public class SisteringElement {
    public Object[] nullArrayValue;
    public SisteringClass sisteringClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<SisteringElement> {
        @Override
        public SisteringElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SisteringElement value = new SisteringElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.sisteringClassValue = jsonParser.readValueAs(SisteringClass.class);
                    break;
                default: throw new IOException("Cannot deserialize SisteringElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SisteringElement> {
        @Override
        public void serialize(SisteringElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.sisteringClassValue != null) {
                jsonGenerator.writeObject(obj.sisteringClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("SisteringElement must not be null");
        }
    }
}
