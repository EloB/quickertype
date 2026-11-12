package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAs.Deserializer.class)
@JsonSerialize(using = UnionAs.Serializer.class)
public class UnionAs {
    public Double doubleValue;
    public As asValue;

    static class Deserializer extends JsonDeserializer<UnionAs> {
        @Override
        public UnionAs deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAs value = new UnionAs();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.asValue = jsonParser.readValueAs(As.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAs");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAs> {
        @Override
        public void serialize(UnionAs obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.asValue != null) {
                jsonGenerator.writeObject(obj.asValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
