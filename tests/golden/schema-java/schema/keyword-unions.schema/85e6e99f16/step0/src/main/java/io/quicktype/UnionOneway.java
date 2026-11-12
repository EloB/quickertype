package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOneway.Deserializer.class)
@JsonSerialize(using = UnionOneway.Serializer.class)
public class UnionOneway {
    public Double doubleValue;
    public Oneway onewayValue;

    static class Deserializer extends JsonDeserializer<UnionOneway> {
        @Override
        public UnionOneway deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOneway value = new UnionOneway();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.onewayValue = jsonParser.readValueAs(Oneway.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOneway");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOneway> {
        @Override
        public void serialize(UnionOneway obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.onewayValue != null) {
                jsonGenerator.writeObject(obj.onewayValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
