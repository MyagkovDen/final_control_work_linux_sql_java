package Animals;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Animal {
    private int id;
    private String name;
    private List<String> commands;
    private LocalDate birthdate;

    public Animal(int id, String name, LocalDate birthdate) {
        this.id = id;
        this.name = name;
        this.commands = new ArrayList<>();
        this.birthdate = birthdate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getCommands() {
        return commands;
    }

    public void setCommands(List<String> commands) {
        this.commands = commands;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(LocalDate birthdate) {
        this.birthdate = birthdate;
    }
    public void addCommand (String command){
        this.commands.add(command);
    }

    @Override
    public String toString() {
        return "Animals.Animal{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", birthdate=" + birthdate +
                '}';
    }
}
