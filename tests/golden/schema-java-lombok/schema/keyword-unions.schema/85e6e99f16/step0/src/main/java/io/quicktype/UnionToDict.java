package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionToDict.Deserializer.class)
@JsonSerialize(using = UnionToDict.Serializer.class)
public class UnionToDict {
    public Double doubleValue;
    public ToDict toDictValue;

    static class Deserializer extends JsonDeserializer<UnionToDict> {
        @Override
        public UnionToDict deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionToDict value = new UnionToDict();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.toDictValue = jsonParser.readValueAs(ToDict.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionToDict");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionToDict> {
        @Override
        public void serialize(UnionToDict obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.toDictValue != null) {
                jsonGenerator.writeObject(obj.toDictValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
