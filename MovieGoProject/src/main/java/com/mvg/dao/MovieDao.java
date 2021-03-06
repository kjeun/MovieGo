package com.mvg.dao;

import java.util.List;

import com.mvg.entity.Movie;

public interface MovieDao {
	// 총 영화의 개수
	Integer getAllMovieCount();

	// 모든 영화 얻어오기
	List<Movie> getAllMovies();
	
	// 모든 영화 얻어오기 (랜덤)
	List<Movie> randomGetAllMovies(int page);
	
	// 영화 포스터 url 불러오기
	String getMovieThumbnail(String movieCode);

	// 영화 하나 불러오기
	Movie getMovieByMovieCode(String movieCode);

	// 새 영화 추가
	int insertMovie(Movie movie);

	// 기존 영화 수정
	int updateMovie(Movie movie);

	// 영화 삭제
	int deleteMovie(String movieCode);

}
