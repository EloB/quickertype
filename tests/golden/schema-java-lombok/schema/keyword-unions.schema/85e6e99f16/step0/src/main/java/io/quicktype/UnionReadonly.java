package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionReadonly.Deserializer.class)
@JsonSerialize(using = UnionReadonly.Serializer.class)
public class UnionReadonly {
    public Double doubleValue;
    public Readonly readonlyValue;

    static class Deserializer extends JsonDeserializer<UnionReadonly> {
        @Override
        public UnionReadonly deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionReadonly value = new UnionReadonly();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.readonlyValue = jsonParser.readValueAs(Readonly.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionReadonly");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionReadonly> {
        @Override
        public void serialize(UnionReadonly obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.readonlyValue != null) {
                jsonGenerator.writeObject(obj.readonlyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
