package com.example.tastingworld.services;
import java.util.List;
import com.example.tastingworld.models.User;
import com.example.tastingworld.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserRepository repo;

    public List<User> listAll() {
        return repo.findAll();
    }

    public User findByName(String name){
        return repo.findByName(name);
    }
    public User save(User user) {
        return repo.save(user);
    }

    public User find(Integer id) {
        return repo.findById(id).get();
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }
}