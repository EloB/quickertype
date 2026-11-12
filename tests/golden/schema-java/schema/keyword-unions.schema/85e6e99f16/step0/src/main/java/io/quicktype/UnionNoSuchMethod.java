package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNoSuchMethod.Deserializer.class)
@JsonSerialize(using = UnionNoSuchMethod.Serializer.class)
public class UnionNoSuchMethod {
    public Double doubleValue;
    public NoSuchMethod noSuchMethodValue;

    static class Deserializer extends JsonDeserializer<UnionNoSuchMethod> {
        @Override
        public UnionNoSuchMethod deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNoSuchMethod value = new UnionNoSuchMethod();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.noSuchMethodValue = jsonParser.readValueAs(NoSuchMethod.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNoSuchMethod");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNoSuchMethod> {
        @Override
        public void serialize(UnionNoSuchMethod obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.noSuchMethodValue != null) {
                jsonGenerator.writeObject(obj.noSuchMethodValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
