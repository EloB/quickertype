package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEqualityContract.Deserializer.class)
@JsonSerialize(using = UnionEqualityContract.Serializer.class)
public class UnionEqualityContract {
    public Double doubleValue;
    public EqualityContract equalityContractValue;

    static class Deserializer extends JsonDeserializer<UnionEqualityContract> {
        @Override
        public UnionEqualityContract deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEqualityContract value = new UnionEqualityContract();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.equalityContractValue = jsonParser.readValueAs(EqualityContract.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEqualityContract");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEqualityContract> {
        @Override
        public void serialize(UnionEqualityContract obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.equalityContractValue != null) {
                jsonGenerator.writeObject(obj.equalityContractValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
