package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRetain.Deserializer.class)
@JsonSerialize(using = UnionRetain.Serializer.class)
public class UnionRetain {
    public Double doubleValue;
    public Retain retainValue;

    static class Deserializer extends JsonDeserializer<UnionRetain> {
        @Override
        public UnionRetain deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRetain value = new UnionRetain();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.retainValue = jsonParser.readValueAs(Retain.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRetain");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRetain> {
        @Override
        public void serialize(UnionRetain obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.retainValue != null) {
                jsonGenerator.writeObject(obj.retainValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
