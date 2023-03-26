package com.example.tastingworld.models;
import com.example.tastingworld.services.FoodService;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

@Entity
@Table(name = "user")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String surname;

    //@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @OneToMany(mappedBy = "user")
    //@LazyCollection(LazyCollectionOption.FALSE)
    private Set<Comment> comments;
    @OneToMany(mappedBy = "user")
    //@LazyCollection(LazyCollectionOption.FALSE)
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
    //@JsonManagedReference

    public void setComments(Set<Comment>comments){
        this.comments=comments;
    }
    public void setRates(Set<Rate> rates){
        this.rates=rates;
    }
}