package api;

import com.intuit.karate.junit5.Karate;

public class TagRunner {

    @Karate.Test
    Karate smokeTest() {
        return Karate.run("classpath:api").tags("@Smoke").relativeTo(getClass());
    }


    @Karate.Test
    Karate regressionTest() {
        return Karate.run("classpath:api").tags("@Regression").relativeTo(getClass());
    }
}
