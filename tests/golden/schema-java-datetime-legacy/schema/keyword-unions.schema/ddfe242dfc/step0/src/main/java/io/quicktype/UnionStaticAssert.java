package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStaticAssert.Deserializer.class)
@JsonSerialize(using = UnionStaticAssert.Serializer.class)
public class UnionStaticAssert {
    public Double doubleValue;
    public StaticAssert staticAssertValue;

    static class Deserializer extends JsonDeserializer<UnionStaticAssert> {
        @Override
        public UnionStaticAssert deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStaticAssert value = new UnionStaticAssert();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.staticAssertValue = jsonParser.readValueAs(StaticAssert.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStaticAssert");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStaticAssert> {
        @Override
        public void serialize(UnionStaticAssert obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.staticAssertValue != null) {
                jsonGenerator.writeObject(obj.staticAssertValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
