package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTypeof.Deserializer.class)
@JsonSerialize(using = UnionTypeof.Serializer.class)
public class UnionTypeof {
    public Double doubleValue;
    public Typeof typeofValue;

    static class Deserializer extends JsonDeserializer<UnionTypeof> {
        @Override
        public UnionTypeof deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTypeof value = new UnionTypeof();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typeofValue = jsonParser.readValueAs(Typeof.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTypeof");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTypeof> {
        @Override
        public void serialize(UnionTypeof obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typeofValue != null) {
                jsonGenerator.writeObject(obj.typeofValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
