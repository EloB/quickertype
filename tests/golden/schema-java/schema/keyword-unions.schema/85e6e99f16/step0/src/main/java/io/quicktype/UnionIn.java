package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIn.Deserializer.class)
@JsonSerialize(using = UnionIn.Serializer.class)
public class UnionIn {
    public Double doubleValue;
    public In inValue;

    static class Deserializer extends JsonDeserializer<UnionIn> {
        @Override
        public UnionIn deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIn value = new UnionIn();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.inValue = jsonParser.readValueAs(In.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIn");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIn> {
        @Override
        public void serialize(UnionIn obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.inValue != null) {
                jsonGenerator.writeObject(obj.inValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
