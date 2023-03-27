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