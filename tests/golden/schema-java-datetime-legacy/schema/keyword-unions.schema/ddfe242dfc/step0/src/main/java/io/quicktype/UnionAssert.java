package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAssert.Deserializer.class)
@JsonSerialize(using = UnionAssert.Serializer.class)
public class UnionAssert {
    public Double doubleValue;
    public Assert assertValue;

    static class Deserializer extends JsonDeserializer<UnionAssert> {
        @Override
        public UnionAssert deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAssert value = new UnionAssert();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.assertValue = jsonParser.readValueAs(Assert.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAssert");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAssert> {
        @Override
        public void serialize(UnionAssert obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.assertValue != null) {
                jsonGenerator.writeObject(obj.assertValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
