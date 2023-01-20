package tevi.msa.exercisecontroller;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
@Service
@Transactional
public class ExerciseService {
    @Autowired
    private ExerciseRepository exerciseRepository;
    public List<Exercise> listAllExercise(int userid) {
        return exerciseRepository.findByUserId(userid);
    }

    public void saveExercise(Exercise Exercise) {
        exerciseRepository.save(Exercise);
    }

    public void deleteExercise(Integer id) {
        exerciseRepository.deleteById(id);
    }

    public Exercise getExercise(Integer id) {
        return exerciseRepository.findById(id).get();
    }
}