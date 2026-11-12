package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = HrefCondition.Deserializer.class)
@JsonSerialize(using = HrefCondition.Serializer.class)
public class HrefCondition {
    public ConditionalPredicateFieldDefClass conditionalPredicateFieldDefClassValue;
    public List<ConditionalValueDef> conditionalValueDefArrayValue;

    static class Deserializer extends JsonDeserializer<HrefCondition> {
        @Override
        public HrefCondition deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            HrefCondition value = new HrefCondition();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.conditionalValueDefArrayValue = jsonParser.readValueAs(new TypeReference<List<ConditionalValueDef>>() {});
                    break;
                case START_OBJECT:
                    value.conditionalPredicateFieldDefClassValue = jsonParser.readValueAs(ConditionalPredicateFieldDefClass.class);
                    break;
                default: throw new IOException("Cannot deserialize HrefCondition");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<HrefCondition> {
        @Override
        public void serialize(HrefCondition obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.conditionalPredicateFieldDefClassValue != null) {
                jsonGenerator.writeObject(obj.conditionalPredicateFieldDefClassValue);
                return;
            }
            if (obj.conditionalValueDefArrayValue != null) {
                jsonGenerator.writeObject(obj.conditionalValueDefArrayValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
