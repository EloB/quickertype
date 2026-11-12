package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionString.Deserializer.class)
@JsonSerialize(using = UnionString.Serializer.class)
public class UnionString {
    public Double doubleValue;
    public StringClass stringClassValue;

    static class Deserializer extends JsonDeserializer<UnionString> {
        @Override
        public UnionString deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionString value = new UnionString();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.stringClassValue = jsonParser.readValueAs(StringClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionString");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionString> {
        @Override
        public void serialize(UnionString obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stringClassValue != null) {
                jsonGenerator.writeObject(obj.stringClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
