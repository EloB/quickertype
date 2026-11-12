package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLocale.Deserializer.class)
@JsonSerialize(using = UnionLocale.Serializer.class)
public class UnionLocale {
    public Double doubleValue;
    public Locale localeValue;

    static class Deserializer extends JsonDeserializer<UnionLocale> {
        @Override
        public UnionLocale deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLocale value = new UnionLocale();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.localeValue = jsonParser.readValueAs(Locale.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLocale");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLocale> {
        @Override
        public void serialize(UnionLocale obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.localeValue != null) {
                jsonGenerator.writeObject(obj.localeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
