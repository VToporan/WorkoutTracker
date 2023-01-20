package tevi.msa.logscontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tevi.msa.exercisecontroller.Exercise;
import tevi.msa.exercisecontroller.ExerciseService;

import java.util.List;

@RestController
@RequestMapping("/logs")
public class ExerciseLogController {
    @Autowired
    ExerciseService exerciseService;
    @Autowired
    ExerciseLogService exerciseLogService;

    @PostMapping("/{exerciseid}/add")
    public ResponseEntity<ExerciseLog> add(@PathVariable(value = "exerciseid") int exerciseid, @RequestBody ExerciseLog exerciseLog) {
        try {
            Exercise exercise = exerciseService.getExercise(exerciseid);
            if (exercise == null) {
                throw new Exception("");
            }

            exerciseLog.setExercise(exercise);
            exerciseLogService.saveExerciseLog(exerciseLog);
            return new ResponseEntity<ExerciseLog>(exerciseLog, HttpStatus.OK);

        } catch (DataIntegrityViolationException e) {
            return new ResponseEntity<ExerciseLog>(HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            return new ResponseEntity<ExerciseLog>(HttpStatus.CONFLICT);
        }
    }

    @DeleteMapping("/delete/{logid}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable(value = "logid") int logid) {
        exerciseLogService.deleteExerciseLog(logid);
    }
}
