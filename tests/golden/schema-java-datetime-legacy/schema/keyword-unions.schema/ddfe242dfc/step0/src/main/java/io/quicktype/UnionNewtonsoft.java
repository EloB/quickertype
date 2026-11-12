package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNewtonsoft.Deserializer.class)
@JsonSerialize(using = UnionNewtonsoft.Serializer.class)
public class UnionNewtonsoft {
    public Double doubleValue;
    public Newtonsoft newtonsoftValue;

    static class Deserializer extends JsonDeserializer<UnionNewtonsoft> {
        @Override
        public UnionNewtonsoft deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNewtonsoft value = new UnionNewtonsoft();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.newtonsoftValue = jsonParser.readValueAs(Newtonsoft.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNewtonsoft");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNewtonsoft> {
        @Override
        public void serialize(UnionNewtonsoft obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.newtonsoftValue != null) {
                jsonGenerator.writeObject(obj.newtonsoftValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
