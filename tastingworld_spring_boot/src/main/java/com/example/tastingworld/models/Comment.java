package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "comment")
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Comment implements Serializable{

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
