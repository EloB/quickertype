package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBOOL.Deserializer.class)
@JsonSerialize(using = UnionBOOL.Serializer.class)
public class UnionBOOL {
    public Double doubleValue;
    public Bool boolValue;

    static class Deserializer extends JsonDeserializer<UnionBOOL> {
        @Override
        public UnionBOOL deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBOOL value = new UnionBOOL();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.boolValue = jsonParser.readValueAs(Bool.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBOOL");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBOOL> {
        @Override
        public void serialize(UnionBOOL obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
