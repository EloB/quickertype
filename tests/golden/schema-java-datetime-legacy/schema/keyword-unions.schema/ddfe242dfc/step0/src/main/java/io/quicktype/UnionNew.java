package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNew.Deserializer.class)
@JsonSerialize(using = UnionNew.Serializer.class)
public class UnionNew {
    public Double doubleValue;
    public New newValue;

    static class Deserializer extends JsonDeserializer<UnionNew> {
        @Override
        public UnionNew deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNew value = new UnionNew();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.newValue = jsonParser.readValueAs(New.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNew");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNew> {
        @Override
        public void serialize(UnionNew obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.newValue != null) {
                jsonGenerator.writeObject(obj.newValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
