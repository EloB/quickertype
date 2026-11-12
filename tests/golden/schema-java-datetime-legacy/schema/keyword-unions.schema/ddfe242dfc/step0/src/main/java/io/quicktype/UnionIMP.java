package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIMP.Deserializer.class)
@JsonSerialize(using = UnionIMP.Serializer.class)
public class UnionIMP {
    public Double doubleValue;
    public Imp impValue;

    static class Deserializer extends JsonDeserializer<UnionIMP> {
        @Override
        public UnionIMP deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIMP value = new UnionIMP();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.impValue = jsonParser.readValueAs(Imp.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIMP");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIMP> {
        @Override
        public void serialize(UnionIMP obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.impValue != null) {
                jsonGenerator.writeObject(obj.impValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
