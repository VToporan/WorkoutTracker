package org.loose.WorkoutTracker.controllers;

import org.loose.WorkoutTracker.exceptions.UsernameAlreadyExistsException;
import org.loose.WorkoutTracker.exceptions.InvalidCredentialsException;
import org.loose.WorkoutTracker.services.UserService;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class LoginController {
    @FXML
    private Text loginMessage;
    @FXML
    private PasswordField passwordField;
    @FXML
    private TextField usernameField;

    @FXML
    public void handleLoginAction() throws Exception {
        Stage primaryStage=(Stage)loginMessage.getScene().getWindow();
        try {

            UserService.verifyLogin(usernameField.getText(),passwordField.getText());
            String rol=(String)role.getValue();

            Parent root = FXMLLoader.load(getClass().getClassLoader().getResource("Home.fxml"));
            primaryStage.setTitle("Home");
            primaryStage.setScene(new Scene(root, 1050, 600));
            primaryStage.show();

        }catch(InvalidCredentialsException e) {
            loginMessage.setText(e.getMessage());
        }
    }
    @FXML
    public void handleRedirectRegisterAction() throws Exception{
        Stage primaryStage=(Stage)loginMessage.getScene().getWindow();
        Parent root = FXMLLoader.load(getClass().getClassLoader().getResource("register.fxml"));
        primaryStage.setTitle("Register");
        primaryStage.setScene(new Scene(root, 400, 300));
        primaryStage.show();
    }
}
