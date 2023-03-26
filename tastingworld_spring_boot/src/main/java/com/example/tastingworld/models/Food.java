package com.example.tastingworld.models;
import com.example.tastingworld.services.FoodService;
import com.example.tastingworld.services.UserService;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.beans.factory.annotation.Autowired;

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
    //@LazyCollection(LazyCollectionOption.FALSE)
    private Set<Comment> comments;
    @OneToMany(mappedBy = "food")
    //@LazyCollection(LazyCollectionOption.FALSE)
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

    // other getters and setters...
}