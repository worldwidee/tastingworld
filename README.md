# tastingworld
Website: The purpose of this site is to find out which restaurant is better in various food categories by people's votes. Users can view, post comment and vote for the best restaurants in any type of food.

The purpose of this web site is how to develop an application using java springboot & MySQL in the backend part

# 1- Creating database tables and mapping its relationship each other
You’ll learn how to map a (many-to-many with extra columns) database relationship at the object level using JPA and Hibernate.

Consider the following four tables - user, food, comment and rate of a Tastingworld database schema where the users table has a many-to-many relationship with the comment&rate tables and same for foods table.

When an extra column is entered in many-to-many relationship, the relationship of the common table with other tables is converted to many-to-one

<p align="center">
<img width=800 src="https://raw.githubusercontent.com/worldwidee/files/main/tastingworld_diagram.JPG"> 
</p>

### Create MySQL Database
```
CREATE DATABASE db_name;
```
### Create User Table
```
USE tastingworld;
CREATE TABLE User (
    id int NOT NULL AUTO_INCREMENT,
    username varchar(255),
    password varchar(255),
    name varchar(255),
    surname varchar(255),
    created_at datetime,
    updated_at datetime,
    PRIMARY KEY (id)
);
```
### Create Food Table
```
USE tastingworld;
CREATE TABLE Food (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    imageUrl varchar(255),
    originCountry varchar(255),
    restaurant varchar(255),
    description text,
    category varchar(255),
    PRIMARY KEY (id)
);
```
### Create Comment Table
```
USE tastingworld;
CREATE TABLE Comment (
    id INT NOT NULL AUTO_INCREMENT,
    created_at datetime,
    updated_at datetime,
    user_id int NOT NULL,
    food_id int NOT NULL,
    comment text,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (food_id) REFERENCES food(id)
);
```
### Create Rate Table
```
USE tastingworld;
CREATE TABLE Rate  (
    id INT NOT NULL AUTO_INCREMENT,
    created_at datetime,
    updated_at datetime,
    user_id int NOT NULL,
    food_id int NOT NULL,
    rate float,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (food_id) REFERENCES food(id)
); 
```
# 2- Creating project

You can generate the project from Spring Initializer web tool by following the instructions below:

- Go to http://start.spring.io
- Select `Maven` in the `Project` section.
- Select your jdk version in the `Java` part
- Change Package Name to `com.example.tastingworld`
- Select `Spring Web`, `MySQL Driver`, `Spring Data JPA`, `Validation` dependencies.
- Click Generate to download the project.

Following is the directory structure of the project for your reference.
<p align="center">
<img width=800 src="https://raw.githubusercontent.com/worldwidee/files/main/testingworld-directory-structure.JPG"> 
</p>

# 3- Configuring the Database and Logging

Since we’re using MySQL as our database, we need to configure the database URL, username, and password so that Spring can establish a connection with the database on startup. Open `src/main/resources/application.properties` file and add the following properties to it.


```
spring.jpa.hibernate.ddl-auto=none
spring.datasource.url=jdbc:mysql://localhost:3306/tastingworld
spring.datasource.username=root
spring.datasource.password=password
```

# 4- Defining the Models

In this section, we’ll define the models - `User`, `Food`, `Comment`, `Rate`.

`User`, `Comment`, `Rate` entities contain some common auditing related fields like created_at and updated_at.

We’ll abstract out these common fields in a separate class called AuditModel and extend this class in the `User`, `Comment`, `Rate` entities.

We’ll also use Spring Boot’s JPA Auditing feature to automatically populate the `created_at` and `updated_at` fields while persisting the entities.

## 1- Audit Model

In the below class, we’re using Spring Boot’s AuditingEntityListener to automatically populate the createdAt and updatedAt fields.

```java
package com.example.tastingworld.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.util.Date;

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(
        value = {"createdAt", "updatedAt"},
        allowGetters = true
)
public abstract class AuditModel implements Serializable {
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", updatable = false)
    @CreatedDate
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    @LastModifiedDate
    private Date updatedAt;

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
```

## Enabling JPA Auditing

To enable JPA Auditing, you’ll need to add `@EnableJpaAuditing` annotation to one of your configuration classes. Open the main class `Application.java` and add the `@EnableJpaAuditing` to the main class like so
```java
package com.example.tastingworld;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class Application {


	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
```

## 2- User Model

```java
package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

import java.util.*;

@Entity
@Table(name = "user")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class User extends AuditModel{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String surname;

    @OneToMany(mappedBy = "user")
    private Set<Comment> comments;

    @OneToMany(mappedBy = "user")
    private Set<Rate> rates;
    public User() {
    }
    static public User fromMap(Map<String, String> map){

        String username=map.get("username");
        String password=map.get("password");
        String name=map.get("name");
        String surname=map.get("surname");
        if(map.get("id")==null){

            return new User(username,password,name,surname);
        }else{

            return new User(Integer.parseInt(map.get("id")),username,password,name,surname);
        }
    }
    public User(Integer id, String username, String password, String name, String surname) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.surname = surname;
    }

    public User(String username, String password, String name, String surname) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.surname = surname;
    }
    public Integer getId() {
        return id;
    }

    public String getUsername() {
         return username;
    }

    public String viewPassword() {
        return password;
    }

    public String getName() {
        return name;
    }
    public String getSurname() {
        return surname;
    }

    public void setComments(Set<Comment>comments){
        this.comments=comments;
    }
    public void setRates(Set<Rate> rates){
        this.rates=rates;
    }
}
```

## 3- Food Model

```java
package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

import java.util.*;

@Entity
@Table(name = "food")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Food {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name="imageurl")
    private String imageUrl;
    @Column(name="origincountry")
    private String originCountry;
    private String restaurant;
    private String description;
    private String category;
    @OneToMany(mappedBy = "food")
    private Set<Comment> comments;

    @OneToMany(mappedBy = "food")
    private Set<Rate> rates;

    private String name;

    public Food() {
    }

    static public Food fromMap(Map<String, String> map){

        String name=map.get("name");
        String imageUrl=map.get("imageUrl");
        String originCountry=map.get("originCountry");
        String restaurant=map.get("restaurant");
        String description=map.get("description");
        String category=map.get("category");
        Food food= new Food(name,imageUrl,originCountry,restaurant,description,category);
        if(map.get("id")==null) {
            food.setId(Integer.parseInt(map.get("id")));
        }
        return food;
    }

    public Food(Integer id,String name, String imageUrl, String originCountry, String restaurant, String description, String category) {
        this.id = id;
        this.name=name;
        this.originCountry = originCountry;
        this.imageUrl = imageUrl;
        this.restaurant = restaurant;
        this.description = description;
        this.category = category;
    }
    public Food(String name,String imageUrl, String originCountry, String restaurant, String description, String category) {
        this.name= name;
        this.originCountry = originCountry;
        this.imageUrl = imageUrl;
        this.restaurant = restaurant;
        this.description = description;
        this.category = category;
    }


    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }
    public String getOriginCountry() {
        return originCountry;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public String getRestaurant() {
        return restaurant;
    }
    public String getDescription() {
        return description;
    }
    public String getCategory() {
        return category;
    }

    public List<Map> getComments(){
        List<Map> list= new ArrayList<>();
        for(Comment comment:comments){
            Map map=new HashMap();
            User user=comment.viewUser();
            map.put("id",id);
            map.put("user_id",comment.getUserId());
            map.put("food_id",comment.getFoodId());
            map.put("comment",comment.getComment());
            map.put("username",user.getUsername());
            map.put("name",user.getName());
            map.put("surname",user.getSurname());
            map.put("createdAt",comment.getCreatedAt());
            map.put("updatedAt",comment.getUpdatedAt());
            list.add(map);
        }
        return list;
    }
    public String getAvarageRate(){
        float total=0;
        for(Rate rate : rates){
            total+=rate.getRate();
        }
        return rates.isEmpty()?"unknown":String.format("%.1f", total/rates.size());
    }
    public Integer getRateCount(){
        return rates.size();
    }
    public void setComments(Set<Comment>comments){
        this.comments=comments;
    }
    public void setId(Integer id){
        this.id=id;
    }

}
```
## 4- Comment Model

```java
package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

@Entity
@Table(name = "comment")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Comment extends AuditModel{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "food_id")
    private Food food;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private String comment;
    public Comment(){}

    public Comment(Integer id,String comment){
        this.id=id;
        this.comment=comment;
    }
    public Comment(String comment){
        this.comment=comment;
    }

    public void setFood(Food food){
        this.food=food;
    }
    public void setUser(User user){
        this.user=user;
    }
    public Integer getId(){
        return id;
    }
    public Integer getFoodId(){
        return food.getId();
    }
    public Integer getUserId(){
        return user.getId();
    }
    public Food viewFood(){
        return food;
    }
    public User viewUser(){
        return user;
    }
    public String getComment(){
        return comment;
    }

    public void setComment(String comment){
        this.comment=comment;
    }

}

```
## 5- Rate Model

```java
package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

@Entity
@Table(name = "rate")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Rate extends AuditModel{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "food_id")
    private Food food;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private float rate;
    public Rate(){}

    public Rate(Integer id,float rate){
        this.id=id;
        this.rate=rate;
    }
    public Rate(float rate){
        this.rate=rate;
    }

    public void setFood(Food food){
        this.food=food;
    }
    public void setUser(User user){
        this.user=user;
    }
    public Integer getId(){
        return id;
    }
    public Integer getFoodId(){
        return food.getId();
    }
    public Integer getUserId(){
        return user.getId();
    }
    public float getRate(){
        return rate;
    }

    public void setRate(float rate){
        this.rate=rate;
    }

}

```

# 5- Defining the Repositories
Next, We’ll define the repositories for accessing the data from the database. Create a new package called `repository` inside `com.example.tastingworld` package and add the following interfaces inside the `repository` package -

## 1- User Repository

```java
package com.example.tastingworld.repositories;
import com.example.tastingworld.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Integer> {
    @Query(value = "SELECT * FROM user WHERE name=? LIMIT 1",nativeQuery = true)
    public User findByName(String name);
}
```
## 2- Food Repository

```java
package com.example.tastingworld.repositories;
import com.example.tastingworld.models.Food;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface FoodRepository extends JpaRepository<Food, Integer> {
    @Query(value = "SELECT * FROM food WHERE category=?",nativeQuery = true)
    public List<Food> findListByCategory(String category);
    @Query(value = "SELECT * FROM food WHERE originCountry=?",nativeQuery = true)
    public List<Food> findListByOriginCountry(String originCountry);

    @Query(value = "SELECT * FROM food WHERE name=? LIMIT 1",nativeQuery = true)
    public Food findByName(String name);
}
```
## 3- Comment Repository

```java
package com.example.tastingworld.repositories;
import com.example.tastingworld.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
    @Query(value = "SELECT * FROM comment WHERE food_id=?",nativeQuery = true)
    public List<Comment> findByFoodId(Integer food_id);
    @Query(value = "SELECT * FROM comment WHERE user_id=?",nativeQuery = true)
    public List<Comment> findByUserId(Integer user_id);
    @Query(value = "SELECT EXISTS(SELECT * FROM comment WHERE user_id=? AND food_id=?)",nativeQuery = true)
    public int checkIfFoodHasCommentByUser(Integer user_id,Integer food_id);
    @Query(value = "SELECT * FROM comment WHERE user_id=? AND food_id=?",nativeQuery = true)
    public List<Comment> checkUserCommentsOfFood(Integer user_id,Integer food_id);
}
```
## 4- Rate Repository

```java
package com.example.tastingworld.repositories;
import com.example.tastingworld.models.Rate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface RateRepository extends JpaRepository<Rate, Integer> {
    @Query(value = "SELECT * FROM rate WHERE food_id=?",nativeQuery = true)
    public List<Rate> findByFoodId(Integer food_id);
    @Query(value = "SELECT * FROM rate WHERE user_id=?",nativeQuery = true)
    public List<Rate> findByUserId(Integer user_id);
    @Query(value = "SELECT EXISTS(SELECT * FROM rate WHERE user_id=? AND food_id=?)",nativeQuery = true)
    public int checkIfFoodRatedByUser(Integer user_id,Integer food_id);
    @Query(value = "SELECT * FROM rate WHERE user_id=? AND food_id=?",nativeQuery = true)
    public Rate checkWhatUserRated(Integer user_id,Integer food_id);
}
```

# 6- Writing the REST APIs to perform CRUD operations on the entities
Let’s now write the REST APIs to perform CRUD operations on Post and Comment entities.

All the following controller classes are define inside `com.example.tastingworld.controller` package.


## 1- User Controller

```java
package com.example.tastingworld.controllers;
import java.util.*;

import com.example.tastingworld.models.Comment;
import com.example.tastingworld.models.User;
import com.example.tastingworld.services.CommentService;
import com.example.tastingworld.services.UserService;
import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {

    @Autowired
    private UserService service;
    @Autowired
    private CommentService commentService;
    @GetMapping("/users")
    public List<User> getList() {
        return service.listAll();
    }
    @GetMapping("/users/{id}")
    public User getById(@PathVariable("id") String id) {
        return service.find(Integer.parseInt(id));
    }
    @GetMapping("/users/{id}/comments")
    public List<Comment> getCommentsById(@PathVariable("id") String id) {
        return commentService.findCommentListByUser(Integer.parseInt(id));
    }
    @GetMapping("/users/{id}/foods/{food_id}/isCommentExist")
    public boolean checkIfFoodHasCommentByUser(@PathVariable("id") String id,@PathVariable("food_id") String food_id) {
        return commentService.checkIfFoodHasCommentByUser(Integer.parseInt(id),Integer.parseInt(food_id));
    }
    @GetMapping("/users/{id}/foods/{food_id}/comments")
    public List<Comment> getUserCommentsOfFood(@PathVariable("id") String id,@PathVariable("food_id") String food_id) {
        return commentService.checkUserCommentsOfFood(Integer.parseInt(id),Integer.parseInt(food_id));
    }
    @PostMapping(value="/user",consumes = {"application/json; charset=UTF-8"})
    public User create(@RequestBody User user){
        return service.save(user);
    }
    @PutMapping(value="/users/{id}",consumes = {"application/json; charset=UTF-8"})
    public User update(@PathVariable String id,@RequestBody User user){
        return service.save(new User(Integer.parseInt(id),user.getUsername(),user.viewPassword(),user.getName(),user.getSurname()));
    }
    @DeleteMapping("users/{id}")
    public boolean delete(@PathVariable String id){
        service.delete(Integer.parseInt(id));
        return true;
    }
}
```

## 2- Food Controller

```java
package com.example.tastingworld.controllers;
import java.util.*;
import com.example.tastingworld.models.Food;
import com.example.tastingworld.services.FoodService;
import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;

@RestController
public class FoodController {

    @Autowired
    private FoodService service;
    @GetMapping("/foods")
    public List<Food> getList() {
        return service.listAll();
    }
    @GetMapping("/foods/categories")
    public List<String> getCategories() {
        return Arrays.asList("sandwich", "wrap", "burger", "pizza");
    }
    @GetMapping("/foods/category={category}")
    public List<Food> getListByCategory(@PathVariable("category") String category) {
        return service.findListByCategory(category);
    }
    @GetMapping("/foods/originCountry={originCountry}")
    public List<Food> getListByOriginCountry(@PathVariable("originCountry") String originCountry) {
        return service.findListByOriginCountry(originCountry);
    }
    @GetMapping("/foods/name={name}")
    public Food getByName(@PathVariable("name") String name) {
        return service.findByName(name);
    }
    @GetMapping("/foods/{id}")
    public Food getById(@PathVariable("id") String id) {
        return service.find(Integer.parseInt(id));
    }
    @GetMapping("/foods/{id}/rate")
    public String getRate(@PathVariable("id") String id) {
        return service.findRating(Integer.parseInt(id));
    }
    @GetMapping("/foods/{id}/ratedUserCount")
    public int ratedUserCount(@PathVariable("id") String id) {
        return service.findRateCount(Integer.parseInt(id));
    }
    @GetMapping("/foods/{id}/commentCount")
    public float findCommentCount(@PathVariable("id") String id) {
        return service.findCommentCount(Integer.parseInt(id));
    }
    @PostMapping(value="/food",consumes = {"application/json; charset=UTF-8"})
    public Food create(@RequestBody Food food){
        return service.save(food);
    }
    @PutMapping(value="/foods/{id}",consumes = {"application/json; charset=UTF-8"})
    public Food update(@PathVariable String id,@RequestBody Food food){
        return service.save(new Food(Integer.parseInt(id),food.getName(),food.getImageUrl(),food.getOriginCountry(),food.getRestaurant(),food.getDescription(),food.getCategory()));
    }
    @DeleteMapping("foods/{id}")
    public boolean delete(@PathVariable String id){
        service.delete(Integer.parseInt(id));
        return true;
    }
}
```

## 3- Comment Controller

```java
package com.example.tastingworld.controllers;
import com.example.tastingworld.models.Comment;
import com.example.tastingworld.services.CommentService;
import com.example.tastingworld.services.FoodService;
import com.example.tastingworld.services.UserService;
import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class CommentController {

    @Autowired
    private CommentService service;
    @Autowired
    private FoodService foodService;
    @Autowired
    private UserService userService;

    @GetMapping("/comments")
    public List<Comment> getList() {
        return service.listAll();
    }
    @GetMapping("/comments/{id}")
    public Comment getById(@PathVariable("id") String id) {
        return service.find(Integer.parseInt(id));
    }
    @PostMapping(value="/users/{userId}/foods/{foodId}/comment",consumes = {"application/json; charset=UTF-8"})
    public Comment create(@PathVariable("userId") String userId,@PathVariable("foodId") String foodId,@RequestBody Comment comment){
        comment.setFood(foodService.find(Integer.parseInt(foodId)));
        comment.setUser(userService.find(Integer.parseInt(userId)));
        return service.save(comment);
    }
    @PutMapping(value="/comments/{id}",consumes = {"application/json; charset=UTF-8"})
    public Comment update(@PathVariable String id,@RequestBody Comment requestedComment){
        Comment comment=service.find(Integer.parseInt(id));
        comment.setComment(requestedComment.getComment());
        return service.save(comment);
    }
    @DeleteMapping("comments/{id}")
    public boolean delete(@PathVariable String id){
        service.delete(Integer.parseInt(id));
        return true;
    }

}
```

## 4- Rate Controller

```java
package com.example.tastingworld.controllers;

import com.example.tastingworld.models.Rate;
import com.example.tastingworld.services.FoodService;
import com.example.tastingworld.services.RateService;
import com.example.tastingworld.services.UserService;
import org.springframework.beans.factory.annotation.*;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class RateController {

    @Autowired
    private RateService service;
    @Autowired
    private FoodService foodService;
    @Autowired
    private UserService userService;

    @GetMapping("/rates")
    public List<Rate> getList() {
        return service.listAll();
    }
    @GetMapping("/rates/{id}")
    public Rate getById(@PathVariable("id") String id) {
        return service.find(Integer.parseInt(id));
    }
    @PostMapping(value="/users/{userId}/foods/{foodId}/rate",consumes = {"application/json; charset=UTF-8"})
    public Rate create(@PathVariable("userId") String userId,@PathVariable("foodId") String foodId,@RequestBody Rate rate){
        rate.setFood(foodService.find(Integer.parseInt(foodId)));
        rate.setUser(userService.find(Integer.parseInt(userId)));
        return service.save(rate);
    }
    @PutMapping(value="/rates/{id}",consumes = {"application/json; charset=UTF-8"})
    public Rate update(@PathVariable String id,@RequestBody Rate requestedRate){
        Rate rate=service.find(Integer.parseInt(id));
        rate.setRate(requestedRate.getRate());
        return service.save(rate);
    }
    @DeleteMapping("rates/{id}")
    public boolean delete(@PathVariable String id){
        service.delete(Integer.parseInt(id));
        return true;
    }

}
```

# Running the Application and Testing the APIs via a Postman
You can run the application by typing the following command in the terminal

```
mvn spring-boot:run
Let’s now test the APIs via Postman.
```

