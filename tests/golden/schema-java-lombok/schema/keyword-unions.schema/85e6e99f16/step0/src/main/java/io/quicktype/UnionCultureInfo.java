package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCultureInfo.Deserializer.class)
@JsonSerialize(using = UnionCultureInfo.Serializer.class)
public class UnionCultureInfo {
    public Double doubleValue;
    public CultureInfo cultureInfoValue;

    static class Deserializer extends JsonDeserializer<UnionCultureInfo> {
        @Override
        public UnionCultureInfo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCultureInfo value = new UnionCultureInfo();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.cultureInfoValue = jsonParser.readValueAs(CultureInfo.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCultureInfo");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCultureInfo> {
        @Override
        public void serialize(UnionCultureInfo obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.cultureInfoValue != null) {
                jsonGenerator.writeObject(obj.cultureInfoValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
