package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDidSet.Deserializer.class)
@JsonSerialize(using = UnionDidSet.Serializer.class)
public class UnionDidSet {
    public Double doubleValue;
    public DidSet didSetValue;

    static class Deserializer extends JsonDeserializer<UnionDidSet> {
        @Override
        public UnionDidSet deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDidSet value = new UnionDidSet();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.didSetValue = jsonParser.readValueAs(DidSet.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDidSet");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDidSet> {
        @Override
        public void serialize(UnionDidSet obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.didSetValue != null) {
                jsonGenerator.writeObject(obj.didSetValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
