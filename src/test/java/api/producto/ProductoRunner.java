package api.producto;

import com.intuit.karate.junit5.Karate;

public class ProductoRunner {

    @Karate.Test
    Karate testProducto() {
        return Karate.run("producto").relativeTo(getClass());
    }


}
