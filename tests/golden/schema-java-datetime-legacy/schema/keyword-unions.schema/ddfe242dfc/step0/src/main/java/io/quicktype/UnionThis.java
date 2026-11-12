package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionThis.Deserializer.class)
@JsonSerialize(using = UnionThis.Serializer.class)
public class UnionThis {
    public Double doubleValue;
    public This thisValue;

    static class Deserializer extends JsonDeserializer<UnionThis> {
        @Override
        public UnionThis deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionThis value = new UnionThis();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.thisValue = jsonParser.readValueAs(This.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionThis");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionThis> {
        @Override
        public void serialize(UnionThis obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.thisValue != null) {
                jsonGenerator.writeObject(obj.thisValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
