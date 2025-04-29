@Service
public class LoginAttemptService {
    private final int MAX_ATTEMPTS = 3;
    private Map<String, Integer> attemptsCache = new ConcurrentHashMap<>();

    public void loginFailed(String key) {
        int attempts = attemptsCache.getOrDefault(key, 0);
        attemptsCache.put(key, attempts + 1);
    }

    public boolean isBlocked(String key) {
        return attemptsCache.getOrDefault(key, 0) >= MAX_ATTEMPTS;
    }

    public void loginSuccess(String key) {
        attemptsCache.remove(key);
    }
}