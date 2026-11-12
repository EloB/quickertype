package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = MixedElement.Deserializer.class)
@JsonSerialize(using = MixedElement.Serializer.class)
public class MixedElement {
    public Boolean boolValue;
    public MixedClass mixedClassValue;
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<MixedElement> {
        @Override
        public MixedElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            MixedElement value = new MixedElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.mixedClassValue = jsonParser.readValueAs(MixedClass.class);
                    break;
                default: throw new IOException("Cannot deserialize MixedElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<MixedElement> {
        @Override
        public void serialize(MixedElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.mixedClassValue != null) {
                jsonGenerator.writeObject(obj.mixedClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
