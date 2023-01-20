package tevi.msa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    UserService userService;

    @PostMapping("/register")
    public ResponseEntity<User> add(@RequestBody User user) {
        try {
            userService.saveUser(user);
            return new ResponseEntity<User>(user, HttpStatus.OK);
        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<User>(HttpStatus.IM_USED);
        }
    }
}