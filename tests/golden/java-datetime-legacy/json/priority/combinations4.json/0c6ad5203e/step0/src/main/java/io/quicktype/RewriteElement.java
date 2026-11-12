package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = RewriteElement.Deserializer.class)
@JsonSerialize(using = RewriteElement.Serializer.class)
public class RewriteElement {
    public Object[] nullArrayValue;
    public RewriteClass rewriteClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<RewriteElement> {
        @Override
        public RewriteElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            RewriteElement value = new RewriteElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.rewriteClassValue = jsonParser.readValueAs(RewriteClass.class);
                    break;
                default: throw new IOException("Cannot deserialize RewriteElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<RewriteElement> {
        @Override
        public void serialize(RewriteElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.rewriteClassValue != null) {
                jsonGenerator.writeObject(obj.rewriteClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("RewriteElement must not be null");
        }
    }
}
