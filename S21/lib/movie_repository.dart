import 'package:untitled3/person.dart';

import 'movie.dart';

class MovieRepository{

  static List<Movie> movie_list = [];
  static void InitList(){

    Person pr1 = Person('Brad Pitt', 'assets/brad.PNG', 'Derictor');
    Person pr2 = Person('Ethan Hawke', 'assets/ethan.webp', 'Actor');
    Person pr3 = Person('Johnny Depp', 'assets/john.webp', 'Actor');
    Person pr4 = Person('Keanu Reeves', 'assets/keanu.jpg', "Writer");
    Person pr5 = Person('Nicole Kidman', 'assets/nic.webp', 'Actress');
    Person pr6 = Person('Nick Offerman', 'assets/nick.webp', "Actor");
    Person pr7 = Person('Pedro pascal', 'assets/pedro.jpg', "Actor");
    Person pr8 = Person('Tom Cruise', 'assets/tom.jpg', "Actor");

    /**                  **/

    List<Person> _list1 = [];
    _list1.add(pr1);
    _list1.add(pr2);
    _list1.add(pr3);
    Movie movie1 = Movie('assets/bullet2.jpg', 'assets/bullet.jpg', 'Bullet train ', _list1);

    List<Person> _list2 = [];
    _list2.add(pr8);
    _list2.add(pr5);
    _list2.add(pr4);
    Movie movie2 = Movie('assets/topgun.webp', 'assets/top.jpg', 'Top gun ', _list2);

    List<Person> _list3 = [];
    _list3.add(pr7);
    _list3.add(pr6);
    _list3.add(pr4);
    Movie movie3 = Movie('assets/last.webp', 'assets/last2.jpg', 'The Last of us ', _list3);

    movie_list.add(movie1);
    movie_list.add(movie2);
    movie_list.add(movie3);

  }
}