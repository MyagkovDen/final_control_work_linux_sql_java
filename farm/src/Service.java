import Animals.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Service {
    private Counter counter;
    private List<Animal> registry;

    public Service() {
        this.counter = new Counter();
        this.registry = new ArrayList<>();
    }

    public void addAnimal(int number, String name, int[] birthdate){
        switch(number){
            case 1:
                registry.add(new Dog(counter.add(), name, LocalDate.of(birthdate[0],
                        birthdate[1], birthdate[2])));
                break;
            case 2:
                registry.add(new Cat(counter.add(), name, LocalDate.of(birthdate[0],
                        birthdate[1], birthdate[2])));
                break;
            case 3:
                registry.add(new Hamster(counter.add(), name, LocalDate.of(birthdate[0],
                        birthdate[1], birthdate[2])));
                break;
            case 4:
                registry.add(new Horse(counter.add(), name, LocalDate.of(birthdate[0],
                        birthdate[1], birthdate[2])));
                break;
            case 5:
                registry.add(new Donkey(counter.add(), name, LocalDate.of(birthdate[0],
                        birthdate[1], birthdate[2])));
                break;
//            case 6:
//                registry.add(new Animals.Camel(id++, name, LocalDate.of(birthdate[0],
//                        birthdate[1], birthdate[2])));
//                break;
        }
    }
    public List<String> showCommands(int number){
        return registry.get(number-1).getCommands();
    }

    public void addNewCommand(int number, String newCommand){
        registry.get(number-1).addCommand(newCommand);
    }

    public List<Animal> getRegistry() {
        return registry;
    }
}
