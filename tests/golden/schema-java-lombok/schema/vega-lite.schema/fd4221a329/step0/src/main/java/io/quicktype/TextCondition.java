package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = TextCondition.Deserializer.class)
@JsonSerialize(using = TextCondition.Serializer.class)
public class TextCondition {
    public ConditionalPredicateTextFieldDefClass conditionalPredicateTextFieldDefClassValue;
    public List<ConditionalValueDef> conditionalValueDefArrayValue;

    static class Deserializer extends JsonDeserializer<TextCondition> {
        @Override
        public TextCondition deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TextCondition value = new TextCondition();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.conditionalValueDefArrayValue = jsonParser.readValueAs(new TypeReference<List<ConditionalValueDef>>() {});
                    break;
                case START_OBJECT:
                    value.conditionalPredicateTextFieldDefClassValue = jsonParser.readValueAs(ConditionalPredicateTextFieldDefClass.class);
                    break;
                default: throw new IOException("Cannot deserialize TextCondition");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TextCondition> {
        @Override
        public void serialize(TextCondition obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.conditionalPredicateTextFieldDefClassValue != null) {
                jsonGenerator.writeObject(obj.conditionalPredicateTextFieldDefClassValue);
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
