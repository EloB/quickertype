package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionList.Deserializer.class)
@JsonSerialize(using = UnionList.Serializer.class)
public class UnionList {
    public Double doubleValue;
    public ListClass listClassValue;

    static class Deserializer extends JsonDeserializer<UnionList> {
        @Override
        public UnionList deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionList value = new UnionList();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.listClassValue = jsonParser.readValueAs(ListClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionList");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionList> {
        @Override
        public void serialize(UnionList obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.listClassValue != null) {
                jsonGenerator.writeObject(obj.listClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
