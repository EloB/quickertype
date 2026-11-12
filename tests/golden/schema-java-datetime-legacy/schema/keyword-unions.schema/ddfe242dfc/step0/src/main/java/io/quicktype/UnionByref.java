package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionByref.Deserializer.class)
@JsonSerialize(using = UnionByref.Serializer.class)
public class UnionByref {
    public Double doubleValue;
    public Byref byrefValue;

    static class Deserializer extends JsonDeserializer<UnionByref> {
        @Override
        public UnionByref deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionByref value = new UnionByref();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.byrefValue = jsonParser.readValueAs(Byref.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionByref");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionByref> {
        @Override
        public void serialize(UnionByref obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.byrefValue != null) {
                jsonGenerator.writeObject(obj.byrefValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
