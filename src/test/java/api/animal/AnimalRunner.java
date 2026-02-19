package api.animal;

import com.intuit.karate.junit5.Karate;

public class AnimalRunner {

    @Karate.Test
    Karate testAnimal() {
        return Karate.run("animal").relativeTo(getClass());
    }
}
