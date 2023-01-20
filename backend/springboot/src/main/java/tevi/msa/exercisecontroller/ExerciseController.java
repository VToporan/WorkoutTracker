package tevi.msa.exercisecontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tevi.msa.logscontroller.ExerciseLog;
import tevi.msa.logscontroller.ExerciseLogService;
import tevi.msa.usercontroller.User;
import tevi.msa.usercontroller.UserService;

import java.util.List;

@RestController
@RequestMapping("/exercises")
public class ExerciseController {
    @Autowired
    ExerciseLogService exerciseLogService;
    @Autowired
    ExerciseService exerciseService;
    @Autowired
    UserService userService;

    @PostMapping("/{userid}/add")
    public ResponseEntity<Exercise> add(@PathVariable(value = "userid") int userid, @RequestBody Exercise exercise) {
        try {
            User user = userService.getUser(userid);
            if (user == null) {
                throw new Exception("");
            }

            exercise.setUser(user);
            exerciseService.saveExercise(exercise);
            return new ResponseEntity<Exercise>(exercise, HttpStatus.OK);

        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<Exercise>(HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            return new ResponseEntity<Exercise>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/{userid}") 
    public ResponseEntity<List<Exercise>> getAll(@PathVariable(value = "userid") int userid) {
        try {
            User user = userService.getUser(userid);
            if (user == null) {
                throw new Exception("");
            }

            List<Exercise> allExercise = exerciseService.listAllExercise(userid);
            for (Exercise exercise : allExercise) {
                List<ExerciseLog> logData = exerciseLogService.listAllExerciseLogs(exercise.getId());
                exercise.setLogData(logData);
            }
            return new ResponseEntity<List<Exercise>>(allExercise, HttpStatus.OK);

        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<List<Exercise>>(HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            return new ResponseEntity<List<Exercise>>(HttpStatus.CONFLICT);
        }
    }

    @DeleteMapping("/delete/{exerciseid}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable(value = "exerciseid") int exerciseidid) {
        exerciseService.deleteExercise(exerciseidid);
    }
}
