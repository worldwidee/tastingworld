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