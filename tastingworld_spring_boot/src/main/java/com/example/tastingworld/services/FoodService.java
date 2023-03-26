package com.example.tastingworld.services;
import java.util.List;
import java.util.Map;

import com.example.tastingworld.models.Comment;
import com.example.tastingworld.models.Food;
import com.example.tastingworld.models.Rate;
import com.example.tastingworld.repositories.CommentRepository;
import com.example.tastingworld.repositories.FoodRepository;
import com.example.tastingworld.repositories.RateRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class FoodService {

    @Autowired
    private FoodRepository repo;
    @Autowired
    private CommentRepository commRepo;
    @Autowired
    private RateRepository rateRepo;

    public List<Food> listAll() {
        return repo.findAll();
    }

    public List<Food> findListByCategory(String category){return repo.findListByCategory(category); };
    public List<Food> findListByOriginCountry(String originCountry){return repo.findListByOriginCountry(originCountry); };

    public Food findByName(String name){
        return repo.findByName(name);
    }
    public int findCommentCount(Integer id){
        List<Comment>comments=commRepo.findByFoodId(id);
        return comments.size();
    };
    public int findRateCount(Integer id){
        List<Rate>rates=rateRepo.findByFoodId(id);
        return rates.size();
    };
    public String findRating(Integer id){
        List<Rate>rates=rateRepo.findByFoodId(id);
        float total=0;
        for(Rate rate : rates){
            total+=rate.getRate();
        }
        return rates.isEmpty()?"unknown":String.format("%.1f", total/rates.size());
    };
    public Food save(Food food) {
        return repo.save(food);
    }
    public Food saveFromMap(Map<String, String> map) {
        return repo.save(Food.fromMap(map));
    }

    public Food find(Integer id) {
        return repo.findById(id).get();
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }
}