package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionImplicit.Deserializer.class)
@JsonSerialize(using = UnionImplicit.Serializer.class)
public class UnionImplicit {
    public Double doubleValue;
    public Implicit implicitValue;

    static class Deserializer extends JsonDeserializer<UnionImplicit> {
        @Override
        public UnionImplicit deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionImplicit value = new UnionImplicit();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.implicitValue = jsonParser.readValueAs(Implicit.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionImplicit");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionImplicit> {
        @Override
        public void serialize(UnionImplicit obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.implicitValue != null) {
                jsonGenerator.writeObject(obj.implicitValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
