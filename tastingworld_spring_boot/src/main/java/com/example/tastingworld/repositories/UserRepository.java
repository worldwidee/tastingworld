package com.example.tastingworld.repositories;
import com.example.tastingworld.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Integer> {
    @Query(value = "SELECT * FROM user WHERE name=? LIMIT 1",nativeQuery = true)
    public User findByName(String name);
}