package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Next.Deserializer.class)
@JsonSerialize(using = Next.Serializer.class)
public class Next {
    public Node nodeValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Next> {
        @Override
        public Next deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Next value = new Next();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.nodeValue = jsonParser.readValueAs(Node.class);
                    break;
                default: throw new IOException("Cannot deserialize Next");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Next> {
        @Override
        public void serialize(Next obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nodeValue != null) {
                jsonGenerator.writeObject(obj.nodeValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
