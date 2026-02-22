package api;

import com.intuit.karate.junit5.Karate;

public class DebugRunner {

    @Karate.Test
    Karate debugTest() {
        return Karate.run("classpath:api").tags("@ActualizarParcialmenteAnimal").relativeTo(getClass());
    }
}
