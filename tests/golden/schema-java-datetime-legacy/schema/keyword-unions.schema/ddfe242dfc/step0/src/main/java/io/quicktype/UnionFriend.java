package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFriend.Deserializer.class)
@JsonSerialize(using = UnionFriend.Serializer.class)
public class UnionFriend {
    public Double doubleValue;
    public Friend friendValue;

    static class Deserializer extends JsonDeserializer<UnionFriend> {
        @Override
        public UnionFriend deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFriend value = new UnionFriend();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.friendValue = jsonParser.readValueAs(Friend.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFriend");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFriend> {
        @Override
        public void serialize(UnionFriend obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.friendValue != null) {
                jsonGenerator.writeObject(obj.friendValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
