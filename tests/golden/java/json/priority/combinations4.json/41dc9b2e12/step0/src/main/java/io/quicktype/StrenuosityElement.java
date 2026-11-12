package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = StrenuosityElement.Deserializer.class)
@JsonSerialize(using = StrenuosityElement.Serializer.class)
public class StrenuosityElement {
    public Object[] nullArrayValue;
    public StrenuosityClass strenuosityClassValue;

    static class Deserializer extends JsonDeserializer<StrenuosityElement> {
        @Override
        public StrenuosityElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            StrenuosityElement value = new StrenuosityElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.strenuosityClassValue = jsonParser.readValueAs(StrenuosityClass.class);
                    break;
                default: throw new IOException("Cannot deserialize StrenuosityElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<StrenuosityElement> {
        @Override
        public void serialize(StrenuosityElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.strenuosityClassValue != null) {
                jsonGenerator.writeObject(obj.strenuosityClassValue);
                return;
            }
            throw new IOException("StrenuosityElement must not be null");
        }
    }
}
