package org.loose.WorkoutTracker.exceptions;

public class InvalidCredentialsException extends Exception {
    public InvalidCredentialsException()
    {
        super(String.format("Invalid credentials, please try again!"));
    }
}
