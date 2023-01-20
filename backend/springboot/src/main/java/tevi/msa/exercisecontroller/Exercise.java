package tevi.msa.exercisecontroller;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import tevi.msa.logscontroller.ExerciseLog;
import tevi.msa.usercontroller.User;

@Entity
@Table(name = "exercises")
public class Exercise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exerciseid")
    private int id;

    public void setId(int id) {
        this.id = id;
    }   

    public int getId() {
        return id;
    }

    @Column(name = "exercisename")
    private String exercisename;

    public String getExercisename() {
        return exercisename;
    }

    public void setExercisename(String exercisename) {
        this.exercisename = exercisename;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "userid", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
    User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @OneToMany(mappedBy = "exercise", fetch = FetchType.LAZY)
    List<ExerciseLog> logData;

    public List<ExerciseLog> getLogData() {
        return logData;
    }

    public void setLogData(List<ExerciseLog> logData) {
        this.logData = logData;
    }

    public Exercise() {
    }

    public Exercise(int id, String exercisename) {
        this.id = id;
        this.exercisename = exercisename;
    }

}