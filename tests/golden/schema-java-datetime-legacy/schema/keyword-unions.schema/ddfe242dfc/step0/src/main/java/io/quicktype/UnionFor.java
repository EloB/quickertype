package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFor.Deserializer.class)
@JsonSerialize(using = UnionFor.Serializer.class)
public class UnionFor {
    public Double doubleValue;
    public For forValue;

    static class Deserializer extends JsonDeserializer<UnionFor> {
        @Override
        public UnionFor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFor value = new UnionFor();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.forValue = jsonParser.readValueAs(For.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFor> {
        @Override
        public void serialize(UnionFor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.forValue != null) {
                jsonGenerator.writeObject(obj.forValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
