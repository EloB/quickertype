package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = TopLevel.Deserializer.class)
@JsonSerialize(using = TopLevel.Serializer.class)
public class TopLevel {
    public List<TopLevelElement> topLevelElementArrayValue;
    public PurpleTopLevel purpleTopLevelValue;

    static class Deserializer extends JsonDeserializer<TopLevel> {
        @Override
        public TopLevel deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TopLevel value = new TopLevel();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.topLevelElementArrayValue = jsonParser.readValueAs(new TypeReference<List<TopLevelElement>>() {});
                    break;
                case START_OBJECT:
                    value.purpleTopLevelValue = jsonParser.readValueAs(PurpleTopLevel.class);
                    break;
                default: throw new IOException("Cannot deserialize TopLevel");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TopLevel> {
        @Override
        public void serialize(TopLevel obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.topLevelElementArrayValue != null) {
                jsonGenerator.writeObject(obj.topLevelElementArrayValue);
                return;
            }
            if (obj.purpleTopLevelValue != null) {
                jsonGenerator.writeObject(obj.purpleTopLevelValue);
                return;
            }
            throw new IOException("TopLevel must not be null");
        }
    }
}
