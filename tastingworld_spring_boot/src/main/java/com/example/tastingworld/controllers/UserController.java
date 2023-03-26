package com.example.tastingworld.controllers;
import java.util.*;

import com.example.tastingworld.models.Comment;
import com.example.tastingworld.models.Food;
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
    @PutMapping(value="/user={id}",consumes = {"application/json; charset=UTF-8"})
    public User update(@PathVariable String id,@RequestBody User user){
        return service.save(new User(Integer.parseInt(id),user.getUsername(),user.viewPassword(),user.getName(),user.getSurname()));
    }
    @DeleteMapping("user/{id}")
    public boolean delete(@PathVariable String id){
        service.delete(Integer.parseInt(id));
        return true;
    }
}