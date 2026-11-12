package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSelect.Deserializer.class)
@JsonSerialize(using = UnionSelect.Serializer.class)
public class UnionSelect {
    public Double doubleValue;
    public Select selectValue;

    static class Deserializer extends JsonDeserializer<UnionSelect> {
        @Override
        public UnionSelect deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSelect value = new UnionSelect();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.selectValue = jsonParser.readValueAs(Select.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSelect");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSelect> {
        @Override
        public void serialize(UnionSelect obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.selectValue != null) {
                jsonGenerator.writeObject(obj.selectValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
