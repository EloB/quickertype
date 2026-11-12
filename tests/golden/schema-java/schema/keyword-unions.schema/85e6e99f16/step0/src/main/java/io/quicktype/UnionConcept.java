package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConcept.Deserializer.class)
@JsonSerialize(using = UnionConcept.Serializer.class)
public class UnionConcept {
    public Double doubleValue;
    public Concept conceptValue;

    static class Deserializer extends JsonDeserializer<UnionConcept> {
        @Override
        public UnionConcept deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConcept value = new UnionConcept();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.conceptValue = jsonParser.readValueAs(Concept.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConcept");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConcept> {
        @Override
        public void serialize(UnionConcept obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.conceptValue != null) {
                jsonGenerator.writeObject(obj.conceptValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
