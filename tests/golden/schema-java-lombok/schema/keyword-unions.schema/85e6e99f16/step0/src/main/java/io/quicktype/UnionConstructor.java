package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConstructor.Deserializer.class)
@JsonSerialize(using = UnionConstructor.Serializer.class)
public class UnionConstructor {
    public Double doubleValue;
    public Constructor constructorValue;

    static class Deserializer extends JsonDeserializer<UnionConstructor> {
        @Override
        public UnionConstructor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConstructor value = new UnionConstructor();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.constructorValue = jsonParser.readValueAs(Constructor.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConstructor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConstructor> {
        @Override
        public void serialize(UnionConstructor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.constructorValue != null) {
                jsonGenerator.writeObject(obj.constructorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
