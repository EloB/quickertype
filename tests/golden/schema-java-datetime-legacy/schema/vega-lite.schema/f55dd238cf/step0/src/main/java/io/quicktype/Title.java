package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Title.Deserializer.class)
@JsonSerialize(using = Title.Serializer.class)
public class Title {
    public TitleParams titleParamsValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<Title> {
        @Override
        public Title deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Title value = new Title();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.titleParamsValue = jsonParser.readValueAs(TitleParams.class);
                    break;
                default: throw new IOException("Cannot deserialize Title");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Title> {
        @Override
        public void serialize(Title obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.titleParamsValue != null) {
                jsonGenerator.writeObject(obj.titleParamsValue);
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
