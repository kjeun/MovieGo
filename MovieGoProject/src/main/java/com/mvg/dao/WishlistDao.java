package com.mvg.dao;

import java.util.List;

import com.mvg.entity.Wishlist;

public interface WishlistDao {
	
	//위시리스트 개수
	int getAllWishlistCount();
	
	//위시리스트 추가
	int insertWishlist(Wishlist wishlist);
	
	//위시리스트 삭제
	int deleteWishlist(int wishId);
	
	//사용자별 위시리스트
	List<Wishlist> getWishlistByUserId(String userId);
	
	//모든 위시리스트
	List<Wishlist> getAllWishlist();
	
	//사용자별 위시리스트개수
	int getWishlistCountByUserId(String userId);
	
	//영화별 위시리스트에 포함된 수
	int getWishlistCountByMovieCode(String movieCode);
	
}