package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRef.Deserializer.class)
@JsonSerialize(using = UnionRef.Serializer.class)
public class UnionRef {
    public Double doubleValue;
    public Ref refValue;

    static class Deserializer extends JsonDeserializer<UnionRef> {
        @Override
        public UnionRef deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRef value = new UnionRef();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.refValue = jsonParser.readValueAs(Ref.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRef");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRef> {
        @Override
        public void serialize(UnionRef obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.refValue != null) {
                jsonGenerator.writeObject(obj.refValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
