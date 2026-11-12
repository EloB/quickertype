package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRequired.Deserializer.class)
@JsonSerialize(using = UnionRequired.Serializer.class)
public class UnionRequired {
    public Double doubleValue;
    public Required requiredValue;

    static class Deserializer extends JsonDeserializer<UnionRequired> {
        @Override
        public UnionRequired deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRequired value = new UnionRequired();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.requiredValue = jsonParser.readValueAs(Required.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRequired");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRequired> {
        @Override
        public void serialize(UnionRequired obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.requiredValue != null) {
                jsonGenerator.writeObject(obj.requiredValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
