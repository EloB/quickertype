package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTopLevel.Deserializer.class)
@JsonSerialize(using = UnionTopLevel.Serializer.class)
public class UnionTopLevel {
    public Double doubleValue;
    public TopLevelClass topLevelClassValue;

    static class Deserializer extends JsonDeserializer<UnionTopLevel> {
        @Override
        public UnionTopLevel deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTopLevel value = new UnionTopLevel();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.topLevelClassValue = jsonParser.readValueAs(TopLevelClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTopLevel");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTopLevel> {
        @Override
        public void serialize(UnionTopLevel obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.topLevelClassValue != null) {
                jsonGenerator.writeObject(obj.topLevelClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
