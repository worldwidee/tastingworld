package com.example.tastingworld.services;
import java.util.List;
import com.example.tastingworld.models.Rate;
import com.example.tastingworld.repositories.RateRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class RateService {

    @Autowired
    private RateRepository repo;

    public List<Rate> listAll() {
        return repo.findAll();
    }

    public Rate save(Rate rate) {
        return repo.save(rate);
    }

    public Rate find(Integer id) {
        return repo.findById(id).get();
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }

    public List<Rate> findRateListByUser(Integer user_id){
        return repo.findByUserId(user_id);
    }

    public boolean checkIfFoodRatedByUser(Integer user_id,Integer food_id){
        return repo.checkIfFoodRatedByUser(user_id, food_id) == 1;
    }
    public Rate checkWhatUserRated(Integer user_id,Integer food_id){

        return repo.checkWhatUserRated(user_id, food_id);
    }
}