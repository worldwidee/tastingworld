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