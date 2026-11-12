package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNil.Deserializer.class)
@JsonSerialize(using = UnionNil.Serializer.class)
public class UnionNil {
    public Double doubleValue;
    public Nil nilValue;

    static class Deserializer extends JsonDeserializer<UnionNil> {
        @Override
        public UnionNil deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNil value = new UnionNil();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nilValue = jsonParser.readValueAs(Nil.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNil");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNil> {
        @Override
        public void serialize(UnionNil obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nilValue != null) {
                jsonGenerator.writeObject(obj.nilValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
