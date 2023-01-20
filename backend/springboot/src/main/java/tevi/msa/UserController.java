package tevi.msa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    UserService userService;

    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody User user) {
        try {
            userService.saveUser(user);
            return new ResponseEntity<User>(user, HttpStatus.OK);
        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<User>(HttpStatus.IM_USED);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<User> login(@RequestBody User user) {
        try {
            User existingUser = userService.getUser(user.getUsername());
            if (existingUser == null) {
                throw new DataIntegrityViolationException("No such user");

            }
            if (! existingUser.getPassword().equals((Object) user.getPassword())) {
                throw new DataIntegrityViolationException("Password doesn't match");
            }
            return new ResponseEntity<User>(existingUser, HttpStatus.OK); 
            
        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<User>(HttpStatus.BAD_REQUEST);
        }
    }
}