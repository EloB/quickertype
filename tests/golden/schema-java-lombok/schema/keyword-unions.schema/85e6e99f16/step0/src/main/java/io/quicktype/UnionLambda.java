package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLambda.Deserializer.class)
@JsonSerialize(using = UnionLambda.Serializer.class)
public class UnionLambda {
    public Double doubleValue;
    public Lambda lambdaValue;

    static class Deserializer extends JsonDeserializer<UnionLambda> {
        @Override
        public UnionLambda deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLambda value = new UnionLambda();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.lambdaValue = jsonParser.readValueAs(Lambda.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLambda");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLambda> {
        @Override
        public void serialize(UnionLambda obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.lambdaValue != null) {
                jsonGenerator.writeObject(obj.lambdaValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
