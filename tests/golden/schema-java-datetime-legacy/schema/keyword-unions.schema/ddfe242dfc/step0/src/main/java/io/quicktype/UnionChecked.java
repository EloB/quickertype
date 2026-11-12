package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionChecked.Deserializer.class)
@JsonSerialize(using = UnionChecked.Serializer.class)
public class UnionChecked {
    public Double doubleValue;
    public Checked checkedValue;

    static class Deserializer extends JsonDeserializer<UnionChecked> {
        @Override
        public UnionChecked deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionChecked value = new UnionChecked();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.checkedValue = jsonParser.readValueAs(Checked.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionChecked");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionChecked> {
        @Override
        public void serialize(UnionChecked obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.checkedValue != null) {
                jsonGenerator.writeObject(obj.checkedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
