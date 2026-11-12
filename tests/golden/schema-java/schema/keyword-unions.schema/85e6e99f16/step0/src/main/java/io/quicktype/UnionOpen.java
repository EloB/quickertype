package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOpen.Deserializer.class)
@JsonSerialize(using = UnionOpen.Serializer.class)
public class UnionOpen {
    public Double doubleValue;
    public Open openValue;

    static class Deserializer extends JsonDeserializer<UnionOpen> {
        @Override
        public UnionOpen deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOpen value = new UnionOpen();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.openValue = jsonParser.readValueAs(Open.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOpen");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOpen> {
        @Override
        public void serialize(UnionOpen obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.openValue != null) {
                jsonGenerator.writeObject(obj.openValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
