package pkgPmegpNew;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class LoginAttemptCache {
    
    // Thread-safe cache to store failed attempts
    private static final Map<String, Integer> failedAttempts = new ConcurrentHashMap<>();
    private static final Map<String, Long> lockedAccounts = new ConcurrentHashMap<>();
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    
    // Initialize the cleanup thread
    static {
        // Clean up locked accounts after 30 minutes
        scheduler.scheduleAtFixedRate(() -> {
            long now = System.currentTimeMillis();
            lockedAccounts.entrySet().removeIf(entry -> 
                (now - entry.getValue()) > TimeUnit.MINUTES.toMillis(30)
            );
        }, 30, 30, TimeUnit.MINUTES);
    }
    
    /**
     * Track a failed login attempt
     * @param username The username that failed to login
     * @param maxAttempts Maximum allowed attempts before locking
     * @param lockDuration Duration to lock the account in minutes
     * @return true if account is now locked, false otherwise
     */
    public static boolean trackFailedLogin(String username, int maxAttempts, int lockDuration) {
        if (isAccountLocked(username)) {
            return true; // Already locked
        }
        
        int attempts = failedAttempts.merge(username, 1, Integer::sum);
        
        if (attempts >= maxAttempts) {
            lockAccount(username, lockDuration);
            failedAttempts.remove(username); // Clean up failed attempts
            return true;
        }
        return false;
    }
    
    /**
     * Reset failed attempts on successful login
     */
    public static void resetFailedLogin(String username) {
        failedAttempts.remove(username);
        lockedAccounts.remove(username);
    }
    
    /**
     * Check if account is locked
     */
    public static boolean isAccountLocked(String username) {
        Long lockedUntil = lockedAccounts.get(username);
        if (lockedUntil != null) {
            if (System.currentTimeMillis() > lockedUntil) {
                // Lock expired
                lockedAccounts.remove(username);
                return false;
            }
            return true;
        }
        return false;
    }
    
    /**
     * Get remaining login attempts
     */
    public static int getRemainingAttempts(String username, int maxAttempts) {
        return maxAttempts - failedAttempts.getOrDefault(username, 0);
    }
    
    /**
     * Lock the account for specified duration
     */
    private static void lockAccount(String username, int lockDurationMinutes) {
        lockedAccounts.put(username, 
            System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(lockDurationMinutes)
        );
    }
    
    /**
     * Get time until account is unlocked (in minutes)
     * @return minutes until unlock, or 0 if not locked
     */
    public static long getTimeUntilUnlock(String username) {
        Long lockedUntil = lockedAccounts.get(username);
        if (lockedUntil != null) {
            long remaining = lockedUntil - System.currentTimeMillis();
            return remaining > 0 ? TimeUnit.MILLISECONDS.toMinutes(remaining) + 1 : 0;
        }
        return 0;
    }
    
    /**
     * Cleanup resources
     */
    public static void shutdown() {
        scheduler.shutdown();
    }
}