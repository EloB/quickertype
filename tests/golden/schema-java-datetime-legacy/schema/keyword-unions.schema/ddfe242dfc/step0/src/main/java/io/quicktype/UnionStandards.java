package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStandards.Deserializer.class)
@JsonSerialize(using = UnionStandards.Serializer.class)
public class UnionStandards {
    public Double doubleValue;
    public Standards standardsValue;

    static class Deserializer extends JsonDeserializer<UnionStandards> {
        @Override
        public UnionStandards deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStandards value = new UnionStandards();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.standardsValue = jsonParser.readValueAs(Standards.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStandards");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStandards> {
        @Override
        public void serialize(UnionStandards obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.standardsValue != null) {
                jsonGenerator.writeObject(obj.standardsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
