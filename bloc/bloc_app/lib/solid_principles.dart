/// Solid Principles
//~ Single Responsibility Principle
//. A class should have one, and only one, reason to change.
//. A class should have only one job.
/* . Ex: ❌
  class UserManagement {
    authUser () {
      // Authenticate user
    }
    void addUser() {
      // Add user
    }

    void deleteUser() {
      // Delete user
    }

    void updateUser() {
      // Update user
    }
  }
✅
  class AuthUser {
    authUser () {
      // Authenticate user
    }
  }

  class ProfileManagement {
    void addUser() {
      // Add user
    }

    void deleteUser() {
      // Delete user
    }

    void updateUser() {
      // Update user
    }
  }
*/

//~ Open/Closed Principle
//. Software entities should be open for extension, but closed for modification.
//. You should be able to add new functionality to an object or method without altering its structure.
/* . Ex: ❌
  class Rectangle {
    double width;
    double height;
  }
  class Circle {
    double radius;
  }

  class AreaCalculator {
  if (shape is Rectangle) {
    double calculateRectangleArea(Rectangle rectangle) {
      return rectangle.width * rectangle.height;
    }
  } else if (shape is Circle) {
    double calculateCircleArea(Circle circle) {
      return 3.14 * circle.radius * circle.radius;
    }
  }
  }


✅
//. Abstract vs Interface
//. Abstract class can have both abstract and non-abstract methods.
//. Interface can only have abstract methods.
// .for example if a class has a method that is not common to all the classes that implement the interface, then it is better to use an abstract class.
  abstract interface class Shape {
    double area();
  }

  class Rectangle implements Shape {
    double width;
    double height;

    @override
    double area() {
      return width * height;
    }
  }

  class Circle implements Shape {
    double radius;

    @override
    double area() {
      return 3.14 * radius * radius;
    }
  }

  class AreaCalculator {
    double calculateArea(Shape shape) {
      return shape.area();
    }
  }
*/

//~ Liskov Substitution Principle
//. Objects of a superclass should be replaceable with objects of its subclasses without affecting the functionality of the program.
//. If S is a subtype of T, then objects of type T may be replaced with objects of type S without altering any of the desirable properties of the program.
//. to check if the class is following the LSP, by checking if the subclass is throwing an exception or not implementing the method of the superclass.
/* . Ex: ❌
  class Bird {
    void fly() {
      print('Bird is flying');
    }
  }

  /// here the the output of the ostrich will be different from the bird class which is not a good practice
  class Ostrich extends Bird {
    void fly() {
    super.fly();
      throw Exception('Ostrich cannot fly');
    }
  }

  class Sparrow extends Bird {
    void fly() {
      print('Sparrow is flying');
    }
  }

  void makeBirdFly(Bird bird) {
    bird.fly();
  }

✅
  class Bird {
    void fly() {
      print('Bird is flying');
    }
  }

  class Ostrich extends Bird {
    void fly() {
      throw Exception('Ostrich cannot fly');
    }
  }

  class Sparrow extends Bird {
    void fly() {
      print('Sparrow is flying');
    }
  }

  void makeBirdFly(Bird bird) {
    bird.fly();
  }
*/

//~ Interface Segregation Principle
//. A client should never be forced to implement an interface that it doesn’t use or clients shouldn’t be forced to depend on methods they do not use.
//. Instead of one fat interface, many small interfaces are preferred based on groups of methods, each one serving one submodule.
// . to check if the interface is following the ISP, by checking if empty methods are being implemented in the class that implements the interface.
/* . Ex: ❌
  abstract interface class Worker {
    void work() {
      // ....working
    }

    void eat() {
      //.... eating in launch break
    }
  }
  /// here the robot class will have to implement the eat method which is not necessary for the robot class

  class Robot implements Worker {
    void work() {
      // ....working
    }
  }

  class SuperWorker implements Worker {
    void work() {
      //.... working much more
    }

    void eat() {
      //.... eating in launch break
    }
  }

✅
  abstract interface class Workable {
    void work();
  }

  abstract interface class Feedable {
    void eat();
  }

  class Worker implements Workable, Feedable {
    void work() {
      // ....working
    }

    void eat() {
      //.... eating in launch break
    }
  }

  class Robot implements Workable {
    void work() {
      // ....working
    }
  }
*/

//~ Dependency Inversion Principle
//. High-level modules should not depend on low-level modules. Both should depend on abstractions.
//. Abstractions should not depend on details. Details should depend on abstractions.
//. analogy: Building a house, the house is the high-level module, and the bricks, cement, etc are the low-level modules, so the house should not depend on the bricks, cement, etc like if you want to change the bricks with wood, you should be able to do it without changing the house.
/* . Ex: ❌
// Low-level module
  class LightBulb {
    void turnOn() {
      print('LightBulb: turned on...');
    }

    void turnOff() {
      print('LightBulb: turned off...');
    }
  }
  // here i i want to chnage the ligth bulb to a led bulb i will have to change the room class
  // High-level module
  class Room {
    LightBulb bulb;
    Room (this.bulb);

    void SwitchLigthOn() {
        bulb.turnOn();
    }
    void SwitchLigthOff() {
        bulb.turnOff();
    }
  }

✅

  abstract interface class Bulb {
    void turnOn();
    void turnOff();
  }

  class LightBulb implements Bulb {
    void turnOn() {
      print('LightBulb: turned on...');
    }

    void turnOff() {
      print('LightBulb: turned off...');
    }
  }

  class LedBulb implements Bulb {
    void turnOn() {
      print('LedBulb: turned on...');
    }

    void turnOff() {
      print('LedBulb: turned off...');
    }
  }

  class Room {
    Bulb bulb;
    Room (this.bulb);

    void SwitchLigthOn() {
        bulb.turnOn();
    }
    void SwitchLigthOff() {
        bulb.turnOff();
    }
  }

*/
