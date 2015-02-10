package com.mvg.dao;

import java.util.List;

import com.mvg.entity.Movie;

public interface MovieDao {
	//총 영화의 개수
	Integer getMovieCount();
	
	//모든 영화 얻어오기
	List<Movie> getAllMovies();
	
	//새 영화 추가
	int insertMovie(Movie movie);
	
	//기존 영화 수정
	int updateMovie(Movie movie);
	
	//영화 삭제
	int deleteMovie(String movieCode);
	
	//영화 하나 불러오기
	Movie getMovieByMovieCode(String movieCode);
	
	//영화 여러개 불러오기
}
