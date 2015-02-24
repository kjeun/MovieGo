package com.mvg.service;

import java.util.HashMap;
import java.util.List;

import com.mvg.entity.Movie;
import com.mvg.entity.Recommend;
import com.mvg.entity.User;

public interface RecommendService {

	
	List<Recommend> countGenreService(User user);
	
	int countMovieEvalService(User user);
	
	List<Movie> rmdMovieBasedGenreService(HashMap<String, Object> hashmap);
}
