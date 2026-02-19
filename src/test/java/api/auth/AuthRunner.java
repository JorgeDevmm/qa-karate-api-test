package api.auth;

import com.intuit.karate.junit5.Karate;

public class AuthRunner {

    @Karate.Test
    Karate testAuth() {
        return Karate.run("auth").relativeTo(getClass());
    }
}
