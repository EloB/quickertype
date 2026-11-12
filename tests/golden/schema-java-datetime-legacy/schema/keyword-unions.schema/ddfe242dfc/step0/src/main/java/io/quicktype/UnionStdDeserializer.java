package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStdDeserializer.Deserializer.class)
@JsonSerialize(using = UnionStdDeserializer.Serializer.class)
public class UnionStdDeserializer {
    public Double doubleValue;
    public StdDeserializer stdDeserializerValue;

    static class Deserializer extends JsonDeserializer<UnionStdDeserializer> {
        @Override
        public UnionStdDeserializer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStdDeserializer value = new UnionStdDeserializer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.stdDeserializerValue = jsonParser.readValueAs(StdDeserializer.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStdDeserializer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStdDeserializer> {
        @Override
        public void serialize(UnionStdDeserializer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stdDeserializerValue != null) {
                jsonGenerator.writeObject(obj.stdDeserializerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
