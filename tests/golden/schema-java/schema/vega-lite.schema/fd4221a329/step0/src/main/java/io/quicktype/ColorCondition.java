package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = ColorCondition.Deserializer.class)
@JsonSerialize(using = ColorCondition.Serializer.class)
public class ColorCondition {
    public ConditionalPredicateMarkPropFieldDefClass conditionalPredicateMarkPropFieldDefClassValue;
    public List<ConditionalValueDef> conditionalValueDefArrayValue;

    static class Deserializer extends JsonDeserializer<ColorCondition> {
        @Override
        public ColorCondition deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ColorCondition value = new ColorCondition();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case START_ARRAY:
                    value.conditionalValueDefArrayValue = jsonParser.readValueAs(new TypeReference<List<ConditionalValueDef>>() {});
                    break;
                case START_OBJECT:
                    value.conditionalPredicateMarkPropFieldDefClassValue = jsonParser.readValueAs(ConditionalPredicateMarkPropFieldDefClass.class);
                    break;
                default: throw new IOException("Cannot deserialize ColorCondition");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ColorCondition> {
        @Override
        public void serialize(ColorCondition obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.conditionalPredicateMarkPropFieldDefClassValue != null) {
                jsonGenerator.writeObject(obj.conditionalPredicateMarkPropFieldDefClassValue);
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
