package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = TopLevelUnionBool.Deserializer.class)
@JsonSerialize(using = TopLevelUnionBool.Serializer.class)
public class TopLevelUnionBool {
    public Double doubleValue;
    public UnionBoolBool unionBoolBoolValue;

    static class Deserializer extends JsonDeserializer<TopLevelUnionBool> {
        @Override
        public TopLevelUnionBool deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            TopLevelUnionBool value = new TopLevelUnionBool();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unionBoolBoolValue = jsonParser.readValueAs(UnionBoolBool.class);
                    break;
                default: throw new IOException("Cannot deserialize TopLevelUnionBool");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<TopLevelUnionBool> {
        @Override
        public void serialize(TopLevelUnionBool obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unionBoolBoolValue != null) {
                jsonGenerator.writeObject(obj.unionBoolBoolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
