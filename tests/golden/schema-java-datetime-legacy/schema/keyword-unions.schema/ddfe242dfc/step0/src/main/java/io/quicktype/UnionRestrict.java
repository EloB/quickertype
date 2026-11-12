package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRestrict.Deserializer.class)
@JsonSerialize(using = UnionRestrict.Serializer.class)
public class UnionRestrict {
    public Double doubleValue;
    public Restrict restrictValue;

    static class Deserializer extends JsonDeserializer<UnionRestrict> {
        @Override
        public UnionRestrict deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRestrict value = new UnionRestrict();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.restrictValue = jsonParser.readValueAs(Restrict.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRestrict");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRestrict> {
        @Override
        public void serialize(UnionRestrict obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.restrictValue != null) {
                jsonGenerator.writeObject(obj.restrictValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
