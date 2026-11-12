package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSelf.Deserializer.class)
@JsonSerialize(using = UnionSelf.Serializer.class)
public class UnionSelf {
    public Double doubleValue;
    public Self selfValue;

    static class Deserializer extends JsonDeserializer<UnionSelf> {
        @Override
        public UnionSelf deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSelf value = new UnionSelf();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.selfValue = jsonParser.readValueAs(Self.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSelf");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSelf> {
        @Override
        public void serialize(UnionSelf obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.selfValue != null) {
                jsonGenerator.writeObject(obj.selfValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
