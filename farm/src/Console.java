import Animals.Animal;

import java.util.List;
import java.util.Scanner;

public class Console {
    Service service;

    public Console() {
        this.service = new Service();
    }

    public void start() {
        try (Scanner iScanner = new Scanner(System.in)) {
            while (true) {
                System.out.println("Выберите действие:\n" +
                        "1 - добавить новое животное\n" +
                        "2 - посмотреть список команд\n" +
                        "3 - обучить животное новым командам\n" +
                        "4 - посмотреть список животных\n" +
                        "5 - выйти из приложения");
                int input = Integer.parseInt(iScanner.nextLine());
                switch (input) {
                    case 1:
                        addAnimalChoice(iScanner);
                        break;
                    case 2:
                        showCommandsChoice(iScanner);
                        break;
                    case 3:
                        addCommandChoice(iScanner);
                        break;
                    case 4:
                        System.out.println(getRegistry());
                        break;
                    case 5:
                        iScanner.close();
                        return;
                }
            }
        } catch (Exception e){
            System.out.println("Ошибка ввода! " + e.getMessage());
        }
    }
    private void addAnimalChoice(Scanner iScanner) {
        System.out.println("Введите вид животного:\n" +
                "1 - собака;\n" +
                "2 - кошка;\n" +
                "3 - хомяк;\n" +
                "4 - лошадь;\n" +
                "5 - осёл;\n"
    //            +"6 - верблюд;"
                );
        int species = Integer.parseInt(iScanner.nextLine());
        System.out.println("Введите имя животного: ");
        String name = iScanner.nextLine();
        int[] birthdate = new int[3];
        System.out.println("Введите год рождения: ");
        birthdate[0] = Integer.parseInt(iScanner.nextLine());
        System.out.println("Введите месяц рождения: ");
        birthdate[1] = Integer.parseInt(iScanner.nextLine());
        System.out.println("Введите день рождения: ");
        birthdate[2] = Integer.parseInt(iScanner.nextLine());
        service.addAnimal(species, name, birthdate);
        System.out.println("Животное добавлено");
    }

    private void showCommandsChoice(Scanner iScanner) {
        System.out.println("Введите id животного: ");
        int animalId = Integer.parseInt(iScanner.nextLine());
        System.out.println(service.showCommands(animalId));
    }

    private void addCommandChoice(Scanner iScanner) {
        System.out.println("Введите id животного: ");
        int animalId = Integer.parseInt(iScanner.nextLine());
        System.out.println("Введите команду: ");
        String command = iScanner.nextLine();
        service.addNewCommand(animalId, command);
        System.out.println("Команда добавлена");
    }
    private List<Animal> getRegistry(){
        return service.getRegistry();
    }
}
