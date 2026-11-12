package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFromDict.Deserializer.class)
@JsonSerialize(using = UnionFromDict.Serializer.class)
public class UnionFromDict {
    public Double doubleValue;
    public FromDict fromDictValue;

    static class Deserializer extends JsonDeserializer<UnionFromDict> {
        @Override
        public UnionFromDict deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFromDict value = new UnionFromDict();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fromDictValue = jsonParser.readValueAs(FromDict.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFromDict");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFromDict> {
        @Override
        public void serialize(UnionFromDict obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fromDictValue != null) {
                jsonGenerator.writeObject(obj.fromDictValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
