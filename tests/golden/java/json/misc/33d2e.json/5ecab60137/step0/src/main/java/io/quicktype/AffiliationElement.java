package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = AffiliationElement.Deserializer.class)
@JsonSerialize(using = AffiliationElement.Serializer.class)
public class AffiliationElement {
    public List<Object> anythingArrayValue;
    public AffiliationClass affiliationClassValue;

    static class Deserializer extends JsonDeserializer<AffiliationElement> {
        @Override
        public AffiliationElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AffiliationElement value = new AffiliationElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.anythingArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                case START_OBJECT:
                    value.affiliationClassValue = jsonParser.readValueAs(AffiliationClass.class);
                    break;
                default: throw new IOException("Cannot deserialize AffiliationElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AffiliationElement> {
        @Override
        public void serialize(AffiliationElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.anythingArrayValue != null) {
                jsonGenerator.writeObject(obj.anythingArrayValue);
                return;
            }
            if (obj.affiliationClassValue != null) {
                jsonGenerator.writeObject(obj.affiliationClassValue);
                return;
            }
            throw new IOException("AffiliationElement must not be null");
        }
    }
}
