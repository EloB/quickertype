package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCase.Deserializer.class)
@JsonSerialize(using = UnionCase.Serializer.class)
public class UnionCase {
    public Double doubleValue;
    public Case caseValue;

    static class Deserializer extends JsonDeserializer<UnionCase> {
        @Override
        public UnionCase deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCase value = new UnionCase();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.caseValue = jsonParser.readValueAs(Case.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCase");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCase> {
        @Override
        public void serialize(UnionCase obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.caseValue != null) {
                jsonGenerator.writeObject(obj.caseValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
