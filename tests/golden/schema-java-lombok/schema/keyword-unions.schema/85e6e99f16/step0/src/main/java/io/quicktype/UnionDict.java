package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDict.Deserializer.class)
@JsonSerialize(using = UnionDict.Serializer.class)
public class UnionDict {
    public Double doubleValue;
    public Dict dictValue;

    static class Deserializer extends JsonDeserializer<UnionDict> {
        @Override
        public UnionDict deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDict value = new UnionDict();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dictValue = jsonParser.readValueAs(Dict.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDict");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDict> {
        @Override
        public void serialize(UnionDict obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dictValue != null) {
                jsonGenerator.writeObject(obj.dictValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
