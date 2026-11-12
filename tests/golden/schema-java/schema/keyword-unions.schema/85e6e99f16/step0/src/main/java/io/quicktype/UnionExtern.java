package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExtern.Deserializer.class)
@JsonSerialize(using = UnionExtern.Serializer.class)
public class UnionExtern {
    public Double doubleValue;
    public Extern externValue;

    static class Deserializer extends JsonDeserializer<UnionExtern> {
        @Override
        public UnionExtern deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExtern value = new UnionExtern();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.externValue = jsonParser.readValueAs(Extern.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExtern");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExtern> {
        @Override
        public void serialize(UnionExtern obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.externValue != null) {
                jsonGenerator.writeObject(obj.externValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
