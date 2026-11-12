package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = MonaziteElement.Deserializer.class)
@JsonSerialize(using = MonaziteElement.Serializer.class)
public class MonaziteElement {
    public MonaziteClass monaziteClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<MonaziteElement> {
        @Override
        public MonaziteElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            MonaziteElement value = new MonaziteElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.monaziteClassValue = jsonParser.readValueAs(MonaziteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize MonaziteElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<MonaziteElement> {
        @Override
        public void serialize(MonaziteElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.monaziteClassValue != null) {
                jsonGenerator.writeObject(obj.monaziteClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("MonaziteElement must not be null");
        }
    }
}
