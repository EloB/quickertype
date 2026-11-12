package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBitor.Deserializer.class)
@JsonSerialize(using = UnionBitor.Serializer.class)
public class UnionBitor {
    public Double doubleValue;
    public Bitor bitorValue;

    static class Deserializer extends JsonDeserializer<UnionBitor> {
        @Override
        public UnionBitor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBitor value = new UnionBitor();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.bitorValue = jsonParser.readValueAs(Bitor.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBitor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBitor> {
        @Override
        public void serialize(UnionBitor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.bitorValue != null) {
                jsonGenerator.writeObject(obj.bitorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
