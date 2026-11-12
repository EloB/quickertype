package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWhere.Deserializer.class)
@JsonSerialize(using = UnionWhere.Serializer.class)
public class UnionWhere {
    public Double doubleValue;
    public Where whereValue;

    static class Deserializer extends JsonDeserializer<UnionWhere> {
        @Override
        public UnionWhere deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWhere value = new UnionWhere();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.whereValue = jsonParser.readValueAs(Where.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWhere");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWhere> {
        @Override
        public void serialize(UnionWhere obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.whereValue != null) {
                jsonGenerator.writeObject(obj.whereValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
