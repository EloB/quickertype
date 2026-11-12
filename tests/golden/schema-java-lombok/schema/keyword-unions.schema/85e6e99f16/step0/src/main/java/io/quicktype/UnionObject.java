package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionObject.Deserializer.class)
@JsonSerialize(using = UnionObject.Serializer.class)
public class UnionObject {
    public Double doubleValue;
    public ObjectClass objectClassValue;

    static class Deserializer extends JsonDeserializer<UnionObject> {
        @Override
        public UnionObject deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionObject value = new UnionObject();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.objectClassValue = jsonParser.readValueAs(ObjectClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionObject");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionObject> {
        @Override
        public void serialize(UnionObject obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.objectClassValue != null) {
                jsonGenerator.writeObject(obj.objectClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
