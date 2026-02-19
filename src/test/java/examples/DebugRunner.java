package examples;

import com.intuit.karate.junit5.Karate;

public class DebugRunner {

    @Karate.Test
    Karate debugTest() {
        return Karate.run("classpath:examples").tags("@debug").relativeTo(getClass());
    }
}
