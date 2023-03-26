package com.example.tastingworld.repositories;
import com.example.tastingworld.models.Food;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface FoodRepository extends JpaRepository<Food, Integer> {
    @Query(value = "SELECT * FROM food WHERE category=?",nativeQuery = true)
    public List<Food> findListByCategory(String category);
    @Query(value = "SELECT * FROM food WHERE originCountry=?",nativeQuery = true)
    public List<Food> findListByOriginCountry(String originCountry);

    @Query(value = "SELECT * FROM food WHERE name=? LIMIT 1",nativeQuery = true)
    public Food findByName(String name);
}