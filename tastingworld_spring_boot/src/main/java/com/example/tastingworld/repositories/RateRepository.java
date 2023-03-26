package com.example.tastingworld.repositories;
import com.example.tastingworld.models.Rate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface RateRepository extends JpaRepository<Rate, Integer> {
    @Query(value = "SELECT * FROM rate WHERE food_id=?",nativeQuery = true)
    public List<Rate> findByFoodId(Integer food_id);
    @Query(value = "SELECT * FROM rate WHERE user_id=?",nativeQuery = true)
    public List<Rate> findByUserId(Integer user_id);
    @Query(value = "SELECT EXISTS(SELECT * FROM rate WHERE user_id=? AND food_id=?)",nativeQuery = true)
    public int checkIfFoodRatedByUser(Integer user_id,Integer food_id);
    @Query(value = "SELECT * FROM rate WHERE user_id=? AND food_id=?",nativeQuery = true)
    public Rate checkWhatUserRated(Integer user_id,Integer food_id);
}