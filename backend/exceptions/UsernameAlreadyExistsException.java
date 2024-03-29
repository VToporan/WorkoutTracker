package org.loose.WorkoutTracker.exceptions;

public class UsernameAlreadyExistsException extends Exception {

    private String username;

    public UsernameAlreadyExistsException(String username) {
        super(String.format("This username: %s , is already in use!", username));
        this.username = username;
    }

    public String getUsername() {
        return username;
    }
}