package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionID.Deserializer.class)
@JsonSerialize(using = UnionID.Serializer.class)
public class UnionID {
    public Double doubleValue;
    public ID idValue;

    static class Deserializer extends JsonDeserializer<UnionID> {
        @Override
        public UnionID deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionID value = new UnionID();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.idValue = jsonParser.readValueAs(ID.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionID");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionID> {
        @Override
        public void serialize(UnionID obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.idValue != null) {
                jsonGenerator.writeObject(obj.idValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
