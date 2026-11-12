package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = DiscordiaElement.Deserializer.class)
@JsonSerialize(using = DiscordiaElement.Serializer.class)
public class DiscordiaElement {
    public long[] integerArrayValue;
    public DiscordiaClass discordiaClassValue;

    static class Deserializer extends JsonDeserializer<DiscordiaElement> {
        @Override
        public DiscordiaElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            DiscordiaElement value = new DiscordiaElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(long[].class);
                    break;
                case START_OBJECT:
                    value.discordiaClassValue = jsonParser.readValueAs(DiscordiaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize DiscordiaElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<DiscordiaElement> {
        @Override
        public void serialize(DiscordiaElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.discordiaClassValue != null) {
                jsonGenerator.writeObject(obj.discordiaClassValue);
                return;
            }
            throw new IOException("DiscordiaElement must not be null");
        }
    }
}
