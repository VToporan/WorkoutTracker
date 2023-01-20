package tevi.msa.exercisecontroller;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
@Service
@Transactional
public class ExerciseService {
    @Autowired
    private ExerciseRepository ExerciseRepository;
    public List<Exercise> listAllExercise() {
        return ExerciseRepository.findAll();
    }

    public void saveExercise(Exercise Exercise) {
        ExerciseRepository.save(Exercise);
    }

    public void deleteExercise(Integer id) {
        ExerciseRepository.deleteById(id);
    }
}