package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = ObjectOrStringUnion.Deserializer.class)
@JsonSerialize(using = ObjectOrStringUnion.Serializer.class)
public class ObjectOrStringUnion {
    public String stringValue;
    public ObjectOrStringClass objectOrStringClassValue;

    static class Deserializer extends JsonDeserializer<ObjectOrStringUnion> {
        @Override
        public ObjectOrStringUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ObjectOrStringUnion value = new ObjectOrStringUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.objectOrStringClassValue = jsonParser.readValueAs(ObjectOrStringClass.class);
                    break;
                default: throw new IOException("Cannot deserialize ObjectOrStringUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ObjectOrStringUnion> {
        @Override
        public void serialize(ObjectOrStringUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            if (obj.objectOrStringClassValue != null) {
                jsonGenerator.writeObject(obj.objectOrStringClassValue);
                return;
            }
            throw new IOException("ObjectOrStringUnion must not be null");
        }
    }
}
