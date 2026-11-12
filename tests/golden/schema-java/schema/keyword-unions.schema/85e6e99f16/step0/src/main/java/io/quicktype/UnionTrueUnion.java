package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTrueUnion.Deserializer.class)
@JsonSerialize(using = UnionTrueUnion.Serializer.class)
public class UnionTrueUnion {
    public Double doubleValue;
    public TrueClass trueClassValue;

    static class Deserializer extends JsonDeserializer<UnionTrueUnion> {
        @Override
        public UnionTrueUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTrueUnion value = new UnionTrueUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.trueClassValue = jsonParser.readValueAs(TrueClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTrueUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTrueUnion> {
        @Override
        public void serialize(UnionTrueUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.trueClassValue != null) {
                jsonGenerator.writeObject(obj.trueClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
