package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDelete.Deserializer.class)
@JsonSerialize(using = UnionDelete.Serializer.class)
public class UnionDelete {
    public Double doubleValue;
    public Delete deleteValue;

    static class Deserializer extends JsonDeserializer<UnionDelete> {
        @Override
        public UnionDelete deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDelete value = new UnionDelete();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.deleteValue = jsonParser.readValueAs(Delete.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDelete");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDelete> {
        @Override
        public void serialize(UnionDelete obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.deleteValue != null) {
                jsonGenerator.writeObject(obj.deleteValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
