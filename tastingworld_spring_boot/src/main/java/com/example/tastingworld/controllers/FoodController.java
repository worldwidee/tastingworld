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