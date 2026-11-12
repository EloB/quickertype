package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAssociativity.Deserializer.class)
@JsonSerialize(using = UnionAssociativity.Serializer.class)
public class UnionAssociativity {
    public Double doubleValue;
    public Associativity associativityValue;

    static class Deserializer extends JsonDeserializer<UnionAssociativity> {
        @Override
        public UnionAssociativity deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAssociativity value = new UnionAssociativity();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.associativityValue = jsonParser.readValueAs(Associativity.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAssociativity");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAssociativity> {
        @Override
        public void serialize(UnionAssociativity obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.associativityValue != null) {
                jsonGenerator.writeObject(obj.associativityValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
