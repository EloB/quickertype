package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = PrefreshmanElement.Deserializer.class)
@JsonSerialize(using = PrefreshmanElement.Serializer.class)
public class PrefreshmanElement {
    public List<Object> nullArrayValue;
    public PrefreshmanClass prefreshmanClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<PrefreshmanElement> {
        @Override
        public PrefreshmanElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PrefreshmanElement value = new PrefreshmanElement();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.prefreshmanClassValue = jsonParser.readValueAs(PrefreshmanClass.class);
                    break;
                default: throw new IOException("Cannot deserialize PrefreshmanElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PrefreshmanElement> {
        @Override
        public void serialize(PrefreshmanElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.prefreshmanClassValue != null) {
                jsonGenerator.writeObject(obj.prefreshmanClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("PrefreshmanElement must not be null");
        }
    }
}
