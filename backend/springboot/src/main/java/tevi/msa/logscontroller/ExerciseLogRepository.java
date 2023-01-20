package tevi.msa.logscontroller;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExerciseLogRepository extends JpaRepository<ExerciseLog, Integer>{
    List<ExerciseLog> findByExerciseId(int exerciseid);
}
