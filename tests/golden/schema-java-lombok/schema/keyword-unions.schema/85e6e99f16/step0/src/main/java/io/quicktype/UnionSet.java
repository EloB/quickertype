package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSet.Deserializer.class)
@JsonSerialize(using = UnionSet.Serializer.class)
public class UnionSet {
    public Double doubleValue;
    public Set setValue;

    static class Deserializer extends JsonDeserializer<UnionSet> {
        @Override
        public UnionSet deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSet value = new UnionSet();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.setValue = jsonParser.readValueAs(Set.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSet");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSet> {
        @Override
        public void serialize(UnionSet obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.setValue != null) {
                jsonGenerator.writeObject(obj.setValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
