package tevi.msa.logscontroller;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
@Service
@Transactional
public class ExerciseLogService {
    @Autowired
    private ExerciseLogRepository exerciseLogRepository;
    public List<ExerciseLog> listAllExerciseLogs(int exerciseid) {
        return exerciseLogRepository.findByExerciseId(exerciseid);
    }

    public void saveExerciseLog(ExerciseLog exerciseLog) {
        exerciseLogRepository.save(exerciseLog);
    }

    public void deleteExerciseLog(Integer id) {
        exerciseLogRepository.deleteById(id);
    }
}