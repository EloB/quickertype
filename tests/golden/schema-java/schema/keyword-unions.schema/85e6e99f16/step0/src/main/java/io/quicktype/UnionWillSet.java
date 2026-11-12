package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWillSet.Deserializer.class)
@JsonSerialize(using = UnionWillSet.Serializer.class)
public class UnionWillSet {
    public Double doubleValue;
    public WillSet willSetValue;

    static class Deserializer extends JsonDeserializer<UnionWillSet> {
        @Override
        public UnionWillSet deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWillSet value = new UnionWillSet();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.willSetValue = jsonParser.readValueAs(WillSet.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWillSet");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWillSet> {
        @Override
        public void serialize(UnionWillSet obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.willSetValue != null) {
                jsonGenerator.writeObject(obj.willSetValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
