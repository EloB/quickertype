package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBoolean.Deserializer.class)
@JsonSerialize(using = UnionBoolean.Serializer.class)
public class UnionBoolean {
    public Double doubleValue;
    public BooleanClass booleanClassValue;

    static class Deserializer extends JsonDeserializer<UnionBoolean> {
        @Override
        public UnionBoolean deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBoolean value = new UnionBoolean();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.booleanClassValue = jsonParser.readValueAs(BooleanClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBoolean");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBoolean> {
        @Override
        public void serialize(UnionBoolean obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.booleanClassValue != null) {
                jsonGenerator.writeObject(obj.booleanClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
