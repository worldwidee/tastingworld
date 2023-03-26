package com.example.tastingworld.models;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

import java.io.Serializable;

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
