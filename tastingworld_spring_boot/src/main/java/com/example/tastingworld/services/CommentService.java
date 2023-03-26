package com.example.tastingworld.services;
import java.util.List;
import com.example.tastingworld.models.Comment;
import com.example.tastingworld.repositories.CommentRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class CommentService {

    @Autowired
    private CommentRepository repo;

    public List<Comment> listAll() {
        return repo.findAll();
    }

    public Comment save(Comment comment) {
        return repo.save(comment);
    }

    public Comment find(Integer id) {
        return repo.findById(id).get();
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }

    public List<Comment> findCommentListByUser(Integer user_id){
        return repo.findByUserId(user_id);
    }

    public boolean checkIfFoodHasCommentByUser(Integer user_id,Integer food_id){
        return repo.checkIfFoodHasCommentByUser(user_id, food_id) == 1;
    }
    public List<Comment> checkUserCommentsOfFood(Integer user_id,Integer food_id){

        return repo.checkUserCommentsOfFood(user_id, food_id);
    }
}